Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF41B41A73C
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 07:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhI1Fpp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 01:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Fpo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 01:45:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED11C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 22:44:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so1289575pjb.1
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 22:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0I6ZcxSwHbhSqrhJ0LKugH1ZVSSeUVn5wfAkkOpYpMc=;
        b=Aelh93yGHKM/BB9YD2dpfeARoqVvKrm0Wy9nm0nr3X4bvjdLSae3iWfP2msyVANLuS
         UFDVATC8JK3cL5dW2hU6+6sNMP7OlI3nnxO5nbknZQBWBxHh4zsasXX6UVK0BF+4Skv6
         gMgLJWJeJtiBLFyGj9N1pyEsHcoHWKaVE4L7lOFMTuwiVU26xAEWRTn4/RjAnVZRYgXM
         Ffj2LTkuQAUIdl5/eJRq72erP7B8QwZ86IbbdtkXIvl6b4aBDSinSSJZ8ba50HixNf3k
         aV8ftsIpDSqpdFrIMZM78qSuIrQ5lXCWScyhCjBKevN2TQTBQMYy5fieVj3wQysLL9eE
         U0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0I6ZcxSwHbhSqrhJ0LKugH1ZVSSeUVn5wfAkkOpYpMc=;
        b=2KeoKyseNGa6BG3lEI/HHCLWpxfmP8s79lnQNflnQFMe8HyELBRm1iakpGbvn8Mkys
         Dn5wMFT6hC9tKsK26KuXtstFXX/0Iy3QTbbcDPeW4COlCgfXnGZypg2dxFE6NiiQ0NNj
         eoqbKnXTXywH3Utec9WIpv9GrwkbVzlCuf9gxbZSWpMAl1v7KOdajcY7W/1pFN1eECqF
         b6qgi0EoSmAJdQNXXjkNzCyA/33L2ENo0irSuLz0jcvcW3bDHvN1UCZbzFa/z6oYdxEc
         uD8Rd6Af/KdcstuSUCu7BPRhtFLVZBaPwKfnM/VCULyT5eXiPltyueQks0L1Wn6jreYo
         aeuw==
X-Gm-Message-State: AOAM530tnECyHr6rDLWg5zx3BIEeDTXQNC1MSMpLnTJsBzvk2uEbqdNK
        d3D5SvnOhI89+lylDwIM76A=
X-Google-Smtp-Source: ABdhPJxHZwXNxCCRn+YhDfUvG8oK9HslIM0qW9m0LBHIasVPuPHJX7s25DP+Ns7/GLACHQnDCLSJjQ==
X-Received: by 2002:a17:902:8547:b0:13d:ebc2:44ba with SMTP id d7-20020a170902854700b0013debc244bamr3292843plo.85.1632807845569;
        Mon, 27 Sep 2021 22:44:05 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id b126sm20440420pga.67.2021.09.27.22.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 22:44:05 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:14:02 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf] samples: bpf: Fix vmlinux.h generation for XDP
 samples
Message-ID: <20210928054402.ibsxgsia6cybfq4m@apollo.localdomain>
References: <20210928041329.1735524-1-memxor@gmail.com>
 <CAEf4BzaCyCZoUGjY8_-+WUV6DMxHvcJLGLb+gYxZrA5YDwbU=w@mail.gmail.com>
 <20210928045131.psoz6gjb3q3suxc6@apollo.localdomain>
 <CAEf4BzYOedEAXN0vCj0+seThLwkwv=e83KWDKkym7B9cE36yAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYOedEAXN0vCj0+seThLwkwv=e83KWDKkym7B9cE36yAQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 10:58:01AM IST, Andrii Nakryiko wrote:
> On Mon, Sep 27, 2021 at 9:51 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, Sep 28, 2021 at 10:06:09AM IST, Andrii Nakryiko wrote:
> > > On Mon, Sep 27, 2021 at 9:16 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > Generate vmlinux.h only from the in-tree vmlinux, and remove enum
> > > > declarations that would cause a build failure in case of version
> > > > mismatches.
> > > >
> > > > There are now two options when building the samples:
> > > > 1. Compile the kernel to use in-tree vmlinux for vmlinux.h
> > > > 2. Override VMLINUX_BTF for samples using something like this:
> > > >    make VMLINUX_BTF=/sys/kernel/btf/vmlinux -C samples/bpf
> > > >
> > > > This change was tested with relative builds, e.g. cases like:
> > > >  * make O=build -C samples/bpf
> > > >  * make KBUILD_OUTPUT=build -C samples/bpf
> > > >  * make -C samples/bpf
> > > >  * cd samples/bpf && make
> > > >
> > > > When a suitable VMLINUX_BTF is not found, the following message is
> > > > printed:
> > > > /home/kkd/src/linux/samples/bpf/Makefile:333: *** Cannot find a vmlinux
> > > > for VMLINUX_BTF at any of "  ./vmlinux", build the kernel or set
> > > > VMLINUX_BTF variable.  Stop.
> > > >
> > > > Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> > > > Fixes: 384b6b3bbf0d (samples: bpf: Add vmlinux.h generation support)
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  samples/bpf/Makefile                     | 13 ++++++-------
> > > >  samples/bpf/xdp_redirect_map_multi.bpf.c |  5 -----
> > > >  2 files changed, 6 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > > > index 4dc20be5fb96..a05130e91403 100644
> > > > --- a/samples/bpf/Makefile
> > > > +++ b/samples/bpf/Makefile
> > > > @@ -324,15 +324,9 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
> > > >
> > > >  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                           \
> > > >                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> > > > -                    ../../../../vmlinux                                \
> > > > -                    /sys/kernel/btf/vmlinux                            \
> > > > -                    /boot/vmlinux-$(shell uname -r)
> > > > +                    ./vmlinux
> > >
> > > isn't this relative to samples/bpf subdirectory, so shouldn't it be
> > > ../../vmlinux?
> > >
> >
> > I was confused about this too; but it executes this when you call make:
> >
> > # Trick to allow make to be run from this directory
> > all:
> >         $(MAKE) -C ../../ M=$(CURDIR) BPF_SAMPLES_PATH=$(CURDIR)
> >
> > so it fails if the path isn't relative to kernel source root.
>
> Hm... what if we do $(abspath ./vmlinux) here (and probably same for
> $(O) and $(KBUILD_OUTPUT) just in case those are relative as well,
> would that do the right thing here? The way it is right now it's

Yeah, that works. I'll send a v2.

> extremely confusing (and obviously ../../../../vmlinux never worked
> and we never knew that).
>

Indeed.

> >
> > > >  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
> > > >
> > > > -ifeq ($(VMLINUX_BTF),)
> > > > -$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
> > > > -endif
> > > > -
> > >
> > > [...]
> >
> > --
> > Kartikeya

--
Kartikeya
