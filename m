Return-Path: <bpf+bounces-34270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F092C2CD
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4D21C217CF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E440717B044;
	Tue,  9 Jul 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuqYBi3t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8F1B86ED;
	Tue,  9 Jul 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547415; cv=none; b=BGqieM03HG7GxKK1CkuXR6l2J2t7EvROayEuyZ83CGjHRa8fBetIN1fSZFylMsDbcSDvE9KYaiXU0xLAzRvJw8gacHef14F54sXq29aiVL4hH+kaNz/5Y9wDVScR2Fc5k+hadoNjQDU0bAUMMQCnZWUSUuKU9FpPOf1JFE7Bi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547415; c=relaxed/simple;
	bh=GmrPSmo1303o876eSGXA2Ke1Ip3S05EwUbBsDv7mM6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rG5+5rHtCcoi/jXx0dweVkmZVteuuKId7d+3Pb7eFDjpCv/moMkKW19XQ+F9lUie4Jel1YS4HwLKlCs8NKybMtS5GqFzq1lC+Co2vp05KuPKlYLV7BvMQS3rGJz1tFYFt4B9AtLAE+ZPpBEqtACR5BkyZufPbT2QyzsMyYkBFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuqYBi3t; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-75a6c290528so2928987a12.1;
        Tue, 09 Jul 2024 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720547413; x=1721152213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjuvgEc4GR8fmvTKFsW+ckPFS57613C03orBn4x8IXg=;
        b=RuqYBi3tKCKPDfYorv/xLGPgHDYWAGccDJwbKquxp8DFnNdk4BthRZiEpuKrlC/oah
         +Qi+Nqx/SkyVvjK2fLGg6XkUV/xa2cDfv3GgkJ3sR1bqKD6ZdGwqHNp1u0f3l9AiyMRD
         6aWy1nZHOq65GGt+0lvc+/+/clwGiOu4Gt2n/CgmKrq4I1V8ntmqHmZJ43tpYwbWiO8O
         0fESATE/PPL3ipRtGfL/VUW9hTizr7D3UZjQ+R5U6T0a6MPRFBY0LYpkgbDzTernP1qj
         xibqmjlL1VRXsmhZAKgKJSF/L60DnvdQwSWMfuFN1tTblka8rNH3dd2J3IkPMxWSCzFm
         YX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720547413; x=1721152213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjuvgEc4GR8fmvTKFsW+ckPFS57613C03orBn4x8IXg=;
        b=WSr5u3T+AIDHW0OKglg3asKFFlirLPsxnIauIX6eTGid2P4oQj+GdHVHgzygzAVuLF
         9DzjqBGETWgBFMWL2xjpjAd5QZVmvTkWt+OU6SbFwea3EHJMQpedtTC3SP1/x2hlp0He
         My73dQNbc+RLX2ck9cQauH5gBG+w9R6x7bHOKlmkCnxtPZdv4sr5c8ga5XFp+2BSpQca
         SWP0e9/YifOit/iEznie9nr8sabPUyLyBDKdsuHUOSkemtM24A2M6DoSdwWO6GNHxQsj
         wXhbR49+18+9dMOjYYgnL7Km+Czen6tl/3OMrWONmd8fZ6dPJo7JqkRH6csFBAA1WxUi
         l2AA==
X-Forwarded-Encrypted: i=1; AJvYcCVu2XGGRAJ8NjPIg8KIkfe2pbBsakmBZZQ7y41DldosdMxrOOpmbJRDo/9Xy1o/m3Bw5nh/vI5/SXyyEQzto8ddl4coTiCozgPdt47Fk6xOMLSqRSTNMFDXf+nP+lp+tJwJP5co2DxQgTeIxdro9BzdhdusuMwCVn9EQGtWVJ7tz980hDL9y4t0Kal/+Y7z2uAEcjiochbkkcA1uAfqFpNJM1GFKeatDA==
X-Gm-Message-State: AOJu0Yy2A+OaLU4FJSEO8JQyKRS2ItO19KdOcdpCqMHOSY3x6Ae6jDJG
	SzXKrsQsJFnfcJEjIAP4/0C8ujRNJi+NlFuWNPxqycjOCJeV636oKoZIlTr22L2Iw7tk7wH/9lr
	wZzWSQp2h72sj5ItCCdEo6FSJN2fnNU0N
X-Google-Smtp-Source: AGHT+IF1rWrxBaNPBEPUEhZkYCauomT40ych1jwMmPjvzoPKJ8LJhUbM5lGyfSG2qr/ehIYkrYTp1IOAA1KhWfg8Svw=
X-Received: by 2002:a05:6a20:7f96:b0:1c2:93a7:2556 with SMTP id
 adf61e73a8af0-1c2984cf106mr3651883637.41.1720547413066; Tue, 09 Jul 2024
 10:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708231127.1055083-1-andrii@kernel.org> <20240709101133.GI27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240709101133.GI27299@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 10:50:00 -0700
Message-ID: <CAEf4Bza22X+vmirG=Xf4zPV0DTn9jVXi1SRTn9ff=LG=z2srNQ@mail.gmail.com>
Subject: Re: [PATCH v4] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com, 
	tglx@linutronix.de, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 3:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Jul 08, 2024 at 04:11:27PM -0700, Andrii Nakryiko wrote:
> > +#ifdef CONFIG_UPROBES
> > +/*
> > + * Heuristic-based check if uprobe is installed at the function entry.
> > + *
> > + * Under assumption of user code being compiled with frame pointers,
> > + * `push %rbp/%ebp` is a good indicator that we indeed are.
> > + *
> > + * Similarly, `endbr64` (assuming 64-bit mode) is also a common patter=
n.
> > + * If we get this wrong, captured stack trace might have one extra bog=
us
> > + * entry, but the rest of stack trace will still be meaningful.
> > + */
> > +static bool is_uprobe_at_func_entry(struct pt_regs *regs)
> > +{
> > +     struct arch_uprobe *auprobe;
> > +
> > +     if (!current->utask)
> > +             return false;
> > +
> > +     auprobe =3D current->utask->auprobe;
> > +     if (!auprobe)
> > +             return false;
> > +
> > +     /* push %rbp/%ebp */
> > +     if (auprobe->insn[0] =3D=3D 0x55)
> > +             return true;
> > +
> > +     /* endbr64 (64-bit only) */
> > +     if (user_64bit_mode(regs) && *(u32 *)auprobe->insn =3D=3D 0xfa1e0=
ff3)
> > +             return true;
>
> I meant to reply to Josh suggesting this, but... how can this be? If you
> scribble the ENDBR with an INT3 things will #CP and we'll never get to
> the #BP.

Well, it seems like it works in practice, I just tried. Here's the
disassembly of the function:

00000000000019d0 <urandlib_api_v1>:
    19d0: f3 0f 1e fa                   endbr64
    19d4: 55                            pushq   %rbp
    19d5: 48 89 e5                      movq    %rsp, %rbp
    19d8: 48 83 ec 10                   subq    $0x10, %rsp
    19dc: 48 8d 3d fe ed ff ff          leaq    -0x1202(%rip), %rdi
 # 0x7e1 <__isoc99_scanf+0x7e1>
    19e3: 48 8d 75 fc                   leaq    -0x4(%rbp), %rsi
    19e7: b0 00                         movb    $0x0, %al
    19e9: e8 f2 00 00 00                callq   0x1ae0 <__isoc99_scanf+0x1a=
e0>
    19ee: b8 01 00 00 00                movl    $0x1, %eax
    19f3: 48 83 c4 10                   addq    $0x10, %rsp
    19f7: 5d                            popq    %rbp
    19f8: c3                            retq
    19f9: 0f 1f 80 00 00 00 00          nopl    (%rax)

And here's the state when uprobe is attached:

(gdb) disass/r urandlib_api_v1
Dump of assembler code for function urandlib_api_v1:
   0x00007ffb734e39d0 <+0>:     cc                      int3
   0x00007ffb734e39d1 <+1>:     0f 1e fa                nop    %edx
   0x00007ffb734e39d4 <+4>:     55                      push   %rbp
   0x00007ffb734e39d5 <+5>:     48 89 e5                mov    %rsp,%rbp
   0x00007ffb734e39d8 <+8>:     48 83 ec 10             sub    $0x10,%rsp
   0x00007ffb734e39dc <+12>:    48 8d 3d fe ed ff ff    lea
-0x1202(%rip),%rdi        # 0x7ffb734e27e1
   0x00007ffb734e39e3 <+19>:    48 8d 75 fc             lea    -0x4(%rbp),%=
rsi
=3D> 0x00007ffb734e39e7 <+23>:    b0 00                   mov    $0x0,%al
   0x00007ffb734e39e9 <+25>:    e8 f2 00 00 00          call
0x7ffb734e3ae0 <__isoc99_scanf@plt>
   0x00007ffb734e39ee <+30>:    b8 01 00 00 00          mov    $0x1,%eax
   0x00007ffb734e39f3 <+35>:    48 83 c4 10             add    $0x10,%rsp
   0x00007ffb734e39f7 <+39>:    5d                      pop    %rbp
   0x00007ffb734e39f8 <+40>:    c3                      ret


You can see it replaced the first byte, the following 3 bytes are
remnants of endb64 (gdb says it's a nop? :)), and then we proceeded,
you can see I stepped through a few more instructions.

Works by accident?

But either way, if we prevent uprobe to be placed on end64 that will
essentially break any code that does compile with endbr64
(-fcf-protection=3Dbranch), which is very not great (I suspect most
people that care would just disable that option in such a case).

>
> Also, we tried very hard to not have a literal encode ENDBR (I really
> should teach objtool about this one :/). If it somehow makes sense to
> keep this clause, please use: gen_endbr()

I'll just use is_endbr(), no problem.

