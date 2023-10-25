Return-Path: <bpf+bounces-13237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A47D67C8
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999BB2817B2
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978724214;
	Wed, 25 Oct 2023 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jbLQqvs/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932741A585;
	Wed, 25 Oct 2023 10:02:01 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A13E5;
	Wed, 25 Oct 2023 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=E2dG4OlBfkBTNu2B59oJZLN0pmNJT9nCe57aHpvbqLY=; b=jbLQqvs/fFnf3xWzRWaM7N4noG
	BJ6piSF7H1odmTHw3wnU+qJTMaOs0ihBbGwHLtonkpt7k4n2665LyCue8owzuaNAoPdMD17ZNZJI+
	pRjscxPKVHIPPilNLOQMnqRJUonCPzCNniHaLgybkvHtQdCGMrcBwsZrT5soDDVKgN7iGFvjbq6jb
	bbuzZfZYN/oQH37W/GpghXMhHNI4J+AvhgSGuc+MA2Fblx6bSf435GaLqd+Usm1ccE1S6MUH5aC7g
	mTsX6LB+xyn05v4cxWyacQp5jU1r5F4Zi/mUwdsnr6GgNzx6UG01OQh/P0pOWXgwpZAkgl+dg88+2
	Up0LMjGw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvai0-0001tU-Gj; Wed, 25 Oct 2023 12:01:52 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvai0-000Iym-4l; Wed, 25 Oct 2023 12:01:52 +0200
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
To: Ido Schimmel <idosch@idosch.org>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz,
 xiyou.wangcong@gmail.com
References: <20231009092655.22025-1-daniel@iogearbox.net>
 <ZTjY959R+AFXf3Xy@shredder>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <726368f0-bbe9-6aeb-7007-6f974ed075f2@iogearbox.net>
Date: Wed, 25 Oct 2023 12:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZTjY959R+AFXf3Xy@shredder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27072/Wed Oct 25 09:45:37 2023)

Hi Ido,

On 10/25/23 10:59 AM, Ido Schimmel wrote:
> On Mon, Oct 09, 2023 at 11:26:54AM +0200, Daniel Borkmann wrote:
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 606a366cc209..664426285fa3 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
>>   #endif /* CONFIG_NET_EGRESS */
>>   
>>   #ifdef CONFIG_NET_XGRESS
>> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
>> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
>> +		  enum skb_drop_reason *drop_reason)
>>   {
>>   	int ret = TC_ACT_UNSPEC;
>>   #ifdef CONFIG_NET_CLS_ACT
>> @@ -3922,12 +3923,14 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
>>   
>>   	tc_skb_cb(skb)->mru = 0;
>>   	tc_skb_cb(skb)->post_ct = false;
>> +	res.drop_reason = *drop_reason;
>>   
>>   	mini_qdisc_bstats_cpu_update(miniq, skb);
>>   	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
>>   	/* Only tcf related quirks below. */
>>   	switch (ret) {
>>   	case TC_ACT_SHOT:
>> +		*drop_reason = res.drop_reason;
> 
> Daniel,
> 
> Getting the following splat [1] with CONFIG_DEBUG_NET=y and this
> reproducer [2]. Problem seems to be that classifiers clear 'struct
> tcf_result::drop_reason', thereby triggering the warning in
> __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).
> 
> Fixed by maintaining the original drop reason if the one returned from
> tcf_classify() is 'SKB_NOT_DROPPED_YET' [3]. I can submit this fix
> unless you have a better idea.

Thanks for catching this, looks reasonable to me as a fix.

> [1]
> WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x38/0x130
> Modules linked in:
> CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9582e0 #682
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
> RIP: 0010:kfree_skb_reason+0x38/0x130
> [...]
> Call Trace:
>   <IRQ>
>   __netif_receive_skb_core.constprop.0+0x837/0xdb0
>   __netif_receive_skb_one_core+0x3c/0x70
>   process_backlog+0x95/0x130
>   __napi_poll+0x25/0x1b0
>   net_rx_action+0x29b/0x310
>   __do_softirq+0xc0/0x29b
>   do_softirq+0x43/0x60
>   </IRQ>
> 
> [2]
> #!/bin/bash
> 
> ip link add name veth0 type veth peer name veth1
> ip link set dev veth0 up
> ip link set dev veth1 up
> tc qdisc add dev veth1 clsact
> tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:22:33:44:55 action drop
> mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1

I didn't know you're using mausezahn, nice :)

> [3]
> diff --git a/net/core/dev.c b/net/core/dev.c
> index a37a932a3e14..abd0b13f3f17 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3929,7 +3929,8 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
>          /* Only tcf related quirks below. */
>          switch (ret) {
>          case TC_ACT_SHOT:
> -               *drop_reason = res.drop_reason;
> +               if (res.drop_reason != SKB_NOT_DROPPED_YET)
> +                       *drop_reason = res.drop_reason;
>                  mini_qdisc_qstats_cpu_drop(miniq);
>                  break;
>          case TC_ACT_OK:
> 

When you submit feel free to add:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

