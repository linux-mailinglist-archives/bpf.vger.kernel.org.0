Return-Path: <bpf+bounces-78557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A34D13557
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C724030081AF
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D182DC34B;
	Mon, 12 Jan 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6b9wMXy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1E2D9481
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229700; cv=none; b=t1uNhbrQZBdW8RB1o0F3Nn0z6/lOaoxKNHtyahb9NPDpivaAzEz0CYQG8aCbFiDohLXwFla4Z3grhrreMbaQDhrXZQc14ylCNMO/hjfAxpxwn2/vSj8dhPb6iYSQ5g0eAM8MkeOGBGHdKOAHfUB5VGw/+3yeuhtgMEdO3gQabMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229700; c=relaxed/simple;
	bh=TXNwA3965GzlDRqMhL9CM9SyM4AjcV2DpVDWeku3wwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxU6RfOkdFlCQmVAjEqw8yStrALzvHCKUWSt2mL8usuPOWboNCUqdnfP+1V8x1t+KpbCWuLgixhBu0laqaT/TYO29y/p2LUbtcnZfQHZQIIUMrpcOc4jBD0adXmZPGoAR80dtbh1KaJh7uqJD04tVlb2+kkzKpQD46XokNsb72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6b9wMXy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so9689228a12.0
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768229695; x=1768834495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYe3l0oBhmHzifRrnp39fnXIOs5adBqTqrq6bxByLWQ=;
        b=d6b9wMXykBm6DhWMzH095jkkhjlR35bpyGdH/VZM7fW83SavDr4Y+RTgP/wE8ETTri
         vbUa3QdIIUAM0jX+ba4QI2kwOqDk/wodERB5LAne7C+XJ0WoN8gaJJgn7zhMB6Ycsdui
         M0Yu2YlpX0Z3KjfeY+80C3Y89IjGwEpRCoPDWViK6DdMT0KgKNiKo5KZpxt3EaWKc7uO
         N+V5jv0OCm9QOkzKLK4VjraCgtl2J5JFtaaFKPLNjVMitbEQuW+YPMZ8kEAwTIKcQ/2A
         3xdtpw/Grap7TKDEdmWnOZ6Y+/DaN6ko2wfIkadQD4n/oFzt7gl1mHjiv8WNN/WQZymL
         9H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229695; x=1768834495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYe3l0oBhmHzifRrnp39fnXIOs5adBqTqrq6bxByLWQ=;
        b=cX060gjMKzGwhgo7EDgf+/phM9xXxwCqYWXl4ninbX492QXypd4vVa8Ug1dPqVyKGF
         GyhSMBePx35xCx8fdaMdVsBJ8NMEJl42mptbepYlbAfxs23d168clZD7uLfg2TqdsrRV
         rSX98WScxwJFKV2YqNkcgPlhq1Jd1ww2eXSu9M2Z4yvO1zfSmkiPhOOEYbwkfPh6o2Pi
         5my0yDFJlzXWwSlZsX5TomVHe2mTr+ixLYmYGNCCSuvOt/Rz6PT7uZOUqTcz+lzTEUpt
         F/DDuPzwtWEm7hw/n7iSnZqIgB/kzQV6BLlSf8qV+xrMywBG5IOr0eWzRXDDDJBCENzO
         qoLw==
X-Forwarded-Encrypted: i=1; AJvYcCWtZgSytFzNRo0fSbWwenLE0l6mngF/XrCS2d1Iyg4VrJFciaP0MWHUOVFhpP7Lz1G/ldI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2lebF95qPZKF/q949Vg9yN40jS/DcS3bNIFfxbmMM9d93wtK
	7V3A7XYxguC9MP0zZYsIDyIOMMpqbh579LkdHXj7qnTOjQZYNoFF93bL291L7+xBLg==
X-Gm-Gg: AY/fxX668UPCu4GITIO7BZN05qbGBlR2n7iaJzN+8wjxx5KpqHZIHDdyT48J50KzR6i
	EIHZ3Aiu98azhbOdHc9vH0McBaMrBq6S7EhUtwhwOT84IuWVRXFPO9+Kn6hGq1WOQxG1rDyTF/U
	nmQ0G1wZT1Dh1UXMG4pgX8Pl1oCaavpdrERKFm5EwTMjhsUNt9Y9mXPwr5LVlqWoqH77iUPwbuH
	ZaJhL/nbt8NNJ+3M21vYXG96t959N13/kD4r9Vrk5eCHURG4OsrbeJ5RxTC1I7DvSy4fVA2+VFl
	1FH5ZPMUgAJWREFdVZeseVd7aGmTwU8Amwg+4V3/A/onnZ5xUDOqIG3CUjfnExuYqITL6sLPdnk
	wcap42dzvFCvX5N1rM39o9lkRuYbsEJzRUDNvy7or/8aC9FagBHHnUnWbVB5h2fRYyRShbWbZa2
	q7HStrqH7OfdIT4bMNptt0BjY1ZoGAJiPH4NJCwCP92wKGYiamsI6+7w==
X-Google-Smtp-Source: AGHT+IFyq/l4Y91s3As0xM4b0On+utGWXrHomO/NLjTjpU6N78n4mNIPQUlji/xKCtXhg3z6I1P7oA==
X-Received: by 2002:a17:907:6d25:b0:b87:1839:2601 with SMTP id a640c23a62f3a-b87183929d6mr419319566b.40.1768229694667;
        Mon, 12 Jan 2026 06:54:54 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf661f3sm19687163a12.26.2026.01.12.06.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:54:54 -0800 (PST)
Date: Mon, 12 Jan 2026 14:54:50 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
Message-ID: <aWULOvXrN0acG97Y@google.com>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>

On Mon, Oct 27, 2025 at 04:17:09PM -0700, Roman Gushchin wrote:
> Introduce a bpf struct ops for implementing custom OOM handling
> policies.
> 
> It's possible to load one bpf_oom_ops for the system and one
> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
> cgroup tree is traversed from the OOM'ing memcg up to the root and
> corresponding BPF OOM handlers are executed until some memory is
> freed. If no memory is freed, the kernel OOM killer is invoked.
> 
> The struct ops provides the bpf_handle_out_of_memory() callback,
> which expected to return 1 if it was able to free some memory and 0
> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
> field of the oom_control structure, which is expected to be set by
> kfuncs suitable for releasing memory. If both are set, OOM is
> considered handled, otherwise the next OOM handler in the chain
> (e.g. BPF OOM attached to the parent cgroup or the in-kernel OOM
> killer) is executed.
> 
> The bpf_handle_out_of_memory() callback program is sleepable to enable
> using iterators, e.g. cgroup iterators. The callback receives struct
> oom_control as an argument, so it can determine the scope of the OOM
> event: if this is a memcg-wide or system-wide OOM.
> 
> The callback is executed just before the kernel victim task selection
> algorithm, so all heuristics and sysctls like panic on oom,
> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> are respected.
> 
> BPF OOM struct ops provides the handle_cgroup_offline() callback
> which is good for releasing struct ops if the corresponding cgroup
> is gone.
> 
> The struct ops also has the name field, which allows to define a
> custom name for the implemented policy. It's printed in the OOM report
> in the oom_policy=<policy> format. "default" is printed if bpf is not
> used or policy name is not specified.
> 
> [  112.696676] test_progs invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
>                oom_policy=bpf_test_policy
> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> [  112.698167] Call Trace:
> [  112.698177]  <TASK>
> [  112.698182]  dump_stack_lvl+0x4d/0x70
> [  112.698192]  dump_header+0x59/0x1c6
> [  112.698199]  oom_kill_process.cold+0x8/0xef
> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> [  112.698250]  out_of_memory+0xab/0x5c0
> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> [  112.698288]  charge_memcg+0x2f/0xc0
> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> [  112.698299]  do_anonymous_page+0x40f/0xa50
> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698335]  handle_mm_fault+0xe6/0x370
> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> [  112.698354]  exc_page_fault+0x75/0x1d0
> [  112.698363]  asm_exc_page_fault+0x26/0x30
> [  112.698366] RIP: 0033:0x7fa97236db00
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/bpf_oom.h    |  74 ++++++++++
>  include/linux/memcontrol.h |   5 +
>  include/linux/oom.h        |   8 ++
>  mm/Makefile                |   3 +
>  mm/bpf_oom.c               | 272 +++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c            |   2 +
>  mm/oom_kill.c              |  22 ++-
>  7 files changed, 384 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/bpf_oom.h
>  create mode 100644 mm/bpf_oom.c
> 
> diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
> new file mode 100644
> index 000000000000..18c32a5a068b
> --- /dev/null
> +++ b/include/linux/bpf_oom.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __BPF_OOM_H
> +#define __BPF_OOM_H
> +
> +struct oom_control;
> +
> +#define BPF_OOM_NAME_MAX_LEN 64
> +
> +struct bpf_oom_ctx {
> +	/*
> +	 * If bpf_oom_ops is attached to a cgroup, id of this cgroup.
> +	 * 0 otherwise.
> +	 */
> +	u64 cgroup_id;
> +};
> +
> +struct bpf_oom_ops {
> +	/**
> +	 * @handle_out_of_memory: Out of memory bpf handler, called before
> +	 * the in-kernel OOM killer.
> +	 * @ctx: Execution context
> +	 * @oc: OOM control structure
> +	 *
> +	 * Should return 1 if some memory was freed up, otherwise
> +	 * the in-kernel OOM killer is invoked.
> +	 */
> +	int (*handle_out_of_memory)(struct bpf_oom_ctx *ctx, struct oom_control *oc);
> +
> +	/**
> +	 * @handle_cgroup_offline: Cgroup offline callback
> +	 * @ctx: Execution context
> +	 * @cgroup_id: Id of deleted cgroup
> +	 *
> +	 * Called if the cgroup with the attached bpf_oom_ops is deleted.
> +	 */
> +	void (*handle_cgroup_offline)(struct bpf_oom_ctx *ctx, u64 cgroup_id);
> +
> +	/**
> +	 * @name: BPF OOM policy name
> +	 */
> +	char name[BPF_OOM_NAME_MAX_LEN];
> +};
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +/**
> + * @bpf_handle_oom: handle out of memory condition using bpf
> + * @oc: OOM control structure
> + *
> + * Returns true if some memory was freed.
> + */
> +bool bpf_handle_oom(struct oom_control *oc);
> +
> +
> +/**
> + * @bpf_oom_memcg_offline: handle memcg offlining
> + * @memcg: Memory cgroup is offlined
> + *
> + * When a memory cgroup is about to be deleted and there is an
> + * attached BPF OOM structure, it has to be detached.
> + */
> +void bpf_oom_memcg_offline(struct mem_cgroup *memcg);
> +
> +#else /* CONFIG_BPF_SYSCALL */
> +static inline bool bpf_handle_oom(struct oom_control *oc)
> +{
> +	return false;
> +}
> +
> +static inline void bpf_oom_memcg_offline(struct mem_cgroup *memcg) {}
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
> +#endif /* __BPF_OOM_H */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 50d851ff3f27..39a6c7c8735b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -29,6 +29,7 @@ struct obj_cgroup;
>  struct page;
>  struct mm_struct;
>  struct kmem_cache;
> +struct bpf_oom_ops;
>  
>  /* Cgroup-specific page state, on top of universal node page state */
>  enum memcg_stat_item {
> @@ -226,6 +227,10 @@ struct mem_cgroup {
>  	 */
>  	bool oom_group;
>  
> +#ifdef CONFIG_BPF_SYSCALL
> +	struct bpf_oom_ops *bpf_oom;
> +#endif
> +
>  	int swappiness;
>  
>  	/* memory.events and memory.events.local */
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 7b02bc1d0a7e..721087952d04 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -51,6 +51,14 @@ struct oom_control {
>  
>  	/* Used to print the constraint info. */
>  	enum oom_constraint constraint;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +	/* Used by the bpf oom implementation to mark the forward progress */
> +	bool bpf_memory_freed;
> +
> +	/* Policy name */
> +	const char *bpf_policy_name;
> +#endif
>  };
>  
>  extern struct mutex oom_lock;
> diff --git a/mm/Makefile b/mm/Makefile
> index 21abb3353550..051e88c699af 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -105,6 +105,9 @@ obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
>  ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) += swap_cgroup.o
>  endif
> +ifdef CONFIG_BPF_SYSCALL
> +obj-y += bpf_oom.o
> +endif
>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) += gup_test.o
>  obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
> diff --git a/mm/bpf_oom.c b/mm/bpf_oom.c
> new file mode 100644
> index 000000000000..c4d09ed9d541
> --- /dev/null
> +++ b/mm/bpf_oom.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * BPF-driven OOM killer customization
> + *
> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/oom.h>
> +#include <linux/bpf_oom.h>
> +#include <linux/srcu.h>
> +#include <linux/cgroup.h>
> +#include <linux/memcontrol.h>
> +
> +DEFINE_STATIC_SRCU(bpf_oom_srcu);
> +static struct bpf_oom_ops *system_bpf_oom;
> +
> +#ifdef CONFIG_MEMCG
> +static u64 memcg_cgroup_id(struct mem_cgroup *memcg)
> +{
> +	return cgroup_id(memcg->css.cgroup);
> +}
> +
> +static struct bpf_oom_ops **bpf_oom_memcg_ops_ptr(struct mem_cgroup *memcg)
> +{
> +	return &memcg->bpf_oom;
> +}
> +#else /* CONFIG_MEMCG */
> +static u64 memcg_cgroup_id(struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +static struct bpf_oom_ops **bpf_oom_memcg_ops_ptr(struct mem_cgroup *memcg)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +static int bpf_ops_handle_oom(struct bpf_oom_ops *bpf_oom_ops,
> +			      struct mem_cgroup *memcg,
> +			      struct oom_control *oc)
> +{
> +	struct bpf_oom_ctx exec_ctx;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_MEMCG) && memcg)
> +		exec_ctx.cgroup_id = memcg_cgroup_id(memcg);
> +	else
> +		exec_ctx.cgroup_id = 0;
> +
> +	oc->bpf_policy_name = &bpf_oom_ops->name[0];
> +	oc->bpf_memory_freed = false;
> +	ret = bpf_oom_ops->handle_out_of_memory(&exec_ctx, oc);
> +	oc->bpf_policy_name = NULL;
> +
> +	return ret;
> +}
> +
> +bool bpf_handle_oom(struct oom_control *oc)
> +{
> +	struct bpf_oom_ops *bpf_oom_ops = NULL;
> +	struct mem_cgroup __maybe_unused *memcg;
> +	int idx, ret = 0;
> +
> +	/* All bpf_oom_ops structures are protected using bpf_oom_srcu */
> +	idx = srcu_read_lock(&bpf_oom_srcu);
> +
> +#ifdef CONFIG_MEMCG
> +	/* Find the nearest bpf_oom_ops traversing the cgroup tree upwards */
> +	for (memcg = oc->memcg; memcg; memcg = parent_mem_cgroup(memcg)) {
> +		bpf_oom_ops = READ_ONCE(memcg->bpf_oom);
> +		if (!bpf_oom_ops)
> +			continue;
> +
> +		/* Call BPF OOM handler */
> +		ret = bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> +		if (ret && oc->bpf_memory_freed)
> +			goto exit;

I have a question about the semantics of oc->bpf_memory_freed.

Currently, it seems this flag is used to indicate that a BPF OOM
program has made forward progress by freeing some memory (i.e.,
bpf_oom_kill_process()), but if it's not set, it falls back to the
default in-kernel OOM killer.

However, what if forward progress in some contexts means not freeing
memory? For example, in some bespoke container environments, the
policy might be to catch the OOM event and handle it gracefully by
raising the memory.limit_in_bytes on the affected memcg. In this kind
of resizing scenario, no memory would be freed, but the OOM event
would effectively be resolved.

> +	}
> +#endif /* CONFIG_MEMCG */
> +
> +	/*
> +	 * System-wide OOM or per-memcg BPF OOM handler wasn't successful?
> +	 * Try system_bpf_oom.
> +	 */
> +	bpf_oom_ops = READ_ONCE(system_bpf_oom);
> +	if (!bpf_oom_ops)
> +		goto exit;
> +
> +	/* Call BPF OOM handler */
> +	ret = bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
> +exit:
> +	srcu_read_unlock(&bpf_oom_srcu, idx);
> +	return ret && oc->bpf_memory_freed;
> +}
> +
> +static int __handle_out_of_memory(struct bpf_oom_ctx *exec_ctx,
> +				  struct oom_control *oc)
> +{
> +	return 0;
> +}
> +
> +static void __handle_cgroup_offline(struct bpf_oom_ctx *exec_ctx, u64 cgroup_id)
> +{
> +}
> +
> +static struct bpf_oom_ops __bpf_oom_ops = {
> +	.handle_out_of_memory = __handle_out_of_memory,
> +	.handle_cgroup_offline = __handle_cgroup_offline,
> +};
> +
> +static const struct bpf_func_proto *
> +bpf_oom_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	return tracing_prog_func_proto(func_id, prog);
> +}
> +
> +static bool bpf_oom_ops_is_valid_access(int off, int size,
> +					enum bpf_access_type type,
> +					const struct bpf_prog *prog,
> +					struct bpf_insn_access_aux *info)
> +{
> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_verifier_ops bpf_oom_verifier_ops = {
> +	.get_func_proto = bpf_oom_func_proto,
> +	.is_valid_access = bpf_oom_ops_is_valid_access,
> +};
> +
> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *ops_link = container_of(link, struct bpf_struct_ops_link, link);
> +	struct bpf_oom_ops **bpf_oom_ops_ptr = NULL;
> +	struct bpf_oom_ops *bpf_oom_ops = kdata;
> +	struct mem_cgroup *memcg = NULL;
> +	int err = 0;
> +
> +	if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> +		/* Attach to a memory cgroup? */
> +		memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +		if (IS_ERR_OR_NULL(memcg))
> +			return PTR_ERR(memcg);
> +		bpf_oom_ops_ptr = bpf_oom_memcg_ops_ptr(memcg);
> +	} else {
> +		/* System-wide OOM handler */
> +		bpf_oom_ops_ptr = &system_bpf_oom;
> +	}
> +
> +	/* Another struct ops attached? */
> +	if (READ_ONCE(*bpf_oom_ops_ptr)) {
> +		err = -EBUSY;
> +		goto exit;
> +	}
> +
> +	/* Expose bpf_oom_ops structure */
> +	WRITE_ONCE(*bpf_oom_ops_ptr, bpf_oom_ops);
> +exit:
> +	mem_cgroup_put(memcg);
> +	return err;
> +}
> +
> +static void bpf_oom_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *ops_link = container_of(link, struct bpf_struct_ops_link, link);
> +	struct bpf_oom_ops **bpf_oom_ops_ptr = NULL;
> +	struct bpf_oom_ops *bpf_oom_ops = kdata;
> +	struct mem_cgroup *memcg = NULL;
> +
> +	if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> +		/* Detach from a memory cgroup? */
> +		memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +		if (IS_ERR_OR_NULL(memcg))
> +			goto exit;
> +		bpf_oom_ops_ptr = bpf_oom_memcg_ops_ptr(memcg);
> +	} else {
> +		/* System-wide OOM handler */
> +		bpf_oom_ops_ptr = &system_bpf_oom;
> +	}
> +
> +	/* Hide bpf_oom_ops from new callers */
> +	if (!WARN_ON(READ_ONCE(*bpf_oom_ops_ptr) != bpf_oom_ops))
> +		WRITE_ONCE(*bpf_oom_ops_ptr, NULL);
> +
> +	mem_cgroup_put(memcg);
> +
> +exit:
> +	/* Release bpf_oom_ops after a srcu grace period */
> +	synchronize_srcu(&bpf_oom_srcu);
> +}
> +
> +#ifdef CONFIG_MEMCG
> +void bpf_oom_memcg_offline(struct mem_cgroup *memcg)
> +{
> +	struct bpf_oom_ops *bpf_oom_ops;
> +	struct bpf_oom_ctx exec_ctx;
> +	u64 cgrp_id;
> +	int idx;
> +
> +	/* All bpf_oom_ops structures are protected using bpf_oom_srcu */
> +	idx = srcu_read_lock(&bpf_oom_srcu);
> +
> +	bpf_oom_ops = READ_ONCE(memcg->bpf_oom);
> +	WRITE_ONCE(memcg->bpf_oom, NULL);
> +
> +	if (bpf_oom_ops && bpf_oom_ops->handle_cgroup_offline) {
> +		cgrp_id = cgroup_id(memcg->css.cgroup);
> +		exec_ctx.cgroup_id = cgrp_id;
> +		bpf_oom_ops->handle_cgroup_offline(&exec_ctx, cgrp_id);
> +	}
> +
> +	srcu_read_unlock(&bpf_oom_srcu, idx);
> +}
> +#endif /* CONFIG_MEMCG */
> +
> +static int bpf_oom_ops_check_member(const struct btf_type *t,
> +				    const struct btf_member *member,
> +				    const struct bpf_prog *prog)
> +{
> +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> +
> +	switch (moff) {
> +	case offsetof(struct bpf_oom_ops, handle_out_of_memory):
> +		if (!prog)
> +			return -EINVAL;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bpf_oom_ops_init_member(const struct btf_type *t,
> +				   const struct btf_member *member,
> +				   void *kdata, const void *udata)
> +{
> +	const struct bpf_oom_ops *uops = udata;
> +	struct bpf_oom_ops *ops = kdata;
> +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> +
> +	switch (moff) {
> +	case offsetof(struct bpf_oom_ops, name):
> +		if (uops->name[0])
> +			strscpy_pad(ops->name, uops->name, sizeof(ops->name));
> +		else
> +			strscpy_pad(ops->name, "bpf_defined_policy");
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static int bpf_oom_ops_init(struct btf *btf)
> +{
> +	return 0;
> +}
> +
> +static struct bpf_struct_ops bpf_oom_bpf_ops = {
> +	.verifier_ops = &bpf_oom_verifier_ops,
> +	.reg = bpf_oom_ops_reg,
> +	.unreg = bpf_oom_ops_unreg,
> +	.check_member = bpf_oom_ops_check_member,
> +	.init_member = bpf_oom_ops_init_member,
> +	.init = bpf_oom_ops_init,
> +	.name = "bpf_oom_ops",
> +	.owner = THIS_MODULE,
> +	.cfi_stubs = &__bpf_oom_ops
> +};
> +
> +static int __init bpf_oom_struct_ops_init(void)
> +{
> +	return register_bpf_struct_ops(&bpf_oom_bpf_ops, bpf_oom_ops);
> +}
> +late_initcall(bpf_oom_struct_ops_init);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5d27cd5372aa..d44c1f293e16 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -63,6 +63,7 @@
>  #include <linux/seq_buf.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/kmemleak.h>
> +#include <linux/bpf_oom.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -3885,6 +3886,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  
>  	zswap_memcg_offline_cleanup(memcg);
>  
> +	bpf_oom_memcg_offline(memcg);
>  	memcg_offline_kmem(memcg);
>  	reparent_shrinker_deferred(memcg);
>  	wb_memcg_offline(memcg);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c145b0feecc1..d05ec0f84087 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -45,6 +45,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/cred.h>
>  #include <linux/nmi.h>
> +#include <linux/bpf_oom.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -246,6 +247,15 @@ static const char * const oom_constraint_text[] = {
>  	[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
>  };
>  
> +static const char *oom_policy_name(struct oom_control *oc)
> +{
> +#ifdef CONFIG_BPF_SYSCALL
> +	if (oc->bpf_policy_name)
> +		return oc->bpf_policy_name;
> +#endif
> +	return "default";
> +}
> +
>  /*
>   * Determine the type of allocation constraint.
>   */
> @@ -458,9 +468,10 @@ static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
>  
>  static void dump_header(struct oom_control *oc)
>  {
> -	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
> +	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\noom_policy=%s\n",
>  		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
> -			current->signal->oom_score_adj);
> +		current->signal->oom_score_adj,
> +		oom_policy_name(oc));
>  	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
>  		pr_warn("COMPACTION is disabled!!!\n");
>  
> @@ -1167,6 +1178,13 @@ bool out_of_memory(struct oom_control *oc)
>  		return true;
>  	}
>  
> +	/*
> +	 * Let bpf handle the OOM first. If it was able to free up some memory,
> +	 * bail out. Otherwise fall back to the kernel OOM killer.
> +	 */
> +	if (bpf_handle_oom(oc))
> +		return true;
> +
>  	select_bad_process(oc);
>  	/* Found nothing?!?! */
>  	if (!oc->chosen) {
> -- 
> 2.51.0
> 

