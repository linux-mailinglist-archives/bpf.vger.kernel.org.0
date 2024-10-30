Return-Path: <bpf+bounces-43596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBF9B6B2B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 18:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148FE1C2176C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94931212F1D;
	Wed, 30 Oct 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsM/urZO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C51BD9C0;
	Wed, 30 Oct 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309971; cv=none; b=C5w8T3pAlCb4ZJqCdjIQ89LQTypT8DHwHPmK3Ao33EdFIte6w48yZBY7dmXjAGi0+iAVVKR15LGeB2yuGapI/0/3jhFlU2GEaIHXGPRBlwO5Ze89q4TGEkWCQaP8shz1uP2m/2fofZ6TC4mfh/zugOARioICq5BpVRWc8I/gQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309971; c=relaxed/simple;
	bh=tAF2qP4LNMaTA5Al21nxn6HftTk7TKjha2xG9IqFUSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvUkvvHa9etIywkNAiYLdTavRMfh8bNhzHUjmHdtlfNx/FGdJUfx8M3uZgIy2bsKwvnCjDVYMS2szU9nseP+uPyrEA4Fj/inBspo5OMtKuPwX3pVtw1SJ2geKH6DCISsN3wrcaXEzwur5YV8mCCOv/X4OzjFdPGTUiFVxqL11Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsM/urZO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so64745b3a.0;
        Wed, 30 Oct 2024 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730309968; x=1730914768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYJ1Q/lWqkK3Cg7z3hIgRYLOhSjE/i7vB7XiHiOeAZ0=;
        b=OsM/urZOXBr2xR3vIMNSF2X8OybEBi4hbYiCtUV+zkuONPu95eZdFXEmFh7H314PNi
         KEbJCcQ8d73uTSw74MM/jjNbpMghOgyBQ3nCcxbbBy9vGCW9ZUMP04nfXosK/LuH4qK7
         yahYJ3AoJW7A6xXgCn6qvoBnAH1iTMGdajn035F6BGpu1DWe+OyRuZAVpanqG6Bv8moy
         zUI2ddPlWBmV4mhnHw90aR7kw0MkRXWREGDvS+M1/FRIehDXkZaU6JaMi9Y6K8epZX9t
         86P5nJx+KALP2/Q3wCg2I20nekLTel3pQ5JJRyiZWPZqkX43KRwXKcuiwouoxAfD6xRY
         RgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309968; x=1730914768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYJ1Q/lWqkK3Cg7z3hIgRYLOhSjE/i7vB7XiHiOeAZ0=;
        b=WXsT4f2U/F5B8qhVAygRXk5hBBuSyPXamlnojYXcXHttlu1t5zHsKVOyhlH35R1CNf
         b6B0X7uYFRF2DK0+WmhSmAMvgJogrngY6ti4Bl4VUB05eetG7SJBABKlM+dy6WFfA2z2
         WzWHo5EDy9hxUlMhFbXJ/sCWD9kndw44TWiQiv2IBCChnvYOp6WSuGGpvNMW/tt9CmBT
         GwDq39+dnaQdb/e0NEfY3KNZJApo2nCafQFN86UsvYHNx8fFgljzElLxtyPVkzFgsJJK
         H+emhvBuGyOBD2PdygOQ4mnqv+l3fZ2lWUjA8mjuFovAZ2pHFOSEnwSI0gVFnCpjQR9z
         gVpw==
X-Forwarded-Encrypted: i=1; AJvYcCVuW92EbE3xaz5kTJUypwX6eiUZ+B+9bY2FtoE2UzS+mioMyfcPO8mWzmoVdLIq74s0AYWp20FFWX3e/jqW@vger.kernel.org, AJvYcCXkxC7JTXigD5AFlvIFPmelRXfXhvVeNgnBgP/QUZcyEPElZ9r9jKjfIt53gEklPeIaW1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSCKqU4WJyE3CV+5KnmRvU5l9AFdzUR8sYPZFYfJHr4/27R35
	8JL2pkXSl+U94NKG+uPfBkYJaiKpBh8n6645tyMwnoY0hVqnHd5WOEwz+pBPv94fG4G2yViUh2i
	mbj102xaLoUdxZHKLzoC048s9wO0=
X-Google-Smtp-Source: AGHT+IFaMPK9Sdz1U5LgrWNoHuzUscjFnKXDgOvap9NtC+XfxHjP1Qx/vOvXvvbJcIAxkllNS5OO3doVBzZkBJeGPQ0=
X-Received: by 2002:a05:6a00:1742:b0:71e:722b:ae1d with SMTP id
 d2e1a72fcca58-72063059df3mr21500836b3a.25.1730309968461; Wed, 30 Oct 2024
 10:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnT59wzKxob03OOOfvVh67MQkpWvzvfmzv3D-_bGeM=rJA@mail.gmail.com>
 <20241029002814.505389-1-jrife@google.com> <CAADnVQJeWj2t9XSRxK5NU99GJsOBnropoOOohDNPj7N2xZFGEQ@mail.gmail.com>
 <CADKFtnTUmRe1T92BQ_NB=V7DW13hAKpA40rm+m6DkpTNf5RyFw@mail.gmail.com>
In-Reply-To: <CADKFtnTUmRe1T92BQ_NB=V7DW13hAKpA40rm+m6DkpTNf5RyFw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 30 Oct 2024 10:39:16 -0700
Message-ID: <CAEf4BzZkDjCqDu56M=aAn2exnmaV=SZ6rWdFbAO4wkkzZHS2Zg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
To: Jordan Rife <jrife@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 10:34=E2=80=AFAM Jordan Rife <jrife@google.com> wro=
te:
>
> > > [  687.334265][T16276] allocated by task 16281 on cpu 1 at 683.953385=
s (3.380878s ago):
> > > [  687.335615][T16276]  tracepoint_add_func+0x28a/0xd90
> > > [  687.336424][T16276]  tracepoint_probe_register_prio_may_exist+0xa2=
/0xf0
> > > [  687.337416][T16276]  bpf_probe_register+0x186/0x200
> > > [  687.338174][T16276]  bpf_raw_tp_link_attach+0x21f/0x540
> > > [  687.339233][T16276]  __sys_bpf+0x393/0x4fa0
> > > [  687.340042][T16276]  __x64_sys_bpf+0x78/0xc0
> > > [  687.340801][T16276]  do_syscall_64+0xcb/0x250
> > > [  687.341623][T16276]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > I think the stack trace points out that the patch [1] isn't really fixi=
ng it.
> > UAF is on access to bpf_link in __traceiter_sys_enter
>
> The stack trace points to the memory in question being allocated by
> tracepoint_add_func where allocation and assignment to
> __tracepoint_sys_enter->funcs happens. Mathieu's patch addresses
> use-after-free on this structure by using call_rcu_tasks_trace inside
> release_probes. In contrast, here is what the "allocated by" trace
> looks like for UAF on access to bpf_link (copied from the original
> KASAN crash report [4]).
>
> > Allocated by task 5681:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
> >  kasan_kmalloc include/linux/kasan.h:260 [inline]
> >  __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4304
> >  kmalloc_noprof include/linux/slab.h:901 [inline]
> >  kzalloc_noprof include/linux/slab.h:1037 [inline]
> >  bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3829
> >  bpf_raw_tracepoint_open+0x177/0x1f0 kernel/bpf/syscall.c:3876
> >  __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5691
> >  __do_sys_bpf kernel/bpf/syscall.c:5756 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5754 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5754
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> This clearly points to where memory for a bpf_link is allocated.
>
> > link =3D kzalloc(sizeof(*link), GFP_USER);
> > if (!link) {
> >     err =3D -ENOMEM;
> >     goto out_put_btp;
> > }
>
> To add some context, if I apply Mathieu's patch alone then I get no
> meaningful test signal when running the reproducer, because the UAF
> crash almost always occurs first on accesses to bpf_link or bpf_prog
> showing a trace like the second one above. My intent in applying patch
> [1] is to mask out these sources of UAF-related crashes on the BPF
> side to just focus on what this series addresses. This series should
> eventually be tested end-to-end with Andrii's fix for the BPF stuff
> that he mentioned last week, but that would rely on this patch series,
> tracepoint_is_faultable() in particular, so it's kind of chicken and

Yep, agreed. I'll need this patch set landed before landing my fixes.
Mathieu's patch set fixes one set of issues, so I'd say we should land
it and unblock BPF link-specific fixes.

> egg in terms of testing. In the meantime, [1] provides a bandaid to
> allow some degree of test coverage on this patch.
>
> > while your patch [1] and all attempts to "fix" were delaying bpf_prog.
> > The issue is not reproducing anymore due to luck.
>
> [1] chains call_rcu_tasks_trace and call_rcu to free both bpf_prog and
> bpf_link after unregistering the trace point. This grace period should
> be sufficient to prevent UAF on these structures from the syscall TP
> handlers which are protected with rcu_read_lock_trace. I've run the
> reproducer many times. Without /some/ fix on the BPF side it crashes
> reliably within seconds here. Using call_rcu_tasks_trace or chaining
> it with call_rcu eliminates UAF on the BPF stuff which eliminates a
> couple of variables for local testing.
>
> If you are not convinced, I'm happy to run through other test
> scenarios or run the reproducer for much longer.
>
> -Jordan

