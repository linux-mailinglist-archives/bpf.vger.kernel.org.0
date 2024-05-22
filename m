Return-Path: <bpf+bounces-30346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A548D8CC9F4
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 01:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42611C21254
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CF14D282;
	Wed, 22 May 2024 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTZlHoz9"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96D2E631;
	Wed, 22 May 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716422165; cv=none; b=raaOCPvSZUOo7HJJGA70D0Wo21Cpb8xQsCZ6m2klDCqXv+MOFIqNvaOddijja2JX41rhnpeMIAvrCpSH3mfg8pqleL1PM3yiRPUfInS7l+PMWIIlGNb0tiFAHG4xlun0gFieXihutrOKYoojPJ0bEdL/aisPJCZbtZKXR2XeOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716422165; c=relaxed/simple;
	bh=2nZnGFq8MPMyieDZW+kwi9KgBeInpwFu6IHQucpSmc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MglkESgK9gNFhm8+k8/DdHuHc+tPTImF7mWrwlGWjAlLEZ4m9bUsAep6oBobt8NHvxF+BwBhkLR7vFecbexuTIOLM3xSNnaEMkP1Vm6uBNPt3QY06nDGUZMEoYuvxCPrX82T5QIP2dEB+3TuEVD/f8PwkW3Be5G2QlB+0n+xDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTZlHoz9; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ameryhung@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716422161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6bB3vfRJNYAiq4S6ECYcTjHCIm5bjYwnUK76A5VfM=;
	b=UTZlHoz9THyXDLseLL3QXlwVbMJfugVc9dipw3PyOgQhOh1ouRoh5Q65f0OEpj1TvCyznu
	f5RoXNfVyNugFocqUrg4iEoWk5BtXCDQpGozIh52sL/djRsmrQFGHgXmUerMZk0hTrI/EI
	4qnXVzENrMJUMM3ACP71aRG663egeMY=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: yangpeihao@sjtu.edu.cn
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: toke@redhat.com
X-Envelope-To: jhs@mojatatu.com
X-Envelope-To: jiri@resnulli.us
X-Envelope-To: sdf@google.com
X-Envelope-To: xiyou.wangcong@gmail.com
X-Envelope-To: yepeilin.cs@gmail.com
Message-ID: <e87abee4-7dc4-4fea-bf98-499d7378acbf@linux.dev>
Date: Wed, 22 May 2024 16:55:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v8 14/20] bpf: net_sched: Add bpf qdisc kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-15-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240510192412.3297104-15-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/10/24 12:24 PM, Amery Hung wrote:
> +BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_skb_set_dev)
> +BTF_ID_FLAGS(func, bpf_skb_get_hash)
> +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)

Thanks for working on the bpf qdisc!

I want to see if we can shrink the set and focus on the core pieces first.

The above kfuncs look ok. bpf_skb_set_dev() will need some thoughts but my 
understanding is that it is also not needed if the patch set did not reuse the 
rb_node in the sk_buff?

> +BTF_ID_FLAGS(func, bpf_skb_tc_classify)
> +BTF_ID_FLAGS(func, bpf_qdisc_create_child)
> +BTF_ID_FLAGS(func, bpf_qdisc_find_class)
> +BTF_ID_FLAGS(func, bpf_qdisc_enqueue, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_qdisc_dequeue, KF_ACQUIRE | KF_RET_NULL)

How about starting with classless qdisc first?

I also wonder if the class/hierarchy can be implemented in the 
bpf_map/bpf_rb_root/bpf_list_head alone. That aside, the patch set shows that 
classful qdisc is something tangible with kfuncs. The classless qdisc bpf 
support does not seem to depend on it. Unless there is something on the classful 
side that really needs to be finalized at this point, I would leave it out from 
the core pieces for now and focus on classless. Does it make sense?

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
> @@ -558,6 +781,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
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


