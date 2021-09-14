Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C740B47D
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhINQY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhINQY1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 12:24:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963BC061574;
        Tue, 14 Sep 2021 09:23:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e26so9799315wmk.2;
        Tue, 14 Sep 2021 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tr01GyylZI3UqnYy8BOTfLJTw33JZGlyWNDynz0Qkkw=;
        b=FteU91coMdxZbAl75VSMmNvxsOAWUHsCPDccDkza5yL3jzYBKPOE+Dp1H0eNfozggC
         /mwK9HjkB3aFsO5iO/q6XylTI3apuzGumCgF5F+slkP3kGnW1cVJuwDyZVDDmp4x1u/U
         qm8mT1I4CMu8B6RYiBbEjPiVWJ+IiC+7SG9REaNzcdBp3lQhxuf5hzRr5nSkNkmGHYty
         MpJCNaNdkC+IGfH4pGDeCIvfbdkAYvpxs5QSYU9Hewqhygyme22SBsinVHUQEi0O08US
         CzfiOnLKfxzkEdRYH3b2oxZRfygWwqiMRGyFoCVCySMK4w858ikEeGcW+ePBdCGAzjjc
         jIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tr01GyylZI3UqnYy8BOTfLJTw33JZGlyWNDynz0Qkkw=;
        b=QUhbD3CzrZg6VmHHlUNiVIQD8BRg+xkG98LWe381vaTU9xWcKIcMTQNeU5YCqi70CV
         mTJHCW8yL5cf00RjyPih0quenNXcsIWy4+KD7QuaDTUHFiR+2ADdGFD5BB9qOx2xhU1j
         LHyD8eR2DNH6vBLbTveZJrx0Yzm6e2i515SgDLyetBxKHANbVuE8Lg/VrpyaIQjUyWr/
         Ci19zz+DxqroILoQFL+gT/xm75AQoXsYN2VPAnK+ELA6FwjsuFfgzB1j8Ub0MDyxA5jL
         yZWCZjmgSr3XVdPBj3+cTgzBx2sXQOL3+EDtkCRn1gz8FZ3OmFUPLJeT55bgWT6THISZ
         bckQ==
X-Gm-Message-State: AOAM531vvK4wfrpiGPcbKbKVW/8yTnOUiH5jHC5n1RQx/esha4lHMsKf
        AxtOylYTliIk1OLN7Ne/j0752ZyTR2w=
X-Google-Smtp-Source: ABdhPJxVsFb7xtLnTbDOW+el3/vhtjPpsfqUkbre3TQcUDgr+LdnC6D5Flc3FAItwfEAKl8rC+G4GA==
X-Received: by 2002:a05:600c:350f:: with SMTP id h15mr3150424wmq.144.1631636588480;
        Tue, 14 Sep 2021 09:23:08 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:c813:4da2:f58a:a1e2? (p200300ea8f084500c8134da2f58aa1e2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:c813:4da2:f58a:a1e2])
        by smtp.googlemail.com with ESMTPSA id f7sm1579760wmh.20.2021.09.14.09.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:23:08 -0700 (PDT)
To:     Guilin Tang <tangguilin@uniontech.com>, nic_swsd@realtek.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <cover.1631610501.git.tangguilin@uniontech.com>
 <9d6f2c902c118108d3ebd18adca2542c61490f82.1631610502.git.tangguilin@uniontech.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] r8169: ADD XDP support for redirect action
Message-ID: <beac05a2-ad5a-ddb0-4f59-8884147635af@gmail.com>
Date:   Tue, 14 Sep 2021 18:15:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9d6f2c902c118108d3ebd18adca2542c61490f82.1631610502.git.tangguilin@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 14.09.2021 11:31, Guilin Tang wrote:
> Implement XDP_REDIRECT based on the r8169 XDP implementation.
> Can use sample/bpf/xdpsock test.
> 
> Signed-off-by: Guilin Tang <tangguilin@uniontech.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 78 +++++++++++++++++++----
>  1 file changed, 65 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 69bc3c68e73d..b56899530ed5 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -69,6 +69,8 @@
>  
>  #define R8169_REGS_SIZE		256
>  #define R8169_RX_BUF_SIZE	(SZ_16K - 1)
> +/*Reserve space for XDP frame*/
> +#define R8169_RX_XDP_BUF_SIZE	(R8169_RX_BUF_SIZE - XDP_PACKET_HEADROOM)
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> @@ -645,6 +647,7 @@ struct rtl8169_private {
>  	u32 ocp_base;
>  	/*xdp bpf*/
>  	struct bpf_prog *rtl_xdp;
> +	struct xdp_rxq_info rtl_rxq;
>  };
>  
>  typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
> @@ -2516,7 +2519,7 @@ static void rtl_set_tx_config_registers(struct rtl8169_private *tp)
>  static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  {
>  	/* Low hurts. Let's disable the filtering. */
> -	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
> +	RTL_W16(tp, RxMaxSize, R8169_RX_XDP_BUF_SIZE + 1);

You shouldn't have to change this value. Max mtu is 9k and this
16k buffer is used due to hw bug on an older chip versions.

>  }
>  
>  static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
> @@ -3866,7 +3869,7 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
>  	desc->opts2 = 0;
>  	/* Force memory writes to complete before releasing descriptor */
>  	dma_wmb();
> -	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_XDP_BUF_SIZE));
>  }
>  
>  static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
> @@ -3881,7 +3884,8 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  	if (!data)
>  		return NULL;
>  
> -	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
> +	mapping = dma_map_page(d, data, XDP_PACKET_HEADROOM,
> +			R8169_RX_XDP_BUF_SIZE, DMA_FROM_DEVICE);
>  	if (unlikely(dma_mapping_error(d, mapping))) {
>  		netdev_err(tp->dev, "Failed to map RX DMA!\n");
>  		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
> @@ -3901,19 +3905,28 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)
>  	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
>  		dma_unmap_page(tp_to_dev(tp),
>  			       le64_to_cpu(tp->RxDescArray[i].addr),
> -			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
> +			       R8169_RX_XDP_BUF_SIZE, DMA_FROM_DEVICE);
>  		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
>  		tp->Rx_databuff[i] = NULL;
>  		tp->RxDescArray[i].addr = 0;
>  		tp->RxDescArray[i].opts1 = 0;
>  	}
>  	tp->rtl_xdp = NULL;
> +	xdp_rxq_info_unreg(&tp->rtl_rxq);
>  }
>  
>  static int rtl8169_rx_fill(struct rtl8169_private *tp)
>  {
>  	int i;
>  
> +	if (xdp_rxq_info_reg(&tp->rtl_rxq, tp->dev, 0, 0))
> +		return -1;

Again, if you need an errno, use an errno.

> +
> +	if (xdp_rxq_info_reg_mem_model(&tp->rtl_rxq, MEM_TYPE_PAGE_SHARED, NULL)) {
> +		xdp_rxq_info_unreg(&tp->rtl_rxq);
> +		return -1;
> +	}
> +
>  	for (i = 0; i < NUM_RX_DESC; i++) {
>  		struct page *data;
>  
> @@ -4513,24 +4526,50 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
>  		skb_checksum_none_assert(skb);
>  }
>  
> +struct page *rtl8169_realloc_rx_data(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	struct page *data = NULL;
> +
> +	do {
> +		data = rtl8169_alloc_rx_data(tp, desc);
> +	} while (data == NULL);
> +
> +	return data;
> +}
> +
>  static struct sk_buff *rtl8619_run_xdp(struct rtl8169_private *tp, struct bpf_prog *xdp_prog,
> -				void *rx_buf, unsigned int pkt_size)
> +				void *rx_buf, unsigned int pkt_size, unsigned int entry)
>  {
> -	int result = R8169_XDP_PASS;
> +	int err, result = R8169_XDP_PASS;
>  	struct xdp_buff xdp;
>  	u32 act;
> +	struct RxDesc *desc = tp->RxDescArray + entry;
>  
> -	xdp.data = rx_buf;
> -	xdp.data_end = xdp.data + pkt_size;
> -	xdp_set_data_meta_invalid(&xdp);
> +	xdp_init_buff(&xdp, R8169_RX_XDP_BUF_SIZE, &tp->rtl_rxq);
> +	xdp_prepare_buff(&xdp, (unsigned char *)rx_buf, XDP_PACKET_HEADROOM, pkt_size, true);
> +	prefetchw(xdp.data_hard_start);
>  
>  	act = bpf_prog_run_xdp(xdp_prog, &xdp);
>  	switch (act) {
>  	case XDP_PASS:
>  		break;
>  	case XDP_TX:
> -	case XDP_REDIRECT:
>  		goto out_failure;
> +	case XDP_REDIRECT:
> +		/*unmap dma page*/
> +		dma_unmap_page(tp_to_dev(tp), le64_to_cpu(desc->addr),
> +			R8169_RX_XDP_BUF_SIZE, DMA_FROM_DEVICE);
> +		err = xdp_do_redirect(tp->dev, &xdp, xdp_prog);
> +		if (unlikely(err)) {
> +			/*free page*/
> +			__free_pages(tp->Rx_databuff[entry], get_order(R8169_RX_BUF_SIZE));
> +			/*realloc*/
> +			tp->Rx_databuff[entry] = rtl8169_realloc_rx_data(tp, desc);

Why this reallocation?

> +			goto out_failure;
> +		} else {
> +			result = R8169_XDP_REDIR;
> +		}
> +		break;
>  	default:
>  		bpf_warn_invalid_xdp_action(act);
>  		fallthrough;
> @@ -4551,6 +4590,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  	struct device *d = tp_to_dev(tp);
>  	int count;
>  	struct bpf_prog *xdp_prog;
> +	unsigned int xdp_xmit = 0;
>  
>  	for (count = 0; count < budget; count++, tp->cur_rx++) {
>  		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
> @@ -4607,9 +4647,18 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		//Determine whether to execute xdp
>  		xdp_prog = READ_ONCE(tp->rtl_xdp);
>  		if (xdp_prog) {
> -			skb = rtl8619_run_xdp(tp, xdp_prog, (void *)rx_buf, pkt_size);
> +			skb = rtl8619_run_xdp(tp, xdp_prog, (void *)rx_buf, pkt_size, entry);
>  			if (IS_ERR(skb)) {
> -				dev->stats.rx_dropped++;
> +				unsigned int xdp_res = -PTR_ERR(skb);
> +
> +				if (xdp_res & R8169_XDP_REDIR) {
> +					tp->Rx_databuff[entry] = rtl8169_realloc_rx_data(tp, desc);

Why this reallocation?

> +					xdp_xmit |= xdp_res;
> +					dev->stats.rx_packets++;

Why not use dev_sw_netstats_rx_add() like in standard path?

> +					dev->stats.rx_bytes += pkt_size;
> +				} else {
> +					dev->stats.rx_dropped++;
> +				}
>  				goto release_descriptor;
>  			}
>  		}
> @@ -4620,7 +4669,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb_copy_to_linear_data(skb, rx_buf, pkt_size);
> +		skb_copy_to_linear_data(skb, rx_buf + XDP_PACKET_HEADROOM, pkt_size);
>  		skb->tail += pkt_size;
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
> @@ -4640,6 +4689,9 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		rtl8169_mark_to_asic(desc);
>  	}
>  
> +	if (xdp_xmit & R8169_XDP_REDIR)
> +		xdp_do_flush();
> +
>  	return count;
>  }
>  
> 

