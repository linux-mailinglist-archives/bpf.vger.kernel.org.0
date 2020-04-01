Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60519B4DB
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbgDARrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 13:47:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33964 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbgDARrM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 13:47:12 -0400
Received: by mail-il1-f195.google.com with SMTP id t11so855275ils.1;
        Wed, 01 Apr 2020 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7f+oFGBz4lKq+gYaVg47iObMCSlHnFkkTWzFoO6ob70=;
        b=pVcU+dsHG+xi+OdTaXPlzb2fvjo47FLw/EUeR34ecopFZpovwEmAGBOR1KUyZ6G3vt
         7HV0y+QRQzVY8Lx9vEb6utqV7AIxezWlddf9ft4fmX5Kmh2JLVTeNtXRHVmARyhnmuR3
         UJgf3w8ZuSSFEoVmtaj+a8Ljkz7vkiaRdg4wU8DLrI/3J0hAKW+GYrXM97SQQHdbriVF
         WEh+cPxR92okd0nPKw7F/JfjrEds+3rxYkbsKM4th6lgFcURuC099Nk1SchXWqRMbUR7
         V0GwxUcl2onS7SY10WqEbxlm3r/0+MNuObBGG11nLve5x+q8mNj3NiN4ZrDYDoVpumib
         yrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7f+oFGBz4lKq+gYaVg47iObMCSlHnFkkTWzFoO6ob70=;
        b=eJV0+LUXjwgk3fXQNv1Vm/ENBar48MX0RxDEIjAB0FNJ3GnTGnqqwW2845Rk3GWmcY
         CQIH0WtyTTojx8kWXrNXNlMP6ynAf6OHyIdgf7TeqK/Q/Y33LVMShrDWUfKe0b3HBq6L
         Axh8Nd5vlpWxzgt6l2CNVRx5l3AVcRAwXT83YeGYZnOfq64Zkk69sM+OzPoLdSi2/71n
         Bq55325B0y1USOM5THts1yJiFXqSfJZuAIFPDY3hYKt80qNgLIFJNpWN5/B/1VGF0GIz
         HspyUnZEfw7PG5xr5my5KBuRVdB8/J3ix+pwB0pTecMSEQiRjodqTFnvrIzfD/TNoFki
         +HDA==
X-Gm-Message-State: ANhLgQ29zODoP0ogaYG0as+iHHvXYuGcbg1BM077Uqe6RPj4V7lx/UR3
        +q0kV31gwMtg3xmaWugvZZm8AOnhvpm4/Sd18v0=
X-Google-Smtp-Source: ADFU+vtcPRVHBDFXuLENFOQ1nGCShR+miCa33OMScUOHVZVQa44lyFKgZ0mNFPnw7ZGMLllXJbDU7a+zLtxmGrqTOGY=
X-Received: by 2002:a05:6e02:688:: with SMTP id o8mr20983373ils.156.1585763231060;
 Wed, 01 Apr 2020 10:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <202004010033.A1523890@keescook> <20200401142057.453892-1-slava@bacher09.org>
 <eba80d4e-a385-1fba-37f9-38888ae91f1e@bacher09.org>
In-Reply-To: <eba80d4e-a385-1fba-37f9-38888ae91f1e@bacher09.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Apr 2020 10:46:57 -0700
Message-ID: <CAEf4BzYx7hffHm5RV3QQQqvgAzy-41DRgFQDKh+4xcM9OL890A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 1, 2020 at 7:38 AM Slava Bacherikov <slava@bacher09.org> wrote:
>
>
>
> 01.04.2020 17:20, Slava Bacherikov wrotes:
> > Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> > enabled will produce invalid btf file, since gen_btf function in
> > link-vmlinux.sh script doesn't handle *.dwo files.
> >
> > Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
> > using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
> >
> > Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> > Reported-by: Jann Horn <jannh@google.com>
> > Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> > Acked-by: KP Singh <kpsingh@google.com>
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
> > ---
> >  lib/Kconfig.debug | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index f61d834e02fe..b94227be2d62 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -222,7 +222,9 @@ config DEBUG_INFO_DWARF4
> >
> >  config DEBUG_INFO_BTF
> >       bool "Generate BTF typeinfo"
> > -     depends on DEBUG_INFO
> > +     depends on DEBUG_INFO || COMPILE_TEST
> I had to add this, since DEBUG_INFO which depends on:
>
>         DEBUG_KERNEL && !COMPILE_TEST
>
> would block DEBUG_INFO_BTF when COMPILE_TEST is turned on.
>

Sorry if I'm being dense here. But what's the point in enabling
DEBUG_INFO_BTF if there is no *valid* DWARF info available for
DWARF-to-BTF conversion?


> In that case allyesconfig will emit both:
>
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_GCC_PLUGIN_RANDSTRUCT=y

Which I thought is exactly what we wanted to avoid. Not sure what's
the point of compiling kernel (even if it's the one that is not
supposed to ever run) that apriori has broken BTF? If it was
acceptable to not have DEBUG_INFO for COMPILE_TEST, why it's not
acceptable to not have DEBUG_INFO_BTF in that situation as well?

>
>
>
> > +     depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
> > +     depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
> >       help
> >         Generate deduplicated BTF type information from DWARF debug info.
> >         Turning this on expects presence of pahole tool, which will convert
> >
