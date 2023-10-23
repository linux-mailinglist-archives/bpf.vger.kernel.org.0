Return-Path: <bpf+bounces-12966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7F7D28C2
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 05:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5D0B20D58
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 02:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D515B3;
	Mon, 23 Oct 2023 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvxCSk7r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224081104
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:59:51 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C84119
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 19:59:49 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d1a05b816so21946406d6.1
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698029988; x=1698634788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6OJsYG53qkdKLI2mndRMykx22cvUjCektEL73A9ayc=;
        b=FvxCSk7ryIkgsQTdZJRMQLfPSJX84moxKXidkMGO086F4lRO0DMe6IUWDY6gChZXPH
         qDdVxHZIDF89H0Ar7qrgDEcOvNrfE/1RQV/KGqn7LQcD3f9jgAEEYy3MK7YdhggTp7AH
         hQQQB5VdOJo2w780IpqVmgXiGqcQtjZjbyv3/Qn/8ax0LAcnUcIbmCrAeDsXv3YbJ8EQ
         Mx1Ow9DgBE1HPCJGH0hS8UKooyIleX0YfU3kKROl7AhpnED5/kE3RXh9S4w9zHsYqJZS
         pIAb2qGi04unTtYLZ0sgLAdtI8VSsFkTD4E1nXg2CtfMJNViKyxkGsjM2f8tsYK0huVw
         o/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698029988; x=1698634788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6OJsYG53qkdKLI2mndRMykx22cvUjCektEL73A9ayc=;
        b=qWSNOPHQTDKiCIVVFtjz4Axa/Jcmtksi1yk5yRnsSwA9UWFIHcQ7Y40dBRyDUrLurP
         +5HtTu/uU44pnCSC5Y8irXPsd8FejIpwm/5V/6C9xf3ooqPJZDgJA68lhvVYMXCk7t3a
         eYN2wWp/W5Lua86WLfbiI8MRp2+YiVPOjuA/POV56Bg442o01fHZPtDTbCmWJAJ1yOzz
         VpaXz9IXXdXY/zZESh46buPaDfh1FGBTnQAIvd6vi69G4OaMmXIlt9PFGzPImvdHY4Jf
         vLxbr8wO7jbZzGnk1iJMJu7zipeUx5Y3RT/kzOPQGw5MmFyhjUQa5IRFZteixSvtNcMF
         xT7w==
X-Gm-Message-State: AOJu0Yw9b/gvJHftcnyuiZ6azc/Yl7ZFcD2emLvg/OvgmEvcYXFzT2+T
	VI92YnFEK/V6Td8ejgU/mcPeBNoyC4+fOhZqPJk=
X-Google-Smtp-Source: AGHT+IHT2DVFg6n/fpki1JIz7YgvFr1x5k4XW7Dr5KilWPtUgML5TtFS4KfemrRuh1swAjNGWz7OYprgiFX6niZWh50=
X-Received: by 2002:a05:6214:248e:b0:66d:690d:42b8 with SMTP id
 gi14-20020a056214248e00b0066d690d42b8mr12191924qvb.22.1698029988506; Sun, 22
 Oct 2023 19:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019181158.1982205-1-leitao@debian.org>
In-Reply-To: <20231019181158.1982205-1-leitao@debian.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 23 Oct 2023 10:59:13 +0800
Message-ID: <CALOAHbDreP4JpL_C=+mkpwRvMpkVDdE-LNxkN=oyJW2vPjM_GQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] x86/bugs: Add a separate config for each mitigation
To: Breno Leitao <leitao@debian.org>
Cc: jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	x86@kernel.org, leit@meta.com, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 2:12=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
> where some mitigations have entries in Kconfig, and they could be
> modified, while others mitigations do not have Kconfig entries, and
> could not be controlled at build time.
>
> The fact of having a fine grained control can help in a few ways:
>
> 1) Users can choose and pick only mitigations that are important for
> their workloads.
>
> 2) Users and developers can choose to disable mitigations that mangle
> the assembly code generation, making it hard to read.
>
> 3) Separate configs for just source code readability,
> so that we see *which* butt-ugly piece of crap code is for what
> reason.
>
> Important to say, if a mitigation is disabled at compilation time, it
> could be enabled at runtime using kernel command line arguments.

Hi Breno,

Do you have any plans to introduce utility functions for runtime
checks on whether specific mitigations are disabled? Such helpers
would be quite valuable; for instance, we could utilize them to
determine if Spectre v1 or Spectre v4 mitigations are disabled in
BPF[1].

[1].  https://lore.kernel.org/bpf/20231005084123.1338-1-laoar.shao@gmail.co=
m


>
> Discussion about this approach:
> https://lore.kernel.org/all/CAHk-=3DwjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7q=
A9U1Xr4w@mail.gmail.com/
> and
> https://lore.kernel.org/lkml/20231011044252.42bplzjsam3qsasz@treble/
>
> In order to get the missing mitigations, some clean up was done.
>
> 1) Get a namespace for mitigations, prepending MITIGATION to the Kconfig
> entries.
>
> 2) Adding the missing mitigations, so, the mitigations have entries in th=
e
> Kconfig that could be easily configure by the user.
>
> With this patchset applied, all configs have an individual entry under
> CONFIG_SPECULATION_MITIGATIONS, and all of them starts with CONFIG_MITIGA=
TION.
>
> Changelog
> ---------
> V1:
>         * Creates a way to mitigate all (or none) hardware bugs
> V2:
>         * Create KCONFIGs entries only some hardware bugs (MDS, TAA, MMIO=
)
> V3:
>         * Expand the mitigations KCONFIGs to all hardware bugs that are
>           Linux mitigates.
> V4:
>         * Patch rebase.
>         * Better documentation about the reasons of this decision.
> V5:
>         * Create a "MITIGATION" Kconfig namespace for the entries mitigat=
ing
>           hardware bugs.
>         * Add GDS to the set of mitigations that are being covered.
>         * Reduce the ifdefs in the code by leveraging conditionals with o=
mitted
>           operands.
>
> Breno Leitao (12):
>   x86/bugs: Rename GDS_FORCE_MITIGATION to MITIGATION_GDS_FORCE
>   x86/bugs: Rename CPU_IBPB_ENTRY to MITIGATION_IBPB_ENTRY
>   x86/bugs: Rename CALL_DEPTH_TRACKING to MITIGATION_CALL_DEPTH_TRACKING
>   x86/bugs: Rename PAGE_TABLE_ISOLATION to MITIGATION_PAGE_TABLE_ISOLATIO=
N
>   x86/bugs: Rename RETPOLINE to MITIGATION_RETPOLINE
>   x86/bugs: Rename SLS to CONFIG_MITIGATION_SLS
>   x86/bugs: Rename CPU_UNRET_ENTRY to MITIGATION_UNRET_ENTRY
>   x86/bugs: Rename CPU_IBRS_ENTRY to MITIGATION_IBRS_ENTRY
>   x86/bugs: Rename CPU_SRSO to MITIGATION_SRSO
>   x86/bugs: Rename RETHUNK to MITIGATION_RETHUNK
>   x86/bugs: Create a way to disable GDS mitigation
>   x86/bugs: Add a separate config for missing mitigation
>
>  Documentation/admin-guide/hw-vuln/spectre.rst |   8 +-
>  .../admin-guide/kernel-parameters.txt         |   4 +-
>  Documentation/arch/x86/pti.rst                |   6 +-
>  arch/x86/Kconfig                              | 141 +++++++++++++++---
>  arch/x86/Makefile                             |   8 +-
>  arch/x86/boot/compressed/ident_map_64.c       |   4 +-
>  arch/x86/configs/i386_defconfig               |   2 +-
>  arch/x86/entry/calling.h                      |   8 +-
>  arch/x86/entry/entry_64.S                     |   2 +-
>  arch/x86/entry/vdso/Makefile                  |   4 +-
>  arch/x86/include/asm/current.h                |   2 +-
>  arch/x86/include/asm/disabled-features.h      |  10 +-
>  arch/x86/include/asm/linkage.h                |  16 +-
>  arch/x86/include/asm/nospec-branch.h          |  30 ++--
>  arch/x86/include/asm/pgalloc.h                |   2 +-
>  arch/x86/include/asm/pgtable-3level.h         |   2 +-
>  arch/x86/include/asm/pgtable.h                |  18 +--
>  arch/x86/include/asm/pgtable_64.h             |   3 +-
>  arch/x86/include/asm/processor-flags.h        |   2 +-
>  arch/x86/include/asm/pti.h                    |   2 +-
>  arch/x86/include/asm/static_call.h            |   2 +-
>  arch/x86/kernel/alternative.c                 |  14 +-
>  arch/x86/kernel/asm-offsets.c                 |   2 +-
>  arch/x86/kernel/cpu/amd.c                     |   2 +-
>  arch/x86/kernel/cpu/bugs.c                    |  87 ++++++-----
>  arch/x86/kernel/dumpstack.c                   |   2 +-
>  arch/x86/kernel/ftrace.c                      |   3 +-
>  arch/x86/kernel/head_32.S                     |   4 +-
>  arch/x86/kernel/head_64.S                     |   2 +-
>  arch/x86/kernel/kprobes/opt.c                 |   2 +-
>  arch/x86/kernel/ldt.c                         |   8 +-
>  arch/x86/kernel/static_call.c                 |   2 +-
>  arch/x86/kernel/vmlinux.lds.S                 |   8 +-
>  arch/x86/kvm/mmu/mmu.c                        |   2 +-
>  arch/x86/kvm/mmu/mmu_internal.h               |   2 +-
>  arch/x86/kvm/svm/svm.c                        |   2 +-
>  arch/x86/kvm/svm/vmenter.S                    |   4 +-
>  arch/x86/kvm/vmx/vmx.c                        |   2 +-
>  arch/x86/lib/Makefile                         |   2 +-
>  arch/x86/lib/retpoline.S                      |  26 ++--
>  arch/x86/mm/Makefile                          |   2 +-
>  arch/x86/mm/debug_pagetables.c                |   4 +-
>  arch/x86/mm/dump_pagetables.c                 |   4 +-
>  arch/x86/mm/pgtable.c                         |   4 +-
>  arch/x86/mm/tlb.c                             |  10 +-
>  arch/x86/net/bpf_jit_comp.c                   |   4 +-
>  arch/x86/net/bpf_jit_comp32.c                 |   2 +-
>  arch/x86/purgatory/Makefile                   |   2 +-
>  include/linux/compiler-gcc.h                  |   2 +-
>  include/linux/indirect_call_wrapper.h         |   2 +-
>  include/linux/module.h                        |   2 +-
>  include/linux/objtool.h                       |   2 +-
>  include/linux/pti.h                           |   2 +-
>  include/net/netfilter/nf_tables_core.h        |   2 +-
>  include/net/tc_wrapper.h                      |   2 +-
>  kernel/trace/ring_buffer.c                    |   2 +-
>  net/netfilter/Makefile                        |   2 +-
>  net/netfilter/nf_tables_core.c                |   6 +-
>  net/netfilter/nft_ct.c                        |   4 +-
>  net/netfilter/nft_lookup.c                    |   2 +-
>  net/sched/sch_api.c                           |   2 +-
>  scripts/Makefile.lib                          |   8 +-
>  scripts/Makefile.vmlinux_o                    |   2 +-
>  scripts/generate_rust_target.rs               |   2 +-
>  scripts/mod/modpost.c                         |   2 +-
>  .../arch/x86/include/asm/disabled-features.h  |  10 +-
>  66 files changed, 326 insertions(+), 214 deletions(-)
>
> --
> 2.34.1
>
>


--
Regards
Yafang

