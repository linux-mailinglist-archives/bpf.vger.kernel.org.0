Return-Path: <bpf+bounces-42458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57C09A45C9
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70C41C23DF7
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D631209687;
	Fri, 18 Oct 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ISWYdl7x"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F804208967
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275737; cv=none; b=Vpc0Rf5NNQzD5mve4CSXGdYtjJrqL++LVO5ju0izSrTtUOmNmPMB6k0CCUCqWkW+Dpx+13wpzBzGVbST0PZnYzep2azveFjEz0y1V+wPVXmOgBYx6xUXc6FJOsMI67Nj6n/w895F0XFNgZz2azN4BdVhOzCwxPgqlwGtoaSNerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275737; c=relaxed/simple;
	bh=fsaUa9G1opCeUihrjrdTRgCV45Ou5JI4JRd24hmNsBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6damkJtowbVLreTyE627M+Y7Blq/KXcWEg9vaA5ICc8dWSeMl5MNw2jsJApKwutvdfIjVuuCcBPLYmyGWuvhSXz6JDxnAg3GYmbYF+EFCp+ZF/C1E5FVo5LUexxGckFhiKBxTlza9ngnfytEFN+SgZS9FgNNOl9uk1vzByOj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ISWYdl7x; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3655d46-5c42-407e-adc1-b17865432e45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729275733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX3NnUn3UeH6nxlGLDibU44GfunoKuAgfBARM5Nx6YQ=;
	b=ISWYdl7xe2RCvWWdBZlzAuQHys34NaB91RlKHoJSftbAhIcBUgKd3W1Au95yy4fSCqFl56
	K51phyfbeZytnF7akWTGEJj2x2Nap8e4ON+XOBd1ZPhR+9Jgtj+RkSC4ZcRnI+vedNFPgD
	HT+31mMysD4cFpNox6amsUooFVTqBKI=
Date: Fri, 18 Oct 2024 11:22:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add open coded version of kmem_cache
 iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
References: <20241017080604.541872-1-namhyung@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241017080604.541872-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/17/24 1:06 AM, Namhyung Kim wrote:
> Add a new open coded iterator for kmem_cache which can be called from a
> BPF program like below.  It doesn't take any argument and traverses all
> kmem_cache entries.
> 
>    struct kmem_cache *pos;
> 
>    bpf_for_each(kmem_cache, pos) {
>        ...
>    }
> 
> As it needs to grab slab_mutex, it should be called from sleepable BPF
> programs only.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   kernel/bpf/helpers.c         |  3 ++
>   kernel/bpf/kmem_cache_iter.c | 87 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 073e6f04f4d765ff..d1dfa4f335577914 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3111,6 +3111,9 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>   BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_get_kmem_cache)
> +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>   BTF_KFUNCS_END(common_btf_ids)
>   
>   static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/kernel/bpf/kmem_cache_iter.c b/kernel/bpf/kmem_cache_iter.c
> index ebc101d7da51b57c..31ddaf452b20a458 100644
> --- a/kernel/bpf/kmem_cache_iter.c
> +++ b/kernel/bpf/kmem_cache_iter.c
> @@ -145,6 +145,93 @@ static const struct bpf_iter_seq_info kmem_cache_iter_seq_info = {
>   	.seq_ops		= &kmem_cache_iter_seq_ops,
>   };
>   
> +/* open-coded version */
> +struct bpf_iter_kmem_cache {
> +	__u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_kmem_cache_kern {
> +	struct kmem_cache *pos;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it)
> +{
> +	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
> +
> +	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
> +	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
> +
> +	kit->pos = NULL;
> +	return 0;
> +}
> +
> +__bpf_kfunc struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it)
> +{
> +	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
> +	struct kmem_cache *prev = kit->pos;
> +	struct kmem_cache *next;
> +	bool destroy = false;
> +
> +	mutex_lock(&slab_mutex);

I think taking mutex_lock here should be fine since sleepable tracing prog 
should be limited to the error injection whitelist. Those functions should not 
have held the mutex afaict.

> +
> +	if (list_empty(&slab_caches)) {
> +		mutex_unlock(&slab_mutex);
> +		return NULL;
> +	}
> +
> +	if (prev == NULL)
> +		next = list_first_entry(&slab_caches, struct kmem_cache, list);
> +	else if (list_last_entry(&slab_caches, struct kmem_cache, list) == prev)
> +		next = NULL;

At the last entry, next is NULL.

> +	else
> +		next = list_next_entry(prev, list);
> +
> +	/* boot_caches have negative refcount, don't touch them */
> +	if (next && next->refcount > 0)
> +		next->refcount++;
> +
> +	/* Skip kmem_cache_destroy() for active entries */
> +	if (prev && prev->refcount > 1)
> +		prev->refcount--;
> +	else if (prev && prev->refcount == 1)
> +		destroy = true;
> +
> +	mutex_unlock(&slab_mutex);
> +
> +	if (destroy)
> +		kmem_cache_destroy(prev);
> +
> +	kit->pos = next;

so kit->pos will be NULL also. Does it mean the bpf prog will be able to call 
bpf_iter_kmem_cache_next() again and re-loop from the beginning of the 
slab_caches list?

> +	return next;
> +}
> +
> +__bpf_kfunc void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it)
> +{
> +	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
> +	struct kmem_cache *s = kit->pos;
> +	bool destroy = false;
> +
> +	if (s == NULL)
> +		return;
> +
> +	mutex_lock(&slab_mutex);
> +
> +	/* Skip kmem_cache_destroy() for active entries */
> +	if (s->refcount > 1)
> +		s->refcount--;
> +	else if (s->refcount == 1)
> +		destroy = true;
> +
> +	mutex_unlock(&slab_mutex);
> +
> +	if (destroy)
> +		kmem_cache_destroy(s);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
>   static void bpf_iter_kmem_cache_show_fdinfo(const struct bpf_iter_aux_info *aux,
>   					    struct seq_file *seq)
>   {


