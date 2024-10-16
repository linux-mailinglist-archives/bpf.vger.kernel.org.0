Return-Path: <bpf+bounces-42227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B059A1206
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01E2B21A00
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A4C2144AB;
	Wed, 16 Oct 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWmGtJLB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B618DF97;
	Wed, 16 Oct 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104819; cv=none; b=TMR4FgjM45W1NXkf8qf2Bp8kIBKz5ER8MoKFLNmXe7pDu9PwTzK0szyd8uBGTaGEnJvWxNQXm66XJ5WtymecJQ3l2Vi4jzsFhSM9fWksGAeKXCCqRfS50VEkI4/VNjOEU5e578EMtg3t0FM9+rfSaix8dwBgFJ+qqZvlpC56K3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104819; c=relaxed/simple;
	bh=Y/Vqjn7AS4QmH95MO8AvZCxoQ6XG93780zk6JPh7v0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjo6SV5QwZXd0OmOwH8AK68Uf/0PsZm8nVJr2kWPNCYREGP6hOkJFNWlQiBarr4tVI+mzzogyv2GTsB5Cn+8olXgsICyDnHNAhmS0s6p0EaD3QlcpxLm4+k7+p+0DT6kMV3cC7gA+ISVEuPgHGqLPh7qt5UwTuzcmpd0Bi8kpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWmGtJLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97651C4CEC5;
	Wed, 16 Oct 2024 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729104819;
	bh=Y/Vqjn7AS4QmH95MO8AvZCxoQ6XG93780zk6JPh7v0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWmGtJLBhHBuC2eGL/nM5trZ/bmISrffOYX6BavdrXMmlINXDYuD7mD1Tc6pesfvQ
	 dsATNy1gjXju1TWzmTfXDRxjUHZCBmo2c8I2CrNi1KwaA6Awlzvbdl8MXH1iHoPPEX
	 BBaZOkz0l6JoFNo24aP9x5NjSLK8NirkDhEboWCIMzDgam8Hby11CTM4OYB/00+bp3
	 L4K4o6ibNgOA8v40bJYnnZJi5mJoZ6hjL20Uv6vboGNcBA+J1CNiU/E12sVnejkNKC
	 1mox9Ytacs1U8LlFVAcPtAF1qEfUReXUV42WYuqkRIxugf0FoC1nScQToQ2jrZT48i
	 aHEuW0W9yHvFQ==
Date: Wed, 16 Oct 2024 19:53:33 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, vedang.patel@intel.com,
	andre.guedes@intel.com, maciej.fijalkowski@intel.com,
	jithu.joseph@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
Message-ID: <20241016185333.GL2162@kernel.org>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016105310.3500279-1-yuehaibing@huawei.com>

On Wed, Oct 16, 2024 at 06:53:10PM +0800, Yue Haibing wrote:
> Return NULL instead of passing to ERR_PTR while res is IGC_XDP_PASS,
> which is zero, this fix smatch warnings:
> drivers/net/ethernet/intel/igc/igc_main.c:2533
>  igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
> 
> Fixes: 26575105d6ed ("igc: Add initial XDP support")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 6e70bca15db1..c3d6e20c0be0 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2530,7 +2530,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
>  	res = __igc_xdp_run_prog(adapter, prog, xdp);
>  
>  out:
> -	return ERR_PTR(-res);
> +	return res ? ERR_PTR(-res) : NULL;

I think this is what PTR_ERR_OR_ZERO() is for.

