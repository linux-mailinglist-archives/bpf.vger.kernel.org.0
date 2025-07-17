Return-Path: <bpf+bounces-63641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BBFB09240
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2CB5A1826
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211242FCFD0;
	Thu, 17 Jul 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqG5RH84"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB52F6FAD;
	Thu, 17 Jul 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771277; cv=none; b=CKWaE9LFuB4HXoWt2x12y1UcdqhhqXuhQYdFmWFOe5SMrVvQZPvYA/nTSC9wjaelPvfGpXNvUuh/l9j/vAKCrH38Py53WMxUSupIw3HUeihkJdOwAWixUGbTFvStRYU3Qf3Mid33AI2AaIpH9zkulGcb9rA4qsrMzPbY9j9b3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771277; c=relaxed/simple;
	bh=wltZfUVemhVqBJv2X+OS136Vc8QdzWWBDDT2yFGTmVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAgfBZAT1OQI3YWDJ6c+JYRZRd0lrvdJxzcq4uPE1U9cfwqo80dOI5+ovGjzdRI+iixKrBTZB177Uzilpa+aR888TcA2gdNGB4aBxB5ZQYa9KV9+xTFsiJlqWkgoH4bqL9odbv0Xpl0XVp8N9+mBaUdClboVQ5i+ap+HQqPsyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqG5RH84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DB8C4CEE3;
	Thu, 17 Jul 2025 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752771277;
	bh=wltZfUVemhVqBJv2X+OS136Vc8QdzWWBDDT2yFGTmVQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fqG5RH84Fm+Gibjk6PACO1WmcIkOKhWjUH2BIZIpdSJFAtmhrpeJV6cPKkTFBG20/
	 6/7ejXdvkZmuyWGZrm6jsC4kLZmxcHEdZ8WMmyoNE2ZLByeUofdtG3p/HuNvCkKyCF
	 AFEsm4pLGhE6RkUBU09eJc/EuH92coBUgUUi8VBp0zpWPio/txAIrqq9jVOYwRjSNu
	 Qgp+Ie/hjqgFZIxmHxXpT1peSbCngph7IpTslaARBZZtC9M6IRtHC4on0yUnMDiekf
	 6WrSVUf1kL+VBD7wZU0O3TM7jStjE7mUTDHsB+1OEdYNk+92bqHKSiqPlDQ2MbtSsI
	 Xw+j6vTCg/+6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E8D8CE0B77; Thu, 17 Jul 2025 09:54:36 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:54:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v14 09/12] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <3eec6c5d-2e4c-41c0-ac43-6df51faeb670@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250717004910.297898999@kernel.org>
 <20250717004957.918908732@kernel.org>
 <47c3b0df-9f11-4e14-97e2-0f3ba3b09855@paulmck-laptop>
 <20250717082526.7173106a@gandalf.local.home>
 <41c204c0-eabc-4f4f-93f4-2568e2f962a9@paulmck-laptop>
 <20250717121010.4246366a@batman.local.home>
 <a9bdf195-e9b2-4cd0-88ba-b6f68b3b72b3@paulmck-laptop>
 <20250717123835.21c8aa89@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717123835.21c8aa89@batman.local.home>

On Thu, Jul 17, 2025 at 12:38:35PM -0400, Steven Rostedt wrote:
> On Thu, 17 Jul 2025 09:27:34 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Two, I'm still grasping at the concept of srcu_fast (and srcu_lite for
> > > that matter), where I rather be slow and safe than optimize and be
> > > unsafe. The code where this is used may be faulting in user space
> > > memory, so it doesn't need the micro-optimizations now.  
> > 
> > Straight-up SRCU and guard(srcu), then?  Both are already in mainline.
> > 
> > Or are those read-side smp_mb() calls a no-go for this code?
> 
> As I stated, the read-side is likely going to be faulting in user space
> memory. I don't think one or two smp_mb() will really make much of a
> difference ;-)
> 
> It's not urgent. If it can be switched to srcu_fast, we can do it later.

Very good, we will continue with our removal of SRCU-lite, and I might
as well add guard(srcu_fast) in my current series.

							Thanx, Paul

