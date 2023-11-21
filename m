Return-Path: <bpf+bounces-15560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBC7F3485
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DB2B21223
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C756762;
	Tue, 21 Nov 2023 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07210E;
	Tue, 21 Nov 2023 09:09:43 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so3047612a12.2;
        Tue, 21 Nov 2023 09:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586582; x=1701191382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDqY6LIVmpxgbya3l2Nab39btyfIaWzyAEzG5sT0dtA=;
        b=IbCn2yFewox/9WR3VkSjZNXYZr87pBIZIUg2QjaRRPvuhqHzDzLuhvZRX6PHX/6D0a
         sDuGPRdeTuwxxeD0qCgQG1iW4NOTfILOmCVlNCfm53i9byGeNPG52ZX2Vka5JyKKiY2e
         kxOGfGHR0B1WsdXnR6WsCb5ADP9ub7BsNjViU5iEaQD8s3vOVV3to33mGvgokADh3m1O
         EWFTfFYlQnkorbw7U4wcdsbFa1A9OGTsXJNptbIXrqLb++6XfbL/3JbKqq0Af1wofTR+
         SPvl08OlXnTJQNIaJRVQoHduTCRo9DgK8Y0L+T69B/XbFjJiptF20GBhYuPmWzQWIDnn
         s/fQ==
X-Gm-Message-State: AOJu0YxBmJ13O5ea68EeVdFYub5uMNA5YYg/SFmhWSYP2TjQB4+f/F65
	grxwhlV+KrUvhOjVs91lX2E=
X-Google-Smtp-Source: AGHT+IG0OXdAmZl/s6GpGYs8sGVSUBNqozCr8XKBLxwouLiw4YwNnW/jrQPSw0Q3fqkEWDnkMjc8Zg==
X-Received: by 2002:a17:906:10b:b0:9c7:59d1:b2ce with SMTP id 11-20020a170906010b00b009c759d1b2cemr8410617eje.5.1700586581954;
        Tue, 21 Nov 2023 09:09:41 -0800 (PST)
Received: from localhost (fwdproxy-cln-027.fbsv.net. [2a03:2880:31ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id h4-20020a170906590400b00997d7aa59fasm5560744ejq.14.2023.11.21.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:09:41 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: jpoimboe@kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de
Cc: x86@kernel.org,
	leit@meta.com,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v6 00/13] x86/bugs: Add a separate config for each mitigation
Date: Tue, 21 Nov 2023 08:07:27 -0800
Message-Id: <20231121160740.1249350-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

The fact of having a fine grained control can help in a few ways:

1) Users can choose and pick only mitigations that are important for
their workloads.

2) Users and developers can choose to disable mitigations that mangle
the assembly code generation, making it hard to read.

3) Separate configs for just source code readability,
so that we see *which* butt-ugly piece of crap code is for what
reason.

Important to say, if a mitigation is disabled at compilation time, it
could be enabled at runtime using kernel command line arguments.

Discussion about this approach:
https://lore.kernel.org/all/CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com/
and
https://lore.kernel.org/lkml/20231011044252.42bplzjsam3qsasz@treble/

In order to get the missing mitigations, some clean up was done.

1) Get a namespace for mitigations, prepending MITIGATION to the Kconfig
entries.

2) Adding the missing mitigations, so, the mitigations have entries in the
Kconfig that could be easily configure by the user.

With this patchset applied, all configs have an individual entry under
CONFIG_SPECULATION_MITIGATIONS, and all of them starts with CONFIG_MITIGATION.

Changelog
---------
V1:
        * Creates a way to mitigate all (or none) hardware bugs
V2:
        * Create KCONFIGs entries only some hardware bugs (MDS, TAA, MMIO)
V3:
        * Expand the mitigations KCONFIGs to all hardware bugs that are
          Linux mitigates.
V4:
        * Patch rebase.
        * Better documentation about the reasons of this decision.
V5:
	* Create a "MITIGATION" Kconfig namespace for the entries mitigating
	  hardware bugs.
	* Add GDS to the set of mitigations that are being covered.
	* Reduce the ifdefs in the code by leveraging conditionals with omitted
	  operands.
V6:
	* Reference documentation RST files from Kconfig entries
	* Fix some grammar mistakes and Kconfig dependencies
	* Now spectre v2 user depends on CONFIG_MITIGATION_SPECTRE_V2. See
	  patch "spectre_v2_user default mode depends on Kconfig"

Breno Leitao (13):
  x86/bugs: Rename GDS_FORCE_MITIGATION to MITIGATION_GDS_FORCE
  x86/bugs: Rename CPU_IBPB_ENTRY to MITIGATION_IBPB_ENTRY
  x86/bugs: Rename CALL_DEPTH_TRACKING to MITIGATION_CALL_DEPTH_TRACKING
  x86/bugs: Rename PAGE_TABLE_ISOLATION to MITIGATION_PAGE_TABLE_ISOLATION
  x86/bugs: Rename RETPOLINE to MITIGATION_RETPOLINE
  x86/bugs: Rename SLS to CONFIG_MITIGATION_SLS
  x86/bugs: Rename CPU_UNRET_ENTRY to MITIGATION_UNRET_ENTRY
  x86/bugs: Rename CPU_IBRS_ENTRY to MITIGATION_IBRS_ENTRY
  x86/bugs: Rename CPU_SRSO to MITIGATION_SRSO
  x86/bugs: Rename RETHUNK to MITIGATION_RETHUNK
  x86/bugs: Create a way to disable GDS mitigation
  x86/bugs: spectre_v2_user default mode depends on Kconfig
  x86/bugs: Add a separate config for missing mitigation

 Documentation/admin-guide/hw-vuln/spectre.rst |   8 +-
 .../admin-guide/kernel-parameters.txt         |   4 +-
 Documentation/arch/x86/pti.rst                |   6 +-
 arch/x86/Kconfig                              | 151 +++++++++++++++---
 arch/x86/Makefile                             |   8 +-
 arch/x86/boot/compressed/ident_map_64.c       |   4 +-
 arch/x86/configs/i386_defconfig               |   2 +-
 arch/x86/entry/calling.h                      |   8 +-
 arch/x86/entry/entry_64.S                     |   2 +-
 arch/x86/entry/vdso/Makefile                  |   4 +-
 arch/x86/include/asm/current.h                |   2 +-
 arch/x86/include/asm/disabled-features.h      |  10 +-
 arch/x86/include/asm/linkage.h                |  16 +-
 arch/x86/include/asm/nospec-branch.h          |  30 ++--
 arch/x86/include/asm/pgalloc.h                |   2 +-
 arch/x86/include/asm/pgtable-3level.h         |   2 +-
 arch/x86/include/asm/pgtable.h                |  18 +--
 arch/x86/include/asm/pgtable_64.h             |   3 +-
 arch/x86/include/asm/processor-flags.h        |   2 +-
 arch/x86/include/asm/pti.h                    |   2 +-
 arch/x86/include/asm/static_call.h            |   2 +-
 arch/x86/kernel/alternative.c                 |  14 +-
 arch/x86/kernel/asm-offsets.c                 |   2 +-
 arch/x86/kernel/cpu/amd.c                     |   2 +-
 arch/x86/kernel/cpu/bugs.c                    |  98 +++++++-----
 arch/x86/kernel/dumpstack.c                   |   2 +-
 arch/x86/kernel/ftrace.c                      |   3 +-
 arch/x86/kernel/head_32.S                     |   4 +-
 arch/x86/kernel/head_64.S                     |   2 +-
 arch/x86/kernel/kprobes/opt.c                 |   2 +-
 arch/x86/kernel/ldt.c                         |   8 +-
 arch/x86/kernel/static_call.c                 |   2 +-
 arch/x86/kernel/vmlinux.lds.S                 |  10 +-
 arch/x86/kvm/mmu/mmu.c                        |   2 +-
 arch/x86/kvm/mmu/mmu_internal.h               |   2 +-
 arch/x86/kvm/svm/svm.c                        |   2 +-
 arch/x86/kvm/svm/vmenter.S                    |   4 +-
 arch/x86/kvm/vmx/vmx.c                        |   2 +-
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/retpoline.S                      |  26 +--
 arch/x86/mm/Makefile                          |   2 +-
 arch/x86/mm/debug_pagetables.c                |   4 +-
 arch/x86/mm/dump_pagetables.c                 |   4 +-
 arch/x86/mm/pgtable.c                         |   4 +-
 arch/x86/mm/tlb.c                             |  10 +-
 arch/x86/net/bpf_jit_comp.c                   |   4 +-
 arch/x86/net/bpf_jit_comp32.c                 |   2 +-
 arch/x86/purgatory/Makefile                   |   2 +-
 include/linux/compiler-gcc.h                  |   2 +-
 include/linux/indirect_call_wrapper.h         |   2 +-
 include/linux/module.h                        |   2 +-
 include/linux/objtool.h                       |   2 +-
 include/linux/pti.h                           |   2 +-
 include/net/netfilter/nf_tables_core.h        |   2 +-
 include/net/tc_wrapper.h                      |   2 +-
 kernel/trace/ring_buffer.c                    |   2 +-
 net/netfilter/Makefile                        |   2 +-
 net/netfilter/nf_tables_core.c                |   6 +-
 net/netfilter/nft_ct.c                        |   4 +-
 net/netfilter/nft_lookup.c                    |   2 +-
 net/sched/sch_api.c                           |   2 +-
 scripts/Makefile.lib                          |   8 +-
 scripts/Makefile.vmlinux_o                    |   2 +-
 scripts/generate_rust_target.rs               |   2 +-
 scripts/mod/modpost.c                         |   2 +-
 .../arch/x86/include/asm/disabled-features.h  |  10 +-
 66 files changed, 344 insertions(+), 219 deletions(-)

-- 
2.34.1


