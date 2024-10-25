Return-Path: <bpf+bounces-43139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67649AF992
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 08:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5F5282B7F
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 06:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2658198E81;
	Fri, 25 Oct 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q5EopU4x"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342618CBFF;
	Fri, 25 Oct 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836528; cv=none; b=OMELQ+TxtaJpkYwMeIadKel2UOUhZluAGFcMof3hKs17yfuK0+kUtVztRLyQqZirA4NNWN02q1CJr7QeBUTFMqiYzRiIn4zM5h4hc4QHsBbUopZrdUcxrAQDFATl/wvP78sPz1yv8fPdDHrSoIeLRKs1KTtlJmmILUHcQnDkzTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836528; c=relaxed/simple;
	bh=X7LTNv42hr0cLBwcmc9BjZV3R9sxwA54LnIt1zXGcEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ3+2pV1fMD8vNAJIswVAd9NEcK7t4KVqyphPK8WyU7AF4AboRmTaQF8DXjQaSavdr9FQuA2s7DPR3T6JcbruFhoTAKILQdI7zwVUda60hkwwMYb3zm8eLF1sMcZEeEPtB7xw7wodavXpCpy3e6xj1MrWsbXwBMFmGV5bFPHZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q5EopU4x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 05861211A53B; Thu, 24 Oct 2024 23:08:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05861211A53B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729836526;
	bh=UwQh0e2Jag6AWyM6LY3ePC0H4CPiaFhzl+Wf/xOw+zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5EopU4xpJLUiV8m7P0B8nZgDpWShoRWLGaBOgN6PopUH+7i7ejktOS07jgpLkm/V
	 2U+CO9vTPjPq0En6Fkv58+WT0pO0p7uFBDzWHCnfJ6xT4BOP/9RPZETbY12eLuyfJo
	 0+NDYErchzDUsw8o9+2il6erhzGK/4tRLOAGjakQ=
Date: Thu, 24 Oct 2024 23:08:45 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] net: mana: use ethtool string helpers
Message-ID: <20241025060845.GA9741@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241022204908.511021-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022204908.511021-1-rosenp@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Oct 22, 2024 at 01:49:08PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the data pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 55 ++++++-------------
>  1 file changed, 18 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 349f11bf8e64..c419626073f5 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -91,53 +91,34 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
>  	unsigned int num_queues = apc->num_queues;
> -	u8 *p = data;
>  	int i;
>  
>  	if (stringset != ETH_SS_STATS)
>  		return;
>  
> -	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++) {
> -		memcpy(p, mana_eth_stats[i].name, ETH_GSTRING_LEN);
> -		p += ETH_GSTRING_LEN;
> -	}
> +	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++)
> +		ethtool_puts(&data, mana_eth_stats[i].name);
>  
>  	for (i = 0; i < num_queues; i++) {
> -		sprintf(p, "rx_%d_packets", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "rx_%d_bytes", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "rx_%d_xdp_drop", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "rx_%d_xdp_tx", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "rx_%d_xdp_redirect", i);
> -		p += ETH_GSTRING_LEN;
> +		ethtool_sprintf(&data, "rx_%d_packets", i);
> +		ethtool_sprintf(&data, "rx_%d_bytes", i);
> +		ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
> +		ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
> +		ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
>  	}
>  
>  	for (i = 0; i < num_queues; i++) {
> -		sprintf(p, "tx_%d_packets", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_bytes", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_xdp_xmit", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_tso_packets", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_tso_bytes", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_tso_inner_packets", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_tso_inner_bytes", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_long_pkt_fmt", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_short_pkt_fmt", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_csum_partial", i);
> -		p += ETH_GSTRING_LEN;
> -		sprintf(p, "tx_%d_mana_map_err", i);
> -		p += ETH_GSTRING_LEN;
> +		ethtool_sprintf(&data, "tx_%d_packets", i);
> +		ethtool_sprintf(&data, "tx_%d_bytes", i);
> +		ethtool_sprintf(&data, "tx_%d_xdp_xmit", i);
> +		ethtool_sprintf(&data, "tx_%d_tso_packets", i);
> +		ethtool_sprintf(&data, "tx_%d_tso_bytes", i);
> +		ethtool_sprintf(&data, "tx_%d_tso_inner_packets", i);
> +		ethtool_sprintf(&data, "tx_%d_tso_inner_bytes", i);
> +		ethtool_sprintf(&data, "tx_%d_long_pkt_fmt", i);
> +		ethtool_sprintf(&data, "tx_%d_short_pkt_fmt", i);
> +		ethtool_sprintf(&data, "tx_%d_csum_partial", i);
> +		ethtool_sprintf(&data, "tx_%d_mana_map_err", i);
>  	}
>  }
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>  
> -- 
> 2.47.0

