Return-Path: <bpf+bounces-34452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30292D8E6
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E331C21D99
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223B195F0D;
	Wed, 10 Jul 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT98t+uG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6F8F66
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639013; cv=none; b=gPhwuHD5u8cOwQ/VYDcloeXfU3gy/rv1Hi8S/7wawI5+qj8BAWDScQuDAhP2cPRfSmpcrNa+jO8bdFvomBxiCT3swg90rhiiMDMPwLDzb9fsEs+xA6I68niULYWJx2srsFgxVYUXy/tVhjn2FC1I0A7dK58KNfJqvuZfp0VbfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639013; c=relaxed/simple;
	bh=nOZgwlxiiICso5kmJUE9/A5EFogBWHGLKg3B4Pj7gW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiVqNIMj5vuadMaW5ieoeTwV+sfX+rfk27ti4dS+xfIo6a7V4mMXEwdCktKjIjC+4hqlT+QT0dxMg/z39W0iDnQ7MIUfIMZI1iChpHMi9T7n9mQPZfl42s2TVV8uih/ZSziBaG9Q/1IW/Vw8fO8YhL6qfO/t6XUha4XEqkjcKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT98t+uG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so38942a12.2
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720639011; x=1721243811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8jvFb7DLR3P3y99qpILtSvsIXU6xFYIEhhH6ZzPkrI=;
        b=KT98t+uGja4ewREKYbmZjzm6/cieIg1QdtZuAha6CgDI32o7cYeHt0iK5COS/36QcX
         rv8KbRD2fwwCcmrf9JUI2xjO8u+WDWJftxbGbunydNT1P1IPjArVeWW8VKc+F+vFiZR8
         f6JOl/ZiYibelSXJAjyg/FxG0rU6heLeuj4YI8YF4FtDWJwrVg6olnMHU7uLTNZg1XL5
         LajGlVXXTAp2v1ax1zi57weti5Ub6F0rEVKZ17W9xLjfhi7MVvmkE4CjZwmNHDEYsjnD
         y1U4dnIuyX+WWT912AL19AzrkntB35D9BYKEql8zfCHkGLXCzuIze/6WzIvh6kcXX7YE
         vWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639011; x=1721243811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8jvFb7DLR3P3y99qpILtSvsIXU6xFYIEhhH6ZzPkrI=;
        b=nuOrZBD+2J0t2CDIfldEcXjIzjC4aWVq8I1ZRWCJEAouTR/b2LLXkzUev+nlfwUORm
         EqNjMuvjXompT9+MKIfHh39lgoL54yrnCdHQY/1AZ751Azl0cYHmJva9IQ5lYu3+TsTZ
         VIgRF68DhCN29q7LRaRKd28T6IHCqzXBkg+8Hv2z1TVg11RKb0CZy7RxN6p+3W2xwzJR
         V3qcTcvgvkcF6w8sIFT2ujmilddkUYTZcGgtlmFqFErif+atqs93bSra2cJY8Wq8u+R9
         QF9ZNhyfxnMbRfLiiVHfEte4+VD9ClKxq/IMoVWYwgTLlUpBUnVKcODEOGwubg89DiMX
         rcnQ==
X-Gm-Message-State: AOJu0YyFva0AlaoMa2G9BM4lR1Iw4nwJCSTVHWll9M2jiwPN7awF9JXR
	E+wOVW8RNnizoSbLLSP3ufd0zsW4ZrWmeYxTT0kv/VNCVR2fynEyyg9SqqAwqWQiYJmWRGWW+hc
	I+FIoqwoixmzZYWncW50vppPOL6A=
X-Google-Smtp-Source: AGHT+IGXN44R0fcRwPFp/wA8zyQyKyJ2jvqjaMaTtyNvjctAlKRTWX1/x27C2Az1Qza76R/n+wB75eSPNyZ6eER5f2g=
X-Received: by 2002:a05:6a20:4890:b0:1c2:9022:1583 with SMTP id
 adf61e73a8af0-1c2984e0b0emr5293530637.61.1720639010908; Wed, 10 Jul 2024
 12:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
 <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
 <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
 <44bbdf47feb182fce4857e1b38fedb8fc95db3e7.camel@gmail.com>
 <CAEf4BzZWMNWzk0V2HmG3MV693bNDoBo5ptFE6_fPsRXEH4E75A@mail.gmail.com>
 <b21d3cc6f95dc4e1241c09a92a1ad45942ce53d0.camel@gmail.com>
 <CAEf4BzZD=1KmBi-t=qPcfFU=BrH0qDkLgjbBjNCohhBv2vc1EA@mail.gmail.com> <a317a04fc5b51d2c11b2cce6055b35a326183c43.camel@gmail.com>
In-Reply-To: <a317a04fc5b51d2c11b2cce6055b35a326183c43.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 12:16:38 -0700
Message-ID: <CAEf4BzbwY1_JGzzbiu9wg-r0+j7E3D_i75r0MUqPYFhTBLZ8DQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-07-10 at 11:49 -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 10, 2024 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Wed, 2024-07-10 at 10:50 -0700, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > > > Ok, I see, this wasn't obvious that you want this behavior. I a=
ctually
> > > > > > find it surprising (and so at least let's call this possibility=
 out).
> > > > > >
> > > > > > But, tbh, I'd make this stricter. I'd dictate that within a sub=
program
> > > > > > all no_csr patterns *should* end with the same stack offset and=
 I
> > > > > > would check for that (so what I mentioned before that instead o=
f min
> > > > > > or max we need assignment and check for equality if we already
> > > > > > assigned it once).
> > > > >
> > > > > This makes sense, but does not cover a theoretical corner case:
> > > > > - suppose there are two nocsr functions A and B on the kernel sid=
e,
> > > > >   but only was A marked as nocsr during program compilation;
> > > > > - the spill/fill "bracket" was generated for a call to function B=
 by
> > > > >   the compiler (because this is just a valid codegen).
> > > >
> > > > In this case the call to A shouldn't be changing nocsr_offset at al=
l,
> > > > though? You should find no spill/fill and thus even though A is
> > > > *allowed* to use no_csr, it doesn't, so it should have no effect on
> > > > nocsr offsets, no?
> > >
> > > Consider the following code:
> > >
> > >     *(u64 *)(r10 - 24) =3D r1;
> > >     call A                     // kernel and clang know that A is noc=
sr
> > >     r1 =3D *(u64 *)(r10 - 24);   // kernel assumes .nocsr_stack_offse=
t -24
> > >     ...
> > >     *(u64 *)(r10 - 16) =3D r1;
> > >     call B                     // only kernel knows that B is nocsr
> > >     r1 =3D *(u64 *)(r10 - 16);   // with stricter logic this would di=
sable
> > >                                // nocsr for the whole sub-probram
> >
> > oh, you mean that r10-16 accesses are valid instructions emitted by
> > the compiler but not due to nocsr? I mean, tough luck?... We shouldn't
> > reject this, but nocsr is ultimately a performance optimization, so
> > not critical if it doesn't work within some subprogram.
>
> Not critical, but the difference between allowing and disallowing nocsr
> for this case is '<' (current) vs '=3D=3D' (suggested) check for .nocsr_s=
tack_offset.
> I think that current algo should not be made more strict.
>

ok

> > > > But your example actually made me think about another (not theoreti=
cal
> > > > at all) case. What if we have calls to A and B, the kernel is sligh=
tly
> > > > old and knows that B is nocsr, but A is not. But the BPF program wa=
s
> > > > compiled with the latest helper/kfunc definitions marking A as no_c=
sr
> > > > eligible (as well as B). (btw, THAT'S THE WORD for allow_csr --
> > > > ELIGIBLE. csr_eligible FTW! but I digress...)
> > > >
> > > > With the case above we'll disable nocsr for both A and B, right? Th=
at
> > > > sucks, but not sure if we can do anything about that. (We can proba=
bly
> > > > assume no_csr pattern and thus allow spill/fill and not disable noc=
sr
> > > > in general, but not remove spill/fills... a bit more complication
> > > > upfront for longer term extensibility.. not sure, maybe performance
> > > > regression is a fine price, hmm)
> > > >
> > > > So I take it back about unmarking csr in the *entire BPF program*,
> > > > let's just limit it to the subprog scope. But I still think we shou=
ld
> > > > do it eagerly, rather than double checking in do_misc_followups().
> > > > WDYT?
> > >
> > > With current algo this situation would disable nocsr indeed.
> > > The problem is that checks for spilled stack slots usage is too simpl=
istic.
> > > However, it could be covered if the check is performed using e.g.
> > > process I described earlier:
> > > - for spill, remember the defining instruction in the stack slot stru=
cture;
> > > - for fill, "merge" the defining instruction index;
> > > - for other stack access mark defining instruction as escaping.
> >
> > Sorry, I have no idea what the above means and implies. "defining
> > instruction", "merge", "escaping"
> >
> > As I mentioned above, I'd keep it as simple as reasonably possible.
>
> It should not be much more complex compared to current implementation.
>
>     1: *(u64 *)(r10 - 16) =3D r1; // for stack slot -16 remember that
>                                 // it is defined at insn (1)
>     2: call %[nocsr_func]
>     3: r1 =3D *(u64 *)(r10 - 16); // the value read from stack is defined
>                                 // at (1), so remember this in insn aux
>
> If (1) is the only defining instruction for (3) and value written at (1)
> is not used by other instructions (e.g. not passed as function argument,
> "escapes"), the pair (1) and (3) could be removed.

> > As I mentioned above, I'd keep it as simple as reasonably possible.

>
> > > >
> > > - on the first pass true .nocsr_stack_off is not yet known,
> > >   so .nocsr_pattern is set optimistically;
> > > - on the second pass .nocsr_stack_off is already known,
> > >   so .nocsr_pattern can be removed from spills/fills outside the rang=
e;
> > > - check_nocsr_stack_contract() does not need to scan full sub-program
> > >   on each violation, it can set a flag disabling nocsr in subprogram =
info.
> >
> > I'm not even sure anymore if we are agreeing or disagreeing, let's
> > just look at the next revision or something, I'm getting lost.
> >
> > I was saying that as soon as check_nocsr_stack_contract() detects that
> > contract is breached, we eagerly set nocsr_pattern and
> > nocsr_spills_num to 0 for all instructions within the current subprog
> > and setting nocsr_stack_off for subprog info to 0 (there is no more
> > csr). There will be no other violations after that within that
> > subprog. Maybe that's what you mean as well and I just can't read.
>
> Ok, I'll send v3, let's proceed from there.
>
> [...]

