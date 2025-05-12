Return-Path: <bpf+bounces-58045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF1EAB44F8
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97572460EA1
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC4299931;
	Mon, 12 May 2025 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyT1eic4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F79298C10
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747078201; cv=none; b=uwYOw+IOm0u1Fj+kCG3zl/1SWkz4tgUxaswVvt97QE5l155R0gpgSEWJTsk+hYeJtrb4uj9XRCR7D3pnJxx+AbAumnPcJV8H8RD+JRXikUjvM7sGxYeLuCsGRQ3OJR4k3PyEakjI7KGxjjpOpDVqnWTjD7pTbQVpg/eHhz3iBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747078201; c=relaxed/simple;
	bh=0i411t71ziBb7mfIj2vpsg1UT8kDVAgg1QEik/Xu3NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfvrslyU/jDr4WE7ydkTSvMM8P3Z+lb1oVw1ma7DRWJV+0ifeFLO61JZ60B+dL1Q35e/V72eGHaafvyKXzqMkoMhlzpKo71KWvf4wWVFXCUYiXY4yCqL6bKwAoNFrrSs8GJAE5HDv/TGR/Vr0zTXxQMUiZQ7pvfs3qB4lrmpUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyT1eic4; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5fbfdf7d353so6402265a12.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747078198; x=1747682998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKiEFJzVwPSqHWbjsTwSt4cr/R4Son2CynGQm62HkXg=;
        b=VyT1eic4O8vb2531l1Byyik2xvgyqj40VCOzFmxI2EgpJp/JuUQoyTlcxkwFWkx+G1
         WXnK8DImg7aT8gunB45may/nbsqycdWwFEmn+s3SmFFt7utj5eLheHUDzgCvam4k6j5i
         P+4GPAsKxqHeJZH/JWmV5JCjK4Lb3LiOX7sRhgUKzBflfatpLGlUZxUzBWP2DYcQ1b95
         vedVwqR5AvzbV4Esw+dvex/sWXC6UfC/KdnezjwB2bcbufGGw5pVOwijnZgrCBGp7L+q
         iWP4hg4E0wDlARmoCml+6MVUqzJ/bgXRfm4TUc+Rt9VEQQTvln2l1RE1p7WT1WU25ORM
         Ti4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747078198; x=1747682998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKiEFJzVwPSqHWbjsTwSt4cr/R4Son2CynGQm62HkXg=;
        b=lApNZ+5E7ktSxloJeWB0m9R3UZdetLBjit19u3sS6rORUzHh8YCN0lKkE9RjK2r/xa
         lXEvY434JeKTLZ9V3/f9HkZmU2h2G/xNQqGdhzf6ZAoSkE8DOOzcdA821x1WFa1MFBcD
         uIWLd/B+C5ulV25/rEU7l2061Or31Qwnqa/G/7mg8/+l53gHfmceFFT82ljpIyLZHpcI
         Gthp4zFJOEVQ9Qc/b5uWoed6SqlMrPKfLTB7y2/C8EgaNHkaoA5kZvDG5Y+O884jXBJs
         X7D3g193C7xm9b9rUk1ND7q8zkUb44NNYxdfNs2fLHv1vV1wJRs4vLNygCDJJ+Ip2LbR
         tdCw==
X-Forwarded-Encrypted: i=1; AJvYcCXnlYUeSqenPf2GUq2s1IyXe8NLvBrkPt7n/vGxJ40p2D8QNmrAEgZy63z5Sj/XPwSSdQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGjQJKc5XNBzgAth1eIJKwd5VthM1Z3zhedJjZ5AxVXxtoKfT
	Y2Lw+ymnEEjqgmh3+9imSBjrnW3VqZnRct/dg87E3vIj0XlFD6bujecU5LzYBOeAKBv+8DddOot
	1tM72lAwQO9gJBkT+VspFBBkALvo=
X-Gm-Gg: ASbGnct/YPDAqAnPh/pGL+2ag9ZQ49yA3n6LF6OS+iDxFWr3F4orR6/WdnxJcTfA2oh
	1QTUd5M63w0+0a+wUyqpnq4L4s7FA7Ebq7HujcSVARY9yYYRllK6tRsQPnB3e7Has/Ea/yt9idi
	KY9gB+wWfNMU5Dr+W0BZy9dvPPvoSSKzVgZQ==
X-Google-Smtp-Source: AGHT+IG9UgKTm04Imzp/kUC9/HJnjZDfTgcStHoB3bvL6gB3aD9OJrk/0ldlr/JKDV0CwYAv86LGW/+jfhWZf2fMFis=
X-Received: by 2002:a17:907:7f21:b0:ad1:7858:a74c with SMTP id
 a640c23a62f3a-ad218fc1f1fmr1249994266b.22.1747078197439; Mon, 12 May 2025
 12:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508113804.304665-1-iii@linux.ibm.com> <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
 <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
 <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com>
 <7a242102eecdd17b4d35c1e4f7d01ea15cb8066a.camel@linux.ibm.com> <CAADnVQ+5h9UESAgNA58HEQ-0zwxn=c0+ibH++NF9farR5-JB8g@mail.gmail.com>
In-Reply-To: <CAADnVQ+5h9UESAgNA58HEQ-0zwxn=c0+ibH++NF9farR5-JB8g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 May 2025 15:29:19 -0400
X-Gm-Features: AX0GCFs9IrNPeGH3MeR_08igt_3-0nArCfjAmZePqP2Uishy9NvuPOC16sqJMDw
Message-ID: <CAP01T74iix8HvmVYowFyrG98tDRw8JMOck7HQLD57nuo7SyuoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused" warnings
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 at 12:41, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 12, 2025 at 5:22=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.c=
om> wrote:
> >
> > On Fri, 2025-05-09 at 09:51 -0700, Alexei Starovoitov wrote:
> > > On Thu, May 8, 2025 at 12:21=E2=80=AFPM Ilya Leoshkevich <iii@linux.i=
bm.com>
> > > wrote:
> > > >
> > > > On Thu, 2025-05-08 at 11:38 -0700, Alexei Starovoitov wrote:
> > > > > On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevich
> > > > > <iii@linux.ibm.com>
> > > > > wrote:
> > > > > >
> > > > > > clang-21 complains about unused expressions in a few progs.
> > > > > > Fix by explicitly casting the respective expressions to void.
> > > > >
> > > > > ...
> > > > > >         if (val & _Q_LOCKED_MASK)
> > > > > > -               smp_cond_load_acquire_label(&lock->locked,
> > > > > > !VAL,
> > > > > > release_err);
> > > > > > +               (void)smp_cond_load_acquire_label(&lock-
> > > > > > >locked,
> > > > > > !VAL, release_err);
> > > > >
> > > > > Hmm. I'm on clang-21 too and I don't see them.
> > > > > What warnings do you see ?
> > > >
> > > > In file included from progs/arena_spin_lock.c:7:
> > > > progs/bpf_arena_spin_lock.h:305:1756: error: expression result
> > > > unused
> > > > [-Werror,-Wunused-value]
> > > >   305 |   ({ typeof(_Generic((*&lock->locked), char: (char)0,
> > > > unsigned
> > > > char : (unsigned char)0, signed char : (signed char)0, unsigned
> > > > short :
> > > > (unsigned short)0, signed short : (signed short)0, unsigned int :
> > > > (unsigned int)0, signed int : (signed int)0, unsigned long :
> > > > (unsigned
> > > > long)0, signed long : (signed long)0, unsigned long long :
> > > > (unsigned
> > > > long long)0, signed long long : (signed long long)0, default:
> > > > (typeof(*&lock->locked))0)) __val =3D ({ typeof(&lock->locked) __pt=
r
> > > > =3D
> > > > (&lock->locked); typeof(_Generic((*(&lock->locked)), char: (char)0,
> > > > unsigned char : (unsigned char)0, signed char : (signed char)0,
> > > > unsigned short : (unsigned short)0, signed short : (signed short)0,
> > > > unsigned int : (unsigned int)0, signed int : (signed int)0,
> > > > unsigned
> > > > long : (unsigned long)0, signed long : (signed long)0, unsigned
> > > > long
> > > > long : (unsigned long long)0, signed long long : (signed long
> > > > long)0,
> > > > default: (typeof(*(&lock->locked)))0)) VAL; for (;;) { VAL =3D
> > > > (typeof(_Generic((*(&lock->locked)), char: (char)0, unsigned char :
> > > > (unsigned char)0, signed char : (signed char)0, unsigned short :
> > > > (unsigned short)0, signed short : (signed short)0, unsigned int :
> > > > (unsigned int)0, signed int : (signed int)0, unsigned long :
> > > > (unsigned
> > > > long)0, signed long : (signed long)0, unsigned long long :
> > > > (unsigned
> > > > long long)0, signed long long : (signed long long)0, default:
> > > > (typeof(*(&lock->locked)))0)))(*(volatile typeof(*__ptr)
> > > > *)&(*__ptr));
> > > > if (!VAL) break; ({ __label__ l_break, l_continue; asm volatile
> > > > goto("may_goto %l[l_break]" :::: l_break); goto l_continue;
> > > > l_break:
> > > > goto release_err; l_continue:; }); ({}); } (typeof(*(&lock-
> > > > > locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({ unsigned long
> > > > > __val;
> > > > __sync_fetch_and_add(&__val, 0); }); else asm volatile("" :::
> > > > "memory"); }); }); (typeof(*(&lock->locked)))__val; });
> > > >       |
> > > > ^                         ~~~~~
> > > > 1 error generated.
> > >
> > > hmm. The error is impossible to read.
> > >
> > > Kumar,
> > >
> > > Do you see a way to silence it differently ?
> > >
> > > Without adding (void)...
> > >
> > > Things like:
> > > -       bpf_obj_new(..
> > > +       (void)bpf_obj_new(..
> > >
> > > are good to fix, and if we could annotate
> > > bpf_obj_new_impl kfunc with __must_check we would have done it,
> > >
> > > but
> > > -               arch_mcs_spin_lock...
> > > +               (void)arch_mcs_spin_lock...
> > >
> > > is odd.
> >
> > What do you think about moving (void) to the definition of
> > arch_mcs_spin_lock_contended_label()? I can send a v2 if this is
> > better.
>
> Kumar,
>
> thoughts?

Sorry for the delay, I was afk.

The warning seems a bit aggressive, in the kernel we have users which
do and do not use the value and it's fine.
I think moving (void) inside the macro is a problem since at least
rqspinlock like algorithm would want to inspect the result of the
locked bit.
No such users exist for now, of course. So maybe we can silence it
until we do end up depending on the value.

I will give a try with clang-21, but I think probably (void) in the
source is better if we do need to silence it.

