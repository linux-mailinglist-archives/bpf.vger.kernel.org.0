Return-Path: <bpf+bounces-27839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B68B2842
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA361F21DCE
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF443BBE9;
	Thu, 25 Apr 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgJTe99D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1380208C4
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070452; cv=none; b=Z1GDZhV+TzBd4IiIEYujARKWjdU8bLTQLBjnEc5qCtL/Mr1qkz7ML0Ivm2jOUdiHajPb/m99m9qX9SZI8O/wsPC+b5MyQPbzb64Z9ZRqudNRI8ByHP1AV8CmUa1ulKYlwfAKkwQdKoY+uC/vjKgC/gcXCBWLmCwtB/eOFQ+nvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070452; c=relaxed/simple;
	bh=G8ehixNkhmlMEQ4vrTN7D2cokyGIQ2CrMjUaGdsV0u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmXgz94loTThsyKS1AIm0f3PsW5/yDsRBhSfhzBx/Ef1hHAIpu1DXvq5iIrtrSG87r7aiM68D9qnx+n7oadQnNxtJTm8jBIBYuXF/3TAF1rvovwtIxuGY3MRk1wlbTdyX/lRpHpBcimAUA1Zs+I5iCF/jc0xP9+SJIbqVFki7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgJTe99D; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso834322a12.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714070450; x=1714675250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MLwzoOoJDeHpfTXpsUeymp5JzykeluODXmqHdjgAfA=;
        b=WgJTe99DIyrL7FEmgqQFHeD1Tp7CgDmJkd44yfQKn16ExbhXpmELks8Yk0KlYr4N68
         skmGG7dwaVWpj39yg6K8H4F4h8CfEdpF0l4XHpQru/oXRnq2svGpBC5Fm9AyAH/n912o
         +BFQz+QNxlEibey/a68DQWSgx/GO1d6EmXLfDS+wF5OWCBhlYPPe7q34aESfdQiiWu9z
         fi2WUlHEQh0328pecV+7AIO/MkbfaZL4XS1778HThQcJ5jtOCVF4/gT+DIrFbUT8rWYF
         kMZg/1p1k/w8ps71SynNPNASfKxo4KN81l8xaNN+l0MJYwBxgpMHzg7qQpoTsBPrUFN2
         sOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714070450; x=1714675250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MLwzoOoJDeHpfTXpsUeymp5JzykeluODXmqHdjgAfA=;
        b=FE8zUe2WZdLVDaCRcFasm51UjqTAz1rgZQj2WpvWrzhRQFQv6H+Kc79/G1EBgmQxFp
         e1C6iGtrhYSgls8Ej7AFZ9/6Q8IfoNnNylsg+zSdEdgJe1PYFncPvsjJ7nCg/YuoG8sM
         LzFJV5/QZZGpQTCL+MWQzOsnT22lm1JMtXSfkg6X49xAIenBYpknBELicH71Kxj+XBcC
         LkX+YMKt3Vl1bZ+qrnGKcYb5dwedFFM0tsnUAOgPNiN6eu0tE4QO6TWeEIq9jXrdgikG
         +YDTxGXQbSQer45OmOWMHsUq1t6t2mKc64P3Utm/lZoNiIk/T1NvHlwrdk38T+dCI/UC
         RoZg==
X-Gm-Message-State: AOJu0Yxov74dwWZl0CsMP4iwldHq6BkkIz+5g94MmXEXnlWqTVffYsOZ
	ME76tEJh+F4JPKVSEGGlyxmJN6GwfwdeIurhy/aqZonc9kz+zJnc/wKYRpROjbBBn2hSKEa1Umr
	3awf800aN27M8RjZC+OfHpCZ2QPQtYArS
X-Google-Smtp-Source: AGHT+IECvW5SKeK0PbSFOkUmbWQ/K+0jwzJDY6J4t19JzcyCptaoMJPb42BudUW0FfzZIRkW2qfqdh4biB6mFUnPmA4=
X-Received: by 2002:a17:90a:fa98:b0:2af:3c7f:3531 with SMTP id
 cu24-20020a17090afa9800b002af3c7f3531mr413153pjb.33.1714070450127; Thu, 25
 Apr 2024 11:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87edat1j7f.fsf@oracle.com>
In-Reply-To: <87edat1j7f.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 11:40:37 -0700
Message-ID: <CAEf4BzYfkb+ZCT+qjQZ5OA=Wy_q2ojk5RGLqf+otZGKC+c1nvQ@mail.gmail.com>
Subject: Re: BPF_PROG, BPF_KPROBE, BPF_KSYSCALL and enum conversions
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 9:49=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> The BPF_PROG macro defined in tools/lib/bpf/bpf_tracing.h uses a clever
> hack in order to provide a convenient way to define entry points for BPF
> programs, that get their argument as elements in a single "context"
> array argument.
>
> It allows to write something like:
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
> Note how the 64-bit unsigned integers in the incoming CTX get casted to
> a void pointer, and then implicitly casted to whatever type of the
> actual argument in the wrapped function.  In this case:
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
> BPF_PROG works because the pointer to integer conversion leads to the
> same value in 64-bit mode, much like when casting a pointer to
> uintptr_t.  It also silences compiler errors by mean of the compiler
> pragma that installs -Wno-int-conversion temporarily.
>
> However, the GCC error marked with (*) above when assigning a pointer to
> an enumerated value is not associated with the -Wint-conversion warning,
> and it is not possible to turn it off.
>
> This is preventing building the BPF kernel selftests with GCC.
>
> The magic in the BPF_PROG macro leads down to these macros:
>
>   #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0=
]
>   #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)c=
tx[1]
>   #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)c=
tx[2]
>   etc
>
> An option would be to change all the usages of BPF_PROG that use
> enumerated arguments in order to use integers instead.  But this is not
> very nice for obvious reasons.
>
> Another option would be to omit the casts to (void *) from the
> definitions above.  This would lead to conversions from 'unsigned long
> long' to typed pointers, integer types and enumerated types.  As far as
> I can tell this should imply no difference in the generated code in
> 64-bit mode (is there any particular reason for this cast?).  Since the
> pointer->enum conversion would not happen, errors in both compilers
> would be successfully silenced with the -Wno-int-conversion pragma.
>
> This option would lead to:
>
>   #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), ctx[0]
>   #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), ctx[1]
>   #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), ctx[2]
>   #define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), ctx[3]
>   etc
>
> Then there is BPF_KPROBE, which is very much like BPF_PROG but the
> context is an array of pointers to ptregs instead of an array of
> unsigned long longs.
>
> The BPF_KPROBE arguments and handled by:
>
>   #define ___bpf_kprobe_args0()           ctx
>   #define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(), (void *)=
PT_REGS_PARM1(ctx)
>   #define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args), (voi=
d *)PT_REGS_PARM2(ctx)
>   #define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (voi=
d *)PT_REGS_PARM3(ctx)
>   etc
>
> There is currently only one BPF_KPROBE usage that uses an enumerated
> value (handle__kprobe in progs/test_vmlinux.c) but a similar solution to
> the above could be used, by casting the ptregs pointers to unsigned long
> long:
>
>   #define ___bpf_kprobe_args0()           ctx
>   #define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(),(unsigned=
 long long )PT_REGS_PARM1(ctx)
>   #define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args),(unsi=
gned long long)PT_REGS_PARM2(ctx)
>   #define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args),(unsi=
gned long long)PT_REGS_PARM3(ctx)
>   etc
>
> Similar situation with BPF_KSYSCALL:
>
>   #define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (void =
*)PT_REGS_PARM1_CORE_SYSCALL(regs)
>   #define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (v=
oid *)PT_REGS_PARM2_CORE_SYSCALL(regs)
>   etc
>
> There is currently no usage of BPF_KSYSCALL with enumerated types, but
> the same change would lead to:
>
>   #define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(),(unsign=
ed long long)PT_REGS_PARM1_CORE_SYSCALL(regs)
>   #define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args),(un=
signed long long )PT_REGS_PARM2_CORE_SYSCALL(regs)
>   etc
>
> Opinions?
>

I don't remember why I did (void *), but I think I was just banging my
head against the compiler until I made it work, and once it worked, I
didn't try to improve it further :) If casting to (unsigned long long)
works just as well as (void *) and helps in GCC case, let's convert.

Just please don't miss ___bpf_syscall_args* and ___bpf_kretprobe_args1 as w=
ell.

