Return-Path: <bpf+bounces-74550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F01C5F07C
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4F5D35C8F3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77182F0698;
	Fri, 14 Nov 2025 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STZRA6MN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91C2DC34D;
	Fri, 14 Nov 2025 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148040; cv=none; b=XbqEmJZOIOI1cWqxD2rtjpwKSgLRsfrWIKCFbynmQKCtIuLrc4pNjm7KNBfBVpJcDYxXHF6JkuK0kXbOP2eZbcaLi4m4nFW8ahWnLRkjsLulznZbDMLtZ0sfxo3Ma8L0w22cX/uLQx8Dm4dfphWPlCesr8PHKvdxjvkU1JbWr1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148040; c=relaxed/simple;
	bh=6OZwm3/vATkgmrObf611KQsaycSWIREGTponHLVPn08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adagqt7OLBjIXVZ8PQbcsfoBf0DjeGvWKEA7h4OcQZS8+y70do5R2pPAzknbZ2plsctTlryXjI1fufrIhw4DVGrSFTJ61o9MiJpJ/UQ1KM7kOtJ03Zbma0ZB0ItGMBS4YOHIqtU11bwVR4babcyW9DwMliEdJ76xzqOtMkqUtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STZRA6MN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A02C2BC9E;
	Fri, 14 Nov 2025 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148039;
	bh=6OZwm3/vATkgmrObf611KQsaycSWIREGTponHLVPn08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STZRA6MNvMe3Ql1fhy76l4MlejPt8w+uha4e2biEHS6lGMeCZPOV5dJKIJeRYNG4j
	 L6ES+p0IQ0dfUfg0f4e1LsR7OiW7JkH0JF9l9JmHAwKPs+vKhxYtewpRDc0TD+/Zk2
	 teDDYQk/PRtewJ4qYl3u5wXMFOKs7nJ4CFJUEnMQ/Fgpb2fpTF7FeNSt9muclTX4Os
	 1lMdHM5k1sER4xB1P34HxYN8c9q88bpWJkzj34YBNDR+Ym7JLyiMJImT3iHOPpNu34
	 86LwvZ4qU0K94iEO8LPtNOGZvypcLB4BVC/Y2tWLk1ZUoijt5Z5Rv1SRP1ysMfp6Bi
	 Zrz+CeeYo+BzQ==
Date: Fri, 14 Nov 2025 11:20:37 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user
 callchains
Message-ID: <aReBBQAhnto3RZ2d@google.com>
References: <20251114070018.160330-1-namhyung@kernel.org>
 <20251114070018.160330-4-namhyung@kernel.org>
 <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com>
 <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
 <20251114133009.7dd97625@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114133009.7dd97625@gandalf.local.home>

On Fri, Nov 14, 2025 at 01:30:09PM -0500, Steven Rostedt wrote:
> On Fri, 14 Nov 2025 10:09:26 -0800
> Ian Rogers <irogers@google.com> wrote:
> 
> > Just to be clear. I don't think the behavior of using frame pointers
> > should change. Deferral has downsides, for example:
> > 
> >   $ perf record -g -a sleep 1
> 
> The biggest advantage of the deferred callstack is that there's much less
> duplication of data in the ring buffer. Especially when you have deep
> stacks and long system calls.
> 
> Now, if we have frame pointers enabled, we could possibly add a feature to
> the deferred unwinder where it could try to do the deferred immediately and
> if it faults it then waits until going back to user space.

This would be great if it can share the callstack with later samples
before going to user space.


> This means that
> the frame pointer version should work (unless the user space stack was
> swapped out).
> 
> > 
> > Without deferral kernel stack traces will contain both kernel and user
> > traces. With deferral the user stack trace is only generated when the
> > system call returns and so there is a chance for kernel stack traces
> > to be missing their user part. An obvious behavioral change.

Right, this is one of my concerns too.  For system-wide profiling, the
chances are high it can have some tasks sleeping in the kernel and perf
finishes the profiling before they return to user space.

Thanks,
Namhyung


> > I think
> > for what you are doing here we can have an option something like:
> > 
> >   $ perf record --call-graph fp-deferred -a sleep 1
> 
> I would be OK with this but I would prefer a much shorter name. Adding 20
> characters to the command line will likely keep people from using it.
> 
> -- Steve

