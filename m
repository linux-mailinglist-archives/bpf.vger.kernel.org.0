Return-Path: <bpf+bounces-14983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB67E99B2
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 11:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F091A1F20F29
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CB1C2A0;
	Mon, 13 Nov 2023 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMxtvVWu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83522290C;
	Mon, 13 Nov 2023 10:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DB2C433C9;
	Mon, 13 Nov 2023 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699869789;
	bh=cfnuPkChTa2Qw4d30BcMRSRlcZrP4mPrSTjl3W3msmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMxtvVWudgQ8AhSTkqtkh7PIbqQ6lDH1ujoybbzlZjnpQMt/BG3B1B86ugPnyixiQ
	 TKvj4j+nKiiquzbRAj03euCiwCzlTbZl8BoSlcwjtj2R8SCKJFoE/j3X61gbcdFyAL
	 mBMPaN3EGqWRJOn1R8jqSr/KGlBd55kEFNb1NnfVkCJVdGDbuvsFQBREgFcWmasYUD
	 t/Be7WLD0zs+IAqUBOFHKBK/notIp7x70bI2wH+3gKfBE9ErMZkGdICooe4iQMx7CO
	 DTGnAaT1tgTOv8V4nu5Y9VOdoJqm23wvsam/2iDC0w7V2qYyXY14PYIZkuqXg45R4+
	 fBAHD2RwNm49A==
Date: Mon, 13 Nov 2023 10:03:05 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
	sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH bpf v2 2/8] net: Move {l,t,d}stats allocation to core and
 convert veth & vrf
Message-ID: <20231113100305.GO705326@kernel.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112203009.26073-3-daniel@iogearbox.net>

On Sun, Nov 12, 2023 at 09:30:03PM +0100, Daniel Borkmann wrote:
> Move {l,t,d}stats allocation to the core and let netdevs pick the stats
> type they need. That way the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc) - all happening in the core.
> 
> Co-developed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@kernel.org>

Hi Daniel,

sorry I was a bit to hasty in hitting the send button for my previous
message. I have a some more minor feedback on this series.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0d548431f3fa..75db81496db5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10049,6 +10049,44 @@ void netif_tx_stop_all_queues(struct net_device *dev)
>  }
>  EXPORT_SYMBOL(netif_tx_stop_all_queues);
>  
> +static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
> +{
> +	void __percpu *v;
> +
> +	switch (dev->pcpu_stat_type) {
> +	case NETDEV_PCPU_STAT_NONE:
> +		return 0;
> +	case NETDEV_PCPU_STAT_LSTATS:
> +		v = dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
> +		break;
> +	case NETDEV_PCPU_STAT_TSTATS:
> +		v = dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> +		break;
> +	case NETDEV_PCPU_STAT_DSTATS:
> +		v = dev->dstats = netdev_alloc_pcpu_stats(struct pcpu_dstats);
> +		break;
> +	}
> +
> +	return v ? 0 : -ENOMEM;

Perhaps this cannot happen, but if none of the cases in the switch
statement are met, then v will be uninitialised here.

As flagged by Smatch.

> +}
> +

...

> @@ -10469,6 +10513,7 @@ void netdev_run_todo(void)
>  		WARN_ON(rcu_access_pointer(dev->ip_ptr));
>  		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
>  
> +		netdev_do_free_pcpu_stats(dev);
>  		if (dev->priv_destructor)
>  			dev->priv_destructor(dev);
>  		if (dev->needs_free_netdev)

nit: the hunk above seems unnecessary; one blank line is enough.

