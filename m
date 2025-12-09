Return-Path: <bpf+bounces-76329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF9CAE8D9
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 01:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F33304EDB9
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 00:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC74221FF46;
	Tue,  9 Dec 2025 00:39:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4343B8D7E;
	Tue,  9 Dec 2025 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765240740; cv=none; b=h88FVJDjOGaq+LG+D+PWTqa64ims2Jlnpc+Hxu2CTQyDuScyAwKP6SQ3ZNACU1em1qCfDvsMA2j2Zd9XcWfsxk7mz79qLCWsqokkZ+TVSRJH9fMaOiHgOvJKSHjnd3ylJx6rRHfJYgfefv5I8A/NpVEINBlucCc/txg0dUvOAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765240740; c=relaxed/simple;
	bh=K5SZ53rvRg+l4CX4EBlALPhPJQhW/y0zMG1HwyKwauE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9n45+Gh1zzdpWzKpFs+U1Uql2vCLq721UBZnoPuiR82MDON3OTtwNx+hSeT5yDsttOjHElR1UEhSQC6OvsJS9a2rVh3Z6hCrxynnKUP4CWPDd5okbdsSHlXvbAmGJkwYciW5jiQGcaGPJh0N1RuZRTbCjDGe3pVsgPhC7aoEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B960D13A941;
	Tue,  9 Dec 2025 00:38:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id E705F30;
	Tue,  9 Dec 2025 00:38:53 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:38:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, bpf@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251208193849.3a51648a@debian>
In-Reply-To: <075fd9e5-2db8-4030-9364-0be5e22e9902@paulmck-laptop>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
	<20251208044352.38360456@debian>
	<075fd9e5-2db8-4030-9364-0be5e22e9902@paulmck-laptop>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4jwx8sbbass9mdh3tu1ap3egb3wfkksn
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E705F30
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19derb2eVp8QjlHpOljct6+9mc+dJwWLNI=
X-HE-Tag: 1765240733-482286
X-HE-Meta: U2FsdGVkX1+rIEqrvrEFWEx8WUkjrN72JFefj5I8vS5+kDbTTwJgUeJzawmsJIHTEKS3IlkcnkpVZ8hOzayipuxSAFk/FPEB8Q7sqiGF945pYXmo4MpTjDH5eIws/BdpHuodSQ4RSzjT4KH3aa0k1n4S3pVU3CQ1RfYaw73xJH+2Fp+fw24WumugZjez4IRkM6hWb4BDbXYW0CyJjeGWqrQ3MxuasMMLABaYUBMYkLpw/lWfBaJcwRsey45vKORk1zVLRuEuoiHwdeeqtYgJHQWdZiHxCiG80PManPLszhh8Bmt9yNXqmhivEWQtFiSOQltA1KqBXbVsAZssWxJcYExGybgMNjAR

On Mon, 8 Dec 2025 12:46:32 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> >             bash-1165    [001] DBZ.f   269.955762: sys_rt_sigaction -> 0x0
> >                                ^^^^^
> >                             This is just garbage.  
> 
> Yes, but is is the original garbage, and garbage obtained by acceding
> to your request.  ;-)

Yes, here's what it looks like before patch:

            bash-1168    [001] .....    77.498737: sys_wait4 -> 0xfffffffffffffff6
            bash-1168    [001] .....    77.498740: sys_rt_sigreturn()
            bash-1168    [001] .....    77.498765: sys_rt_sigaction(sig: 2, act: 0x7ffef2f08c50, oact: 0x7ffef2f08cf0, sigsetsize: 8)
            bash-1168    [001] .....    77.498770: sys_rt_sigaction -> 0x0
            bash-1168    [001] .....    77.498794: sys_rt_sigprocmask(how: 0, nset: 0, oset: 0x7ffef2f08c70, sigsetsize: 8)
            bash-1168    [001] .....    77.498795: sys_rt_sigprocmask -> 0x0
            bash-1168    [001] .....    77.499055: sys_write(fd: 1, buf: 0x562f0f3aba90 (1b:5d:38:30:30:33:3b:65:6e:64:3d:36:62:62:34:38:38:39:38:2d:32:33:31:33:2d:34:64:38:30:2d:39:30:62:39
:2d:66:33:63:31:36:36:37:62:63:37:37:34:3b:65:78:69:74:3d:73:75:63:63:65:73:73:1b:5c) ".]8003;end=6bb48898-2313-4d80-90b9-f3c1667bc774;exit=success.\", count: 0x3e)
            bash-1168    [001] .l...    77.499099: sys_write -> 0x3e
            bash-1168    [001] .....    77.499196: sys_rt_sigprocmask(how: 0, nset: 0, oset: 0x7ffef2f080c0, sigsetsize: 8)
            bash-1168    [001] .....    77.499198: sys_rt_sigprocmask -> 0x0

[ that lone "l" (el not one) is LAZY_NEED_RESCHED ]

After adding the patch:

            bash-1212    [005] DBZ.f    72.179808: sys_rt_sigprocmask -> 0x0
            bash-1212    [005] DBZ.f    72.179811: sys_ioctl(fd: 0xff, cmd: 0x5401, arg: 0x7ffcaef0e1b0)
            bash-1212    [005] DBZ.f    72.179815: sys_ioctl -> 0x0
            bash-1212    [005] DBZ.f    72.179818: sys_ioctl(fd: 0xff, cmd: 0x5413, arg: 0x7ffcaef0e1c0)
            bash-1212    [005] DBZ.f    72.179823: sys_ioctl -> 0x0
            bash-1212    [005] DBZ.f    72.179862: sys_rt_sigprocmask(how: 2, nset: 0x7ffcaef0e290, oset: 0, sigsetsize: 8)
            bash-1212    [005] DBZ.f    72.179866: sys_rt_sigprocmask -> 0x0
            bash-1212    [005] DBZ.f    72.179884: sys_wait4(upid: 0xffffffffffffffff, stat_addr: 0x7ffcaef0db50, options: 0xb, ru: 0)
            bash-1212    [005] DBZ.f    72.179891: sys_wait4 -> 0xfffffffffffffff6
            bash-1212    [005] DBZ.f    72.179894: sys_rt_sigreturn()


> 
> Perhaps a little bit more constructively, have your conflicting changes
> hit mainline yet?

All my changes have hit mainline.

I believe I did have a solution for fixing the above issue but I was
planning to implement it after the merge window. I can probably do that
today during the keynotes ;-)

-- Steve

