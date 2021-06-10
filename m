Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB17C3A2DC1
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFJOMb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 10:12:31 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:44009 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJOMb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 10:12:31 -0400
Received: by mail-lf1-f46.google.com with SMTP id n12so3460783lft.10
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzmKas184833usYf8v0jhhrF9F4Gbsyk8OwV/MYiGYU=;
        b=UZLoa4rDrimW7rhq+NqdEVVIbZNv5NbROf+P0xqFYYCA0RFx09I8HuyALR0eqyLADN
         foYsyZhFemxKzd6tOc2RGrAw8qOEdhVEPD31Ez2YT9UYW5VuvXt4CLDMSs3GiIqbobTo
         hyOPbzeYBER3sEHtBhY/QEQo+Zy2QGNJr6fR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzmKas184833usYf8v0jhhrF9F4Gbsyk8OwV/MYiGYU=;
        b=h8x1xriP6ywuXjQoHc+prWBAxm5zDDA7JqLGkdhv2loctcHsPOmjRC2ajGTIw2hdgA
         oIfalCdNUv+20UdaT/LKcSSQGFlTlHh0lfmyJD/38I5fOyndKF0TCV3yc3o1TMZrzNw/
         RWOR3Sg8UpDF+2pjpHkOqOdw/O+jhlHI5ImFjP+MwyTPBg5PQAKUDKkNLH3SZH4ypF4m
         Jd36HUklpWJuTc3rmm62RkpF3pPqg5sU4QgzWPcOFXCyNFEkePIgh13L+I7aefKIJ1lr
         lL5l0HG3aIbVKQi397cd0TsjZr2V9KsIEjFtjqiYIH+dhQlSPnMOXAnAOkvLnXXATXSs
         H4ZA==
X-Gm-Message-State: AOAM530KlCTIQ392cBTH7DsXdp4bMZeSQ8ztcBetri4fWO3aGaU0JFto
        Pu7Sj5wTFc+2yZEbRcqBnm0IDvG2tXpTaGc1cEscdQ==
X-Google-Smtp-Source: ABdhPJzq6WZNss7mCtlubYmeguvAzkuO2hELiFE9HytwNYQpyECaL0cGO1QkWpauCLVdl6bBvuNFn+6LoJjWnCi1ImU=
X-Received: by 2002:ac2:4847:: with SMTP id 7mr1995521lfy.97.1623334174497;
 Thu, 10 Jun 2021 07:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
 <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
 <CACAyw99QydcWBeE3T_4g5QzuDyfb_MEpR1V0EzEwbY=R-s202w@mail.gmail.com>
 <CAEf4BzZftL2q9qAoeXsO87-Wx9AbF8A1mLnBAtBrGo=XSx996g@mail.gmail.com>
 <CACAyw9-mHGrvrWozqngJ8X4qzqxB8Yku+AaL_Rv8RZhLXPRwJQ@mail.gmail.com> <CAEf4BzYz19hg6H4jieEzZQR1e3R3OOkLBiQLzCxQM+=cvQTGow@mail.gmail.com>
In-Reply-To: <CAEf4BzYz19hg6H4jieEzZQR1e3R3OOkLBiQLzCxQM+=cvQTGow@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 10 Jun 2021 15:09:23 +0100
Message-ID: <CACAyw99m8rbE5L9LAowYwvAkza+twuet2tdas2eotsf3uWgGTQ@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 30 May 2021 at 01:51, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 28, 2021 at 1:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > On Wed, 26 May 2021 at 19:34, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > So I did a bit of investigation and gathered struct pt_regs
> > > definitions from all the "supported" architectures in bpf_tracing.h.
> > > I'll leave it here for further reference.
> > >
> > > static unsigned long bpf_pt_regs_parm1(const void *regs)
> > > {
> > >     if (___arch_is_x86)
> > >         return ((struct pt_regs___x86 *)regs)->di;
> > >     else if (___arch_is_s390)
> > >         return ((struct pt_regs___s390 *)regs)->gprs[2];
> > >     else if (___arch_is_powerpc)
> > >         return ((struct pt_regs___powerpc *)regs)->gpr[3];
> > >     else
> > >         while(1); /* need some better way to force BPF verification failure */
> > > }
> > >
> > > And so on for other architectures and other helpers, you should get
> > > the idea from the above.
> >
> > The idea of basing this on unique fields in types is neat, the
> > downside I see is that we encode the logic in the BPF bitstream. If in
> > the future struct pt_regs is changed, code breaks and we can't do much
>
> If pt_regs fields are renamed all PT_REGS-related stuff, provided by
> libbpf in bpf_tracing.h will break as well and will require
> re-compilation of BPF application.

I'm thinking more along the lines of, if a PT_REGS definition changes
so that the unique field isn't unique anymore. The BPF is still valid,
but the logic that determines the platform isn't.

> This piece of code is going to be
> part of the same bpf_tracing.h, so if something changes in newer
> kernel version, libbpf will accommodate that in the latest version.
> You'd still need to re-compile your BPF application, but I don't see
> how that's avoidable even with your proposal.
>
> > about it. What if instead we replace ___arch_is_x86, etc. with a
> > .kconfig style constant load? The platform detection logic can then
> > live in libbpf or cilium/ebpf and can be evolved if needed. Instead of
>
> That might be worthwhile to do (similarly to how we have a special
> LINUX_KERNEL_VERSION extern) regardless. But again, detection of the
> architecture is just one part. Once you know the architecture, you are
> still relying on knowing pt_regs field names to extract the data. So
> if anything changes about that, you'd need to update bpf_tracing.h and
> re-compile.

Yes. It'd be nice to fix that, but I don't see how to do that in a
generic fashion. So I'd deal with it when it happens.

> > > How so? If someone is using PT_REGS_PARM1 without setting target arch
> > > they should get compilation error about undefined macro. Here it will
> > > be the same thing, only if someone tries to use PT_REGS_PARM1() will
> > > they reach that _Pragma.
> > >
> > > Or am I missing something?
> >
> > Right! Doing this makes sense regardless of the outcome of our discussion above.
>
> Cool, feel free to send a patch with _Pragmas and no extra #defines ;)

I'll give it a shot.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
