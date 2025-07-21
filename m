Return-Path: <bpf+bounces-63894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF3FB0C0FF
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26BC7AEEA8
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488AD28D8E4;
	Mon, 21 Jul 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EF83KfN0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A328C2A9;
	Mon, 21 Jul 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092743; cv=none; b=iGIARO+493e8wW+GmiznAtvlX+dsO1Nr+DV8kzlprqz3E/lb01uQiqBVIuO7C5NV95OTRUC2EMUhUjq+gLlSNQXExBBQAY6YAHj5ZE9En9okKlN3gn8nHjn0C5r1qgVaOJCa3fQQdkS4chb68mN3x8yze4K4mWO+/q5SpwU4Hac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092743; c=relaxed/simple;
	bh=dH+et4IVFehAoofbz4bjXr/dEXWhL6mRUcMkBd7PQ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDIxiIiul0KNx/Q9rVKyxi/cHkgM8JrtHyxxmmgmGc3WH5IG+pyVQy0vzCldt5c5AFzjioKjKkfnKh6Q/r51pQ+NW/mPCuXLEusJ/48sBBD5jAoHRcP6KSbrf0wivYTNLXu5pDyANsuvsPZB9jd1OFjySH7ZZdVM46ArBnpjfnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EF83KfN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC5BC4CEED;
	Mon, 21 Jul 2025 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753092743;
	bh=dH+et4IVFehAoofbz4bjXr/dEXWhL6mRUcMkBd7PQ98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EF83KfN0RR+kBLAAoTiFCigRniZfIBmzhofNXQtSRhe0mIc+mSmwaXLpSIeKFOTrA
	 mmn2x+EnoGxkQK/rmulUujuDzayGk1EYz8CbEkTMMlZscPF/p/LpkR6Oiph/tODjtl
	 r/AkOmZCVFFKCmzmBPMd0dxwjdMm1XaHscvOVFYQ/QrjPKpYJMWvOLxtgc3kVm7jUZ
	 IO2CT8AOBAFLJhHf4843gZASPIUT8QWci9esovDs6sXmKSY7VrC0I8xN24r2q1611n
	 +H4X9So0PKaKtjBzQBYKcoOvo3At/KLZRv86DxF+2rSI8J99LitFD4/mcgYMkBS7hH
	 CyswzAJMYqjOg==
Date: Mon, 21 Jul 2025 11:12:17 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 2/2] igb: xsk: solve underflow of nb_pkts in
 zerocopy mode
Message-ID: <20250721101217.GC2459@horms.kernel.org>
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721083343.16482-3-kerneljasonxing@gmail.com>

On Mon, Jul 21, 2025 at 04:33:43PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> There is no break time in the while() loop, so every time at the end of
> igb_xmit_zc(), underflow of nb_pkts will occur, which renders the return
> value always false. But theoretically, the result should be set after
> calling xsk_tx_peek_release_desc_batch(). We can take i40e_xmit_zc() as
> a good example.
> 
> Returning false means we're not done with transmission and we need one
> more poll, which is exactly what igb_xmit_zc() always did before this
> patch. After this patch, the return value depends on the nb_pkts value.
> Two cases might happen then:
> 1. if (nb_pkts < budget), it means we process all the possible data, so
>    return true and no more necessary poll will be triggered because of
>    this.
> 2. if (nb_pkts == budget), it means we might have more data, so return
>    false to let another poll run again.
> 
> Fixes: f8e284a02afc ("igb: Add AF_XDP zero-copy Tx support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 5cf67ba29269..243f4246fee8 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -482,7 +482,7 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct xsk_buff_pool *xsk_pool)
>  	if (!nb_pkts)
>  		return true;
>  
> -	while (nb_pkts-- > 0) {
> +	while (i < nb_pkts) {

Hi Jason,

FWIIW, I think using a for loop is a more idiomatic way
of handling the relationship between i, nb_pkts, and
the iterations of this loop.

>  		dma = xsk_buff_raw_get_dma(xsk_pool, descs[i].addr);
>  		xsk_buff_raw_dma_sync_for_device(xsk_pool, dma, descs[i].len);
>  
> -- 
> 2.41.3
> 
> 

