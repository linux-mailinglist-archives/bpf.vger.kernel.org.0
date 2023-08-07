Return-Path: <bpf+bounces-7184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721FC772AFE
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC2E1C20C4B
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7E11184;
	Mon,  7 Aug 2023 16:33:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D920FE;
	Mon,  7 Aug 2023 16:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6163BC433C8;
	Mon,  7 Aug 2023 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691426036;
	bh=XgeQ5mSaWe8K6QwECsHe/esmDKTuPpjwcCuG5PrF2aA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPyqeyqVIr68DswAS0TYjevUUCuhQAVJkjGbBek8e8l3hfB/D5EzUOh8HEVLMIePb
	 q4cW7JFqaBcW95B/0Ofe1flROB+y6rS6dHLVLLV5yk+mkvNS8SvfomkcA8UiadUa4d
	 AOAs8d0hgbT2d+grxxXzKUrmFOQSGY1fAFbJRSq+D2oylMt02Xo8KPOxO+Bssx6qQt
	 Fan02QqfsVtBDeeE4zcVPxWDXu4QXGQ+6ljyH/4YZ7LGM3ppSgfBbMjkiAsn2L+jgS
	 I7oEf0N6+mXHaw3nqsoZ+cHTbWmxA5LyqWadY89vkd1Jq6uAJvdYFfvmHnkgtgobM2
	 7hSjYbv68xASQ==
Date: Mon, 7 Aug 2023 09:33:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Jesper Dangaard Brouer
 <jbrouer@redhat.com>, "brouer@redhat.com" <brouer@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei
 Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230807093354.184bc18b@kernel.org>
In-Reply-To: <AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
	<20230802104706.5ce541e9@kernel.org>
	<AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
	<1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
	<AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
	<cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
	<AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
	<ba96db35-2273-9cc5-9a32-e924e8eff37c@kernel.org>
	<AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 10:30:34 +0000 Wei Fang wrote:
> ./xdp_rxq_info --dev eth0 --action XDP_TX
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       259,102     0
> XDP-RX CPU      total   259,102

> Result 2: dma_sync_len method
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       258,254     0
> XDP-RX CPU      total   258,254

Just to be clear are these number with xdp_return_frame() replaced
with page_pool_put_page(pool, page, 0, true); ?

