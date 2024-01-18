Return-Path: <bpf+bounces-19841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92783217C
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79191C23325
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72631A9A;
	Thu, 18 Jan 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aEhD5/h/"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949321E486
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616328; cv=none; b=dv8DyLwJw57XklEHF7wRz2NekIJppjWt0N9Ga8qb5BCMbxEUFkwa3F3r9B3+KLrtCfIJ7ckmT6oVGSjDslTyH5L1+ioiSHqHJfZ5NQJAhVjdqQLs7Keinod/L+sUlKtJsdwspZU9R4nm8h+jMkEDX+1AEdI984/BKrJQSyCbdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616328; c=relaxed/simple;
	bh=LtW60o0CKU7omMQRvIvfuZKyGKb/8C4/OhOsOxVUymI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPCzc57JExumlVyatQl7Z9GkN+crMnpKDHK6kN7B4v8SBmjsLlrocG+bD997FX2u82RjOyZTQiI9ybFhLg+6kn+jow0q5m/NoBRtxLS/mGqCSk2+kNgpwDeGyqehFHuCkKLP3SFdPW5LX4lJzK5TXSI/IOj4G6xwzVqN0Rg9QsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aEhD5/h/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0a382b1-467c-4c28-8882-8f523826178a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705616324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewxitrZLdDVnRn2s9kIpEbtOn1d9bIYWsnLT4JYtrXQ=;
	b=aEhD5/h/fc91n4nGMubMmEesfEM+m6srAxSmDsgUS8R0cstYqLAv/ZZ1ZtjLazhxrFnGrf
	dAzMXHLhS8knVZamRylS22n7ZZcd189472asK9odau2MGA8sANortD0soVjEuY7baJGqlf
	nGqvFaES8gFzuvQYBAE2z26BTNn57XE=
Date: Thu, 18 Jan 2024 14:18:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v16 09/14] bpf: hold module refcnt in
 bpf_struct_ops map creation and prog verification.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-10-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240118014930.1992551-10-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> To ensure that a module remains accessible whenever a struct_ops object of
> a struct_ops type provided by the module is still in use.
> 
> struct bpf_struct_ops_map doesn't hold a refcnt to btf anymore since a
> module will hold a refcnt to it's btf already. But, struct_ops programs are
> different. They hold their associated btf, not the module since they need
> only btf to assure their types (signatures).
> 
> However, verifier holds the refcnt of the associated module of a struct_ops
> type temporarily when verify a struct_ops prog. Verifier needs the help
> from the verifier operators (struct bpf_verifier_ops) provided by the owner
> module to verify data access of a prog, provide information, and generate
> code.
> 
> This patch also add a count of links (links_cnt) to bpf_struct_ops_map. It
> avoids bpf_struct_ops_map_put_progs() from accessing btf after calling
> module_put() in bpf_struct_ops_map_free().

Good catch in v16.

> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h          |  1 +
>   include/linux/bpf_verifier.h |  1 +
>   kernel/bpf/bpf_struct_ops.c  | 31 +++++++++++++++++++++++++------
>   kernel/bpf/verifier.c        | 10 ++++++++++
>   4 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3d1c1014fdb2..a977ed75288c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1674,6 +1674,7 @@ struct bpf_struct_ops {
>   	int (*update)(void *kdata, void *old_kdata);
>   	int (*validate)(void *kdata);
>   	void *cfi_stubs;
> +	struct module *owner;
>   	const char *name;
>   	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>   };
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d07d857ca67f..e6cf025c9446 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -662,6 +662,7 @@ struct bpf_verifier_env {
>   	u32 prev_insn_idx;
>   	struct bpf_prog *prog;		/* eBPF program being verified */
>   	const struct bpf_verifier_ops *ops;
> +	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
>   	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
>   	int stack_size;			/* number of states to be processed */
>   	bool strict_alignment;		/* perform strict pointer alignment checks */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 3b8d689ece5d..61486f6595ea 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -40,6 +40,7 @@ struct bpf_struct_ops_map {
>   	 * (in kvalue.data).
>   	 */
>   	struct bpf_link **links;
> +	u32 links_cnt;
>   	/* image is a page that has all the trampolines
>   	 * that stores the func args before calling the bpf_prog.
>   	 * A PAGE_SIZE "image" is enough to store all trampoline for
> @@ -306,10 +307,9 @@ static void *bpf_struct_ops_map_lookup_elem(struct bpf_map *map, void *key)
>   
>   static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
>   {
> -	const struct btf_type *t = st_map->st_ops_desc->type;
>   	u32 i;
>   
> -	for (i = 0; i < btf_type_vlen(t); i++) {
> +	for (i = 0; i < st_map->links_cnt; i++) {
>   		if (st_map->links[i]) {
>   			bpf_link_put(st_map->links[i]);
>   			st_map->links[i] = NULL;
> @@ -641,12 +641,20 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   		bpf_jit_uncharge_modmem(PAGE_SIZE);
>   	}
>   	bpf_map_area_free(st_map->uvalue);
> -	btf_put(st_map->btf);
>   	bpf_map_area_free(st_map);
>   }
>   
>   static void bpf_struct_ops_map_free(struct bpf_map *map)
>   {
> +	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
> +
> +	/* st_ops->owner was acquired during map_alloc to implicitly holds
> +	 * the btf's refcnt. The acquire was only done when btf_is_module()
> +	 * st_map->btf cannot be NULL here.
> +	 */
> +	if (btf_is_module(st_map->btf))
> +		module_put(st_map->st_ops_desc->st_ops->owner);
> +
>   	/* The struct_ops's function may switch to another struct_ops.
>   	 *
>   	 * For example, bpf_tcp_cc_x->init() may switch to
> @@ -682,6 +690,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	size_t st_map_size;
>   	struct bpf_struct_ops_map *st_map;
>   	const struct btf_type *t, *vt;
> +	struct module *mod = NULL;
>   	struct bpf_map *map;
>   	struct btf *btf;
>   	int ret;
> @@ -695,11 +704,20 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   			btf_put(btf);
>   			return ERR_PTR(-EINVAL);
>   		}
> +
> +		mod = btf_try_get_module(btf);

nit. btf_put(btf) here.

> +		if (!mod) {
> +			btf_put(btf);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		/* mod holds a refcnt to btf. We don't need an extra refcnt
> +		 * here.
> +		 */
> +		btf_put(btf);
>   	} else {
>   		btf = bpf_get_btf_vmlinux();
>   		if (IS_ERR(btf))
>   			return ERR_CAST(btf);
> -		btf_get(btf);
>   	}
>   
>   	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
> @@ -746,8 +764,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		goto errout_free;
>   	}
>   	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
> +	st_map->links_cnt = btf_type_vlen(t);
>   	st_map->links =
> -		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
> +		bpf_map_area_alloc(st_map->links_cnt * sizeof(struct bpf_links *),
>   				   NUMA_NO_NODE);
>   	if (!st_map->uvalue || !st_map->links) {
>   		ret = -ENOMEM;
> @@ -763,7 +782,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   errout_free:
>   	__bpf_struct_ops_map_free(map);
>   errout:
> -	btf_put(btf);
> +	module_put(mod);
>   
>   	return ERR_PTR(ret);
>   }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff41f7736618..60f08f468399 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20243,6 +20243,14 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   	}
>   
>   	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
> +	if (btf_is_module(btf)) {
> +		/* Make sure st_ops is valid through the lifetime of env */
> +		env->attach_btf_mod = btf_try_get_module(btf);
> +		if (!env->attach_btf_mod) {
> +			verbose(env, "owner module of btf is not found\n");

nit. A better message, something like:

			verbose(env, "struct_ops module %s is not found\n",
				btf_get_name(btf));

> +			return -ENOTSUPP;
> +		}
> +	}
>   
>   	btf_id = prog->aux->attach_btf_id;
>   	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
> @@ -20968,6 +20976,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>   		env->prog->expected_attach_type = 0;
>   
>   	*prog = env->prog;
> +
> +	module_put(env->attach_btf_mod);
>   err_unlock:
>   	if (!is_priv)
>   		mutex_unlock(&bpf_verifier_lock);


