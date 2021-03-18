Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E43340B2C
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 18:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhCRRLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhCRRLQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F079C06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l83so2869473ybf.22
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SCzz0vkCTXCJ+hl1sGhlu0aynSHOxUfyv4GiVUi2UT8=;
        b=Qn2g5lLRvdKJvgzF43+LCRfbhyf/1XwO7VexN9MTAJ/y7/GXos2MZ6DPQ5+40SXSdr
         3WUM1haHcbmP9fvJ5H0GP0vnMIfZYFYJ3/skq+V4JOBLmlhGlPExy6gqYwMz2uSJ1gR3
         Kgl24aisbJ27zFi0E+w0DAM6qtK+mORJD0REsBOc+I74Jm51pwyVzGpvxB7NjD1JArlW
         Z1Nw3IJcwTpFcPc/OM/mDZYHlik6/X5+hBBgaF+RBWA6lCnTc9Su31yLYk3E+KZP8/w7
         k1BrfTKfIXXZ46LHA5pZpwKRNzhgz58PNc7YyUV/9wiANk3u5qYBZVv8t0PgePg8ENXo
         Bcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SCzz0vkCTXCJ+hl1sGhlu0aynSHOxUfyv4GiVUi2UT8=;
        b=Y5zBcpW6V4jPCfl5QfWp4GdKa8NiQpMivZbZ+/DEEjZgGd021HltZGmQKlETegEIcT
         AoPeKiOt+0xWvxYpDMdM+pKOJevQJ/Pd1GK3Qlix5FUzYDK+SvO2SCkJfSEvyFCkAq8L
         FVWalv+9m5c1v/fWC5AJ6B1fb678V90UuqF73vSJaGBDQ+I2kQDKIlzikvwHhaWsZ8cQ
         duLeuLp3b++Ht6X8nRNmYJEQ5VzK0U6AqB0qhpbNshmLWr9osXZwubLGpCDkVyolppWY
         Oj6w3vhaqxhGUl1L/k07iJRSqptj1Yrgrd33zpJsob7/AFRYjflmFlKCIEDppD0czye6
         zFOQ==
X-Gm-Message-State: AOAM530qY6FuXdK0cEl6jNdJVIDNy7tzNtavP/OTEDlQ+RWlibVWDR+B
        R5RxgJy7nc8YEP14fUYAAXNCj32PgjSG/AUSzM8=
X-Google-Smtp-Source: ABdhPJwBMd/Hg8Inw/d+QCjcsX4aY1KphAmvmly7frqYXPa28oCDMQoPY4+7I2PpXYAYog1pvPg18bYfcaeLUFSg7M0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a25:4ce:: with SMTP id
 197mr429022ybe.462.1616087474808; Thu, 18 Mar 2021 10:11:14 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:10:54 -0700
Message-Id: <20210318171111.706303-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 00/17] Add support for Clang CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
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

  https://github.com/samitolvanen/linux.git cfi-v2

---
Changes in v2:
 - Fixed .text merging in module.lds.S.
 - Added WARN_ON_FUNCTION_MISMATCH() and changed kernel/thread.c
   and kernel/workqueue.c to use the macro instead.


Sami Tolvanen (17):
  add support for Clang CFI
  cfi: add __cficanonical
  mm: add generic __va_function and __pa_function macros
  module: ensure __cfi_check alignment
  workqueue: use WARN_ON_FUNCTION_MISMATCH
  kthread: use WARN_ON_FUNCTION_MISMATCH
  kallsyms: strip ThinLTO hashes from static functions
  bpf: disable CFI in dispatcher functions
  lib/list_sort: fix function type mismatches
  lkdtm: use __va_function
  psci: use __pa_function for cpu_resume
  arm64: implement __va_function
  arm64: use __pa_function
  arm64: add __nocfi to functions that jump to a physical address
  arm64: add __nocfi to __apply_alternatives
  KVM: arm64: Disable CFI for nVHE
  arm64: allow CONFIG_CFI_CLANG to be selected

 Makefile                                  |  17 ++
 arch/Kconfig                              |  45 +++
 arch/arm64/Kconfig                        |   1 +
 arch/arm64/include/asm/memory.h           |  15 +
 arch/arm64/include/asm/mmu_context.h      |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c |   2 +-
 arch/arm64/kernel/alternative.c           |   4 +-
 arch/arm64/kernel/cpu-reset.h             |  10 +-
 arch/arm64/kernel/cpufeature.c            |   4 +-
 arch/arm64/kernel/psci.c                  |   3 +-
 arch/arm64/kernel/smp_spin_table.c        |   2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile          |   6 +-
 drivers/firmware/psci/psci.c              |   4 +-
 drivers/misc/lkdtm/usercopy.c             |   2 +-
 include/asm-generic/bug.h                 |  16 ++
 include/asm-generic/vmlinux.lds.h         |  20 +-
 include/linux/bpf.h                       |   4 +-
 include/linux/cfi.h                       |  41 +++
 include/linux/compiler-clang.h            |   3 +
 include/linux/compiler_types.h            |   8 +
 include/linux/init.h                      |   6 +-
 include/linux/mm.h                        |   8 +
 include/linux/module.h                    |  13 +-
 include/linux/pci.h                       |   4 +-
 init/Kconfig                              |   2 +-
 kernel/Makefile                           |   4 +
 kernel/cfi.c                              | 329 ++++++++++++++++++++++
 kernel/kallsyms.c                         |  54 +++-
 kernel/kthread.c                          |   3 +-
 kernel/module.c                           |  43 +++
 kernel/workqueue.c                        |   2 +-
 lib/list_sort.c                           |   8 +-
 scripts/Makefile.modfinal                 |   2 +-
 scripts/module.lds.S                      |  18 +-
 34 files changed, 663 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/cfi.h
 create mode 100644 kernel/cfi.c


base-commit: 6417f03132a6952cd17ddd8eaddbac92b61b17e0
-- 
2.31.0.291.g576ba9dcdaf-goog

