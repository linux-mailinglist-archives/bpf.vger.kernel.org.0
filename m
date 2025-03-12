Return-Path: <bpf+bounces-53884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E519BA5D9CD
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750ED3B339F
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB5235345;
	Wed, 12 Mar 2025 09:45:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B21DEFDD
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772751; cv=none; b=WEP2rO5E39C86r2Rce1NYygw0GgFmLuE/EXbcv7HPMB8uYm9q5Ox4PpeWwMOOmguIE46TCxxUjR4JB/luAcuhvKM0dQui7PMjOx2Y8VUewoZx+TAJryEbVSxh5nN8nFMqRawTJrhBl8fRbGfNBnw6oWlbPtHLGVRpMdTQ4Pni7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772751; c=relaxed/simple;
	bh=txwgjPqzzZaizTpTsEgL4Osujh4B6jyJ9XbL4dWYjLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5wi21Ij0BWHYBXdtOmqJexb2sxQrBxQqvUQ2t3tT7UzvPIq6jGh5wzfWzoes0QW2q2G7b7nwVZUVKWOHJUsVA4xcFBcE2SxM9QnLFgxV8AdIdP9pghh0BRI6tIcLZdlQmi5DJCVoCT4xV6ud44n2/bru9PmHdN9LhWcU8pj+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8423DC4CEEC;
	Wed, 12 Mar 2025 09:45:47 +0000 (UTC)
Date: Wed, 12 Mar 2025 05:45:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Sebastian Sewior <bigeasy@linutronix.de>, Hou Tao <houtao1@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, Matthew Wilcox
 <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn
 <jannh@google.com>, Tejun Heo <tj@kernel.org>, linux-mm
 <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages()
 for opportunistic page allocation
Message-ID: <20250312054545.11681338@batman.local.home>
In-Reply-To: <rbfpuj6kmbwbzyd25tjhlrf4aytmhmegn5ez54rpb2mue3cxyk@ok46lkhvvfjt>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
	<20250222024427.30294-3-alexei.starovoitov@gmail.com>
	<20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
	<CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
	<rbfpuj6kmbwbzyd25tjhlrf4aytmhmegn5ez54rpb2mue3cxyk@ok46lkhvvfjt>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 19:04:47 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> A small bit before that:
>        if (!spin_trylock_irqsave(&zone->lock, flags)) {
> 	       if (unlikely(alloc_flags & ALLOC_TRYLOCK))
> 		       return NULL;
> 	       spin_lock_irqsave(&zone->lock, flags);
>        }
> 
> This is going to perform worse when contested due to an extra access to
> the lock. I presume it was done this way to avoid suffering another
> branch, with the assumption the trylock is normally going to succeed.

What extra access? If a spinlock were to fail, it keeps checking the
lock until it's released. If anything, this may actually help with
performance when contended.

Now, there's some implementations of spinlocks where on failure to
secure the lock, some magic is done to spin on another bit instead of
the lock to prevent cache bouncing (as locks usually live on the same
cache line as the data they protect). When the owner releases the lock,
it will also have to tell the spinners that the lock is free again.

But this extra trylock is not going to show up outside the noise.

-- Steve

