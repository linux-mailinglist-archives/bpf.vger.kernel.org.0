Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618AE358C37
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 20:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhDHS27 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbhDHS27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 14:28:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA44C061765
        for <bpf@vger.kernel.org>; Thu,  8 Apr 2021 11:28:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v186so2868858ybe.5
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hFbfrV6NLQcaUFBI7qoKubPMd6hwVRmqL95jk4+jyxc=;
        b=JBj3h6xqwlztdZoD9Dqpfp7Alwo8u054FoOK8zma9pkGeWTeuATHhjoaZNawNS9+V6
         Tb0dfg5qd67tmw3R8nLEKrnIYOWChn0hf/JHJSKf1HDGlH5u4FFW0wRgpWmyLSvt4ajs
         5NMl9F0QfJzNd/l72+LsejYvM3DXrFq4dHIUFzx2BzuMfxcENkc+lXht5+iKIHiJQ9jO
         5Hv8ezegeHjGE0ZRU2sZBv0I3I9xLvPzXRtinDBJ/SSxL2hsoHBwdVVGqnvIdCCslKLV
         FjLUh4sBAuzykaGDJG7ZoK2ZyXcz8dON+CCNISz/BBMbMLgM2CAMTit3atSJCz7eDK7b
         N/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hFbfrV6NLQcaUFBI7qoKubPMd6hwVRmqL95jk4+jyxc=;
        b=tHMnAps/xJMqn9bN5ioy98VQuzFyJ0YJ4kAWhO+re/OW4hyBzygqOaH8GTGSgCIi/w
         A661A06EKXnUcWkORqaZ9FNo852y+CuVHNFkLNOw7lDYnSfeePY2jg/Mh3nxhMRw0Bqv
         7QUWasjPv/dR4pYCoNeIlqw0nCTpZH5Bp8oxsVi3qiUSrMvNjnaaGK/g0CpvAfg0JVUX
         Ok/p4QhpgIJJkKqaIejvlA9m1TB+907mtta3bZMVlChbndkkACShFQVGnT1h0/x26mFA
         euBaapUax7DbVdkBq71NTB68mwrvsePWNQ9rECVZaqC5ouFi0NQ1qa+nK7ZaOJQ71+Ki
         6gkg==
X-Gm-Message-State: AOAM530lDBd2O/HC/FXl4RJyp7RTd6AeNx6ItIlIr/8l2W8l3ydLGgjq
        l8Qk8ypIt/yKwb1z7moVdUalsX/hwB3PA+FdLdE=
X-Google-Smtp-Source: ABdhPJzp417bGfyY56r6I/HGmGdmkcvMSkgwww5nAXRa8l4TGBMnYYcrRloFTGcs6uh2r5JE+hqZHf9jDTXST4AD3dM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a25:31d5:: with SMTP id
 x204mr13666827ybx.3.1617906525373; Thu, 08 Apr 2021 11:28:45 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:25 -0700
Message-Id: <20210408182843.1754385-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 00/18] Add support for Clang CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support for Clang's Control-Flow Integrity (CFI)
checking. With CFI, the compiler injects a runtime check before each
indirect function call to ensure the target is a valid function with
the correct static type. This restricts possible call targets and
makes it more difficult for an attacker to exploit bugs that allow the
modification of stored function pointers. For more details, see:

  https://clang.llvm.org/docs/ControlFlowIntegrity.html

The first patch contains build system changes and error handling,
and implements support for cross-module indirect call checking. The
remaining patches address issues caused by the compiler
instrumentation. These include fixing known type mismatches, as well
as issues with address space confusion and cross-module function
address equality.

These patches add support only for arm64, but I'll post patches also
for x86_64 after we address the remaining issues there, including
objtool support.

You can also pull this series from

  https://github.com/samitolvanen/linux.git cfi-v6

---
Changes in v6:
 - Added temporary variables and moved assembly constraints to a
   separate line based on Mark's suggestions.

Changes in v5:
 - Changed module.lds.S to only include <asm/page.h> when CFI is
   enabled to fix the MIPS build.
 - Added a patch that fixes dynamic ftrace with CFI on arm64.

Changes in v4:
 - Per Mark's suggestion, dropped __pa_function() and renamed
   __va_function() to function_nocfi().
 - Added a comment to function_nocfi() to explain what it does.
 - Updated the psci patch to use an intermediate variable for
   the physical address for clarity.

Changes in v3:
 - Added a patch to change list_sort() callers treewide to use
   const pointers instead of simply removing the internal casts.
 - Changed cleanup_symbol_name() to return bool.
 - Changed module.lds.S to drop the .eh_frame section only with
   CONFIG_CFI_CLANG.
 - Switched to synchronize_rcu() in update_shadow().

Changes in v2:
 - Fixed .text merging in module.lds.S.
 - Added WARN_ON_FUNCTION_MISMATCH() and changed kernel/thread.c
   and kernel/workqueue.c to use the macro instead.


Sami Tolvanen (18):
  add support for Clang CFI
  cfi: add __cficanonical
  mm: add generic function_nocfi macro
  module: ensure __cfi_check alignment
  workqueue: use WARN_ON_FUNCTION_MISMATCH
  kthread: use WARN_ON_FUNCTION_MISMATCH
  kallsyms: strip ThinLTO hashes from static functions
  bpf: disable CFI in dispatcher functions
  treewide: Change list_sort to use const pointers
  lkdtm: use function_nocfi
  psci: use function_nocfi for cpu_resume
  arm64: implement function_nocfi
  arm64: use function_nocfi with __pa_symbol
  arm64: add __nocfi to functions that jump to a physical address
  arm64: add __nocfi to __apply_alternatives
  arm64: ftrace: use function_nocfi for ftrace_call
  KVM: arm64: Disable CFI for nVHE
  arm64: allow CONFIG_CFI_CLANG to be selected

 Makefile                                      |  17 +
 arch/Kconfig                                  |  45 +++
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/memory.h               |  16 +
 arch/arm64/include/asm/mmu_context.h          |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c     |   3 +-
 arch/arm64/kernel/alternative.c               |   4 +-
 arch/arm64/kernel/cpu-reset.h                 |  10 +-
 arch/arm64/kernel/cpufeature.c                |   4 +-
 arch/arm64/kernel/ftrace.c                    |   2 +-
 arch/arm64/kernel/psci.c                      |   3 +-
 arch/arm64/kernel/smp_spin_table.c            |   3 +-
 arch/arm64/kvm/hyp/nvhe/Makefile              |   6 +-
 arch/arm64/kvm/vgic/vgic-its.c                |   8 +-
 arch/arm64/kvm/vgic/vgic.c                    |   3 +-
 block/blk-mq-sched.c                          |   3 +-
 block/blk-mq.c                                |   3 +-
 drivers/acpi/nfit/core.c                      |   3 +-
 drivers/acpi/numa/hmat.c                      |   3 +-
 drivers/clk/keystone/sci-clk.c                |   4 +-
 drivers/firmware/psci/psci.c                  |   7 +-
 drivers/gpu/drm/drm_modes.c                   |   3 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c   |   3 +-
 drivers/gpu/drm/i915/gvt/debugfs.c            |   2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |   3 +-
 drivers/gpu/drm/radeon/radeon_cs.c            |   4 +-
 .../hw/usnic/usnic_uiom_interval_tree.c       |   3 +-
 drivers/interconnect/qcom/bcm-voter.c         |   2 +-
 drivers/md/raid5.c                            |   3 +-
 drivers/misc/lkdtm/usercopy.c                 |   2 +-
 drivers/misc/sram.c                           |   4 +-
 drivers/nvme/host/core.c                      |   3 +-
 .../controller/cadence/pcie-cadence-host.c    |   3 +-
 drivers/spi/spi-loopback-test.c               |   3 +-
 fs/btrfs/raid56.c                             |   3 +-
 fs/btrfs/tree-log.c                           |   3 +-
 fs/btrfs/volumes.c                            |   3 +-
 fs/ext4/fsmap.c                               |   4 +-
 fs/gfs2/glock.c                               |   3 +-
 fs/gfs2/log.c                                 |   2 +-
 fs/gfs2/lops.c                                |   3 +-
 fs/iomap/buffered-io.c                        |   3 +-
 fs/ubifs/gc.c                                 |   7 +-
 fs/ubifs/replay.c                             |   4 +-
 fs/xfs/scrub/bitmap.c                         |   4 +-
 fs/xfs/xfs_bmap_item.c                        |   4 +-
 fs/xfs/xfs_buf.c                              |   6 +-
 fs/xfs/xfs_extent_busy.c                      |   4 +-
 fs/xfs/xfs_extent_busy.h                      |   3 +-
 fs/xfs/xfs_extfree_item.c                     |   4 +-
 fs/xfs/xfs_refcount_item.c                    |   4 +-
 fs/xfs/xfs_rmap_item.c                        |   4 +-
 include/asm-generic/bug.h                     |  16 +
 include/asm-generic/vmlinux.lds.h             |  20 +-
 include/linux/bpf.h                           |   4 +-
 include/linux/cfi.h                           |  41 +++
 include/linux/compiler-clang.h                |   3 +
 include/linux/compiler_types.h                |   8 +
 include/linux/init.h                          |   6 +-
 include/linux/list_sort.h                     |   7 +-
 include/linux/mm.h                            |  10 +
 include/linux/module.h                        |  13 +-
 include/linux/pci.h                           |   4 +-
 init/Kconfig                                  |   2 +-
 kernel/Makefile                               |   4 +
 kernel/cfi.c                                  | 329 ++++++++++++++++++
 kernel/kallsyms.c                             |  55 ++-
 kernel/kthread.c                              |   3 +-
 kernel/module.c                               |  43 +++
 kernel/workqueue.c                            |   2 +-
 lib/list_sort.c                               |  17 +-
 lib/test_list_sort.c                          |   3 +-
 net/tipc/name_table.c                         |   4 +-
 scripts/Makefile.modfinal                     |   2 +-
 scripts/module.lds.S                          |  19 +-
 75 files changed, 760 insertions(+), 113 deletions(-)
 create mode 100644 include/linux/cfi.h
 create mode 100644 kernel/cfi.c


base-commit: e0a472fffe435af52ea4e21e1e0001c5c8ffc6c7
-- 
2.31.1.295.g9ea45b61b8-goog

