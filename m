Return-Path: <bpf+bounces-6825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8576E211
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6EF281FF6
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC113AC0;
	Thu,  3 Aug 2023 07:42:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AB9454
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:42:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5BB3C1E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691048180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5lW9yJGd0tTOcYr5wtydcMH3ilaH7qpJMhJhFacpac=;
	b=KS1SdA9QKogzudITIby50URIqbHiWRP5+xfs8QZ9r5lQMt3LygpI8b7m0K6qGvvyPr+06t
	P4cB9JTGpXQzvynVJUWvHw/cemfyKeGHI6W+1OLDr2MjfaaOg7tJGBtAawAsFaINrcHbJ3
	eGXOHGy70GYK9l0SXN4w8rOm9mhkTHc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-oZ3G3ZS9OOmcfwc1tZspUw-1; Thu, 03 Aug 2023 03:36:18 -0400
X-MC-Unique: oZ3G3ZS9OOmcfwc1tZspUw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe08e088d5so628496e87.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 00:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048177; x=1691652977;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5lW9yJGd0tTOcYr5wtydcMH3ilaH7qpJMhJhFacpac=;
        b=ZA5MsdaA6KKpKiPAYiU+SwHM1sw9cOLbdHeWIs/9jEoUVEPdJNGjhKpQzL+SJ/mUzl
         NoOYNxkv4BunKBiyBh9ouwHulUb1t87K0rq+dNGXfw7SwuI402LfbDrPCYZxc5mBpxuR
         jeIzki7LbzgBZ6eA1MFsT9aKtLIYrLLjI3Ec4rBPagVvgS56ZRsnnH9Ab/AlyoBJEUEL
         ylvJsBgZizncSOHmsmSJx2UVx1bHlTNwqRfRfppDXtFabxmSu4yNIx14mwIohEyfaTE3
         SaHMsxHjmRZHp4+JabM2N1X232Z3uBa5ZeZZ80g+gtSfBRzOJ2AC5+01d/wtN1olurCQ
         v0Mw==
X-Gm-Message-State: ABy/qLaJ+iUsQLvGfiY2xnduJcOj/ByNEbD3H9OTStdOKeCEZXSpbSya
	RFoC5EBV6/9QAZcGq4075PGqVUEnLk1IOzlIpXE3NOkjzEZMZeKQ/1kivH7RC5WnOgxDAuYIzmH
	vxJc1fSRuGfpF
X-Received: by 2002:a05:6512:5cf:b0:4f9:547c:a3cc with SMTP id o15-20020a05651205cf00b004f9547ca3ccmr5247249lfo.14.1691048176975;
        Thu, 03 Aug 2023 00:36:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHk7khmdMhPIrJx41CkIsKhng1gZd/TgR+/xDOjScGe95JF1N3aEbzr0qwR3nW3Rsl3nXk3Ig==
X-Received: by 2002:a05:6512:5cf:b0:4f9:547c:a3cc with SMTP id o15-20020a05651205cf00b004f9547ca3ccmr5247235lfo.14.1691048176425;
        Thu, 03 Aug 2023 00:36:16 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id c12-20020a056402120c00b0052241b8fd0bsm9589115edw.29.2023.08.03.00.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 00:36:15 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
Date: Thu, 3 Aug 2023 09:36:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "hawk@kernel.org" <hawk@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 03/08/2023 05.58, Wei Fang wrote:
>>>   		} else {
>>> -			xdp_return_frame(xdpf);
>>> +			xdp_return_frame_rx_napi(xdpf);
>>
>> If you implement Jesper's syncing suggestions, I think you can use
>>
>> 	page_pool_put_page(pool, page, 0, true);

To Jakub, using 0 here you are trying to bypass the DMA-sync (which is
valid as driver knows XDP_TX have already done the sync).
The code will still call into DMA-sync calls with zero as size, so
wonder if we should detect size zero and skip that call?
(I mean is this something page_pool should support.)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7ca456bfab71..778d061e4f2c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -323,7 +323,8 @@ static void page_pool_dma_sync_for_device(struct 
page_pool *pool,
         dma_addr_t dma_addr = page_pool_get_dma_addr(page);

         dma_sync_size = min(dma_sync_size, pool->p.max_len);
-       dma_sync_single_range_for_device(pool->p.dev, dma_addr,
+       if (dma_sync_size)
+               dma_sync_single_range_for_device(pool->p.dev, dma_addr,
                                          pool->p.offset, dma_sync_size,
                                          pool->p.dma_dir);



>>
>> for XDP_TX here to avoid the DMA sync on page recycle.
> 
> I tried Jasper's syncing suggestion and used page_pool_put_page() to recycle
> pages, but the results does not seem to improve the performance of XDP_TX,

The optimization will only have effect on those devices which have
dev->dma_coherent=false else DMA function [1] (e.g.
dma_direct_sync_single_for_device) will skip the sync calls.

  [1] 
https://elixir.bootlin.com/linux/v6.5-rc4/source/kernel/dma/direct.h#L63

(Cc. Andrew Lunn)
Does any of the imx generations have dma-noncoherent memory?

And does any of these use the fec NIC driver?

> it even degrades the speed.

Could be low runs simply be a variation between your test runs?

The specific device (imx8mpevk) this was tested on, clearly have
dma_coherent=true, or else we would have seen a difference.
But the code change should not have any overhead for the
dma_coherent=true case, the only extra overhead is the extra empty DMA
sync call with size zero (as discussed in top).

> 
> The result of the current modification.
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     260180 pkt/s

These results are *significantly* better than reported in patch-1.
What happened?!?

e.g.
  root@imx8mpevk:~# ./xdp2 eth0
  proto 17:     135817 pkt/s
  proto 17:     142776 pkt/s

> proto 17:     260373 pkt/s
> proto 17:     260363 pkt/s
> proto 17:     259036 pkt/s
> proto 17:     260180 pkt/s
> proto 17:     260048 pkt/s
> proto 17:     260029 pkt/s
> proto 17:     260133 pkt/s
> proto 17:     260021 pkt/s
> proto 17:     260203 pkt/s
> proto 17:     260293 pkt/s
> proto 17:     259418 pkt/s
> 
> After using the sync suggestion, the result shows as follow.
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     255956 pkt/s
> proto 17:     255841 pkt/s
> proto 17:     255835 pkt/s
> proto 17:     255381 pkt/s
> proto 17:     255736 pkt/s
> proto 17:     255779 pkt/s
> proto 17:     254135 pkt/s
> proto 17:     255584 pkt/s
> proto 17:     255855 pkt/s
> proto 17:     255664 pkt/s
> 
> Below are my changes, I don't know what cause it. Based on the results,
> it's better to keep the current modification.
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index d5fda24a4c52..415c0cb83f84 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -77,7 +77,8 @@
>   static void set_multicast_list(struct net_device *ndev);
>   static void fec_enet_itr_coal_set(struct net_device *ndev);
>   static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> -                               struct xdp_buff *xdp);
> +                               struct xdp_buff *xdp,
> +                               u32 dma_sync_len);
> 
>   #define DRIVER_NAME    "fec"
> 
> @@ -1487,7 +1488,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>                          /* Free the sk buffer associated with this last transmit */
>                          dev_kfree_skb_any(skb);
>                  } else {
> -                       xdp_return_frame_rx_napi(xdpf);
> +                       if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
> +                               xdp_return_frame_rx_napi(xdpf);
> +                       else {
> +                               struct page *page;
> +
> +                               page = virt_to_head_page(xdpf->data);
> +                               page_pool_put_page(page->pp, page, 0, true);
> +                       }
> 
>                          txq->tx_buf[index].xdp = NULL;
>                          /* restore default tx buffer type: FEC_TXBUF_T_SKB */
> @@ -1557,7 +1565,8 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
>          act = bpf_prog_run_xdp(prog, xdp);
> 
>          /* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
> -       sync = xdp->data_end - xdp->data_hard_start - FEC_ENET_XDP_HEADROOM;
> +       sync = xdp->data_end - xdp->data;
>          sync = max(sync, len);
> 
>          switch (act) {
> @@ -1579,7 +1588,7 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
>                  break;
> 
>          case XDP_TX:
> -               err = fec_enet_xdp_tx_xmit(fep->netdev, xdp);
> +               err = fec_enet_xdp_tx_xmit(fep->netdev, xdp, sync);
>                  if (unlikely(err)) {
>                          ret = FEC_ENET_XDP_CONSUMED;
>                          page = virt_to_head_page(xdp->data);
> @@ -3807,6 +3816,7 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
>   static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>                                     struct fec_enet_priv_tx_q *txq,
>                                     struct xdp_frame *frame,
> +                                  u32 dma_sync_len,
>                                     bool ndo_xmit)
>   {
>          unsigned int index, status, estatus;
> @@ -3840,7 +3850,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>                  dma_addr = page_pool_get_dma_addr(page) + sizeof(*frame) +
>                             frame->headroom;
>                  dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
> -                                          frame->len, DMA_BIDIRECTIONAL);
> +                                          dma_sync_len, DMA_BIDIRECTIONAL);
>                  txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
>          }
> 
> @@ -3889,7 +3899,8 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   }
> 
>   static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> -                               struct xdp_buff *xdp)
> +                               struct xdp_buff *xdp,
> +                               u32 dma_sync_len)
>   {
>          struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
>          struct fec_enet_private *fep = netdev_priv(ndev);
> @@ -3909,7 +3920,7 @@ static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> 
>          /* Avoid tx timeout as XDP shares the queue with kernel stack */
>          txq_trans_cond_update(nq);
> -       ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
> +       ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len, false);
> 
>          __netif_tx_unlock(nq);
> 
> @@ -3938,7 +3949,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
>          /* Avoid tx timeout as XDP shares the queue with kernel stack */
>          txq_trans_cond_update(nq);
>          for (i = 0; i < num_frames; i++) {
> -               if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
> +               if (fec_enet_txq_xmit_frame(fep, txq, frames[i], 0, true) < 0)
>                          break;
>                  sent_frames++;
>          }
> 


