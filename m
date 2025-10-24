Return-Path: <bpf+bounces-72115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43DCC06DFD
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921253B403E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EAC322A25;
	Fri, 24 Oct 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OWl9MjzU"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E71EEA5F;
	Fri, 24 Oct 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318631; cv=none; b=gF85rTY2pEyBOTJ3IcZCyjjagh8n2aKVcWLznWQrH/nTdPQWXLu33isk63iufUrIINmFlgzHy5wnFuuh3Wg+jsIulcpvSjGyP4iiejCs4Bs7JFeGhVX/Pn5g4Fz+/Qbswet5gjpLHFOs9i4FlNo0pJw173evNKutVPjNfM5WgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318631; c=relaxed/simple;
	bh=R9uCasHZl5HZzWzXq2yaMlfUSqQxKmz/9Jg7my5yLM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFANtMUi4iRq80UWiHbjrBO1m1SCVrAAEXW09/W6xE2phSLIG8cDjSsm5hPelwSdDz65mYi2Be44IE2s/kpts0CH+0GR5/RWHNVPEzmOO2a+WkaJmn7PiL5C8qauafT5l82GMiTRgrSa7j6Ka8HUSzY75cqn+2SJ+Skv1nT4FYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OWl9MjzU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bzmhK2MoONtKgOO64v1I2LbgUXYBjp2AsY6bh7sSjTs=; b=OWl9MjzUfHjDzzRpdl628UU0c6
	BbcRumvb/5DBwJEg6G91P+9W+DGfV0nTf5BfqzPk2cFTgC5lNN1qHbMJ0m6WXv6nIzS/r77yL3sqT
	SmgFaApKDoOpp+j3QiNaKkW0FCnCfNt0544m1FSVU4rsTjAzXSOf0nT/BjUVJ3BVy+rjgALMDyp9s
	Z4khXvYZJJtoK9BjBLC6CagJxu83R1mhi4Eo7kowoiRq5f2J0+ewLwLgjlmRgx3oPJ1feGvF+jy8K
	y5ntNe8kjFeCmtE2JNMvS9S62sSy+m54g9Xi0Cf9bizmJRVMFMAIOBnQnJsQUgde6peIpsk5WyrIi
	VcHRGA6w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCJQo-00000003Xbm-1q4V;
	Fri, 24 Oct 2025 15:10:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CD53300323; Fri, 24 Oct 2025 17:10:19 +0200 (CEST)
Date: Fri, 24 Oct 2025 17:10:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251024151019.GP4068168@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
 <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
 <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
 <20251024140815.GE3245006@noisy.programming.kicks-ass.net>
 <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
 <20251024145401.GN4068168@noisy.programming.kicks-ass.net>
 <20251024145735.GO4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024145735.GO4068168@noisy.programming.kicks-ass.net>

On Fri, Oct 24, 2025 at 04:57:35PM +0200, Peter Zijlstra wrote:

> Urgh, that makes us call that weird hack for sframe too, which isn't
> needed. Oh well, ignore this.

I've decided to stop tinkering for today and pushed out the lot into:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

It seems to build and work on the one test build I did, so fingers
crossed.

If there is anything you want changed, please holler, I'll not push to
tip until at least Monday anyway.

