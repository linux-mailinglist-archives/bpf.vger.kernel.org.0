Return-Path: <bpf+bounces-50941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04591A2E836
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81467164337
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEB81C5799;
	Mon, 10 Feb 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWMoJ5gO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045742E628;
	Mon, 10 Feb 2025 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181067; cv=none; b=rJb4nmAbfekHXNOZf3CjBHniI77uAxDnAUDVvS5iqRpv1pIEKHkW8s/jr0qff09JHyMyEVf6V6pDVVkpoJUlNFkffNrN6YIIAhHeZJwaNp13DE/WLOAhKmaYTduiL7qv12C/S4RPMFOM3FfkfGCa0x5RoHQtvn+Ll/0n/PhLAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181067; c=relaxed/simple;
	bh=L/47NT1D33AXwhb7bm+RpJCwbuPNbjYzSmLMznvjFWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObhMYx9gh23jvTv45/YpdxSGr2aU2ol5nMFxujV6WbMHKUzo6is4MPofJFYc9iI9+ZXBJJC26NDmJpxV/RZpfqv7krDSGIbpvyEqW/omlL3flt1jgeFABNdqIBk9baDvMlgHA4QzvFm/9RP7G1tLZ20ut6NGfFtr94bc5CLvHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWMoJ5gO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739181066; x=1770717066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L/47NT1D33AXwhb7bm+RpJCwbuPNbjYzSmLMznvjFWw=;
  b=QWMoJ5gOmbr1ei3AfxJZ4WdPbw+/zj46qq2SJQzE77gqegORRziW9XSX
   U9XsF4iJMNQ/DRQoiwzePgZenCMvdcub3rH0bZLmZ7JPwEaTYGNQz1l4T
   QQrrLbiKfpd1VKfjnuEZf726n+5prXwYwiKOcHo0+JcYl5HeudUH0wPTI
   brNxxrOksP7X1w/O9ggNNUlA5sBK3RmrVNosJfsZTZHOiAn+N3LSdGjVp
   g7/CV9PbUqlND9uDLiq4nVT6NsaFEo3B45Z3c51YedstqJ2FmEiXLvpk2
   kb7JkAqoe94c5qYXuRMM+YA0j6T51SfHeR0JPXBNWQJ6c4pggwmcknku0
   Q==;
X-CSE-ConnectionGUID: MykdgzrHTvirkLw2jCF5HQ==
X-CSE-MsgGUID: B5JxyzdJTW2g8mTyNl9kEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="42595860"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="42595860"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:51:05 -0800
X-CSE-ConnectionGUID: xmjUZU8AToy/ZXqkagaATg==
X-CSE-MsgGUID: Q/eVqaqlQgO8mCvrCPpGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112777594"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:51:00 -0800
Date: Mon, 10 Feb 2025 10:47:26 +0100
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
	William Tu <witu@nvidia.com>
Subject: Re: [PATCH net-next 06/15] net/mlx5e: reduce the max log mpwrq sz
 for ECPF and reps
Message-ID: <Z6nLLsMa4njyLrIV@mev-dev.igk.intel.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
 <20250209101716.112774-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209101716.112774-7-tariqt@nvidia.com>

On Sun, Feb 09, 2025 at 12:17:07PM +0200, Tariq Toukan wrote:
> From: William Tu <witu@nvidia.com>
> 
> For the ECPF and representors, reduce the max MPWRQ size from 256KB (18)
> to 128KB (17). This prepares the later patch for saving representor
> memory.
> 
> With Striding RQ, there is a minimum of 4 MPWQEs. So with 128KB of max
> MPWRQ size, the minimal memory is 4 * 128KB = 512KB. When creating page
> pool, consider 1500 mtu, the minimal page pool size will be 512KB/4KB =
> 128 pages = 256 rx ring entries (2 entries per page).
> 
> Before this patch, setting RX ringsize (ethtool -G rx) to 256 causes
> driver to allocate page pool size more than it needs due to max MPWRQ
> is 256KB (18). Ex: 4 * 256KB = 1MB, 1MB/4KB = 256 pages, but actually
> 128 pages is good enough. Reducing the max MPWRQ to 128KB fixes the
> limitation.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 --
>  .../net/ethernet/mellanox/mlx5/core/en/params.c   | 15 +++++++++++----
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 979fc56205e1..534fdd27c8de 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -95,8 +95,6 @@ struct page_pool;
>  #define MLX5_MPWRQ_DEF_LOG_STRIDE_SZ(mdev) \
>  	MLX5_MPWRQ_LOG_STRIDE_SZ(mdev, order_base_2(MLX5E_RX_MAX_HEAD))
>  
> -#define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
> -
>  /* Keep in sync with mlx5e_mpwrq_log_wqe_sz.
>   * These are theoretical maximums, which can be further restricted by
>   * capabilities. These values are used for static resource allocations and
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 64b62ed17b07..e37d4c202bba 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -10,6 +10,9 @@
>  #include <net/page_pool/types.h>
>  #include <net/xdp_sock_drv.h>
>  
> +#define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
> +#define MLX5_REP_MPWRQ_MAX_LOG_WQE_SZ 17
> +
>  static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
>  {
>  	u8 min_page_shift = MLX5_CAP_GEN_2(mdev, log_min_mkey_entity_size);
> @@ -103,18 +106,22 @@ u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
>  			  enum mlx5e_mpwrq_umr_mode umr_mode)
>  {
>  	u8 umr_entry_size = mlx5e_mpwrq_umr_entry_size(umr_mode);
> -	u8 max_pages_per_wqe, max_log_mpwqe_size;
> +	u8 max_pages_per_wqe, max_log_wqe_size_calc;
> +	u8 max_log_wqe_size_cap;
>  	u16 max_wqe_size;
>  
>  	/* Keep in sync with MLX5_MPWRQ_MAX_PAGES_PER_WQE. */
>  	max_wqe_size = mlx5e_get_max_sq_aligned_wqebbs(mdev) * MLX5_SEND_WQE_BB;
>  	max_pages_per_wqe = ALIGN_DOWN(max_wqe_size - sizeof(struct mlx5e_umr_wqe),
>  				       MLX5_UMR_FLEX_ALIGNMENT) / umr_entry_size;
> -	max_log_mpwqe_size = ilog2(max_pages_per_wqe) + page_shift;
> +	max_log_wqe_size_calc = ilog2(max_pages_per_wqe) + page_shift;
> +
> +	WARN_ON_ONCE(max_log_wqe_size_calc < MLX5E_ORDER2_MAX_PACKET_MTU);
>  
> -	WARN_ON_ONCE(max_log_mpwqe_size < MLX5E_ORDER2_MAX_PACKET_MTU);
> +	max_log_wqe_size_cap = mlx5_core_is_ecpf(mdev) ?
> +			   MLX5_REP_MPWRQ_MAX_LOG_WQE_SZ : MLX5_MPWRQ_MAX_LOG_WQE_SZ;
>  
> -	return min_t(u8, max_log_mpwqe_size, MLX5_MPWRQ_MAX_LOG_WQE_SZ);
> +	return min_t(u8, max_log_wqe_size_calc, max_log_wqe_size_cap);

Changing the variable name looks like uneccessary complication, as it is
still used for the same purpouse.

I remember there were some patches to devlink for supporting changing
the representor parameters. Is it sth different or you decided to only
change the default value to fix the memory problem? (sorry, maybe I miss
the devlink series).

Anyway, looks fine, thanks:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  }
>  
>  u8 mlx5e_mpwrq_pages_per_wqe(struct mlx5_core_dev *mdev, u8 page_shift,
> -- 
> 2.45.0

