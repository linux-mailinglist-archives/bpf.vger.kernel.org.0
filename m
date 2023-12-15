Return-Path: <bpf+bounces-17959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F2814199
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4E51C224A8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 05:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534536D22;
	Fri, 15 Dec 2023 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ng4HRW6j"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C1D30F
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a8849cd-b8ca-4219-b7cc-5331c42fc190@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702619697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIpY/sTfSRL8B8SBlf3HZZ0vohPPshXoonB5eAF5rAU=;
	b=ng4HRW6ju7vd1xe9gfXMF4ZCkxyiFUGtTGrApBbtq0hMxJRra0PVJcj8lGOFf0PGQ0eRR8
	g6pwEBzK3sBDB3VO3MkvmBon/7fIH+qLWMCv4gmtIPVFnxSLWYitKnPzDH9eXAu12WuXhX
	oBhnNJcl/5sFuy+G5cprm3lvuQfLOos=
Date: Thu, 14 Dec 2023 21:54:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 08/14] bpf: hold module for
 bpf_struct_ops_map.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-9-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-9-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> To ensure that a module remains accessible whenever a struct_ops object of
> a struct_ops type provided by the module is still in use.
> 
> struct bpf_strct_ops_map doesn't hold a refcnt to btf anymore sicne a

s /bpf_strct_/bpf_struct_/

s/sicne/since/

> module will hold a refcnt to it's btf already. But, struct_ops programs are
> different. They hold their associated btf, not the module since they need
> only btf to assure their types (signatures).

The patch subject is not accurate. The patch holds the module refcnt when 
verifying the bpf prog also. May be "hold module refcnt in struct_ops map 
creation and prog verification".

The commit message also is inaccurate on the prog load. It did not mention the 
module is also held when loading struct_ops prog but it is only held during the 
verification time. Please explain why it is only needed during the verification 
time.

> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h          |  1 +
>   include/linux/bpf_verifier.h |  1 +
>   kernel/bpf/bpf_struct_ops.c  | 28 +++++++++++++++++++++++-----
>   kernel/bpf/verifier.c        | 10 ++++++++++
>   4 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 91bcd62d6fcf..c5c7cc4552f5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1681,6 +1681,7 @@ struct bpf_struct_ops {
>   	void (*unreg)(void *kdata);
>   	int (*update)(void *kdata, void *old_kdata);
>   	int (*validate)(void *kdata);
> +	struct module *owner;
>   	const char *name;
>   	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>   };
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 314b679fb494..01113bcdd479 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -651,6 +651,7 @@ struct bpf_verifier_env {
>   	u32 prev_insn_idx;
>   	struct bpf_prog *prog;		/* eBPF program being verified */
>   	const struct bpf_verifier_ops *ops;
> +	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
>   	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
>   	int stack_size;			/* number of states to be processed */
>   	bool strict_alignment;		/* perform strict pointer alignment checks */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index f943f8378e76..a838f7c7d583 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -641,12 +641,15 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
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
> +	module_put(st_map->st_ops_desc->st_ops->owner);

The module_get was not done on st_ops->owner when st_map->btf is btf_vmlinux 
(i.e. not module). Although it probably does not matter, I would feel more 
comfortable if it only releases for the things that it did acquire earlier.

	/* st_ops->owner was acquired during map_alloc to implicitly holds
	 * the btf's refcnt. The acquire was only done when btf_is_module()
	 * st_map->btf cannot be NULL here.
	 */
	if (btf_is_module(st_map->btf))
		module_put(st_map->st_ops_desc->st_ops->owner);

> +
>   	/* The struct_ops's function may switch to another struct_ops.
>   	 *
>   	 * For example, bpf_tcp_cc_x->init() may switch to
> @@ -681,6 +684,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	size_t st_map_size;
>   	struct bpf_struct_ops_map *st_map;
>   	const struct btf_type *t, *vt;
> +	struct module *mod = NULL;
>   	struct bpf_map *map;
>   	struct btf *btf;
>   	int ret;
> @@ -690,10 +694,20 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>   		if (IS_ERR(btf))
>   			return ERR_PTR(PTR_ERR(btf));
> -	} else {
> +
> +		if (btf != btf_vmlinux) {
> +			mod = btf_try_get_module(btf);
> +			if (!mod) {
> +				btf_put(btf);
> +				return ERR_PTR(-EINVAL);
> +			}
> +		}
> +		/* mod (NULL for btf_vmlinux) holds a refcnt to btf. We
> +		 * don't need an extra refcnt here.
> +		 */
> +		btf_put(btf);
> +	} else
>   		btf = btf_vmlinux;
> -		btf_get(btf);
> -	}
>   
>   	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
>   	if (!st_ops_desc) {
> @@ -756,7 +770,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   errout_free:
>   	__bpf_struct_ops_map_free(map);
>   errout:
> -	btf_put(btf);
> +	module_put(mod);
>   
>   	return ERR_PTR(ret);
>   }
> @@ -886,6 +900,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>   	if (!bpf_struct_ops_valid_to_reg(new_map))
>   		return -EINVAL;
>   
> +	/* The old map is holding the refcount for the owner module.  The
> +	 * ownership of the owner module refcount is going to be
> +	 * transferred from the old map to the new map.
> +	 */

This part I don't understand. Both old and new map hold its own module's 
refcount at map_alloc time and release its own module refcnt during map_free().
Where the module refcount transfer happened?

>   	if (!st_map->st_ops_desc->st_ops->update)
>   		return -EOPNOTSUPP;
>   
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 795c16f9cf57..c303cf2fb5ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20079,6 +20079,14 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   	}
>   
>   	btf = prog->aux->attach_btf;
> +	if (btf != btf_vmlinux) {

	if (btf_is_module(btf)) {

> +		/* Make sure st_ops is valid through the lifetime of env */
> +		env->attach_btf_mod = btf_try_get_module(btf);
> +		if (!env->attach_btf_mod) {
> +			verbose(env, "owner module of btf is not found\n");
> +			return -ENOTSUPP;
> +		}
> +	}
>   
>   	btf_id = prog->aux->attach_btf_id;
>   	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
> @@ -20792,6 +20800,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>   		env->prog->expected_attach_type = 0;
>   
>   	*prog = env->prog;
> +
> +	module_put(env->attach_btf_mod);
>   err_unlock:
>   	if (!is_priv)
>   		mutex_unlock(&bpf_verifier_lock);


