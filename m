Return-Path: <bpf+bounces-60939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DA3ADEEBE
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786BE1BC15A0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CAE2EAB81;
	Wed, 18 Jun 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FjacVzhQ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5892EAB6D;
	Wed, 18 Jun 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255381; cv=none; b=tj4UI1KZWJ/73yTfa5ml0REJ+epPbMdxbn5JZ7K+xLsooCkL+5Fwfgpp8+8LCYgl3On+SZ9TZ56fltihuWmVzDgUW8HpLML2HRur9QXxHZZ6jyNyujMH0adDt04XMu/heHzeapMeBU6otvGhRQgRNt42alAJOKEFXqKRe8c76rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255381; c=relaxed/simple;
	bh=cJj1tsRvy78ZJVUYsUkI1JGZL+hPM6U3daoh+CuWnN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViO5q5GDtfTFNTfoMKYbSTAR9VEu56fiDq4LTLXt90rBJiAsxtGaHUyrSJ/dSDyQ1o7pbk5n1EyK5dJzdCborCySTeDpYW8o9vrUAE/nv7L1CiC17VgK9Xy7M4l5EgIlu/Jf76HZGIxMN0y9y8021Wu0uO5nZ4pliMKGplQ7aNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FjacVzhQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cJj1tsRvy78ZJVUYsUkI1JGZL+hPM6U3daoh+CuWnN0=; b=FjacVzhQwHkrarX3E4VsjTz6K0
	RHvaCoNeZoy9g8+AD4rtZogqcM2kMy3/VJBkvwV8I7qynAW5Ur5T10OlUNR5AVPRKovry4niErQk4
	4+ZYl3OLQzoUFJgvkEvHkGjIyQeAMnMWrdeJF/TSfUwzHaSWWQ9LikVvnWNdCqXR8mH9yTGOp3vCP
	8mg1AuPjRHmKn/g6f2VBvv8KbafBB+JEqtymggCQmzzBE/KNM+mohRQO13Ya+7otTwYJ0ey2DnoQ+
	FTqFJs0tWltKVfhhoEc/UlvwC46p/qqqfZi+gSui73FRpYvTVVxD6STpw32hziZSBXcR02m6Rc6yN
	n+4YF4Dw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRtNI-00000003p3Q-2Qb8;
	Wed, 18 Jun 2025 14:02:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 87901307FB7; Wed, 18 Jun 2025 16:02:47 +0200 (CEST)
Date: Wed, 18 Jun 2025 16:02:47 +0200
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 04/14] unwind_user/deferred: Add
 unwind_deferred_trace()
Message-ID: <20250618140247.GQ1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.433111891@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.433111891@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:25PM -0400, Steven Rostedt wrote:
> +/**
> + * unwind_deferred_trace - Produce a user stacktrace in faultable context
> + * @trace: The descriptor that will store the user stacktrace
> + *
> + * This must be called in a known faultable context (usually when entering
> + * or exiting user space). Depending on the available implementations
> + * the @trace will be loaded with the addresses of the user space stacktrace
> + * if it can be found.

I am confused -- why would we ever want to call this on exiting
user-space, or rather kernel entry?

I thought the whole point was to request a user trace while in-kernel,
and defer that to return-to-user.

