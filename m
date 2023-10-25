Return-Path: <bpf+bounces-13219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1667D65FB
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EE0281C8C
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2D2031F;
	Wed, 25 Oct 2023 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FyRWO16L"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BC1F607;
	Wed, 25 Oct 2023 08:59:44 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D47B3;
	Wed, 25 Oct 2023 01:59:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id EADD05C03CA;
	Wed, 25 Oct 2023 04:59:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 25 Oct 2023 04:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698224380; x=1698310780; bh=jpFc3ADajep3n
	lG/4rtGxWjxO8/4XiSQOhnpquc1b/I=; b=FyRWO16LCUeS8X29cjvKZOrcySLLd
	BFQnw+50d+0g4m+5IDddrooMjcG+3BuCxvuHm4RK08mJkciXTmkJ+xzntT7s1XQK
	zw1Q9ZSiULl+x0ocXgkMqP6T32KjGyF0w4bDOZME2o4rr/5vPVtVbNVOz+vHpEbm
	rObIWc/o8e9e0og6lDnXVoQYcavUN0Ad87PtIfwlkmXACo4BVkhX5gdPU9Tkc+5W
	PzhMTgX9Ll2M8Gu1+YbIySyahUxOZnuBMTgyP1dw+YRb85Wn961kvb9mcHdqNpfV
	w1fArdrrbMouoZXjFsObgXf5vJzQq16QDir9/aXhxygR5C4I3mRovSk9g==
X-ME-Sender: <xms:_Ng4ZZ3XFt6keF4jY_DDRAiiS5uOuUJ8eNThET9YSb-SEaSuih95Iw>
    <xme:_Ng4ZQH4IkiXua-BnAx31EEN0hRklee0um2nZqUHAAdRt4nh0fqSfZFUwdWjN-duE
    ihCcvNEBl20l-w>
X-ME-Received: <xmr:_Ng4ZZ7WAJjHEO0BkH1sqlvPClwKZ9ZZGu9PFPa6hWZnn6druucsl1GT2MVC-JMAzrBqUb1bLGC5NajIKre8dWXWfnRgIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:_Ng4ZW3BuJtnJghZda-zhgUdhsRkDZsQiuBYWTVrRZzLXbyWGa5E-A>
    <xmx:_Ng4ZcENMl7sBC2P6p8hhJBHggZwQ94ypC_MVNQ7UE3U7RhNXnWTnw>
    <xmx:_Ng4ZX_dfaBfnBkh3g3-CM4b1-1cPuTaVhcnO6xgHZxaq0mkWYH62A>
    <xmx:_Ng4ZR5eDdDi36FqPDeIHhiAy04Szm0iB0a1NfEDwidh1wPYdszqrw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 04:59:39 -0400 (EDT)
Date: Wed, 25 Oct 2023 11:59:35 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	jhs@mojatatu.com, victor@mojatatu.com, martin.lau@linux.dev,
	dxu@dxuuu.xyz, xiyou.wangcong@gmail.com
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
Message-ID: <ZTjY959R+AFXf3Xy@shredder>
References: <20231009092655.22025-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009092655.22025-1-daniel@iogearbox.net>

On Mon, Oct 09, 2023 at 11:26:54AM +0200, Daniel Borkmann wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 606a366cc209..664426285fa3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
>  #endif /* CONFIG_NET_EGRESS */
>  
>  #ifdef CONFIG_NET_XGRESS
> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> +		  enum skb_drop_reason *drop_reason)
>  {
>  	int ret = TC_ACT_UNSPEC;
>  #ifdef CONFIG_NET_CLS_ACT
> @@ -3922,12 +3923,14 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
>  
>  	tc_skb_cb(skb)->mru = 0;
>  	tc_skb_cb(skb)->post_ct = false;
> +	res.drop_reason = *drop_reason;
>  
>  	mini_qdisc_bstats_cpu_update(miniq, skb);
>  	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
>  	/* Only tcf related quirks below. */
>  	switch (ret) {
>  	case TC_ACT_SHOT:
> +		*drop_reason = res.drop_reason;

Daniel,

Getting the following splat [1] with CONFIG_DEBUG_NET=y and this
reproducer [2]. Problem seems to be that classifiers clear 'struct
tcf_result::drop_reason', thereby triggering the warning in
__kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).

Fixed by maintaining the original drop reason if the one returned from
tcf_classify() is 'SKB_NOT_DROPPED_YET' [3]. I can submit this fix
unless you have a better idea.

Thanks

[1]
WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x38/0x130
Modules linked in:
CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9582e0 #682
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
RIP: 0010:kfree_skb_reason+0x38/0x130
[...]
Call Trace:
 <IRQ>
 __netif_receive_skb_core.constprop.0+0x837/0xdb0
 __netif_receive_skb_one_core+0x3c/0x70
 process_backlog+0x95/0x130
 __napi_poll+0x25/0x1b0
 net_rx_action+0x29b/0x310
 __do_softirq+0xc0/0x29b
 do_softirq+0x43/0x60
 </IRQ>

[2]
#!/bin/bash

ip link add name veth0 type veth peer name veth1
ip link set dev veth0 up
ip link set dev veth1 up
tc qdisc add dev veth1 clsact
tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:22:33:44:55 action drop
mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1

[3]
diff --git a/net/core/dev.c b/net/core/dev.c
index a37a932a3e14..abd0b13f3f17 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3929,7 +3929,8 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
        /* Only tcf related quirks below. */
        switch (ret) {
        case TC_ACT_SHOT:
-               *drop_reason = res.drop_reason;
+               if (res.drop_reason != SKB_NOT_DROPPED_YET)
+                       *drop_reason = res.drop_reason;
                mini_qdisc_qstats_cpu_drop(miniq);
                break;
        case TC_ACT_OK:

