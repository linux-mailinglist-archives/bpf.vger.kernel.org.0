Return-Path: <bpf+bounces-6844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B23776E8DE
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FAB2820F9
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7021ED51;
	Thu,  3 Aug 2023 12:55:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFE14287;
	Thu,  3 Aug 2023 12:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21202C433C8;
	Thu,  3 Aug 2023 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691067343;
	bh=GhmWwQWMZjJg/eGpXkU3AgopEMscfS5D4Dor979ob8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dvRmOH831+pqhZHhKsHSaiHkJOMtiL241WzFcGB2utZAUuahi0yp3FqdSCC/u4tF7
	 AhTpYtOPJ/wDhlQ1PfZAzXijJmtgCio2MMfqDnqqRbU/WNFII3KsWVUMy2DE8yfu/n
	 rAViT3AaaJNMGdX7Yyl7w/ckImq62lVTrRrf/3wrJHT67MNWpxNUmmOCCMnZ6qB1y9
	 5R6s7wbeLRm2ioTPtiZT4bbiJZZOfWYC3lYFq6NEcfTK+/CmRpq5WEJQ0XH7bRMWbG
	 Bbt0nJ82xqJynIwryPSM1ws4WggJo/VoAfsVj3XRm+WrcCDM6Sh7dUVlLOaomxSTGK
	 222NuFAoKZ0Vw==
Message-ID: <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
Date: Thu, 3 Aug 2023 14:55:37 +0200
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
To: Wei Fang <wei.fang@nxp.com>, Jesper Dangaard Brouer <jbrouer@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "brouer@redhat.com" <brouer@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
 <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2023 13.18, Wei Fang wrote:
>> On 03/08/2023 05.58, Wei Fang wrote:
>>>>>                    } else {
>>>>> -                 xdp_return_frame(xdpf);
>>>>> +                 xdp_return_frame_rx_napi(xdpf);
>>>> If you implement Jesper's syncing suggestions, I think you can use
>>>>
>>>>     page_pool_put_page(pool, page, 0, true);
>> To Jakub, using 0 here you are trying to bypass the DMA-sync (which is valid
>> as driver knows XDP_TX have already done the sync).
>> The code will still call into DMA-sync calls with zero as size, so wonder if we
>> should detect size zero and skip that call?
>> (I mean is this something page_pool should support.)
>>
[...]
>>
>>
>>>> for XDP_TX here to avoid the DMA sync on page recycle.
>>> I tried Jasper's syncing suggestion and used page_pool_put_page() to
>>> recycle pages, but the results does not seem to improve the
>>> performance of XDP_TX,
>> The optimization will only have effect on those devices which have
>> dev->dma_coherent=false else DMA function [1] (e.g.
>> dma_direct_sync_single_for_device) will skip the sync calls.
>>
>>  [1] https://elixir.bootlin.com/linux/v6.5-rc4/source/kernel/dma/direct.h#L63
>>
>> (Cc. Andrew Lunn)
>> Does any of the imx generations have dma-noncoherent memory?
>>
>> And does any of these use the fec NIC driver?
>>
>>> it even degrades the speed.
>> 
>> Could be low runs simply be a variation between your test runs?
>>
> Maybe, I just tested once before. So I test several times again, the
> results of the two methods do not seem to be much different so far,
> both about 255000 pkt/s.
> 
>> The specific device (imx8mpevk) this was tested on, clearly have
>> dma_coherent=true, or else we would have seen a difference.
>> But the code change should not have any overhead for the
>> dma_coherent=true case, the only extra overhead is the extra empty DMA
>> sync call with size zero (as discussed in top).
>>
> The FEC of i.MX8MP-EVK has dma_coherent=false, and as I mentioned
> above, I did not see an obvious difference in the performance. :(

That is surprising - given the results.

(see below, lack of perf/diff might be caused by Ethernet flow-control).

> 
>>> The result of the current modification.
>>> root@imx8mpevk:~# ./xdp2 eth0
>>> proto 17:     260180 pkt/s
>>
>> These results are*significantly*  better than reported in patch-1.
>> What happened?!?
>>
> The test environment is slightly different, in patch-1, the FEC port was
> directly connected to the port of another board. But in the latest test,
> the ports of the two boards were connected to a switch, so the ports of
> the two boards are not directly connected.
> 

Hmm, I've seen this kind of perf behavior of direct-connected or via
switch before. The mistake I made was, that I had not disabled Ethernet
flow-control.  The xdp2 XDP_TX program will swap the mac addresses, and
send the packet back to the packet generator (running pktgen), which
will get overloaded itself and starts sending Ethernet flow-control
pause frames.

Command line to disable:
  # ethtool -A eth0 rx off tx off

Can I ask/get you to make sure that Ethernet flow-control is disabled
(on both generator and DUT (to be on safe-side)) and run the test again?

--Jesper

>> e.g.
>>    root@imx8mpevk:~# ./xdp2 eth0
>>    proto 17:     135817 pkt/s
>>    proto 17:     142776 pkt/s
>>
>>> proto 17:     260373 pkt/s
>>> proto 17:     260363 pkt/s
>>> proto 17:     259036 pkt/s
[...]
>>>
>>> After using the sync suggestion, the result shows as follow.
>>> root@imx8mpevk:~# ./xdp2 eth0
>>> proto 17:     255956 pkt/s
>>> proto 17:     255841 pkt/s
>>> proto 17:     255835 pkt/s

