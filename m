Return-Path: <bpf+bounces-50943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809DA2E848
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA8918874AD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD21C549F;
	Mon, 10 Feb 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxyEoupx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B911C3C01;
	Mon, 10 Feb 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181213; cv=none; b=GXj2jZXy/C6w0AyKgPiAMmavY8GFc1txq9dIOva53iZvCzr1e7FqxpBEjFoUAtM5mHZBj1YZnYXJGWRkXo5mmReG+oMxVmgV1R6OJQt6ws5KXiwPQi2AV+X/XJxSccFGowYfPebN76JKJob+axzmxubGVssf+1wAAzYAwdYgi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181213; c=relaxed/simple;
	bh=Cs4DIpiDZFbONHrR/b3pzJ9QiKq0CYJfxV6A+hW40Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbK8icaDTpLMOC3qYr20NyAXHIEQokhNRaQMDWi+CNXHbxtVtX56ir4D14f2YNsuHzf6vibeAzxQ+KhOZ1MturgJQWLgYErrYdvqWn7Fg9ecU70iw9s0EmGjgp5sk/Vre7Hy8Wxfw9rVtSJjKpfaOj7JYmtqAGKTqajv4U2NYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxyEoupx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739181213; x=1770717213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cs4DIpiDZFbONHrR/b3pzJ9QiKq0CYJfxV6A+hW40Tk=;
  b=fxyEoupx4fA85MGKyd2pTKekjRTlCeRH1ZHoahsYpwz50pgOOvzSbERv
   ZvAlnLItE2AEWT9br+5eoCobhKwbRgyFWE1cYuMiRNnIE2sW3tscfq8VF
   bV6vSBY0j4aXp1HHCxtHgh478t8VzkVCPwZ/Pq6MaDe4KnCovtjsRMSbZ
   4lezSgboFXguynMSiVXaveoDrtt4WAMXdFFI8M8pOaFtjQIWAYHhwVp4x
   7SphqXc/qsoRZKoDI+nodDn3lgaMuImrlZCj+ZHl4s30Fu+3tLLrvCVNK
   EysqYnNE9XkwC3F4v0TQ2GuFEjbz9Ug+qUwmr8t0Fnw8Vo+ZSSMs4W2oE
   w==;
X-CSE-ConnectionGUID: ag4Sww0XQZSC4tI1SJVJ5g==
X-CSE-MsgGUID: Tl7OP7tQQV6YZPA8XXXGxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43414892"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="43414892"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:53:31 -0800
X-CSE-ConnectionGUID: k8qiI+q8Tpa/U0n5AhEbdQ==
X-CSE-MsgGUID: Km2MynZTS2S3HcHczkCaFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="117077825"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:53:24 -0800
Date: Mon, 10 Feb 2025 10:49:49 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	William Tu <witu@nvidia.com>, Bodong Wang <bodong@nvidia.com>
Subject: Re: [PATCH net-next 07/15] net/mlx5e: reduce rep rxq depth to 256
 for ECPF
Message-ID: <Z6nLtN5rn68kY4i0@mev-dev.igk.intel.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
 <20250209101716.112774-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209101716.112774-8-tariqt@nvidia.com>

On Sun, Feb 09, 2025 at 12:17:08PM +0200, Tariq Toukan wrote:
> From: William Tu <witu@nvidia.com>
> 
> By experiments, a single queue representor netdev consumes kernel
> memory around 2.8MB, and 1.8MB out of the 2.8MB is due to page
> pool for the RXQ. Scaling to a thousand representors consumes 2.8GB,
> which becomes a memory pressure issue for embedded devices such as
> BlueField-2 16GB / BlueField-3 32GB memory.
> 
> Since representor netdevs mostly handles miss traffic, and ideally,
> most of the traffic will be offloaded, reduce the default non-uplink
> rep netdev's RXQ default depth from 1024 to 256 if mdev is ecpf eswitch
> manager. This saves around 1MB of memory per regular RQ,
> (1024 - 256) * 2KB, allocated from page pool.
> 
> With rxq depth of 256, the netlink page pool tool reports
> $./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> 	 --dump page-pool-get
>  {'id': 277,
>   'ifindex': 9,
>   'inflight': 128,
>   'inflight-mem': 786432,
>   'napi-id': 775}]
> 
> This is due to mtu 1500 + headroom consumes half pages, so 256 rxq
> entries consumes around 128 pages (thus create a page pool with
> size 128), shown above at inflight.
> 
> Note that each netdev has multiple types of RQs, including
> Regular RQ, XSK, PTP, Drop, Trap RQ. Since non-uplink representor
> only supports regular rq, this patch only changes the regular RQ's
> default depth.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> Reviewed-by: Bodong Wang <bodong@nvidia.com>
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> index fdff9fd8a89e..da399adc8854 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> @@ -65,6 +65,7 @@
>  #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
>  	max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
>  #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
> +#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
>  
>  static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
>  
> @@ -855,6 +856,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
>  
>  	/* RQ */
>  	mlx5e_build_rq_params(mdev, params);
> +	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
> +		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
>  
>  	/* If netdev is already registered (e.g. move from nic profile to uplink,
>  	 * RTNL lock must be held before triggering netdev notifiers.

Thanks for detailed commit message.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.45.0

