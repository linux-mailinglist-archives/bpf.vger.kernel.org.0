Return-Path: <bpf+bounces-76316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B0CAE2C1
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 21:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C051630202DE
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4506C2DCC01;
	Mon,  8 Dec 2025 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIg9LFl5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9201259CB6;
	Mon,  8 Dec 2025 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765226795; cv=none; b=bgdvkyUx0TNPIvAvTy4pw72e0PBKBIu6MIp6ySuGPg6dyOkKR+jkgYjp1vRnuAAww6RGCf2ne9+qvsmmE+Wh9BcQn3M2iziGNFCaGeLSQ7n2Le7xbWRRqQ5cBvL3LykN1qRBKIIPc6eur9Qo9wHOZ4e/45AWnNAqM82WgprnU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765226795; c=relaxed/simple;
	bh=x2UjReiwtmk0C2BH6V97iqqnFcSMI5RmReTQSBck62I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJog8PS0EjmJLSeaUZvlDcqwRLpuu38U4IPETC4KnNofrQX4o5ZoyK8FaDHoShMaVBa3qeGogqawi0gzNo5r6liAZ08mWjpIIb+X7Vo69AK+iDD+13MCxvOUgbs8vYES9KAq6twWnU5KPPXPC5WUJth5usdygFmjlfMVWhBHFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIg9LFl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14006C4CEF1;
	Mon,  8 Dec 2025 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765226795;
	bh=x2UjReiwtmk0C2BH6V97iqqnFcSMI5RmReTQSBck62I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pIg9LFl5rDMHuLyh2sTdtBK74Xvcp8hqeNMjrWpISJ6TLXPUdBTVvoZIj5F8LEY/V
	 Q8SK8OFnI2WORa1yeGP+phTA4ujmTJpBRGm1aJ9orW+QQW2SOwaqts2Gd2FbtQuEZY
	 Z0QUZinOroGm2S59gglZuLH1K0Go3j7ItIGDJWtVr/rTJg/DZNbTbxJZSb1funjMRS
	 qu5Vynl1dBzwPV0NVEPrKRIN6enYly5MynZXCaK9HceQH6QMosVahEuEbXEoizHeSl
	 wUIuW8fasjZjECRx/x3iRRO1pj1iSObR4Aoq2WnZI3KK7P6vXezoZA9aPxp1NXszf1
	 UNWaYSJlXCL8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D98FDCE0D19; Mon,  8 Dec 2025 12:46:32 -0800 (PST)
Date: Mon, 8 Dec 2025 12:46:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <075fd9e5-2db8-4030-9364-0be5e22e9902@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <20251208044352.38360456@debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208044352.38360456@debian>

On Mon, Dec 08, 2025 at 04:43:52AM -0500, Steven Rostedt wrote:
> On Sun, 7 Dec 2025 20:20:23 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > [ paulmck: Remove trace_syscalls.h changes per Steven Rostedt. ]
> 
> But they still need to be fixed.
> 
> With PREEMPT_RT enabled:
> 
>  # trace-cmd start -e syscalls
>  # trace-cmd show
>             bash-1165    [001] DBZ.f   269.955644: sys_ioctl(fd: 0xff, cmd: 0x5413, arg: 0x7fffd3d6a2d0)
>             bash-1165    [001] DBZ.f   269.955649: sys_ioctl -> 0x0
>             bash-1165    [001] DBZ.f   269.955694: sys_rt_sigprocmask(how: 2, nset: 0x7fffd3d6a3a0, oset: 0, sigsetsize: 8)
>             bash-1165    [001] DBZ.f   269.955698: sys_rt_sigprocmask -> 0x0
>             bash-1165    [001] DBZ.f   269.955715: sys_wait4(upid: 0xffffffffffffffff, stat_addr: 0x7fffd3d69c50, options: 0xb, ru: 0)
>             bash-1165    [001] DBZ.f   269.955722: sys_wait4 -> 0xfffffffffffffff6
>             bash-1165    [001] DBZ.f   269.955725: sys_rt_sigreturn()
>             bash-1165    [001] DBZ.f   269.955758: sys_rt_sigaction(sig: 2, act: 0x7fffd3d6a2e0, oact: 0x7fffd3d6a380, sigsetsize: 8)
>             bash-1165    [001] DBZ.f   269.955762: sys_rt_sigaction -> 0x0
>                                ^^^^^
>                             This is just garbage.

Yes, but is is the original garbage, and garbage obtained by acceding
to your request.  ;-)

Perhaps a little bit more constructively, have your conflicting changes
hit mainline yet?

							Thanx, Paul

