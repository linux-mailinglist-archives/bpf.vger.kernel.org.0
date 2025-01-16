Return-Path: <bpf+bounces-49121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB0A14440
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1207F188CD79
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68F2236EC6;
	Thu, 16 Jan 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDdaEuq8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6A22BAC9;
	Thu, 16 Jan 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064517; cv=none; b=bxnBgDZJ8gN/LSdqw20oSO9zrqBzWczY6uSXiVcq1GF9b+q1Sloha8ysxVCyLy20WiZ1PIAg9Shh5EgfuVG8xAxiDCvenugIWMIne2Bzvez3eSMh3aiLN6lgNYhbR2zno3zNO30ePqUXrFR45u4OyXaxSySx0XlkljvvvV8pRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064517; c=relaxed/simple;
	bh=rdeNiv+Q7lUlMaf0PSHLDli7kYT8Yjhhx5GzhA1whWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB1ePoCbxyB+3r4guFHLnCFbnlZaw4k/b0pHdllxomxegRTJ2Acr4R/XUDGhOpxnoSgiuL/zybw5SP+4DehY9nX612fT0+HdMG1XygikK3vFgtJ66KZ2x/BA1qk9qGsjP1tFO2XvvrRaAnMdpN8txjtN0Ck8hbEjXX6Hf6EELJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDdaEuq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF60C4CED6;
	Thu, 16 Jan 2025 21:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064516;
	bh=rdeNiv+Q7lUlMaf0PSHLDli7kYT8Yjhhx5GzhA1whWc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lDdaEuq8E0bYcyNaQUi3lbgiBXac0XC4cqDPsps4YMySo3qlUhYqbhgRZmA9H0rPu
	 k8SJgxBjJXLMpVg7QAIPNDhO68Y5pkZKTk6jxpmAUcIdfiXzvrW9iPLT4aYNK/hB6O
	 5Er/omUrknCnOE+ZDZLT04Ogl69gQyEtN8+bUyIrWA9vIScOt1Mnxn+0OUQ9bDDap0
	 AUyX5JFWUHAL21o4Gj4oSJehPlQOQCcMsedty7rNjUqJWH6+0PLsVD6T+LNpa4VSgZ
	 DEz0ZiXLC+1+BpRowgEDeYzIZAHUnGEla32DH1HWOnpP6OAuXxBthqeMSgc+TRnl15
	 3sGuHlMqkz+eg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 861F6CE1311; Thu, 16 Jan 2025 13:55:16 -0800 (PST)
Date: Thu, 16 Jan 2025 13:55:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH rcu 13/17] srcu: Add SRCU-fast readers
Message-ID: <8d3242ec-1e56-4a51-a950-20a185a5cc3b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
 <20250116202112.3783327-13-paulmck@kernel.org>
 <CAADnVQ+fz7DQ9O=4F-4NNo1J7=dkiDAfYa+Fc5WXBK0yH0f=TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+fz7DQ9O=4F-4NNo1J7=dkiDAfYa+Fc5WXBK0yH0f=TQ@mail.gmail.com>

On Thu, Jan 16, 2025 at 01:00:24PM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 16, 2025 at 12:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > +/*
> > + * Counts the new reader in the appropriate per-CPU element of the
> > + * srcu_struct.  Returns a pointer that must be passed to the matching
> > + * srcu_read_unlock_fast().
> > + *
> > + * Note that this_cpu_inc() is an RCU read-side critical section either
> > + * because it disables interrupts, because it is a single instruction,
> > + * or because it is a read-modify-write atomic operation, depending on
> > + * the whims of the architecture.
> > + */
> > +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
> > +{
> > +       struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> > +
> > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
> > +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> > +       barrier(); /* Avoid leaking the critical section. */
> > +       return scp;
> > +}
> 
> This doesn't look fast.
> If I'm reading this correctly,
> even with debugs off RCU_LOCKDEP_WARN() will still call
> rcu_is_watching() and this doesn't look cheap or fast.

Here is the CONFIG_PROVE_RCU=n definition:

	#define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))

The "0" in the "0 && (c)" should prevent that call to rcu_is_watching().

But why not see what the compiler thinks?  I added the following function
to kernel/rcu/srcutree.c:

struct srcu_ctr __percpu *test_srcu_read_lock_fast(struct srcu_struct *ssp)
{
	struct srcu_ctr __percpu *p;

	p = srcu_read_lock_fast(ssp);
	return p;
}

This function compiles to the following code:

Dump of assembler code for function test_srcu_read_lock_fast:
   0xffffffff811220c0 <+0>:     endbr64
   0xffffffff811220c4 <+4>:     sub    $0x8,%rsp
   0xffffffff811220c8 <+8>:     mov    0x8(%rdi),%rax
   0xffffffff811220cc <+12>:    add    %gs:0x7eef3944(%rip),%rax        # 0x15a18 <this_cpu_off>
   0xffffffff811220d4 <+20>:    mov    0x20(%rax),%eax
   0xffffffff811220d7 <+23>:    test   $0x8,%al
   0xffffffff811220d9 <+25>:    je     0xffffffff811220eb <test_srcu_read_lock_fast+43>
   0xffffffff811220db <+27>:    mov    (%rdi),%rax
   0xffffffff811220de <+30>:    incq   %gs:(%rax)
   0xffffffff811220e2 <+34>:    add    $0x8,%rsp
   0xffffffff811220e6 <+38>:    jmp    0xffffffff81f5fe60 <__x86_return_thunk>
   0xffffffff811220eb <+43>:    mov    $0x8,%esi
   0xffffffff811220f0 <+48>:    mov    %rdi,(%rsp)
   0xffffffff811220f4 <+52>:    call   0xffffffff8111fb90 <__srcu_check_read_flavor>
   0xffffffff811220f9 <+57>:    mov    (%rsp),%rdi
   0xffffffff811220fd <+61>:    jmp    0xffffffff811220db <test_srcu_read_lock_fast+27>

The first call to srcu_read_lock_fast() invokes __srcu_check_read_flavor(),
but after that the "je" instruction will fall through.  So the common-case
code path executes only the part of this function up to and including the
"jmp 0xffffffff81f5fe60 <__x86_return_thunk>".

Does that serve?

							Thanx, Paul

