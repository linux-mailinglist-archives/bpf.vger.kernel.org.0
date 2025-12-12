Return-Path: <bpf+bounces-76497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E9CB77A5
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 01:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031AE3022AB1
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 00:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147F2417C6;
	Fri, 12 Dec 2025 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkrH9Bef"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477B239E97;
	Fri, 12 Dec 2025 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500455; cv=none; b=dhrE13bWMydBMaDeqk9FFsu/n8j010TCHHpGc0RAMywUzFabVSE1EQ9oDEA/1g4eSDhsrmYuG36pH60+A9xUwbLCFnh223FYT+kPmw1zX13oABCsc2DaA/F01Rx7TwH5ksSdsoG9ifOb5P/+FCtFBK43rB8VJoBg9LCNvlRUGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500455; c=relaxed/simple;
	bh=83fZXvFsq8X1rmZDQM4OqoZGegYuwMDo2CZt4BQuHbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTe85dPck+nODVH2CfcvWbHDrpbuKXL8TO6xSJMYWmeRgFC7z4ff8RezMl2vxmMg4bTVyQSwca2MADpMGkp79JcJnWjk15PdbMfQrEH+vBlCdrJJQp+dU3H+06X58OTB+1xVmt/1Hv4H3G4DAOGHV8kgwtAPSyJoeLSL/9uMuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkrH9Bef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20270C4CEF7;
	Fri, 12 Dec 2025 00:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765500455;
	bh=83fZXvFsq8X1rmZDQM4OqoZGegYuwMDo2CZt4BQuHbI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tkrH9BefhsuOpiTa3c4M/qcnPLoq5L04UcjhCnqm076tcz+lq240OB6CrBQeCp/uJ
	 H2wm5LpE7IxTUoQTrE1tmbtmPeEx03Zxx9FiWpP7OLxjuP7QYCbW8OVPMPut/wUdLZ
	 6b1fe/kTHEkDxC6iNvItE6qGpjC9T8JwAd+lTZ9jSLTkAKRa84F2cb+Rgc51yETLsc
	 RpdElnvVEeWMmR0rJCyrPp8wOj/r+5kQjl6cDvt4ytkqzkClRc+Ec3VfMIadTrypr3
	 Hq3W107YdhFPRWFhU/qQbOl/gaDj1DH+yWdEJnY86DbqDSwPxvDx9OB460a9Ecgwnu
	 bAJDSwCekGCGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 20AC2CE0C97; Thu, 11 Dec 2025 16:47:33 -0800 (PST)
Date: Thu, 11 Dec 2025 16:47:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steve Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <0ec97a2d-5aee-4214-b387-229e9822b468@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
 <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
 <bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>

On Fri, Dec 12, 2025 at 09:12:07AM +0900, Joel Fernandes wrote:
> 
> 
> On 12/11/2025 3:23 PM, Paul E. McKenney wrote:
> > On Thu, Dec 11, 2025 at 08:02:15PM +0000, Joel Fernandes wrote:
> >>
> >>
> >>> On Dec 8, 2025, at 1:20 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>
> >>> ﻿The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
> >>> to protect invocation of __DO_TRACE_CALL() means that BPF programs
> >>> attached to tracepoints are non-preemptible.  This is unhelpful in
> >>> real-time systems, whose users apparently wish to use BPF while also
> >>> achieving low latencies.  (Who knew?)
> >>>
> >>> One option would be to use preemptible RCU, but this introduces
> >>> many opportunities for infinite recursion, which many consider to
> >>> be counterproductive, especially given the relatively small stacks
> >>> provided by the Linux kernel.  These opportunities could be shut down
> >>> by sufficiently energetic duplication of code, but this sort of thing
> >>> is considered impolite in some circles.
> >>>
> >>> Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
> >>> readers than those of preemptible RCU, at least on Paul E. McKenney's
> >>> laptop, where task_struct access is more expensive than access to per-CPU
> >>> variables.  And SRCU-fast provides way faster readers than does SRCU,
> >>> courtesy of being able to avoid the read-side use of smp_mb().  Also,
> >>> it is quite straightforward to create srcu_read_{,un}lock_fast_notrace()
> >>> functions.
> >>>
> >>> While in the area, SRCU now supports early boot call_srcu().  Therefore,
> >>> remove the checks that used to avoid such use from rcu_free_old_probes()
> >>> before this commit was applied:
> >>>
> >>> e53244e2c893 ("tracepoint: Remove SRCU protection")
> >>>
> >>> The current commit can be thought of as an approximate revert of that
> >>> commit, with some compensating additions of preemption disabling.
> >>> This preemption disabling uses guard(preempt_notrace)().
> >>>
> >>> However, Yonghong Song points out that BPF assumes that non-sleepable
> >>> BPF programs will remain on the same CPU, which means that migration
> >>> must be disabled whenever preemption remains enabled.  In addition,
> >>> non-RT kernels have performance expectations that would be violated by
> >>> allowing the BPF programs to be preempted.
> >>>
> >>> Therefore, continue to disable preemption in non-RT kernels, and protect
> >>> the BPF program with both SRCU and migration disabling for RT kernels,
> >>> and even then only if preemption is not already disabled.
> >>
> >> Hi Paul,
> >>
> >> Is there a reason to not make non-RT also benefit from SRCU fast and trace points for BPF? Can be a follow up patch though if needed.
> > 
> > Because in some cases the non-RT benefit is suspected to be negative
> > due to increasing the probability of preemption in awkward places.
> 
> Since you mentioned suspected, I am guessing there is no concrete data collected
> to substantiate that specifically for BPF programs, but correct me if I missed
> something. Assuming you're referring to latency versus tradeoffs issues, due to
> preemption, Android is not PREEMPT_RT but is expected to be low latency in
> general as well. So is this decision the right one for Android as well,
> considering that (I heard) it uses BPF? Just an open-ended question.
> 
> There is also issue of 2 different paths for PREEMPT_RT versus otherwise,
> complicating the tracing side so there better be a reason for that I guess.

You are advocating a change in behavior for non-RT workloads.  Why do
you believe that this change would be OK for those workloads?

							Thanx, Paul

