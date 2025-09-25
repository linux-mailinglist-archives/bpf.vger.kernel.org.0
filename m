Return-Path: <bpf+bounces-69721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981EEBA0165
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5828F4E5FF1
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D02E0936;
	Thu, 25 Sep 2025 14:54:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21062E0935
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812061; cv=none; b=QAolHwMuhJks24/IrjT81huWRhptFC0ngXEi94FCe7JrU+lm1FdnX2FGFfdQJfQ9W+7JExm1y5Adeji+mutezCHEw8bmknVqur7vu3gmrt6aMGS47NS9BDWgA27mrBFbSWe1J1IHN3v1l2cEAJItow+ONzG21a8n0vrcVEZctZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812061; c=relaxed/simple;
	bh=A8L0nf1gaVHlRy73qccu/s96Ug2C6l/YoMDis3HLE7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7fTdXByN87Kan5Lvh9xWiyO68hOGIhf1+kzeXJnLiMqGETgOwhRT/OUzysk4d9ZoNk8GthcN/omZKnGkYv9rNsHqurRoAcXYJf1nYggmDN1Rx9sNjevcek1hF0efFJEd0xefRZ7+AUpSAO17YhIsqaiW5mNfjIJh96+LJ1F6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so434928e0c.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 07:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812057; x=1759416857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD2PjoU5+JrVarPavyhlPC+IQxTgLRvH49Qucb6M/RI=;
        b=hUD2lWmqWexXSHc18oq/EGO5YUaM9vbTBhC466eD5V6G/aXWwLptclQ47Utg6YW+PU
         WueV99HJisiWrrRAWKTLbosN8bFu1hl7S9BK/1QqW/yO3zdO9V+Z20f2qSn9NZwbMx0Y
         /hDKM9pO7l/nH9Hdkfj/u7Yc7ztZ6bRizv5iypr7VMJtcpuZ7WFiC0ORNG1jp5xukpu6
         7QkFhuldOAy+qCk+uS8qZJi7GEoG7rhQ7yo2yFeN/NKIjHAZnX+sXZqekrN3pRwqy/6h
         /g4BqugEEEWTUJ79iC/m7xlVNVH/nn1O8IGMSHW3LrwM9TYL8aAHTjZZMwXeKVO1WGXi
         30xQ==
X-Gm-Message-State: AOJu0Yz+bgoFhDK1yztBaa1Y2ACGbfHNeFPCrXkF2G1SvuPB1na4gFg6
	/2plGba4f114JoZGUxX0n8sU5/cFbhjPLRM/grmqYryryWgA1EMtVNKQgbn8MRoc
X-Gm-Gg: ASbGncs+XPQ2l8izzRrBpJ1AaIaxPDavGhDD/VT+LbsfnlLx6veui0FMwFAupvXxsIw
	sN/ePGd8MSUC3EzCdW7PkFh5jde3llSMnFCGPYfc0W75RhdsqD5yRAgTpd+TmJa9x06nhGJuZ3k
	YTTFcatTvt4c76hhui/K62g0nYMXSBKhLJnfaLQ4xBuUjb1gHf+ThkuYMFiLvn2fD7zIJVFjPuP
	ryXWeEd7HAH/4VfuLozrZ/RVgoa2+a+sSiCmGh9+oUgjXoNvQVxj0gPv/2cC2zR9VUmZTxpSs4Y
	cb14uj2ZC29Akcn3JkkYpMPHTZ521ylEnEPODUYk8bv58RxMCYHkrecNvgeNqKaUIgf6tv+RdMY
	f6mrCVIVh/yK8WKBr1e0XO/xQOk/nUc7h7c1+H7h85HABnH+f9NjgMuj94MHE
X-Google-Smtp-Source: AGHT+IGlMD6Ck5ygGsarZWGsm4Be+m2ZLRAPbgFK99iajU/KnsaUbdzAjutx8rzUU/FXG/TguiVVXA==
X-Received: by 2002:a05:6122:d06:b0:530:7bd4:1761 with SMTP id 71dfb90a1353d-54bea300da3mr1678682e0c.11.1758812056505;
        Thu, 25 Sep 2025 07:54:16 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54beddd9839sm380867e0c.25.2025.09.25.07.54.15
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:54:16 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-59ebaa8ccd4so166136137.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 07:54:15 -0700 (PDT)
X-Received: by 2002:a05:6102:3ecb:b0:519:534a:6c24 with SMTP id
 ada2fe7eead31-5acd2161437mr1757410137.34.1758812055404; Thu, 25 Sep 2025
 07:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20211122144742.477787-1-memxor@gmail.com> <20211122144742.477787-2-memxor@gmail.com>
 <edac3822-cd29-f7c8-1ff1-182dde7a2c0b@linux-m68k.org>
In-Reply-To: <edac3822-cd29-f7c8-1ff1-182dde7a2c0b@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Sep 2025 16:54:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX07vgxYB30Y1dMpLD7Nd+P68qJi09U=gKu90NJdRN=FQ@mail.gmail.com>
X-Gm-Features: AS18NWB31Po2guVLZDWVrq0Dc_RKJlgZOykIikL1u-hMdoN6FuP3Y3ryaNuK43I
Message-ID: <CAMuHMdX07vgxYB30Y1dMpLD7Nd+P68qJi09U=gKu90NJdRN=FQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 12:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 22 Nov 2021, Kumar Kartikeya Dwivedi wrote:
> > Vinicius Costa Gomes reported [0] that build fails when
> > CONFIG_DEBUG_INFO_BTF is enabled and CONFIG_BPF_SYSCALL is disabled.
> > This leads to btf.c not being compiled, and then no symbol being present
> > in vmlinux for the declarations in btf.h. Since BTF is not useful
> > without enabling BPF subsystem, disallow this combination.
> >
> > However, theoretically disabling both now could still fail, as the
> > symbol for kfunc_btf_id_list variables is not available. This isn't a
> > problem as the compiler usually optimizes the whole register/unregister
> > call, but at lower optimization levels it can fail the build in linking
> > stage.
> >
> > Fix that by adding dummy variables so that modules taking address of
> > them still work, but the whole thing is a noop.
> >
> >  [0]: https://lore.kernel.org/bpf/20211110205418.332403-1-vinicius.gomes@intel.com
> >
> > Fixes: 14f267d95fe4 ("bpf: btf: Introduce helpers for dynamic BTF set registration")
> > Reported-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Thanks for your patch, which is now commit d9847eb8be3d895b ("bpf:
> Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL") in v5.16.
>
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -316,6 +316,7 @@ config DEBUG_INFO_BTF
> >       bool "Generate BTF typeinfo"
> >       depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
> >       depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
> > +     depends on BPF_SYSCALL
> >       help
> >         Generate deduplicated BTF type information from DWARF debug info.
> >         Turning this on expects presence of pahole tool, which will convert
>
> I wanted to run pahole on a kernel object file, but was greeted by an
> error message:
>
>      libbpf: failed to find '.BTF' ELF section in <foo>.o
>
> Then I discovered I could not enable CONFIG_DEBUG_INFO_BTF without also
> enabling BPF_SYSCALL, which looks totally unrelated to me.  So yes,
> there seems to be a use case for BTF without enabling the BPF subsystem.

On current kernels, the dependencies for DEBUG_INFO_BTF are:

    config DEBUG_INFO_BTF
            bool "Generate BTF type information"
            depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
            depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
            depends on PAHOLE_VERSION >= 116
            depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
            # pahole uses elfutils, which does not have support for
Hexagon relocations
            depends on !HEXAGON

Upon closer look, pahole (I have v1.25) works with CONFIG_DEBUG_INFO_BTF
disabled, as long as CONFIG_DEBUG_INFO_DWARF4 is enabled, which seems
a bit counter-intuitive...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

