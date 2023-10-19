Return-Path: <bpf+bounces-12723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A202F7D0130
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEB4B21320
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 18:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116F37CB5;
	Thu, 19 Oct 2023 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1037C90
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 18:12:23 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2C12D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:12:19 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so13989202a12.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739138; x=1698343938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghTz8XSf6OoRU2U731CrIpcb8c7Gp4rY5wSTKxYJjcY=;
        b=GvsbIL0QxcWMNaa8WzwQ7pZU3zfbCV/+eda6Wqvak9e1UzT+ZCPxlfwq4wNxlIfEj8
         Xx6YxqLUbc+68+TC+UmbG7ApSe4sSHNKritxseZcJT2YM7/1VmSabC2KrwmTRp4b0k89
         MvdJkBXGki2R8Rrq+WpfxxSJgtRaaYP8k6HMo8Wadlx43Me0oXfzNQggHRXXXMnbn5tb
         I5QXX++i1wdWuS8YsrNOdjcV4OJY1QIk9xVxDVYIegNdDnAbbifeV6INxSbMqsTT7UOT
         CQ+2VN/BkYDeWybQdDKJP9nIuoiJHdGSvAERrpL7f3d9vC9MSK4zGN0oBOdasuP/C+Mn
         5FCA==
X-Gm-Message-State: AOJu0Yz8i5u1l/1dAB9IwI4edni9OOYIQdHwVxpVoN24whLrWZ1jXRvj
	zVoQ335IMmJHdMkQB00TW9s=
X-Google-Smtp-Source: AGHT+IH6sw5vuUr0cVkIquYGJth/uvVOcs6wi/NDxCn1RXLk1NMiZEiHRQPGB3n1eQqi34owTw8N8A==
X-Received: by 2002:aa7:d883:0:b0:53e:58fd:9600 with SMTP id u3-20020aa7d883000000b0053e58fd9600mr2238015edq.36.1697739137499;
        Thu, 19 Oct 2023 11:12:17 -0700 (PDT)
Received: from localhost (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id cm15-20020a0564020c8f00b0053e3839fc79sm22783edb.96.2023.10.19.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:12:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: jpoimboe@kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de
Cc: x86@kernel.org,
	leit@meta.com,
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v5 00/12] x86/bugs: Add a separate config for each mitigation
Date: Thu, 19 Oct 2023 11:11:46 -0700
Message-Id: <20231019181158.1982205-1-leitao@debian.org>
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

Breno Leitao (12):
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
  x86/bugs: Add a separate config for missing mitigation

 Documentation/admin-guide/hw-vuln/spectre.rst |   8 +-
 .../admin-guide/kernel-parameters.txt         |   4 +-
 Documentation/arch/x86/pti.rst                |   6 +-
 arch/x86/Kconfig                              | 141 +++++++++++++++---
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
 arch/x86/kernel/cpu/bugs.c                    |  87 ++++++-----
 arch/x86/kernel/dumpstack.c                   |   2 +-
 arch/x86/kernel/ftrace.c                      |   3 +-
 arch/x86/kernel/head_32.S                     |   4 +-
 arch/x86/kernel/head_64.S                     |   2 +-
 arch/x86/kernel/kprobes/opt.c                 |   2 +-
 arch/x86/kernel/ldt.c                         |   8 +-
 arch/x86/kernel/static_call.c                 |   2 +-
 arch/x86/kernel/vmlinux.lds.S                 |   8 +-
 arch/x86/kvm/mmu/mmu.c                        |   2 +-
 arch/x86/kvm/mmu/mmu_internal.h               |   2 +-
 arch/x86/kvm/svm/svm.c                        |   2 +-
 arch/x86/kvm/svm/vmenter.S                    |   4 +-
 arch/x86/kvm/vmx/vmx.c                        |   2 +-
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/retpoline.S                      |  26 ++--
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
 66 files changed, 326 insertions(+), 214 deletions(-)

-- 
2.34.1


