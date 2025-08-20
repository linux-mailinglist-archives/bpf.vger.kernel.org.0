Return-Path: <bpf+bounces-66120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE63B2E838
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A411AA0734C
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097932C21E7;
	Wed, 20 Aug 2025 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UZM2lI3i"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CC2773F6
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755729846; cv=none; b=qQ+X3P+YEUOsKqdeopqeEKVsBH9n7OChy6OndOcaP3BMOBZqsw/9apA0xeHmOdXWQSUX/YgeFn98YADsvXtU5xiW5+EB32RoozFGsEi1ikiNDfksW0N6JZ3jZQTkJoiCF6x+AwnMaRrol6HpQFAZOEkjfq+2DL2TRUUI2hG58I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755729846; c=relaxed/simple;
	bh=W9bu/CNCb4kof607lr+BIx990sVUjgia0BWsqRfCEL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qMH7LwgHSCk0zumNlznbC1WjaC6DT52x9afca1+tvI5wwfTpc359FLhJ0AJn5bLOk2uJh4IkaSRpB5JVPJvN/Iui8ADtA126+QQdabMkQvth39JDbrsI8B2xoxv1FpNA4oUJQDoev8mqg9L6FSeBEtkL2DbA0S4B0IinERim23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UZM2lI3i; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755729839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIBMbsV17r3lKNlQBpoJQUHEqmYE5Up+KV862pg9Yp4=;
	b=UZM2lI3i6LGEVcl88gfvKWNdhERvfxCPdeyXhhcpp6sf9wz0lyTEz9gchUtQJBcJHZUwHq
	b4dUlPv4LO2OSlHxptKoAQ0+m2qa6C4s1kbKKuqAy6vX+C48KlC5vBDZZ7spT/8Jloygxc
	IouxqrgwYt1sJWqrmzXRJUbgYy4+aYE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/14] mm: introduce bpf kfuncs to deal with memcg
 pointers
In-Reply-To: <CAP01T77yTb69hhi0CtDp9afVzO3T0fyPqhBF7By-iYYy__uOjA@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 20 Aug 2025 11:21:10
	+0200")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-5-roman.gushchin@linux.dev>
	<CAP01T77yTb69hhi0CtDp9afVzO3T0fyPqhBF7By-iYYy__uOjA@mail.gmail.com>
Date: Wed, 20 Aug 2025 15:43:50 -0700
Message-ID: <87y0rdobq1.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 18 Aug 2025 at 19:02, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>
>> To effectively operate with memory cgroups in bpf there is a need
>> to convert css pointers to memcg pointers. A simple container_of
>> cast which is used in the kernel code can't be used in bpf because
>> from the verifier's point of view that's a out-of-bounds memory access.
>>
>> Introduce helper get/put kfuncs which can be used to get
>> a refcounted memcg pointer from the css pointer:
>>   - bpf_get_mem_cgroup,
>>   - bpf_put_mem_cgroup.
>>
>> bpf_get_mem_cgroup() can take both memcg's css and the corresponding
>> cgroup's "self" css. It allows it to be used with the existing cgroup
>> iterator which iterates over cgroup tree, not memcg tree.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  include/linux/memcontrol.h |   2 +
>>  mm/Makefile                |   1 +
>>  mm/bpf_memcontrol.c        | 151 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 154 insertions(+)
>>  create mode 100644 mm/bpf_memcontrol.c
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 87b6688f124a..785a064000cd 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -932,6 +932,8 @@ static inline void mod_memcg_page_state(struct page *page,
>>         rcu_read_unlock();
>>  }
>>
>> +unsigned long memcg_events(struct mem_cgroup *memcg, int event);
>> +unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
>>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
>>  unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>> diff --git a/mm/Makefile b/mm/Makefile
>> index a714aba03759..c397af904a87 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -107,6 +107,7 @@ obj-$(CONFIG_MEMCG) += swap_cgroup.o
>>  endif
>>  ifdef CONFIG_BPF_SYSCALL
>>  obj-y += bpf_oom.o
>> +obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
>>  endif
>>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>>  obj-$(CONFIG_GUP_TEST) += gup_test.o
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> new file mode 100644
>> index 000000000000..66f2a359af7e
>> --- /dev/null
>> +++ b/mm/bpf_memcontrol.c
>> @@ -0,0 +1,151 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Memory Controller-related BPF kfuncs and auxiliary code
>> + *
>> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
>> + */
>> +
>> +#include <linux/memcontrol.h>
>> +#include <linux/bpf.h>
>> +
>> +__bpf_kfunc_start_defs();
>> +
>> +/**
>> + * bpf_get_mem_cgroup - Get a reference to a memory cgroup
>> + * @css: pointer to the css structure
>> + *
>> + * Returns a pointer to a mem_cgroup structure after bumping
>> + * the corresponding css's reference counter.
>> + *
>> + * It's fine to pass a css which belongs to any cgroup controller,
>> + * e.g. unified hierarchy's main css.
>> + *
>> + * Implements KF_ACQUIRE semantics.
>> + */
>> +__bpf_kfunc struct mem_cgroup *
>> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
>> +{
>> +       struct mem_cgroup *memcg = NULL;
>> +       bool rcu_unlock = false;
>> +
>> +       if (!root_mem_cgroup)
>> +               return NULL;
>> +
>> +       if (root_mem_cgroup->css.ss != css->ss) {
>> +               struct cgroup *cgroup = css->cgroup;
>> +               int ssid = root_mem_cgroup->css.ss->id;
>> +
>> +               rcu_read_lock();
>> +               rcu_unlock = true;
>> +               css = rcu_dereference_raw(cgroup->subsys[ssid]);
>> +       }
>> +
>> +       if (css && css_tryget(css))
>> +               memcg = container_of(css, struct mem_cgroup, css);
>> +
>> +       if (rcu_unlock)
>> +               rcu_read_unlock();
>> +
>> +       return memcg;
>> +}
>> +
>> +/**
>> + * bpf_put_mem_cgroup - Put a reference to a memory cgroup
>> + * @memcg: memory cgroup to release
>> + *
>> + * Releases a previously acquired memcg reference.
>> + * Implements KF_RELEASE semantics.
>> + */
>> +__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>> +{
>> +       css_put(&memcg->css);
>> +}
>> +
>> +/**
>> + * bpf_mem_cgroup_events - Read memory cgroup's event counter
>> + * @memcg: memory cgroup
>> + * @event: event idx
>> + *
>> + * Allows to read memory cgroup event counters.
>> + */
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_events(struct mem_cgroup *memcg, int event)
>> +{
>> +
>> +       if (event < 0 || event >= NR_VM_EVENT_ITEMS)
>> +               return (unsigned long)-1;
>> +
>> +       return memcg_events(memcg, event);
>> +}
>> +
>> +/**
>> + * bpf_mem_cgroup_usage - Read memory cgroup's usage
>> + * @memcg: memory cgroup
>> + *
>> + * Returns current memory cgroup size in bytes.
>> + */
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
>> +{
>> +       return page_counter_read(&memcg->memory);
>> +}
>> +
>> +/**
>> + * bpf_mem_cgroup_events - Read memory cgroup's page state counter
>> + * @memcg: memory cgroup
>> + * @event: event idx
>> + *
>> + * Allows to read memory cgroup statistics.
>> + */
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
>> +{
>> +       if (idx < 0 || idx >= MEMCG_NR_STAT)
>> +               return (unsigned long)-1;
>> +
>> +       return memcg_page_state(memcg, idx);
>> +}
>> +
>> +/**
>> + * bpf_mem_cgroup_flush_stats - Flush memory cgroup's statistics
>> + * @memcg: memory cgroup
>> + *
>> + * Propagate memory cgroup's statistics up the cgroup tree.
>> + *
>> + * Note, that this function uses the rate-limited version of
>> + * mem_cgroup_flush_stats() to avoid hurting the system-wide
>> + * performance. So bpf_mem_cgroup_flush_stats() guarantees only
>> + * that statistics is not stale beyond 2*FLUSH_TIME.
>> + */
>> +__bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>> +{
>> +       mem_cgroup_flush_stats_ratelimited(memcg);
>> +}
>> +
>> +__bpf_kfunc_end_defs();
>> +
>> +BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
>> +BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
>
> I think you could set KF_TRUSTED_ARGS for this as well.

Not really. The intended use case is to iterate over the cgroup tree,
which gives non-trusted css pointers:
	bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
		memcg = bpf_get_mem_cgroup(css_pos);
	}

Thanks

