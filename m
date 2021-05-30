Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B743A394EB9
	for <lists+bpf@lfdr.de>; Sun, 30 May 2021 02:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhE3AxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 May 2021 20:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhE3AxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 May 2021 20:53:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A328C061574
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 17:51:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g38so11115265ybi.12
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsdadOc/o3bBQHHWi2mFw60CIqfBgsnB0GTp5vorhhY=;
        b=VWXkTsud1jPD4IaDvSKhv7Yxeq9pYR/ZM6NBabKvEJWbCLngSuDYGGWIR98URJLWjn
         pG0SfYZgHVr2lqhgl25nXbGgUYKqsef4fy3p8VOusVWwJYqPObqMDkPTUsJBIZ/1AwMk
         SJMVRKqe4jmxeUWrwVccvl9YF8dubXUJvQ0JnNhl7Y51srxH/6Wd8SgUxZHFGPoTwW6P
         VG1bZsOMDPoXzgyAJbGmstMI9ozMVK//Nk0/mn2sJYb6JVk01L98M2ApcDtZGSRPi3lT
         LCAL5FChADR+8r/J9RRmxmMM1bnxxBQ+XQleeVfcM0Z/6mIoEqLYio64H/nQEkbryTtn
         rI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsdadOc/o3bBQHHWi2mFw60CIqfBgsnB0GTp5vorhhY=;
        b=OVbWbsChmLC45wWWiOZs9g3tC5KR91Gy5gm6lX0mmvLdenRECJFr3sbwdh2LoJ7qUQ
         yPY8YQc4JFq9vQgnPDx7NZXU+cOceJSMdmTzJothvzyQlLRdcsPy52GjDdtU7DDscTU/
         M3DJr+UtLtboU1WPuAjyNo7i2kBbvZMQpIGzOyLpiVBGN9ge4qyG+BHzPXQf1rcvGu0H
         vJMR2Ki9LfSTZ1dytQtctPwl8OzD1U9raG+NZh0XCX4iEjolMcs1jzM/A8ZAALqGmSWz
         /pIcTWTioPLwg09/1Vft504cspVFFK/udhbyZbr0w7x4T4RRe8J/SV7nE6JSuUmtYdKt
         ncOg==
X-Gm-Message-State: AOAM532QrzG1XdlrLK5vsCtgE1qP6WzchDOwFMWoU4wvVljfUib3AVEI
        q3TWXV5A1r2JpWB5g82yD3i3tqNUIhk38MubiUByrzWEhic=
X-Google-Smtp-Source: ABdhPJzaRDhloTDvpALCoq0d6zvPRTLQTO/m3UOBXrKa00Db+v73AjG3NrGPDFTkELEaB3ajtSNGdKQGXA+/sAm2zss=
X-Received: by 2002:a5b:286:: with SMTP id x6mr22861461ybl.347.1622335890657;
 Sat, 29 May 2021 17:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
 <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
 <CACAyw99QydcWBeE3T_4g5QzuDyfb_MEpR1V0EzEwbY=R-s202w@mail.gmail.com>
 <CAEf4BzZftL2q9qAoeXsO87-Wx9AbF8A1mLnBAtBrGo=XSx996g@mail.gmail.com> <CACAyw9-mHGrvrWozqngJ8X4qzqxB8Yku+AaL_Rv8RZhLXPRwJQ@mail.gmail.com>
In-Reply-To: <CACAyw9-mHGrvrWozqngJ8X4qzqxB8Yku+AaL_Rv8RZhLXPRwJQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 29 May 2021 17:51:19 -0700
Message-ID: <CAEf4BzYz19hg6H4jieEzZQR1e3R3OOkLBiQLzCxQM+=cvQTGow@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 28, 2021 at 1:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Wed, 26 May 2021 at 19:34, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > So I did a bit of investigation and gathered struct pt_regs
> > definitions from all the "supported" architectures in bpf_tracing.h.
> > I'll leave it here for further reference.
> >
> > static unsigned long bpf_pt_regs_parm1(const void *regs)
> > {
> >     if (___arch_is_x86)
> >         return ((struct pt_regs___x86 *)regs)->di;
> >     else if (___arch_is_s390)
> >         return ((struct pt_regs___s390 *)regs)->gprs[2];
> >     else if (___arch_is_powerpc)
> >         return ((struct pt_regs___powerpc *)regs)->gpr[3];
> >     else
> >         while(1); /* need some better way to force BPF verification failure */
> > }
> >
> > And so on for other architectures and other helpers, you should get
> > the idea from the above.
>
> The idea of basing this on unique fields in types is neat, the
> downside I see is that we encode the logic in the BPF bitstream. If in
> the future struct pt_regs is changed, code breaks and we can't do much

If pt_regs fields are renamed all PT_REGS-related stuff, provided by
libbpf in bpf_tracing.h will break as well and will require
re-compilation of BPF application. This piece of code is going to be
part of the same bpf_tracing.h, so if something changes in newer
kernel version, libbpf will accommodate that in the latest version.
You'd still need to re-compile your BPF application, but I don't see
how that's avoidable even with your proposal.

> about it. What if instead we replace ___arch_is_x86, etc. with a
> .kconfig style constant load? The platform detection logic can then
> live in libbpf or cilium/ebpf and can be evolved if needed. Instead of

That might be worthwhile to do (similarly to how we have a special
LINUX_KERNEL_VERSION extern) regardless. But again, detection of the
architecture is just one part. Once you know the architecture, you are
still relying on knowing pt_regs field names to extract the data. So
if anything changes about that, you'd need to update bpf_tracing.h and
re-compile.


> while(1) we could use an illegal function call, like we do for
> poisoned CORE relocations.

Yeah, I knew something like that should be possible with assembly, but
was too lazy to search for or invent it.

>
> >
> > As a shameless plug, if you'd like to see some more examples of using
> > CO-RE for detecting kernel features, see [0]
> >
> >   [0] https://nakryiko.com/posts/bpf-tips-printk/
> >
> > > > Well, obviously I'm not a fan of even more magic #defines. But I think
> > > > we can achieve a similar effect with a more "lazy" approach. I.e., if
> > > > user tries to use PT_REGS_xxx macros but doesn't specify the platform
> > > > -- only then it gets compilation errors. There is stuff in
> > > > bpf_tracing.h that doesn't need pt_regs, so we can't just outright do
> > > > #error unconditinally. But we can do something like this:
> > > >
> > > > #else /* !bpf_target_defined */
> > > >
> > > > #define PT_REGS_PARM1(x) _Pragma("GCC error \"blah blah something
> > > > user-facing\"")
> > > >
> > > > ... and so on for all macros
> > > >
> > > > #endif
> > > >
> > > > Thoughts?
> > >
> > > That would work for me, but it would change the behaviour for current
> > > users of the header, no? That's why I added the magic define in the
> > > first place.
> >
> > How so? If someone is using PT_REGS_PARM1 without setting target arch
> > they should get compilation error about undefined macro. Here it will
> > be the same thing, only if someone tries to use PT_REGS_PARM1() will
> > they reach that _Pragma.
> >
> > Or am I missing something?
>
> Right! Doing this makes sense regardless of the outcome of our discussion above.

Cool, feel free to send a patch with _Pragmas and no extra #defines ;)

>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
