Return-Path: <bpf+bounces-23257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116786F340
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 02:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF53A28440D
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C1A2CA5;
	Sun,  3 Mar 2024 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKNI81nI"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30017FD
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709429578; cv=none; b=sWIExcnDGqryvptTzHZiTGePTuuTEDLhhzTkBIJJUx7TghBfBqa3AvaS+swxdooZM0u+ACvlZ6hFFqEkgWtW57l2pWLRz94r2npkHDBBkXqlZLh5bMvqBlzjDryrkyZuUw5yZ75zReK11rRIhBnMqNZOR/ODeixcoIsrsrS5Htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709429578; c=relaxed/simple;
	bh=IylH3m+cHRJZ4YXYafo3lkVoSQgVcmUJ7A+fcaZpHlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgNGpAZoe0kTMD6eMFhPZSAlZZOUtJjLh0xQjrE5dKj0P8qEH3CYzZKXlVipFfDJ4FWWr+iGsb+5LmB/yr7YdeHjoavGfYaZd6CfSuXlNhHO0GN4k0H//CNKzS3GZBGaHxgMbw92vx6iX/zz4u7EgGnkxl3pZoLZwwxUKSQAOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKNI81nI; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f88b5f65-957e-4b5d-8959-d16e79372658@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709429573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/EYWu62tI2U5I+uQtQ7jK0OywLWaXMVjw053AZzpVQE=;
	b=pKNI81nI3zL9rwQIIFVyYvg9FaTzITPuv1EyaU3BO+1aSDZ7jlsZywv6M6/lovMVw/PVeQ
	78mT+NuihMLsUZDEo16X+PfRw0/mseQCors9VyqkJDO3sKvKhsGdfJCOsMueFmMg2k3keD
	aIyALcwxCn3QpvmU0b1lqOBLDfPfdGs=
Date: Sat, 2 Mar 2024 17:32:42 -0800
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
 <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev>
 <CAM0EoMniOaKn4W_WN9rmQZ1JY3qCugn34mmqCy9UdCTAj_tuTQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAM0EoMniOaKn4W_WN9rmQZ1JY3qCugn34mmqCy9UdCTAj_tuTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/1/24 4:31 AM, Jamal Hadi Salim wrote:
> On Fri, Mar 1, 2024 at 1:53 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/25/24 8:54 AM, Jamal Hadi Salim wrote:
>>> +struct p4tc_table_entry_act_bpf_params {
>>
>> Will this struct be extended in the future?
>>
>>> +     u32 pipeid;
>>> +     u32 tblid;
>>> +};
>>> +
> 
> Not that i can think of. We probably want to have the option to do so
> if needed. Do you see any harm if we were to make changes for whatever
> reason in the future?

It will be useful to add an argument named with "__sz" suffix to the kfunc.
Take a look at how the kfunc in nf_conntrack_bpf.c is handling the "opts" and 
"opts__sz" argument in its kfunc.

> 
>>> +struct p4tc_table_entry_create_bpf_params {
>>> +     u32 profile_id;
>>> +     u32 pipeid;
>>> +     u32 tblid;
>>> +};
>>> +
>>
>> [ ... ]
>>
>>> diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
>>> index c5256d821..155068de0 100644
>>> --- a/include/net/tc_act/p4tc.h
>>> +++ b/include/net/tc_act/p4tc.h
>>> @@ -13,10 +13,26 @@ struct tcf_p4act_params {
>>>        u32 tot_params_sz;
>>>    };
>>>
>>> +#define P4TC_MAX_PARAM_DATA_SIZE 124
>>> +
>>> +struct p4tc_table_entry_act_bpf {
>>> +     u32 act_id;
>>> +     u32 hit:1,
>>> +         is_default_miss_act:1,
>>> +         is_default_hit_act:1;
>>> +     u8 params[P4TC_MAX_PARAM_DATA_SIZE];
>>> +} __packed;
>>> +
>>> +struct p4tc_table_entry_act_bpf_kern {
>>> +     struct rcu_head rcu;
>>> +     struct p4tc_table_entry_act_bpf act_bpf;
>>> +};
>>> +
>>>    struct tcf_p4act {
>>>        struct tc_action common;
>>>        /* Params IDR reference passed during runtime */
>>>        struct tcf_p4act_params __rcu *params;
>>> +     struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
>>>        u32 p_id;
>>>        u32 act_id;
>>>        struct list_head node;
>>> @@ -24,4 +40,39 @@ struct tcf_p4act {
>>>
>>>    #define to_p4act(a) ((struct tcf_p4act *)a)
>>>
>>> +static inline struct p4tc_table_entry_act_bpf *
>>> +p4tc_table_entry_act_bpf(struct tc_action *action)
>>> +{
>>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf;
>>> +     struct tcf_p4act *p4act = to_p4act(action);
>>> +
>>> +     act_bpf = rcu_dereference(p4act->act_bpf);
>>> +
>>> +     return &act_bpf->act_bpf;
>>> +}
>>> +
>>> +static inline int
>>> +p4tc_table_entry_act_bpf_change_flags(struct tc_action *action, u32 hit,
>>> +                                   u32 dflt_miss, u32 dflt_hit)
>>> +{
>>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf, *act_bpf_old;
>>> +     struct tcf_p4act *p4act = to_p4act(action);
>>> +
>>> +     act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL);
>>
>>
>> [ ... ]
>>
>>> +__bpf_kfunc static struct p4tc_table_entry_act_bpf *
>>> +bpf_p4tc_tbl_read(struct __sk_buff *skb_ctx,
>>
>> The argument could be "struct sk_buff *skb" instead of __sk_buff. Take a look at
>> commit 2f4643934670.
> 
> We'll make that change.
> 
>>
>>> +               struct p4tc_table_entry_act_bpf_params *params,
>>> +               void *key, const u32 key__sz)
>>> +{
>>> +     struct sk_buff *skb = (struct sk_buff *)skb_ctx;
>>> +     struct net *caller_net;
>>> +
>>> +     caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
>>> +
>>> +     return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
>>> +}
>>> +
>>> +__bpf_kfunc static struct p4tc_table_entry_act_bpf *
>>> +xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
>>> +               struct p4tc_table_entry_act_bpf_params *params,
>>> +               void *key, const u32 key__sz)
>>> +{
>>> +     struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
>>> +     struct net *caller_net;
>>> +
>>> +     caller_net = dev_net(ctx->rxq->dev);
>>> +
>>> +     return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
>>> +}
>>> +
>>> +static int
>>> +__bpf_p4tc_entry_create(struct net *net,
>>> +                     struct p4tc_table_entry_create_bpf_params *params,
>>> +                     void *key, const u32 key__sz,
>>> +                     struct p4tc_table_entry_act_bpf *act_bpf)
>>> +{
>>> +     struct p4tc_table_entry_key *entry_key = key;
>>> +     struct p4tc_pipeline *pipeline;
>>> +     struct p4tc_table *table;
>>> +
>>> +     if (!params || !key)
>>> +             return -EINVAL;
>>> +     if (key__sz != P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
>>> +             return -EINVAL;
>>> +
>>> +     pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
>>> +     if (!pipeline)
>>> +             return -ENOENT;
>>> +
>>> +     table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
>>> +     if (!table)
>>> +             return -ENOENT;
>>> +
>>> +     if (entry_key->keysz != table->tbl_keysz)
>>> +             return -EINVAL;
>>> +
>>> +     return p4tc_table_entry_create_bpf(pipeline, table, entry_key, act_bpf,
>>> +                                        params->profile_id);
>>
>> My understanding is this kfunc will allocate a "struct
>> p4tc_table_entry_act_bpf_kern" object. If the bpf_p4tc_entry_delete() kfunc is
>> never called and the bpf prog is unloaded, how the act_bpf object will be
>> cleaned up?
>>
> 
> The TC code takes care of this. Unloading the bpf prog does not affect
> the deletion, it is the TC control side that will take care of it. If
> we delete the pipeline otoh then not just this entry but all entries
> will be flushed.

It looks like the "struct p4tc_table_entry_act_bpf_kern" object is allocated by 
the bpf prog through kfunc and will only be useful for the bpf prog but not 
other parts of the kernel. However, if the bpf prog is unloaded, these bpf 
specific objects will be left over in the kernel until the tc pipeline (where 
the act_bpf_kern object resided) is gone.

It is the expectation on bpf prog (not only tc/xdp bpf prog) about resources 
clean up that these bpf objects will be gone after unloading the bpf prog and 
unpinning its bpf map.

[ ... ]

>>> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
>>
>> This soon will be broken with the latest change in bpf-next. It is replaced by
>> BTF_KFUNCS_START. commit a05e90427ef6.

It has already been included in the latest bpf-next pull-request, so should 
reach net-next soon.

>>
> 
> Ok, this wasnt in net-next when we pushed. We base our changes on
> net-next. When do you plan to merge that into net-next?
> 
>> What is the plan on the selftest ?
>>
> 
> We may need some guidance. How do you see us writing a selftest for this?
> We have extensive testing on the control side which is netlink (not
> part of the current series).

There are examples in tools/testing/selftests/bpf, e.g. the test_bpf_nf.c to 
test the kfuncs in nf_conntrack_bpf mentioned above. There are also selftests 
doing netlink to setup the test. The bpf/test_progs tries to avoid external 
dependency as much as possible, so linking to an extra external library and 
using an extra tool/binary will be unacceptable.
and only the bpf/test_progs binary will be run by bpf CI.

The selftest does not have to be complicated. It can exercise the kfunc and show 
how the new struct (e.g. struct p4tc_table_entry_bpf_*) will be used. There is 
BPF_PROG_RUN for the tc and xdp prog, so should be quite doable.


