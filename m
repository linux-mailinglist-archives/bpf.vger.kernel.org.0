Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0C4282B9
	for <lists+bpf@lfdr.de>; Sun, 10 Oct 2021 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhJJRvV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Oct 2021 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhJJRvV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Oct 2021 13:51:21 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F54C06161C
        for <bpf@vger.kernel.org>; Sun, 10 Oct 2021 10:49:22 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id u32so33443407ybd.9
        for <bpf@vger.kernel.org>; Sun, 10 Oct 2021 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m0tVlWSXIOyQB2dgqv4j2n31BilYhoZPAwFWKrJU88=;
        b=PsUvnSdUSAmqKwDzNq9WJnFPKcbpdmRh5/jw66XAt9hP/tWSJAb/4w/SNgIAPG5Aox
         mX2G/aDq1B5rPRE46cQTRb2XuHG9e/SSVWq8F53f4DR0mkYuD9jP54/hCWXqUXQxI0Zf
         pAcHnFJISheLru/OQ8lMIla4gFwGM5gL1R7J8H7bhKtQNeIbU5OS8k2xbFAqEvNyYkq9
         gNdSwnxBTvz5lkNBP7Dsjn+NJVtuyUR28qOL1AmfDyi9eroRguVFqfbi9gZjfk9qXLmd
         utsIGcSdYnV2MSanTe+6k1r61+/oFVTNB7smQDAR4XjowUMUmZgtO5J3dPU+BQVD5T6H
         SWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m0tVlWSXIOyQB2dgqv4j2n31BilYhoZPAwFWKrJU88=;
        b=AiSBwdbLmqfniv8GBzrbini88GkezccaQhupJy0Bs5cRx4BzWFk0Vu8zsqePPYVP8/
         GoCZ+PMTS5oMZH14zKiU3GGSehdN78x7ueY/20HRccltMHntyTdMOwPHoijZ8c8J3MN7
         hpj8s51iOKfYM3CFL78D17gyr1+ixDJ3+SpNNgV/BLz0SsHOfCSoTgTG8ZTUmW7flwim
         kQFXV5PnxG8bybe6rsP+bOFvmXg+fevFrh35T6iSy2ZBXmLSv20H/PKqn4HSQYjLvhls
         uKJybsaTI+AWFjCEx/qEVz+wx2z6RZsso6FXHbOxtILpMU2JUOpNvS0LmMpy+TPXwDWZ
         vOFQ==
X-Gm-Message-State: AOAM533KdYxw+BYMV26g7UERyVgMR/9gDirbtbkOVIfNLgImHI7ZMbSq
        hQjzViWuoRJsiu9tkpDhtfWEVj4+LDKpmgdciQEeMg==
X-Google-Smtp-Source: ABdhPJzkZnpQTV5Qp77PgEJ34HsJPqCmVi+ZOVVGOe/uHLDMUs6H/ZfgHJrleyk4/1QDC55+WeC+DLC/a9G2zdhlXUE=
X-Received: by 2002:a25:c006:: with SMTP id c6mr16530910ybf.480.1633888161709;
 Sun, 10 Oct 2021 10:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <1633777076-17256-1-git-send-email-yangtiezhu@loongson.cn> <1633777076-17256-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1633777076-17256-2-git-send-email-yangtiezhu@loongson.cn>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Sun, 10 Oct 2021 19:49:11 +0200
Message-ID: <CAM1=_QT_vR5EZyt6kVVWHJi3rpervkiO4HRrpvRgh2sh6J7yrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, mips: Clean up config options about JIT
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 9, 2021 at 12:58 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> The config options MIPS_CBPF_JIT and MIPS_EBPF_JIT are useless, remove
> them in arch/mips/Kconfig, and then modify arch/mips/net/Makefile.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/Kconfig      | 9 ---------
>  arch/mips/net/Makefile | 6 +++---
>  2 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 38468f4..9b03c78 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1214,15 +1214,6 @@ config SYS_SUPPORTS_RELOCATABLE
>           The platform must provide plat_get_fdt() if it selects CONFIG_USE_OF
>           to allow access to command line and entropy sources.
>
> -config MIPS_CBPF_JIT
> -       def_bool y
> -       depends on BPF_JIT && HAVE_CBPF_JIT
> -
> -config MIPS_EBPF_JIT
> -       def_bool y
> -       depends on BPF_JIT && HAVE_EBPF_JIT
> -
> -
>  #
>  # Endianness selection.  Sufficiently obscure so many users don't know what to
>  # answer,so we try hard to limit the available choices.  Also the use of a
> diff --git a/arch/mips/net/Makefile b/arch/mips/net/Makefile
> index 95e8267..e3e6ae6 100644
> --- a/arch/mips/net/Makefile
> +++ b/arch/mips/net/Makefile
> @@ -1,10 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # MIPS networking code
>
> -obj-$(CONFIG_MIPS_EBPF_JIT) += bpf_jit_comp.o
> +obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
>
>  ifeq ($(CONFIG_32BIT),y)
> -        obj-$(CONFIG_MIPS_EBPF_JIT) += bpf_jit_comp32.o
> +        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
>  else
> -        obj-$(CONFIG_MIPS_EBPF_JIT) += bpf_jit_comp64.o
> +        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
>  endif
> --
> 2.1.0
>

Looks good to me.

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
