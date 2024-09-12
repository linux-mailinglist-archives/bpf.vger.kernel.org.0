Return-Path: <bpf+bounces-39729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D5976CEE
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71061F258BD
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C21ACDE3;
	Thu, 12 Sep 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="liNZV9aV"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798367DA62;
	Thu, 12 Sep 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153422; cv=none; b=PCLp75NnngYM9BkQgbDrEDEsZs2inpW4A+iUEI3n4zO0MtZToVQTB2cTtKDBmMdVSgpFpxEMAqZi5IO+nTqxCJ+EJFraD5+KoYdqs8eSKYqjGNHVCVUWzIwCCkjQxn8JwqYaEropb8kFVl2ZOH33wgdb1Du+EEGbHxPcebFUaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153422; c=relaxed/simple;
	bh=FS7VowP6VcwbfSE/69Yg1n5VFPIhrlBX+o8c6BCsi/Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=acTcFPm81OHSBtBsO3f0yPQ+ag6OblwI3M3N3TNnl2DWOaAtC98MITCeM+oC3nwICnuSIXequ9zL2qIe/bZpCZvV3ZbEWqBbybGUOhW3mi4XJgMwdzbhk/vhjczPg/Sn3RNQq5pZVM5hOafEDUpzTiipIcZfrG1AUfBtYsS18Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=liNZV9aV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MfQwa2aIAfoK5dYYHltwSoHa2s4oTNuzjDGGZa7ERak=; b=liNZV9aVtezOd3XCB+U5oCb17n
	FheNiQVMungeEsyHZ3e2aNuB0TuQGMQdl87pNImvJ9giiO6xQ1GVFrMhbYk7ijPcg8KPlD1Hm1X9Q
	5T9ECw41V3m32Elw9GRoiiiayIE3IGeRSTcBv2i4QraDHqf7S0tEE/Rz7hbOl0bxbe9qEt4Pb0tPu
	bPewtmWfOb3n5ilo0GaZqtsgz55yeU4oAIRu2d5wjhidxI5Og+rnf8ax/JorCbdu+0gsFP41bXdrM
	iAKxMSCfwONdGePx1aoiQtQy6HbuSrU/Fj5+rEZW/r5s3037y15f75tBIOduCZHm36QS4bbM9zcWN
	7r4693SQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1solLp-000Iqs-9X; Thu, 12 Sep 2024 17:03:17 +0200
Received: from [178.197.249.55] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1solLo-0007la-1f;
	Thu, 12 Sep 2024 17:03:15 +0200
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
To: Breno Leitao <leitao@debian.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, razor@blackwall.org, andrii@kernel.org,
 ast@kernel.org,
 syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org> <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
 <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ccd708bf-580a-3d24-e5be-4e7dc12e7b39@iogearbox.net>
Date: Thu, 12 Sep 2024 17:03:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

On 9/12/24 3:17 PM, Breno Leitao wrote:
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

Oh well, quite annoying that we need this context now everywhere also outside of XDP :(
Sebastian, do you see any way where this could be noop for !PREEMPT_RT?

Anyway, fix looks good to me, thanks!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

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
>   	peer = rcu_dereference(nk->peer);
>   	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
> @@ -110,6 +112,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
>   		break;
>   	}
>   	rcu_read_unlock();
> +	bpf_net_ctx_clear(bpf_net_ctx);
>   	return ret_dev;
>   }
> 


