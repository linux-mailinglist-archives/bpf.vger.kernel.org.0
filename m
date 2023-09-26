Return-Path: <bpf+bounces-10823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DDA7AE2BB
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 02:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D4A762816CE
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBAE15BB;
	Tue, 26 Sep 2023 00:02:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA917FE
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 00:02:35 +0000 (UTC)
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A5FB
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:02:33 -0700 (PDT)
Message-ID: <cc0aa287-e4de-13fe-1727-b1e0e8dbc3ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695686551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtht82d0HgcHlp6Eo3ZPjzuEwcszjGYcBhLvh9DnSl8=;
	b=AtbqQtEkHT1S5GJ5htEXAe3KbBdRbBkg6I/de9UL2WfUOSH8LAgiQlNvDgtD/ufO21/KPi
	WdF/szVCzkEjmR51C+8RuZSPkpJwfXLAiy1mSK4qAytgSLmF+9tLXITUulUB0LTHAdd3Rh
	qLUhxcAvzjHhzCJfXpcGb4rNtzfDR7k=
Date: Mon, 25 Sep 2023 17:02:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 07/11] bpf, net: switch to storing struct_ops in
 btf
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-8-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-8-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Use struct_ops registered and stored in module btf instead of static ones.
> 
> Both bpf_dummy_ops and bpf_tcp_ca switches to calling the registration
> function instead of listed in bpf_struct_ops_types.h.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c       | 114 ++++++++++++++++++------------
>   kernel/bpf/bpf_struct_ops_types.h |  12 ----
>   net/bpf/bpf_dummy_struct_ops.c    |  12 +++-
>   net/ipv4/bpf_tcp_ca.c             |  20 +++++-
>   4 files changed, 94 insertions(+), 64 deletions(-)
>   delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index fb684d2ee99d..8b5c859377e9 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -59,35 +59,6 @@ static DEFINE_MUTEX(update_mutex);
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
> @@ -264,14 +235,11 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>   
>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>   {
> -	struct bpf_struct_ops *st_ops;
> +#if defined(CONFIG_BPF_JIT) && defined(CONFIG_NET)
> +	extern struct bpf_struct_ops_mod bpf_testmod_struct_ops;
> +	int ret;
> +#endif
>   	s32 module_id;
> -	u32 i;
> -
> -	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
> -#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
>   
>   	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
>   	if (module_id < 0) {
> @@ -280,43 +248,95 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>   	}
>   	module_type = btf_type_by_id(btf, module_id);
>   
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		st_ops = bpf_struct_ops[i];
> -		bpf_struct_ops_init_one(st_ops, btf, log);
> +#if defined(CONFIG_BPF_JIT) && defined(CONFIG_NET)
> +	ret = register_bpf_struct_ops(&bpf_testmod_struct_ops);

What is stopping the 'register_bpf_struct_ops(&bpf_testmod_struct_ops)' to be 
done in bpf_dummy_struct_ops.c instead of here?

I am hoping bpf_dummy_struct_ops.c can eventually be moved out to 
bpf_testmod_struct_ops.c but it is better to leave it as a followup later.

> +	if (ret)
> +		pr_warn("Cannot register bpf_testmod_struct_ops\n");
> +#endif
> +}
> +
> +int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
> +{
> +	struct bpf_struct_ops *st_ops = mod->st_ops;
> +	struct bpf_verifier_log *log;
> +	struct btf *btf;
> +	int err;
> +
> +	if (mod->st_ops == NULL ||
> +	    mod->owner == NULL)
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
> +	btf = btf_get_module_btf(mod->owner);
> +	if (!btf) {
> +		err = -EINVAL;
> +		goto errout;
>   	}
> +
> +	bpf_struct_ops_init_one(st_ops, btf, log);
> +
> +	btf_put(btf);
> +
> +	st_ops->owner = mod->owner;
> +	err = btf_add_struct_ops(st_ops, st_ops->owner);
> +
> +errout:
> +	kfree(log);
> +
> +	return err;
>   }
> +EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
>   
>   extern struct btf *btf_vmlinux;
>   
>   static const struct bpf_struct_ops *
>   bpf_struct_ops_find_value(u32 value_id, struct btf *btf)
>   {
> +	const struct bpf_struct_ops *st_ops = NULL;
> +	const struct bpf_struct_ops **st_ops_list;
>   	unsigned int i;
> +	u32 cnt = 0;
>   
>   	if (!value_id || !btf_vmlinux)
>   		return NULL;
>   
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i]->value_id == value_id)
> -			return bpf_struct_ops[i];
> +	st_ops_list = btf_get_struct_ops(btf, &cnt);
> +	for (i = 0; i < cnt; i++) {
> +		if (st_ops_list[i]->value_id == value_id) {
> +			st_ops = st_ops_list[i];
> +			break;
> +		}
>   	}
>   
> -	return NULL;
> +	return st_ops;
>   }
>   
>   const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf)
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
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index 5918d1b32e19..9cb982c67c4c 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -7,7 +7,7 @@
>   #include <linux/bpf.h>
>   #include <linux/btf.h>
>   
> -extern struct bpf_struct_ops bpf_bpf_dummy_ops;
> +static struct bpf_struct_ops bpf_bpf_dummy_ops;
>   
>   /* A common type for test_N with return value in bpf_dummy_ops */
>   typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
> @@ -218,9 +218,12 @@ static int bpf_dummy_reg(void *kdata)
>   
>   static void bpf_dummy_unreg(void *kdata)
>   {
> +	BTF_STRUCT_OPS_TYPE_EMIT(bpf_dummy_ops);
>   }
>   
> -struct bpf_struct_ops bpf_bpf_dummy_ops = {
> +DEFINE_STRUCT_OPS_VALUE_TYPE(bpf_dummy_ops);
> +
> +static struct bpf_struct_ops bpf_bpf_dummy_ops = {
>   	.verifier_ops = &bpf_dummy_verifier_ops,
>   	.init = bpf_dummy_init,
>   	.check_member = bpf_dummy_ops_check_member,
> @@ -229,3 +232,8 @@ struct bpf_struct_ops bpf_bpf_dummy_ops = {
>   	.unreg = bpf_dummy_unreg,
>   	.name = "bpf_dummy_ops",
>   };
> +
> +struct bpf_struct_ops_mod bpf_testmod_struct_ops = {
> +	.st_ops = &bpf_bpf_dummy_ops,
> +	.owner = THIS_MODULE,
> +};
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 39dcccf0f174..9947323f3e22 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -12,7 +12,7 @@
>   #include <net/bpf_sk_storage.h>
>   
>   /* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
> -extern struct bpf_struct_ops bpf_tcp_congestion_ops;
> +static struct bpf_struct_ops bpf_tcp_congestion_ops;
>   
>   static u32 unsupported_ops[] = {
>   	offsetof(struct tcp_congestion_ops, get_info),
> @@ -271,7 +271,9 @@ static int bpf_tcp_ca_validate(void *kdata)
>   	return tcp_validate_congestion_control(kdata);
>   }
>   
> -struct bpf_struct_ops bpf_tcp_congestion_ops = {
> +DEFINE_STRUCT_OPS_VALUE_TYPE(tcp_congestion_ops);
> +
> +static struct bpf_struct_ops bpf_tcp_congestion_ops = {
>   	.verifier_ops = &bpf_tcp_ca_verifier_ops,
>   	.reg = bpf_tcp_ca_reg,
>   	.unreg = bpf_tcp_ca_unreg,
> @@ -283,8 +285,20 @@ struct bpf_struct_ops bpf_tcp_congestion_ops = {
>   	.name = "tcp_congestion_ops",
>   };
>   
> +static struct bpf_struct_ops_mod bpf_tcp_ca_ops_mod = {
> +	.st_ops = &bpf_tcp_congestion_ops,
> +	.owner = THIS_MODULE,
> +};
> +
>   static int __init bpf_tcp_ca_kfunc_init(void)
>   {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
> +	int ret;
> +
> +	BTF_STRUCT_OPS_TYPE_EMIT(tcp_congestion_ops);
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
> +	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_ca_ops_mod);
> +
> +	return ret;
>   }
>   late_initcall(bpf_tcp_ca_kfunc_init);


