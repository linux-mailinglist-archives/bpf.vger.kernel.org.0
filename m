Return-Path: <bpf+bounces-64335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46368B11AE1
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F291C81F3A
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62712D3726;
	Fri, 25 Jul 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu4J+kmu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806D2882DD;
	Fri, 25 Jul 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436047; cv=none; b=sSwdLX7lpwc3m4yDyRmcWsmpl6IliESuIshgu0xyoAaCO7/syv1W5lgBlBSiAjQcAusq7mYfKBGx0tJ0+4QOvWJUGWJgdJx69vxJjn75bADbZxrrb6qfK+cIRaWdUiTEBLhp1agyuVjcRPyNcTiKdEggqp9vrjD1ChiOFam5Phg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436047; c=relaxed/simple;
	bh=nQBD86iMxD11aFWKtQSmUj2kVORfTABBMNoeBRIHq0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiYMGnUXjJUN4jN6YH/4chqk8cJ9LbiwVpFK8XY/Mfb1muGXM0ur0J29uh7FxvaQ6pbbmesl3R+eIiOInn9x42mUe96xCMz/CIvCXVqcEPcTjZTcYA2tpet9kI075HuIkO+6g8IKXD58ECKReipsIfeBkw83ELSxOH2Ed2c0l7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu4J+kmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A7C4CEE7;
	Fri, 25 Jul 2025 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753436046;
	bh=nQBD86iMxD11aFWKtQSmUj2kVORfTABBMNoeBRIHq0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cu4J+kmu1ZWRISDF3iNfLeSnbmfRuUUlNlquHv5iEjn99wDW36G7bq/3lHrrpJYXO
	 8KI0SUI0WYvze0Fm1nf2iqxGWjmGsjVoekgtx2bjPeLoi3tthfMfBMuBy7dTiE/6ST
	 /eai6OlKgN/f2oCrrxADPqAajWSPG2qh2920UiPt6t3c/DC4DslivwrZu19M5ETv7e
	 +m47Mo9gGYtZobeL4k8dpbejDwMAx608Pg8CT6U9Jyg5vOdkzBMZv/KV7Q/4q1+378
	 +BU7XCYUUphsOiCloacb7eNawyjy0RaJ3XilC74MpOao+bEMjvvuCqpyRhn8NrJFUd
	 cWebY5VYpy4Ew==
Date: Fri, 25 Jul 2025 10:34:01 +0100
From: Simon Horman <horms@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, martinh@xilinx.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	bpf@vger.kernel.org, zzjas98@gmail.com
Subject: Re: [PATCH] sfc: siena: handle NULL returned by
 xdp_convert_buff_to_frame()
Message-ID: <20250725093401.GA1367887@horms.kernel.org>
References: <20250723003230.1243224-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723003230.1243224-1-chenyuan0y@gmail.com>

On Tue, Jul 22, 2025 at 07:32:30PM -0500, Chenyuan Yang wrote:
> The xdp_convert_buff_to_frame() function can return NULL when there is
> insufficient headroom in the buffer to store the xdp_frame structure
> or when the driver didn't reserve enough tailroom for skb_shared_info.
> 
> Currently, the sfc siena driver does not check for this NULL return value
> in the XDP_TX case within efx_do_xdp().
> 
> Fix by adding a proper NULL check in the XDP_TX case. If conversion
> fails, free the RX buffer and increment the bad drops counter, following
> the same pattern used for other XDP error conditions in this driver.
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
> ---
>  drivers/net/ethernet/sfc/siena/rx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/siena/rx.c b/drivers/net/ethernet/sfc/siena/rx.c
> index 98d3c0743c0f..65f6daad3168 100644
> --- a/drivers/net/ethernet/sfc/siena/rx.c
> +++ b/drivers/net/ethernet/sfc/siena/rx.c
> @@ -310,6 +310,12 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
>  	case XDP_TX:
>  		/* Buffer ownership passes to tx on success. */
>  		xdpf = xdp_convert_buff_to_frame(&xdp);
> +		if (unlikely(!xdpf)) {
> +			efx_siena_free_rx_buffers(rx_queue, rx_buf, 1);
> +			channel->n_rx_xdp_bad_drops++;
> +			break;
> +		}

I see the incidence of this cleanup code multiplying in this function.
I would be nice to follow-up by consolidating that - I'd suggest
in the form of a goto label at the end of the function.

But as a fix for net this minimal patch seems appropriate to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> +
>  		err = efx_siena_xdp_tx_buffers(efx, 1, &xdpf, true);
>  		if (unlikely(err != 1)) {
>  			efx_siena_free_rx_buffers(rx_queue, rx_buf, 1);
> -- 
> 2.34.1
> 
> 

