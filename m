Return-Path: <bpf+bounces-63629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02EB09191
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47A2166871
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B022FA640;
	Thu, 17 Jul 2025 16:19:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B001F8725;
	Thu, 17 Jul 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769180; cv=none; b=E8MnQjITdER2XbN47KISFvGyV0lxTrnk3Av+p5fFqmdtWDqucQKS0zCbAGR4L8UcQqqdlSlCShjSWUFpE8ynIz7IMBTqeMsgT0SKib9KAUvrEp/EKLAJwcnFTLjIvYCLj/Iwqodag59hwnZe9fopB5/QOZGAWH/Jn2OJkx+sk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769180; c=relaxed/simple;
	bh=zyVsdAl8M2hwLLcgWjwH2lrEtkq4tLivn3VgWIRNc9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giPHRUh9kReGxqTYJnmUQNzHV0Q2j5U1KlE6qj5xWNeKX4Tse4u+/D6t8VGHfT4fnu7tguLVix4+LaFVgZkw7De0ax18Tv/WWtDhOwoxM8PMgU+CHEQYQq3EjOhXCKraSmJGLyH2IK+Ss8grNWDM9GkKGvRuDZHPx83U6dcb1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 824CB140154;
	Thu, 17 Jul 2025 16:19:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id B870120026;
	Thu, 17 Jul 2025 16:19:25 +0000 (UTC)
Date: Thu, 17 Jul 2025 12:19:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <20250717121924.7d5549f2@batman.local.home>
In-Reply-To: <CAADnVQJwpM=DfWjYe12pbx=Yb9NR5MRktzwgV_ALjLqMR3w9nw@mail.gmail.com>
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
	<29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
	<acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
	<ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
	<512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
	<bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
	<16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
	<20250716110922.0dadc4ec@batman.local.home>
	<895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
	<bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
	<e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
	<CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
	<20250717111216.4949063d@batman.local.home>
	<CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
	<20250717114028.77ea7745@batman.local.home>
	<20250717115510.7717f839@batman.local.home>
	<CAADnVQJwpM=DfWjYe12pbx=Yb9NR5MRktzwgV_ALjLqMR3w9nw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B870120026
X-Stat-Signature: yqpei3kibyawnrqz9rzebzuosh1yqi4i
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FDy0cGsHdsURV7LUII6F6HBtwbHZrff8=
X-HE-Tag: 1752769165-600123
X-HE-Meta: U2FsdGVkX1/kX8EcLo5sJgKdKvVQvI4dVj/4WIlyiwvdW1It4tT2Yj5quiWHcSOJXxsfXAB9ht0IrPm3N4R7VyMzib2qHrQuQ9qsyROHaQjTqcU88qVoZpVHsVA1ibfIUyrnIChL0WoYpfQg59f+DrT+BGeDoKEcXxGnSwfdX41cxo+V/+dqGti6PEUm4P9Jx/em4tB7CIZMdMl6bXBOvr8vfcSC+SkjFhQD4RBbW30e7Cu0f4dmMLcWZBtEXa6NbE7lzpJjwEXwTMl37h+DU6iJhG0/VXiamEgkKTFsW3yeto9GabfI4TxYFHmquXaXGZHR3ESJyULxm+n8bjxKPs2gBuFFt14R

On Thu, 17 Jul 2025 09:02:38 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Stop blaming the users. Tracepoints disable preemption for now
> good reason and you keep shifting the blame.
> Fix tracepoint infra.

The fix *is* to have tracepoints not disable preemption. Your first
reply said:

   There is no need to replace existing preempt_disable wrappers
   with sleepable srcu_fast or anything else.

What is it? To replace the existing preemptable wrappers is the
solution. But you said it isn't needed.

Those using PREEMPT_RT look to blame the users that cause unbounded
latency. When you design an RT system, you look at what causes
unbounded latency and disable it.

Blaming the users is part of the process!

If BPF programs attached to tracepoints cannot be preempted, it means
it must not be used with PREEMPT_RT. FULL STOP!

It doesn't mean BPF programs can't be used. It just can't be used when
you care about bounded latency.

There's even people looking into configuring the kernel where if
anything gets called that can cause an unbounded latency, it would
trigger BUG(). As crashing the kernel in safety critical systems is
actually better than missing a deadline.

-- Steve

