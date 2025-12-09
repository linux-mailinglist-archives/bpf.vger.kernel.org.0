Return-Path: <bpf+bounces-76379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42286CB14A4
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 23:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F86F302762F
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE85A2EA168;
	Tue,  9 Dec 2025 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y65xC4Yb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97326E706;
	Tue,  9 Dec 2025 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319343; cv=none; b=kjN/0oi4cDBCgmBWuPs8viaNzmdM5H5yWwEqk3zYFi7rXRk53l5p+cnw2N5ZJGXzlofGdJVSChW7xHFzwY/jqhD2pD4Gap09DDcdURRGq/UHIEHvHTBT5s/SwA/5Xy3lkHV9jQhsV2jxx76g4xOmjvgzWp+yW/mm56ColDBnZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319343; c=relaxed/simple;
	bh=PuSbWbgUByM578ik0jdxWy1kNOmNeFEhoG4GggzJS1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDxIauCoNcgXjuJ20pexfQHk5fiKKcInKhJzL82A5TaEaiKH1AjqR6QLP8YXHuL1cTYcAWFnCjcxloY1wXMVJY+qxihaO3/0ZLrCKVsTX3H3j7aD4FkWgREMPZWO32xZ5tSK4Jg1OA8i6sv/5JIJESJ6Mu8SjgoH9Oqe5rkLw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y65xC4Yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B444CC4CEF5;
	Tue,  9 Dec 2025 22:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765319342;
	bh=PuSbWbgUByM578ik0jdxWy1kNOmNeFEhoG4GggzJS1c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Y65xC4YbmUsdmytnCYReOSDlGSPwfQbUYO/9Xky31H61OlV/zxf95m/rJsGxq39Cm
	 jjsDOHfy1m2muVNIP5z6UwVRO4M4khIt2dFoa2Ze1fE5pnqtmV2vRrozk/sKrgOS3N
	 R23M3FUpHX5GX3CeFshd3VT6KovQjgk3GL8q4rOm/hwHBhviSg9KydgN9ICooArsIf
	 /Qp/ClztQ7RktshHB/5KwANxLq2YAU/KHClC8uppq8isa3n+TD5eODhE3fSqBHLpMu
	 KqtACcaOhlBfCvrMSfAmAuQmnUaRk/5KUbB2ARUYtmsyDUgLRZ3LXyoxlBO4XBUPQW
	 1MQ7HSIOPgwBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8CA16CE0D19; Tue,  9 Dec 2025 14:29:00 -0800 (PST)
Date: Tue, 9 Dec 2025 14:29:00 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <7052507f-a435-4fbb-bdf4-4949224e29dc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <20251208044352.38360456@debian>
 <075fd9e5-2db8-4030-9364-0be5e22e9902@paulmck-laptop>
 <20251208193849.3a51648a@debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208193849.3a51648a@debian>

On Mon, Dec 08, 2025 at 07:38:49PM -0500, Steven Rostedt wrote:
> On Mon, 8 Dec 2025 12:46:32 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > >             bash-1165    [001] DBZ.f   269.955762: sys_rt_sigaction -> 0x0
> > >                                ^^^^^
> > >                             This is just garbage.  
> > 
> > Yes, but is is the original garbage, and garbage obtained by acceding
> > to your request.  ;-)
> 
> Yes, here's what it looks like before patch:
> 
>             bash-1168    [001] .....    77.498737: sys_wait4 -> 0xfffffffffffffff6
>             bash-1168    [001] .....    77.498740: sys_rt_sigreturn()
>             bash-1168    [001] .....    77.498765: sys_rt_sigaction(sig: 2, act: 0x7ffef2f08c50, oact: 0x7ffef2f08cf0, sigsetsize: 8)
>             bash-1168    [001] .....    77.498770: sys_rt_sigaction -> 0x0
>             bash-1168    [001] .....    77.498794: sys_rt_sigprocmask(how: 0, nset: 0, oset: 0x7ffef2f08c70, sigsetsize: 8)
>             bash-1168    [001] .....    77.498795: sys_rt_sigprocmask -> 0x0
>             bash-1168    [001] .....    77.499055: sys_write(fd: 1, buf: 0x562f0f3aba90 (1b:5d:38:30:30:33:3b:65:6e:64:3d:36:62:62:34:38:38:39:38:2d:32:33:31:33:2d:34:64:38:30:2d:39:30:62:39
> :2d:66:33:63:31:36:36:37:62:63:37:37:34:3b:65:78:69:74:3d:73:75:63:63:65:73:73:1b:5c) ".]8003;end=6bb48898-2313-4d80-90b9-f3c1667bc774;exit=success.\", count: 0x3e)
>             bash-1168    [001] .l...    77.499099: sys_write -> 0x3e
>             bash-1168    [001] .....    77.499196: sys_rt_sigprocmask(how: 0, nset: 0, oset: 0x7ffef2f080c0, sigsetsize: 8)
>             bash-1168    [001] .....    77.499198: sys_rt_sigprocmask -> 0x0
> 
> [ that lone "l" (el not one) is LAZY_NEED_RESCHED ]
> 
> After adding the patch:
> 
>             bash-1212    [005] DBZ.f    72.179808: sys_rt_sigprocmask -> 0x0
>             bash-1212    [005] DBZ.f    72.179811: sys_ioctl(fd: 0xff, cmd: 0x5401, arg: 0x7ffcaef0e1b0)
>             bash-1212    [005] DBZ.f    72.179815: sys_ioctl -> 0x0
>             bash-1212    [005] DBZ.f    72.179818: sys_ioctl(fd: 0xff, cmd: 0x5413, arg: 0x7ffcaef0e1c0)
>             bash-1212    [005] DBZ.f    72.179823: sys_ioctl -> 0x0
>             bash-1212    [005] DBZ.f    72.179862: sys_rt_sigprocmask(how: 2, nset: 0x7ffcaef0e290, oset: 0, sigsetsize: 8)
>             bash-1212    [005] DBZ.f    72.179866: sys_rt_sigprocmask -> 0x0
>             bash-1212    [005] DBZ.f    72.179884: sys_wait4(upid: 0xffffffffffffffff, stat_addr: 0x7ffcaef0db50, options: 0xb, ru: 0)
>             bash-1212    [005] DBZ.f    72.179891: sys_wait4 -> 0xfffffffffffffff6
>             bash-1212    [005] DBZ.f    72.179894: sys_rt_sigreturn()

Understood.

> > Perhaps a little bit more constructively, have your conflicting changes
> > hit mainline yet?
> 
> All my changes have hit mainline.
> 
> I believe I did have a solution for fixing the above issue but I was
> planning to implement it after the merge window. I can probably do that
> today during the keynotes ;-)

Would it be easiest for me to just hand the patch back to you?  I am of
course happy to push it myself, but I am also happy to avoid being in
the way.

							Thanx, Paul

