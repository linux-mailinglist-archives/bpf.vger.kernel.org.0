Return-Path: <bpf+bounces-69361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E5AB9548D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A262E4979
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D0321282;
	Tue, 23 Sep 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xe+JWNLN"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73E320CBF;
	Tue, 23 Sep 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620323; cv=none; b=ZfvQ+nxap5uZN4aZ2kBEdDpl8xqkpBQgG8+XYKSZGE/QNO9y9Pu41zGoBNW4i3TstIv3D0QVu8pfuB7XZROhEyj+aS1TGFCbwY8u0M/sQL31Tmy88ZTK1/Qt/7nts2gyTJ71IEGLv3oE82npWFpLmDzJe2tyHD7x80vyH45iQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620323; c=relaxed/simple;
	bh=fRWDgFvvA5A8ATCfR7doIa1lG/KqewQPh5lfQ8qEfCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC7BmMfbfhPT07rAP6YpgAZ4bAYL/2MXAzbczqh+G7vlPuR8pTvR9VJAS4IN/MhSbg3BIHlocIqZyAQSIgeH505DyCnh+ezyQweA18RP6Eu/Z/bcQ44fapn9RK7GJkiP4Ng8h+ktJ4bk3/AgExdUD8cMFupz/YFF2rcAHzhoAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xe+JWNLN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fRWDgFvvA5A8ATCfR7doIa1lG/KqewQPh5lfQ8qEfCw=; b=Xe+JWNLNyGU0hk7bcJzN/9OKc6
	SmbU+h+5p6mfnlnPY2fS8Z6s3g2Qf07IZw6UXHqasXC8c3l1C00u5IGotOj/5mHICyfVVOnGxpBB8
	XJUjGfgXehP99znA6sgsWqax6YgB0UKjEBh+p9QXzc/4IBb8WB5+lqCrJFXIDJEBJPaSxCrt8eEeo
	9NVvUqgAHq6o/UT69rkGZNx/EICV1i+P6+W0HQeGDF+kuOavA/1Hvv10fHzC2xlk8Q5MCukG4mpiW
	/o8L/WEalnqI0W8uIpu3VB2r9eeZ0udnyz/V3sUl5TcmpdOhy7tQWyXg41pvJl19iNA9WOQsxJLXh
	0UT2z6+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0zTa-00000008UP6-3If5;
	Tue, 23 Sep 2025 09:38:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A4FC30049C; Tue, 23 Sep 2025 11:38:21 +0200 (CEST)
Date: Tue, 23 Sep 2025 11:38:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 2/4] perf: Support deferred user callchains
Message-ID: <20250923093821.GB3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
 <20250908171524.605637238@kernel.org>
 <20250923091935.GA3419281@noisy.programming.kicks-ass.net>
 <20250923053515.25a1713e@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923053515.25a1713e@batman.local.home>

On Tue, Sep 23, 2025 at 05:35:15AM -0400, Steven Rostedt wrote:

> I even pushed this to a git tree. Not sure why it didn't get flagged.

I've been looking at this... how do I enable CONFIG_UWIND_USER ?

I suspect the problem is that its impossible to actually compile/use
this code.

