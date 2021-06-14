Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9383A5F0D
	for <lists+bpf@lfdr.de>; Mon, 14 Jun 2021 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhFNJYT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Jun 2021 05:24:19 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40733 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJYT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Jun 2021 05:24:19 -0400
Received: by mail-lf1-f52.google.com with SMTP id k40so19984745lfv.7
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PfJELIBIReaJ9ogCnXjaaMHhML/e2xtA2OdG2dkSm0=;
        b=UpVZDHjdSQZxaeBcrYMUYuCy2HkiZsiugv5rldSKKv+IK0b2LjBFFjCqxqMb0uQ9a6
         WjcovZJ6d3oBl3fkJnsGSSmbr8h9QLCCqx5IwESNHNkdK7B36l6MG7BO8cIPiQt4hCPD
         5oicnkYR9bynWQEN1+x5Ekpv7PW+F3MpVFVI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PfJELIBIReaJ9ogCnXjaaMHhML/e2xtA2OdG2dkSm0=;
        b=B2uSjv5+0+/CgCJL3xgi8KYp4vqDxWnucO2iEUWVdLFNNWmaYOBzSfgmuu9YnbKzfy
         y32YZ6o9U13zthXqjZRFp9OuJLUINzDI+yXMk6tiPJAPkxHRThz7TvSZqtmmN6Y4hQa6
         Ms+K3ncXxD750WICFaJfdSzgRnhMnqgIFq89C7vMvQqnWQb8l/1XfMv/tiOvgcnQkhbi
         pTDZgGzf2S6+8vRvt4pDpWLEV3lLlBmBiJ73WxZpEL73duy+Wy1XGiEhRfDOCRbhWeDo
         QFGqqFM7gew06wjH49HMqifDCcxqVgWIp+CMmiFEq7/Hg2+TNpW96m2o28GivQzZ+dEE
         Itag==
X-Gm-Message-State: AOAM530PHOgKKyI834CKuxJNjSqkNWDX2FW8BOuwo8OT+5Px33E6p1J9
        ZNxi+at/mEbo4ixweqm6YJ6vJlvtaSleaEqPvthBDQ==
X-Google-Smtp-Source: ABdhPJxZtkEyoelN5TiAPYBPeqkQrw2QD4hi14e2B7Qj29SLiBuddsLMT0WtYXfRqkPWJvqVdikPyiED9oKfx2xlhqg=
X-Received: by 2002:a05:6512:2ea:: with SMTP id m10mr11627075lfq.325.1623662475147;
 Mon, 14 Jun 2021 02:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210610161027.255372-1-lmb@cloudflare.com> <CAEf4BzZDDuyybofAjxm8QG9VYFMGAF8gZ9g-rnoD1-8R_9LExw@mail.gmail.com>
In-Reply-To: <CAEf4BzZDDuyybofAjxm8QG9VYFMGAF8gZ9g-rnoD1-8R_9LExw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 14 Jun 2021 10:21:04 +0100
Message-ID: <CACAyw9-UbOD_H5=KfscPHzwOHL13nTUpojhtQnOTNJpTS-DVzQ@mail.gmail.com>
Subject: Re: [PATCH bpf] lib: bpf: tracing: fail compilation if target arch is missing
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 12 Jun 2021 at 00:33, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> Hm... doesn't this auto-guessing based on host architecture defeats
> your goal? You don't want bpf_tracing.h to guess the right set of
> PT_REGS macros, no?
>
> I thought you'll do something like
>
> #ifndef bpf_target_guess
> #define bpf_target_guess 1
> #endif
>
> #if !defined(bpf_target_defined) && bpf_target_guess
>
> /* then try to use host architecture */
>
> But I guess I'm missing something...

I understood that you didn't want new defines :D I'll rework the patch.

>
> >  #if defined(__x86_64__)
> >         #define bpf_target_x86
> > +       #define bpf_target_defined
> >  #elif defined(__s390__)
> >         #define bpf_target_s390
> > +       #define bpf_target_defined
>
> btw, instead of having this zoo of bpf_target_<arch> and also
> bpf_traget_defined, how about simplifying it to a single variable that
> would contain the actual architecture:
>
> #define BPF_TARGET_ARCH "s390"
>
> And then do
>
> #if BPF_TARGET_ARCH == "s390"
> #elif BPF_TARGET_ARCH == "arm"
> ...
> #else /* unknown bpf_target_arch or not defined */
> _Pragma(...)
> #endif
>
> WDYT? We can eventually move away from weird-looking __TARGET_ARCH_x86
> to just -DBPF_TARGET_ARCH=x86. We'll need to support __TARGET_ARCH_xxx
> for backwards compatibility, but at least new use cases can be cleaner
> and more meaningful.

Yeah that would be nice. I think the preprocessor doesn't understand
strings. So we'd have to use special integers (or more macros) or a
char. That doesn't seem nicer.

> > +#ifndef __bpf_target_missing
> > +#define __bpf_target_missing "GCC error \"Must specify a target arch via __TARGET_ARCH_xxx\""
>
> If you goal is to customize the error message, why not parameterize
> the error message part only, not the "GCC error \"\"" part?

Because _Pragma is annoying: it doesn't accept strings that get
concatenated via the preprocessor: _Pragma("GCC error \"" OTHER_DEFINE
"\"") gives me trouble. It's possible to avoid this via another macro
expansion though. Up to you.

>
> >  #endif
> >
> >  #if defined(bpf_target_x86)
> > @@ -287,7 +296,7 @@ struct pt_regs;
> >  #elif defined(bpf_target_sparc)
> >  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({ (ip) = PT_REGS_RET(ctx); })
> >  #define BPF_KRETPROBE_READ_RET_IP              BPF_KPROBE_READ_RET_IP
> > -#else
> > +#elif defined(bpf_target_defined)
> >  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                                            \
> >         ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
> >  #define BPF_KRETPROBE_READ_RET_IP(ip, ctx)                                 \
> > @@ -295,6 +304,35 @@ struct pt_regs;
> >                           (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
> >  #endif
> >
> > +#if !defined(bpf_target_defined)
> > +
> > +#define PT_REGS_PARM1(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_PARM2(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_PARM3(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_PARM4(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_PARM5(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_RET(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_FP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_RC(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_SP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_IP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +
> > +#define PT_REGS_PARM1_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_PARM2_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_PARM3_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_PARM4_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_PARM5_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_RET_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_FP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_RC_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_SP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> > +#define PT_REGS_IP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
>
> nit: why ull suffix?

Without it we sometimes get an integer cast warning, something about
an int to void* cast I think?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
