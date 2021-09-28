Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA941A6CE
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 06:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhI1ExQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 00:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbhI1ExN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 00:53:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82DEC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 21:51:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n18so19868326pgm.12
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dZ7svcOfc1Mg4E6W0TkdAY+GX+/S7r5iMq69pSypb8g=;
        b=CSEKbtYy1Vzd181zJyjtrj5HJx2x3gUxwkTieyptibzGgOK1cX014llDAMp7o5U7+i
         LKTqZaXtou9lJO3GU/R6gf4Hi06dRVAGKP9TAqr/Bdi0yZo3g/ejuMLEU+dtfuwiol5/
         JfsCGg5unM74Nqiap02TcVagIDWdceZtrRCLJM5c0/bd/Erc6Zo4ShvgPylLCJ3UR5Ub
         rI2D/LBVos+xHS/14xriumB7K57vm96KJmewHRchTqkKwP3N1KeVBt3b1+W3OJJiO3qO
         qQr0v9hAsE2QxtdXVaqqFQ82g10foOF6N8QP0UEhtWG3Gg7rWR2hjfMg5DKTTQG2nU08
         REhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dZ7svcOfc1Mg4E6W0TkdAY+GX+/S7r5iMq69pSypb8g=;
        b=TNP2jw4MHGittUI/Hn0lT6ICb6Q7zIBD7rGC49KEIWFpmlRXROwurqhFgVPPOhWwCL
         uUTFwqXU+UMdZ0oynSxPnAMzeo4F7q72GkXsy6To6XTpxnFfUP3wZg16bo5PjkOGa2Xp
         wAPgVa3pj5m8taRRaSSYZMPS+7H45L+ddqqiSEfzltQfee8nmHguAyX/LXkj1+iAFzxO
         zmqydIOhfyfKbHatClhkEI1l0twSyC+MX8IJdbGCYErn/FZF4VeJ1p8iehmorSs+ohws
         +2greE5rFSiDkKCCY6SdZg9AZEdt8G0aXKR7vtXNT1O7DmLZOxj49AEYvvyiJA8cNn/v
         UyxA==
X-Gm-Message-State: AOAM532qT1q1Aj5Va3SJYkX1UnmjuesWdOC/MSnorKtHkT1zqGd8BEBx
        9uFlRefz7Xkj4JSCpQ+4EOM=
X-Google-Smtp-Source: ABdhPJyvCKnxU7VR0eks1XWHK7xUn/uMn2wLTUlg1BS/nkXQK8kLEUd7kjo6lb/AlLdivjh2p4H5Qw==
X-Received: by 2002:a05:6a00:2309:b0:444:6be1:c499 with SMTP id h9-20020a056a00230900b004446be1c499mr3567332pfh.62.1632804694196;
        Mon, 27 Sep 2021 21:51:34 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id z65sm17210277pfc.30.2021.09.27.21.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 21:51:33 -0700 (PDT)
Date:   Tue, 28 Sep 2021 10:21:31 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf] samples: bpf: Fix vmlinux.h generation for XDP
 samples
Message-ID: <20210928045131.psoz6gjb3q3suxc6@apollo.localdomain>
References: <20210928041329.1735524-1-memxor@gmail.com>
 <CAEf4BzaCyCZoUGjY8_-+WUV6DMxHvcJLGLb+gYxZrA5YDwbU=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaCyCZoUGjY8_-+WUV6DMxHvcJLGLb+gYxZrA5YDwbU=w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 10:06:09AM IST, Andrii Nakryiko wrote:
> On Mon, Sep 27, 2021 at 9:16 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Generate vmlinux.h only from the in-tree vmlinux, and remove enum
> > declarations that would cause a build failure in case of version
> > mismatches.
> >
> > There are now two options when building the samples:
> > 1. Compile the kernel to use in-tree vmlinux for vmlinux.h
> > 2. Override VMLINUX_BTF for samples using something like this:
> >    make VMLINUX_BTF=/sys/kernel/btf/vmlinux -C samples/bpf
> >
> > This change was tested with relative builds, e.g. cases like:
> >  * make O=build -C samples/bpf
> >  * make KBUILD_OUTPUT=build -C samples/bpf
> >  * make -C samples/bpf
> >  * cd samples/bpf && make
> >
> > When a suitable VMLINUX_BTF is not found, the following message is
> > printed:
> > /home/kkd/src/linux/samples/bpf/Makefile:333: *** Cannot find a vmlinux
> > for VMLINUX_BTF at any of "  ./vmlinux", build the kernel or set
> > VMLINUX_BTF variable.  Stop.
> >
> > Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> > Fixes: 384b6b3bbf0d (samples: bpf: Add vmlinux.h generation support)
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  samples/bpf/Makefile                     | 13 ++++++-------
> >  samples/bpf/xdp_redirect_map_multi.bpf.c |  5 -----
> >  2 files changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index 4dc20be5fb96..a05130e91403 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -324,15 +324,9 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
> >
> >  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                           \
> >                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> > -                    ../../../../vmlinux                                \
> > -                    /sys/kernel/btf/vmlinux                            \
> > -                    /boot/vmlinux-$(shell uname -r)
> > +                    ./vmlinux
>
> isn't this relative to samples/bpf subdirectory, so shouldn't it be
> ../../vmlinux?
>

I was confused about this too; but it executes this when you call make:

# Trick to allow make to be run from this directory
all:
        $(MAKE) -C ../../ M=$(CURDIR) BPF_SAMPLES_PATH=$(CURDIR)

so it fails if the path isn't relative to kernel source root.

> >  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
> >
> > -ifeq ($(VMLINUX_BTF),)
> > -$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
> > -endif
> > -
>
> [...]

--
Kartikeya
