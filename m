Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833C94AE8F2
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiBIFNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:13:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377815AbiBIElT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 23:41:19 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB925C061579
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 20:41:18 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i10so775498ilm.4
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 20:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7t36LdCGbLq4fNGgL+Fce4M8ZaXugQ2Hp8fiBZ3C2ek=;
        b=J1qbFg4wUHF+mQa2aJuaHh4fLBOz0m6ygV39pVdJLUNBVFyCVSe7kW9bqHfdMbvUfh
         8fbxYNFR87OpCx5ZbVDXUbFACINiG/heP9RX9CxBqQLzZeaRMHCUjyPhsqgnDAF+EIrk
         uol2/TfZXxoSRrb22vtNJkR+TZqAkPpWvKFngQ89wwA38I/HR6K+lc3rE4ZLf6hUORhc
         rwNfo6+U0Fbbt43FCwhmB/IZMRN+Na7/dS60UyscYRd1mkIGtdoWaCmYUmBXYpN7Rg4U
         oNem/wLmxTlWZ+MeGZolwhA4WYGAm3oiYz3im0OB2K/4EUzC1JguvaPxmmAdxGnRWj6+
         YCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7t36LdCGbLq4fNGgL+Fce4M8ZaXugQ2Hp8fiBZ3C2ek=;
        b=EKrNKA58kk4tcu39ZQbGneHRx4P9CIPVorAB1i41cpXB2Rb8A5YGCjLpGsDTqIoS89
         SBt5v4JA9iU4A/S6f/pDa3vJmHHJWD4fLn7kUjO46JcjNcDR0s9LVlA9E5hMaOL0dClJ
         JzC6bsbpmZVayrXl0A4WNK0xN1Ggb8AGGmATZK72AAbhH2fD1D+p8raa6tKnfIDgKo9Y
         HeGPRPPR87sssIPxK6tBAQjpklTy7fS9dStLgmNwNxUDz8rXBFBYXNrxvWvydDJeVKAo
         B17h0isPC9JtOIaBu2NddCGDiPVliaZR2CpcxddbfhEdTxuVmnJf+6xcVZSHp6R2UsF6
         JhEw==
X-Gm-Message-State: AOAM533rd1/bRfYGyLXEgZOmi3igSVYjJocS5n97TSF/fvfIOq59Z6H8
        AB2EWaahyfVAGqzrXQKTWHpSrzbcZh8WjIdKpS0=
X-Google-Smtp-Source: ABdhPJxoMgLZZf6nTtx7N+Bzk6JAbg1oQ9NIjAr/yKdpkUCm7AlhXm0MHWDlSTC+O6dkYah8WpiG8UU5Wil9pJb/cFs=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr230475ilv.305.1644381677197;
 Tue, 08 Feb 2022 20:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 20:41:06 -0800
Message-ID: <CAEf4BzYmr-ApTnFsq9Wc2afCZpbzG80Ftx4n=BvoCFCUaSCEzw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/5] bpf: Light skeleton for the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 11:13 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The libbpf performs a set of complex operations to load BPF programs.
> With "loader program" and "CO-RE in the kernel" the loading job of
> libbpf was diminished. The light skeleton became lean enough to perform
> program loading and map creation tasks without libbpf.
> It's now possible to tweak it further to make light skeleton usable
> out of user space and out of kernel module.
> This allows bpf_preload.ko to drop user-mode-driver usage,
> drop host compiler dependency, allow cross compilation and simplify the code.
> It's a building block toward safe and portable kernel modules.
>
> v1->v2:
> - removed redundant anon struct and added comments (Andrii's reivew)
> - added Yonghong's ack
> - fixed build warning when JIT is off
>
> Alexei Starovoitov (5):
>   bpf: Extend sys_bpf commands for bpf_syscall programs.
>   libbpf: Prepare light skeleton for the kernel.
>   bpftool: Generalize light skeleton generation.
>   bpf: Update iterators.lskel.h.
>   bpf: Convert bpf_preload.ko to use light skeleton.
>

See question about error handling for rodata in skeleton. But otherwise LGTM.

For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/inode.c                            |  39 +---
>  kernel/bpf/preload/Kconfig                    |   9 +-
>  kernel/bpf/preload/Makefile                   |  14 +-
>  kernel/bpf/preload/bpf_preload.h              |   8 +-
>  kernel/bpf/preload/bpf_preload_kern.c         | 119 +++++------
>  kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 -
>  .../preload/iterators/bpf_preload_common.h    |  13 --
>  kernel/bpf/preload/iterators/iterators.c      | 108 ----------
>  .../bpf/preload/iterators/iterators.lskel.h   |  28 +--
>  kernel/bpf/syscall.c                          |  40 +++-
>  tools/bpf/bpftool/gen.c                       |  45 ++--
>  tools/lib/bpf/skel_internal.h                 | 193 ++++++++++++++++--
>  12 files changed, 319 insertions(+), 304 deletions(-)
>  delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
>  delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
>  delete mode 100644 kernel/bpf/preload/iterators/iterators.c
>
> --
> 2.30.2
>
