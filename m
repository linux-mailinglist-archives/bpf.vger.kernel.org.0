Return-Path: <bpf+bounces-61053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CCAE0170
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD7D1895266
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250C27AC56;
	Thu, 19 Jun 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UD3wIrY+"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845721CC47;
	Thu, 19 Jun 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323888; cv=none; b=enlC3GUmmpkWrPGBnQhwLUTHH9cxJKuG1UNny2VO8TuIzNm/GyW2cJ/KUUuRRJo3K09yZEQcqLhbN+YVL89Zy2It36DfMLt1GWHqQ1Kpsr8TSVGey5Hk1xR1R5ppot0vVCltjZgUi/xkAyLi2Q053R285Sfz8HTtBJti7+goAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323888; c=relaxed/simple;
	bh=TxcuXMVV+aV1+GhdvzFE2xtaQghLDy476d1fX4BrXTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4r6ZEag+FuExwtIUkmqiTcy5ytbC4olzrEkJheM8ltqZDBMURdRq3MMg64teFareAyGhCECCxciaScVdt5OrISi3Mao9AsiF1XOaJe4ukvLQsxvw1R7uM5hDWgoU6U8hBFGIOeM/4rGKAblPCxFE1xURdclq7FCltL56WHjC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UD3wIrY+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/kqvh4lUfMoQlrV4TypHYuQcQHe2CtjhOSnu/WvQXTM=; b=UD3wIrY+U78Zz3M2QjaI5kEwF3
	d+ktMLqdBBS4v4XxS+QAm41wpFi+kz/AsqyW6qkycbE3daHw5YFRC7lt19DshmGP3uGFVehl5OCIi
	G5SoD+HWlh/Xq0P2FRgJz/cSphsWxedi62u0EW3uYV4Lww8J647oXoTkUWNB19DTXpbm18nBjTJSf
	WTkgFL0j10Rltd+mKo1+4RMtZOMbh0jHc/O70Fsxud8tiUtwsP7bPFDkckzfcjuF5NI9tDSIhq/A2
	a8b7ycDTWZLSD+Hxx5jNpe2SJt8TW9l9fgh3wcyKRgTfCmAU3tG3sYXfGu5REMmCj4BL5xXESu8T/
	biOI9Abg==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSBCH-00000007z3S-2cV9;
	Thu, 19 Jun 2025 09:04:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6218F3088F2; Thu, 19 Jun 2025 11:04:36 +0200 (CEST)
Date: Thu, 19 Jun 2025 11:04:36 +0200
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
Subject: Re: [PATCH v10 05/14] unwind_user/deferred: Add unwind cache
Message-ID: <20250619090436.GE1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.603778772@goodmis.org>
 <20250618141345.GR1613376@noisy.programming.kicks-ass.net>
 <20250618113359.585b3770@gandalf.local.home>
 <20250619075611.GX1613376@noisy.programming.kicks-ass.net>
 <20250619044714.5e676bf3@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619044714.5e676bf3@batman.local.home>

On Thu, Jun 19, 2025 at 04:47:14AM -0400, Steven Rostedt wrote:
> On Thu, 19 Jun 2025 09:56:11 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Well, the trivial solution is to make it 511 and call it a day. Don't
> > make things complicated if you don't have to.
> 
> I don't know if this is more complicated, but it should make it fit
> nicely in a page:
> 
>   /* Make the cache fit in a page */
>   #define UNWIND_MAX_ENTRIES                                      \
>         ((PAGE_SIZE - sizeof(struct unwind_cache)) / sizeof(long))

Right, that's the fancy way of spelling 511 :-) Except on 32bit, where
it now spells 1023 instead.

Did you want that bitness difference?

Also, you ready for some *reaaally* big numbers on Power/ARM with 64K
pages? :-)

