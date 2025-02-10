Return-Path: <bpf+bounces-50945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E588A2E856
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0734B16739E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885D41C5F29;
	Mon, 10 Feb 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoCYTq3D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A551C4A0E;
	Mon, 10 Feb 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181286; cv=none; b=lMzv1kiJsKJPDr52rzeyB0LdQ18y1sO3xPZ+lqMkWXyE72rtn+XcZEDPRoibNLFKJBOxmW26X5Fl3CkB7NC3Y3MExJbz33J0qIeeijVvwOqDb83jf4w6lqXq1u78MmxGTww56wqf0JVqey5jgovBxvE2U3fWLOWHXEw61cuZNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181286; c=relaxed/simple;
	bh=ho9n3VcfJkszLgQBZ71Nls4seClP+D2Y17joOZ6Dau0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exkExM+CTYGiWaYNysdhV5vpqD/AlePoP7su3MAm7xj4QZYXGTZXMZyupadp1KsoeyNf3so/DEkivwvG7d3CwvyJOe06xtqW3j8VdlJpttBsyZWpq+03KCPPlcryjAv3fGBjfDkYXe9nlsiEBHjTbJSGsDsdteYCc9N/p5+5s48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoCYTq3D; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739181284; x=1770717284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ho9n3VcfJkszLgQBZ71Nls4seClP+D2Y17joOZ6Dau0=;
  b=ZoCYTq3D2HtrRlS1qjz1lnrEIUUlggNsCdARqjSzAwBiZuL51ncOn7mW
   bu3zCQ9/KtvZPkvaAjt9siLd8BzZ317djkS751SZeV6NTHp5HaPoii9Y8
   xNqOQvorZbx9Ptz/aTJ5IrHzmswrRqh9eM+pJIw7jjBjKNZvVOuC6wdqO
   Phzj6KlZHOxgtqhZAvwyfoAQ6hrLAtu2//QvsbtbGk5rEkjoNbfd2qpFQ
   kTzYyoUmEqtaez7opa7PjgJFTO5axlxlUBkbPBTwMBM3VXnuA5L8sJBly
   qZP1eBXbeDobwsjPF2gGmzwt02oWHcZCROPON1QEBPNvkeNI1OOSA6tpR
   A==;
X-CSE-ConnectionGUID: 3ciKh5CGQy+TqSzQO75toQ==
X-CSE-MsgGUID: rriZIlVATjKobi0U4tgHvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50392912"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="50392912"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:54:43 -0800
X-CSE-ConnectionGUID: suYm/ui8Qh6NIvYsBsUajg==
X-CSE-MsgGUID: x2SrYlPpQQyEY6kS13ph6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="111977801"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:54:38 -0800
Date: Mon, 10 Feb 2025 10:51:02 +0100
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
	William Tu <witu@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next 08/15] net/mlx5e: set the tx_queue_len for
 pfifo_fast
Message-ID: <Z6nMBi26yyFjQQJK@mev-dev.igk.intel.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
 <20250209101716.112774-9-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209101716.112774-9-tariqt@nvidia.com>

On Sun, Feb 09, 2025 at 12:17:09PM +0200, Tariq Toukan wrote:
> From: William Tu <witu@nvidia.com>
> 
> By default, the mq netdev creates a pfifo_fast qdisc. On a
> system with 16 core, the pfifo_fast with 3 bands consumes
> 16 * 3 * 8 (size of pointer) * 1024 (default tx queue len)
> = 393KB. The patch sets the tx qlen to representor default
> value, 128 (1<<MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE), which
> consumes 16 * 3 * 8 * 128 = 49KB, saving 344KB for each
> representor at ECPF.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> Reviewed-by: Daniel Jurgens <danielj@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> index da399adc8854..07f38f472a27 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> @@ -889,6 +889,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
>  	netdev->ethtool_ops = &mlx5e_rep_ethtool_ops;
>  
>  	netdev->watchdog_timeo    = 15 * HZ;
> +	if (mlx5_core_is_ecpf(mdev))
> +		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
>  
>  #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
>  	netdev->hw_features    |= NETIF_F_HW_TC;

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.45.0

