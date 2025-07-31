Return-Path: <bpf+bounces-64784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFFFB16E81
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60085A7F59
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85D2BDC02;
	Thu, 31 Jul 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esw+cvmx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2901E571B;
	Thu, 31 Jul 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953811; cv=none; b=XcW697EWtNutJGcIG+x7TFBqM7EwV5ND0DJkfbZyGouQBG7nTv08PbJ0NrxRewOz77YBcrRYI+doY6/Ibzl7otK0VQPUoX180s+lqOeYv9tkW/l1KBrKFVvQk2j8hsPUa++FsICLKNPMlGvqL87ndJ4RUBOFnja5qwZsQ3kJll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953811; c=relaxed/simple;
	bh=TEv0EJJ7X3saRmXkvPbOaGlS9PtKVjxjEnpdkcm7ghY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVZVw731kEOGI7nQCkzy5rGANjoA1uTDWlvXxmJKbgP8YRfpnGRXpY1LsF3qcmMjuVPfF21tpjHC4kI6esLChx2rUL3HJjutS5o6+IWQADtLVgQiwhhyGNSuaYql7Cgpp1kAazNMVkiqCj4gcziVUvPT/zqFiwDL5a4RenC4oKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esw+cvmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D2AC4CEEF;
	Thu, 31 Jul 2025 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753953810;
	bh=TEv0EJJ7X3saRmXkvPbOaGlS9PtKVjxjEnpdkcm7ghY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=esw+cvmxSiW/QifsMN6DvA03HI1Gt/fCrZPyEC9XAIZ0ukOHQsqosTNcVb+cSjzJO
	 sU6lOIqcDfFR1sef9BcjvRnY0dATpr5doGnLb+CJkXkOSK7RmILNOGqcHeyWCBA7Kv
	 HGM2cwjNogEmeoDU9ncz3u1Y7U6GKMQ4R40Nwd9LONGePsCtKrEgtXLWWqZdCPYrL1
	 PvdmC63DrUiunPL6ldmahWEUsY09WDeJFTb0THSNeEECWnrm2U2kbZqNHh6+kri/Ak
	 bG2z0eOX8IdoOWzIFeteM8sAJfKB5kFV6GsppjRIIFhjSn/ipl0y/iCNUmCp1GIM97
	 BjigNPCq9KczQ==
Message-ID: <2671c27e-9a5e-4a6f-ae03-30ec1eb83013@kernel.org>
Date: Thu, 31 Jul 2025 11:23:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sfc: handle NULL returned by
 xdp_convert_buff_to_frame()
To: Chenyuan Yang <chenyuan0y@gmail.com>, ecree.xilinx@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 zzjas98@gmail.com, Kunwu Chan <kunwu.chan@linux.dev>,
 Edward Cree <ecree@amd.com>
References: <20250726195605.1650303-1-chenyuan0y@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250726195605.1650303-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/07/2025 21.56, Chenyuan Yang wrote:
> The xdp_convert_buff_to_frame() function can return NULL when there is
> insufficient headroom in the buffer to store the xdp_frame structure
> or when the driver didn't reserve enough tailroom for skb_shared_info.
> 
> Currently, the sfc driver does not check for this NULL return value
> in the XDP_TX case within efx_do_xdp(). While the efx_xdp_tx_buffers()
> function has some defensive checks, passing a NULL xdpf can still lead
> to undefined behavior when the function tries to access xdpf->len and
> xdpf->data.
> 

The XDP_TX case is only for driver local frames/packets. And Edward says
the sfc driver reserves both enough headroom and tailroom.

> Fix by adding a proper NULL check in the XDP_TX case, following the
> suggestions of the developers.

In [V1] reply I question if this is possible
  - [v1] 
https://lore.kernel.org/all/a13646af-78f7-4ba7-9767-41d598222b1d@kernel.org/

Hmm... have you actually tested that XDP/BPF can adjust headroom so much
that xdp_convert_buff_to_frame() function fails?

I really doubt this possible for BPF-progs to violate this.

The XDP BPF-prog can only adjust the headroom via the helpers
bpf_xdp_adjust_head() and bpf_xdp_adjust_meta().  These helpers reserve
room for sizeof(struct xdp_frame).

The tailroom can be adjusted via helper bpf_xdp_adjust_tail() and it
also reserve room for sizeof(struct skb_shared_info) such that BPF-progs
cannot get access to this area. See define for xdp_data_hard_end.


> Fixes: 1b698fa5d8ef ("xdp: Rename convert_to_xdp_frame in xdp_convert_buff_to_frame")
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@linux.dev>
> Cc: Edward Cree <ecree@amd.com>
> ---
>   drivers/net/ethernet/sfc/rx.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
> index ffca82207e47..b56457c23f66 100644
> --- a/drivers/net/ethernet/sfc/rx.c
> +++ b/drivers/net/ethernet/sfc/rx.c
> @@ -308,14 +308,20 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
>   	case XDP_TX:
>   		/* Buffer ownership passes to tx on success. */
>   		xdpf = xdp_convert_buff_to_frame(&xdp);
> -		err = efx_xdp_tx_buffers(efx, 1, &xdpf, true);
> +		if (unlikely(!xdpf))
> +			err = -ENOBUFS;
> +		else
> +			err = efx_xdp_tx_buffers(efx, 1, &xdpf, true);
> +
>   		if (unlikely(err != 1)) {
>   			efx_free_rx_buffers(rx_queue, rx_buf, 1);
>   			if (net_ratelimit())
>   				netif_err(efx, rx_err, efx->net_dev,
> -					  "XDP TX failed (%d)\n", err);
> +					  "XDP TX failed (%d)%s\n", err,
> +					  err == -ENOBUFS ? " [frame conversion]" : "");
>   			channel->n_rx_xdp_bad_drops++;
> -			trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> +			if (err != -ENOBUFS)
> +				trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
>   		} else {
>   			channel->n_rx_xdp_tx++;
>   		}


