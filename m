Return-Path: <bpf+bounces-42307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665AF9A24BE
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 16:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DF21C218DF
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171711DE3D6;
	Thu, 17 Oct 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEFDhw4Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888781DDA24;
	Thu, 17 Oct 2024 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174590; cv=none; b=i2MPPzyruRW5pDzrA8XlU0v5jp15UmIAwMB1RKDeCfjFQmyjG7+dmHXLDTLLtl09IwDbfXveYtDvh/uHWa3lF2PuZMguq7unr3sLf0UkB2ZunzRLmLd5LLSLVd9JXUwJKrIZmv2AS+q+RVgnEg/x5Mmei6tD/EWSx+smmLR9JD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174590; c=relaxed/simple;
	bh=Gjd358NdN1FC5NF7qKwHKj4oavoCBNSLL7Qo72hpwmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCfuPosRpklPAqmnXPtvY49bzCcrIqcOMUVdKEVuMjZIgcJ7i7k2bWwh6k4IScTfRvG1ZOjgX95wV8fwuvaPE1d9H6+s6Iota2OmWNMCYux49achDELZ7idIRPo4eEVATrIaq7VpO2gCyxezbfE6p/8XL6w9txbzye3GsVgM+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEFDhw4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B259DC4CEC3;
	Thu, 17 Oct 2024 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174590;
	bh=Gjd358NdN1FC5NF7qKwHKj4oavoCBNSLL7Qo72hpwmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iEFDhw4QSPb/UP/iSVNDln8sDERMgECcDFGfbozJO3x3fYWOcTwHktH1Uy3TSilNx
	 Lfh8vIZGIdwI5sNQMzGUS2LBtAybjWYldLWUX+79J27rI+eg1aKNZVinfvTDVrBVTk
	 /tdSYD2SpNSTPK32H6D8gLsU92p72IN3v/TZEXSClLKu1rGBaycEzBl1+6MsaZ2qTI
	 Qaw7iE25YEG7seXmuo0c3PYZ7s5VjuLIAwzjai9VgZl+4R6DrwsNx8p2D6SfvIMJDI
	 cND52m8HtNrqHT+h1CghLurFWm6PukkfadjY0rg4OwVDfVJid2tG10ClYkZcyDbcG/
	 2qvzQoztLzu+Q==
Date: Thu, 17 Oct 2024 15:16:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, vedang.patel@intel.com,
	andre.guedes@intel.com, maciej.fijalkowski@intel.com,
	jithu.joseph@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
Message-ID: <20241017141624.GO1697@kernel.org>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
 <20241016185333.GL2162@kernel.org>
 <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>

On Wed, Oct 16, 2024 at 04:06:34PM -0700, Jacob Keller wrote:
> 
> 
> On 10/16/2024 11:53 AM, Simon Horman wrote:
> > On Wed, Oct 16, 2024 at 06:53:10PM +0800, Yue Haibing wrote:
> >> Return NULL instead of passing to ERR_PTR while res is IGC_XDP_PASS,
> >> which is zero, this fix smatch warnings:
> >> drivers/net/ethernet/intel/igc/igc_main.c:2533
> >>  igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
> >>
> >> Fixes: 26575105d6ed ("igc: Add initial XDP support")
> >> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> >> index 6e70bca15db1..c3d6e20c0be0 100644
> >> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> >> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> >> @@ -2530,7 +2530,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
> >>  	res = __igc_xdp_run_prog(adapter, prog, xdp);
> >>  
> >>  out:
> >> -	return ERR_PTR(-res);
> >> +	return res ? ERR_PTR(-res) : NULL;
> > 
> > I think this is what PTR_ERR_OR_ZERO() is for.
> 
> Not quite. PTR_ERR_OR_ZERO is intended for the case where you are
> extracting an error from a pointer. This is converting an error into a
> pointer.

Yes, silly me.

> I am not sure what is really expected here. If res is zero, shouldn't we
> be returning an skb pointer and not NULL?

Right. I think the whole point of the cited warning is that it highlights
code that is often buggy. I think I may have tried to address it in the
past, but if so unsuccessfully. In any case, I do think it would be good to
dig into this and either fix it properly (or understand why it is correct
and note that somewhere.

> 
> Why does igc_xdp_run_prog even return a sk_buff pointer at all? It never
> actually returns an skb...
> 
> This feels like the wrong fix entirely.
> 
> __igc_xdp_run_prog returns a custom value for the action, between
> IGC_XDP_PASS, IGC_XDP_TX, IGC_XDP_REDIRECT, or IGC_XDP_CONSUMED.
> 
> This function is called by igc_xdp_run_prog which converts this to a
> negative error code with the sk_buff pointer type.
> 
> All so that we can assign a value to the skb pointer in
> ice_clean_rx_irq, and check it with IS_ERR
> 
> I don't like this fix, I think we could drop the igc_xdp_run_prog
> wrapper, call __igc_xdp_run_prog directly and check its return value
> instead of this method of using an error pointer.

-- 
pw-bot: changes-requested

