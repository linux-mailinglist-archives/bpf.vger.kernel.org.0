Return-Path: <bpf+bounces-10806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CBE7AE1F9
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6B0D61C20954
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059812375B;
	Mon, 25 Sep 2023 22:57:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C814010
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:57:17 +0000 (UTC)
Received: from out-194.mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314C2101
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 15:57:15 -0700 (PDT)
Message-ID: <dc241e84-bc0a-b529-f032-9bd27abc3d41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695682633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tCllaZ4M0KIhre8q/MXPZ9/NhyL/4ZwXJIsBPZXt7E=;
	b=DtLmahkXRGqI7MfrLE8L1HaCMN9ArHYVsrcvtXX4OpZCHlTCCbd7UrUpFQs+963UxNVavZ
	3Q/GADTeNFzoLhanmr75ENAN8m3piCY3C60sLu8IwdJrB+3kIQ93oLTC+yTQtdm8ICh50h
	DXmqwWXf8dCUnUZaxu55rKDgTgBUyZw=
Date: Mon, 25 Sep 2023 15:57:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 04/11] bpf: attach a module BTF to a
 bpf_struct_ops
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-5-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-5-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Every struct_ops type should has an associated module BTF to provide type
> information since we are going to allow modules to define and register new
> struct_ops types. New types may exist only in module itself, and the kernel
> BTF (vmlinux) doesn't know it at all. The attached module BTF here is going
> to be used to get correct btf and resolve type IDs of a struct_ops map.
> 
> However, it doesn't use the attached module BTF until we are ready to
> switch to registration function in subsequent patches.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h         |  5 +++--
>   kernel/bpf/bpf_struct_ops.c | 27 ++++++++++++++++++---------
>   kernel/bpf/verifier.c       |  2 +-
>   3 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 67554f2f81b7..0776cb584b3f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1626,6 +1626,7 @@ struct bpf_struct_ops {
>   	void (*unreg)(void *kdata);
>   	int (*update)(void *kdata, void *old_kdata);
>   	int (*validate)(void *kdata);
> +	const struct btf *btf;
>   	const struct btf_type *type;
>   	const struct btf_type *value_type;
>   	const char *name;
> @@ -1641,7 +1642,7 @@ struct bpf_struct_ops_mod {
>   
>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
> -const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id);
> +const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf);
>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>   bool bpf_struct_ops_get(const void *kdata);
>   void bpf_struct_ops_put(const void *kdata);
> @@ -1684,7 +1685,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   			    union bpf_attr __user *uattr);
>   #endif
>   #else
> -static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
> +static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf)
>   {
>   	return NULL;
>   }
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index cd688e9033b5..7c2ef53687ef 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -174,6 +174,10 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>   			pr_warn("Error in init bpf_struct_ops %s\n",
>   				st_ops->name);
>   		} else {
> +			/* XXX: We need a owner (module) here to company
> +			 * with type_id and value_id.
> +			 */
> +			st_ops->btf = btf;

I looked ahead in patch 5 and 7, I suspect I sort of getting why it does not 
need a refcount for the btf here.

Instead of having st_ops->btf pointing back to its containing btf, is it enough 
to store the btf in st_"map"->btf?

>   			st_ops->type_id = type_id;
>   			st_ops->type = t;
>   			st_ops->value_id = value_id;
> @@ -210,7 +214,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>   extern struct btf *btf_vmlinux;
>   
>   static const struct bpf_struct_ops *
> -bpf_struct_ops_find_value(u32 value_id)
> +bpf_struct_ops_find_value(u32 value_id, struct btf *btf)

nit. 'struct btf *btf' as the first argument, consistent with other btf search 
functions.

>   {
>   	unsigned int i;
>   
> @@ -225,7 +229,7 @@ bpf_struct_ops_find_value(u32 value_id)
>   	return NULL;
>   }
>   
> -const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
> +const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf)

same here.

>   {
>   	unsigned int i;
>   
> @@ -305,7 +309,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
>   	}
>   }
>   
> -static int check_zero_holes(const struct btf_type *t, void *data)
> +static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
>   {
>   	const struct btf_member *member;
>   	u32 i, moff, msize, prev_mend = 0;
> @@ -317,8 +321,8 @@ static int check_zero_holes(const struct btf_type *t, void *data)
>   		    memchr_inv(data + prev_mend, 0, moff - prev_mend))
>   			return -EINVAL;
>   
> -		mtype = btf_type_by_id(btf_vmlinux, member->type);
> -		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
> +		mtype = btf_type_by_id(btf, member->type);
> +		mtype = btf_resolve_size(btf, mtype, &msize);
>   		if (IS_ERR(mtype))
>   			return PTR_ERR(mtype);
>   		prev_mend = moff + msize;
> @@ -371,7 +375,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	const struct bpf_struct_ops *st_ops = st_map->st_ops;
>   	struct bpf_struct_ops_value *uvalue, *kvalue;
>   	const struct btf_member *member;
> -	const struct btf_type *t = st_ops->type;
> +	const struct btf_type *t;
>   	struct bpf_tramp_links *tlinks;
>   	void *udata, *kdata;
>   	int prog_fd, err;
> @@ -381,15 +385,20 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	if (flags)
>   		return -EINVAL;
>   
> +	if (!st_ops)
> +		return -EINVAL;

Why this new NULL check is needed?

> +
> +	t = st_ops->type;
> +
>   	if (*(u32 *)key != 0)
>   		return -E2BIG;
>   
> -	err = check_zero_holes(st_ops->value_type, value);
> +	err = check_zero_holes(st_ops->btf, st_ops->value_type, value);
>   	if (err)
>   		return err;
>   
>   	uvalue = value;
> -	err = check_zero_holes(t, uvalue->data);
> +	err = check_zero_holes(st_ops->btf, t, uvalue->data);
>   	if (err)
>   		return err;
>   
> @@ -660,7 +669,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	struct bpf_map *map;
>   	int ret;
>   
> -	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
> +	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
>   	if (!st_ops)
>   		return ERR_PTR(-ENOTSUPP);
>   
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7178ecf676d..99b45501951c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19631,7 +19631,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   	}
>   
>   	btf_id = prog->aux->attach_btf_id;
> -	st_ops = bpf_struct_ops_find(btf_id);
> +	st_ops = bpf_struct_ops_find(btf_id, btf_vmlinux);
>   	if (!st_ops) {
>   		verbose(env, "attach_btf_id %u is not a supported struct\n",
>   			btf_id);


