Return-Path: <bpf+bounces-46897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B9B9F1742
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C7F1885A2D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB811E47DA;
	Fri, 13 Dec 2024 20:09:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EF19A2A3
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120568; cv=none; b=XAnmFovnM89DO04hnfQl7aMqtzwO3mFDT3Rq8Hyth4o5YZDGZ+7L4gM7XW0QdKcmJzn3EBgDeBoTBBkIMGwQIB98rdrGf9mKmbQHwkNSL4LwhFzlII6nwgS1a27v6fWpXeOpB5UWWMAPSOwXbaZ9Wgf3io9KL8yZSrtFxpDR+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120568; c=relaxed/simple;
	bh=gZOwsF5A8Gyh1XTXc/YXWQgLDvQAThV7RnuuX2dcVIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhjVVlf9at65K30OpCf0ESK2n7KxhBy07SorFOhs4K3Efae5B/U6qQmM3G78UKUmPoQ+I0nOY4kLvkxo7voC7tnrPBNdv11vc/OlpuHjLuNQCOuWugbtzAeJVGj4HZBIaUDhnbCKRzEiOunKZv2DB/UTJvlRU5u9CcAC1knt+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D670C4CED0;
	Fri, 13 Dec 2024 20:09:25 +0000 (UTC)
Date: Fri, 13 Dec 2024 15:09:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Michal Hocko
 <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, bpf
 <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 shakeel.butt@linux.dev, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo
 <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241213150950.2879b7db@gandalf.local.home>
In-Reply-To: <CAADnVQ+R3ABHX2sdiTqjgZDgn0==cA3gryx9h_uDktU6P2s2aw@mail.gmail.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
	<20241210023936.46871-2-alexei.starovoitov@gmail.com>
	<Z1fSMhHdSTpurYCW@casper.infradead.org>
	<Z1gEUmHkF1ikgbor@tiehlicka>
	<CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
	<20241212150744.dVyycFUJ@linutronix.de>
	<Z1r_eKGkJYMz-uwH@tiehlicka>
	<20241212153506.dT1MvukO@linutronix.de>
	<20241212104809.1c6cb0a1@batman.local.home>
	<20241212160009.O3lGzN95@linutronix.de>
	<20241213124411.105d0f33@gandalf.local.home>
	<CAADnVQ+R3ABHX2sdiTqjgZDgn0==cA3gryx9h_uDktU6P2s2aw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 10:44:26 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > But this is not the case. I'm not sure what would happen here, but it is
> > definitely out of scope of the requirements of the PI logic and thus,
> > trylock must also not be used in hard interrupt context.  
> 
> If hard-irq acquired rt_mutex B (spin_lock or spin_trylock doesn't
> change the above analysis), the task won't schedule
> and it has to release this rt_mutex B before reenabling irq.
> The irqrestore without releasing the lock is a bug regardless.
> 
> What's the concern then? That PI may see an odd order of locks for this task ?
> but it cannot do anything about it anyway, since the task won't schedule.
> And before irq handler is over the B will be released and everything
> will look normal again.

The problem is the chain walk. It could also cause unwanted side effects in RT.

If low priority task 1 has lock A and is running on another CPU and low
priority task 2 blocks on lock A and then is interrupted right before going
to sleep as being "blocked on", and takes lock B in the interrupt context.
We then have high priority task 3 on another CPU block on B which will then
see that the owner of B is blocked (even though it is not blocked for B), it
will boost its priority as well as the owner of the lock (A). The A owner
will get boosted where it is not the task that is blocking the high
priority task.

My point is that RT is all about deterministic behavior. It would require
a pretty substantial audit to the PI logic to make sure that this doesn't
cause any unexpected results.

My point is, the PI logic was not designed for taking a lock after being
blocked on another lock. It may work, but we had better prove and show all
side effects that can happen in these cases.

-- Steve

