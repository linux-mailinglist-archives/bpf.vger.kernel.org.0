Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B540041A720
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 07:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhI1F3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbhI1F3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 01:29:51 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C11C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 22:28:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v10so29155719ybq.7
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 22:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1be5GuyeQcY7Mkmy2Kjcem9/Kg64N37FjNduHkmYhrE=;
        b=GwydxRagiJtanSkDgyZjPwjp22rdyUyQ9wSHcVwlEaVyHZucMFkheaT8/dZ83rtpVg
         pngdhnCyLawbDs7TfiQvEHGl1b2eAVsX+26rQARqAL6GI5OtQfOKax9/yznZOdlo8d3z
         0LXsWlp9+4jCRvv4KOLVJw1Pf3dRvW18rFAW22UX0j7672ZMWPvylsRQVqLxDrx0U/Vv
         CZIqg0fHd2dcuw1B4u41wpeLsNUYh86IAdRNBYsQYuljc4LHCszKhs/YtXHFpssF3w1Z
         UVDeqQc1awc5E6dY6h2lIrv8qHrnLXMWA12nZB12twMGRc1lQ0aPa3nQobIVyP1hjDva
         KHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1be5GuyeQcY7Mkmy2Kjcem9/Kg64N37FjNduHkmYhrE=;
        b=kYSK/yiTR/oZMx6cuOgXB27npY4iN/f6OmYdvmvdL67Pe0sE9v/fgPUre9d4vzKFmB
         HFt1SpZ1VfIhpWFHm8SGrxOexAcbNS/anPsJOiKMmpac6U1rc2N/CFLNDVX8Fvt9tA0X
         hwCkhclBtmwvj9FWVy15fgRj+PAEKEJTYolzbZo4C6msQXCHhE+4LJ1mxOJ+QmFfzRWd
         +9rKfY2yJ5poVvD37BaZ70vVKPqwDOL+JYSIpy6BsPLiXcyxdM0PJf3nE/K56izPEYbi
         fUDc1Skp95rP27gocjTyv82Q4+PSgo+7uK83BjUeYvSkPy2xet24LKaiU0BCa+QiPpIL
         E08g==
X-Gm-Message-State: AOAM530rGlfK6mLIgsderNvX+rkRpo+hTL+M8iNVNV2VGIflVh5a/Abs
        nN7+x5abKzycqdN7yG8KBND0fCHwFGxessnte8w=
X-Google-Smtp-Source: ABdhPJyqJAmQ3VJ5SPnT7AQwfAx+vlG70Kb63vr4khY5Fa83634HNHo2sx2wO68CgOG7sE3MufKquia+k6zP+jpTrWo=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr4292014ybj.504.1632806892222;
 Mon, 27 Sep 2021 22:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210928041329.1735524-1-memxor@gmail.com> <CAEf4BzaCyCZoUGjY8_-+WUV6DMxHvcJLGLb+gYxZrA5YDwbU=w@mail.gmail.com>
 <20210928045131.psoz6gjb3q3suxc6@apollo.localdomain>
In-Reply-To: <20210928045131.psoz6gjb3q3suxc6@apollo.localdomain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Sep 2021 22:28:01 -0700
Message-ID: <CAEf4BzYOedEAXN0vCj0+seThLwkwv=e83KWDKkym7B9cE36yAQ@mail.gmail.com>
Subject: Re: [PATCH bpf] samples: bpf: Fix vmlinux.h generation for XDP samples
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 9:51 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Sep 28, 2021 at 10:06:09AM IST, Andrii Nakryiko wrote:
> > On Mon, Sep 27, 2021 at 9:16 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Generate vmlinux.h only from the in-tree vmlinux, and remove enum
> > > declarations that would cause a build failure in case of version
> > > mismatches.
> > >
> > > There are now two options when building the samples:
> > > 1. Compile the kernel to use in-tree vmlinux for vmlinux.h
> > > 2. Override VMLINUX_BTF for samples using something like this:
> > >    make VMLINUX_BTF=3D/sys/kernel/btf/vmlinux -C samples/bpf
> > >
> > > This change was tested with relative builds, e.g. cases like:
> > >  * make O=3Dbuild -C samples/bpf
> > >  * make KBUILD_OUTPUT=3Dbuild -C samples/bpf
> > >  * make -C samples/bpf
> > >  * cd samples/bpf && make
> > >
> > > When a suitable VMLINUX_BTF is not found, the following message is
> > > printed:
> > > /home/kkd/src/linux/samples/bpf/Makefile:333: *** Cannot find a vmlin=
ux
> > > for VMLINUX_BTF at any of "  ./vmlinux", build the kernel or set
> > > VMLINUX_BTF variable.  Stop.
> > >
> > > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Fixes: 384b6b3bbf0d (samples: bpf: Add vmlinux.h generation support)
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  samples/bpf/Makefile                     | 13 ++++++-------
> > >  samples/bpf/xdp_redirect_map_multi.bpf.c |  5 -----
> > >  2 files changed, 6 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > > index 4dc20be5fb96..a05130e91403 100644
> > > --- a/samples/bpf/Makefile
> > > +++ b/samples/bpf/Makefile
> > > @@ -324,15 +324,9 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_k=
ern.h
> > >
> > >  VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                      =
     \
> > >                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux) =
   \
> > > -                    ../../../../vmlinux                             =
   \
> > > -                    /sys/kernel/btf/vmlinux                         =
   \
> > > -                    /boot/vmlinux-$(shell uname -r)
> > > +                    ./vmlinux
> >
> > isn't this relative to samples/bpf subdirectory, so shouldn't it be
> > ../../vmlinux?
> >
>
> I was confused about this too; but it executes this when you call make:
>
> # Trick to allow make to be run from this directory
> all:
>         $(MAKE) -C ../../ M=3D$(CURDIR) BPF_SAMPLES_PATH=3D$(CURDIR)
>
> so it fails if the path isn't relative to kernel source root.

Hm... what if we do $(abspath ./vmlinux) here (and probably same for
$(O) and $(KBUILD_OUTPUT) just in case those are relative as well,
would that do the right thing here? The way it is right now it's
extremely confusing (and obviously ../../../../vmlinux never worked
and we never knew that).

>
> > >  VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATH=
S))))
> > >
> > > -ifeq ($(VMLINUX_BTF),)
> > > -$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_B=
TF_PATHS)")
> > > -endif
> > > -
> >
> > [...]
>
> --
> Kartikeya
