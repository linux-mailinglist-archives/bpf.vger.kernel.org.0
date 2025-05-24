Return-Path: <bpf+bounces-58873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356EDAC2CCC
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DB81C07BC8
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B731448D5;
	Sat, 24 May 2025 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxbMGfIi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927F6FC3
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748048522; cv=none; b=h0d/D4Vost6WHbbYTgigDWN3snh24+GVYamGnhAi1dcgTKdpTj4N2HOv5jovHrsvw0nXuM8lOXpYOmMuAuGBB/OpUy38WC5OEVYGo4WW4+db5YZK4pdWbMbmmaRBF1IfvsFuv+op0P+7wUhTuHKbGril9LkMyz7kzWmTcVwy1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748048522; c=relaxed/simple;
	bh=x32efmyMIIicX20DP2SgZVJAb502Gq/DfBcpsIbkTk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuY4o5wNUdw6QmaGOMLwCemdff3/0YPUnmIPDKgC8sXyLVqUsUdTmpHj8kM3h5TUuMzlUVMh05b2Bl6qhuZUyAASwOCl0gCQ5ukNZMj3reEuDX7QJ99eeecu31uHJhmm3mOCh9ll2ZA31OYGaGPPKp21a4qzXz8LzbYuODLotXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxbMGfIi; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-acacb8743a7so75818466b.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748048519; x=1748653319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPxNcC3YId4FUejlEXwL5IotcAvwx+O8AcIu/WuJJbk=;
        b=gxbMGfIiMrdSfbLBHGT5sW78tu/JviOf1zW4nldY319kHP46FMo7aPE5gjk6VjJKtE
         oHF6TYccophoFY9jLFQcQRxcW2KUY0sZkRJKcFZciNL5nKf04xj/+5E1jLGQkfZCMF2x
         kcMchKEHCC9VxRdNYF5tV0R7tii3tVbGb/Ywe7yyN7Kuc04PG9dh3fSrVTMKk7v8z+o4
         mPcsctCDm/f+/kf6YXlYFHUtNWawI9CeZI1+0CfFi5dTj8kV7N2hl12+aw/SYlXIpy8t
         UQiCM2BGqn7cjBhZmw+uQWrV6DYxpYWyY9Vi3Uo2LOufSBOPY2N4TI6+kbJkwVHrm3Oh
         XIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748048519; x=1748653319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPxNcC3YId4FUejlEXwL5IotcAvwx+O8AcIu/WuJJbk=;
        b=N//4Wl0DIL3Fg1d7KgXLOeupb3MNLEY53D9TeUwI63klFC90lmk+Lwp8BLSXmRjy9Y
         SUIZ8WfveOC1Nd2XBWNMSHj9REbKdJUkrUjt8Y+tUJhZwz5hZulObBgtjkKrzaMLZUYn
         mMwZWfba4CaN/S4uzaUK0AjnR682S9sNDqbnL1qBTLEV5pUjGyZrrcu1YP0nM+RqyBzo
         AoCbmn289k5ElxzVMObT/FovGbqwCdHT+HNCvL171y7gYm6RQ302+f1M7BzsG/lpLQ7k
         Pcd5h+BOzAJaL3gheVY3Plfms3NSM3ph0DSdI04QlIkvQg7fcXViyT7lDfUh7hzJbNBm
         KFyw==
X-Forwarded-Encrypted: i=1; AJvYcCXEpNCB+L903Vl0FuQtV3vRr8T+8/o7+z+CfmHYRIOoWbFWKwTLYaFvh5Tk7F82i3zi+oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzommjdiBsuma28uwVZ5KpQFbJJo341H5O/09ELtTISm5VR87Jh
	lYxVdQk++kct0xL0I/T496klezntxNjjatF/APUTVo10GU1V6xTMiQ2CvjiikjOTZ2YGjLqNdIz
	0HV+Ke5D7oiz9Xjw1ZqYm7zLBSDdMyGg=
X-Gm-Gg: ASbGnct3PMQnzqkdDCXtHOH/280PjUd6WpABEuMLbeOsdlJqyqf7pJ+ZfAVD5ku1Ag4
	8a+N6S8lV+bn86O3ZjXim4Ln/3GK3SI8XSaqVogF1YGit2TUCAaqkkNGQpic+dMTZ3XqJBBNp2h
	SC6Su9MKSTP3IdmTESQwRtXp1WLnJrG7K7O0RFZ4Z7ZJfDUINRlPES2LmfYYrfNNPFJAWNELgOG
	RTZKw==
X-Google-Smtp-Source: AGHT+IFATIIq2FhBhUFnZ33lSdWiFwY3st2VXgVu/FkeTB1rvMiGSGpxYT2qOPuv+cg5+8MqUsci0K/ssVRFJpdwygo=
X-Received: by 2002:a17:907:3e1c:b0:ac7:81b0:62c9 with SMTP id
 a640c23a62f3a-ad8599eacf9mr114310166b.20.1748048518664; Fri, 23 May 2025
 18:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508113804.304665-1-iii@linux.ibm.com> <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
 <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
 <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com>
 <7a242102eecdd17b4d35c1e4f7d01ea15cb8066a.camel@linux.ibm.com>
 <CAADnVQ+5h9UESAgNA58HEQ-0zwxn=c0+ibH++NF9farR5-JB8g@mail.gmail.com>
 <CAP01T74iix8HvmVYowFyrG98tDRw8JMOck7HQLD57nuo7SyuoA@mail.gmail.com>
 <a8b8b4c9b5485a605437448bd1c548a38dfd1d55.camel@linux.ibm.com> <b7517bd4-3e6a-4a74-99c8-bca0969aeb01@linux.dev>
In-Reply-To: <b7517bd4-3e6a-4a74-99c8-bca0969aeb01@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 24 May 2025 03:01:22 +0200
X-Gm-Features: AX0GCFtWb6r4Rlharq365DhzPegk85Bmk4Wj1Yyk5fi9acHLlk0waf--unvwnas
Message-ID: <CAP01T75hQ0SDAXY+w-nnRii_B9TkydCXahbC8ATrmuGAeQc+AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused" warnings
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 24 May 2025 at 02:06, Yonghong Song <yonghong.song@linux.dev> wrote=
:
>
>
>
> On 5/23/25 4:25 AM, Ilya Leoshkevich wrote:
> > On Mon, 2025-05-12 at 15:29 -0400, Kumar Kartikeya Dwivedi wrote:
> >> On Mon, 12 May 2025 at 12:41, Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>> On Mon, May 12, 2025 at 5:22=E2=80=AFAM Ilya Leoshkevich
> >>> <iii@linux.ibm.com> wrote:
> >>>> On Fri, 2025-05-09 at 09:51 -0700, Alexei Starovoitov wrote:
> >>>>> On Thu, May 8, 2025 at 12:21=E2=80=AFPM Ilya Leoshkevich
> >>>>> <iii@linux.ibm.com>
> >>>>> wrote:
> >>>>>> On Thu, 2025-05-08 at 11:38 -0700, Alexei Starovoitov wrote:
> >>>>>>> On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevich
> >>>>>>> <iii@linux.ibm.com>
> >>>>>>> wrote:
> >>>>>>>> clang-21 complains about unused expressions in a few
> >>>>>>>> progs.
> >>>>>>>> Fix by explicitly casting the respective expressions to
> >>>>>>>> void.
> >>>>>>> ...
> >>>>>>>>          if (val & _Q_LOCKED_MASK)
> >>>>>>>> -               smp_cond_load_acquire_label(&lock-
> >>>>>>>>> locked,
> >>>>>>>> !VAL,
> >>>>>>>> release_err);
> >>>>>>>> +               (void)smp_cond_load_acquire_label(&lock-
> >>>>>>>>> locked,
> >>>>>>>> !VAL, release_err);
> >>>>>>> Hmm. I'm on clang-21 too and I don't see them.
> >>>>>>> What warnings do you see ?
> >>>>>> In file included from progs/arena_spin_lock.c:7:
> >>>>>> progs/bpf_arena_spin_lock.h:305:1756: error: expression
> >>>>>> result
> >>>>>> unused
> >>>>>> [-Werror,-Wunused-value]
> >>>>>>    305 |   ({ typeof(_Generic((*&lock->locked), char: (char)0,
> >>>>>> unsigned
> >>>>>> char : (unsigned char)0, signed char : (signed char)0,
> >>>>>> unsigned
> >>>>>> short :
> >>>>>> (unsigned short)0, signed short : (signed short)0, unsigned
> >>>>>> int :
> >>>>>> (unsigned int)0, signed int : (signed int)0, unsigned long :
> >>>>>> (unsigned
> >>>>>> long)0, signed long : (signed long)0, unsigned long long :
> >>>>>> (unsigned
> >>>>>> long long)0, signed long long : (signed long long)0, default:
> >>>>>> (typeof(*&lock->locked))0)) __val =3D ({ typeof(&lock->locked)
> >>>>>> __ptr
> >>>>>> =3D
> >>>>>> (&lock->locked); typeof(_Generic((*(&lock->locked)), char:
> >>>>>> (char)0,
> >>>>>> unsigned char : (unsigned char)0, signed char : (signed
> >>>>>> char)0,
> >>>>>> unsigned short : (unsigned short)0, signed short : (signed
> >>>>>> short)0,
> >>>>>> unsigned int : (unsigned int)0, signed int : (signed int)0,
> >>>>>> unsigned
> >>>>>> long : (unsigned long)0, signed long : (signed long)0,
> >>>>>> unsigned
> >>>>>> long
> >>>>>> long : (unsigned long long)0, signed long long : (signed long
> >>>>>> long)0,
> >>>>>> default: (typeof(*(&lock->locked)))0)) VAL; for (;;) { VAL =3D
> >>>>>> (typeof(_Generic((*(&lock->locked)), char: (char)0, unsigned
> >>>>>> char :
> >>>>>> (unsigned char)0, signed char : (signed char)0, unsigned
> >>>>>> short :
> >>>>>> (unsigned short)0, signed short : (signed short)0, unsigned
> >>>>>> int :
> >>>>>> (unsigned int)0, signed int : (signed int)0, unsigned long :
> >>>>>> (unsigned
> >>>>>> long)0, signed long : (signed long)0, unsigned long long :
> >>>>>> (unsigned
> >>>>>> long long)0, signed long long : (signed long long)0, default:
> >>>>>> (typeof(*(&lock->locked)))0)))(*(volatile typeof(*__ptr)
> >>>>>> *)&(*__ptr));
> >>>>>> if (!VAL) break; ({ __label__ l_break, l_continue; asm
> >>>>>> volatile
> >>>>>> goto("may_goto %l[l_break]" :::: l_break); goto l_continue;
> >>>>>> l_break:
> >>>>>> goto release_err; l_continue:; }); ({}); } (typeof(*(&lock-
> >>>>>>> locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({ unsigned
> >>>>>>> long
> >>>>>>> __val;
> >>>>>> __sync_fetch_and_add(&__val, 0); }); else asm volatile("" :::
> >>>>>> "memory"); }); }); (typeof(*(&lock->locked)))__val; });
> >>>>>>        |
> >>>>>> ^                         ~~~~~
> >>>>>> 1 error generated.
> >>>>> hmm. The error is impossible to read.
> >>>>>
> >>>>> Kumar,
> >>>>>
> >>>>> Do you see a way to silence it differently ?
> >>>>>
> >>>>> Without adding (void)...
> >>>>>
> >>>>> Things like:
> >>>>> -       bpf_obj_new(..
> >>>>> +       (void)bpf_obj_new(..
> >>>>>
> >>>>> are good to fix, and if we could annotate
> >>>>> bpf_obj_new_impl kfunc with __must_check we would have done it,
> >>>>>
> >>>>> but
> >>>>> -               arch_mcs_spin_lock...
> >>>>> +               (void)arch_mcs_spin_lock...
> >>>>>
> >>>>> is odd.
> >>>> What do you think about moving (void) to the definition of
> >>>> arch_mcs_spin_lock_contended_label()? I can send a v2 if this is
> >>>> better.
> >>> Kumar,
> >>>
> >>> thoughts?
> >> Sorry for the delay, I was afk.
> >>
> >> The warning seems a bit aggressive, in the kernel we have users which
> >> do and do not use the value and it's fine.
> >> I think moving (void) inside the macro is a problem since at least
> >> rqspinlock like algorithm would want to inspect the result of the
> >> locked bit.
> >> No such users exist for now, of course. So maybe we can silence it
> >> until we do end up depending on the value.
> >>
> >> I will give a try with clang-21, but I think probably (void) in the
> >> source is better if we do need to silence it.
> > Gentle ping.
> >
> > This is still an issue with clang version 21.0.0
> > (++20250522112647+491619a25003-1~exp1~20250522112819.1465).
> >
> I cannot reproduce the "unused expressions" error. What is the
> llvm cmake command line you are using?
>

Sorry for the delay. I tried just now with clang built from the latest
git checkout but I don't see it either.
I built it following the steps at
https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst.

