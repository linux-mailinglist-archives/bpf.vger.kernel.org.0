Return-Path: <bpf+bounces-10810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35CA7AE211
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8464A2817C3
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7F26289;
	Mon, 25 Sep 2023 23:07:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B461B281
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:07:14 +0000 (UTC)
Received: from out-202.mta1.migadu.com (out-202.mta1.migadu.com [IPv6:2001:41d0:203:375::ca])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57064A3
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:07:13 -0700 (PDT)
Message-ID: <75489013-0364-a91a-66d8-2d600a159246@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695683230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lq9GC1R18CehNtFAD7iFXeWoNHtXeB4F/Wib/pYxboo=;
	b=ErSsqzULT8u+/xmkT1GpcX5tDOdR5RO2VIJ6tC5COzmfeNxpGkWEqAt3119d1oI+2rHQ8H
	+pFXLPzbzFODPhVrTHaif+GwKj01v6OZWI9p5th2WLHg/3+Peo7VSAXBSK1xA0SflS/zHm
	OpMPyArmJL5oj5qkW66fUXUmtWl04J0=
Date: Mon, 25 Sep 2023 16:07:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 03/11] bpf: add register and unregister
 functions for struct_ops.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-4-thinker.li@gmail.com>
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
> Provide registration functions to add/remove struct_ops types.
> 
> Currently, it does linear search to find a struct_ops type. It should be
> fine for now since we don't have many struct_ops types.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h         |  9 +++++++++
>   include/linux/btf.h         | 27 +++++++++++++++++++++++++++
>   kernel/bpf/bpf_struct_ops.c | 11 -----------
>   kernel/bpf/btf.c            |  2 +-
>   4 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 30063a760b5a..67554f2f81b7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1634,6 +1634,11 @@ struct bpf_struct_ops {
>   	u32 value_id;
>   };
>   
> +struct bpf_struct_ops_mod {
> +	struct module *owner;

After reading patch 5, I don't think this new 'struct bpf_struct_ops_mod' is needed.

> +	struct bpf_struct_ops *st_ops;

In patch 5, 'struct module *owner' has been added to 'bpf_struct_ops'. st_ops 
itself should already have the 'owner'.

> +};
> +
>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
>   const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id);
> @@ -3205,4 +3210,8 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>   	return prog->aux->func_idx != 0;
>   }
>   
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod);

This should be register_bpf_struct_ops(struct bpf_struct_ops *st_ops) instead.

> +#endif
> +
>   #endif /* _LINUX_BPF_H */
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 5fabe23aedd2..8d50e46b21bc 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -12,6 +12,8 @@
>   #include <uapi/linux/bpf.h>
>   
>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);	\
> +		((void)(struct bpf_struct_ops_##type *)0); }
>   #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>   
>   /* These need to be macros, as the expressions are used in assembler input */
> @@ -200,6 +202,7 @@ u32 btf_obj_id(const struct btf *btf);
>   bool btf_is_kernel(const struct btf *btf);
>   bool btf_is_module(const struct btf *btf);
>   struct module *btf_try_get_module(const struct btf *btf);
> +struct btf *btf_get_module_btf(const struct module *module);
>   u32 btf_nr_types(const struct btf *btf);
>   bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>   			   const struct btf_member *m,
> @@ -580,4 +583,28 @@ int btf_add_struct_ops(struct bpf_struct_ops *st_ops,
>   const struct bpf_struct_ops **
>   btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
>   
> +enum bpf_struct_ops_state {
> +	BPF_STRUCT_OPS_STATE_INIT,
> +	BPF_STRUCT_OPS_STATE_INUSE,
> +	BPF_STRUCT_OPS_STATE_TOBEFREE,
> +	BPF_STRUCT_OPS_STATE_READY,
> +};
> +
> +#define BPF_STRUCT_OPS_COMMON_VALUE			\
> +	refcount_t refcnt;				\
> +	enum bpf_struct_ops_state state
> +
> +/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
> + * the map's value exposed to the userspace and its btf-type-id is
> + * stored at the map->btf_vmlinux_value_type_id.
> + *
> + */
> +#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)			\
> +extern struct bpf_struct_ops bpf_##_name;			\
> +								\
> +struct bpf_struct_ops_##_name {					\
> +	BPF_STRUCT_OPS_COMMON_VALUE;				\
> +	struct _name data ____cacheline_aligned_in_smp;		\
> +};
> +
>   #endif
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 627cf1ea840a..cd688e9033b5 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -13,17 +13,6 @@
>   #include <linux/btf_ids.h>
>   #include <linux/rcupdate_wait.h>
>   
> -enum bpf_struct_ops_state {
> -	BPF_STRUCT_OPS_STATE_INIT,
> -	BPF_STRUCT_OPS_STATE_INUSE,
> -	BPF_STRUCT_OPS_STATE_TOBEFREE,
> -	BPF_STRUCT_OPS_STATE_READY,
> -};
> -
> -#define BPF_STRUCT_OPS_COMMON_VALUE			\
> -	refcount_t refcnt;				\
> -	enum bpf_struct_ops_state state
> -
>   struct bpf_struct_ops_value {
>   	BPF_STRUCT_OPS_COMMON_VALUE;
>   	char data[] ____cacheline_aligned_in_smp;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 3fb9964f8672..73d19ef99306 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7532,7 +7532,7 @@ struct module *btf_try_get_module(const struct btf *btf)
>   /* Returns struct btf corresponding to the struct module.
>    * This function can return NULL or ERR_PTR.
>    */
> -static struct btf *btf_get_module_btf(const struct module *module)
> +struct btf *btf_get_module_btf(const struct module *module)
>   {
>   #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>   	struct btf_module *btf_mod, *tmp;


