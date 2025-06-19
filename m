Return-Path: <bpf+bounces-61037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D68ADFF2F
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C31017BF0E
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A932566E6;
	Thu, 19 Jun 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n8CwOEx5"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E124231837;
	Thu, 19 Jun 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319669; cv=none; b=S0XazqmdmohGnEkYLhT+wLjt6V9p9Gh8LjJ5+WqMwwvOtyzz5lvINxznU4JrcCxE6HKCxTfDxZ6ZNVeLhi5fQVbZ7X6rbOnplTRlChXI7PvrGMlvvx+H7EW+DqCFhhZ3am6XuOXwggZhFefNc8ndnJNoa4WhRVytfe3YkmkwRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319669; c=relaxed/simple;
	bh=tOP+atBabNbGYR6Z5UrZUndGasMZB1gx4wcd4JLCyQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsyYHIbYl5zZVRSta3iZXW1neG/JpqI+2Yz2wpaLiwM5vu/txh6Mu9NNyr9rE0QaFvpH3sKnu7w4Six054U9xd3YgYb50W/hYkzGKCR/BCSD7GVvMmeedqUAv6F0qrynBvVDxh+0u8wZIiseQMzZGi5/UOsLyvxNquBBYLPw0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n8CwOEx5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tOP+atBabNbGYR6Z5UrZUndGasMZB1gx4wcd4JLCyQQ=; b=n8CwOEx5xmk1bo/UbhRnasul0x
	GhWHnaA4nhO0UImFeIG2Xac9nbtU3soSoP5eOKEcRDtJJFGBiveO0tdPm2PDb2gCIckD72g/xh92/
	SOFCAbhuWBUbIrAdc0SHXeWqTz7tR6LIIWBqlaZHhl0FxnPpQSPcTFepsgxK2tih0LyAIiD97bCMv
	5KmyBSMZMaNDnz/k02dj/s+i+os2ND1JfXT009E+6QtssDwjI2I5UNmOjzow7YxMiHrcPdBvWQuey
	qUvVDKHjj8Ot0jpXbEn3/2iTHXuDUhucTnhSIIPtUu33VfbNKSIdIX50PdSLDGSlLsWmmpbVvVPhi
	cz9VUqqQ==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSA6E-00000007iD3-1eGm;
	Thu, 19 Jun 2025 07:54:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 674DF307FB7; Thu, 19 Jun 2025 09:54:17 +0200 (CEST)
Date: Thu, 19 Jun 2025 09:54:17 +0200
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
Message-ID: <20250619075417.GW1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.433111891@goodmis.org>
 <20250618140247.GQ1613376@noisy.programming.kicks-ass.net>
 <20250618112939.76f4bb87@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618112939.76f4bb87@gandalf.local.home>

On Wed, Jun 18, 2025 at 11:29:39AM -0400, Steven Rostedt wrote:

> Note, a request from the gcc folks is to add a system call that gives the
> user space application a backtrace from its current location. This can be
> handy for debugging as it would be similar to how we use dump_stack().

That makes very little sense to me; apps can typically unwind themselves
just fine, no? In fact, they can use DWARFs and all that.

Also, how about we don't make thing complicated and not confuse comments
with things like this? Focus on the deferred stuff (that's what these
patches are about) -- and then return-to-user is the one and only place
that makes sense.

