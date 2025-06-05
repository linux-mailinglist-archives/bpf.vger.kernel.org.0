Return-Path: <bpf+bounces-59726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23FACEF7A
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 14:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3651C3AD193
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1975F221F11;
	Thu,  5 Jun 2025 12:47:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F001FC0E2;
	Thu,  5 Jun 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127646; cv=none; b=KsHdLkBlZ68ph7XDmq6seka8W22lS7KlGUbr3obf34hfn7NLgbPXk+JhT9/3JNFoM+6Ryg/vSjLzsEB85Cl1baCqq/mSEbBRA4GvbjcYwSRgSENNjY0hsycOSGDQNwto6VlerFyZ9JCcE+Y8E9P5MRUGyIcxdyX+f4tVs951ThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127646; c=relaxed/simple;
	bh=SH9qwzbyg8F36LBU6FR7xOXsvoNAZ5waCbu7aTMlBCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YA6/oflAQguMKyTh712F2q2QVXyGQvI7Z1bW5fOizf2ysysDA8bEVlsjjYMzeATPfvjQd23um94LkN8ef3z5qALSsqtUPzKwO1Wi/GXwGutgOC5s3LUQiF4TsqFbvrr3Cg+JJTyy2EcJuQz9zJ/+60yp8KRp1Iio29fWtesrBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 859D512088A;
	Thu,  5 Jun 2025 12:47:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 331E620025;
	Thu,  5 Jun 2025 12:47:19 +0000 (UTC)
Date: Thu, 5 Jun 2025 08:48:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 bpf@vger.kernel.org, linux-rt-users@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf
 selftests
Message-ID: <20250605084816.3e5d1af1@gandalf.local.home>
In-Reply-To: <20250605091904.5853-1-spasswolf@web.de>
References: <20250605091904.5853-1-spasswolf@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 331E620025
X-Stat-Signature: whh6bi9m5mr9jaw1d1867w4c6y7arhmz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX187PQPCPjtJ4X6JvRAdXb0ZxxIf5B+1DAw=
X-HE-Tag: 1749127639-233947
X-HE-Meta: U2FsdGVkX1/NnoGasWV1VjzEiL0KUVJxN9Ft2Mh7D3kD+XZHV1EgB1XCq0ujiQLw074g4gP9GWj4jK5u6UN7xEUOZr61u05zTgU7c0W5IIqZjYX3QSec6X9+3Se2jp5OaHHU864AZvbLFLlKw1IK4VvP2B3o+UTnAj6HkBzCVfhoTh23zEXS8GJa8hJvnRo0RzoG+5A3jml9efRS9OAVf8RWmtn8E/PRflcHwhyoNIGwZk41vky58qd/vmDW/S4KWiJB1RU5ebh/Jv/2LJHlU3AMVYxKgwTBmKcnMeBfmV4zWbaMXtIZQdu9LNdn/nym

On Thu,  5 Jun 2025 11:19:03 +0200
Bert Karwatzki <spasswolf@web.de> wrote:

> This patch seems to create so much output that the orginal error message and
> backtrace often get lost, so I needed several runs to get a meaningful message
> when running

Are you familiar with preempt count tracing?

~# trace-cmd start -e preempt_enable -e preempt_disable
~# trace-cmd show
# tracer: nop
#
# entries-in-buffer/entries-written: 177552/177552   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
       trace-cmd-1131    [001] ...1.   965.046684: preempt_disable: caller=vfs_write+0x89c/0xe90 parent=vfs_write+0x89c/0xe90
       trace-cmd-1131    [001] ...1.   965.046695: preempt_enable: caller=vfs_write+0x923/0xe90 parent=vfs_write+0x923/0xe90
       trace-cmd-1131    [001] ...1.   965.046729: preempt_disable: caller=_raw_spin_lock+0x17/0x40 parent=0x0
       trace-cmd-1131    [001] ...1.   965.046746: preempt_enable: caller=_raw_spin_unlock+0x2d/0x50 parent=0x0
       trace-cmd-1131    [001] ...1.   965.046749: preempt_disable: caller=count_memcg_events+0x74/0x480 parent=count_memcg_events+0x74/0x480
       trace-cmd-1131    [001] ...1.   965.046751: preempt_enable: caller=count_memcg_events+0x2b4/0x480 parent=count_memcg_events+0x2b4/0x480
       trace-cmd-1131    [001] ...1.   965.046765: preempt_disable: caller=_raw_spin_lock+0x17/0x40 parent=0x0
       trace-cmd-1131    [001] ...1.   965.046769: preempt_enable: caller=_raw_spin_unlock+0x2d/0x50 parent=0x0
       trace-cmd-1131    [001] ...1.   965.046771: preempt_disable: caller=count_memcg_events+0x74/0x480 parent=count_memcg_events+0x74/0x480
       trace-cmd-1131    [001] ...1.   965.046773: preempt_enable: caller=count_memcg_events+0x2b4/0x480 parent=count_memcg_events+0x2b4/0x480
       trace-cmd-1131    [001] ...1.   965.046787: preempt_disable: caller=_raw_spin_lock+0x17/0x40 parent=0x0
       trace-cmd-1131    [001] ...1.   965.046801: preempt_enable: caller=_raw_spin_unlock+0x2d/0x50 parent=0x0
       trace-cmd-1131    [001] ...1.   965.046803: preempt_disable: caller=count_memcg_events+0x74/0x480 parent=count_memcg_events+0x74/0x480
       trace-cmd-1131    [001] ...1.   965.046805: preempt_enable: caller=count_memcg_events+0x2b4/0x480 parent=count_memcg_events+0x2b4/0x480
       trace-cmd-1131    [001] d..1.   965.046812: preempt_disable: caller=_raw_spin_lock_irq+0x2b/0x60 parent=0x0
       trace-cmd-1131    [001] ...1.   965.046815: preempt_enable: caller=_raw_spin_unlock_irq+0x38/0x60 parent=0x0
[..]

It's very light weight. There's also trace_printk() that is also very light
weight to use.

It's enabled when you enable CONFIG_PREEMPT_TRACER.

-- Steve

