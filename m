Return-Path: <bpf+bounces-6994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5476FFFA
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 14:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9877D282626
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F88EBA57;
	Fri,  4 Aug 2023 12:09:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8ED9479;
	Fri,  4 Aug 2023 12:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172B6C433C7;
	Fri,  4 Aug 2023 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691150994;
	bh=axWaUXP/2OhWrOi66tqNCt4hqCOmMutZJ5QBsrM8Zp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GFx83acKyAhwxLNwQ2QD1TqpWgk816I2NQ5ZNVBe1IX5m/P6LIjSTys8bU9fS0xq9
	 xIR7kbCTFnfNZ76KhKuJ1SmZ1fy12ta3i7CqbrhT5rBEYiBeSB1YunwKmzfRuOHXsx
	 cTXRbR3N1SEgQAzDI8CFNKi0OSiqKeASEmZBOApsuhg90g6fQ0Q8MzYjf/v8/6pVPY
	 oQ7Ep6Svy3onB0co9lm2YpfOAlbfOqU6B+JkeZeJqocYFdS2PSd1xmFzhC7keXIyP6
	 DCWLKRfzWPKSuuD5NYKD9oJD6ZYAH2FmDflVpQEe1vcFuNlXI3HRVhg34Q0zfp2p7M
	 q2k1Bqtr+kfhw==
Message-ID: <3a11f1e2-ee5d-676f-2666-0cee8bcbed6b@kernel.org>
Date: Fri, 4 Aug 2023 14:09:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: "brouer@redhat.com" <brouer@redhat.com>, dl-linux-imx
 <linux-imx@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <3d0a8536-6a22-22e5-41c0-98c13dd7b802@redhat.com>
 <AM5PR04MB3139E5A9A0B407922A33BF99880BA@AM5PR04MB3139.eurprd04.prod.outlook.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <AM5PR04MB3139E5A9A0B407922A33BF99880BA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/08/2023 14.33, Wei Fang wrote:
>>> +	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
>> XDP_TX can avoid this conversion to xdp_frame.
>> It would requires some refactor of fec_enet_txq_xmit_frame().
>>
> Yes, but I'm not intend to change it, using the existing interface is enough.
> 
>>> +	struct fec_enet_private *fep = netdev_priv(ndev);
>>> +	struct fec_enet_priv_tx_q *txq;
>>> +	int cpu = smp_processor_id();
>>> +	struct netdev_queue *nq;
>>> +	int queue, ret;
>>> +
>>> +	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
>>> +	txq = fep->tx_queue[queue];

Notice how TXQ gets selected based on CPU.
Thus it will be the same for all the frames.

>>> +	nq = netdev_get_tx_queue(fep->netdev, queue);
>>> +
>>> +	__netif_tx_lock(nq, cpu);
>> 
>> It is sad that XDP_TX takes a lock for each frame.
>>
> Yes, but the XDP path share the queue with the kernel network stack, so
> we need a lock here, unless there is a dedicated queue for XDP path. Do
> you have a better solution?
> 

Yes, the solution would be to keep a stack local (or per-CPU) queue for
all the XDP_TX frames, and send them at the xdp_do_flush_map() call
site. This is basically what happens with xdp_do_redirect() in cpumap.c
and devmap.c code, that have a per-CPU bulk queue and sends a bulk of
packets into fec_enet_xdp_xmit / ndo_xdp_xmit.

I understand if you don't want to add the complexity to the driver.
And I guess, it should be a followup patch to make sure this actually
improves performance.

--Jesper

