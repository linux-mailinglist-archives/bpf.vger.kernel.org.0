Return-Path: <bpf+bounces-77210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6F8CD22BA
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 00:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B693023794
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86F2BE7AB;
	Fri, 19 Dec 2025 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u39UQgTq"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20321FF2A
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766185655; cv=none; b=EuYKxNdzKIDyN+g8AGPAqeydM5zqUwgC/12wuos1CNWfpT9UMcGRg4+NB0ya8hABTMmgxUurVJW75+F++PnEscgHW/hllcYeg0CdUpcAa6rvYhjuvw6kW1XOUPs0RPGxyGCpE8K2Q3dRmVTxsciKhfMSO2+EAmq/w3Eybp4kFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766185655; c=relaxed/simple;
	bh=fiZ0CoPW0gOnxyRiIhEO8HUO0+T2UPkjyNbHi/yiV/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPNWzBL6sq92C79/AurCrubbJI2N/pmRHugjguK8+0bTtSoqqX4nkpce2DOGv/SkxyhWKS9uP2Vd8agGSUdhItqj5OjfEawBiCUhjRw9nbx/vjbgFQU09Wlv2OPmN0WyY32ATtjd0kMRL2hhqMXcfKhHTrYPi894ggXpMbgnqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u39UQgTq; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 15:07:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766185641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UxbH7/QY+8GEwV0rueVzSKiGoEoy6NGLSngPmq+y6I=;
	b=u39UQgTqEkUaY63z0CDXE/GoT2fL7qAK2LEWgWvC1yEKtwwvSvTK9RkCzrvcUNV9yP45rF
	0ELxSvTgF2yX9Q0ofCaUrk49R/LBVsdMf5o2qjBWyAGmYGChxjZxXwMa7tSUPIcH1b+/UY
	D2XOTVj998YROjj0Sugli2yXd8/YIYM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v1 6/6] bpf: selftests: selftests for memcg stat
 kfuncs
Message-ID: <2xhmcrporen72rskghn6hmg6obnojptuerwzqgu7mqzhnxaxs5@33dxlwa6rqlh>
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
 <20251219015750.23732-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219015750.23732-7-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 18, 2025 at 05:57:50PM -0800, Roman Gushchin wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> Add test coverage for the kfuncs that fetch memcg stats. Using some common
> stats, test scenarios ensuring that the given stat increases by some
> arbitrary amount. The stats selected cover the three categories represented
> by the enums: node_stat_item, memcg_stat_item, vm_event_item.
> 
> Since only a subset of all stats are queried, use a static struct made up
> of fields for each stat. Write to the struct with the fetched values when
> the bpf program is invoked and read the fields in the user mode program for
> verification.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Need your signoff

[...]
> +
> +#define NR_PIPES 64
> +static void test_kmem(struct bpf_link *link, struct memcg_query *memcg_query)
> +{
> +	int fds[NR_PIPES][2], i;
> +
> +	/*
> +	 * Increase kmem value by creating pipes which will allocate some
> +	 * kernel buffers.
> +	 */
> +	for (i = 0; i < NR_PIPES; i++) {
> +		if (!ASSERT_OK(pipe(fds[i]), "pipe"))
> +			goto cleanup;
> +	}
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		goto cleanup;
> +
> +	ASSERT_GT(memcg_query->memcg_kmem, 0, "kmem value");
> +
> +cleanup:
> +	for (i = 0; i < NR_PIPES; i++) {

Instead of from 0 to NR_PIPES, we need to go from i-1 to (and equal to) 0
otherwise we can potentially close() junk values.

> +		close(fds[i][0]);
> +		close(fds[i][1]);
> +	}
> +}
> +

[...]

> +
> +SEC("iter.s/cgroup")
> +int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
> +{
> +	struct cgroup *cgrp = ctx->cgroup;
> +	struct cgroup_subsys_state *css;
> +	struct mem_cgroup *memcg;
> +
> +	if (!cgrp)
> +		return 1;
> +
> +	css = &cgrp->self;
> +	if (!css)

Will css ever be NULL here?

> +		return 1;
> +
> +	memcg = bpf_get_mem_cgroup(css);
> +	if (!memcg)
> +		return 1;
> +
> +	bpf_mem_cgroup_flush_stats(memcg);
> +
> +	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED);
> +	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
> +	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
> +	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(memcg, NR_FILE_MAPPED);
> +	memcg_query.memcg_kmem = bpf_mem_cgroup_page_state(memcg, MEMCG_KMEM);
> +	memcg_query.pgfault = bpf_mem_cgroup_vm_events(memcg, PGFAULT);
> +
> +	bpf_put_mem_cgroup(memcg);
> +
> +	return 0;
> +}
> -- 
> 2.52.0
> 

