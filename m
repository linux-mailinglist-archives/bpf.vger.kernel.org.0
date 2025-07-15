Return-Path: <bpf+bounces-63358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E8B0666B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 21:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09504A2453
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02CB28C02C;
	Tue, 15 Jul 2025 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVY+z1bm"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6284D08;
	Tue, 15 Jul 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606124; cv=none; b=AUv/Vx0Rbv+kfdBY0tUl32Ch2qKHSgJKYuJoli4gd61MR+Odx+eCrRCTmpDnZr9WgweKV6oivsyfz7lOIbRf9cHjtMGb4FjGcjVdsmywtx6QZQrv2pfW9X/0eMkZN3Gidot4G5DcTcGLmS6Ko9sQIm5quqjuZ/eJ1sIKMsQVaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606124; c=relaxed/simple;
	bh=+sAh1If8BjuK0pvB9U7uBcJ5tysPZ7oRAhi8SvIJA+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQT+A7kOp5373U8kPC3cfTtOfA4CfwLUp/Qm76NRxPPPtvUFcXFvza/VSh3pTEUQa8Y12pgu84ygAoAx2/jxFatH782fHFsuvifF2NFMj/4MS5Yrarw/s3qZ168ayJSt5WcYjjFfNPS3B44EAxWEkMFL61v08E+mQYSJofJIcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eVY+z1bm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vfvPe4HP02bQoj3HUfT9H152gPlNxmP69GglcQVHFyM=; b=eVY+z1bmlvCZqlVTJDwrLbv/8K
	K8zWTx0JwsToQZm4D2uDxJrqKdRYAKr8AAAefEzi+EdCMQXZqW/W+EHXf3uRNJIMMIexEpeTSZ910
	4qETpdv9vkBB3lyU51GWIkeeCQPZHgtXcHrTfSJuFTkSM443ytFn4p1EpVpy6PDrwSAOpsbaBXLSK
	lPBly1xAefeYOFWz7Ldg965PZ0LxaxIJ5KlZrqMNzsmV5pzlIFU/Ae4NCfSfmrcR05S8eqHzQNuRx
	x9md/BT9ZEj6PL6/GcfNYYBzFbi2zhilf1KFaT3Nl2w9D323ctnaDyO+yVLMv9Ovngdcrqro7qqjz
	czuAshjw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubkuN-00000009vEi-0K7n;
	Tue, 15 Jul 2025 19:01:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E3D623001AA; Tue, 15 Jul 2025 21:01:41 +0200 (CEST)
Date: Tue, 15 Jul 2025 21:01:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to user
 space
Message-ID: <20250715190141.GF4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012359.345060579@kernel.org>
 <20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
 <20250715084932.0563f532@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715084932.0563f532@gandalf.local.home>

On Tue, Jul 15, 2025 at 08:49:32AM -0400, Steven Rostedt wrote:
> > The below is the last four patches rolled into one. Not been near a
> > compiler.
> 
> Are you recommending that I fold those patches into one?

Not particularly; but given the terrible back and forth, the only sane
way to 'show' my changes it from patch 6 onwards folded. If I were to
diff against patch 9 it'd be a shitshow.

At the very least the SRCU thing ought to be broken back out. Not sure
how many pieces it can reasonably be broken into, see what works.

