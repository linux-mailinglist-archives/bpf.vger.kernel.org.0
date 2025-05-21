Return-Path: <bpf+bounces-58657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9880ABF6FD
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA011710A7
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D8D18C002;
	Wed, 21 May 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqYnON9t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0914EC60;
	Wed, 21 May 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836159; cv=none; b=ZvIUnhXSsZNL747C5yfKD7Ew/YDBjbEe/lKyTq3WmhWTttzSz3f7HF0/h2FWrM+YZIdiI1hEllRMbmMRppF7VtDh1VGuJHJdhSkY/lLy2q65xxXGP4d5lAK93BW9imErG+m+9+wY8/zDmBem1lADAC3SvVpSVuYWCVNNkWvA1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836159; c=relaxed/simple;
	bh=XzBNibcp7iKkeEFDUAzJdibe/Jo7NOOf5PX3W+wxgD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVoNPW/8h8D5A1ZVIHUikLgf550p2RT8gjypiqVVm253W18VizrHa0Xi6yRDAMat3+GUzeEwzNykWvQKmzWMGXBG87992ZgHEDEN/gVQ4zOFhg+1qvSlPk11BzIg3oOoEN6uHI1AJlDc5q6xpzJYYgNy4sELsrVt61F6Fn61+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqYnON9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7C4C4CEE4;
	Wed, 21 May 2025 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747836158;
	bh=XzBNibcp7iKkeEFDUAzJdibe/Jo7NOOf5PX3W+wxgD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqYnON9tKaNxbz622vXY3a5h7IsI/+xBDvDXZa2hyvFfYeSmdv8EYSNVWOsAZRhSo
	 4VMLh5AP7aPS0z++jYbK1J81HUMEYW+CVwNZdITNgGWHALlo5mUgQmM/RdLr7T3519
	 hxt1g0F01btuw74hzw9xKDzXf+AD45KPhCbMVqrLqbSl8DsTCbgkA2h+D252WseKg9
	 2dvz6JNAm0Qa4qcC3jd8so/+1qjD3zKHrJ8i3FR4DkeDngUckkbLaBezxLC5nECWQn
	 eUBfkvyTuzMsNPtIsfzIyZRbnbqeuOgf7IptoXwQurBKBjODWatfRl3vkhFI3d9ZDC
	 gqIOVPi1xYw5A==
Date: Wed, 21 May 2025 15:02:31 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	hawk@kernel.org, tglx@linutronix.de,
	shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
	kotaranov@microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v2] net: mana: Add support for Multi Vports on
 Bare metal
Message-ID: <20250521140231.GW365796@horms.kernel.org>
References: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>

On Mon, May 19, 2025 at 09:20:36AM -0700, Haiyang Zhang wrote:
> To support Multi Vports on Bare metal, increase the device config response
> version. And, skip the register HW vport, and register filter steps, when
> the Bare metal hostmode is set.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2:
>   Updated comments as suggested by ALOK TIWARI.
>   Fixed the version check.
> 
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
>  include/net/mana/mana.h                       |  4 +++-
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 2bac6be8f6a0..9c58d9e0bbb5 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -921,7 +921,7 @@ static void mana_pf_deregister_filter(struct mana_port_context *apc)
>  
>  static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
>  				 u32 proto_minor_ver, u32 proto_micro_ver,
> -				 u16 *max_num_vports)
> +				 u16 *max_num_vports, u8 *bm_hostmode)
>  {
>  	struct gdma_context *gc = ac->gdma_dev->gdma_context;
>  	struct mana_query_device_cfg_resp resp = {};
> @@ -932,7 +932,7 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
>  	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_DEV_CONFIG,
>  			     sizeof(req), sizeof(resp));
>  
> -	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
> +	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
>  
>  	req.proto_major_ver = proto_major_ver;
>  	req.proto_minor_ver = proto_minor_ver;

> @@ -956,11 +956,16 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
>  
>  	*max_num_vports = resp.max_num_vports;
>  
> -	if (resp.hdr.response.msg_version == GDMA_MESSAGE_V2)
> +	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
>  		gc->adapter_mtu = resp.adapter_mtu;
>  	else
>  		gc->adapter_mtu = ETH_FRAME_LEN;
>  
> +	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V3)
> +		*bm_hostmode = resp.bm_hostmode;
> +	else
> +		*bm_hostmode = 0;

Hi,

Perhaps not strictly related to this patch, but I see
that mana_verify_resp_hdr() is called a few lines above.
And that verifies a minimum msg_version. But I do not see
any verification of the maximum msg_version supported by the code.

I am concerned about a hypothetical scenario where, say the as yet unknown
version 5 is sent as the version, and the above behaviour is used, while
not being correct.

Could you shed some light on this?

...

