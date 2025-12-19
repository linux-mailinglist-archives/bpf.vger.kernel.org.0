Return-Path: <bpf+bounces-77207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4FACD2241
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 23:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B7523063432
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 22:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D712D59FA;
	Fri, 19 Dec 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kryMfCV8"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11842287503
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184173; cv=none; b=BRV+NC1/rxYjEjc7AycqhXV8oKMv0oNr+AdBGDo2F8d+Jue7i+3uFlBdi2yvFEafM3QND+CZ3FhHlGs6pTv8BV97mtwrDkaXG48PauE3tksS9sjrLn0NMnytlK2PuMxVe5Ng8dB3WPO58vm58cEjOtWFKX5khZ3qVgG6qRQNLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184173; c=relaxed/simple;
	bh=QM3fPvs24xxUK46lUgLPZTIdIbBY3T5sZJ5/XNMBwUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uck9Jf3VgcgtmLxcONUsY1xCebu4Uy2teUtfPi/ctMS1/siPjI7nmjN7o0Ze9acjNNCydwDsv44A6ohinmvxRHVWGPQpPwaIRHbNw7ZLRSoT1ia5OBiYrM4rfb4lBcY3KtalLGaZkUbTT5Fo7mnEFOGnTXPXOWjqzuLVe3Kz9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kryMfCV8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766184167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yKgwo1ObVk1PtlBS0PDy4iJ86OgBR5tXdRHxkExP6E=;
	b=kryMfCV8sBFXLDY2tZpjHZ5qu1vI/gVuXJUBjnNSCrdRnE7BFWmA/8RA09W/orfjto4LX/
	h63wNLUV8XW7skMuBaqQpi8JYdA71n5gX3uMc9YI0BDiFM5SvOqubNegMWpviB2JVlOH0P
	7eHaitaKQmRxSh5LAftv34jiQIwjSBU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf@vger.kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  JP Kobryn <inwardvessel@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Michal Hocko
 <mhocko@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v1 2/6] mm: introduce BPF kfuncs to deal with
 memcg pointers
In-Reply-To: <nicnfk2rfemgjvrlp2wyztymyunfxgd4ixqfnkivzjckwn4x2v@fzxj6prn3c4b>
	(Shakeel Butt's message of "Fri, 19 Dec 2025 13:51:16 -0800")
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
	<20251219015750.23732-3-roman.gushchin@linux.dev>
	<nicnfk2rfemgjvrlp2wyztymyunfxgd4ixqfnkivzjckwn4x2v@fzxj6prn3c4b>
Date: Fri, 19 Dec 2025 14:42:35 -0800
Message-ID: <87qzsqhz50.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Thu, Dec 18, 2025 at 05:57:46PM -0800, Roman Gushchin wrote:
>> To effectively operate with memory cgroups in BPF there is a need
>> to convert css pointers to memcg pointers. A simple container_of
>> cast which is used in the kernel code can't be used in BPF because
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
>>  mm/Makefile         |  3 ++
>>  mm/bpf_memcontrol.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
>
> Let's add this file to MAINTAINERS file.

Will do. I planned to create a new entry for mm-related bpf files
as part of the bpf oom patchset.

>
>>  2 files changed, 91 insertions(+)
>>  create mode 100644 mm/bpf_memcontrol.c
>> 
>> diff --git a/mm/Makefile b/mm/Makefile
>> index 9175f8cc6565..79c39a98ff83 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -106,6 +106,9 @@ obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
>>  ifdef CONFIG_SWAP
>>  obj-$(CONFIG_MEMCG) += swap_cgroup.o
>>  endif
>> +ifdef CONFIG_BPF_SYSCALL
>> +obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
>> +endif
>>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>>  obj-$(CONFIG_GUP_TEST) += gup_test.o
>>  obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> new file mode 100644
>> index 000000000000..8aa842b56817
>> --- /dev/null
>> +++ b/mm/bpf_memcontrol.c
>> @@ -0,0 +1,88 @@
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
>> +	struct mem_cgroup *memcg = NULL;
>> +	bool rcu_unlock = false;
>> +
>> +	if (!root_mem_cgroup)
>> +		return NULL;
>
> Should we also handle mem_cgroup_disabled() here?

Good point, will add in v2. Same with bpf_get_root_mem_cgroup() patch.

>
>> +
>> +	if (root_mem_cgroup->css.ss != css->ss) {
>> +		struct cgroup *cgroup = css->cgroup;
>> +		int ssid = root_mem_cgroup->css.ss->id;
>> +
>> +		rcu_read_lock();
>> +		rcu_unlock = true;
>> +		css = rcu_dereference_raw(cgroup->subsys[ssid]);
>> +	}
>> +
>> +	if (css && css_tryget(css))
>> +		memcg = container_of(css, struct mem_cgroup, css);
>> +
>> +	if (rcu_unlock)
>> +		rcu_read_unlock();
>
> Any reason to handle rcu lock like this? Why not just take the rcu read
> lock irrespective? It is cheap.

Idk, it's cheap but not entirely free and I think the code is still
perfectly readable.

>
>> +
>> +	return memcg;
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
>> +	css_put(&memcg->css);
>
> Should we NULL check memcg here? bpf_get_mem_cgroup() can return NULL.

No, the verifier ensures it's a valid memcg pointer. No need for an
additional check.

>
>> +}
>> +
>> +__bpf_kfunc_end_defs();
>> +
>> +BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
>> +BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL | KF_RCU)
>> +BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_TRUSTED_ARGS | KF_RELEASE)
>
> Will the verifier enforce that bpf_put_mem_cgroup() can not be called
> with NULL?

Yep.

Thanks for the review!

