Return-Path: <bpf+bounces-40917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536798FD05
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 07:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E481C22691
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 05:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC607D3F1;
	Fri,  4 Oct 2024 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlN1u4IC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001C1D5ADA;
	Fri,  4 Oct 2024 05:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019907; cv=none; b=GmyZIER8bWif5jHgx0g5TZzOTOvnt7Df7CSYl33J5ja3gWjJ3+++Nxt96Dejkr3SVhtvEiTBZMbROHr+hDQeJi7wJI0ss6smp86QhhRsnl5icREhApNXsdctRHXNLgCl5MfRIsr+6kqz6sPXHOASD8P82ZxCo1UJu48WiEgIpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019907; c=relaxed/simple;
	bh=oPReOWeYT2UZEov/VsqcIcn18d320BRQlYBQEAvZuUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZgilMo/dKzlsGnKxkclcTm+pqaEJa/lu+73tjWf5oy3zh4R76wXokCG8d/dNHa/S2yn4/kGgqwkOp5iFIgXQ0UfcWdB/puRcSSLkRlPDLnW5TYKmIHr5QoB4Qan1LIrguw8t7K6NoIr2moUF0dKquPMRNyYLqH3hyxx6Ypv8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlN1u4IC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765A3C4CEC6;
	Fri,  4 Oct 2024 05:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728019906;
	bh=oPReOWeYT2UZEov/VsqcIcn18d320BRQlYBQEAvZuUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlN1u4IC0r99kFwuTyEvvgpnKtlQXJhQIiaVSYFWhKt0guvQX5I2wtbi4wfjdPRvw
	 jDFjhzprkgEX63ncvKL/SeVUECu5nBFrH5IIY6d1J0MCbZyKD4hvs92/xS0keDVZQs
	 TFtKR1zDQLVPE6z4xgr19Hx8bgMXlNKLzKD8s4AXc3Zou8yXuts/LhS2JxwColr0Fi
	 fduCMr+IhO1XWtSdTYu8QRP94FyJ6/NBxH/2Rikk8e8Rhc+wQF8y4V/m2u6N5if3Jo
	 hNV01hbozoSnECH8E9jJAUxO0tNxkNOo8ENRWVrSeDbk237tgY7YRxY8eo8almgf5b
	 VESCjGrbNaDNQ==
Date: Thu, 3 Oct 2024 22:31:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <Zv99wGyOjwWfbsyz@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002180956.1781008-3-namhyung@kernel.org>

On Wed, Oct 02, 2024 at 11:09:55AM -0700, Namhyung Kim wrote:
> The bpf_get_kmem_cache() is to get a slab cache information from a
> virtual address like virt_to_cache().  If the address is a pointer
> to a slab object, it'd return a valid kmem_cache pointer, otherwise
> NULL is returned.
> 
> It doesn't grab a reference count of the kmem_cache so the caller is
> responsible to manage the access.  The intended use case for now is to
> symbolize locks in slab objects from the lock contention tracepoints.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/bpf/helpers.c |  1 +
>  mm/slab_common.c     | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4053f279ed4cc7ab..3709fb14288105c6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
>  BTF_KFUNCS_END(common_btf_ids)
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 7443244656150325..5484e1cd812f698e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
>  }
>  EXPORT_SYMBOL(ksize);
>  
> +#ifdef CONFIG_BPF_SYSCALL
> +#include <linux/btf.h>
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> +{
> +	struct slab *slab;
> +
> +	if (!virt_addr_valid(addr))

Hmm.. 32-bit systems don't like this.  Is it ok to change the type of
the parameter (addr) to 'unsigned long'?  Or do you want to keep it as
u64 and add a cast here?

Thanks,
Namhyung


> +		return NULL;
> +
> +	slab = virt_to_slab((void *)(long)addr);
> +	return slab ? slab->slab_cache : NULL;
> +}
> +
> +__bpf_kfunc_end_defs();
> +#endif /* CONFIG_BPF_SYSCALL */
> +
>  /* Tracepoints definitions. */
>  EXPORT_TRACEPOINT_SYMBOL(kmalloc);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
> -- 
> 2.46.1.824.gd892dcdcdd-goog
> 

