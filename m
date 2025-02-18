Return-Path: <bpf+bounces-51849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E65A3A4EB
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF9C188A45E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5C270ECB;
	Tue, 18 Feb 2025 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRISGRn+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD326A1C7;
	Tue, 18 Feb 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901826; cv=none; b=ZPckwnUzAuztGYQ8FocIMULP4fdy2iQK5TDE6WegeZnZH+NMYgYXBOUwaGo0IJ0aDns02ImiRPLqaciw2yRiQ6CbtJtgC8NigMeABq0/2Y13BzgUp1ETsOmO9VyKWwO4Xog8BTWq2QDb2GnHaFHorwg53Or0JOz/an6aUScMkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901826; c=relaxed/simple;
	bh=ky9UJmYTSsctYzz0hk8n01Wcf6eT9yEihECuIxGa1yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No9WMYhl2y5ikPqDhT04j4WUVnCKoTfK0eezLillrXkV71ViR/URb+T7TYSo0LjuvLp/TJvXFpGnAca5MuVNktw616zvIvrZMpDks0mV9cIQ+I8FP8sv+EnAje0V8ijd+masS09chTiEqBssmap9kObeC7tctVC4W/8M5U4qJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRISGRn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42460C4CEE4;
	Tue, 18 Feb 2025 18:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739901826;
	bh=ky9UJmYTSsctYzz0hk8n01Wcf6eT9yEihECuIxGa1yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRISGRn+k0h+0V77nvwNkSg0TYbAWwazRl9xAsZbQW56u5HfigmvoITx+j3hCK/eG
	 91BaD5huvl02fPmwJxEdgzjsk/kaIK+4+o0cANwHeya5Xg+x6y8Ol0YIjc3z7LeabM
	 x6c80WV73V8twugZxHTsR9OR9i4lZs0nxl7hEj1XpMs/uaZtRKGK883EA1JFsz8+P3
	 ha84dovdxR7MciRNpE3P6cjI7OQ/PfPnMVe4oGpHBn9IuKPqKY2XQ6M0zmsZ3MVMwb
	 gJTEVuQjvWcVdwwXXYyYoWaVllLi8bncIDwOvlK/A72lkafyf0bDrhvYC/yPUnL98D
	 pW56bXKs7np+w==
Date: Tue, 18 Feb 2025 18:03:40 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Md Danish Anwar <danishanwar@ti.com>, srk@ti.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: ethernet: ti: am65_cpsw: move
 am65_cpsw_put_page() out of am65_cpsw_run_xdp()
Message-ID: <20250218180340.GF1615191@kernel.org>
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
 <20250217-am65-cpsw-zc-prep-v1-4-ce450a62d64f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-am65-cpsw-zc-prep-v1-4-ce450a62d64f@kernel.org>

On Mon, Feb 17, 2025 at 09:31:49AM +0200, Roger Quadros wrote:
> This allows us to re-use am65_cpsw_run_xdp() for zero copy
> case. Add AM65_CPSW_XDP_TX case for successful XDP_TX so we don't
> free the page while in flight.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c

...

> @@ -1230,9 +1230,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
>  		ndev->stats.rx_dropped++;
>  	}
>  
> -	page = virt_to_head_page(xdp->data);
> -	am65_cpsw_put_page(flow, page, true);
> -
>  	return ret;

It seems that before and after this patch ret is always initialised to
AM65_CPSW_XDP_CONSUMED and never changed. So it can be removed.

Given that with this patch the function only returns after the switch
statement, I think this would be a nice follow-up.

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 20a4fc3e579f..4052c9153632 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1172,7 +1172,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 {
 	struct am65_cpsw_common *common = flow->common;
 	struct net_device *ndev = port->ndev;
-	int ret = AM65_CPSW_XDP_CONSUMED;
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
 	int cpu = smp_processor_id();
@@ -1228,9 +1227,8 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 		fallthrough;
 	case XDP_DROP:
 		ndev->stats.rx_dropped++;
+		return AM65_CPSW_XDP_CONSUMED;
 	}
-
-	return ret;
 }
 
 /* RX psdata[2] word format - checksum information */

...

