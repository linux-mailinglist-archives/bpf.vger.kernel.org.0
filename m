Return-Path: <bpf+bounces-7555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C973779277
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E06E1C2160D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059229E1D;
	Fri, 11 Aug 2023 15:09:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9111CBC;
	Fri, 11 Aug 2023 15:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E404BC433C8;
	Fri, 11 Aug 2023 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691766541;
	bh=B9H8DIEwZ4OoBS2kfl3LqlTOO0srRHKGp/4wPDMFu1Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=f1/eNXFXk5g4fN8S4EVmpVE3o75jiLV9hpORZaLzoHe8uS0Tn2nDNTKRRwG6mvHzV
	 /EINHN+MYIEeRDYWtrANimCcTqWxnaIUGPupJG2PHiqFxWQnL6IXYenZOWEEnZJ1Z5
	 ckIB7zwK2fJuXah2nmrvK+9u1Rh4Bd1owAYwn8Ari/SICmCOMviC0qn6wYSCngSqUG
	 mIhBpwscIRgedhLHJGBj+9MdvAd0in7K8eXNifwR3ZDODA6igUg5fHkQdrRpnF98PQ
	 tu9KhElc1ONi0qP33OqTWFK7LOyluLZ9hqNpKf4kz33mBz/YcvGR0ozNr7/0LMs/lI
	 PyoQ4Va6VxsOw==
Message-ID: <cc3d1319-d67e-3031-9351-95b45af797d4@kernel.org>
Date: Fri, 11 Aug 2023 17:08:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "larysa.zaremba@intel.com" <larysa.zaremba@intel.com>,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
 "jbrouer@redhat.com" <jbrouer@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230810064514.104470-1-wei.fang@nxp.com>
 <20230810064514.104470-2-wei.fang@nxp.com>
 <a7ede79c-8d5f-0036-7b8d-67c736cea058@kernel.org>
 <AM5PR04MB3139BB2A930C4D7297FDA3348810A@AM5PR04MB3139.eurprd04.prod.outlook.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <AM5PR04MB3139BB2A930C4D7297FDA3348810A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2023 03.26, Wei Fang wrote:
>> If you add below code comment you can add my ACK in V6:
>>
> Okay, I will add the annotation to the code in V6. Thanks.
> 

Great, one adjustment to my suggested comment below.

>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>>> @@ -1482,7 +1488,13 @@ fec_enet_tx_queue(struct net_device *ndev,
>> u16 queue_id, int budget)
>>>    			/* Free the sk buffer associated with this last transmit */
>>>    			dev_kfree_skb_any(skb);
>>>    		} else {
>>> -			xdp_return_frame(xdpf);
>>> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
>>> +				xdp_return_frame_rx_napi(xdpf);
>>> +			} else {
>>> +				struct page *page = virt_to_head_page(xdpf->data);
>>> +
>>
>> I think this usage of page_pool_put_page() with dma_sync_size=0 requires a
>> comment, else we will forget why this okay...
>> I suggest:
>>
>> /* PP dma_sync_size=0 as xmit already synced DMA for_device */
>>

I update my suggestion to:

  /* PP dma_sync_size=0 as XDP_TX already synced DMA for_device */

Reading code path there is an simple "else" to reach this spot, and it
will be good to hint to code-reader that this code path deals with
XDP_TX completion handling.

You are of-cause free to come up with a better comment yourself.

>>> +				page_pool_put_page(page->pp, page, 0, true);
>>> +			}
>>>
>>>    			txq->tx_buf[index].xdp = NULL;
>>>    			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
>> @@ -1541,7
> 

--Jesper

