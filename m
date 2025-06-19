Return-Path: <bpf+bounces-61043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E5AAE0028
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1C93BE961
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAAB264F8B;
	Thu, 19 Jun 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F714k0Pr"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4924166E;
	Thu, 19 Jun 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322678; cv=none; b=udcUj8bGHhrVmq74/7nBCOXKSBYzZzz/c4jfh0XQUwBYhs9QdsX2xRPKChwxzx7mCrtJyLOafiCdcAZTEeNEh7vxMEfDWTbO3Whss2UC+m1uytI35XHFZtXCWx8NKVhWoe3AEDyOi5riQz33/6IgnHedx3ky7QHhsiChyO80EaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322678; c=relaxed/simple;
	bh=pAQIs0wPNcKspvealxxLH8x5f2oaCYdGWfWa+mZjI4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxG5qoL8LDmL2rwKYve6/X3lBcw9h4yMdGGJ2LdeANUfoctr6Uk1v/9HHKdtI3EPp9kYfUAjeMxEg2/E21HpPr+URlwmDX/HYekfz68VvVBzq3Q7SuK5OLGmnOeQaIF4NfHUyVQCUOiLBiOZgZc7SjmqSPsDuqySN+/wREgECnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F714k0Pr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zdSTT5GIAhkhibnh3jBupBeo3fDvg6PoB7Mf0Alg2KA=; b=F714k0PrGY2UjMoRVc/fTj+mfL
	2gUYFjFXcIEPSCzAIWCjBN4juRyyJxq1o/r9ZcKD5iLLex2ppvReauRReBsygZC4CG8hgKR7iKbqx
	dvRgVKIlqoc41ISPLD3cJhetQ81pi1S7h4lkYoG2QMy8sxs4MMh6sPGhjD6ETav5b1UhEVPLFhbgW
	yz5UIGtYwyS7Ihw0/bfPUi7NYFO4P6Bkaz1IwXzBc+oSUy4rqSRk0eayUfB2zixJEZe1uEhlFkRET
	ejyWOOtBtXO2b/BqJ16PYKwDg0z7bei66XSpFdMtdi+/f0T7DRo7+6YSugk3lwp14yKg8fDKY3p8I
	fUu3rjbg==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSAsl-00000007v7W-3Pw4;
	Thu, 19 Jun 2025 08:44:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5CD2A3088F2; Thu, 19 Jun 2025 10:44:27 +0200 (CEST)
Date: Thu, 19 Jun 2025 10:44:27 +0200
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
Subject: Re: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250619084427.GA1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
 <20250619083415.GZ1613376@noisy.programming.kicks-ass.net>
 <20250619043733.2a74d431@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619043733.2a74d431@batman.local.home>

On Thu, Jun 19, 2025 at 04:37:33AM -0400, Steven Rostedt wrote:
> On Thu, 19 Jun 2025 10:34:15 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Why can't we cmpxchg_local() the thing and avoid this horrible stuff?
> > 
> > static u64 get_timestamp(struct unwind_task_info *info)
> > {
> > 	u64 new, old = info->timestamp;
> > 
> > 	if (old)
> > 		return old;
> > 	
> > 	new = local_clock();
> > 	old = cmpxchg_local(&info->timestamp, old, new);
> > 	if (old)
> > 		return old;
> > 	return new;
> > }
> > 
> > Seems simple enough; what's wrong with it?
> 
> It's a 64 bit number where most 32 bit architectures don't have any
> decent cmpxchg on 64 bit values. That's given me hell in the ring
> buffer code :-p

Do we really have to support 32bit?

But IIRC a previous version of all this had a syscall counter. If you
make this a per task syscall counter, unsigned long is plenty.

I suppose that was dropped because adding that counter increment to all
syscalls blows. But if you really want to support 32bit, that might be a
fallback.

Luckily, x86 dropped support for !CMPXCHG8B right along with !TSC. So on
x86 we good with timestamps, even on 32bit.

