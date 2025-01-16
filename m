Return-Path: <bpf+bounces-49126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E26A144F2
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718291636E9
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD2234CE4;
	Thu, 16 Jan 2025 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4E7OU3e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E422F3B4;
	Thu, 16 Jan 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068302; cv=none; b=GYoXvqoVxCg9higVqmHxLQgFr6ic0wundnFynh51a/nKDXSZjrjAzGUct0mlEshhznKf9fK7anj5n7IhC7IIKjWiZVilZvZdQ0P1cfJW/bhVjM24vjBj8L+UK4LV/uepCZP2scQ4pp+O3Byc3OqPCsTuOWMc8mCOKZeqlrOQenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068302; c=relaxed/simple;
	bh=mxtL5RdfO7vxrN//7liLlbbZ19NkFzUKczenrQRD6TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/hn9pB2ITvEijncAycyr6QwT9Rn0SM0HO8Bh8i6lBXXsogkJ2XGZSqozbK6xBOSM5RqjhOYd7lg2FXTVnOFRXLQM9i9EfXaWfC9cvtf8/6t3JbDnHawf05Gxe/Jr7/M6xt3yduqN1d6P/pYybEqlVztTvGllPUcdcfnCvbkmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4E7OU3e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43618283dedso14005265e9.3;
        Thu, 16 Jan 2025 14:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737068299; x=1737673099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VVR3fyPsYwKM2x2GcXvzt5VHyXnkVv+GJT5vhxs4D4=;
        b=d4E7OU3eRQefRmwqWB8Aj5LNjBFS79o1jUM6YsdcWvTLLk5+PTZo2yIegX5WJicBVN
         JXIbridBhGBQZUsfXEKxeef53Jvj09l0IwxXo1XHCfHUAK1e0OWSuR47t+NvxZeHu4fu
         4q9TGgtjDZh4Ysdc10LcyJ1QOhR88PA2RQLyDifu//3AMUyE3JVp/jsscH23d2foL5ib
         NgUpCvnQ+djVUzQSQS1O0159KwzIOEwR1r0B4MU5IbV96RvZnYeVbgxaR6d34hQC6DBN
         rxghB75aQ0AqPjSl0Yugs5L9loS/+wW87r1BgNeuNzk658zAVy2FoCoMrUhp93e5hgOD
         v9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737068299; x=1737673099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VVR3fyPsYwKM2x2GcXvzt5VHyXnkVv+GJT5vhxs4D4=;
        b=V5lAdrW93tumfwSMMP6AHqdjJqoag8XfJYY15LfCxCh+VrF21arzqeSyt2leLl7wls
         CvR5QdLCDx4s7c8xG/bijcK1Zxx5FtToIrAUbxNsIxIi3YPwumeeRps0wltvWe0x97rS
         XwB3Ai/Z+bISZzGnS0jFM384hrZrT6ynQcBXQ/xOyo61qw4JmG2QkmEPAUog/BttrUoZ
         tDImXFqv/5/Jjx/3lQzlu82lAtpqDPD+zZYdifiAXRk0AmLUkFvCNETU+xpB+OAaGY+N
         9I3/xaArX962Gkc0X0/yobz6jObREisO0XSXEEKTEqaFFtD4gqD+BK0LPM9hHHUssySD
         v5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU75XlpdMcFOWJnb9JC40SSrhSt1u7hXbJyDCuwO+D13Bh9bkuUhGfB037GKV6OEGZHono=@vger.kernel.org, AJvYcCUN9rLDang6AlyDxYXX/hAAx/ZazkapxYzSvaCf+yXC3b2bAgKMZWuTE1zK9VZkTigwTIqS+h0s+0hPglyp@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGOuHqjY8pMP4C3VzgrCI29OCqYpPLNod3Egn+fasDQGs9vMK
	Sg3OjJH8OnPY8jIFfm16i3Z4/qY8EnXVnl8Few3UyN0Mb2CPtEzohoqXRy7EwAXM8mBMoPRiP50
	D6+XMAMepntxLlpBu37fujNFp/lI=
X-Gm-Gg: ASbGncveZXEaicDsJi6BOY3KYiUPjqJb87wbKm6UElIhiscgJhohPNjSRnNv5Mg3IDw
	0ddH0W7GK2DXaAipKZRIww4lOiUsYn6iSw2tjphpEv1B4HjUEwuUaHg==
X-Google-Smtp-Source: AGHT+IEFk/MT5leOg9lIV+RvHHPnuCs/E6Z2iIGOAEFiG9YA4pCazLPFBb9DMiv7V16wr8PdjlC000d9A9VczZRmzvc=
X-Received: by 2002:a5d:5f56:0:b0:386:3e3c:efd with SMTP id
 ffacd0b85a97d-38bf57b757emr360829f8f.44.1737068298773; Thu, 16 Jan 2025
 14:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
 <20250116202112.3783327-13-paulmck@kernel.org> <CAADnVQ+fz7DQ9O=4F-4NNo1J7=dkiDAfYa+Fc5WXBK0yH0f=TQ@mail.gmail.com>
 <8d3242ec-1e56-4a51-a950-20a185a5cc3b@paulmck-laptop>
In-Reply-To: <8d3242ec-1e56-4a51-a950-20a185a5cc3b@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Jan 2025 14:58:05 -0800
X-Gm-Features: AbW1kvYwTOZjYKR4TjOeBW7HYJY9RoAxwYvzeHbs_yz0jtm_uvsU9Nhhyv7W_jE
Message-ID: <CAADnVQLE8HHU1GReeiou-S6PNJrK=E6NuZE-Pp68YTx6pDFnYg@mail.gmail.com>
Subject: Re: [PATCH rcu 13/17] srcu: Add SRCU-fast readers
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 1:55=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Jan 16, 2025 at 01:00:24PM -0800, Alexei Starovoitov wrote:
> > On Thu, Jan 16, 2025 at 12:21=E2=80=AFPM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > >
> > > +/*
> > > + * Counts the new reader in the appropriate per-CPU element of the
> > > + * srcu_struct.  Returns a pointer that must be passed to the matchi=
ng
> > > + * srcu_read_unlock_fast().
> > > + *
> > > + * Note that this_cpu_inc() is an RCU read-side critical section eit=
her
> > > + * because it disables interrupts, because it is a single instructio=
n,
> > > + * or because it is a read-modify-write atomic operation, depending =
on
> > > + * the whims of the architecture.
> > > + */
> > > +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct=
 srcu_struct *ssp)
> > > +{
> > > +       struct srcu_ctr __percpu *scp =3D READ_ONCE(ssp->srcu_ctrp);
> > > +
> > > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching sr=
cu_read_lock_fast().");
> > > +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> > > +       barrier(); /* Avoid leaking the critical section. */
> > > +       return scp;
> > > +}
> >
> > This doesn't look fast.
> > If I'm reading this correctly,
> > even with debugs off RCU_LOCKDEP_WARN() will still call
> > rcu_is_watching() and this doesn't look cheap or fast.
>
> Here is the CONFIG_PROVE_RCU=3Dn definition:
>
>         #define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
>
> The "0" in the "0 && (c)" should prevent that call to rcu_is_watching().
>
> But why not see what the compiler thinks?  I added the following function
> to kernel/rcu/srcutree.c:
>
> struct srcu_ctr __percpu *test_srcu_read_lock_fast(struct srcu_struct *ss=
p)
> {
>         struct srcu_ctr __percpu *p;
>
>         p =3D srcu_read_lock_fast(ssp);
>         return p;
> }
>
> This function compiles to the following code:
>
> Dump of assembler code for function test_srcu_read_lock_fast:
>    0xffffffff811220c0 <+0>:     endbr64
>    0xffffffff811220c4 <+4>:     sub    $0x8,%rsp
>    0xffffffff811220c8 <+8>:     mov    0x8(%rdi),%rax
>    0xffffffff811220cc <+12>:    add    %gs:0x7eef3944(%rip),%rax        #=
 0x15a18 <this_cpu_off>
>    0xffffffff811220d4 <+20>:    mov    0x20(%rax),%eax
>    0xffffffff811220d7 <+23>:    test   $0x8,%al
>    0xffffffff811220d9 <+25>:    je     0xffffffff811220eb <test_srcu_read=
_lock_fast+43>
>    0xffffffff811220db <+27>:    mov    (%rdi),%rax
>    0xffffffff811220de <+30>:    incq   %gs:(%rax)
>    0xffffffff811220e2 <+34>:    add    $0x8,%rsp
>    0xffffffff811220e6 <+38>:    jmp    0xffffffff81f5fe60 <__x86_return_t=
hunk>
>    0xffffffff811220eb <+43>:    mov    $0x8,%esi
>    0xffffffff811220f0 <+48>:    mov    %rdi,(%rsp)
>    0xffffffff811220f4 <+52>:    call   0xffffffff8111fb90 <__srcu_check_r=
ead_flavor>
>    0xffffffff811220f9 <+57>:    mov    (%rsp),%rdi
>    0xffffffff811220fd <+61>:    jmp    0xffffffff811220db <test_srcu_read=
_lock_fast+27>
>
> The first call to srcu_read_lock_fast() invokes __srcu_check_read_flavor(=
),
> but after that the "je" instruction will fall through.  So the common-cas=
e
> code path executes only the part of this function up to and including the
> "jmp 0xffffffff81f5fe60 <__x86_return_thunk>".
>
> Does that serve?

Thanks for checking.
I was worried that in case of:
while (0 && (c))
the compiler might need to still emit (c) since it cannot prove
that there are no side effects there.
I vaguely recall now that C standard allows to ignore 2nd expression
when the first expression satisfies the boolean condition.

