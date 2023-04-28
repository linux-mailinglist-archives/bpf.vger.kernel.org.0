Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9336F1483
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjD1Jvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjD1Jvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 05:51:48 -0400
Received: from out0-214.mail.aliyun.com (out0-214.mail.aliyun.com [140.205.0.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713132701;
        Fri, 28 Apr 2023 02:51:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.STCEPEV_1682675495;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEPEV_1682675495)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:51:36 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, <bpf@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: [PATCH RFC 00/43] x86/pie: Make kernel image's virtual address flexible
Date:   Fri, 28 Apr 2023 17:50:40 +0800
Message-Id: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Purpose:

These patches make the changes necessary to build the kernel as Position
Independent Executable (PIE) on x86_64. A PIE kernel can be relocated
below the top 2G of the virtual address space. And this patchset
provides an example to allow kernel image to be relocated in top 512G of
the address space.

The ultimate purpose for PIE kernel is to increase the security of the
the kernel and also the fleixbility of the kernel image's virtual
address, which can be even in the low half of the address space. More
locations the kernel can fit in, this means an attacker could guess
harder.

The patchset is based on Thomas Garnier's X86 PIE patchset v6[1] and
v11[2]. However, some design changes are made and some bugs are fixed by
testing with different configurations and compilers.

  Important changes:
  - For fixmap area, move vsyscall page out of fixmap area and unify
    __FIXADDR_TOP for x86. Then fixmap area could be relocated together
    with kernel image.

  - For compile-time base address of kernel image, keep it in top 2G of
    address space. Introduce a new variable to store the run-time base
    address and adapt for VA/PA transition during runtime.

  - For percpu section, keep it as zero mapping for SMP. Because
    compile-time base address of kernel image still resides in top 2G of
    address space, then RIP-relative reference can still be used when
    percpu section is zero mapping. However, when do relocation for
    percpu variable references, percpu variable should be treated as
    normal variable and absolute references should be relocated
    accordingly. In addition, the relocation offset should be subtracted
    from the GS base in order to ensure correct operation.

  - For x86/boot/head64.c, don't build it as mcmodel=large. Instead, use
    data relocation to acqiure global symbol's value and make
    fixup_pointer() as a nop when running in identity mapping. This is
    because not all global symbol references in the code use
    fixup_pointer(), e.g. variables in macro related to 5-level paging,
    which can be optimized by GCC as relative referencs. If build it as
    mcmodel=large, there will be more fixup_pointer() calls, resulting
    in uglier code. Actually, if build it as PIE even when
    CONFIG_X86_PIE is disabled, then all fixup_pointer() could be
    dropped. However stack protector would be broken if per-cpu stack
    protector is not supported.

  Limitations:
  - Since I am not familiar with XEN, it has been disabled for now as it
    is not adapted for PIE. This is due to the assignment of wrong
    pointers (with low address values) to x86_ini_ops when running in
    identity mapping. This issue can be resolved by building pagetable
    eraly and jumping to high kernel address as soon as possible.

  - It is not allowed to reference global variables in an alternative
    section since RIP-relative addressing is not fixed in
    apply_alternatives(). Fortunately, all disallowed relocations in the
    alternative section can be captured by objtool. I believe that this
    issue can also be fixed by using objtool.

  - For module loading, only allow to load module without GOT for
    simplicity. Only weak global variable referencs are using GOT.

  Tests:
    I only have tested booting with GCC 5.1.0 (min version), GCC 12.2.0
    and CLANG 15.0.7. And I have also run the following tests for both
    default configuration and Ubuntu configuration.

Performance/Size impact (GCC 12.2.0):

Size of vmlinux (Default configuration):
 File size:
 - PIE disabled: +0.012%
 - PIE enabled: -2.219%
 instructions:
 - PIE disabled: same
 - PIE enabled: +1.383%
 .text section:
 - PIE disabled: same
 - PIE enabled: +0.589%

Size of vmlinux (Ubuntu configuration):
 File size:
 - PIE disabled: same
 - PIE enabled: +2.391%
 instructions:
 - PIE disabled: +0.013%
 - PIE enabled: +1.566%
 .text section:
 - PIE disabled: same
 - PIE enabled: +0.055%

The .text section size increase is due to more instructions required for
PIE code. There are two reasons that have been mentioned in previous
mailist. Firstly, switch folding is disabled under PIE [3]. Secondly,
two instructions are needed for PIE to represent a single instruction
with sign extension, such as when accessing an array element. While only
one instruction is required when using mcmode=kernel, for PIE, it needs
to use lea to get the base of the array first.

Hackbench (50% and 1600% on thread/process for pipe/sockets):
 - PIE disabled: no significant change (avg -/+ 0.5% on default config).
 - PIE enabled: -2% to +2% in average (default config).

Kernbench (average of 10 Half and Optimal runs):
 Elapsed Time:
 - PIE disabled: no significant change (avg -0.2% on ubuntu config)
 - PIE enabled: average -0.2% to +0.2%
 System Time:
 - PIE disabled: no significant change (avg -0.5% on ubuntu config)
 - PIE enabled: average -0.5% to +0.5%

[1] https://lore.kernel.org/all/20190131192533.34130-1-thgarnie@chromium.org
[2] https://lore.kernel.org/all/20200228000105.165012-1-thgarnie@chromium.org
[3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82303

Brian Gerst (1):
  x86-64: Use per-cpu stack canary if supported by compiler

Hou Wenlong (29):
  x86/irq: Adapt assembly for PIE support
  x86,rethook: Adapt assembly for PIE support
  x86/paravirt: Use relative reference for original instruction
  x86/Kconfig: Introduce new Kconfig for PIE kernel building
  x86/PVH: Use fixed_percpu_data to set up GS base
  x86/pie: Enable stack protector only if per-cpu stack canary is
    supported
  x86/percpu: Use PC-relative addressing for percpu variable references
  x86/tools: Explicitly include autoconf.h for hostprogs
  x86/percpu: Adapt percpu references relocation for PIE support
  x86/ftrace: Adapt assembly for PIE support
  x86/pie: Force hidden visibility for all symbol references
  x86/boot/compressed: Adapt sed command to generate voffset.h when PIE
    is enabled
  x86/pie: Add .data.rel.* sections into link script
  KVM: x86: Adapt assembly for PIE support
  x86/PVH: Adapt PVH booting for PIE support
  x86/bpf: Adapt BPF_CALL JIT codegen for PIE support
  x86/modules: Adapt module loading for PIE support
  x86/boot/64: Use data relocation to get absloute address when PIE is
    enabled
  objtool: Add validation for x86 PIE support
  objtool: Adapt indirect call of __fentry__() for PIE support
  x86/pie: Build the kernel as PIE
  x86/vsyscall: Don't use set_fixmap() to map vsyscall page
  x86/xen: Pin up to VSYSCALL_ADDR when vsyscall page is out of fixmap
    area
  x86/fixmap: Move vsyscall page out of fixmap area
  x86/fixmap: Unify FIXADDR_TOP
  x86/boot: Fill kernel image puds dynamically
  x86/mm: Sort address_markers array when X86 PIE is enabled
  x86/pie: Allow kernel image to be relocated in top 512G
  x86/boot: Extend relocate range for PIE kernel image

Thomas Garnier (13):
  x86/crypto: Adapt assembly for PIE support
  x86: Add macro to get symbol address for PIE support
  x86: relocate_kernel - Adapt assembly for PIE support
  x86/entry/64: Adapt assembly for PIE support
  x86: pm-trace: Adapt assembly for PIE support
  x86/CPU: Adapt assembly for PIE support
  x86/acpi: Adapt assembly for PIE support
  x86/boot/64: Adapt assembly for PIE support
  x86/power/64: Adapt assembly for PIE support
  x86/alternatives: Adapt assembly for PIE support
  x86/ftrace: Adapt ftrace nop patching for PIE support
  x86/mm: Make the x86 GOT read-only
  x86/relocs: Handle PIE relocations

 Documentation/x86/x86_64/mm.rst              |   4 +
 arch/x86/Kconfig                             |  36 +++++-
 arch/x86/Makefile                            |  33 +++--
 arch/x86/boot/compressed/Makefile            |   2 +-
 arch/x86/boot/compressed/kaslr.c             |  55 +++++++++
 arch/x86/boot/compressed/misc.c              |   4 +-
 arch/x86/boot/compressed/misc.h              |   9 ++
 arch/x86/crypto/aegis128-aesni-asm.S         |   6 +-
 arch/x86/crypto/aesni-intel_asm.S            |   2 +-
 arch/x86/crypto/aesni-intel_avx-x86_64.S     |   3 +-
 arch/x86/crypto/aria-aesni-avx-asm_64.S      |  30 ++---
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |  30 ++---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |  30 ++---
 arch/x86/crypto/camellia-x86_64-asm_64.S     |   8 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  50 ++++----
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  44 ++++---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |   3 +-
 arch/x86/crypto/des3_ede-asm_64.S            |  96 ++++++++++-----
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |   4 +-
 arch/x86/crypto/sha256-avx2-asm.S            |  18 ++-
 arch/x86/entry/calling.h                     |  17 ++-
 arch/x86/entry/entry_64.S                    |  22 +++-
 arch/x86/entry/vdso/Makefile                 |   2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c        |   7 +-
 arch/x86/include/asm/alternative.h           |   6 +-
 arch/x86/include/asm/asm.h                   |   1 +
 arch/x86/include/asm/fixmap.h                |  28 +----
 arch/x86/include/asm/irq_stack.h             |   2 +-
 arch/x86/include/asm/kmsan.h                 |   6 +-
 arch/x86/include/asm/nospec-branch.h         |  10 +-
 arch/x86/include/asm/page_64.h               |   8 +-
 arch/x86/include/asm/page_64_types.h         |   8 ++
 arch/x86/include/asm/paravirt.h              |  17 ++-
 arch/x86/include/asm/paravirt_types.h        |  12 +-
 arch/x86/include/asm/percpu.h                |  29 ++++-
 arch/x86/include/asm/pgtable_64_types.h      |  10 +-
 arch/x86/include/asm/pm-trace.h              |   2 +-
 arch/x86/include/asm/processor.h             |  17 ++-
 arch/x86/include/asm/sections.h              |   5 +
 arch/x86/include/asm/stackprotector.h        |  16 ++-
 arch/x86/include/asm/sync_core.h             |   6 +-
 arch/x86/include/asm/vsyscall.h              |  13 ++
 arch/x86/kernel/acpi/wakeup_64.S             |  31 ++---
 arch/x86/kernel/alternative.c                |   8 +-
 arch/x86/kernel/asm-offsets_64.c             |   2 +-
 arch/x86/kernel/callthunks.c                 |   2 +-
 arch/x86/kernel/cpu/common.c                 |  15 ++-
 arch/x86/kernel/ftrace.c                     |  46 ++++++-
 arch/x86/kernel/ftrace_64.S                  |   9 +-
 arch/x86/kernel/head64.c                     |  77 +++++++++---
 arch/x86/kernel/head_64.S                    |  68 ++++++++---
 arch/x86/kernel/kvm.c                        |  21 +++-
 arch/x86/kernel/module.c                     |  27 +++++
 arch/x86/kernel/paravirt.c                   |   4 +
 arch/x86/kernel/relocate_kernel_64.S         |   2 +-
 arch/x86/kernel/rethook.c                    |   8 ++
 arch/x86/kernel/setup.c                      |   6 +
 arch/x86/kernel/vmlinux.lds.S                |  10 +-
 arch/x86/kvm/svm/vmenter.S                   |  10 +-
 arch/x86/kvm/vmx/vmenter.S                   |   2 +-
 arch/x86/lib/cmpxchg16b_emu.S                |   8 +-
 arch/x86/mm/dump_pagetables.c                |  36 +++++-
 arch/x86/mm/fault.c                          |   1 -
 arch/x86/mm/init_64.c                        |  10 +-
 arch/x86/mm/ioremap.c                        |   5 +-
 arch/x86/mm/kasan_init_64.c                  |   4 +-
 arch/x86/mm/pat/set_memory.c                 |   2 +-
 arch/x86/mm/pgtable.c                        |  13 ++
 arch/x86/mm/pgtable_32.c                     |   3 -
 arch/x86/mm/physaddr.c                       |  14 +--
 arch/x86/net/bpf_jit_comp.c                  |  17 ++-
 arch/x86/platform/efi/efi_thunk_64.S         |   4 +
 arch/x86/platform/pvh/head.S                 |  29 ++++-
 arch/x86/power/hibernate_asm_64.S            |   4 +-
 arch/x86/tools/Makefile                      |   4 +-
 arch/x86/tools/relocs.c                      | 113 ++++++++++++++++-
 arch/x86/xen/mmu_pv.c                        |  32 +++--
 arch/x86/xen/xen-asm.S                       |  10 +-
 arch/x86/xen/xen-head.S                      |  14 ++-
 include/asm-generic/vmlinux.lds.h            |  12 ++
 scripts/Makefile.lib                         |   1 +
 scripts/recordmcount.c                       |  81 ++++++++-----
 tools/objtool/arch/x86/decode.c              |  10 +-
 tools/objtool/builtin-check.c                |   4 +-
 tools/objtool/check.c                        | 121 +++++++++++++++++++
 tools/objtool/include/objtool/builtin.h      |   1 +
 86 files changed, 1202 insertions(+), 410 deletions(-)


Patchset is based on tip/master.
base-commit: 01cbd032298654fe4c85e153dd9a224e5bc10194
--
2.31.1

