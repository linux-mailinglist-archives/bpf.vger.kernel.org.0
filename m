Return-Path: <bpf+bounces-63621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28DB090C0
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CF15A20B3
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777DD2F9484;
	Thu, 17 Jul 2025 15:40:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874C2F7D18;
	Thu, 17 Jul 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766838; cv=none; b=tw2B6t3SWpwgpZLlDcOG5xyfQRVuvWpoXi3GyfNFUeqveHeh1JWuULYT1dwx+YmUrr7S7eczHvy288+TpBH6cs2kefYhHvKv8WtRiPk9f5dzq+aihZ4xk6WRlPFiwAqojWZ9QBq9Q5Uq9eBQkwU2gokiBjO0OcUTWI8X+n0V0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766838; c=relaxed/simple;
	bh=byYxJ16ZoC4eUL1Kfe2DDqz43kF8h+TNDCSmTKBbLlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utZBSzAs167H+UwQQX0V4pg5SBjJyZd4s9eCt2bDWkmw4mtCiC7GLDIPDsUI7j55tYRuLfOFO5v5WUVk/aUAQJtCn1bgLWeJCg6IbNmGW6uLlJlCuDY0/hcKrxbT1XizgwyIPZgPzNwPXWWs6K7t7o5avuwm4h4rZVOEfta4YUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id D1779B5F5C;
	Thu, 17 Jul 2025 15:40:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 1A56935;
	Thu, 17 Jul 2025 15:40:30 +0000 (UTC)
Date: Thu, 17 Jul 2025 11:40:28 -0400
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
Message-ID: <20250717114028.77ea7745@batman.local.home>
In-Reply-To: <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
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
	<20250717111216.4949063d@batman.local.home>
	<CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: m1kaai8mpzx73m7izgqpw3g47m7reah1
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1A56935
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18a8NcNSp7uVQ2RRFgIWCN3oRaQtsnQz/k=
X-HE-Tag: 1752766830-912623
X-HE-Meta: U2FsdGVkX18iKgkopQXfm1qnBscJas2EpDY6iC6kVDXPTN01qGA4LL9cKqtSNPVHbAz27uHLXkW1HDoQNMOBZtcbGmp+DnkuWn18KEqOahrpV6yVF3k1RrEjIOnuD0BDAs6XzsM3JPzRY8+o/aevOWFwzpevmzOgr1WkTRXaEu1YfuxwcyAFHg0de/oFr7NBwiNzXQ/U7OnhJmAwRZKvjlvwXT9ecZSuCGqnIL1akrOGv/6CFvRGZRxBPfxRcBxJQYT583KVINqws67FIml5WBdo4Ws+Yz6DlMWV4ySSHn2G0etJqKU9+oDWLf7o58amcZbhtmMB+qUGkwDx1VAp4DWOLzFsP0ccyNY1nctzAZQNq0cSIvTk0gBq1bE2GTfyRM/NKAYOc23O9kSImqkY2A==

On Thu, 17 Jul 2025 08:27:24 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Jul 17, 2025 at 8:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Thu, 17 Jul 2025 07:57:27 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > =20
> > > I still don't understand what problem is being solved.
> > > As current tracepoint code stands there is no issue with it at all
> > > on PREEMPT_RT from bpf pov.
> > > bpf progs that attach to tracepoints are not sleepable.

>=20
> Stop this fud, please.

No fud. Above you said they are not sleepable. I guess that just means
they don't call schedule?

>=20
> bpf progs were preemptible for years and had no issue in RT.
> tracepoints are using preempt_disable() still and that's a
> tracepoint infra problem. Nothing to do with users of tracepoints.

Yes, it is a tracepoint infra problem that we are trying to solve. The
reason we are trying to solve it is because BPF programs can extend the
time a tracepoint takes. If anything else extended the time, this would
need to be solved as well. But currently it's only BPF programs that
cause the issue.

Let me explain the problem being solved then.

Tracepoints currently disable preemption with preempt_disable_notrace()
to allow things to be synchronized correctly. But with the disabling of
preemption for the users of tracepoints (BPF programs being one of
them), it can result in large latency for RT tasks.

The request is to use RCU instead as RCU in PREEMPT_RT can be
preempted. That means we need a rcu_read_lock_notrace() version. One
that doesn't call into any tracing infrastructure (like current
rcu_read_lock() does), otherwise there could be an infinite recursion.

The discussion at hand is how do we come up with a
rcu_read_lock_notrace(), and using rcu_read_lock_fast() may be one of
the solutions as it can be implemented without triggering tracing
infrastructure.

Does that explain it better?

-- Steve

