Return-Path: <bpf+bounces-69220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543A6B91A01
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C38C4235FC
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF420E011;
	Mon, 22 Sep 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJVmMbFn"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA83191F66;
	Mon, 22 Sep 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550644; cv=none; b=AAfANixkKRvGaKHqA5dr7x1KbuItQJkSdBTD6H3lelMxnV9GpDMRMDaCztrAkOH1yWyQ99hBqODo/7GzCJX2vLHtZPVcCXE1BplqNN3aVqXGCcRzG4G1KdZCNAIttcZjRmGn0vHnus3uPNH/e0wBSsjlhQ+kHXqWtkQgkVktQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550644; c=relaxed/simple;
	bh=gn8LLxkIVjhTNakRHlp3LSM2QyH8Sg2TELVlWw65SjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnKw4KrZn+lgiU4Cii9cYR2wXv0HZCPmYKE9nOTC4leAG5oGbSfore8LfxGLQA4ovZ4RT3CnVNWutrkyGoOAQrHGdfpytzMCj+oPTby3wUrNpWlB1+jh3E5zhWEoFomzI9ttptJCMeE6J9leVSekfM+s+IAsACJIpu4qBneDZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fJVmMbFn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PgurSM8v6g4XqceJ5reSyG+7GSpIjEQay/9SsuDXPGA=; b=fJVmMbFn82hQOQlJn8i7wEAqMo
	gIYPHmDMHX1ccIwKVsRyoMEEwEzsQxYo/VoQPeD/jPETtuusCXpyCo+vvUR+ORfz6Trv7m3sYvgdy
	35nTRXyTUIC+muQVKIJxXk7Vl9ZPyWsu9P4y2/63nVyT4C4rPHTvJRf2pG3j0nLy66mRnN9thvT/y
	92XzdLRjNlhsIHgkol5PbliP0vxmIq33BIzw4tGjLHKXlinDbGYa6af/45ZNCYTapl0FP072aiYnO
	L1YhCXOmnmsQQfwaDs5VORIz4NoP9ssCD+piMYohzxsBZwUNhqYosCl1SE0dD9HvhjWh1bYkIrDyv
	fxabBk5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0hLp-00000009Kva-36Qu;
	Mon, 22 Sep 2025 14:17:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4920F30057E; Mon, 22 Sep 2025 16:17:08 +0200 (CEST)
Date: Mon, 22 Sep 2025 16:17:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250922141708.GB70318@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
 <20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
 <20250918111853.5dc424df@gandalf.local.home>
 <20250918172414.GC3409427@noisy.programming.kicks-ass.net>
 <20250918173220.GA3475922@noisy.programming.kicks-ass.net>
 <20250918151018.7281647b@batman.local.home>
 <pde32olzdlqvbom5bya5exndcrfgsw7lmffy6uav5yoplonzj3@ddb2b5sihlpx>
 <20250922072307.GQ4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922072307.GQ4067720@noisy.programming.kicks-ass.net>

On Mon, Sep 22, 2025 at 09:23:07AM +0200, Peter Zijlstra wrote:

> I'll go stick it in the pile. Thanks!

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git unwind/cleanup

I'll let the robot have a chew and post tomorrow or so.

