Return-Path: <bpf+bounces-63782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8685B0ACC8
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 02:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEA77BC130
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CAF1A285;
	Sat, 19 Jul 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKL3fdR1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726B2110;
	Sat, 19 Jul 2025 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884882; cv=none; b=BIkY2cQdughOch89ZDUv0NnYveS7o8wmJ1vnfHnaePEH95KyXrcsrepsX+Mc/L9CWp7zKgyBJj9cyEPF33vBxFnIeFoFObwxpJd4CW1bsm6og186Qt+bzQIfHqpr2ljJMDp72ThF7smvdCTxn/aL1J8xjNFrn8RAXHpst81nl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884882; c=relaxed/simple;
	bh=peO+H93Yb/AoZJd5yCIfu7Ot2DeGqz3/MglVOEZqKMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4AMoRLkiyzin+7PA7wnzZWLvWAi9t65W+pm7UrIJWx1EvSmB0xiNxoZGuJrUeVV1O26ykgPuQjXh5Q8Hg4nZvJEbYZuieKqaG9oxoCkmqITzAt+e6CqS23llxxl6B+YpARt9rqNeuaRr0nIOTupfuQ0K47U0d7s6mJqGSYWBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKL3fdR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE9EC4CEEB;
	Sat, 19 Jul 2025 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752884881;
	bh=peO+H93Yb/AoZJd5yCIfu7Ot2DeGqz3/MglVOEZqKMM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sKL3fdR1R4cmxwCN00/UVjbPE4Cl3Z8LKwDFzJ8tnymTVkonASALvc57OyLC1mrDc
	 5E5VE0zfvDzrF3sO5o3T0Xs0zuFacGgVv9liHmWh8lWDGKhTuzM0ccleODxk7wOTmS
	 uelwupa6Ow/D9XguTIC999WFeF5uU7NZ6OD5cIzLU6EVZC0JXUSva2zbMH29Tk8UVU
	 RcNBktos6AEgOIskgM+/ACqu4K1QHmE32b70pGYZcfWbiAJYzcl+Zp2/lSduNg/zd8
	 glM+zEBFOz/C1cIcbHV2LOpvSwcUkxF+zsUcMLQpffuBYyGlyXWYi7reja9Vw+2p/i
	 5LXZBhTCQhx5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EB72ECE0D3A; Fri, 18 Jul 2025 17:28:00 -0700 (PDT)
Date: Fri, 18 Jul 2025 17:28:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>

Hello!

This is version 2 of a patch series introducing SRCU-fast to the
__DECLARE_TRACE() in place of the current preemption disabling.
This change enable preemption of BPF programs attached to tracepoints
in in, as is required for runtime use of BPF in real-time systems.

The patches are as follows:

1.	Move rcu_is_watching() checks to srcu_read_{,un}lock_fast().

2.	Add srcu_read_lock_fast_notrace() and
	srcu_read_unlock_fast_notrace().

3.	Add guards for notrace variants of SRCU-fast readers.

4.	Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.

Changes since RFC version:

o	RFC patch 6/4 has been pulled into the shared RCU tree:
	e88c632a8698 ("srcu: Add guards for SRCU-fast readers")

o	RFC patch 5/4 (which removed the now-unnecessary special boot-time
	avoidance of SRCU) has been folded into patch 4/4 shown above,
	as suggested by Steven Rostedt.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h       |    4 ++++
 b/include/linux/srcutree.h   |    2 --
 b/include/linux/tracepoint.h |    6 ++++--
 b/kernel/tracepoint.c        |   21 ++++++++++++++++++++-
 include/linux/srcu.h         |   30 ++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 5 deletions(-)

