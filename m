Return-Path: <bpf+bounces-46713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CDD9EECB6
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 16:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE9E16AB87
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1112210EA;
	Thu, 12 Dec 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nul1UW9c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IDAQv/ti"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D50C1547F0
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017711; cv=none; b=Z3GUOn2Tszzq74bWjbiJq5j82Qo9ZdewiP5MVm/ZZP0AoC2O+1usDXtToP7F+O5oAtOYzmk7QGn0QXUKAgMxIeYQZ839MSquGiZDs/vfXhhyLCTAlEuZ1Eds4j2aZ0welqR9kRdvBcIqCi2OXAbkM1sOon2RwS3tAqaPGCokjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017711; c=relaxed/simple;
	bh=0khaNL+eK3yAVlwjJGmHV8APAMIW1qXB1i8oCaUhFzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6RlVrsqm+YBAPglEoqpESYlUL/rk4ozaZ/VRiWY3cGhUrWNTtjY44h1VFsUzyepsb1BNpHmUdR4T7WRqhGhteYWotO+qmZrFMa4Ie2HSJTOEhptqaVNQhBIiDHpJYDfCmViGf7igt6zDZ0wLjBNH9DGVzmUKzXEEnXwHtvTJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nul1UW9c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IDAQv/ti; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Dec 2024 16:35:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734017707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0khaNL+eK3yAVlwjJGmHV8APAMIW1qXB1i8oCaUhFzE=;
	b=nul1UW9c8KDO7JV2fV1KsmtQ8C7u6RO4VW1ghEK3WPCCPfLg1Qyk/fHIafJ20ZzFObgGpj
	Lsm4FRcfvz0UqAOvb3t9WBxkc2tNiiXrd0zBqbbARFr3gKgSfWEi5k5muRMRDU1T5UY2B4
	E7SoAILmq2zQvLtDin4mmMp3vjc1U0+BAJPWdvtaYqlBS1B4YDcYxRhnp/NVy1Z6Gw7W20
	ojSgJnKQ3YksGyJ5BJRXy0q0vIT/vHXhasy6rIWa0uqdeYFbNqOPbk159ThT7s5sx4v/+z
	gRg5iprUzJ9hIvpLYT0jmqsPbR3fq913zSoY7pZTUS67In0FRU2RITilFttpqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734017707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0khaNL+eK3yAVlwjJGmHV8APAMIW1qXB1i8oCaUhFzE=;
	b=IDAQv/tihQH6LHxTMah2RHrGbH5iyg4wc5VUVFwtPCW70wJ9MsveOd3M7nw2h20tvL/oBW
	9R9BzRdwFeEk1eDQ==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Michal Hocko <mhocko@suse.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241212153506.dT1MvukO@linutronix.de>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka>
 <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
 <20241212150744.dVyycFUJ@linutronix.de>
 <Z1r_eKGkJYMz-uwH@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z1r_eKGkJYMz-uwH@tiehlicka>

On 2024-12-12 16:21:28 [+0100], Michal Hocko wrote:
> On Thu 12-12-24 16:07:44, Sebastian Sewior wrote:
> > But since I see in_nmi(). You can't trylock from NMI on RT. The trylock
> > part is easy but unlock might need to acquire rt_mutex_base::wait_lock
> > and worst case is to wake a waiter via wake_up_process().
>=20
> Ohh, I didn't realize that. So try_lock would only be safe on
> raw_spin_lock right?

If NMI is one of the possible calling contexts, yes.

One thing I am not 100% sure about is how "good" a spinlock_t trylock is
if attempted from hardirq (on PREEMPT_RT). Obtaining the lock und
unlocking is doable. The lock part will assign the "current" task as the
task that owns the lock now. This task is just randomly on the CPU while
the hardirq triggered. The regular spin_lock() will see this random task
as the owner and might PI-boost it. This could work=E2=80=A6

Sebastian

