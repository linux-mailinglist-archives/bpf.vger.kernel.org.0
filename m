Return-Path: <bpf+bounces-225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A386FBAD6
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 00:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C245E281160
	for <lists+bpf@lfdr.de>; Mon,  8 May 2023 22:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA9125CC;
	Mon,  8 May 2023 22:06:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064311187
	for <bpf@vger.kernel.org>; Mon,  8 May 2023 22:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38FAC433D2;
	Mon,  8 May 2023 22:06:55 +0000 (UTC)
Date: Mon, 8 May 2023 18:06:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Alcock <nick.alcock@oracle.com>
Cc: mcgrof@kernel.org, masahiroy@kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
 kris.van.hees@oracle.com, bpf@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
Message-ID: <20230508180653.4791819e@rorschach.local.home>
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This topic came up at LSFMM, presented by Jiri.

I'm Cc'ing this email to the BPF mailing list.

-- Steve


On Mon,  5 Dec 2022 16:31:44 +0000
Nick Alcock <nick.alcock@oracle.com> wrote:

> The kallmodsyms patch series was originally posted in Nov 2019, and the thread
> (https://lore.kernel.org/linux-kbuild/20191114223036.9359-1-eugene.loh@oracle.com/t/#u)
> shows review comments, questions, and feedback from interested parties.
> Most recent posting: <https://lore.kernel.org/linux-modules/20221109134132.9052-1-nick.alcock@oracle.com/T/#t>.
> 
> All review comments have been satisfied, as far as I know: in particular
> Yamada's note about translation units that are shared between built-in
> modules is satisfied with a better representation which is also much, much
> smaller, and we are no longer using modules_thick.builtin but Luis's new
> modules.builtin.objs.
> 
> A kernel tree containing this series alone:
>    https://github.com/oracle/dtrace-linux-kernel kallmodsyms/6.1-rc4-modules-next
> 
> 
> The whole point of symbols is that their names are unique: you can look up a
> symbol and get back a unique address, and vice versa.  Alas, because
> /proc/kallsyms (rightly) reports all symbols, even hidden ones, it does not
> really satisfy this requirement.  Large numbers of symbols are duplicated
> many times (just search for __list_del_entry!), and while usually these are
> just out-of-lined things defined in header files and thus all have the same
> implementation, it does make it needlessly hard to figure out which one is
> which in stack dumps, when tracing, and such things.  Some configuration
> options make things much worse: my test make allyesconfig runs introduced
> thousands of text symbols named _sub_I_65535_1, one per compiler-generated
> object file, and it was fairly easy to make them appear in ftrace output.
> 
> Right now the kernel has no way at all to tell such symbols apart, and nor
> has the user: their address differs and that's all.  Which module did they
> come from?  Which object file?  We don't know.  Figuring out which is which
> when tracing needs a combination of guesswork and luck, and if there are
> thousands of them that's not a pleasant prospect.  In discussions at LPC it
> became clear that this is not just annoying me but Steve Rostedt and others,
> so it's probably desirable to fix this.
> 
> It turns out that the linker, and the kernel build system, can be made to
> give us everything we need to resolve this once and for all.  This series
> provides a new /proc/kallmodsyms which is like /proc/kallsyms except that it
> annotates every (textual) symbol which comes from a built-in kernel module
> with the module's name, in square brackets: if a symbol is used by multiple
> modules, it gets [multiple] [names]; if a symbol is still ambiguous it gets
> a cut-down {object file name}; the combination of symbol, [module] [names]
> and {object file name} is unique (with one minor exception: the arm64 nvhe
> module is pre-linked with ld -r, causing all symbols in it to appear to come
> from the same object file: if it was reworked to use thin archives this
> problem would go away).
> 
> The object file names are cut down to save space: we store only the shortest
> suffix needed to distinguish symbols from each other.  It's fairly rare even
> to see two/level names, let alone three/level/ones.  We also save even more
> space by annotating every symbol in a given object file with the object file
> name if we annotate any of them.
> 
> We also add new fields that let you get at this new info in the kallsyms
> iterator.
> 
> In brief we do this by mapping from address ranges to object files (with
> assistance from the linker map file), then mapping from those object files
> to built-in kernel modules and object file names.  Because the number of
> object files is much smaller than the number of symbols, because we fuse
> address range and object file entries together if possible, and because we
> don't even store object file names unless we need to, this is a fairly
> efficient representation, even with a bit of extra complexity to allow
> object files to be in more than one module at once.
> 
> The size impact of all of this is minimal: in testing, vmlinux grew by 16632
> bytes, and the compressed vmlinux only grew by 12544 bytes (about .1% of a
> 10MiB kernel): though this is very configuration-dependent, it seems likely
> to scale roughly with the kernel as a whole.
> 
> This is all controlled by a new config parameter CONFIG_KALLMODSYMS, which when
> set results in output in /proc/kallmodsyms that looks like this:
> 
> ffffffff97606e50 t not_visible
> ffffffff97606e70 T perf_msr_probe
> ffffffff97606f80 t test_msr     [rapl]
> ffffffffa6007350 t rapl_pmu_event_stop  [rapl]
> ffffffffa6007440 t rapl_pmu_event_del   [rapl]
> ffffffffa6007460 t rapl_hrtimer_handle  [rapl]
> ffffffffa6007500 t rapl_pmu_event_read  [rapl]
> ffffffffa6007520 t rapl_pmu_event_init  [rapl]
> ffffffffa6007630 t rapl_cpu_offline     [rapl]
> ffffffffa6007710 t amd_pmu_event_map    {core.o}
> ffffffffa6007750 t amd_pmu_add_event    {core.o}
> ffffffffa6007760 t amd_put_event_constraints_f17h       {core.o}
> 
> The modular symbols are notated as [rapl] even if rapl is built into the
> kernel.  Further, at least one symbol nottated as {core.o} would have been
> ambiguous without that notation.  If we look a little further down, we see:
> 
> ffffffff97607a70 t cmask_show   {core.o}
> ffffffff97607ab0 t inv_show     {core.o}
> ffffffff97607ae0 t edge_show    {core.o}
> ffffffff97607b10 t umask_show   {core.o}
> ffffffff97607b40 t event_show   {core.o}
> 
> where event_show in particular is highly ambiguous and appears in many
> object files, all of which are now notated with different {object file
> names}.
> 
> Further down, we see what happens when object files are reused by multiple
> modules, all of which are built in to the kernel, and some of which contain
> symbols that are ambiguously-named even within that set of modules:
> 
> ffffffff97d7aed0 t liquidio_pcie_mmio_enabled   [liquidio]
> ffffffff97d7aef0 t liquidio_pcie_resume [liquidio]
> ffffffff97d7af00 t liquidio_ptp_adjtime [liquidio]
> ffffffff97d7af50 t liquidio_ptp_enable  [liquidio]
> ffffffff97d7af70 t liquidio_get_stats64 [liquidio]
> ffffffff97d7b0f0 t liquidio_fix_features        [liquidio]
> ffffffff97d7b1c0 t liquidio_get_port_parent_id  [liquidio]
> [...]
> ffffffff97d824c0 t lio_vf_rep_modinit   [liquidio]
> ffffffff97d824f0 t lio_vf_rep_modexit   [liquidio]
> ffffffff97d82520 t lio_ethtool_get_channels     [liquidio] [liquidio_vf]
> ffffffff97d82600 t lio_ethtool_get_ringparam    [liquidio] [liquidio_vf]
> ffffffff97d826a0 t lio_get_msglevel     [liquidio] [liquidio_vf]
> ffffffff97d826c0 t lio_vf_set_msglevel  [liquidio] [liquidio_vf]
> ffffffff97d826e0 t lio_get_pauseparam   [liquidio] [liquidio_vf]
> ffffffff97d82710 t lio_get_ethtool_stats        [liquidio] [liquidio_vf]
> ffffffff97d82e70 t lio_vf_get_ethtool_stats     [liquidio] [liquidio_vf]
> [...]
> ffffffff97d91a80 t cn23xx_vf_mbox_thread        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
> ffffffff97d91aa0 t cpumask_weight.constprop.0   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
> ffffffff97d91ac0 t cn23xx_vf_msix_interrupt_handler     [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
> ffffffff97d91bd0 t cn23xx_vf_get_oq_ticks       [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
> ffffffff97d91c00 t cn23xx_vf_ask_pf_to_do_flr   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
> ffffffff97d91c70 t cn23xx_octeon_pfvf_handshake [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
> ffffffff97d91e20 t cn23xx_setup_octeon_vf_device        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
> ffffffff97d92060 t octeon_mbox_read     [liquidio] [liquidio_vf]
> ffffffff97d92230 t octeon_mbox_write    [liquidio] [liquidio_vf]
> [...]
> ffffffff97d946b0 t octeon_alloc_soft_command_resp       [liquidio] [liquidio_vf]
> ffffffff97d947e0 t octnet_send_nic_data_pkt     [liquidio] [liquidio_vf]
> ffffffff97d94820 t octnet_send_nic_ctrl_pkt     [liquidio] [liquidio_vf]
> ffffffff97d94ab0 t liquidio_get_stats64 [liquidio_vf]
> ffffffff97d94c10 t liquidio_fix_features        [liquidio_vf]
> ffffffff97d94cd0 t wait_for_pending_requests    [liquidio_vf]
> 
> Like /proc/kallsyms, the output is sorted by address, so keeps the curious
> property of /proc/kallsyms that symbols may appear repeatedly with different
> addresses: but now, unlike in /proc/kallsyms, we can see that those symbols
> appear repeatedly because they are *different symbols* that ultimately
> belong to different modules or different object files, all of which are
> built in to the kernel.
> 
> Note that kernel symbols for built-in modules will probably appear
> interspersed with other symbols that are part of different modules and
> non-modular always-built-in symbols, which, as usual, have no
> square-bracketed module denotation (though they might have an {object file
> name}.
> 
> As with /proc/kallsyms, non-root usage produces addresses that are all zero.
> 
> Tested with a make allyesconfig and allmodconfig, and with and without
> CONFIG_X86_KERNEL_IBT.
> 
> Limitations:
> 
>  - this approach only works for textual symbols (and weak ones).  I don't
>    see any way to make it work for data symbols etc: except for initialized
>    data they don't really have corresponding object files at all and they
>    tend to get merged together anyway.
> 
>  - Compiling with clang LTO is untested.  Compiling with X86 IBT now works,
>    but .cold-partitioned symbols are not attributed to any objfiles right
>    now (currently, this results in no conflicts on a make allyesconfig
>    build, so it's harmless).
> 
>  - Non-built-in modules can also have ambiguous symbols in them in different
>    input object files: they aren't handled yet because kallsyms never runs
>    over modules to create the necessary sections.  This is fixable, but it's
>    probably best handled in another patch series.  (kallsyms would need to
>    do much less work for modules: only the sections introduced by this patch
>    series would need emission at all, and no [module] notations would be
>    needed, only {objfile}.)
> 
>  - Section start/end symbols necessarily lie on the boundary between object
>    files, so are sometimes misreported as being in the wrong object file or
>    module.  This is unlikely to be too troublesome for these symbols in
>    particular, but if anyone can figure out a way to fix this I'd be happy
>    to do it.
> 
>  - There is no BPF iterator support yet (it's just a matter of adding it
>    if needed).
> 
> The commits in this series all have reviewed-by tags: they're all from
> internal reviews, so please ignore them.
> 
> Differences from v9, early November 2022:
> 
>  - Rework to use Luis Chamberlain's modules.builtin.objs rather than a
>    tristate-generated "modules_thick.builtin".  Keep the iterator over
>    modules_thick.builtin, but rename it to scripts/modules_builtin.c and
>    make it more robust against strange lines in modules.builtin.objs,
>    such as lines with no colon in.
>  - Rework the old modules_thick.builtin stuff into a "tristate checker"
>    which warns about source files that contain MODULE_LICENSE for which
>    the corresponding Kconfig symbol is of type 'bool' rather than
>    'tristate'.  It no longer runs unless requested, so doesn't slow
>    the build down with a big recursion across the whole source tree.
>  - Fix up a bunch of places where the tristate checker (and the old
>    modules_thick.builtin and modules.builtin generators) gave the wrong
>    answers, usually considering things to be modules that actually
>    unconditionally built in.  (16 makefiles touched.)
>  - Eliminate MODULE_LICENSE/AUTHOR/DESCRIPTION from a bunch of things
>    that cannot actually be modules: aarch64 and x86_64 are now clean,
>    other arches not checked. Verified with make allmodconfig on both
>    arches. (189 not-actually-modules touched.)
>  - Use the CONFIG_VMLINUX_MAP machinery rather than generating a whole
>    second linker mapfile.
>  - Add (in a separate commit since it is largely conceptually separate)
>    support for the ld -r linking used by CONFIG_X86_KERNEL_IBT.
>  - Add a special kallsyms build-time warning for ambiguous symbols that
>    came from the same object file: note that they are probably the
>    result of ld -r.
>  - When lengthening shortened objfile names to resolve an ambiguity,
>    always lengthen the name of the objfile with the longer (unshortened)
>    length, fixing ambiguous objfiles with names which are substrings of
>    other objfiles' names.
>  - Fix a bug which could cause inflooping when outputting the
>    .kallsyms_mod_objnames section.
>  - Rebase atop modules-next.
> 
> Differences from v8, February 2022:
> 
>  - Add object file name handling, emitting only those object names needed to
>    disambiguate symbols, shortening them as much as possible compatible with
>    that.
>  - Rename .kallsyms_module_names to .kallsyms_mod_objnames now that it
>    contains object file names too.
>  - Fix a bug in optimize_obj2mod that prevented proper reuse of module names
>    for object files appearing in both multimodule modules and single-module
>    modules: saves a few KiB more, often more than the space increase due to
>    object file name handling.
>  - Rebased atop v6.1-rc2: move modules_thick.builtin generation into
>    the top-level Kbuild accordingly, and adjust to getopt_long use in
>    scripts/kallsyms.
>  - Significant revisions to the cover letter.
>  - Add proof-of-concept kallmodsyms module support to perf.
>  - (This ping) confirmed that series applies atop v6.1-rc4 without
>    further changes.
> 
> Differences from v7, December 2021:
> 
>  - Adjust for changes in the v5.17 merge window.  Adjust a few commit
>    messages and shrink the cover letter.
>  - Drop the symbol-size patch, probably better done from userspace.
> 
> Differences from v6, November 2021:
> 
>  - Adjust for rewrite of confdata machinery in v5.16 (tristate.conf
>    handling is now more of a rewrite than a reversion)
> 
> Differences from v5, October 2021:
> 
>  - Fix generation of mapfiles under UML
> 
> Differences from v4, September 2021:
> 
>  - Fix building of tristate.conf if missing (usually concealed by the
>    syncconfig being run for other reasons, but not always: the kernel
>    test robot spotted it).
>  - Forward-port atop v5.15-rc3.
> 
> Differences from v3, August 2021:
> 
>  - Fix a kernel test robot warning in get_ksymbol_core (possible
>    use of uninitialized variable if kallmodsyms was wanted but
>    kallsyms_module_offsets was not present, which is most unlikely).
> 
> Differences from v2, June 2021:
> 
>  - Split the series up.  In particular, the size impact of the table
>    optimizer is now quantified, and the symbol-size patch is split out and
>    turned into an RFC patch, with the /proc/kallmodsyms format before that
>    patch lacking a size column.  Some speculation on how to make the symbol
>    sizes less space-wasteful is added (but not yet implemented).
> 
>  - Drop a couple of unnecessary #includes, one unnecessarily exported
>    symbol, and a needless de-staticing.
> 
> Differences from v1, in 2019:
> 
>  - Move from a straight symbol->module name mapping to a mapping from
>    address-range to TU to module name list, bringing major space savings
>    over the previous approach and support for object files used by many
>    built-in modules at the same time, at the cost of a slightly more complex
>    approach (unavoidably so, I think, given that we have to merge three data
>    sources together: the link map in .tmp_vmlinux.ranges, the nm output on
>    stdin, and the mapping from TU name to module names in
>    modules_thick.builtin).
> 
>    We do opportunistic merging of TUs if they cite the same modules and
>    reuse module names where doing so is simple: see optimize_obj2mod below.
>    I considered more extensive searches for mergeable entries and more
>    intricate encodings of the module name list allowing TUs that are used by
>    overlapping sets of modules to share their names, but such modules are
>    rare enough (and such overlapping sharings are vanishingly rare) that it
>    seemed likely to save only a few bytes at the cost of much more
>    hard-to-test code.  This is doubly true now that the tables needed are
>    only a few kilobytes in length.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
> Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
> 
> Luis Chamberlain (1):
>   kbuild: add modules.builtin.objs
> 
> Nick Alcock (12):
>   kbuild: bring back tristate.conf
>   kbuild: add tristate checker
>   kbuild: fix up substitutions in makefiles to allow for tristate
>     checker
>   kbuild: remove MODULE_LICENSE/AUTHOR/DESCRIPTION in non-modules
>   build: add a simple iterator over modules.builtin.objs
>   kbuild: generate an address ranges map at vmlinux link time
>   kbuild: make address ranges map work with IBT
>   kallsyms: introduce sections needed to map symbols to built-in modules
>   kallsyms: optimize .kallsyms_modules*
>   kallsyms: distinguish text symbols fully using object file names
>   kallsyms: add /proc/kallmodsyms for text symbol disambiguation
>   perf: proof-of-concept kallmodsyms support
> 
>  .gitignore                                    |    3 +-
>  Documentation/dontdiff                        |    4 +-
>  Documentation/kbuild/kbuild.rst               |    5 +
>  Documentation/kbuild/kconfig.rst              |    5 +
>  Makefile                                      |   35 +-
>  arch/x86/crypto/blake2s-glue.c                |    1 -
>  arch/x86/mm/debug_pagetables.c                |    3 -
>  crypto/asymmetric_keys/asymmetric_type.c      |    1 -
>  drivers/Makefile                              |    2 +-
>  .../accessibility/braille/braille_console.c   |    4 -
>  drivers/amba/tegra-ahb.c                      |    3 -
>  drivers/android/binder.c                      |    1 -
>  drivers/bus/arm-cci.c                         |    2 -
>  drivers/bus/arm-integrator-lm.c               |    3 -
>  drivers/bus/bt1-apb.c                         |    3 -
>  drivers/bus/bt1-axi.c                         |    3 -
>  drivers/bus/imx-weim.c                        |    3 -
>  drivers/bus/intel-ixp4xx-eb.c                 |    3 -
>  drivers/bus/qcom-ebi2.c                       |    3 -
>  drivers/bus/qcom-ssc-block-bus.c              |    3 -
>  drivers/bus/simple-pm-bus.c                   |    3 -
>  drivers/clk/bcm/clk-bcm2835-aux.c             |    3 -
>  drivers/clk/bcm/clk-bcm2835.c                 |    3 -
>  drivers/clk/clk-bm1880.c                      |    3 -
>  drivers/clk/clk-fixed-mmio.c                  |    3 -
>  drivers/clk/clk-fsl-sai.c                     |    3 -
>  drivers/clk/hisilicon/clk-hi3559a.c           |    2 -
>  drivers/clk/microchip/clk-mpfs-ccc.c          |    3 -
>  drivers/clk/microchip/clk-mpfs.c              |    5 -
>  drivers/clk/renesas/rcar-usb2-clock-sel.c     |    2 -
>  drivers/clk/renesas/renesas-cpg-mssr.c        |    2 -
>  drivers/clk/renesas/rzg2l-cpg.c               |    2 -
>  drivers/clocksource/em_sti.c                  |    3 -
>  drivers/clocksource/sh_cmt.c                  |    3 -
>  drivers/clocksource/sh_mtu2.c                 |    3 -
>  drivers/clocksource/sh_tmu.c                  |    3 -
>  drivers/clocksource/timer-stm32-lp.c          |    2 -
>  drivers/clocksource/timer-tegra186.c          |    3 -
>  drivers/clocksource/timer-ti-dm.c             |    3 -
>  drivers/cpufreq/freq_table.c                  |    3 -
>  drivers/cpufreq/intel_pstate.c                |    3 -
>  drivers/cpufreq/tegra124-cpufreq.c            |    3 -
>  drivers/dma-buf/heaps/cma_heap.c              |    2 -
>  drivers/dma-buf/heaps/system_heap.c           |    1 -
>  drivers/dma-buf/udmabuf.c                     |    2 -
>  drivers/dma/ep93xx_dma.c                      |    3 -
>  drivers/dma/ipu/ipu_idmac.c                   |    3 -
>  drivers/dma/mv_xor_v2.c                       |    2 -
>  drivers/dma/s3c24xx-dma.c                     |    3 -
>  drivers/dma/sh/shdma-base.c                   |    3 -
>  drivers/dma/stm32-dmamux.c                    |    4 -
>  drivers/dma/stm32-mdma.c                      |    4 -
>  drivers/edac/altera_edac.c                    |    3 -
>  drivers/firmware/broadcom/bcm47xx_nvram.c     |    1 -
>  drivers/firmware/imx/imx-scu.c                |    3 -
>  drivers/firmware/imx/scu-pd.c                 |    3 -
>  drivers/gpio/gpio-aspeed-sgpio.c              |    2 -
>  drivers/gpio/gpio-imx-scu.c                   |    3 -
>  drivers/gpio/gpio-mxs.c                       |    6 -
>  drivers/gpio/gpio-rda.c                       |    3 -
>  drivers/gpu/drm/drm_mipi_dsi.c                |    3 -
>  drivers/hv/Makefile                           |    2 +-
>  drivers/hwspinlock/hwspinlock_core.c          |    3 -
>  drivers/interconnect/core.c                   |    3 -
>  drivers/iommu/sun50i-iommu.c                  |    4 -
>  drivers/irqchip/irq-al-fic.c                  |    3 -
>  drivers/irqchip/irq-ls-scfg-msi.c             |    3 -
>  drivers/irqchip/irq-mbigen.c                  |    4 -
>  drivers/irqchip/irq-mchp-eic.c                |    3 -
>  drivers/irqchip/irq-mvebu-pic.c               |    3 -
>  drivers/irqchip/irq-renesas-intc-irqpin.c     |    3 -
>  drivers/irqchip/irq-renesas-irqc.c            |    3 -
>  drivers/irqchip/irq-renesas-rza1.c            |    3 -
>  drivers/irqchip/irq-renesas-rzg2l.c           |    3 -
>  drivers/irqchip/irq-sl28cpld.c                |    3 -
>  drivers/irqchip/irq-ti-sci-inta.c             |    3 -
>  drivers/irqchip/irq-ti-sci-intr.c             |    3 -
>  drivers/leds/leds-asic3.c                     |    3 -
>  drivers/mailbox/rockchip-mailbox.c            |    4 -
>  drivers/mailbox/zynqmp-ipi-mailbox.c          |    3 -
>  drivers/memory/bt1-l2-ctl.c                   |    3 -
>  drivers/memory/da8xx-ddrctl.c                 |    3 -
>  drivers/memory/fsl_ifc.c                      |    3 -
>  drivers/memory/mvebu-devbus.c                 |    3 -
>  drivers/memory/tegra/mc.c                     |    3 -
>  drivers/memory/tegra/tegra186-emc.c           |    3 -
>  drivers/mfd/88pm860x-core.c                   |    3 -
>  drivers/mfd/altera-sysmgr.c                   |    3 -
>  drivers/mfd/bcm2835-pm.c                      |    3 -
>  drivers/mfd/da903x.c                          |    4 -
>  drivers/mfd/da9052-core.c                     |    3 -
>  drivers/mfd/da9052-i2c.c                      |    3 -
>  drivers/mfd/da9052-spi.c                      |    3 -
>  drivers/mfd/da9055-core.c                     |    3 -
>  drivers/mfd/da9055-i2c.c                      |    3 -
>  drivers/mfd/ezx-pcap.c                        |    3 -
>  drivers/mfd/intel_soc_pmic_crc.c              |    4 -
>  drivers/mfd/lp8788.c                          |    3 -
>  drivers/mfd/omap-usb-host.c                   |    4 -
>  drivers/mfd/omap-usb-tll.c                    |    4 -
>  drivers/mfd/palmas.c                          |    3 -
>  drivers/mfd/stmpe-i2c.c                       |    3 -
>  drivers/mfd/stmpe-spi.c                       |    3 -
>  drivers/mfd/tc3589x.c                         |    3 -
>  drivers/mfd/tps6586x.c                        |    3 -
>  drivers/mfd/twl4030-audio.c                   |    3 -
>  drivers/mfd/twl6040.c                         |    4 -
>  drivers/mmc/Makefile                          |    2 +-
>  drivers/mtd/parsers/bcm63xxpart.c             |    6 -
>  drivers/net/wireless/silabs/wfx/Makefile      |    2 +-
>  drivers/nvmem/core.c                          |    4 -
>  drivers/nvmem/zynqmp_nvmem.c                  |    3 -
>  drivers/pci/controller/dwc/pcie-histb.c       |    2 -
>  .../controller/mobiveil/pcie-mobiveil-plat.c  |    3 -
>  drivers/pci/controller/pci-tegra.c            |    1 -
>  drivers/pci/controller/pci-versatile.c        |    2 -
>  drivers/pci/controller/pcie-hisi-error.c      |    2 -
>  drivers/pci/controller/pcie-microchip-host.c  |    3 -
>  drivers/pci/endpoint/pci-ep-cfs.c             |    3 -
>  drivers/pci/endpoint/pci-epc-core.c           |    3 -
>  drivers/pci/endpoint/pci-epc-mem.c            |    3 -
>  drivers/pci/endpoint/pci-epf-core.c           |    3 -
>  drivers/pci/hotplug/acpiphp_core.c            |    3 -
>  drivers/pci/hotplug/shpchp_core.c             |    3 -
>  drivers/perf/apple_m1_cpu_pmu.c               |    1 -
>  drivers/phy/intel/phy-intel-lgm-combo.c       |    2 -
>  drivers/pinctrl/actions/pinctrl-s500.c        |    4 -
>  drivers/pinctrl/actions/pinctrl-s700.c        |    3 -
>  drivers/pinctrl/actions/pinctrl-s900.c        |    4 -
>  drivers/pinctrl/bcm/pinctrl-ns.c              |    2 -
>  drivers/pinctrl/mediatek/pinctrl-mt8188.c     |    2 -
>  drivers/pinctrl/mediatek/pinctrl-mt8192.c     |    2 -
>  drivers/pinctrl/mediatek/pinctrl-mt8365.c     |    3 -
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     |    4 -
>  drivers/pinctrl/pinctrl-amd.c                 |    3 -
>  drivers/pinctrl/renesas/pinctrl-rza1.c        |    3 -
>  drivers/pinctrl/renesas/pinctrl-rza2.c        |    3 -
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c       |    3 -
>  drivers/pinctrl/renesas/pinctrl-rzn1.c        |    3 -
>  drivers/pinctrl/renesas/pinctrl-rzv2m.c       |    3 -
>  drivers/power/reset/as3722-poweroff.c         |    3 -
>  drivers/power/reset/gpio-poweroff.c           |    3 -
>  drivers/power/reset/gpio-restart.c            |    3 -
>  drivers/power/reset/keystone-reset.c          |    3 -
>  drivers/power/reset/ltc2952-poweroff.c        |    3 -
>  drivers/power/reset/mt6323-poweroff.c         |    3 -
>  drivers/power/reset/regulator-poweroff.c      |    3 -
>  drivers/power/reset/restart-poweroff.c        |    3 -
>  drivers/power/reset/tps65086-restart.c        |    3 -
>  drivers/power/supply/power_supply_core.c      |    6 -
>  drivers/power/supply/wm97xx_battery.c         |    3 -
>  drivers/powercap/powercap_sys.c               |    3 -
>  drivers/regulator/stm32-pwr.c                 |    3 -
>  drivers/remoteproc/remoteproc_core.c          |    2 -
>  drivers/reset/reset-axs10x.c                  |    3 -
>  drivers/reset/reset-hsdk.c                    |    3 -
>  drivers/reset/reset-lantiq.c                  |    3 -
>  drivers/reset/reset-microchip-sparx5.c        |    3 -
>  drivers/reset/reset-mpfs.c                    |    3 -
>  drivers/s390/char/Makefile                    |    2 +-
>  drivers/s390/crypto/Makefile                  |    2 +-
>  drivers/soc/apple/apple-pmgr-pwrstate.c       |    3 -
>  drivers/soc/bcm/bcm2835-power.c               |    3 -
>  drivers/soc/bcm/raspberrypi-power.c           |    4 -
>  drivers/soc/fujitsu/a64fx-diag.c              |    3 -
>  drivers/soc/sunxi/sunxi_sram.c                |    3 -
>  drivers/soc/tegra/cbb/tegra194-cbb.c          |    3 -
>  drivers/soc/tegra/cbb/tegra234-cbb.c          |    2 -
>  drivers/tty/n_null.c                          |    3 -
>  drivers/tty/serial/imx_earlycon.c             |    3 -
>  drivers/tty/serial/rda-uart.c                 |    3 -
>  drivers/video/console/vgacon.c                |    1 -
>  drivers/video/fbdev/asiliantfb.c              |    1 -
>  drivers/video/fbdev/gbefb.c                   |    1 -
>  drivers/video/fbdev/imsttfb.c                 |    1 -
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.c         |    3 -
>  .../video/fbdev/mmp/panel/tpo_tj032md01bw.c   |    3 -
>  drivers/video/fbdev/vesafb.c                  |    1 -
>  drivers/video/fbdev/wm8505fb.c                |    3 -
>  drivers/video/fbdev/wmt_ge_rops.c             |    4 -
>  drivers/xen/grant-dma-ops.c                   |    3 -
>  drivers/xen/xenbus/xenbus_probe.c             |    1 -
>  fs/binfmt_elf.c                               |    1 -
>  fs/nfs_common/nfs_ssc.c                       |    1 -
>  fs/unicode/utf8-core.c                        |    1 -
>  include/linux/module.h                        |    4 +-
>  init/Kconfig                                  |   10 +
>  kernel/dma/map_benchmark.c                    |    3 -
>  kernel/events/hw_breakpoint_test.c            |    2 -
>  kernel/kallsyms.c                             |  277 +++-
>  kernel/kallsyms_internal.h                    |   14 +
>  kernel/trace/rv/reactor_panic.c               |    3 -
>  kernel/trace/rv/reactor_printk.c              |    3 -
>  kernel/watch_queue.c                          |    3 -
>  lib/btree.c                                   |    3 -
>  lib/crypto/blake2s-generic.c                  |    3 -
>  lib/crypto/blake2s.c                          |    3 -
>  lib/glob.c                                    |    2 -
>  lib/packing.c                                 |    2 -
>  lib/pldmfw/pldmfw.c                           |    3 -
>  lib/test_fprobe.c                             |    1 -
>  mm/zpool.c                                    |    3 -
>  mm/zswap.c                                    |    3 -
>  net/8021q/Makefile                            |    2 +-
>  net/Makefile                                  |    2 +-
>  net/bridge/Makefile                           |    4 +-
>  net/dccp/Makefile                             |    4 +-
>  net/ipv6/Makefile                             |    2 +-
>  net/l2tp/Makefile                             |   12 +-
>  net/mctp/af_mctp.c                            |    3 -
>  net/netfilter/Makefile                        |    2 +-
>  net/netlabel/Makefile                         |    2 +-
>  net/sctp/Makefile                             |    2 +-
>  scripts/.gitignore                            |    1 +
>  scripts/Kbuild.include                        |   21 +
>  scripts/Makefile                              |    7 +
>  scripts/Makefile.lib                          |   13 +-
>  scripts/Makefile.vmlinux_o                    |   21 +-
>  scripts/addaddrs.c                            |   28 +
>  scripts/check-tristates.mk                    |   56 +
>  scripts/kallsyms.c                            | 1223 ++++++++++++++++-
>  scripts/kconfig/confdata.c                    |   41 +-
>  scripts/link-vmlinux.sh                       |   38 +-
>  scripts/modules_builtin.c                     |  200 +++
>  scripts/modules_builtin.h                     |   48 +
>  tools/perf/builtin-kallsyms.c                 |   35 +-
>  tools/perf/util/event.c                       |   14 +-
>  tools/perf/util/machine.c                     |    6 +-
>  tools/perf/util/machine.h                     |    1 +
>  tools/perf/util/symbol.c                      |  207 ++-
>  tools/perf/util/symbol.h                      |   12 +-
>  231 files changed, 2241 insertions(+), 671 deletions(-)
>  create mode 100644 scripts/addaddrs.c
>  create mode 100644 scripts/check-tristates.mk
>  create mode 100644 scripts/modules_builtin.c
>  create mode 100644 scripts/modules_builtin.h
> 


