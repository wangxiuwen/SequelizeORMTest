const { Sequelize, Model, DataTypes } = require('sequelize');
const sequelize = new Sequelize('nnsay', 'root', '123456', {
    host: '192.168.31.134',
    port: '3306',
    dialect: 'mysql',
    pool: {
        max: 5,
        min: 0,
        idle: 10000
    }
});

class Orgs extends Model {}
Orgs.init({
    id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true
    },
}, { 
    sequelize, 
    timestamps: false,
    modelName: 'Orgs',
    tableName: 'orgs'
});


class Subjects extends Model { }
Subjects.init({
    id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true
    },
}, { 
    sequelize, 
    timestamps: false,
    modelName: 'Subjects',
    tableName: 'subjects'
});

Orgs.hasMany(Subjects, {foreignKey: 'org_id'});
Subjects.belongsTo(Orgs, {foreignKey: 'org_id'});


class Projects extends Model {}
Projects.init({
    id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true
    },
}, { 
    sequelize, 
    timestamps: false,
    modelName: 'Projects',
    tableName: 'projects'
});

Orgs.hasMany(Projects, {foreignKey: 'org_id'});
Projects.belongsTo(Orgs, {foreignKey: 'org_id'});

class Users extends Model {}
Users.init({
    id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true
    },
}, { 
    sequelize, 
    timestamps: false,
    modelName: 'Users',
    tableName: 'users'
});

Orgs.hasMany(Users, {foreignKey: 'org_id'});
Users.belongsTo(Orgs, {foreignKey: 'org_id'});

/*
SELECT
    *
FROM `orgs`
    LEFT JOIN `subjects` ON `orgs`.`id` = `subjects`.`org_id` # 1512
    LEFT JOIN `projects` ON `orgs`.`id` = `projects`.`org_id` # 635
    LEFT JOIN `users` ON `orgs`.`id` = `users`.`org_id` # 14
WHERE
    `orgs`.`id` = 1;
*/
(async () => {

    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
        
        let orgId = 1;
        const results = await Orgs.findByPk(orgId, {
            include: [Subjects, Projects, Users],
        });

        console.log(results)

    } catch (error) {
        console.error('Unable to connect to the database:', error);
    } finally {
        sequelize.close()
    }


})();


