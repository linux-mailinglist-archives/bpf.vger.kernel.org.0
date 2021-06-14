Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE543A7275
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 01:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFNX3n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Jun 2021 19:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFNX3n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Jun 2021 19:29:43 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3050C061574
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 16:27:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p184so17772115yba.11
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 16:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3APGpER8oTg2MptzJWlXp918LdVMWv12aiP1ctOnCA=;
        b=aL2jmXdggVG/V4ZgTwWpp+P9xEQsMwCs69fwm8BksejH9hwGU934kFqplxlLRuSp+H
         INcQHQyMHtw3i0BY9Rf+Ama5T17/NZ/xkp5oiEsVhUaA4Ofgx9jXA5w0VImZG3U8VT0l
         tob9/fp9t4RMWiUzbiTjp8spBb0SRdDM6dC/06vBTx91KfqyttmPeGuodZ/u2xYWBfIk
         2HZCvoFuwOc/vxioirVZv6uWoJPCq06lQe+FYkoTN0bvjsnv5dVSeBfWggepaPi6vLQp
         e7hrbpLfI1bdrrRARXMRZ84EMv64a+LjlTRoCYu3D6w0IuNjXsVuOX0sf2/LIRrSDC4b
         jjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3APGpER8oTg2MptzJWlXp918LdVMWv12aiP1ctOnCA=;
        b=fCK8THTaueyyB1M6ttmwxKJbcMBV6hd19KtAnmyXwbuyBy8pv0AmExzOYQQkdGoYr+
         3Za8j+elo/wx865go9cGvCtfxThDJMim7IrFSz6Or4bydMpGjmp9MaUrXgA2cB5cHbc/
         ScHgMMEDX2ZgTFG42Q3z3gzh46izLa4WnpANgCB3L2YtAMl+ZK1vyvhMFlfjMgc3pHqW
         GPw2ZimC2YUhlobr4y66evhnxghW7J8+0gM/C8LXi0iiktF/s5vO0+SlsQ6NF/ReT/QH
         59An9yAc6zsmPCYNgFjJS2cdVHYuZU2OewJa06+GJulcc6rjAcT5kTa8iPVjU95Vcbt5
         Y4MA==
X-Gm-Message-State: AOAM530bxGPHlAAgoFILxe9mB4PhtYpNk3NdbnnNCPI7h31wmkbwAexa
        j/edhieY6OGQPN/gZWOhArC/qCcJZ55dlZcf3+M=
X-Google-Smtp-Source: ABdhPJww8kG8VEeEAMl63YhTOad9NPtdWY46Wi3Mp26MQECInInHfnPXt9+6T1P68jk1zfMchk9BiUYb2Inqph/sKSo=
X-Received: by 2002:a25:4182:: with SMTP id o124mr27151001yba.27.1623713240300;
 Mon, 14 Jun 2021 16:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210610161027.255372-1-lmb@cloudflare.com> <CAEf4BzZDDuyybofAjxm8QG9VYFMGAF8gZ9g-rnoD1-8R_9LExw@mail.gmail.com>
 <CACAyw9-UbOD_H5=KfscPHzwOHL13nTUpojhtQnOTNJpTS-DVzQ@mail.gmail.com>
In-Reply-To: <CACAyw9-UbOD_H5=KfscPHzwOHL13nTUpojhtQnOTNJpTS-DVzQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Jun 2021 16:27:09 -0700
Message-ID: <CAEf4BzbFhGkRi0YSa0pB+2SFYtJKXLEVKx=hQpVbBO_D4KUjtQ@mail.gmail.com>
Subject: Re: [PATCH bpf] lib: bpf: tracing: fail compilation if target arch is missing
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 14, 2021 at 2:21 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Sat, 12 Jun 2021 at 00:33, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > Hm... doesn't this auto-guessing based on host architecture defeats
> > your goal? You don't want bpf_tracing.h to guess the right set of
> > PT_REGS macros, no?
> >
> > I thought you'll do something like
> >
> > #ifndef bpf_target_guess
> > #define bpf_target_guess 1
> > #endif
> >
> > #if !defined(bpf_target_defined) && bpf_target_guess
> >
> > /* then try to use host architecture */
> >
> > But I guess I'm missing something...
>
> I understood that you didn't want new defines :D I'll rework the patch.

It doesn't seem avoidable. But I'm surprised you are satisfied with
your patch, it doesn't seem to solve your problem, because you'll
never trigger those _Pragmas as you'll just fallback to using your
host architecture. Isn't that right? How did you test your patch?

>
> >
> > >  #if defined(__x86_64__)
> > >         #define bpf_target_x86
> > > +       #define bpf_target_defined
> > >  #elif defined(__s390__)
> > >         #define bpf_target_s390
> > > +       #define bpf_target_defined
> >
> > btw, instead of having this zoo of bpf_target_<arch> and also
> > bpf_traget_defined, how about simplifying it to a single variable that
> > would contain the actual architecture:
> >
> > #define BPF_TARGET_ARCH "s390"
> >
> > And then do
> >
> > #if BPF_TARGET_ARCH == "s390"
> > #elif BPF_TARGET_ARCH == "arm"
> > ...
> > #else /* unknown bpf_target_arch or not defined */
> > _Pragma(...)
> > #endif
> >
> > WDYT? We can eventually move away from weird-looking __TARGET_ARCH_x86
> > to just -DBPF_TARGET_ARCH=x86. We'll need to support __TARGET_ARCH_xxx
> > for backwards compatibility, but at least new use cases can be cleaner
> > and more meaningful.
>
> Yeah that would be nice. I think the preprocessor doesn't understand
> strings. So we'd have to use special integers (or more macros) or a
> char. That doesn't seem nicer.

Yeah, somehow reading some online docs I got the impression that
strings are supported, but you are right, it doesn't seem like they
are :( Never mind then.

>
> > > +#ifndef __bpf_target_missing
> > > +#define __bpf_target_missing "GCC error \"Must specify a target arch via __TARGET_ARCH_xxx\""
> >
> > If you goal is to customize the error message, why not parameterize
> > the error message part only, not the "GCC error \"\"" part?
>
> Because _Pragma is annoying: it doesn't accept strings that get
> concatenated via the preprocessor: _Pragma("GCC error \"" OTHER_DEFINE
> "\"") gives me trouble. It's possible to avoid this via another macro
> expansion though. Up to you.

argh... that's fine, let's leave it as is

>
> >
> > >  #endif
> > >
> > >  #if defined(bpf_target_x86)
> > > @@ -287,7 +296,7 @@ struct pt_regs;
> > >  #elif defined(bpf_target_sparc)
> > >  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({ (ip) = PT_REGS_RET(ctx); })
> > >  #define BPF_KRETPROBE_READ_RET_IP              BPF_KPROBE_READ_RET_IP
> > > -#else
> > > +#elif defined(bpf_target_defined)
> > >  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                                            \
> > >         ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
> > >  #define BPF_KRETPROBE_READ_RET_IP(ip, ctx)                                 \
> > > @@ -295,6 +304,35 @@ struct pt_regs;
> > >                           (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
> > >  #endif
> > >
> > > +#if !defined(bpf_target_defined)
> > > +
> > > +#define PT_REGS_PARM1(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_PARM2(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_PARM3(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_PARM4(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_PARM5(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_RET(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_FP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_RC(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_SP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_IP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +
> > > +#define PT_REGS_PARM1_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_PARM2_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_PARM3_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_PARM4_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_PARM5_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_RET_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_FP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_RC_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_SP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > > +#define PT_REGS_IP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> >
> > nit: why ull suffix?
>
> Without it we sometimes get an integer cast warning, something about
> an int to void* cast I think?

hmm.. ok

>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
