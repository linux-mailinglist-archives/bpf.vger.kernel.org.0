Return-Path: <bpf+bounces-77205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C9CD20EA
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 22:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFF56300BA13
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260C6849C;
	Fri, 19 Dec 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y0QuSSH7"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168C29C321
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181101; cv=none; b=ZMvZmaj84npdZfJtlU3shBpwI5fWxYxHZSDfGQ10wQAlSMaQ57b3tr9pvpXj5sreA5762ZT8kZcAbz4270nAkLVpqosTyPFQR79HOHjHRox5OsVIJuUNgeDc5a0VxjvC7/cOFCWqqUqFDzvf0aCHaEWnCHZQF2li9D5UafD8sKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181101; c=relaxed/simple;
	bh=ycBxUP5QaxJ+pivUIYtJMYQxZuCU9q8ZgdXHtd6Og3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2+7Xis/mSEyvm7j7eUnvuWzYqEwd25VPXyya900JK8yl/I8Nazt45uX7VaOx+DmYGGDg+zoXNO7epZ+FKfqopd3t/o+H4Ni5Os0YPnCkZUIJGUcMK13AF4moRP/fhuisvUBLkEE92B9bdrMkvgK9NYd0cuHdg8VQeGY8p+tUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y0QuSSH7; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 13:51:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766181081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNFoqlgDQA56uiitPv8yysa4KehXudJlPS9PbYyd1Kc=;
	b=Y0QuSSH7VEdDKnqC3BN09CEAzELOAU5UZEqNyfoLH1EHX8dL8l3w+tC3wraX8bHG/iMFQL
	M1Qcok/2BD9DS+UtTWn38wNsv3juS6UJgxxsedqBFcyCXK0hbwQTU/5M6RmcL1H2MMKq/0
	9E9EX/Gm045hLhbEI4uDGNV/6vrrBkM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v1 2/6] mm: introduce BPF kfuncs to deal with
 memcg pointers
Message-ID: <nicnfk2rfemgjvrlp2wyztymyunfxgd4ixqfnkivzjckwn4x2v@fzxj6prn3c4b>
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
 <20251219015750.23732-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219015750.23732-3-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 18, 2025 at 05:57:46PM -0800, Roman Gushchin wrote:
> To effectively operate with memory cgroups in BPF there is a need
> to convert css pointers to memcg pointers. A simple container_of
> cast which is used in the kernel code can't be used in BPF because
> from the verifier's point of view that's a out-of-bounds memory access.
> 
> Introduce helper get/put kfuncs which can be used to get
> a refcounted memcg pointer from the css pointer:
>   - bpf_get_mem_cgroup,
>   - bpf_put_mem_cgroup.
> 
> bpf_get_mem_cgroup() can take both memcg's css and the corresponding
> cgroup's "self" css. It allows it to be used with the existing cgroup
> iterator which iterates over cgroup tree, not memcg tree.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/Makefile         |  3 ++
>  mm/bpf_memcontrol.c | 88 +++++++++++++++++++++++++++++++++++++++++++++

Let's add this file to MAINTAINERS file.

>  2 files changed, 91 insertions(+)
>  create mode 100644 mm/bpf_memcontrol.c
> 
> diff --git a/mm/Makefile b/mm/Makefile
> index 9175f8cc6565..79c39a98ff83 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -106,6 +106,9 @@ obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
>  ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) += swap_cgroup.o
>  endif
> +ifdef CONFIG_BPF_SYSCALL
> +obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
> +endif
>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) += gup_test.o
>  obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> new file mode 100644
> index 000000000000..8aa842b56817
> --- /dev/null
> +++ b/mm/bpf_memcontrol.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Memory Controller-related BPF kfuncs and auxiliary code
> + *
> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> + */
> +
> +#include <linux/memcontrol.h>
> +#include <linux/bpf.h>
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_get_mem_cgroup - Get a reference to a memory cgroup
> + * @css: pointer to the css structure
> + *
> + * Returns a pointer to a mem_cgroup structure after bumping
> + * the corresponding css's reference counter.
> + *
> + * It's fine to pass a css which belongs to any cgroup controller,
> + * e.g. unified hierarchy's main css.
> + *
> + * Implements KF_ACQUIRE semantics.
> + */
> +__bpf_kfunc struct mem_cgroup *
> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
> +{
> +	struct mem_cgroup *memcg = NULL;
> +	bool rcu_unlock = false;
> +
> +	if (!root_mem_cgroup)
> +		return NULL;

Should we also handle mem_cgroup_disabled() here?

> +
> +	if (root_mem_cgroup->css.ss != css->ss) {
> +		struct cgroup *cgroup = css->cgroup;
> +		int ssid = root_mem_cgroup->css.ss->id;
> +
> +		rcu_read_lock();
> +		rcu_unlock = true;
> +		css = rcu_dereference_raw(cgroup->subsys[ssid]);
> +	}
> +
> +	if (css && css_tryget(css))
> +		memcg = container_of(css, struct mem_cgroup, css);
> +
> +	if (rcu_unlock)
> +		rcu_read_unlock();

Any reason to handle rcu lock like this? Why not just take the rcu read
lock irrespective? It is cheap.

> +
> +	return memcg;
> +}
> +
> +/**
> + * bpf_put_mem_cgroup - Put a reference to a memory cgroup
> + * @memcg: memory cgroup to release
> + *
> + * Releases a previously acquired memcg reference.
> + * Implements KF_RELEASE semantics.
> + */
> +__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> +{
> +	css_put(&memcg->css);

Should we NULL check memcg here? bpf_get_mem_cgroup() can return NULL.

> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> +BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_TRUSTED_ARGS | KF_RELEASE)

Will the verifier enforce that bpf_put_mem_cgroup() can not be called
with NULL?

> +
> +BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
> +
> +static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
> +	.owner          = THIS_MODULE,
> +	.set            = &bpf_memcontrol_kfuncs,
> +};
> +
> +static int __init bpf_memcontrol_init(void)
> +{
> +	int err;
> +
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
> +					&bpf_memcontrol_kfunc_set);
> +	if (err)
> +		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
> +
> +	return err;
> +}
> +late_initcall(bpf_memcontrol_init);
> -- 
> 2.52.0
> 

