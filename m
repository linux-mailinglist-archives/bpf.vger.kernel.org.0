Return-Path: <bpf+bounces-28494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5BE8BA6D8
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 08:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050BD1C21E70
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 06:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191F139CEB;
	Fri,  3 May 2024 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILUzc4ZA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD61C6BD
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716345; cv=none; b=Vxp9/3wumNJGym1lw1FSA+qY6XU5V8vNrN8cmdv7eSxrnEHdkzNALn6kn6iFWK3OPV4dNf2lm4nXZkDTzYDPOQE5PHublo43ZQLhKOObPhMRT++H7T3c2nd5M+R5SotZR/6kk8j6JmPjmIfZoATbdL7K5AwPs6lXVAwP7GXFixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716345; c=relaxed/simple;
	bh=IZVSp4T+vgkCe5/9/M0AqWrE7N4qs0E0mExBpBbRhdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRxuuObeM0uLGvJoMWjoTCVwqREPZWGRzYUZbCyJNu/Pwc59S+uQSWApOgi6b2EkiOQVFtPHFzJbkf7hBqWRlEpjb3+JRHcduSh/1+JAnnNdoMZM26ccrnWBidAlh1gsC+BeYH3Bv31LLyUHwxeKWQBRwkjTO9Tx8kYzjX91wc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILUzc4ZA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5200afe39eso1087629466b.1
        for <bpf@vger.kernel.org>; Thu, 02 May 2024 23:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714716341; x=1715321141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY/8E2S9XmGkb/flRWRXUOsLUw7BWi5mHAPpxQlI8Vg=;
        b=ILUzc4ZA2JutpLku4b+PpmMq2bBMU+XW+EebeHQmieixry2lGLswK32HIwGKOOqlRd
         tkCGhgxSDX8hHcXxBkL31L2Vf1wAdTEmpBmJNsz6LMnd4R3n+tUMpM3Ep0Kj3NWKm7A5
         pDgtPzYESwJTztCUpwX8AqEM4Zv3wgN99x/oeNhFMXWlq2aDiiEr6mp4xdr2dnficNyj
         RPtIx2LrVCY42eiBmH2TTMZh11iTwo4EjbnjUZZiwU4eH81OOG303aK0MC7QkSihlb4l
         2NAOQm2SycyZlz5w5smAX5jMBKGh1uL3c3PxtrIupVEACA0YpAf9WfqMEZycVROxoPDc
         4PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714716341; x=1715321141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iY/8E2S9XmGkb/flRWRXUOsLUw7BWi5mHAPpxQlI8Vg=;
        b=qOqbs5rkzIZkcrI68AD0RG+zfjV9XWBx85TGBn3yA5ziCGa1uWyWfE6xtyI1ptcfaY
         fr2slhNk3CTmsq1nYSmeAbR0UodqUFhmahNu/B5+Cj1wkcJg2wPYTTFDJ3GYUEP1XjX4
         g92YZOSkDcjrb0kflzN5IxHrPGIjTIK6Y6sUGsKcF4owk2WPFjhCrzzzNVpJKiIvWVQo
         dmObPnBbzS40QK3O3IAjf/cUzr+suwKtVsrGhFQ4aj1FZOGOCU6EApI1lWouZLZ8vPVA
         2iLxCqb2jE4LBYYG2R6aiegIWQvckGpJMX8dtjrVWuG+TOyvR9iF+Q4nsjjGd1sQ1DbK
         UeXA==
X-Gm-Message-State: AOJu0YxTCNClWSNKMlhL3P/fJlVgSHw/WguhrzYYgKn6DVjSi2KBjd0d
	FFV6Hq+gzd1+zBDO+VOY5dSik2h1kNDQ0J+ltVxxGoGRWEdIwWUJmrpojj8bZJdLj2DWOK/hagK
	UoSTNZFjwSBRLzA7+jOT+Tdq7OBFrPg==
X-Google-Smtp-Source: AGHT+IEairvG4CywHOpSEcmW9hbUjN+5cy7RzvgWEzmorV2i778mnl3b7j3NgjGYZPzxBxNWfBzPg1mcfCXPPzoFJtc=
X-Received: by 2002:a17:906:c7d7:b0:a58:828b:a4a6 with SMTP id
 dc23-20020a170906c7d700b00a58828ba4a6mr1408501ejb.73.1714716341249; Thu, 02
 May 2024 23:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502170925.3194-1-jose.marchesi@oracle.com>
In-Reply-To: <20240502170925.3194-1-jose.marchesi@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 May 2024 23:05:27 -0700
Message-ID: <CAEf4BzaWaggGZCW4mCA53Sa7xiVARNk1taONaK0gL72x6B=mtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2] bpf: avoid casts from pointers to enums in bpf_tracing.h
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 10:09=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>  [Differences from V1:
>   - Do not introduce a global typedef, as this is a public header.
>   - Keep the void* casts in BPF_KPROBE_READ_RET_IP and
>     BPF_KRETPROBE_READ_RET_IP, as these are necessary
>     for converting to a const void* argument of
>     bpf_probe_read_kernel.]
>
> The BPF_PROG, BPF_KPROBE and BPF_KSYSCALL macros defined in
> tools/lib/bpf/bpf_tracing.h use a clever hack in order to provide a
> convenient way to define entry points for BPF programs as if they were
> normal C functions that get typed actual arguments, instead of as
> elements in a single "context" array argument.
>
> For example, PPF_PROGS allows writing:
>
>   SEC("struct_ops/cwnd_event")
>   void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
>   {
>         bbr_cwnd_event(sk, event);
>         dctcp_cwnd_event(sk, event);
>         cubictcp_cwnd_event(sk, event);
>   }
>
> That expands into a pair of functions:
>
>   void ____cwnd_event (unsigned long long *ctx, struct sock *sk, enum tcp=
_ca_event event)
>   {
>         bbr_cwnd_event(sk, event);
>         dctcp_cwnd_event(sk, event);
>         cubictcp_cwnd_event(sk, event);
>   }
>
>   void cwnd_event (unsigned long long *ctx)
>   {
>         _Pragma("GCC diagnostic push")
>         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")
>         return ____cwnd_event(ctx, (void*)ctx[0], (void*)ctx[1]);
>         _Pragma("GCC diagnostic pop")
>   }
>
> Note how the 64-bit unsigned integers in the incoming CTX get casted
> to a void pointer, and then implicitly converted to whatever type of
> the actual argument in the wrapped function.  In this case:
>
>   Arg1: unsigned long long -> void * -> struct sock *
>   Arg2: unsigned long long -> void * -> enum tcp_ca_event
>
> The behavior of GCC and clang when facing such conversions differ:
>
>   pointer -> pointer
>
>     Allowed by the C standard.
>     GCC: no warning nor error.
>     clang: no warning nor error.
>
>   pointer -> integer type
>
>     [C standard says the result of this conversion is implementation
>      defined, and it may lead to unaligned pointer etc.]
>
>     GCC: error: integer from pointer without a cast [-Wint-conversion]
>     clang: error: incompatible pointer to integer conversion [-Wint-conve=
rsion]
>
>   pointer -> enumerated type
>
>     GCC: error: incompatible types in assigment (*)
>     clang: error: incompatible pointer to integer conversion [-Wint-conve=
rsion]
>
> These macros work because converting pointers to pointers is allowed,
> and converting pointers to integers also works provided a suitable
> integer type even if it is implementation defined, much like casting a
> pointer to uintptr_t is guaranteed to work by the C standard.  The
> conversion errors emitted by both compilers by default are silenced by
> the pragmas.
>
> However, the GCC error marked with (*) above when assigning a pointer
> to an enumerated value is not associated with the -Wint-conversion
> warning, and it is not possible to turn it off.
>
> This is preventing building the BPF kernel selftests with GCC.
>
> This patch fixes this by avoiding intermediate casts to void*,
> replaced with casts to `unsigned long long', which is an integer type
> capable of safely store a BPF pointer, much like the standard
> uintptr_t.
>
> Testing performed in bpf-next master:
>   - vmtest.sh -- ./test_verifier
>   - vmtest.sh -- ./test_progs
>   - make M=3Dsamples/bpf
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> ---
>  tools/lib/bpf/bpf_tracing.h | 84 +++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 35 deletions(-)
>

[...]

>  /* If kernel doesn't have CONFIG_ARCH_HAS_SYSCALL_WRAPPER, we have to BP=
F_CORE_READ from pt_regs */
>  #define ___bpf_syswrap_args0()           ctx
> -#define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (void *=
)PT_REGS_PARM1_CORE_SYSCALL(regs)
> -#define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (vo=
id *)PT_REGS_PARM2_CORE_SYSCALL(regs)
> -#define ___bpf_syswrap_args3(x, args...) ___bpf_syswrap_args2(args), (vo=
id *)PT_REGS_PARM3_CORE_SYSCALL(regs)
> -#define ___bpf_syswrap_args4(x, args...) ___bpf_syswrap_args3(args), (vo=
id *)PT_REGS_PARM4_CORE_SYSCALL(regs)
> -#define ___bpf_syswrap_args5(x, args...) ___bpf_syswrap_args4(args), (vo=
id *)PT_REGS_PARM5_CORE_SYSCALL(regs)
> -#define ___bpf_syswrap_args6(x, args...) ___bpf_syswrap_args5(args), (vo=
id *)PT_REGS_PARM6_CORE_SYSCALL(regs)
> -#define ___bpf_syswrap_args7(x, args...) ___bpf_syswrap_args6(args), (vo=
id *)PT_REGS_PARM7_CORE_SYSCALL(regs)
> +#define ___bpf_syswrap_args1(x) \
> +       ___bpf_syswrap_args0(), (unsigned long long)PT_REGS_PARM1_CORE_SY=
SCALL(regs)
> +#define ___bpf_syswrap_args2(x, args...) \
> +       ___bpf_syswrap_args1(args), (unsigned long long)PT_REGS_PARM2_COR=
E_SYSCALL(regs)
> +#define ___bpf_syswrap_args3(x, args...) \
> +       ___bpf_syswrap_args2(args), (unsigned long long)PT_REGS_PARM3_COR=
E_SYSCALL(regs)
> +#define ___bpf_syswrap_args4(x, args...) \
> +       ___bpf_syswrap_args3(args), (unsigned long long)PT_REGS_PARM4_COR=
E_SYSCALL(regs)
> +#define ___bpf_syswrap_args5(x, args...) \
> +       ___bpf_syswrap_args4(args), (unsigned long long)PT_REGS_PARM5_COR=
E_SYSCALL(regs)
> +#define ___bpf_syswrap_args6(x, args...) \
> +       ___bpf_syswrap_args5(args), (unsigned long long)PT_REGS_PARM6_COR=
E_SYSCALL(regs)
> +#define ___bpf_syswrap_args7(x, args...) \
> +       ___bpf_syswrap_args6(args), (unsigned long long)PT_REGS_PARM7_COR=
E_SYSCALL(regs)

I undid all the line wrapping you did. Yes, they are even longer now,
but at least the pattern is easy to see when all of these macros are
single line ones.

Also, I took the liberty of doing similar transformations for
BPF_USDT() in usdt.bpf.h in the same patch, as you'll probably run
into the same issue (not sure why you haven't caught that yet). Please
double-check the committed patch, just to make sure I didn't screw
anything up. Thanks. Applied to bpf-next.

>  #define ___bpf_syswrap_args(args...)     ___bpf_apply(___bpf_syswrap_arg=
s, ___bpf_narg(args))(args)
>
>  /*
> --
> 2.30.2
>

