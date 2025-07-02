Return-Path: <bpf+bounces-62150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90594AF5ED9
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417421C46AEF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25762F50B7;
	Wed,  2 Jul 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZP2SwdkV"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F6C2F3631;
	Wed,  2 Jul 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474184; cv=none; b=WH5lFHFRoItmeHnwK5Ndina3HwJoRVkUPeBIr00nB8INlGJdZOMmnqRLG9oLfyLJ2/cOau7PfrFr99C8DmTF0U+Bu6UtrHJ4uKl6pq9snY5FTy+0b4raucJJhxso+GaCUF0wecN8utgYxKS5XDLFrHuE9HrDIZEgv7h8MmmWIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474184; c=relaxed/simple;
	bh=cfJL4uwsxTpOOEpCClcy7icfZY43EsxMVhrstr0vxfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWZJy0/Q29ft+Uw/h1ehVNecST2AqqHb2nTdgA11cvhvMLdMm15BbuUkE6EF08rB5dwuN/oAKJcuOAFG9NuG260tC2DpbvkpBvA/AumQx7KIV429tn+JCmKsqDX/BugAbOXj+bmCARKMdkmuLhquM4F0ctcQ6+DBqjx9NjaOLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZP2SwdkV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BHoZQI/zyF4cGymUERYBEyeK3+PwhgUVRUsk6Fb8Mag=; b=ZP2SwdkVhXtaITzZxBbBZnsuIG
	oLOocLyc+a/DMjjS7hW7HeU7R8eIruHXAApMZnBPF0EJyH2mczbYLYTZ4iGe0lvpdMDO5Qe6JBtSG
	qOqVQltEJR9gZli6NnK3iwdLGZ8/d61AwvE+dXalAoqmP756IanxoQM/OhfY3VhMSUIesIghq6JWq
	f4wqsHRR3MsQM7wwdqgs9FT6+OGs5RJxZdWSWWwUcaObK3yXEc6Id0FreCAggKDGEaq/FHgMs4p+Y
	u1/JJ3uK4wgOhzJTa+wWhJ2zwQYZwRvk1wS5nIq2qppl+s6lAbZTXOlI2D0mL6dDGWeby757alQks
	g8n3BBKA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0RN-00000007UxO-2KEa;
	Wed, 02 Jul 2025 16:36:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1786D300130; Wed, 02 Jul 2025 18:36:09 +0200 (CEST)
Date: Wed, 2 Jul 2025 18:36:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250702163609.GR1613200@noisy.programming.kicks-ass.net>
References: <20250701005321.942306427@goodmis.org>
 <20250701005451.571473750@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701005451.571473750@goodmis.org>

On Mon, Jun 30, 2025 at 08:53:27PM -0400, Steven Rostedt wrote:

> +/*
> + * Read the task context timestamp, if this is the first caller then
> + * it will set the timestamp.
> + *
> + * For this to work properly, the timestamp (local_clock()) must
> + * have a resolution that will guarantee a different timestamp
> + * everytime a task makes a system call. That is, two short
> + * system calls back to back must have a different timestamp.
> + */
> +static u64 get_timestamp(struct unwind_task_info *info)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	if (!info->timestamp)
> +		info->timestamp = local_clock();
> +
> +	return info->timestamp;
> +}

I'm very hesitant about this. Modern hardware can do this, but older
hardware (think Intel Core and AMD Bulldozer etc hardware) might
struggle with this. They don't have stable TSC and as such will use the
magic in kernel/sched/clock.c; which can get stuck on a window edge for
a little bit and re-use timestamps.



