Return-Path: <bpf+bounces-66723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F595B38B1F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4B65E0A8A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142442FF67D;
	Wed, 27 Aug 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q7gKgNWb"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112132F0C75
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327574; cv=none; b=mKBfWs15/dLLnm46+C3zhoutOOhKzJRWtLF86KGUzda5FLmDqco0y08sxg66gJoMJbm1C3BC8FbPcGncr3M2GgiVzFtig7T2+sbunj3iaKVS9/gGSMRHvxCMaUBsRLex2pWooBENHTGPWCumiHHBeb4SUYW/N1PFfIi2PtyXlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327574; c=relaxed/simple;
	bh=3KLq0MsGce7NG29fkIxZHf8hKAtCZLpW0Xdj8aanGg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irinfPO0LyJZNSXHSryFlLHdhl+0+5yR6jtkCXW7VQ13MHozXsAPE/8+BnXwctU7vyTmKrisd/ofpTDqV59jw8bsct8ssAYYZ9m9OPeeqSUFh/V2JtVzPl+jhXzIIkQ5vShfwarBEe/nEyVjUo/tFp29oXqcdagdPDmJ3P7HO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q7gKgNWb; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Aug 2025 13:45:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756327569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ahOSLWCblhlSzmsWpcFUTr95mpQcXUfJDJnFLqu19U=;
	b=q7gKgNWbJlbFvFV79gYnJ2M3yDQD0gyNhew1vwd+MLVhfZX8esNm3LIG286u0FBXpqbw0y
	/0c3V5wfyP8FU3qGtG965GdeaH+EBm5Dz82fjS+KAc8BeNkdOo4WOvI6jexeI3bBrrAbdI
	6+OmUuV8ctsW1XTWIZybC9ZFiPppTzM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, willy@infradead.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc
 bpf_mm_get_mem_cgroup()
Message-ID: <fxjgxvoq3z4utlwb7asmt6wfjfl5t2nvfnghhmwplhqerv22yg@3i4gdavsyirq>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826071948.2618-3-laoar.shao@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 03:19:40PM +0800, Yafang Shao wrote:
> We will utilize this new kfunc bpf_mm_get_mem_cgroup() to retrieve the
> associated mem_cgroup from the given @mm. The obtained mem_cgroup must
> be released by calling bpf_put_mem_cgroup() as a paired operation.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/bpf_thp.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> index fbff3b1bb988..b757e8f425fd 100644
> --- a/mm/bpf_thp.c
> +++ b/mm/bpf_thp.c
> @@ -175,10 +175,59 @@ static struct bpf_struct_ops bpf_bpf_thp_ops = {
>  	.name = "bpf_thp_ops",
>  };
>  
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_mm_get_mem_cgroup - Get the memory cgroup associated with a mm_struct.
> + * @mm: The mm_struct to query
> + *
> + * The obtained mem_cgroup must be released by calling bpf_put_mem_cgroup().
> + *
> + * Return: The associated mem_cgroup on success, or NULL on failure. Note that
> + * this function depends on CONFIG_MEMCG being enabled - it will always return
> + * NULL if CONFIG_MEMCG is not configured.
> + */
> +__bpf_kfunc struct mem_cgroup *bpf_mm_get_mem_cgroup(struct mm_struct *mm)
> +{
> +	return get_mem_cgroup_from_mm(mm);
> +}
> +
> +/**
> + * bpf_put_mem_cgroup - Release a memory cgroup obtained from bpf_mm_get_mem_cgroup()
> + * @memcg: The memory cgroup to release
> + */
> +__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> +{
> +#ifdef CONFIG_MEMCG
> +	if (!memcg)
> +		return;
> +	css_put(&memcg->css);
> +#endif

Just use mem_cgroup_put() here.

> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_thp_ids)
> +BTF_ID_FLAGS(func, bpf_mm_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
> +BTF_KFUNCS_END(bpf_thp_ids)
> +
> +static const struct btf_kfunc_id_set bpf_thp_set = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_thp_ids,
> +};
> +
>  static int __init bpf_thp_ops_init(void)
>  {
> -	int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
> +	int err;
> +
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_thp_set);
> +	if (err) {
> +		pr_err("bpf_thp: Failed to register kfunc sets (%d)\n", err);
> +		return err;
> +	}
>  
> +	err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
>  	if (err)
>  		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
>  	return err;
> -- 
> 2.47.3
> 

