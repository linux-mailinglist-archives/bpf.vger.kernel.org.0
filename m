Return-Path: <bpf+bounces-4090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C4748B44
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC37A280EE0
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195B14264;
	Wed,  5 Jul 2023 18:11:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8F134A7;
	Wed,  5 Jul 2023 18:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DC0C433C7;
	Wed,  5 Jul 2023 18:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688580681;
	bh=KweOEW8GfMOMNLvHYMkARFoxe20foH7IJPTc8uzro5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k7x8QXaEeLGFcfy29GO40jjHONBbBUk60hI6vcX9hBiOzahQ2oAgXZP/ie9blNMwR
	 4okF9/Avx3zPKsPFurywdGIqudclJ8+nLUw2A3d3yiJe3dd9RpvowwramVZ4JNZ+4K
	 5Fg+xyvIEQbHFzc5RJSe1YIUofsyfOs0w1JwfOmFJ7Znf/GQmUroiRsgTuFyw3Cg4f
	 LjrVLRshCbLLJWSXRZkzW+Gg92RClQNWksjIpm1yRMUsximrO4+0Q1nT1C/g9PIBIf
	 FSvHgsdgotG22s3k8274ZQJdtrICBV53CtJn9O78yLCVvkDsePdPUkWcenjjHURgKe
	 hSNTTySw6908A==
Date: Wed, 5 Jul 2023 11:11:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
 <hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
 <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: fec: increase the size of tx ring and
 update thresholds of tx ring
Message-ID: <20230705111119.07c3dee3@kernel.org>
In-Reply-To: <AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
	<20230704082916.2135501-4-wei.fang@nxp.com>
	<0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
	<AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jul 2023 06:20:26 +0000 Wei Fang wrote:
> > > In addtion, this patch also updates the tx_stop_threshold and the
> > > tx_wake_threshold of the tx ring. In previous logic, the value of
> > > tx_stop_threshold is 217, however, the value of tx_wake_threshold is
> > > 147, it does not make sense that tx_wake_threshold is less than
> > > tx_stop_threshold.  
> > 
> > What do these actually mean? I could imagine that as the ring fills you don't
> > want to stop until it is 217/512 full. There is then some hysteresis, such that it
> > has to drop below 147/512 before more can be added?
> >   
> You must have misunderstood, let me explain more clearly, the queue will be
> stopped when the available BDs are less than tx_stop_threshold (217 BDs). And
> the queue will be waked when the available BDs are greater than tx_wake_threshold
> (147 BDs). So in most cases, the available BDs are greater than tx_wake_threshold
> when the queue is stopped, the only effect is to delay packet sending.
> In my opinion, tx_wake_threshold should be greater than tx_stop_threshold, we
> should stop queue when the available BDs are not enough for a skb to be attached.
> And wake the queue when the available BDs are sufficient for a skb.

But you shouldn't restart the queue for a single packet either.
Restarting for a single packet wastes CPU cycles as there will 
be much more stop / start operations. Two large packets seem 
like the absolute minimum reasonable wake threshold.

Setting tx_stop_threshold to MAX_SKB_FRAGS doesn't seem right either,
as you won't be able to accept a full TSO frame.

Please split the change, the netdev_err_once() should be one patch
and then the change to wake thresh a separate one.
-- 
pw-bot: cr

