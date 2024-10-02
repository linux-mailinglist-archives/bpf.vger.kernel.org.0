Return-Path: <bpf+bounces-40731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73F98CB19
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 04:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E882861DD
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 02:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74423BB;
	Wed,  2 Oct 2024 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/1h2iZf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634B802
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835427; cv=none; b=ZnPNtCm664JaigwDcKkulWmKE94n02+EQNf/MPx84P1wX1rD9A8LTPsq43yn7hQsLqesxOfRJc+ey9xgDbGwLD+GcV2rmQPUi1K9IangYKWTu7Zj+kwQsc6APFZL21+OkAO7ZuvFuOiYCf/Pjq+iDVioD4789Es5yNw8bUO0Go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835427; c=relaxed/simple;
	bh=wIQ5PRuigyqAbqYa/Lfn+cftSPu3x7e8jll3w4X/THw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV1IUjtQEgLc90lM6apR+eRjRRQ8QcQ/Akw0yYedM+LiTyyAtexiDrgdJxmNHTlbVGlDbYtFzH+rZlTbBe8vpHfpCiU9WDkcgkR49f1/WW3OpdJi2hjtOPxedA4nSILzPemDBG4Zl/G14Yk+b+2XaM2cL+cjheXlpWMlbygGCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/1h2iZf; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so652261a12.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 19:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727835424; x=1728440224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0nZe4VJUq2YOwFH1RipJtr0Syz6xcs9P/t9RFxhd1g=;
        b=B/1h2iZf4IgnO8u8/9HS/vtJLLkxhwqTcOLanx4AnuqcH5O8E505k5xFa79+1c0fjz
         sgngAr+KAYmMEBf3j9l3Flv1OZKFjXVCzUtSAsol4C30Z2y127uRa8+vxcpPuQjjkNfe
         xJH5MFvaeCeAZ5/BW2YqVRSUm4PHtj1pVqtzW5Yu8W0wTdhokHeJ5lCSLOtmKsJWNW/0
         TZDrDsiliLOEOcIoQ+KQlaQd8a1J/JaZVorkuDeA9zqaItC1xUEnDIrDHppgdLLJRorG
         +oWqDqIxt2R1qxkl/4eQBrB6YeeykemyT3d4U9g1bKvY/5Abg9kv0M2mA78ws4g2Etyu
         PD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727835424; x=1728440224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0nZe4VJUq2YOwFH1RipJtr0Syz6xcs9P/t9RFxhd1g=;
        b=kBX2mVhNpoR1lrlSm8XXPFfubGLOWZeiBooXhOW66Kp75FlEqt+tJjmjStYzs5X7oM
         jtbJYq4jM8g4fKIgPCwvpoqwT140mq1Vp1W2lv4wkcX5uXMr9jynIgBqiKixGhQpFrph
         SeNEyt6NkZZCYIDXn9hryB+6fCH4HbY4yaOCEfaryDwmI2LHWXZumAwLUN1Bw2twfZdh
         v0TuHSdUhyccwBzZ/+mI9HvmpjClMMBtzeVuA6zlemMsr10zXkxt3UqHoYxEqdvySZdb
         jEmt66gkqtyxsDp6lmquZR9yVw1oiqJiHpJ8D/gLXU7FvE+QZh/eb/8zYzS4kC1T53RU
         bcTg==
X-Forwarded-Encrypted: i=1; AJvYcCWR9W4CVx6rV8Pv/D/Lk3sU7W7g6zZzAo8iIGEMNaPiGOMg5ovfPhs94rBMPpmTU4CbKpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIssXjDh+FjPkAo7RdOQaBL7PBEI13ORfiqUkfciiGc+V+34Nl
	UeSwcZ80fV2o+YDDDfKXD+ZspBNhwgYETXi7gnwHUxMD+/nPEZCuSM041ueXCtZQBGKETCN7GKJ
	py3pyCnLUWmtFcxUZZ6LUpfsV87g=
X-Google-Smtp-Source: AGHT+IHmykr+BPP+nmJ8n3Nx7wX7wO1CCyWerw6zYUcxNkr3pvIgT7sDSK1POVWhxIqYSgnMREBOkBEf4vGoM1o2f18=
X-Received: by 2002:a05:6402:50d3:b0:5c8:843c:7a74 with SMTP id
 4fb4d7f45d1cf-5c8a2a558e3mr5493101a12.12.1727835424151; Tue, 01 Oct 2024
 19:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com> <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
In-Reply-To: <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 2 Oct 2024 04:16:27 +0200
Message-ID: <CAP01T75JUvKUJH4OKDOSySQcK5xP0nFs48FbW_dqMzeo9DhQOw@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2024 at 03:26, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 1, 2024 at 5:23=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Makes sense, though will we have cases where hierarchical scheduling
> > attaches the same prog at different points of the hierarchy?
>
> I'm not sure anyone was asking for such a use case.

I wondered because why would you then need a limit of 4 (say instead
of disallowing it)?

>
> > Then the
> > limit of 4 may not be enough (e.g. say with cgroup nested levels > 4).
>
> Well, 4 was the number from TJ.
>

Ok, then let's assume 4 would be enough.

> Anyway the proposed pseudo code:
>
> __bpf_prog_enter_recur_limited()
> {
>   cnt =3D this_cpu_inc_return(*(prog->active));
>   if (cnt > 4) {
>      inc_miss
>      return 0;
>   }
>  // pass cnt into bpf prog somehow, like %rdx ?
>  // or re-read prog->active from prog
> }
>
>
> then in the prologue emit:
>
> push rbp
> mov rbp, rsp
> if %rdx =3D=3D 1
>    // main prog is called for the first time
>    mov rsp, pcpu_priv_stack_top
> else
>    // 2+nd time main prog is called or 1+ time subprog
>   sub rsp, stack_size
>   if rsp < pcpu_priv_stack_bottom
>     goto exit  // stack is too small, exit
> fi

I think we need just the second part for subprogs, right?
Since rdx is R3 (arg into subprog).
I guess that's what you meant in the pseudocode.
But otherwise sounds good.
The benefit with stack probing is we don't exactly limit to 4 cases.

Another option instead of the branch in main prog is to divide in 4
slots (as you said before) and choose the slot based on cnt.
But then we're stuck with a max limit of 4. Since we're allocating
stack size of bpf + extra (which I guess is 8K?). rdx can be used to
pass in the priv_stack address of the right slot.

So I think the probing version seems better. We can probably pass in
rdx =3D priv_stack and then test and cmov instead for main prog.

>
> Since stack bottom/top are known at JIT time we can
> generate reliable stack overflow checks.
> Much better than guard pages and -fstack-protector.
> The prog can alloc percpu
> (stack size of main prog + subprogs + extra) * 4

extra will be 8K, I guess (same as kernel stack size)?
Just confirming.

> and it likely will be enough.
> If not, the stack protection will gently exit the prog
> when the stack is too deep.

I like this stack probing version, since there's no hard limit on the
number of recursions, and it's safe against stack overflow as well.

> kfunc won't have such a check, so we need a buffer zone.
> Can have a guard page too, but feels like overkill.

I was leaning toward saying yes for a guard page, since we'll atleast
have a hard error instead of random corruption if the kfunc goes
beyond the bottom after probing succeeds.

But the better way might be doing if rsp < pcpu_priv_stack_bottom +
8K, so we leave max headroom we reserve for kernel stuff (or say add
4K instead, which should be good enough), and then skip execution.

