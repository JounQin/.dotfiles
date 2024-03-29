module.exports = {
  name: 'plugin-prepare-lifecycle',
  factory: e => ({
    hooks: {
      afterAllInstalled(r) {
        if (!r.topLevelWorkspace.manifest.scripts.get('prepare')) return
        e('@yarnpkg/shell').execute('yarn prepare')
      },
    },
  }),
}
