Return-Path: <bpf+bounces-39719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0103976AB3
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693AAB21530
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC11AED24;
	Thu, 12 Sep 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kVRR7k8v"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047819F42E
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147988; cv=none; b=g00OezGij5dIeD9yvi0e8DL8WoQL/lqPDOMrZGBlMgHmWTVMXBJwFRCiKslIbOrmeqXggqJ3yZPP1DiEZUIm1GeevyVjcFhbPT8nSQrlIR5U0yXDUvTnO8UQ05jGt/8AFg96buNuGwGJiGXoTfTUKryX5NZIfqHvhMSzQTO7tKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147988; c=relaxed/simple;
	bh=CPeu07DxP3wbB3dMsGK7rsRNYxCKorSGumHxlY94PXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YM4G4BEOvpEtynLofFUWAZoAEGu6hSkiWPcSfz+1CfhSKknFs/7+Jjghi6tniy+YvlNqKMgf1s71etlGoQBOLMCVYVPK0TOlUrdL2U+NvxBMc2otz2lUeY5nKpFB3mPUyr6lHDGqTb8codqx7PrDkRH4l5DoDLgZVkl3Nkrt5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kVRR7k8v; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a2a1cce-8d92-4d10-87ea-4cdf1934d5fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726147981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyq9bRI1TS3hXpjwHtn17hObsWlvaRNqSMNKcUTXNC0=;
	b=kVRR7k8vkeBdRcCmr9Ft0hnm4G456BoZGtzeOSUTMlEcvcZYa/9Wk4GXEZAVvx+VPoqw1N
	qcCVjagUQ1IBLQlbkz6BJwcY1JUkVxlKo489HEBXe53dUzpr37qUnIJGcknMfGvpW3iaO2
	DbeZ6QLelw07hRNsVnCFGPFVm48tjNQ=
Date: Thu, 12 Sep 2024 14:32:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
To: Breno Leitao <leitao@debian.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
 syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org> <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
 <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/09/2024 14:17, Breno Leitao wrote:
> Hello Sabastian,
> 
> Thanks for the quick reply!
> 
> On Thu, Sep 12, 2024 at 02:28:47PM +0200, Sebastian Andrzej Siewior wrote:
>> On 2024-09-12 05:06:36 [-0700], Breno Leitao wrote:
>>> Hello Sebastian, Jakub,
>> Hi,
>>
>>> I've seen some crashes in 6.11-rc7 that seems related to 401cb7dae8130
>>> ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.").
>>>
>>> Basically bpf_net_context is NULL, and it is being dereferenced by
>>> bpf_net_ctx->ri.kern_flags (offset 0x38) in the following code.
>>>
>>> 	static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
>>> 	{
>>> 		struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>>> 		if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
>>>
>>> That said, it means that bpf_net_ctx_get() is returning NULL.
>>>
>>> This stack is coming from the bpf function bpf_redirect()
>>> 	BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
>>> 	{
>>> 	      struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>>>
>>>
>>> Since I don't think there is XDP involved, I wondering if we need some
>>> preotection before calling bpf_redirect()
>>
>> This origins in netkit_xmit(). If my memory serves me, then Daniel told
>> me that netkit is not doing any redirect and therefore does not need
>> "this". This must have been during one of the first "designs"/ versions.
> 
> Right, I've seen several crashes related to this, and in all of them it
> is through netkit_xmit() -> netkit_run() ->  bpf_prog_run()
> 
>> If you are saying, that this is possible then something must be done.
>> Either assign a context or reject the bpf program.
> 
> If we want to assign a context, do you meant something like the
> following?
> 
> Author: Breno Leitao <leitao@debian.org>
> Date:   Thu Sep 12 06:11:28 2024 -0700
> 
>      netkit: Assign missing bpf_net_context.
>      
>      During the introduction of struct bpf_net_context handling for
>      XDP-redirect, the netkit driver has been missed.
>      
>      Set the bpf_net_context before invoking netkit_xmit() program within the
>      netkit driver.
>      
>      Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
>      Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 79232f5cc088..f8af57b7a1e8 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -65,6 +65,7 @@ static struct netkit *netkit_priv(const struct net_device *dev)
>   
>   static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
> +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>   	struct netkit *nk = netkit_priv(dev);
>   	enum netkit_action ret = READ_ONCE(nk->policy);
>   	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
> @@ -72,6 +73,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
>   	struct net_device *peer;
>   	int len = skb->len;
>   
> +	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
>   	rcu_read_lock();

Hi Breno,

looks like bpf_net_ctx should be set under rcu read lock...

>   	peer = rcu_dereference(nk->peer);
>   	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
> @@ -110,6 +112,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
>   		break;
>   	}
>   	rcu_read_unlock();
> +	bpf_net_ctx_clear(bpf_net_ctx);
>   	return ret_dev;
>   }



