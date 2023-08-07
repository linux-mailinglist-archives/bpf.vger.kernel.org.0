Return-Path: <bpf+bounces-7162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC3E77253D
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EC1281399
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C01079C;
	Mon,  7 Aug 2023 13:15:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77BFC02;
	Mon,  7 Aug 2023 13:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A126C433C8;
	Mon,  7 Aug 2023 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691414128;
	bh=88hsxuLYKVqz+P+8ZpynUOYXC8Wm0wXVKKrSqpdIOug=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YBlxm7LoLK6UmjBK4jHs58gD/F3lMu8Psw28IA2IEDXh91vGWSHe8iy/TkSyK9xwW
	 c8kzPYJenw58/QcIgmbbrA/KRPaAxgoYmIbBRiNcPs1CQrRbs+NrbYC49S1idtv2b2
	 MsIzeZ4+TtaZHwa72bA6i1nObVOXVppYOnw4gnMWENf/IZ5YBEuFjAeaGmG08V3CzQ
	 085e8YnnB/+yGlXA1bNO0HxKycKBUEfEkHH4oOeAD9MjwhLoHMuiAIKebV4JheCZFz
	 abhEd2A1BgcsJRB4rvZboGli8P4Jo5OGVMGim9lROetRRF6ibt0oUzo0I29hkjkBU1
	 UDSl/2scXRsew==
Message-ID: <8fd0313b-8f6f-9814-247d-c2687d053e2a@kernel.org>
Date: Mon, 7 Aug 2023 15:15:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: "davem@davemloft.net" <davem@davemloft.net>,
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
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
 <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
 <AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <ba96db35-2273-9cc5-9a32-e924e8eff37c@kernel.org>
 <AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/08/2023 12.30, Wei Fang wrote:
>>> The flow-control was not disabled before, so according to your
>>> suggestion, I disable the flow-control on the both boards and run the
>>> test again, the performance is slightly improved, but still can not
>>> see a clear difference between the two methods. Below are the results.
>>
>> Something else must be stalling the CPU.
>> When looking at fec_main.c code, I noticed that
>> fec_enet_txq_xmit_frame() will do a MMIO write for every xdp_frame (to
>> trigger transmit start), which I believe will stall the CPU.
>> The ndo_xdp_xmit/fec_enet_xdp_xmit does bulking, and should be the
>> function that does the MMIO write to trigger transmit start.
>>
> We'd better keep a MMIO write for every xdp_frame on txq, as you know,
> the txq will be inactive when no additional ready descriptors remain in the
> tx-BDR. So it may increase the delay of the packets if we do a MMIO write
> for multiple packets.
> 

You know this hardware better than me, so I will leave to you.

>> $ git diff
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c
>> index 03ac7690b5c4..57a6a3899b80 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -3849,9 +3849,6 @@ static int fec_enet_txq_xmit_frame(struct
>> fec_enet_private *fep,
>>
>>           txq->bd.cur = bdp;
>>
>> -       /* Trigger transmission start */
>> -       writel(0, txq->bd.reg_desc_active);
>> -
>>           return 0;
>>    }
>>
>> @@ -3880,6 +3877,9 @@ static int fec_enet_xdp_xmit(struct net_device
>> *dev,
>>                   sent_frames++;
>>           }
>>
>> +       /* Trigger transmission start */
>> +       writel(0, txq->bd.reg_desc_active);
>> +
>>           __netif_tx_unlock(nq);
>>
>>           return sent_frames;
>>
>>
>>> Result: use "sync_dma_len" method
>>> root@imx8mpevk:~# ./xdp2 eth0
>>
>> The xdp2 (and xdp1) program(s) have a performance issue (due to using
>>
>> Can I ask you to test using xdp_rxq_info, like:
>>
>>    sudo ./xdp_rxq_info --dev mlx5p1 --action XDP_TX
>>
> Yes, below are the results, the results are also basically the same.
> Result 1: current method
> ./xdp_rxq_info --dev eth0 --action XDP_TX
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       259,102     0
> XDP-RX CPU      total   259,102
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index    0:0   259,102     0
> rx_queue_index    0:sum 259,102
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       259,498     0
> XDP-RX CPU      total   259,498
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index    0:0   259,496     0
> rx_queue_index    0:sum 259,496
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       259,408     0
> XDP-RX CPU      total   259,408
> 
> Result 2: dma_sync_len method
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       258,254     0
> XDP-RX CPU      total   258,254
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index    0:0   258,254     0
> rx_queue_index    0:sum 258,254
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       259,316     0
> XDP-RX CPU      total   259,316
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index    0:0   259,318     0
> rx_queue_index    0:sum 259,318
> Running XDP on dev:eth0 (ifindex:2) action:XDP_TX options:swapmac
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      0       259,554     0
> XDP-RX CPU      total   259,554
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index    0:0   259,553     0
> rx_queue_index    0:sum 259,553
> 

Thanks for running this.

>>
>>> proto 17:     258886 pkt/s
>>> proto 17:     258879 pkt/s
>>
>> If you provide numbers for xdp_redirect, then we could better evaluate if
>> changing the lock per xdp_frame, for XDP_TX also, is worth it.
>>
> For XDP_REDIRECT, the performance show as follow.
> root@imx8mpevk:~# ./xdp_redirect eth1 eth0
> Redirecting from eth1 (ifindex 3; driver st_gmac) to eth0 (ifindex 2; driver fec)

This is not exactly the same as XDP_TX setup as here you choose to 
redirect between eth1 (driver st_gmac) and to eth0 (driver fec).

I would like to see eth0 to eth0 XDP_REDIRECT, so we can compare to 
XDP_TX performance.
Sorry for all the requests, but can you provide those numbers?

> eth1->eth0        221,642 rx/s       0 err,drop/s      221,643 xmit/s

So, XDP_REDIRECT is approx (1-(221825/259554))*100 = 14.53% slower.
But as this is 'eth1->eth0' this isn't true comparison to XDP_TX.

> eth1->eth0        221,761 rx/s       0 err,drop/s      221,760 xmit/s
> eth1->eth0        221,793 rx/s       0 err,drop/s      221,794 xmit/s
> eth1->eth0        221,825 rx/s       0 err,drop/s      221,825 xmit/s
> eth1->eth0        221,823 rx/s       0 err,drop/s      221,821 xmit/s
> eth1->eth0        221,815 rx/s       0 err,drop/s      221,816 xmit/s
> eth1->eth0        222,016 rx/s       0 err,drop/s      222,016 xmit/s
> eth1->eth0        222,059 rx/s       0 err,drop/s      222,059 xmit/s
> eth1->eth0        222,085 rx/s       0 err,drop/s      222,089 xmit/s
> eth1->eth0        221,956 rx/s       0 err,drop/s      221,952 xmit/s
> eth1->eth0        222,070 rx/s       0 err,drop/s      222,071 xmit/s
> eth1->eth0        222,017 rx/s       0 err,drop/s      222,017 xmit/s
> eth1->eth0        222,069 rx/s       0 err,drop/s      222,067 xmit/s
> eth1->eth0        221,986 rx/s       0 err,drop/s      221,987 xmit/s
> eth1->eth0        221,932 rx/s       0 err,drop/s      221,936 xmit/s
> eth1->eth0        222,045 rx/s       0 err,drop/s      222,041 xmit/s
> eth1->eth0        222,014 rx/s       0 err,drop/s      222,014 xmit/s
>    Packets received    : 3,772,908
>    Average packets/s   : 221,936
>    Packets transmitted : 3,772,908
>    Average transmit/s  : 221,936
>> And also find out of moving the MMIO write have any effect.
>>
> I move the MMIO write to fec_enet_xdp_xmit(), the result shows as follow,
> the performance is slightly improved.
> 

I'm puzzled that moving the MMIO write isn't change performance.

Can you please verify that the packet generator machine is sending more
frame than the system can handle?

(meaning the pktgen_sample03_burst_single_flow.sh script fast enough?)

> root@imx8mpevk:~# ./xdp_redirect eth1 eth0
> Redirecting from eth1 (ifindex 3; driver st_gmac) to eth0 (ifindex 2; driver fec)
> eth1->eth0        222,666 rx/s        0 err,drop/s      222,668 xmit/s
> eth1->eth0        221,663 rx/s        0 err,drop/s      221,664 xmit/s
> eth1->eth0        222,743 rx/s        0 err,drop/s      222,741 xmit/s
> eth1->eth0        222,917 rx/s        0 err,drop/s      222,923 xmit/s
> eth1->eth0        221,810 rx/s        0 err,drop/s      221,808 xmit/s
> eth1->eth0        222,891 rx/s        0 err,drop/s      222,888 xmit/s
> eth1->eth0        222,983 rx/s        0 err,drop/s      222,984 xmit/s
> eth1->eth0        221,655 rx/s        0 err,drop/s      221,653 xmit/s
> eth1->eth0        222,827 rx/s        0 err,drop/s      222,827 xmit/s
> eth1->eth0        221,728 rx/s        0 err,drop/s      221,728 xmit/s
> eth1->eth0        222,790 rx/s        0 err,drop/s      222,789 xmit/s
> eth1->eth0        222,874 rx/s        0 err,drop/s      222,874 xmit/s
> eth1->eth0        221,888 rx/s        0 err,drop/s      221,887 xmit/s
> eth1->eth0        223,057 rx/s        0 err,drop/s      223,056 xmit/s
> eth1->eth0        222,219 rx/s        0 err,drop/s      222,220 xmit/s
>    Packets received    : 3,336,711
>    Average packets/s   : 222,447
>    Packets transmitted : 3,336,710
>    Average transmit/s  : 222,447
> 
>> I also noticed driver does a MMIO write (on rxq) for every RX-packet in
>> fec_enet_rx_queue() napi-poll loop.  This also looks like a potential
>> performance stall.
>>
> The same as txq, the rxq will be inactive if the rx-BDR has no free BDs, so we'd
> better do a MMIO write when we recycle a BD, so that the hardware can timely
> attach the received pakcets on the rx-BDR.
> 
> In addition, I also tried to avoid using xdp_convert_buff_to_frame(), but the
> performance of XDP_TX is still not improved. :(
> 

I would not expect much performance improvement from this anyhow.

> After these days of testing, I think it's best to keep the solution in V3, and then
> make some optimizations on the V3 patch.

I agree.

I think you need to send a V5, and then I can ACK that.

Thanks for all this testing,
--Jesper

