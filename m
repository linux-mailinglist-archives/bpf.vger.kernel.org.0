Return-Path: <bpf+bounces-63624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEB1B090FD
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CDF5A1C98
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7E2F94A4;
	Thu, 17 Jul 2025 15:55:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD51F30AD;
	Thu, 17 Jul 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767719; cv=none; b=VDoyxYD0rOM6gmU665rl70IulqetG0Q9mGPkVg9p2afUV6ZDkK+XjkcyY99LG5k1uB5tia4PQQTlsBUWt3/ooSyA/0SJrQRJfSEtX6DP1b/++ZfHXrHgS0DEwnVgBltItbI2h+dJ46W9/JBBeZAzENSFN87tBRwRRVCXyBdHqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767719; c=relaxed/simple;
	bh=oU1gAGdpUX7HzDDDJ4fkE2E0mdxlsBu5BZtIWYhgpf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTGW2pSol2qVYF+wQ3hYcbo1PYak5EW/+PvQ8xJrtaIG91nwO5fd9eDOiVSHovSe/sblKQnA+kwC2xbt/EhqdsICyWcvPUDJ+vYgXhHTo5ZWklkNOlCfZfV/8/Ac/yZcSFuAeDdG5TvZy+8Q68PKK4v3SoTJLTQAfalzgNs4ptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 29B261A014E;
	Thu, 17 Jul 2025 15:55:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 60B6520023;
	Thu, 17 Jul 2025 15:55:11 +0000 (UTC)
Date: Thu, 17 Jul 2025 11:55:10 -0400
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
Message-ID: <20250717115510.7717f839@batman.local.home>
In-Reply-To: <20250717114028.77ea7745@batman.local.home>
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
	<20250717114028.77ea7745@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: h6r9wbmd3dzzkdpunc95it6ceznsrrmj
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 60B6520023
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/HcqfUBq7ZAamlYZ+pbnUkiCl/Cr+nLwo=
X-HE-Tag: 1752767711-221066
X-HE-Meta: U2FsdGVkX1/E7EZePk0SFBavuZDu4z0+Bq9q72Smix7XAoIfXqDza5uZhd1rIlUDnHUndKYZRRcFNvNLIxNuHI34ZtFbw+BHOhhBU1wLwkz2Yxure91zWHImZ17kPBo6N0HKqA9n04Pr1+gZZOui25GZstBF8Yq97+N04gWjRw9y1eS/KtK1P+OFve80pij7j4FAXpV0J23olv6XcUQs6GZ/bxoh471CbTy1jPLthlKCXPKR+VNUxx1GPjK44NBb5L0XPTw1TZaxQKXTYmRR2pNdVKT+2ORwk0uvlg3DGeapMRPgNfcCCVe/MsNNESf9E39cmtEspJhqVkNeSVtIDDRAhWtuetfznL3FUBq1J9ONPz6x0cLgH0g3YcMDLbTA

On Thu, 17 Jul 2025 11:40:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yes, it is a tracepoint infra problem that we are trying to solve. The
> reason we are trying to solve it is because BPF programs can extend the
> time a tracepoint takes. If anything else extended the time, this would
> need to be solved as well. But currently it's only BPF programs that
> cause the issue.

BTW, if we can't solve this issue and something else came along and
attached to tracepoints that caused unbounded latency, I would also
argue that whatever came along would need to be prevented from being
configured with PREEMPT_RT. My comment wasn't a strike against BPF
programs; It was a strike against something adding unbounded latency
into a critical section that has preemption disabled.

-- Steve

