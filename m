Return-Path: <bpf+bounces-76277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A2CACBA7
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 10:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15A8E301F016
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F33271F9;
	Mon,  8 Dec 2025 09:44:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1462E764B;
	Mon,  8 Dec 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765187049; cv=none; b=Gsw43ThYgnJ9gvb19JzHKD1jaBqa+MlZZRUZteO/Twdb4fAw+rghgDjjvkZMllAdw4MprZVvikWv9Cs0pQ45V0AvmaVxmTe4GAVcsZvHyoowBycUXMOOv0PeLWRwJAi7BD6uejseuN4hAt5NgG3SF2jLKZSkausgKCOaVYVmRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765187049; c=relaxed/simple;
	bh=fdGrF5Oel05UQlS5rNphnQjdaZXlo4AaW1ySaH3ZQMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnB+ACUrsXo46kR27J0nRtq/vLAPbDyPp7zzJQFsiY1/PHYrP8wO5WOH9CAxg3S8LRjXiUBdHlTap6SE4YkaQ/R+9AIHmxZ9KDTN9fFpHK3emcRfMKXFXtK+a48iWbb1fzHOnGMeMAi7GPtbY5cbWaJV4taM4PfTZ5KgxhFiZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 21D5E134476;
	Mon,  8 Dec 2025 09:44:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 546A280012;
	Mon,  8 Dec 2025 09:43:57 +0000 (UTC)
Date: Mon, 8 Dec 2025 04:43:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, bpf@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251208044352.38360456@debian>
In-Reply-To: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xjhpdxmxrad6dnq1cfyd6da57cgwtyfj
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 546A280012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19KfNPMKJwmVO5vRkSn9ulTXGzJeOBKsC8=
X-HE-Tag: 1765187037-28855
X-HE-Meta: U2FsdGVkX1/Ia48z6eciqgZ/TNJY5RchHBkWXK9JPl3lPNX8a50/kkjyL+fU+XUS7RgLjqc3C5ugRdOXjE04ClEoK/iptiF2+B2KJdEKtsAjUVp9aKw4RljQvT8psDZaSehDIXyp1MoTJxCil9V7smR9IXP7TkCTtZQC21c/+ek3E1jdh1LfWNuXVlQJrq/iEn7qKojJ+HAAuyf92IkNWS+YbJruGzpTy+nc6aEcaAkaDn1AtdK2VrGjvExNuYFQwqw59BpiYvegWnDT6MBLfZYozqRgE+lB7jlxATXP7gtBMcbp7jSrU13aFrJkfpWnOBKOaz76E1Loz24nAFAprkfT/7vtSYhc

On Sun, 7 Dec 2025 20:20:23 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> [ paulmck: Remove trace_syscalls.h changes per Steven Rostedt. ]

But they still need to be fixed.

With PREEMPT_RT enabled:

 # trace-cmd start -e syscalls
 # trace-cmd show
            bash-1165    [001] DBZ.f   269.955644: sys_ioctl(fd: 0xff, cmd: 0x5413, arg: 0x7fffd3d6a2d0)
            bash-1165    [001] DBZ.f   269.955649: sys_ioctl -> 0x0
            bash-1165    [001] DBZ.f   269.955694: sys_rt_sigprocmask(how: 2, nset: 0x7fffd3d6a3a0, oset: 0, sigsetsize: 8)
            bash-1165    [001] DBZ.f   269.955698: sys_rt_sigprocmask -> 0x0
            bash-1165    [001] DBZ.f   269.955715: sys_wait4(upid: 0xffffffffffffffff, stat_addr: 0x7fffd3d69c50, options: 0xb, ru: 0)
            bash-1165    [001] DBZ.f   269.955722: sys_wait4 -> 0xfffffffffffffff6
            bash-1165    [001] DBZ.f   269.955725: sys_rt_sigreturn()
            bash-1165    [001] DBZ.f   269.955758: sys_rt_sigaction(sig: 2, act: 0x7fffd3d6a2e0, oact: 0x7fffd3d6a380, sigsetsize: 8)
            bash-1165    [001] DBZ.f   269.955762: sys_rt_sigaction -> 0x0
                               ^^^^^
                            This is just garbage.

-- Steve

