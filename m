Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3C3A4B3F
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 01:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFKXfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKXfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 19:35:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74BFC061574
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 16:33:33 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e10so6572774ybb.7
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXe61u2BzqcYfp+5i1/aRck9fmGxpLMjtYbgxZyvQxA=;
        b=joxL7WXBRwGcj4Bu2GHqS90JShb1tKDxk94rc55JO+cpg5Pd/BWHnH++oItwoC1bw4
         5NeoUwHAp/GIfNT3ED9htBIaQc4Hq0QRmIGrhmNNqLUTbMT6H6mtG1eGFHzIiB99uLkN
         8LCqy0nhZIEoQTBfAMggeqeo5+Im7JM0DXdaK4lfzjFF0xHV8g/yjf9kvXycLjzYShsC
         8OdOTVY9IVNFaBWZ+7HZoF8huh4lqUUXSqNVLlfC1o3VZgbQaWZPfE+yEueGBFTfKfpT
         1ApTt8xoEqLDeG+BG21kdx6poiz3yyoJaEdCY9PIvTzUMyMSmkr2U+CzJu6YDHnOQFqi
         GWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXe61u2BzqcYfp+5i1/aRck9fmGxpLMjtYbgxZyvQxA=;
        b=MFON6Vlcn4sisYyrnu/05B1NrQ2mSoQR+H8TmVbP4rHE6v0/8zrA64/hrKuX35ctN9
         kWPzUibKT9CT/eIM9sDhT3dxrdBN5rh0mmVCew0Xz2d2ykOsaYqm06TD/ysKWnPx0fJl
         nA/VgESqt/LsXbAGCdUSKCpdkLkmF1bTV1OjJnFw563q8bz3M5jhIWcJ0qg58GvZz8hX
         X8yb//gbCxrEl72JNaxGHGF627LCNF3ZJx2LvNNvs1UFaGioJ3nTVeBL48uSBcy71rLa
         yKLHfsno9KmfhPfflcxPwBU4gJ9uFbbfIvX0oFcQaWIE6zSXD/WQ/kgs27tWQHqTpWNa
         3o/g==
X-Gm-Message-State: AOAM533W6tJwEzM+7mf27XsCZTf4Onys3bFJ+W8WN0niHHcyd8Dlo9Vd
        vmbaFdYwZ+eMNTjiItVmbUG286yG4u6kfHJsvUVN4bD4PEqECw==
X-Google-Smtp-Source: ABdhPJwBUUXCqa8ptHT8hXAyIPP87ffYah2CRLCKRVO7h+PqxNL2wmjOehg+fI1dSPJByCs8EdPMO/lkf/OXMJ9PcVw=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr8939840ybr.425.1623454412018;
 Fri, 11 Jun 2021 16:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210610161027.255372-1-lmb@cloudflare.com>
In-Reply-To: <20210610161027.255372-1-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Jun 2021 16:33:21 -0700
Message-ID: <CAEf4BzZDDuyybofAjxm8QG9VYFMGAF8gZ9g-rnoD1-8R_9LExw@mail.gmail.com>
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

On Thu, Jun 10, 2021 at 9:10 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> bpf2go is the Go equivalent of libbpf skeleton. The convention is that
> the compiled BPF is checked into the repository to facilitate distributing
> BPF as part of Go packages. To make this portable, bpf2go by default
> generates both bpfel and bpfeb variants of the C.
>
> Using bpf_tracing.h is inherently non-portable since the fields of
> struct pt_regs differ between platforms, so CO-RE can't help us here.
> The only way of working around this is to compile for each target
> platform independently. bpf2go can't do this by default since there
> are too many platforms.
>
> Define the various PT_... macros when no target can be determined and
> turn them into compilation failures. This works because bpf2go always
> compiles for bpf targets, so the compiler fallback doesn't kick in.
> Conditionally define __bpf_missing_target so that we can inject a
> more appropriate error message at build time. The user can then
> choose which platform to target explicitly.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 46 +++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index c0f3a26aa582..438174adb3f8 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -25,26 +25,35 @@
>         #define bpf_target_sparc
>         #define bpf_target_defined
>  #else
> -       #undef bpf_target_defined
> -#endif
>
>  /* Fall back to what the compiler says */
> -#ifndef bpf_target_defined

Hm... doesn't this auto-guessing based on host architecture defeats
your goal? You don't want bpf_tracing.h to guess the right set of
PT_REGS macros, no?

I thought you'll do something like

#ifndef bpf_target_guess
#define bpf_target_guess 1
#endif

#if !defined(bpf_target_defined) && bpf_target_guess

/* then try to use host architecture */

But I guess I'm missing something...

>  #if defined(__x86_64__)
>         #define bpf_target_x86
> +       #define bpf_target_defined
>  #elif defined(__s390__)
>         #define bpf_target_s390
> +       #define bpf_target_defined

btw, instead of having this zoo of bpf_target_<arch> and also
bpf_traget_defined, how about simplifying it to a single variable that
would contain the actual architecture:

#define BPF_TARGET_ARCH "s390"

And then do

#if BPF_TARGET_ARCH == "s390"
#elif BPF_TARGET_ARCH == "arm"
...
#else /* unknown bpf_target_arch or not defined */
_Pragma(...)
#endif

WDYT? We can eventually move away from weird-looking __TARGET_ARCH_x86
to just -DBPF_TARGET_ARCH=x86. We'll need to support __TARGET_ARCH_xxx
for backwards compatibility, but at least new use cases can be cleaner
and more meaningful.

>  #elif defined(__arm__)
>         #define bpf_target_arm
> +       #define bpf_target_defined
>  #elif defined(__aarch64__)
>         #define bpf_target_arm64
> +       #define bpf_target_defined
>  #elif defined(__mips__)
>         #define bpf_target_mips
> +       #define bpf_target_defined
>  #elif defined(__powerpc__)
>         #define bpf_target_powerpc
> +       #define bpf_target_defined
>  #elif defined(__sparc__)
>         #define bpf_target_sparc
> +       #define bpf_target_defined
> +#endif /* no compiler target */
> +
>  #endif
> +
> +#ifndef __bpf_target_missing
> +#define __bpf_target_missing "GCC error \"Must specify a target arch via __TARGET_ARCH_xxx\""

If you goal is to customize the error message, why not parameterize
the error message part only, not the "GCC error \"\"" part?

>  #endif
>
>  #if defined(bpf_target_x86)
> @@ -287,7 +296,7 @@ struct pt_regs;
>  #elif defined(bpf_target_sparc)
>  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({ (ip) = PT_REGS_RET(ctx); })
>  #define BPF_KRETPROBE_READ_RET_IP              BPF_KPROBE_READ_RET_IP
> -#else
> +#elif defined(bpf_target_defined)
>  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                                            \
>         ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
>  #define BPF_KRETPROBE_READ_RET_IP(ip, ctx)                                 \
> @@ -295,6 +304,35 @@ struct pt_regs;
>                           (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
>  #endif
>
> +#if !defined(bpf_target_defined)
> +
> +#define PT_REGS_PARM1(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_PARM2(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_PARM3(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_PARM4(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_PARM5(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_RET(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_FP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_RC(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_SP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_IP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +
> +#define PT_REGS_PARM1_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_PARM2_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_PARM3_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_PARM4_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_PARM5_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_RET_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_FP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_RC_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_SP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define PT_REGS_IP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })

nit: why ull suffix?

> +
> +#define BPF_KPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__bpf_target_missing); 0ull; })
> +#define BPF_KRETPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__bpf_target_missing); 0ull; })
> +
> +#endif /* !defined(bpf_target_defined) */
> +
>  #ifndef ___bpf_concat
>  #define ___bpf_concat(a, b) a ## b
>  #endif
> --
> 2.30.2
>
