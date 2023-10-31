Return-Path: <bpf+bounces-13693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192837DC6A5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4AFB20E57
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7853A5;
	Tue, 31 Oct 2023 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mr9gplBV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6686360
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:36:34 +0000 (UTC)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6912A
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:36:30 -0700 (PDT)
Message-ID: <183fd964-8910-b7e6-436a-f5f82c2bafb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698734188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7rytP9Jz8YlmuSewihEAlGNyDdVt5rkOQstx/lEPqc=;
	b=Mr9gplBV4ORlK13ct73jtd1Z5YcxSlSxPpTf2SibdlJmLT4kxfkx0CNVh+Ig6FYc0xNU0W
	2nTnEDzAVjk2DMuDb0sdo7tEjxY05irZhyxQb0mTnXlhQ3LEXns4vQF6h58h7A0OVPcZ/l
	aXNr7Id53e7tLyhlWvBXAK83aHiP1+8=
Date: Mon, 30 Oct 2023 23:36:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 07/10] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-8-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231030192810.382942-8-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Replace the static list of struct_ops types with per-btf struct_ops_tab to
> enable dynamic registration.
> 
> Both bpf_dummy_ops and bpf_tcp_ca now utilize the registration function
> instead of being listed in bpf_struct_ops_types.h.
> 
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h               |  36 ++++++--
>   include/linux/btf.h               |   5 +-
>   kernel/bpf/bpf_struct_ops.c       | 140 +++++++++---------------------
>   kernel/bpf/bpf_struct_ops_types.h |  12 ---
>   kernel/bpf/btf.c                  |  41 ++++++++-
>   net/bpf/bpf_dummy_struct_ops.c    |  14 ++-
>   net/ipv4/bpf_tcp_ca.c             |  16 +++-
>   7 files changed, 140 insertions(+), 124 deletions(-)
>   delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c993df3cf699..9d7105ff06db 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1644,7 +1644,6 @@ struct bpf_struct_ops_desc {
>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
>   const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>   bool bpf_struct_ops_get(const void *kdata);
>   void bpf_struct_ops_put(const void *kdata);
>   int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
> @@ -1690,10 +1689,6 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
>   {
>   	return NULL;
>   }
> -static inline void bpf_struct_ops_init(struct btf *btf,
> -				       struct bpf_verifier_log *log)
> -{
> -}
>   static inline bool bpf_try_module_get(const void *data, struct module *owner)
>   {
>   	return try_module_get(owner);
> @@ -3232,4 +3227,35 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>   	return prog->aux->func_idx != 0;
>   }
>   
> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
> +
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
> +	struct bpf_struct_ops_common_value common;		\
> +	struct _name data ____cacheline_aligned_in_smp;		\
> +}
> +
> +extern int bpf_struct_ops_init(struct bpf_struct_ops_desc *st_ops_desc,
> +			       struct btf *btf,
> +			       struct bpf_verifier_log *log);
> +
>   #endif /* _LINUX_BPF_H */
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index a8813605f2f6..954536431e0b 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -12,6 +12,8 @@
>   #include <uapi/linux/bpf.h>
>   
>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);	\

((void)(struct type *)0); is new. Why is it needed?

> +		((void)(struct bpf_struct_ops_##type *)0); }
>   #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>   
>   /* These need to be macros, as the expressions are used in assembler input */
> @@ -201,6 +203,7 @@ u32 btf_obj_id(const struct btf *btf);
>   bool btf_is_kernel(const struct btf *btf);
>   bool btf_is_module(const struct btf *btf);
>   struct module *btf_try_get_module(const struct btf *btf);
> +struct btf *btf_get_module_btf(const struct module *module);
>   u32 btf_nr_types(const struct btf *btf);
>   bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>   			   const struct btf_member *m,
> @@ -575,8 +578,6 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
>   struct bpf_struct_ops;
>   struct bpf_struct_ops_desc;
>   
> -struct bpf_struct_ops_desc *
> -btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops);
>   const struct bpf_struct_ops_desc *
>   btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
>   
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index db2bbba50e38..f3ec72be9c63 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -13,21 +13,8 @@
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
> -	BPF_STRUCT_OPS_COMMON_VALUE;
> +	struct bpf_struct_ops_common_value common;

This cleanup is good. It should have been done together in patch 5 instead when 
refcnt and state were grouped into a new 'struct bpf_struct_ops_common_value'.

>   	char data[] ____cacheline_aligned_in_smp;
>   };
>   
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
> -static struct bpf_struct_ops_desc bpf_struct_ops[] = {
> -#define BPF_STRUCT_OPS_TYPE(_name)				\
> -	[BPF_STRUCT_OPS_TYPE_##_name] = { .st_ops = &bpf_##_name },
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -};
> -
>   const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
>   };
>   
> @@ -110,13 +68,22 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
>   #endif
>   };
>   
> -static const struct btf_type *module_type;
> -static const struct btf_type *common_value_type;
> +BTF_ID_LIST(st_ops_ids)
> +BTF_ID(struct, module)
> +BTF_ID(struct, bpf_struct_ops_common_value)

This should have been done in a separated patch immediately after patch 1. The 
patch 7 has unrelated changes/cleanups like this and the above 
BPF_STRUCT_OPS_COMMON_VALUE which could have been done earlier as preparation 
patches instead of packing them together with the main change here: "switch to 
dynamic registration". The commit message for the BTF_ID_LIST changes could be 
like: "A preparation to completely retire the bpf_struct_ops_init() function in 
the latter patch...".

> +
> +enum {
> +	idx_module_id,
> +	idx_st_ops_common_value_id,

nit. upper case to stay consistent with other similar usages.

> +};
> +

[ ... ]

> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
> +{
> +	struct bpf_struct_ops_desc *desc;
> +	struct bpf_verifier_log *log;
> +	struct btf *btf;
> +	int err = 0;
> +
> +	if (st_ops == NULL)

NULL check is not needed. caller will never do that. If it really wanted to try, 
other values would have similar effect.

> +		return -EINVAL;
> +
> +	btf = btf_get_module_btf(st_ops->owner);
> +	if (!btf)
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
> +	desc = btf_add_struct_ops(btf, st_ops);
> +	if (IS_ERR(desc)) {
> +		err = PTR_ERR(desc);
> +		goto errout;
> +	}
> +
> +	err = bpf_struct_ops_init(desc, btf, log);

When bpf_struct_ops_init() returns err, desc is in btf_struct_ops_tab but it is 
in an uninitialized state. May be do the bpf_struct_ops_init() in 
btf_add_struct_ops() and only increment struct_ops_tab->cnt when everything is 
correct.

> +
> +errout:
> +	kfree(log);
> +	btf_put(btf);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(register_bpf_struct_ops);



