Return-Path: <bpf+bounces-64337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B40B11AFB
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D3F1C837D5
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AAD2D3752;
	Fri, 25 Jul 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTMYkIvY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1325FA34;
	Fri, 25 Jul 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436380; cv=none; b=OTBi7aXF/FOm7gvlPtiOS6EgAHpg67hJE1glsMskmQfEWu76x2zpy83dkVi41ZCD3M82NnwRIV3YTodL4QTyxNMtWUwvy2F6hntjc+1pZLUF75pWzX0bGBH0bdVi1EsE/1FfLTybKxuZAXwGhxlbmcrxRidMHijvlovT0AgoiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436380; c=relaxed/simple;
	bh=eFikvBO2EKJ9aWDRPZ5WsTnRi22I//xMn0j49/2eP2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUcqrER04HaavBGRvTy0oSEdyfqxtW3BHcuGh4mPcUytVNJxRWIwC0TdPbEHAbacB/PD4vo1rx6XT8djqxd78McRa5eijUhoV922K+Z0fOqXiPb/ysgh0MVApV/aKc7PFe7NojlI++mOr6P++GJAytyeAVoIY0NEXFI2nf2DRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTMYkIvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFABC4CEE7;
	Fri, 25 Jul 2025 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753436379;
	bh=eFikvBO2EKJ9aWDRPZ5WsTnRi22I//xMn0j49/2eP2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTMYkIvYFVPHRrGBAmsVlGSNmjE0cXJsRmxVxwhT+nagkHr9PmEiUyrhZNKlubgHx
	 tmQZo1GfOITu3Vkq/cxlQqoMk8dmfPintg8Dx+i425rP5pXhtqQVP1yOqGOcQMPfEU
	 pbI/uuClQBYJeTp6XbhTpn2BJYSeEO02rJw1G6dv8rFnMATe5Uiuq7pLdygOH7mn3w
	 eHZlNTjkDVITG6FdLiwFZaB9e/8Kac0/abAJXLoVUsD5uYeA7U01pUaoJJCsSoLz32
	 sUGRETLVXfPBgIonvLAwoSFCJ9felmKAk3lawFuqYYhMAb9KpEyZSQl7HETE+HRtEN
	 X6ym+xkOCxMsw==
Date: Fri, 25 Jul 2025 10:39:34 +0100
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
Message-ID: <20250725093934.GB1367887@horms.kernel.org>
References: <20250723003230.1243224-1-chenyuan0y@gmail.com>
 <20250725093401.GA1367887@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725093401.GA1367887@horms.kernel.org>

On Fri, Jul 25, 2025 at 10:34:01AM +0100, Simon Horman wrote:
> On Tue, Jul 22, 2025 at 07:32:30PM -0500, Chenyuan Yang wrote:
> > The xdp_convert_buff_to_frame() function can return NULL when there is
> > insufficient headroom in the buffer to store the xdp_frame structure
> > or when the driver didn't reserve enough tailroom for skb_shared_info.
> > 
> > Currently, the sfc siena driver does not check for this NULL return value
> > in the XDP_TX case within efx_do_xdp().
> > 
> > Fix by adding a proper NULL check in the XDP_TX case. If conversion
> > fails, free the RX buffer and increment the bad drops counter, following
> > the same pattern used for other XDP error conditions in this driver.
> > 
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > Fixes: d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
> > ---
> >  drivers/net/ethernet/sfc/siena/rx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/sfc/siena/rx.c b/drivers/net/ethernet/sfc/siena/rx.c
> > index 98d3c0743c0f..65f6daad3168 100644
> > --- a/drivers/net/ethernet/sfc/siena/rx.c
> > +++ b/drivers/net/ethernet/sfc/siena/rx.c
> > @@ -310,6 +310,12 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
> >  	case XDP_TX:
> >  		/* Buffer ownership passes to tx on success. */
> >  		xdpf = xdp_convert_buff_to_frame(&xdp);
> > +		if (unlikely(!xdpf)) {
> > +			efx_siena_free_rx_buffers(rx_queue, rx_buf, 1);
> > +			channel->n_rx_xdp_bad_drops++;
> > +			break;
> > +		}
> 
> I see the incidence of this cleanup code multiplying in this function.
> I would be nice to follow-up by consolidating that - I'd suggest
> in the form of a goto label at the end of the function.
> 
> But as a fix for net this minimal patch seems appropriate to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Oops, a few moments later I now see that Paolo felt otherwise
for a similar patch [1].

  "AFAIC the sfc driver reserves both enough headroom and tailroom, but
   this is after ebpf run, which in turn could consume enough headroom to
   cause a failure, so I think this makes sense."

Let's go with his advice and and for a review by Edward.

[1] Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
    https://lore.kernel.org/all/045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com/

