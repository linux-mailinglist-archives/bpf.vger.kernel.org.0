Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E6393EC7
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhE1Ibm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhE1Ibl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 04:31:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99143C061763
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 01:30:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e17so4188030lfb.2
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzDEL9Ib7npAFRzAe/yrT1XBR64hleNChurzA0bFiO8=;
        b=bupGHdhsoxKB1MV+ccYjEvRu5MBKqkqU/2/A85Uj/HNMdDPucit+4pxaIvYKxDfKP7
         39gaHqsCw3vmduKiPNVsuVCJYOzsYw5wRSIyFji4drGQRwtGXwdS3sgcfniRUWdRmuHI
         1vNmNVWxSE7O9wzPIIsh03/Z/eEKJ3+rH6K4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzDEL9Ib7npAFRzAe/yrT1XBR64hleNChurzA0bFiO8=;
        b=tax9YYtvekh3yJiQO7HRsRIK98D3dBIq0PiUkOtOr+xjy6t2vUvxcBcfeEOGSV22+7
         6Sddm6W1/EWSlDnE+2yn0EQWQIaA87+EhuH7BiesthkD1bJy4N7wR4nfWOnNgrEtgFZk
         54F62w/ytTPMzupl3Z44wqbGylHJYijVNN01S2aFn1Z0QJGeVXE1pX1IPONJVNX/3mBx
         ncIkuYHep1xIxaHeXSC2mp/BguatAmtHdh/T6IEUv/3S+ccvXeBXyxVzAd3yhkwHxjxz
         m4/4MAG+/1I9ebE8uMtTwPJFS9t7B8xS3ZNUN5gM7aJg+SR5A/oMVtDi6X1rcQyuuSMe
         vA2g==
X-Gm-Message-State: AOAM5320q3+tmEO4Oz1jP26QboxiviHZU8RAc5HL2lXnsKMj3s9LJ6kS
        Sf1DJSz5o6hBOq7j0jlrUWtHSirZ83se56XcTH3Gtw==
X-Google-Smtp-Source: ABdhPJwbwoHHIQP4rDgoXEBw+SXbTMOOzI8/d0bWM/xUAeXrZeKtzLwMUVCv2eJbEPfuZ996Omv+jmx+vxpD+Rd4pes=
X-Received: by 2002:ac2:5327:: with SMTP id f7mr658889lfh.171.1622190604829;
 Fri, 28 May 2021 01:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
 <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
 <CACAyw99QydcWBeE3T_4g5QzuDyfb_MEpR1V0EzEwbY=R-s202w@mail.gmail.com> <CAEf4BzZftL2q9qAoeXsO87-Wx9AbF8A1mLnBAtBrGo=XSx996g@mail.gmail.com>
In-Reply-To: <CAEf4BzZftL2q9qAoeXsO87-Wx9AbF8A1mLnBAtBrGo=XSx996g@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 28 May 2021 09:29:53 +0100
Message-ID: <CACAyw9-mHGrvrWozqngJ8X4qzqxB8Yku+AaL_Rv8RZhLXPRwJQ@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 May 2021 at 19:34, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> So I did a bit of investigation and gathered struct pt_regs
> definitions from all the "supported" architectures in bpf_tracing.h.
> I'll leave it here for further reference.
>
> static unsigned long bpf_pt_regs_parm1(const void *regs)
> {
>     if (___arch_is_x86)
>         return ((struct pt_regs___x86 *)regs)->di;
>     else if (___arch_is_s390)
>         return ((struct pt_regs___s390 *)regs)->gprs[2];
>     else if (___arch_is_powerpc)
>         return ((struct pt_regs___powerpc *)regs)->gpr[3];
>     else
>         while(1); /* need some better way to force BPF verification failure */
> }
>
> And so on for other architectures and other helpers, you should get
> the idea from the above.

The idea of basing this on unique fields in types is neat, the
downside I see is that we encode the logic in the BPF bitstream. If in
the future struct pt_regs is changed, code breaks and we can't do much
about it. What if instead we replace ___arch_is_x86, etc. with a
.kconfig style constant load? The platform detection logic can then
live in libbpf or cilium/ebpf and can be evolved if needed. Instead of
while(1) we could use an illegal function call, like we do for
poisoned CORE relocations.

>
> As a shameless plug, if you'd like to see some more examples of using
> CO-RE for detecting kernel features, see [0]
>
>   [0] https://nakryiko.com/posts/bpf-tips-printk/
>
> > > Well, obviously I'm not a fan of even more magic #defines. But I think
> > > we can achieve a similar effect with a more "lazy" approach. I.e., if
> > > user tries to use PT_REGS_xxx macros but doesn't specify the platform
> > > -- only then it gets compilation errors. There is stuff in
> > > bpf_tracing.h that doesn't need pt_regs, so we can't just outright do
> > > #error unconditinally. But we can do something like this:
> > >
> > > #else /* !bpf_target_defined */
> > >
> > > #define PT_REGS_PARM1(x) _Pragma("GCC error \"blah blah something
> > > user-facing\"")
> > >
> > > ... and so on for all macros
> > >
> > > #endif
> > >
> > > Thoughts?
> >
> > That would work for me, but it would change the behaviour for current
> > users of the header, no? That's why I added the magic define in the
> > first place.
>
> How so? If someone is using PT_REGS_PARM1 without setting target arch
> they should get compilation error about undefined macro. Here it will
> be the same thing, only if someone tries to use PT_REGS_PARM1() will
> they reach that _Pragma.
>
> Or am I missing something?

Right! Doing this makes sense regardless of the outcome of our discussion above.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
