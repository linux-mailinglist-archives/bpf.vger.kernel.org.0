Return-Path: <bpf+bounces-30756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C37F8D21CF
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4181F2221C
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF917332E;
	Tue, 28 May 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu2iaWbv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDD172BD9;
	Tue, 28 May 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914503; cv=none; b=TegFQfTCSLrjhrZNMf8BNpbH6Q6ftfzcN8H/Q/tW2nNRMFgERHEl+qYOww7u+oooMsov6ufyhM7P8tYyfx1XzJnoBGRENqOv8XPpnuvXgK3gIJLbm9pB88jM1vbpbdzx2O0Bh/DiqjGWwixCWDpGSDk8jQtQzU/6zsBH5u4HoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914503; c=relaxed/simple;
	bh=S24BlvdP5FlyV+yxjEpxZeqIrj5x14GLWTJqi/d3rAU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SZhY9f41nic4yHGItcFwGvmmP6KuBpIhrTPoMOHndULGAcuHgtCnzBBjM81PTPhWFxA+ywXo1y+W1NiZkkeiurids1gx3IJFWKU2pGglQe10KBsywEz9HLlzIfi/J5q/tMlVJaURifrnwoRMdm5fhlsRmlurW7kLkMlzWvUE2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu2iaWbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD13DC3277B;
	Tue, 28 May 2024 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716914503;
	bh=S24BlvdP5FlyV+yxjEpxZeqIrj5x14GLWTJqi/d3rAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vu2iaWbvC5FOvROFM+nBVcxc37tkFLJfbHbAWZ66U745SqJzBgY0EN7SBokiG4H96
	 Y0Dz9ZWqa8SG3fN6cQyh1MgkuQ4bM7Om3plvcXNL1HNBMRbkWTnXqeAM3OyaYZVDIS
	 tgoaCeDgFKy1Vq/h1SjIVfShOkwT///KVCFF0skGJ2gMgSA/rrONKtGD7TeHr8dnKw
	 /nQ/52jzJ9b9HDvQsEtbKG/2glgRuKs/1RVXIq7rq38/o9i8wXIYxTXYs5apNe/W+h
	 VfBmngGDAtmjIthP8X2zT3JkjHLZAOb5DYNcT1MXzwCcl3EcabA0/VF1mhbcH9jOte
	 2vzhkD1co25vw==
Date: Wed, 29 May 2024 01:41:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "wuqiang.matt" <wuqiang.matt@bytedance.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] objpool: enable inlining objpool_push() and
 objpool_pop() operations
Message-Id: <20240529014138.b66a8c76ef219d165496a5b4@kernel.org>
In-Reply-To: <93840eb4-609d-49d3-b48a-9c26bfb5b8ec@suse.cz>
References: <20240424215214.3956041-1-andrii@kernel.org>
	<20240424215214.3956041-2-andrii@kernel.org>
	<0e8b7482-478e-4efc-ad5f-76d60cf02bfd@suse.cz>
	<d841cb8f-fb7e-4427-8f21-a850bee3693f@bytedance.com>
	<93840eb4-609d-49d3-b48a-9c26bfb5b8ec@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Sorry for late reply.

On Fri, 10 May 2024 10:20:56 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 5/10/24 9:59 AM, wuqiang.matt wrote:
> > On 2024/5/7 21:55, Vlastimil Babka wrote:
>  >>
> >>> +	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> >>> +
> >>> +	/* now the tail position is reserved for the given obj */
> >>> +	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
> >>> +	/* update sequence to make this obj available for pop() */
> >>> +	smp_store_release(&slot->last, tail + 1);
> >>> +
> >>> +	return 0;
> >>> +}
> >>>   
> >>>   /**
> >>>    * objpool_push() - reclaim the object and return back to objpool
> >>> @@ -134,7 +219,19 @@ void *objpool_pop(struct objpool_head *pool);
> >>>    * return: 0 or error code (it fails only when user tries to push
> >>>    * the same object multiple times or wrong "objects" into objpool)
> >>>    */
> >>> -int objpool_push(void *obj, struct objpool_head *pool);
> >>> +static inline int objpool_push(void *obj, struct objpool_head *pool)
> >>> +{
> >>> +	unsigned long flags;
> >>> +	int rc;
> >>> +
> >>> +	/* disable local irq to avoid preemption & interruption */
> >>> +	raw_local_irq_save(flags);
> >>> +	rc = __objpool_try_add_slot(obj, pool, raw_smp_processor_id());
> >> 
> >> And IIUC, we could in theory objpool_pop() on one cpu, then later another
> >> cpu might do objpool_push() and cause the latter cpu's pool to go over
> >> capacity? Is there some implicit requirements of objpool users to take care
> >> of having matched cpu for pop and push? Are the current objpool users
> >> obeying this requirement? (I can see the selftests do, not sure about the
> >> actual users).
> >> Or am I missing something? Thanks.
> > 
> > The objects are all pre-allocated along with creation of the new objpool
> > and the total number of objects never exceeds the capacity on local node.
> 
> Aha, I see, the capacity of entries is enough to hold objects from all nodes
> in the most unfortunate case they all end up freed from a single cpu.
> 
> > So objpool_push() would always find an available slot from the ring-array
> > for the given object to insert back. objpool_pop() would try looping all
> > the percpu slots until an object is found or whole objpool is empty.
> 
> So it's correct, but seems rather wasteful to have the whole capacity for
> entries replicated on every cpu? It does make objpool_push() simple and
> fast, but as you say, objpool_pop() still has to search potentially all
> non-local percpu slots, with disabled irqs, which is far from ideal.

For the kretprobe/fprobe use-case, it is important to push (return) object
fast. We can reservce enough number of objects when registering but push
operation will happen always on random CPU.

> 
> And the "abort if the slot was already full" comment for
> objpool_try_add_slot() seems still misleading? Maybe that was your initial
> idea but changed later?

Ah, it should not happen...

> 
> > Currently kretprobe is the only actual usecase of objpool.

Note that fprobe is also using this objpool, but currently I'm working on
integrating fprobe on function-graph tracer[1] which will make fprobe not
using objpool. And also I'm planning to replace kretprobe with the new
fprobe eventually. So if SLUB will use objpool for frontend caching, it
sounds good to me. (Maybe it can speed up the object allocation/free)

> > 
> > I'm testing an updated objpool in our HIDS project for critical pathes,
> > which is widely deployed on servers inside my company. The new version
> > eliminates the raw_local_irq_save and raw_local_irq_restore pair of
> > objpool_push and gains up to 5% of performance boost.
> 
> Mind Ccing me and linux-mm once you are posting that?

Can you add me too?

Thank you,

> 
> Thanks,
> Vlastimil
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

