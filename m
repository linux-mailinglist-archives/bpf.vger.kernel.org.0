Return-Path: <bpf+bounces-47309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824979F75CB
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A6118939F0
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6EE1FBC94;
	Thu, 19 Dec 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OpSItvB0"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9361F63EC
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593862; cv=none; b=BASTPsWQQQidIiY/zL/n0eFHejS9dj/GIEnmsacDYSTVfnuJEqnXhC6QSmOyjEyaeQudYxK2hbYR/PMGBqqorRgU75X4m4BtnUT5JNlc7/uYQclyBdeCNTqyQHd3l8dIRmA84E7V78u82I1vFwJrR+DniMuz0qGEfNbGymCmth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593862; c=relaxed/simple;
	bh=zPGg0my8EWh8N9SSPWrRprpEQbBxxD8yrY5cWQZ7Www=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DouAt/nu47nq22Xb5vWAcGC4SlihqjIR7bSLeLdHr1HpR1HSnQ4ks5Uxqyf5Ea6IOnFzfymTLaYY+MI5XHg1w2Zc3Ztwsdub/SWZO8fWvv9upieGalpSGUcQsZRER7+dSZXix3/UlrpS5wVfRJXEiHmR9yvan9l/f5K2mGovg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OpSItvB0; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd856afb-7ff5-4928-8ba1-22e68c0913e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734593856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Vn7l2vsh26+Lf6JekEaZijnSqWM10IV/0pzrMuAGlA=;
	b=OpSItvB0dI2aeNnJIKdaQT0PVbEhjxzFyXhVmIkdWKpyUKJBtSqhC79BwbhYTR0sUy4z35
	9NzyPDO9Mie54XXELc7ZVYYcTC1suYf4bue3vI1CC+GZW4PAuycATURpLjCcO8lSUfmdK/
	vNB/xCjYEPqBo+drfKcgUkCgBpZXz4s=
Date: Wed, 18 Dec 2024 23:37:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 06/13] bpf: net_sched: Add basic bpf qdisc
 kfuncs
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 ameryhung@gmail.com
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-7-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241213232958.2388301-7-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 3:29 PM, Amery Hung wrote:
> Add basic kfuncs for working on skb in qdisc.
> 
> Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
> a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
> in .enqueue where a to_free skb list is available from kernel to defer
> the release. bpf_kfree_skb() should be used elsewhere. It is also used
> in bpf_obj_free_fields() when cleaning up skb in maps and collections.
> 
> bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> to build flow-based queueing algorithms.
> 
> Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb().
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   net/sched/bpf_qdisc.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index a2e2db29e5fc..28959424eab0 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -106,6 +106,67 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
>   	return 0;
>   }
>   
> +__bpf_kfunc_start_defs();
> +
> +/* bpf_skb_get_hash - Get the flow hash of an skb.
> + * @skb: The skb to get the flow hash from.
> + */
> +__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
> +{
> +	return skb_get_hash(skb);
> +}
> +
> +/* bpf_kfree_skb - Release an skb's reference and drop it immediately.
> + * @skb: The skb whose reference to be released and dropped.
> + */
> +__bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
> +{
> +	kfree_skb(skb);
> +}
> +
> +/* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
> + * @skb: The skb whose reference to be released and dropped.
> + * @to_free_list: The list of skbs to be dropped.
> + */
> +__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
> +				    struct bpf_sk_buff_ptr *to_free_list)
> +{
> +	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +#define BPF_QDISC_KFUNC_xxx \
> +	BPF_QDISC_KFUNC(bpf_skb_get_hash, KF_TRUSTED_ARGS) \
> +	BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
> +	BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
> +
> +BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
> +#define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
> +BPF_QDISC_KFUNC_xxx
> +#undef BPF_QDISC_KFUNC
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_qdisc_kfunc_ids)
> +
> +#define BPF_QDISC_KFUNC(name, _) BTF_ID_LIST_SINGLE(name##_ids, func, name)


> +BPF_QDISC_KFUNC_xxx
> +#undef BPF_QDISC_KFUNC
> +
> +static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (kfunc_id == bpf_qdisc_skb_drop_ids[0])
> +		if (strcmp(prog->aux->attach_func_name, "enqueue"))

The kfunc is registered for all BPF_PROG_TYPE_STRUCT_OPS. Checking func_name 
alone is not enough, e.g. another future struct_ops may have the "enqueue" ops.

Checking the btf type of "struct Qdisc_ops" is better. Something like the 
following (untested):

diff --git i/include/linux/bpf.h w/include/linux/bpf.h
index c81ac98db439..cf3133f81e7f 100644
--- i/include/linux/bpf.h
+++ w/include/linux/bpf.h
@@ -1809,6 +1809,7 @@ struct bpf_struct_ops {
  	void *cfi_stubs;
  	struct module *owner;
  	const char *name;
+	const struct btf_type *type;
  	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
  };

diff --git i/kernel/bpf/bpf_struct_ops.c w/kernel/bpf/bpf_struct_ops.c
index d9e0af00580b..5c2ca5a84384 100644
--- i/kernel/bpf/bpf_struct_ops.c
+++ w/kernel/bpf/bpf_struct_ops.c
@@ -432,6 +432,8 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc 
*st_ops_desc,
  		goto errout;
  	}

+	st_ops->type = t;
+
  	return 0;

  errout:
diff --git i/net/sched/bpf_qdisc.c w/net/sched/bpf_qdisc.c
index 1caa9f696d2d..94e45ea59fef 100644
--- i/net/sched/bpf_qdisc.c
+++ w/net/sched/bpf_qdisc.c
@@ -250,6 +250,11 @@ BPF_QDISC_KFUNC_xxx

  static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
  {
+
+	if (bpf_Qdisc_ops.type != btf_type_by_id(prog->aux->attach_btf,
+						 prog->aux->attach_btf_id))
+		return -EACCES;
+
  	if (kfunc_id == bpf_qdisc_skb_drop_ids[0]) {
  		if (strcmp(prog->aux->attach_func_name, "enqueue"))
  			return -EACCES;


st_ops->type (and a few others) was refactored to bpf_struct_ops_desc when 
adding the kernel module support. I think adding st_ops->type back should be enough.

Also, a bike shedding here, from looking at patch 7 and patch 8 which limit a 
set of kfuncs to a particular ops. I think using btf_id_set_contains() is more 
inline to other verifier usages.

BTF_SET_START(qdisc_enqueue_kfunc_set)
BTF_ID(func, bpf_qdisc_skb_drop)
BTF_ID(func, bpf_qdisc_watchdog_schedule)
BTF_SET_END(qdisc_enqueue_kfunc_set)

BTF_SET_START(qdisc_dequeue_kfunc_set)
BTF_ID(func, bpf_qdisc_bstats_update)
BTF_ID(func, bpf_qdisc_watchdog_schedule)
BTF_SET_END(qdisc_dequeue_kfunc_set)

BTF_SET_START(qdisc_common_kfunc_set)
BTF_ID(func, bpf_skb_get_hash)
BTF_ID(func, bpf_kfree_skb)
BTF_SET_END(qdisc_common_kfunc_set)

> +			return -EACCES;
> +
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_qdisc_kfunc_ids,
> +	.filter = bpf_qdisc_kfunc_filter,
> +};
> +
>   static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
>   	.get_func_proto		= bpf_qdisc_get_func_proto,
>   	.is_valid_access	= bpf_qdisc_is_valid_access,
> @@ -209,6 +270,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
>   
>   static int __init bpf_qdisc_kfunc_init(void)
>   {
> -	return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
> +	int ret;
> +	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
> +		{
> +			.btf_id       = bpf_sk_buff_ids[0],
> +			.kfunc_btf_id = bpf_kfree_skb_ids[0]
> +		},
> +	};
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_qdisc_kfunc_set);
> +	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> +						 ARRAY_SIZE(skb_kfunc_dtors),
> +						 THIS_MODULE);
> +	ret = ret ?: register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
> +
> +	return ret;
>   }
>   late_initcall(bpf_qdisc_kfunc_init);


