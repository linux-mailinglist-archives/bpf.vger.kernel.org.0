Return-Path: <bpf+bounces-63612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C7B0904C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9574E4A169F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FAA2F8C24;
	Thu, 17 Jul 2025 15:12:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED422F85E9;
	Thu, 17 Jul 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765146; cv=none; b=SZipgOWIoRK1puLMqhkXcnB1sP5VXWhuzKqoCq+hgbBWILazhiPL8+5PodH3s8yP6CQXv8Amn4kxR0/qnIPVIAhnXP9GpLZy6TOoRYlUMQy+dG34ZU4O0728pI3OevPgo0GtapT4s5tdiSSTHhHcKFWJ381xvdnCyDUCQa+OUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765146; c=relaxed/simple;
	bh=xxGj8cNrd82Pl24JxRI0cygThMCZ/XGFAujXMZmBd7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJDCC8V+8r1bylZR+jqK04jqdI3uhAQADIZ15ZNR8WIuonyY7mCCofNbue+mtlHGQ477k7mc38Csf5L6Le6dWsk6SdkSot41kKtT4j+9G1DK9L7ejM+izI7kCSbeH2rXcoJVhuWgM95T/duVYe7BqV1WKQrOku7Qmlgnw2YV+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 968151D25F8;
	Thu, 17 Jul 2025 15:12:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 76DE620013;
	Thu, 17 Jul 2025 15:12:17 +0000 (UTC)
Date: Thu, 17 Jul 2025 11:12:16 -0400
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
Message-ID: <20250717111216.4949063d@batman.local.home>
In-Reply-To: <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
	<fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 5gyaquas5ioppiie5ckjo9ruz5i4zk7g
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 76DE620013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ffovo8fsNi0fX63qatArRAunOSWznX20=
X-HE-Tag: 1752765137-569355
X-HE-Meta: U2FsdGVkX1+b0EYH5NrxOQ+jfOYOt/z5FWFjZ0WbQLRNjwDfJlJjQLAZgOvItOXgTvcorYTgkkiW1rzDahLR77azVN9TQ8M9xtpB5ZxQYN6BI6FLRsPQUXcoPlrd0SProDOxHU2R0ZbsDZxCP4B0+8aLxqXOHyXmF61N2KsANbni4JMM2rXmOq0wH7xp/obxI7ElVvIUqOtnbdkg2PZLXO6FlyGcqGqIIMdvWWPIhnJM1uUb/0tFqqun2qA91arlYoIQ5KipDCeBM6BDxbtdjVeur5eSsH9puJVjewog0U0mjmmadJ56ueo93N5lr2jAMnSViGOcxpb0bBfQMwIkUl80LuaFncAX

On Thu, 17 Jul 2025 07:57:27 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> I still don't understand what problem is being solved.
> As current tracepoint code stands there is no issue with it at all
> on PREEMPT_RT from bpf pov.
> bpf progs that attach to tracepoints are not sleepable.
> They don't call rt_spinlock either.
> Recognizing tracepoints that can sleep/fault and allow
> sleepable bpf progs there is on our to do list,
> but afaik it doesn't need any changes to tracepoint infra.
> There is no need to replace existing preempt_disable wrappers
> with sleepable srcu_fast or anything else.

=46rom the PREEMPT_RT point of view, it wants BPF to be preemptable. It
may stop migration, but if someone adds a long running BPF program
(when I say long running, it could be anything more than 10us), and it
executes on a low priority task. If that BPF program is not preemptable
it can delay a high priority task from running. That defeats the
purpose of PREEMPT_RT.

If this is unsolvable, then we will need to make PREEMPT_RT and BPF
mutually exclusive in the configs.

-- Steve

