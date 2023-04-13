Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A56E133A
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjDMRKj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDMRKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 13:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9159F4
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681405789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5dv4XAyW10/07F5EnvMKRPv3TLobZcUlN4bcbi+kaA=;
        b=fIKGaOGaC1XkGwTcSQHcS3m60Bv41dD9LtF4cbZHk6+e+p1jXwFqsI7PHV/ekDQeJ+2ssG
        ripKB7xBdfYc2zTVoZ4Ui5esMIhJ5qBqQnYob5XZc7wm+j/L6+M6tTrV8o7I69JMncpxvd
        +NtF1Y800XKQO3mYm2fybC+9OlwOdeA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-lRwz3H-LPCCmZeFYklv7NQ-1; Thu, 13 Apr 2023 13:09:48 -0400
X-MC-Unique: lRwz3H-LPCCmZeFYklv7NQ-1
Received: by mail-ed1-f70.google.com with SMTP id a26-20020a509b5a000000b004acbe232c03so8446172edj.9
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 10:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405787; x=1683997787;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5dv4XAyW10/07F5EnvMKRPv3TLobZcUlN4bcbi+kaA=;
        b=Djw+Rvc3jRvCx6bl2wzcUbY1cQt0vTlWd+FKmrop8bWwcuDY/6SIF/Za1O4LKndQDo
         CR1fozo7mKqo1sg1bqex2xWS5eAe95nWwUi3VcAhEbhWUwFW6OSoRCh9H3u2FnYYGchX
         E82AX8yEGdAk5xmlG6rXccAAa2O5P1Vj5jDocUcYvhX83GeFGXBXEcPV2M5t/A4nrtAg
         7zhYiUnBNtRyIG1ey4WK5uyqWZHD36CkHX3M5cHQr6AtT5G+0hR4PG6CsDFwDJNCKWxi
         vasd5+dpjVzXmlcRlCFK22xnwj48vubdtKmSHpB7agFdW7GeJMH0tvLhWObSkzsH9QVK
         wisQ==
X-Gm-Message-State: AAQBX9dvDPPkp20pE0RiIorF/hE6b+YeHVS4Vl9IgOHJ1+eF6bKnrwQs
        RLJZecvxuKzRSwQBytTh3OsMnb8LjMSu4cdLzqQGZMUXkobaWhE8B9Tz66dm35tSmqkvCjwYQNx
        aYaboLXP6ewrF
X-Received: by 2002:a17:906:2a56:b0:94c:6762:e20d with SMTP id k22-20020a1709062a5600b0094c6762e20dmr2839486eje.12.1681405787184;
        Thu, 13 Apr 2023 10:09:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350auwQSXJLuDYzIzYzD6jbuy2PcON1aKDR6Ey77ueObIYZvvDUCwgZNOif1QefTp6UAXXc042g==
X-Received: by 2002:a17:906:2a56:b0:94c:6762:e20d with SMTP id k22-20020a1709062a5600b0094c6762e20dmr2839449eje.12.1681405786887;
        Thu, 13 Apr 2023 10:09:46 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090664c800b0094b360a281dsm1221750ejn.123.2023.04.13.10.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 10:09:46 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <203ab7d9-3695-f734-92b5-503118444108@redhat.com>
Date:   Thu, 13 Apr 2023 19:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH net-next v4 1/3] net: stmmac: introduce wrapper for struct
 xdp_buff
Content-Language: en-US
To:     Song Yoong Siang <yoong.siang.song@intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
References: <20230413032541.885238-1-yoong.siang.song@intel.com>
 <20230413032541.885238-2-yoong.siang.song@intel.com>
In-Reply-To: <20230413032541.885238-2-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 13/04/2023 05.25, Song Yoong Siang wrote:
> Introduce struct stmmac_xdp_buff as a preparation to support XDP Rx
> metadata via kfuncs.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  4 ++++
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++---------
>   2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 3d15e1e92e18..ac8ccf851708 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -92,6 +92,10 @@ struct stmmac_rx_buffer {
>   	dma_addr_t sec_addr;
>   };
>   
> +struct stmmac_xdp_buff {
> +	struct xdp_buff xdp;
> +};
> +
>   struct stmmac_rx_queue {
>   	u32 rx_count_frames;
>   	u32 queue_index;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d7fcab057032..6ffce52ca837 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5188,9 +5188,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>   	int status = 0, coe = priv->hw->rx_csum;
>   	unsigned int next_entry = rx_q->cur_rx;
>   	enum dma_data_direction dma_dir;
> +	struct stmmac_xdp_buff ctx = {};

This code trick {} will zero out the struct.

Is this done purpose and really needed?

On x86_64 this unfortunately generates an asm instruction: rep stos

A repeated store string operation, for zeroing out memory, which is
slow. (Because[1] it supports be suspended by an exception or interrupt,
which requires it to store/restore CPU flags).

[1] https://www.felixcloutier.com/x86/rep:repe:repz:repne:repnz#tbl-4-22


>   	unsigned int desc_size;
>   	struct sk_buff *skb = NULL;
> -	struct xdp_buff xdp;
>   	int xdp_status = 0;
>   	int buf_sz;
>   
> @@ -5311,17 +5311,17 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>   			dma_sync_single_for_cpu(priv->device, buf->addr,
>   						buf1_len, dma_dir);
>   
> -			xdp_init_buff(&xdp, buf_sz, &rx_q->xdp_rxq);
> -			xdp_prepare_buff(&xdp, page_address(buf->page),
> +			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
> +			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
>   					 buf->page_offset, buf1_len, false);
>   
> -			pre_len = xdp.data_end - xdp.data_hard_start -
> +			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
>   				  buf->page_offset;
> -			skb = stmmac_xdp_run_prog(priv, &xdp);
> +			skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
>   			/* Due xdp_adjust_tail: DMA sync for_device
>   			 * cover max len CPU touch
>   			 */
> -			sync_len = xdp.data_end - xdp.data_hard_start -
> +			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
>   				   buf->page_offset;
>   			sync_len = max(sync_len, pre_len);
>   
> @@ -5331,7 +5331,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>   
>   				if (xdp_res & STMMAC_XDP_CONSUMED) {
>   					page_pool_put_page(rx_q->page_pool,
> -							   virt_to_head_page(xdp.data),
> +							   virt_to_head_page(ctx.xdp.data),
>   							   sync_len, true);
>   					buf->page = NULL;
>   					priv->dev->stats.rx_dropped++;
> @@ -5359,7 +5359,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>   
>   		if (!skb) {
>   			/* XDP program may expand or reduce tail */
> -			buf1_len = xdp.data_end - xdp.data;
> +			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
>   
>   			skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
>   			if (!skb) {
> @@ -5369,7 +5369,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>   			}
>   
>   			/* XDP program may adjust header */
> -			skb_copy_to_linear_data(skb, xdp.data, buf1_len);
> +			skb_copy_to_linear_data(skb, ctx.xdp.data, buf1_len);
>   			skb_put(skb, buf1_len);
>   
>   			/* Data payload copied into SKB, page ready for recycle */

