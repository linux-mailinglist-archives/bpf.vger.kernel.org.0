Return-Path: <bpf+bounces-35681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BDC93CAEC
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 00:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B81F22065
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC15143C5F;
	Thu, 25 Jul 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tf1gK9Y4"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379432C8C
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947149; cv=none; b=puDq04nCKrjztFxjZVBeVmin+ySm8AnUoT0irw/RtlTDz/J6cc1hcrra4jk0wFiW+Rb5ibYESPrOArYQQxLCTZynwcgOA49vGZgUsUd2vAVOtdP1NIPDMWbUrRFeMdxSEUYb+38Z/KiRO99BGfjBFPwu40Q0jGAGlAvqusSsLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947149; c=relaxed/simple;
	bh=G//iJSa3IhesNuYZbOgBau1tJTw5yhxL21uNzhIuLdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul6VK40jpGOIuutdwjmzXN8ptN5cuSwFCSFLX1lpH31cZjBEsEqqUTdc+bHkKy3whTC0E8U/9uwiH6GNVvWlkKZ5mvny55D2cYwgMxiG/bXi8OyXm9Qbw97tiD0r5pVm1+rAju+DCtc84UfclJrHSvU/Awwjlam7VDMhQOiAmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tf1gK9Y4; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47a1dae1-7196-4991-b008-b50fb92fd5c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721947144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+WsqTy3XWxKBCiHHYlMYNaBdSeO0PURDUUK4R0AMuU=;
	b=tf1gK9Y4B9Slb0WfyaJ7+WBrTo2CF8R28YQJwrxjuOcnF+CdhAYqwzvciAugkmglkrOO6l
	xH3/xMF1nNGku5262Xd51HlZRTKwLX4/lkrsAQdlYgm4NQ5LlX38vJcs/HprhMhxaThdXw
	uPGfV39OaVq0QT20+AE635YsVoVPMpU=
Date: Thu, 25 Jul 2024 15:38:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 06/11] bpf: net_sched: Add bpf qdisc kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-7-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240714175130.4051012-7-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/24 10:51 AM, Amery Hung wrote:
> Add kfuncs for working on skb in qdisc.
> 
> Both bpf_qdisc_skb_drop() and bpf_skb_release() can be used to release
> a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
> in .enqueue where a to_free skb list is available from kernel to defer

Enforcing the bpf_qdisc_skb_drop() kfunc only available to the ".enqueue" is 
achieved by the  "struct bpf_sk_buff_ptr" pointer type only available to the 
".enqueue" ops ?

> the release. Otherwise, bpf_skb_release() should be used elsewhere. It
> is also used in bpf_obj_free_fields() when cleaning up skb in maps and
> collections.
> 
> bpf_qdisc_schedule() can be used to schedule the execution of the qdisc.
> An example use case is to throttle a qdisc if the time to dequeue the
> next packet is known.
> 
> bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> to build flow-based queueing algorithms.
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   net/sched/bpf_qdisc.c | 74 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index a68fc115d8f8..eff7559aa346 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -148,6 +148,64 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
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
> +/* bpf_skb_release - Release an skb reference acquired on an skb immediately.
> + * @skb: The skb on which a reference is being released.
> + */
> +__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
> +{
> +	consume_skb(skb);

snippet from the comment of consume_skb():

  *      Functions identically to kfree_skb, but kfree_skb assumes that the frame
  *      is being dropped after a failure and notes that

consume_skb() has a different tracepoint from the kfree_skb also. It is better 
not to confuse the tracing.

I think at least the Qdisc_ops.reset and the btf_id_dtor_kfunc don't fall into 
the consume_skb(). May be useful to add the kfree_skb[_reason?]() kfunc also?

> +}
> +
> +/* bpf_qdisc_skb_drop - Add an skb to be dropped later to a list.
> + * @skb: The skb on which a reference is being released and dropped.
> + * @to_free_list: The list of skbs to be dropped.
> + */
> +__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
> +				    struct bpf_sk_buff_ptr *to_free_list)
> +{
> +	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
> +}
> +
> +/* bpf_qdisc_watchdog_schedule - Schedule a qdisc to a later time using a timer.
> + * @sch: The qdisc to be scheduled.
> + * @expire: The expiry time of the timer.
> + * @delta_ns: The slack range of the timer.
> + */
> +__bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +
> +	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_skb_get_hash)

Add KF_TRUSTED_ARGS. Avoid cases like getting a skb from walking the skb->next 
for now.

> +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)

Also add KF_TRUSTED_ARGS here.

> +BTF_KFUNCS_END(bpf_qdisc_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_qdisc_kfunc_ids,
> +};
> +
> +BTF_ID_LIST(skb_kfunc_dtor_ids)
> +BTF_ID(struct, sk_buff)
> +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> +
>   static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
>   	.get_func_proto		= bpf_qdisc_get_func_proto,
>   	.is_valid_access	= bpf_qdisc_is_valid_access,
> @@ -347,6 +405,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
>   
>   static int __init bpf_qdisc_kfunc_init(void)
>   {
> -	return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
> +	int ret;
> +	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
> +		{
> +			.btf_id       = skb_kfunc_dtor_ids[0],
> +			.kfunc_btf_id = skb_kfunc_dtor_ids[1]
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


