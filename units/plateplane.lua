return { plateplane = {
  name                          = [[Airplane Plate]],
  description                   = [[Parallel Unit Production]],
  activateWhenBuilt             = false,
  buildDistance                 = Shared.FACTORY_PLATE_RANGE,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 10,
  buildingGroundDecalSizeY      = 10,
  buildingGroundDecalType       = [[plateplane_aoplane.dds]],

  buildoptions                  = {
    [[planecon]],
    [[planefighter]],
    [[planeheavyfighter]],
    [[bomberstrike]],
    [[bomberprec]],
    [[bomberriot]],
    [[bomberdisarm]],
    [[bomberassault]],
    [[bomberheavy]],
    [[planescout]],
    [[planelightscout]],
  },

  buildPic                      = [[plateplane.png]],
  canMove                       = true,
  canPatrol                     = true,
  category                      = [[FLOAT UNARMED]],
  collisionVolumeOffsets        = [[0 10 -8]],
  collisionVolumeScales         = [[60 34 34]],
  collisionVolumeType           = [[box]],
  selectionVolumeOffsets        = [[0 0 16]],
  selectionVolumeScales         = [[87 41 95]],
  selectionVolumeType           = [[box]],
  corpse                        = [[DEAD]],

  customParams                  = {
    landflystate       = [[0]],
    factory_land_state = 1,
    sortName           = [[4]],
    modelradius        = [[51]], -- at 50 planefighter won't respond to Bugger Off calls
    midposoffset       = [[0 0 -16]],
    aimposoffset       = [[0 15 -20]],
    default_spacing    = 4,
    child_of_factory   = [[factoryplane]],

    outline_x = 165,
    outline_y = 165,
    outline_yoff = 27.5,
  },

  explodeAs                     = [[FAC_PLATEEX]],
  fireState                     = 0,
  footprintX                    = 6,
  footprintZ                    = 7,
  health                        = Shared.FACTORY_PLATE_HEALTH,
  iconType                      = [[padair]],
  maxSlope                      = 15,
  metalCost                     = Shared.FACTORY_PLATE_COST,
  noAutoFire                    = false,
  objectName                    = [[plate_plane.s3o]],
  script                        = [[plateplane.lua]],
  selfDestructAs                = [[FAC_PLATEEX]],
  showNanoSpray                 = false,
  sightDistance                 = 273,
  useBuildingGroundDecal        = true,
  waterline                     = 0,
  workerTime                    = Shared.FACTORY_BUILDPOWER,
  yardMap                       = [[oooooo oooooo oooooo oooooo oooooo oooooo oooooo]],

  featureDefs                   = {

    DEAD = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 6,
      footprintZ       = 7,
      object           = [[plate_plane_dead.s3o]],
    },


    HEAP = {
      blocking         = false,
      footprintX       = 6,
      footprintZ       = 7,
      object           = [[debris4x4c.s3o]],
    },

  },

} }
