Return-Path: <bpf+bounces-76862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F6ECC7F15
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 14:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A65EA303B65A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3F428695;
	Wed, 17 Dec 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiKXDt05"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1967F27442
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978542; cv=none; b=KbrE72pmu8XDAvuysYnOizy5H2t7ZwCZojZf8xkzCKe8FGurrOyRC2K94YluD68avW8kG+8lwNjW39qc79v851FNiCuoIj77+sXH45vkywc7lq71nh9KMDkn00yphetvUzkrBYK1sEe2POh4b9VAXYjxG0eP9vUjI9ekoKi2MCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978542; c=relaxed/simple;
	bh=4+hzO08SGe6qm2cHbr4p0yxiKUdjecOw57IPASCUjSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W+29UClisa36NuVg3OHMrwnQeiPeyNEc/06xZJfaq8fl6bxwup1L+YkKhqfmqsacuduW/SdPLMreHwr9AWhP1g8KVdYunPMpUdLRREUuzMoN2eJtJYyCyt0jBL4qZgoWs+u44x8kr6+IWnR/ZRHwtccdi8L5D1rpm1VXB8ncer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uiKXDt05; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b7fe37056e1so240588366b.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765978538; x=1766583338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3+abCe5E3Tvk7YKU0mcCWD1gF9CHnTNJLhm+1muw5I=;
        b=uiKXDt05nE3+IA7zs0TDE2XZNIQqr2MFTfzfg0TsjYWNEiybOIF6EcBpv1U7ZdBx2/
         FDhH/OHxLGU2pfpx0vWsw1z2yktzwd5eYKDWs5dn3m9o+PHcbkGx3vup4JMZmBHmLkMz
         OfnkYfcEQTAtXYuGpE6TDE/xCC/0Aabk7pfSApXMPXI9fZ7duM9/nLqfzCL2aEOhkfO5
         LCjl0iAUFp3WsCZcBQkajdNtsJoFnw+4AsPBldasKfUgaHRQGkmq/eKX1oQs53f5jcc/
         08JpXHkOih1FIbJ6n7X2kDXGi6G8kzNBggerq8VnKDCoazyA0tI7YdfvqAOHslvdGsD4
         6qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765978538; x=1766583338;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L3+abCe5E3Tvk7YKU0mcCWD1gF9CHnTNJLhm+1muw5I=;
        b=J6WKVIYzl1ciJX2YcSPFF3PBausrcv2b1Nj1BeRPjMFBUyeM/dQ5aq6iDQUaDP5MxX
         3+ONeGzsk4m21Y5afLGQ5RNuuCKmBu/sFdMlIOlNAkBr2bwWWdiyfG6Zn1yFvyTYmUkm
         L/5BJng9C2bOg3H1tbdghoTlK/s6rruWafeX8wKCSS628K4OHIzPpqGoQ4dgwnHaUAan
         qaYwP/k8Del8bpquPuSbH+cQG5JU5b+LubV65TnrwnJhZIKf9MCzc6RmBjqExjml8vHN
         zgvWsRuNxg84vmvPMRW0hIn878feQnsG/D+asyqAsmSWLGVbTfpl4iJboggP+7GL+ifs
         CjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB31q1sMW8cxeVZiqshPe/tqjltcKapfS66IrsdkKTXouASLuJw4ETkZAREdvgWyFEEbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9H5cvbiGX9xY26n9p4B6O+sqmX1FGzyolQ15QLd3VNCxkCHbm
	ALHu68yW40xNZweJOdUO3boYWkT9iWj2dW/4a06FN1eiQzFZvp4jVADHWkoHa9SGoaKGykB8a7g
	QLYZaDd+r3K9nxw==
X-Google-Smtp-Source: AGHT+IEH+CdZ04WhFeb5ACXOuocx1dvo+huQmXb+rWY+iQbXbRJaTnTHbLhzGq2SLmIXnR9UZvwmulhup/NTKw==
X-Received: from ejns16.prod.google.com ([2002:a17:906:99d0:b0:b80:1160:f8f0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e112:b0:b80:b7f:aa14 with SMTP id a640c23a62f3a-b800b7fc0f1mr189984166b.32.1765978538592;
 Wed, 17 Dec 2025 05:35:38 -0800 (PST)
Date: Wed, 17 Dec 2025 13:35:37 +0000
In-Reply-To: <d912480a-5229-4efe-9336-b31acded30f5@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com> <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com> <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
 <aUKnfU/3FREY13g1@e129823.arm.com> <d912480a-5229-4efe-9336-b31acded30f5@suse.cz>
X-Mailer: aerc 0.21.0
Message-ID: <DF0J58HOVLL4.2E16Q87D2UXRW@google.com>
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
From: Brendan Jackman <jackmanb@google.com>
To: Vlastimil Babka <vbabka@suse.cz>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <jackmanb@google.com>, 
	<hannes@cmpxchg.org>, <ziy@nvidia.com>, <bigeasy@linutronix.de>, 
	<clrkwllms@kernel.org>, <rostedt@goodmis.org>, <catalin.marinas@arm.com>, 
	<will@kernel.org>, <kevin.brodsky@arm.com>, <dev.jain@arm.com>, 
	<yang@os.amperecomputing.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed Dec 17, 2025 at 1:15 PM UTC, Vlastimil Babka wrote:
> On 12/17/25 13:52, Yeoreum Yun wrote:
>>> On 17/12/2025 10:48, Yeoreum Yun wrote:
>>> > Hi Ryan,
>>> >
>>> >> On 16/12/2025 16:52, Yeoreum Yun wrote:
>>> >>> Hi Ryan,
>>> >>>
>>> >>>> On 12/12/2025 16:18, Yeoreum Yun wrote:
>>> >>>>> Some architectures invoke pagetable_alloc() or __get_free_pages()
>>> >>>>> with preemption disabled.
>>> >>>>> For example, in arm64, linear_map_split_to_ptes() calls pagetable=
_alloc()
>>> >>>>> while spliting block entry to ptes and __kpti_install_ng_mappings=
()
>>> >>>>> calls __get_free_pages() to create kpti pagetable.
>>> >>>>>
>>> >>>>> Under PREEMPT_RT, calling pagetable_alloc() with
>>> >>>>> preemption disabled is not allowed, because it may acquire
>>> >>>>> a spin lock that becomes sleepable on RT, potentially
>>> >>>>> causing a sleep during page allocation.
>>> >>>>>
>>> >>>>> Since above two functions is called as callback of stop_machine()
>>> >>>>> where its callback is called in preemption disabled,
>>> >>>>> They could make a potential problem. (sleeping in preemption disa=
bled).
>>> >>>>>
>>> >>>>> To address this, introduce pagetable_alloc_nolock() API.
>>> >>>>
>>> >>>> I don't really understand what the problem is that you're trying t=
o fix. As I
>>> >>>> see it, there are 2 call sites in arm64 arch code that are calling=
 into the page
>>> >>>> allocator from stop_machine() - one via via pagetable_alloc() and =
another via
>>> >>>> __get_free_pages(). But both of those calls are passing in GFP_ATO=
MIC. It was my
>>> >>>> understanding that the page allocator would ensure it never sleeps=
 when
>>> >>>> GFP_ATOMIC is passed in, (even for PREEMPT_RT)?
>>> >>>
>>> >>> Although GFP_ATOMIC is specify, it only affects of "water mark" of =
the
>>> >>> page with __GFP_HIGH. and to get a page, it must grab the lock --
>>> >>> zone->lock or pcp_lock in the rmqueue().
>>> >>>
>>> >>> This zone->lock and pcp_lock is spin_lock and it's a sleepable in
>>> >>> PREEMPT_RT that's why the memory allocation/free using general API
>>> >>> except nolock() version couldn't be called since
>>> >>> if "contention" happens they'll sleep while waiting to get the lock=
.
>>> >>>
>>> >>> The reason why "nolock()" can use, it always uses "trylock" with
>>> >>> ALLOC_TRYLOCK flags. otherwise GFP_ATOMIC also can be sleepable in
>>> >>> PREEMPT_RT.
>>> >>>
>>> >>>>
>>> >>>> What is the actual symptom you are seeing?
>>> >>>
>>> >>> Since the place where called while smp_cpus_done() and there seems =
no
>>> >>> contention, there seems no problem. However as I mention in another
>>> >>> thread
>>> >>> (https://lore.kernel.org/all/aT%2FdrjN1BkvyAGoi@e129823.arm.com/),
>>> >>> This gives a the false impression --
>>> >>> GFP_ATOMIC are =E2=80=9Csafe to use in preemption disabled=E2=80=9D
>>> >>> even though they are not in PREEMPT_RT case, I've changed it.
>>> >>>
>>> >>>>
>>> >>>> If the page allocator is somehow ignoring the GFP_ATOMIC request f=
or PREEMPT_RT,
>>> >>>> then isn't that a bug in the page allocator? I'm not sure why you =
would change
>>> >>>> the callsites? Can't you just change the page allocator based on G=
FP_ATOMIC?
>>> >>>
>>> >>> It doesn't ignore the GFP_ATOMIC feature:
>>> >>>   - __GFP_HIGH: use water mark till min reserved
>>> >>>   - __GFP_KSWAPD_RECLAIM: wake up kswapd if reclaim required.
>>> >>>
>>> >>> But, it's a restriction -- "page allocation / free" API cannot be c=
alled
>>> >>> in preempt-disabled context at PREEMPT_RT.
>>> >>>
>>> >>> That's why I think it's wrong usage not a page allocator bug.
>>> >>
>>> >> I've taken a look at this and I agree with your analysis. Thanks for=
 explaining.
>>> >>
>>> >> Looking at other stop_machine() callbacks, there are some that call =
printk() and
>>> >> I would assume that spinlocks could be taken there which may present=
 the same
>>> >> kind of issue or PREEMPT_RT? (I'm guessing). I don't see any others =
that attempt
>>> >> to allocate memory though.
>>> >
>>> > IIRC, there was a problem related for printk while try to grab
>>> > pl011_console related lock (spin_lock) while holding
>>> > console_lock(raw_spin_lock) in v6.10.0-rc7 at rpi5:
>>> >
>>> >     [  230.381263] CPU: 2 PID: 5574 Comm: syz.4.1695 Not tainted 6.10=
.0-rc7-01903-g52828ea60dfd #3
>>> >     [  230.381479] Hardware name: linux,dummy-virt (DT)
>>> >     [  230.381565] Call trace:
>>> >     [  230.381607]  dump_backtrace+0x318/0x348
>>> >     [  230.381727]  show_stack+0x4c/0x80
>>> >     [  230.381875]  dump_stack_lvl+0x214/0x328
>>> >     [  230.382159]  dump_stack+0x3c/0x58
>>> >     [  230.382456]  __lock_acquire+0x4398/0x4720
>>> >     [  230.382683]  lock_acquire+0x648/0xb70
>>> >     [  230.382928]  _raw_spin_lock_irqsave+0x138/0x240
>>> >     [  230.383121]  pl011_console_write+0x240/0x8a0
>>> >     [  230.383356]  console_flush_all+0x708/0x1368
>>> >     [  230.383571]  console_unlock+0x180/0x440
>>> >     [  230.383742]  vprintk_emit+0x1f8/0x9d0
>>> >     [  230.383832]  vprintk_default+0x64/0x90
>>> >     [  230.383914]  vprintk+0x2d0/0x400
>>> >     [  230.383971]  _printk+0xdc/0x128
>>> >     [  230.384229]  hrtimer_interrupt+0x8f0/0x920
>>> >     [  230.384414]  arch_timer_handler_virt+0xc0/0x100
>>> >     [  230.384812]  handle_percpu_devid_irq+0x20c/0x4e0
>>> >     [  230.385053]  generic_handle_domain_irq+0xc0/0x120
>>> >     [  230.385367]  gic_handle_irq+0x88/0x360
>>> >     [  230.385559]  call_on_irq_stack+0x24/0x70
>>> >     [  230.385801]  do_interrupt_handler+0xf8/0x200
>>> >     [  230.386092]  el1_interrupt+0x68/0xc0
>>> >     [  230.386434]  el1h_64_irq_handler+0x18/0x28
>>> >     [  230.386716]  el1h_64_irq+0x64/0x68
>>> >     [  230.386853]  __sanitizer_cov_trace_const_cmp2+0x30/0x68
>>> >     [  230.387026]  alloc_pages_mpol_noprof+0x170/0x698
>>> >     [  230.387309]  vma_alloc_folio_noprof+0x128/0x2a8
>>> >     [  230.387610]  vma_alloc_zeroed_movable_folio+0xa0/0xe0
>>> >     [  230.387822]  folio_prealloc+0x5c/0x280
>>> >     [  230.388008]  do_wp_page+0xc30/0x3bc0
>>> >     [  230.388206]  __handle_mm_fault+0xdb8/0x2ba0
>>> >     [  230.388448]  handle_mm_fault+0x194/0x8a8
>>> >     [  230.388676]  do_page_fault+0x6bc/0x1030
>>> >     [  230.388924]  do_mem_abort+0x8c/0x240
>>> >     [  230.389056]  el0_da+0xf0/0x3f8
>>> >     [  230.389178]  el0t_64_sync_handler+0xb4/0x130
>>> >     [  230.389452]  el0t_64_sync+0x190/0x198
>>> >
>>> > But this problem is gone when I try with some of patches in rt-tree
>>> > related for printk which are merged in current tree
>>> > (https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.gi=
t/log/?h=3Dlinux-6.10.y-rt-rebase).
>>> >
>>> > So I think printk() wouldn't be a problem.
>>> >
>>> >>
>>> >> Anyway, to fix the 2 arm64 callsites, I see 2 possible approaches:
>>> >>
>>> >> - Call the nolock variant (as you are doing). But that would just co=
nvert a
>>> >> deadlock to a panic; if the lock is held when stop_machine() runs, w=
ithout your
>>> >> change, we now have a deadlock due to waiting on the lock inside sto=
p_machine().
>>> >> With your change, we notice the lock is already taken and panic. I g=
uess it is
>>> >> marginally better, but not by much. Certainly I would just _always_ =
call the
>>> >> nolock variant regardless of PREEMPT_RT if we take this route; For !=
PREEMPT_RT,
>>> >> the lock is guarranteed to be free so nolock will always succeed.
>>> >>
>>> >> - Preallocate the memory before entering stop_machine(). I think thi=
s would be
>>> >> much more robust. For kpti_install_ng_mappings() I think you could h=
oist the
>>> >> allocation/free out of stop_machine() and pass the pointer in pretty=
 easily. For
>>> >> linear_map_split_to_ptes() its a bit more complex; Perhaps, we need =
to walk the
>>> >> pgtable to figure out how much to preallocate, allocate it, then set=
 it up as a
>>> >> special allocator, wrapped by an allocation function and modify the =
callchain to
>>> >> take a callback function instead of gfp flags.
>>> >>
>>> >> What do you think?
>>> >
>>> > Definitely, second suggestoin is much better.
>>> > My question is whether *memory contention* really happen in the point
>>> > both functions are called.
>>>
>>> My guess would be that it's unlikely, but not impossible. The secondary=
 CPUs are
>>> up, and presumably running their idle thread. I think various power man=
agement
>>> things can be plugged into the idle thread; if so, then I guess it's po=
ssible
>>> that the CPU could be running some hook as part of a power state transi=
tion, and
>>> that could be dynamically allocating memory? That's all just a guess th=
ough; I
>>> don't know the details of that part of the system.
>>>
>>> >
>>> > Above two functions are called as last step of "smp_init()" -- smp_cp=
us_done().
>>> > If we can be sure, I think we don't need to go to complex way and
>>> > I believe the reason why we couldn't find out this problem,
>>> > even using GFP_ATOMIC in PREEMPT_RT since there was *no contection*
>>> > in this time of both functions are called.
>>> > > That's why I first try with the "simple way".
>>> >
>>> > What do you think?
>>>
>>> As far as linear_map_split_to_ptes() is concerned, it was implemented u=
nder the
>>> impression that doing allocation with GFP_ATOMIC was safe, even in
>>> stop_machine(). Given that's an incorrect assumption, I think we should=
 fix it
>>> to pre-allocate outside of stop_machine() regardless of the likelihood =
of
>>> actually hitting the race.
>>>
>>=20
>> Yeap. It=E2=80=99s better to be certain than uncertain. Thanks for check=
ing.
>> I'll repsin with the preallocate way.
>
> Note this is explained in Documentation/core-api/real-time/differences.rs=
t:
>
> Memory allocation
> -----------------
>
> The memory allocation APIs, such as kmalloc() and alloc_pages(), require =
a
> gfp_t flag to indicate the allocation context. On non-PREEMPT_RT kernels,=
 it is
> necessary to use GFP_ATOMIC when allocating memory from interrupt context=
 or
> from sections where preemption is disabled. This is because the allocator=
 must
> not sleep in these contexts waiting for memory to become available.
>
> However, this approach does not work on PREEMPT_RT kernels. The memory
> allocator in PREEMPT_RT uses sleeping locks internally, which cannot be
> acquired when preemption is disabled. Fortunately, this is generally not =
a
> problem, because PREEMPT_RT moves most contexts that would traditionally =
run
> with preemption or interrupts disabled into threaded context, where sleep=
ing is
> allowed.
>
> What remains problematic is code that explicitly disables preemption or
> interrupts. In such cases, memory allocation must be performed outside th=
e
> critical section.
>
> This restriction also applies to memory deallocation routines such as kfr=
ee()
> and free_pages(), which may also involve internal locking and must not be
> called from non-preemptible contexts.

Oh, thanks for pointing to that, I had never read that before (oops).

Shall we point to this from the doc-comment? Something like the below.

BTW, Yeorum, assuming you care about PREEMPT_RT, maybe you can get
Sparse to find some other bugs of this nature? Or if not, plain old
Coccinelle would probably find a few.

---

From 4c6b4d4cb08aee9559d02a348b9ecf799142c96f Mon Sep 17 00:00:00 2001
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 17 Dec 2025 13:26:28 +0000
Subject: [PATCH] mm: clarify GFP_ATOMIC/GFP_NOWAIT doc-comment

The current description of contexts where it's invalid to make
GFP_ATOMIC and GFP_NOWAIT calls is rather vague.

Replace this with a direct description of the actual contexts of concern
and refer to the RT docs where this is explained more discursively.

While rejigging this prose, also move the documentation of GFP_NOWAIT to
the GFP_NOWAIT section.

Link: https://lore.kernel.org/all/d912480a-5229-4efe-9336-b31acded30f5@suse=
.cz/
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp_types.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 3de43b12209ee..07a378542caf2 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -309,8 +309,10 @@ enum {
  *
  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A l=
ower
  * watermark is applied to allow access to "atomic reserves".
- * The current implementation doesn't support NMI and few other strict
- * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_=
NOWAIT.
+ * The current implementation doesn't support NMI, nor contexts that disab=
le
+ * preemption under PREEMPT_RT. This includes raw_spin_lock() and plain
+ * preempt_disable() - see Documentation/core-api/real-time/differences.rs=
t for
+ * more info.
  *
  * %GFP_KERNEL is typical for kernel-internal allocations. The caller requ=
ires
  * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
@@ -321,6 +323,7 @@ enum {
  * %GFP_NOWAIT is for kernel allocations that should not stall for direct
  * reclaim, start physical IO or use any filesystem callback.  It is very
  * likely to fail to allocate memory, even for very small allocations.
+ * The same restrictions on calling contexts apply as for %GFP_ATOMIC.
  *
  * %GFP_NOIO will use direct reclaim to discard clean pages or slab pages
  * that do not require the starting of any physical IO.
--
2.50.1

