Return-Path: <bpf+bounces-12639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358477CEDB4
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 03:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4FD1C20E9D
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB30A49;
	Thu, 19 Oct 2023 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NHTDNQrB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752E65A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 01:49:15 +0000 (UTC)
Received: from out-207.mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72151112
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:49:11 -0700 (PDT)
Message-ID: <72104b12-4573-7f6d-183e-4761673329e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697680149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kJ1FC/30ukOvp+mxYXuhEadyJg35Ys0dgFah0ptykE=;
	b=NHTDNQrBcQnMD+BE/LG8BdNA3c7Hvo1ilu/pY2kqbqXuFQaejDlilQ/bSe2Gsqnb67A8s3
	JH02ddwuSYwJSPygEZm8p0frI1akYKXIfnFZI+rYHOL24arZd33QU39ixQqr/YyW2DWkCY
	PX2c92QhEpg6h7iYYrWwZ9tIoqO36L4=
Date: Wed, 18 Oct 2023 18:49:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 6/9] bpf, net: switch to dynamic registration
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-7-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231017162306.176586-7-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Replace the static list of struct_ops types with pre-btf struct_ops_tab to
> enable dynamic registration.
> 
> Both bpf_dummy_ops and bpf_tcp_ca now utilize the registration function
> instead of being listed in bpf_struct_ops_types.h.
> 
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h               |   2 +
>   include/linux/btf.h               |  29 +++++++
>   kernel/bpf/bpf_struct_ops.c       | 124 +++++++++++++++---------------
>   kernel/bpf/bpf_struct_ops_types.h |  12 ---
>   kernel/bpf/btf.c                  |   2 +-
>   net/bpf/bpf_dummy_struct_ops.c    |  14 +++-
>   net/ipv4/bpf_tcp_ca.c             |  16 +++-
>   7 files changed, 119 insertions(+), 80 deletions(-)
>   delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1e1647c8b0ce..b0f33147aa93 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3207,4 +3207,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>   	return prog->aux->func_idx != 0;
>   }
>   
> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
> +
>   #endif /* _LINUX_BPF_H */
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index aa2ba77648be..fdc83aa10462 100644
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
> @@ -577,4 +580,30 @@ int btf_add_struct_ops(struct bpf_struct_ops *st_ops);
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
> +struct bpf_struct_ops_common_value {
> +	refcount_t refcnt;
> +	enum bpf_struct_ops_state state;
> +};
> +#define BPF_STRUCT_OPS_COMMON_VALUE struct bpf_struct_ops_common_value common

Since there is 'struct bpf_struct_ops_common_value' now, the 
BPF_STRUCT_OPS_COMMON_VALUE macro is not as useful as before. Lets remove it.

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
> +}

I think the bpp_struct_ops_* should not be in btf.h. Probably move them to bpf.h 
instead. or there is some other considerations I am missing?

> +
>   #endif
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 60445ff32275..175068b083cb 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -13,19 +13,6 @@
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
> -struct bpf_struct_ops_common_value {
> -	refcount_t refcnt;
> -	enum bpf_struct_ops_state state;
> -};
> -#define BPF_STRUCT_OPS_COMMON_VALUE struct bpf_struct_ops_common_value common
> -
>   struct bpf_struct_ops_value {
>   	BPF_STRUCT_OPS_COMMON_VALUE;
>   	char data[] ____cacheline_aligned_in_smp;
> @@ -72,35 +59,6 @@ static DEFINE_MUTEX(update_mutex);
>   #define VALUE_PREFIX "bpf_struct_ops_"
>   #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
>   
> -/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
> - * the map's value exposed to the userspace and its btf-type-id is
> - * stored at the map->btf_vmlinux_value_type_id.
> - *
> - */
> -#define BPF_STRUCT_OPS_TYPE(_name)				\
> -extern struct bpf_struct_ops bpf_##_name;			\
> -								\
> -struct bpf_struct_ops_##_name {						\
> -	BPF_STRUCT_OPS_COMMON_VALUE;				\
> -	struct _name data ____cacheline_aligned_in_smp;		\
> -};
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -
> -enum {
> -#define BPF_STRUCT_OPS_TYPE(_name) BPF_STRUCT_OPS_TYPE_##_name,
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -	__NR_BPF_STRUCT_OPS_TYPE,
> -};
> -
> -static struct bpf_struct_ops * const bpf_struct_ops[] = {
> -#define BPF_STRUCT_OPS_TYPE(_name)				\
> -	[BPF_STRUCT_OPS_TYPE_##_name] = &bpf_##_name,
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -};
> -
>   const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
>   };
>   
> @@ -234,16 +192,51 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>   
>   }
>   
> +static int register_bpf_struct_ops_btf(struct bpf_struct_ops *st_ops,
> +				       struct btf *btf)

Please combine this function into register_bpf_struct_ops(). They are both very 
short.

> +{
> +	struct bpf_verifier_log *log;
> +	int err;
> +
> +	if (st_ops == NULL)
> +		return -EINVAL;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
> +	if (!log) {
> +		err = -ENOMEM;
> +		goto errout;
> +	}
> +
> +	log->level = BPF_LOG_KERNEL;
> +
> +	bpf_struct_ops_init_one(st_ops, btf, st_ops->owner, log);
> +
> +	err = btf_add_struct_ops(st_ops);
> +
> +errout:
> +	kfree(log);
> +
> +	return err;
> +}
> +
> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)

Similar to the register kfunc counterpart, can this be moved to btf.c instead by 
extern-ing bpf_struct_ops_init_one()? or there are some other structs/functions 
need to extern?

> +{
> +	struct btf *btf;
> +	int err;
> +
> +	btf = btf_get_module_btf(st_ops->owner);
> +	if (!btf)
> +		return -EINVAL;
> +	err = register_bpf_struct_ops_btf(st_ops, btf);
> +	btf_put(btf);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
> +
>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)

The bpf_struct_ops_init() is pretty much only finding the btf "module_id" and 
"common_value_id". Lets use the BTF_ID_LIST to do it instead. Then the newly 
added bpf_struct_ops_init_one() could use a proper name bpf_struct_ops_init() 
instead of having the special "_one" suffix.

>   {
> -	struct bpf_struct_ops *st_ops;
>   	s32 module_id, common_value_id;
> -	u32 i;
> -
> -	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
> -#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
>   
>   	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
>   	if (module_id < 0) {
> @@ -259,11 +252,6 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>   		return;
>   	}
>   	common_value_type = btf_type_by_id(btf, common_value_id);
> -
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		st_ops = bpf_struct_ops[i];
> -		bpf_struct_ops_init_one(st_ops, btf, NULL, log);
> -	}
>   }
>   
>   extern struct btf *btf_vmlinux;
> @@ -271,32 +259,44 @@ extern struct btf *btf_vmlinux;
>   static const struct bpf_struct_ops *
>   bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
>   {
> +	const struct bpf_struct_ops *st_ops = NULL;
> +	const struct bpf_struct_ops **st_ops_list;
>   	unsigned int i;
> +	u32 cnt = 0;
>   
>   	if (!value_id || !btf_vmlinux)

The "!btf_vmlinux" should have been changed to "!btf" in the earlier patch 
(patch 2?),

and is this null check still needed now?

>   		return NULL;
>   
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i]->value_id == value_id)
> -			return bpf_struct_ops[i];
> +	st_ops_list = btf_get_struct_ops(btf, &cnt);
> +	for (i = 0; i < cnt; i++) {
> +		if (st_ops_list[i]->value_id == value_id) {
> +			st_ops = st_ops_list[i];

nit. Like the change in the earlier patch that is being replaced here,
directly "return st_ops_list[i];".

> +			break;
> +		}
>   	}
>   
> -	return NULL;
> +	return st_ops;
>   }
>   
>   const struct bpf_struct_ops *bpf_struct_ops_find(struct btf *btf, u32 type_id)
>   {
> +	const struct bpf_struct_ops *st_ops = NULL;
> +	const struct bpf_struct_ops **st_ops_list;
>   	unsigned int i;
> +	u32 cnt;
>   
>   	if (!type_id || !btf_vmlinux)
>   		return NULL;
>   
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i]->type_id == type_id)
> -			return bpf_struct_ops[i];
> +	st_ops_list = btf_get_struct_ops(btf, &cnt);
> +	for (i = 0; i < cnt; i++) {
> +		if (st_ops_list[i]->type_id == type_id) {
> +			st_ops = st_ops_list[i];

Same.

> +			break;
> +		}
>   	}
>   
> -	return NULL;
> +	return st_ops;
>   }
>   
>   static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
> diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
> deleted file mode 100644
> index 5678a9ddf817..000000000000
> --- a/kernel/bpf/bpf_struct_ops_types.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* internal file - do not include directly */
> -
> -#ifdef CONFIG_BPF_JIT
> -#ifdef CONFIG_NET
> -BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
> -#endif
> -#ifdef CONFIG_INET
> -#include <net/tcp.h>
> -BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
> -#endif
> -#endif

Seeing this gone is satisfying.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index be5144dbb53d..990973d6057d 100644
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
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index 5918d1b32e19..724bb7224079 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -7,7 +7,7 @@
>   #include <linux/bpf.h>
>   #include <linux/btf.h>
>   
> -extern struct bpf_struct_ops bpf_bpf_dummy_ops;
> +static struct bpf_struct_ops bpf_bpf_dummy_ops;

Is it still needed ?




