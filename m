Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6C40B47B
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbhINQY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 12:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhINQY0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 12:24:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A0C061574;
        Tue, 14 Sep 2021 09:23:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 140so6372592wma.0;
        Tue, 14 Sep 2021 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhx8g9kLOJs9n8EqeC7ifNDTlWzgstpbrOAPnHikRV8=;
        b=TT2pODTxBeTwhbEEONAk4mx5FHGa6tfKd9025d270oWwU0q7zWavSpelWh0GJr3oQ8
         2ZMon7AQ8nC0OFc3USPVdp5+xK6cFDK0/lpbh8hhmYcMe+iX1OWJ6ZaulIzyU3yxBgu2
         WMsTkH8l4AX+09L4XCyAr+84Mcqo/OzJgTju16QbOOBbTKBo1kqZF0TfAiqyPuRhD+tl
         fRj/7QXhBXCR6vhEHxRYC9npKr35/OV567Oa4qKWfXzpCFRJcASBFg1nYTkwm6TmIHDY
         gs6il4FLiKAYEcXe3Rz17Zh+O9Cutt+a4za08ynH63Xb5rFRF2On1VSpG0gM8YLFbYJn
         hQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhx8g9kLOJs9n8EqeC7ifNDTlWzgstpbrOAPnHikRV8=;
        b=AtuptIkdjeZq74gReOy5s/P25sCzexesPhijeajhrcmEzYWDCpRdCcirYAwSHK+0r1
         wINsfGvuQoQAMlgMhSOYoznToTqXSQUlaIwFmTfbqNBbH+9yHkj/PKFQpSQvFN/YREyK
         NuvR/9qbXxldLuVDUZDeKqEgPYAA9KqC0f1RmggjU10R6XiIgv3sgMZGasgLcVb2SXGm
         m8EO019FidqYLlpQCuj6IBFuZHdvJzGhDkwvAdC3A6Bn56WARuFObLBePlOsMhKeNobF
         9CXs+Cy3/5JzcTPcJJKNUWmw/r9DAYsBR6z8OV9GstHaTYX9zehn1iTKSCIeUxkaCrfN
         z35w==
X-Gm-Message-State: AOAM531MHd6HbwIm7kPBoq4fF/rGHyvXQFYpjNCBduvanoIqd9QF4QV9
        bZWsiMk2PKRfI1QJTARlElkdlwaCtkE=
X-Google-Smtp-Source: ABdhPJw9GEbvKHFxI7zX+82ufukLLirF/bx8Ih1222P1GO+NNfSFgkEZH2rgmSipH+2fhXUG6HXyeg==
X-Received: by 2002:a1c:f607:: with SMTP id w7mr3214422wmc.65.1631636587445;
        Tue, 14 Sep 2021 09:23:07 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:c813:4da2:f58a:a1e2? (p200300ea8f084500c8134da2f58aa1e2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:c813:4da2:f58a:a1e2])
        by smtp.googlemail.com with ESMTPSA id q201sm1829986wme.2.2021.09.14.09.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:23:07 -0700 (PDT)
To:     Guilin Tang <tangguilin@uniontech.com>, nic_swsd@realtek.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <cover.1631610501.git.tangguilin@uniontech.com>
 <f20689a084c44b311c05880d2c049e70eb6cef77.1631610502.git.tangguilin@uniontech.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] r8169: Add XDP support for pass and drop actions
Message-ID: <40e45859-8b80-6942-a73a-23978a96568b@gmail.com>
Date:   Tue, 14 Sep 2021 18:05:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f20689a084c44b311c05880d2c049e70eb6cef77.1631610502.git.tangguilin@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 14.09.2021 11:31, Guilin Tang wrote:
> This commi implements simple xdp drop and pass in the r8169 driver
> 
> Signed-off-by: Guilin Tang <tangguilin@uniontech.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 99 +++++++++++++++++++++--
>  1 file changed, 94 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index d927211f8d2c..69bc3c68e73d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -30,6 +30,9 @@
>  #include <linux/ipv6.h>
>  #include <asm/unaligned.h>
>  #include <net/ip6_checksum.h>
> +#include <net/xdp.h>
> +#include <linux/bpf.h>
> +#include <linux/bpf_trace.h>
>  
>  #include "r8169.h"
>  #include "r8169_firmware.h"
> @@ -543,6 +546,12 @@ enum rtl_rx_desc_bit {
>  #define RTL_GSO_MAX_SIZE_V2	64000
>  #define RTL_GSO_MAX_SEGS_V2	64
>  
> +/* XDP */
> +#define R8169_XDP_PASS		0
> +#define R8169_XDP_DROP		BIT(0)
> +#define R8169_XDP_TX		BIT(1)
> +#define R8169_XDP_REDIR		BIT(2)
> +
>  struct TxDesc {
>  	__le32 opts1;
>  	__le32 opts2;
> @@ -634,6 +643,8 @@ struct rtl8169_private {
>  	struct rtl_fw *rtl_fw;
>  
>  	u32 ocp_base;
> +	/*xdp bpf*/
> +	struct bpf_prog *rtl_xdp;
>  };
>  
>  typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
> @@ -3896,6 +3907,7 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)
>  		tp->RxDescArray[i].addr = 0;
>  		tp->RxDescArray[i].opts1 = 0;
>  	}
> +	tp->rtl_xdp = NULL;
>  }
>  
>  static int rtl8169_rx_fill(struct rtl8169_private *tp)
> @@ -4501,10 +4513,44 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
>  		skb_checksum_none_assert(skb);
>  }
>  
> +static struct sk_buff *rtl8619_run_xdp(struct rtl8169_private *tp, struct bpf_prog *xdp_prog,
> +				void *rx_buf, unsigned int pkt_size)
> +{

Why return type struct sk_buff * and not a normal int / errno ?

> +	int result = R8169_XDP_PASS;
> +	struct xdp_buff xdp;
> +	u32 act;
> +
> +	xdp.data = rx_buf;
> +	xdp.data_end = xdp.data + pkt_size;
> +	xdp_set_data_meta_invalid(&xdp);
> +
> +	act = bpf_prog_run_xdp(xdp_prog, &xdp);
> +	switch (act) {
> +	case XDP_PASS:
> +		break;
> +	case XDP_TX:
> +	case XDP_REDIRECT:
> +		goto out_failure;
> +	default:
> +		bpf_warn_invalid_xdp_action(act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +out_failure:
> +		trace_xdp_exception(tp->dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		result = R8169_XDP_DROP;
> +		break;
> +	}
> +
> +	return ERR_PTR(-result);

Overriding errno's with own values isn't nice. If you need an errno,
use an errno.

> +}
> +
>  static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
>  {
>  	struct device *d = tp_to_dev(tp);
>  	int count;
> +	struct bpf_prog *xdp_prog;
>  
>  	for (count = 0; count < budget; count++, tp->cur_rx++) {
>  		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
> @@ -4553,17 +4599,27 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> +		addr = le64_to_cpu(desc->addr);
> +		rx_buf = page_address(tp->Rx_databuff[entry]);
> +
> +		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
> +		prefetch(rx_buf);
> +		//Determine whether to execute xdp
> +		xdp_prog = READ_ONCE(tp->rtl_xdp);
> +		if (xdp_prog) {
> +			skb = rtl8619_run_xdp(tp, xdp_prog, (void *)rx_buf, pkt_size);

Why do you hijack the skb variable? In case of no error it's overwritten
a few lines later.

> +			if (IS_ERR(skb)) {
> +				dev->stats.rx_dropped++;
> +				goto release_descriptor;
> +			}
> +		}
> +
>  		skb = napi_alloc_skb(&tp->napi, pkt_size);
>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
>  			goto release_descriptor;
>  		}
>  
> -		addr = le64_to_cpu(desc->addr);
> -		rx_buf = page_address(tp->Rx_databuff[entry]);
> -
> -		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
> -		prefetch(rx_buf);
>  		skb_copy_to_linear_data(skb, rx_buf, pkt_size);
>  		skb->tail += pkt_size;
>  		skb->len = pkt_size;
> @@ -4999,6 +5055,38 @@ static void rtl_remove_one(struct pci_dev *pdev)
>  	rtl_rar_set(tp, tp->dev->perm_addr);
>  }
>  
> +static int r8169_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf)
> +{
> +	struct rtl8169_private *tp = netdev_priv(netdev);
> +	struct bpf_prog *prog = bpf->prog, *old_prog;
> +	bool running = netif_running(netdev);
> +	bool need_reset;
> +
> +	need_reset = !!tp->rtl_xdp != !!prog;
> +

An explanation would be helpful why a reset is needed and what you
mean with reset. Using these functions outside their usual context
is at least risky.

> +	if (need_reset && running)
> +		rtl8169_close(netdev);
> +
> +	old_prog = xchg(&tp->rtl_xdp, prog);
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	if (need_reset && running)
> +		rtl_open(netdev);
> +
> +	return 0;
> +}
> +
> +static int rtl8169_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> +{
> +	switch (xdp->command) {
> +	case XDP_SETUP_PROG:
> +		return r8169_xdp_set(dev, xdp);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct net_device_ops rtl_netdev_ops = {
>  	.ndo_open		= rtl_open,
>  	.ndo_stop		= rtl8169_close,
> @@ -5013,6 +5101,7 @@ static const struct net_device_ops rtl_netdev_ops = {
>  	.ndo_set_mac_address	= rtl_set_mac_address,
>  	.ndo_eth_ioctl		= phy_do_ioctl_running,
>  	.ndo_set_rx_mode	= rtl_set_rx_mode,
> +	.ndo_bpf			= rtl8169_xdp,
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>  	.ndo_poll_controller	= rtl8169_netpoll,
>  #endif
> 

