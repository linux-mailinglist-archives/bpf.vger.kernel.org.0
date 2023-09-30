Return-Path: <bpf+bounces-11165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74767B42F6
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 20:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D37951C20C16
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9C18C0A;
	Sat, 30 Sep 2023 18:19:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57818B11;
	Sat, 30 Sep 2023 18:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97A7C433C7;
	Sat, 30 Sep 2023 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696097993;
	bh=VkV7TjXZJnym2EdSAsMapvwnoXQMIzv/8uo4dDQrWTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBOmrl8788GbnxHeP93j29wo1oJzATYxI9FNfCZ+5dQrB5Zfl32IFQxHVQs5Mezw4
	 qg4RET03lYP+nNNp3ZdBfn1/I+8fe6faywJo5j1LwYGiD25oZBdcYV96BAuVW4pESV
	 GDtUHZblaXnXYqGPF0Pslim6HYcSh6fffRQ68Pu7xz6OVXQyZBGoUcSu2nuRiaZzGc
	 7Uca+FJvj0NT2Wsy+d5XaonAEHbaAVVuahl6HFm6KNFjvbcR0u4DoemNLVz5GL9tN6
	 zaEfh4YeXokL6XoDUQxIW3dFzXWGDnJhyFZ2ljWi8VeWvXW0ApGHMrjgx2mhFcrFzz
	 TsWCHsXKX6Q4A==
Date: Sat, 30 Sep 2023 20:19:46 +0200
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net, 3/3] net: mana: Fix oversized sge0 for GSO packets
Message-ID: <20230930181946.GG92317@kernel.org>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-4-git-send-email-haiyangz@microsoft.com>
 <ZRaRSKQDyfkhxYmY@kernel.org>
 <PH7PR21MB311698B8C2107E66890F6C7ECAC0A@PH7PR21MB3116.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB311698B8C2107E66890F6C7ECAC0A@PH7PR21MB3116.namprd21.prod.outlook.com>

On Fri, Sep 29, 2023 at 04:11:15PM +0000, Haiyang Zhang wrote:

...

> > > @@ -209,19 +281,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> > struct net_device *ndev)
> > >  	pkg.wqe_req.client_data_unit = 0;
> > >
> > >  	pkg.wqe_req.num_sge = 1 + skb_shinfo(skb)->nr_frags;
> > > -	WARN_ON_ONCE(pkg.wqe_req.num_sge >
> > MAX_TX_WQE_SGL_ENTRIES);
> > > -
> > > -	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
> > > -		pkg.wqe_req.sgl = pkg.sgl_array;
> > > -	} else {
> > > -		pkg.sgl_ptr = kmalloc_array(pkg.wqe_req.num_sge,
> > > -					    sizeof(struct gdma_sge),
> > > -					    GFP_ATOMIC);
> > > -		if (!pkg.sgl_ptr)
> > > -			goto tx_drop_count;
> > > -
> > > -		pkg.wqe_req.sgl = pkg.sgl_ptr;
> > > -	}
> > 
> > It is unclear to me why this logic has moved from here to further
> > down in this function. Is it to avoid some cases where
> > alloation has to be unwond on error (when mana_fix_skb_head() fails) ?
> > If so, this feels more like an optimisation than a fix.
> mana_fix_skb_head() may add one more sge (success case) so the sgl 
> allocation should be done later. Otherwise, we need to free / re-allocate 
> the array later.

Understood, thanks for the clarification.

> > >  	if (skb->protocol == htons(ETH_P_IP))
> > >  		ipv4 = true;
> > > @@ -229,6 +288,23 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> > struct net_device *ndev)
> > >  		ipv6 = true;
> > >
> > >  	if (skb_is_gso(skb)) {
> > > +		gso_hs = mana_get_gso_hs(skb);
> > > +
> > > +		if (mana_fix_skb_head(ndev, skb, gso_hs,
> > &pkg.wqe_req.num_sge))
> > > +			goto tx_drop_count;
> > > +
> > > +		if (skb->encapsulation) {
> > > +			u64_stats_update_begin(&tx_stats->syncp);
> > > +			tx_stats->tso_inner_packets++;
> > > +			tx_stats->tso_inner_bytes += skb->len - gso_hs;
> > > +			u64_stats_update_end(&tx_stats->syncp);
> > > +		} else {
> > > +			u64_stats_update_begin(&tx_stats->syncp);
> > > +			tx_stats->tso_packets++;
> > > +			tx_stats->tso_bytes += skb->len - gso_hs;
> > > +			u64_stats_update_end(&tx_stats->syncp);
> > > +		}
> > 
> > nit: I wonder if this could be slightly more succinctly written as:
> > 
> > 		u64_stats_update_begin(&tx_stats->syncp);
> > 		if (skb->encapsulation) {
> > 			tx_stats->tso_inner_packets++;
> > 			tx_stats->tso_inner_bytes += skb->len - gso_hs;
> > 		} else {
> > 			tx_stats->tso_packets++;
> > 			tx_stats->tso_bytes += skb->len - gso_hs;
> > 		}
> > 		u64_stats_update_end(&tx_stats->syncp);
> > 
> Yes it can be written this way:)
> 
> > Also, it is unclear to me why the stats logic is moved here from
> > futher down in the same block. It feels more like a clean-up than a fix
> > (as, btw, is my suggestion immediately above).
> Since we need to calculate the gso_hs and fix head earlier than the stats and 
> some other work, I move it immediately after skb_is_gso(skb).
> The gso_hs calculation was part of the tx_stats block, so the tx_stats is moved 
> together to remain close to the gso_hs calculation to keep readability.

I agree it is nice the way you have it.
I was mainly thinking that the diffstat could be made smaller,
which might be beneficial to a fix. But I have no strong feelings on that.

> > > +
> > >  		pkg.tx_oob.s_oob.is_outer_ipv4 = ipv4;
> > >  		pkg.tx_oob.s_oob.is_outer_ipv6 = ipv6;
> > >

...

