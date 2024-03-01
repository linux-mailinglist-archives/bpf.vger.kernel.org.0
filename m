Return-Path: <bpf+bounces-23115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B886DBB7
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA6C28873D
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 06:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BEF6994B;
	Fri,  1 Mar 2024 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lrTdj711"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F869945
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275999; cv=none; b=dzTYGqRlDzZaniQ8FVwjiOIh6QLETb462UwmeeAjMVpWyQO1zXPl9iEZSSkhium40p1/iAqefhCXyrhFAF5jmR2KDUFVrn/uxUE1jTpoGfHTSkblj3ndbaZQgPoTa+1GbPux06iJAH2pOwv1Ys7RfLj/M9cdr0d2nmJsTc4jo/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275999; c=relaxed/simple;
	bh=e+pGzNnI82Ylax5Vbf1gmtIlH2eMeT6fQCrZkrOgc3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcOO3TaVbMyuGlRoMSC75lpCA4iPbzpBbpjtSbamdVIRH0ByMZ+2QHrkddXAKZa1kc/BaycneOXT5+XQTbb5HwpG4EO2wI7Z0r2aKVR5L69LAr1MJlFMUYdGNaDGRWkL5OwoH6fV7QYM9oXjaEgM22xUpcG2b6lNYjZ9hMAq+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lrTdj711; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709275992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wo9twMGICbdoOxyQ6GLsYx/nQhq0DMpbpqjiav0rSys=;
	b=lrTdj711iELnXJBNzGvwxNdbSk16vCcaQrbncv69xaOFDBMKIMXBxhJTACubpXq1M9uUyH
	zDj+sQjm/0RjnjAUv0oVd60P/CTE1hwivpSLfxsnNnJoNs8IeJqfMkLSpy/s0zP50LwsZh
	R37/rgQZhRRUcnHYS1yLVz5nVCrpeR8=
Date: Thu, 29 Feb 2024 22:53:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v12 14/15] p4tc: add set of P4TC table kfuncs
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net,
 victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240225165447.156954-1-jhs@mojatatu.com>
 <20240225165447.156954-15-jhs@mojatatu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240225165447.156954-15-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/25/24 8:54 AM, Jamal Hadi Salim wrote:
> +struct p4tc_table_entry_act_bpf_params {

Will this struct be extended in the future?

> +	u32 pipeid;
> +	u32 tblid;
> +};
> +
> +struct p4tc_table_entry_create_bpf_params {
> +	u32 profile_id;
> +	u32 pipeid;
> +	u32 tblid;
> +};
> +

[ ... ]

> diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
> index c5256d821..155068de0 100644
> --- a/include/net/tc_act/p4tc.h
> +++ b/include/net/tc_act/p4tc.h
> @@ -13,10 +13,26 @@ struct tcf_p4act_params {
>   	u32 tot_params_sz;
>   };
>   
> +#define P4TC_MAX_PARAM_DATA_SIZE 124
> +
> +struct p4tc_table_entry_act_bpf {
> +	u32 act_id;
> +	u32 hit:1,
> +	    is_default_miss_act:1,
> +	    is_default_hit_act:1;
> +	u8 params[P4TC_MAX_PARAM_DATA_SIZE];
> +} __packed;
> +
> +struct p4tc_table_entry_act_bpf_kern {
> +	struct rcu_head rcu;
> +	struct p4tc_table_entry_act_bpf act_bpf;
> +};
> +
>   struct tcf_p4act {
>   	struct tc_action common;
>   	/* Params IDR reference passed during runtime */
>   	struct tcf_p4act_params __rcu *params;
> +	struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
>   	u32 p_id;
>   	u32 act_id;
>   	struct list_head node;
> @@ -24,4 +40,39 @@ struct tcf_p4act {
>   
>   #define to_p4act(a) ((struct tcf_p4act *)a)
>   
> +static inline struct p4tc_table_entry_act_bpf *
> +p4tc_table_entry_act_bpf(struct tc_action *action)
> +{
> +	struct p4tc_table_entry_act_bpf_kern *act_bpf;
> +	struct tcf_p4act *p4act = to_p4act(action);
> +
> +	act_bpf = rcu_dereference(p4act->act_bpf);
> +
> +	return &act_bpf->act_bpf;
> +}
> +
> +static inline int
> +p4tc_table_entry_act_bpf_change_flags(struct tc_action *action, u32 hit,
> +				      u32 dflt_miss, u32 dflt_hit)
> +{
> +	struct p4tc_table_entry_act_bpf_kern *act_bpf, *act_bpf_old;
> +	struct tcf_p4act *p4act = to_p4act(action);
> +
> +	act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL);


[ ... ]

> +__bpf_kfunc static struct p4tc_table_entry_act_bpf *
> +bpf_p4tc_tbl_read(struct __sk_buff *skb_ctx,

The argument could be "struct sk_buff *skb" instead of __sk_buff. Take a look at 
commit 2f4643934670.

> +		  struct p4tc_table_entry_act_bpf_params *params,
> +		  void *key, const u32 key__sz)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct net *caller_net;
> +
> +	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> +
> +	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
> +}
> +
> +__bpf_kfunc static struct p4tc_table_entry_act_bpf *
> +xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
> +		  struct p4tc_table_entry_act_bpf_params *params,
> +		  void *key, const u32 key__sz)
> +{
> +	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
> +	struct net *caller_net;
> +
> +	caller_net = dev_net(ctx->rxq->dev);
> +
> +	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
> +}
> +
> +static int
> +__bpf_p4tc_entry_create(struct net *net,
> +			struct p4tc_table_entry_create_bpf_params *params,
> +			void *key, const u32 key__sz,
> +			struct p4tc_table_entry_act_bpf *act_bpf)
> +{
> +	struct p4tc_table_entry_key *entry_key = key;
> +	struct p4tc_pipeline *pipeline;
> +	struct p4tc_table *table;
> +
> +	if (!params || !key)
> +		return -EINVAL;
> +	if (key__sz != P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
> +		return -EINVAL;
> +
> +	pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
> +	if (!pipeline)
> +		return -ENOENT;
> +
> +	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
> +	if (!table)
> +		return -ENOENT;
> +
> +	if (entry_key->keysz != table->tbl_keysz)
> +		return -EINVAL;
> +
> +	return p4tc_table_entry_create_bpf(pipeline, table, entry_key, act_bpf,
> +					   params->profile_id);

My understanding is this kfunc will allocate a "struct 
p4tc_table_entry_act_bpf_kern" object. If the bpf_p4tc_entry_delete() kfunc is 
never called and the bpf prog is unloaded, how the act_bpf object will be 
cleaned up?

> +}
> +
> +__bpf_kfunc static int
> +bpf_p4tc_entry_create(struct __sk_buff *skb_ctx,
> +		      struct p4tc_table_entry_create_bpf_params *params,
> +		      void *key, const u32 key__sz,
> +		      struct p4tc_table_entry_act_bpf *act_bpf)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct net *net;
> +
> +	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> +
> +	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
> +}
> +
> +__bpf_kfunc static int
> +xdp_p4tc_entry_create(struct xdp_md *xdp_ctx,
> +		      struct p4tc_table_entry_create_bpf_params *params,
> +		      void *key, const u32 key__sz,
> +		      struct p4tc_table_entry_act_bpf *act_bpf)
> +{
> +	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
> +	struct net *net;
> +
> +	net = dev_net(ctx->rxq->dev);
> +
> +	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
> +}
> +
> +__bpf_kfunc static int
> +bpf_p4tc_entry_create_on_miss(struct __sk_buff *skb_ctx,
> +			      struct p4tc_table_entry_create_bpf_params *params,
> +			      void *key, const u32 key__sz,
> +			      struct p4tc_table_entry_act_bpf *act_bpf)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct net *net;
> +
> +	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> +
> +	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
> +}
> +
> +__bpf_kfunc static int
> +xdp_p4tc_entry_create_on_miss(struct xdp_md *xdp_ctx,

Same here. "struct xdp_buff *xdp".

> +			      struct p4tc_table_entry_create_bpf_params *params,
> +			      void *key, const u32 key__sz,
> +			      struct p4tc_table_entry_act_bpf *act_bpf)
> +{
> +	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
> +	struct net *net;
> +
> +	net = dev_net(ctx->rxq->dev);
> +
> +	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
> +}
> +

[ ... ]

> +__bpf_kfunc static int
> +bpf_p4tc_entry_delete(struct __sk_buff *skb_ctx,
> +		      struct p4tc_table_entry_create_bpf_params *params,
> +		      void *key, const u32 key__sz)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct net *net;
> +
> +	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> +
> +	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
> +}
> +
> +__bpf_kfunc static int
> +xdp_p4tc_entry_delete(struct xdp_md *xdp_ctx,
> +		      struct p4tc_table_entry_create_bpf_params *params,
> +		      void *key, const u32 key__sz)
> +{
> +	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
> +	struct net *net;
> +
> +	net = dev_net(ctx->rxq->dev);
> +
> +	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
> +}
> +
> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)

This soon will be broken with the latest change in bpf-next. It is replaced by 
BTF_KFUNCS_START. commit a05e90427ef6.

What is the plan on the selftest ?

> +BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
> +BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
> +BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
> +BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
> +
> +static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_skb = {
> +	.owner = THIS_MODULE,
> +	.set = &p4tc_kfunc_check_tbl_set_skb,
> +};
> +
> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_xdp)
> +BTF_ID_FLAGS(func, xdp_p4tc_tbl_read, KF_RET_NULL);
> +BTF_ID_FLAGS(func, xdp_p4tc_entry_create);
> +BTF_ID_FLAGS(func, xdp_p4tc_entry_create_on_miss);
> +BTF_ID_FLAGS(func, xdp_p4tc_entry_update);
> +BTF_ID_FLAGS(func, xdp_p4tc_entry_delete);
> +BTF_SET8_END(p4tc_kfunc_check_tbl_set_xdp)


