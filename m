Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23F9467FDF
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 23:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353969AbhLCWYE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 17:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353945AbhLCWYE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 17:24:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F61C061751;
        Fri,  3 Dec 2021 14:20:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id np3so3345185pjb.4;
        Fri, 03 Dec 2021 14:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yL7RKkkwc77P9ncxY65Uf0b3dLn3VOdzIJznqDCTPWw=;
        b=LZy58+s7rxrkEbEGW3TafumF64IqxWDPFctiglxc+jUx3+1G0B4laet8osfwgUwcjc
         HwsMk4woSPoiALAvldcda56uP3ff2s0n4nZii7zaTA8la/EgNoHVqG9Loegd246pCqte
         +LE2q28fjY+zNeXolnz1IHCJCcn59Rrpk2mgHvb0ylStt/WI4ao6gnqJ0gpL3wYcu5/v
         IfDB7LWNLS2NkpBJfx39n6rlbY0GyLSRsKfcsoBEH/IGR/YDO8apQVgTPjN8KP6pOl6p
         dqWTn4j0ujtmX25jvm0M2nCAzwOAzwtxN+ptbyOaOUNdvA9zfuk5NUhbP4LKY5z1exER
         dL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yL7RKkkwc77P9ncxY65Uf0b3dLn3VOdzIJznqDCTPWw=;
        b=imLIXhgDFw9o/e1sXqBlnBcD3loUasDjcrOafQ22G8exyRfp6VbVFoRDsmoH77ZjeT
         fQn2qo04pcDJFDyZ3C6P4qS9HelYpCB6QMmecXaYyFG8iFC/dp23py8A22Q7HYDI1LOY
         uJvwjczvK2yiCl10rQzVyxrK1KlQ/SQ86X4qDZoRXPJKITtPX4eBFWCIW3lKxOkbksWo
         FEWtdesahDPy27EhaaxxKYZfGkpk+BJZNKZNEYdxZeRHocY9sZwg6RCWCLVMpZstOdZT
         ya3ry1hauJlOjlruuzJcQmlFarQPSo12hM9N9G/S/OwWYYvhDwEMxSABgWrkHAO9gPCx
         lzzw==
X-Gm-Message-State: AOAM532ONqLHnw0iFyMk3nTQYw/LVHKIZLwojig9eBhjVnPTRISjVAhx
        Pj1lqRd9utF0+ADrHyryVgs2gTZVf3CBWduCRBU=
X-Google-Smtp-Source: ABdhPJw7bvGYNsMeqCLbvqAR+CPiJoEle+OS9gtDGiea6s+tmZBMv7XPh7qzMOkyUAINI2Htp6c/ZRnyZAGz4uXmgTA=
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr17403831pjb.62.1638570039613;
 Fri, 03 Dec 2021 14:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
 <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
 <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
 <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com> <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
In-Reply-To: <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Dec 2021 14:20:28 -0800
Message-ID: <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
To:     Luca Boccassi <bluca@debian.org>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 2:06 PM Luca Boccassi <bluca@debian.org> wrote:
>
> On Fri, 2021-12-03 at 11:37 -0800, Alexei Starovoitov wrote:
> > On Fri, Dec 3, 2021 at 11:36 AM Matteo Croce
> > <mcroce@linux.microsoft.com> wrote:
> > >
> > > On Fri, Dec 3, 2021 at 8:22 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce
> > > > <mcroce@linux.microsoft.com> wrote:
> > > > >
> > > > > From: Matteo Croce <mcroce@microsoft.com>
> > > > >
> > > > > This series add signature verification for BPF files.
> > > > > The first patch implements the signature validation in the
> > > > > kernel,
> > > > > the second patch optionally makes the signature mandatory,
> > > > > the third adds signature generation to bpftool.
> > > >
> > > > Matteo,
> > > >
> > > > I think I already mentioned that it's no-go as-is.
> > > > We've agreed to go with John's suggestion.
> > >
> > > Hi,
> > >
> > > my previous attempt was loading a whole ELF file and parsing it in
> > > kernel.
> > > In this series I just validate the instructions against a
> > > signature,
> > > as with kernel CO-RE libbpf doesn't need to mangle it.
> > >
> > > Which suggestion? I think I missed this one..
> >
> > This talk and discussion:
> > https://linuxplumbersconf.org/event/11/contributions/947/
>
> Thanks for the link - but for those of us who don't have ~5 hours to
> watch a video recording, would you mind sharing a one line summary,
> please? Is there an alternative patch series implementing BPF signing
> that you can link us so that we can look at it? Just a link or
> googlable reference would be more than enough.

It's not 5 hours and you have to read slides and watch
John's presentation to follow the conversation.
