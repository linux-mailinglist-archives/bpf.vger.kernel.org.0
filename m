Return-Path: <bpf+bounces-61048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32135AE005A
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B5616ECAC
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F4266581;
	Thu, 19 Jun 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ToBAKOAR"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD45265CC9;
	Thu, 19 Jun 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322904; cv=none; b=QqE12xMCO5l/2phfR2j0Hj+r3fxLJVvXPn8sTbAkkACXDEhAsaUiaAl2Loj6UySGw1h4KU53R1XTmLzq8pavAWQkx0gnIXGp6MK7FjYW66sP6zGNDAKUTBovWZTU9AZjrTLlW3aYvEx9AC/Mlz7WD0MggGuF8T4pXJ7sBAgYs2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322904; c=relaxed/simple;
	bh=vww0wtuYapFk4A06ppyCbC9dlVIFOUMMAQV4XHfEuXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKzYyM38pEl1F/6B9tvGk7Tlu8AIwYVuCjlnR4Q17eghWEXCCfPysrDNWXzcPJG8z/ioz14v7FinLqPEFObx2ZoulrvP0GuMwl3xtVurek+/PbeSEXYq7Ba9KHumBqdYQKkpsroPhmq/A8vd58kt+PhVJl2U57KB2olREnbIP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ToBAKOAR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vww0wtuYapFk4A06ppyCbC9dlVIFOUMMAQV4XHfEuXM=; b=ToBAKOAR/KSKlolXqPBhH8mhg+
	soSiIdL67/PGAN1BaapkrSw7SgtTR+S2XL6WSjxZCiHEt570jrBMenh4sxkYSAuLIZQr6IPEyaZmT
	1y3Zbim/djaSDskOXEODkjy/gG2TBjriJL+67SAUNLObYpV9uLL4RiCYgtYlygwdCJzzIY21p9MSF
	YBV/hemaC0jhHKN9cV+sdPfP8KwggnCm6yEo78xo0YpUVBcWO3Lx8dPhRb9n+Hq/3eMu33xkX9kXB
	5CeMauG/mGaAMT3rkzgySxVjxHylEDA9DD5TaOiXpujyEP6q590uY2Rr7It1HYlKu27okse4Nuu7R
	FimoTX+g==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSAwP-00000007vXx-448X;
	Thu, 19 Jun 2025 08:48:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B1393088F2; Thu, 19 Jun 2025 10:48:13 +0200 (CEST)
Date: Thu, 19 Jun 2025 10:48:13 +0200
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
Message-ID: <20250619084813.GG1613633@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
 <20250619083415.GZ1613376@noisy.programming.kicks-ass.net>
 <20250619043733.2a74d431@batman.local.home>
 <20250619084427.GA1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619084427.GA1613376@noisy.programming.kicks-ass.net>

On Thu, Jun 19, 2025 at 10:44:27AM +0200, Peter Zijlstra wrote:

> Luckily, x86 dropped support for !CMPXCHG8B right along with !TSC. So on
> x86 we good with timestamps, even on 32bit.

Well, not entirely true, local_clock() is not guaranteed monotonic. So
you might be in for quite a bit of hurt if you rely on that.



