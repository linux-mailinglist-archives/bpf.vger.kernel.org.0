Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603614F40F2
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbiDEOLK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389241AbiDENd3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 09:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E05CF136649
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649162206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=804HT8SjfbVYXmUKw0nZ/AD8aYvBB74vMh4fZSUu+vg=;
        b=ACrxWJE5rpQigPv/gIHcFLSXWVXpFp60QZ0vWpOs5Ryc80kJDtmqCj2JydZTVzsRbepp6/
        TkWidpUQPZBb/761y4zdkpvidV0Sa1dm+txsxcokffByXr2RyZMTyPPwY83FXgueDmivBI
        JU6NT/bXiezrh+DCxyQ67SNr9Zk5JOQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-Q2I_k_SJMveiB2_epz6khw-1; Tue, 05 Apr 2022 08:36:44 -0400
X-MC-Unique: Q2I_k_SJMveiB2_epz6khw-1
Received: by mail-ed1-f69.google.com with SMTP id o11-20020aa7c50b000000b0041cbfe481f3so4115255edq.17
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 05:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=804HT8SjfbVYXmUKw0nZ/AD8aYvBB74vMh4fZSUu+vg=;
        b=k9470xMpKMseqad3Jqb6Db8WaqZ1LdPK/7lYBEMIoIZy6CZzzQf2V5WwLlynXV9NWv
         dnqfvB4p3yLHjHEulykHe2DRYTC1dVVWo8MH1rbLNkzQa0NMTwR8DZUySwpAxpLcFNb5
         8YN2qqI1T2oT9kUtY1Lh7PsZK8sFC/j0WYw6I1NtRuYpZgob25Y6b5weOSwVpGIly0tV
         jv4h79th8LNGYpCBO7+SbN9yVQYKMeHu6XokUjQ1UT5K/5JFCfnJjnCy1EsyM81O/nnA
         JVQep/Sc9Q6zfgMp5Jwyyvs35R/VMHJi9cKELjC2WCbmD6Nco/NdF8ZmALI9aN+Oy8f8
         axvQ==
X-Gm-Message-State: AOAM533XuKeNgrXDoiWJF4Jdbuh6U9t8p7DcEMAERAWRXVc5MAvjzfkk
        ySR4Jo1wiDqGbFIm4k/R6W2cdrfBIjjvennXZqXuwoZsSaIo3dPD0kyPUdhmvS74Hv3ik+1qinE
        IyzCycLWpU9Mo
X-Received: by 2002:a50:ff02:0:b0:419:2d32:44fe with SMTP id a2-20020a50ff02000000b004192d3244femr3340870edu.49.1649162203650;
        Tue, 05 Apr 2022 05:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9AtGEgFvSWo3lUpB+5R90p9sRKfkZxZa/BELiSIH7ehc53aV1e1HVT28J/yZ5TGPjAn8ojA==
X-Received: by 2002:a50:ff02:0:b0:419:2d32:44fe with SMTP id a2-20020a50ff02000000b004192d3244femr3340851edu.49.1649162203419;
        Tue, 05 Apr 2022 05:36:43 -0700 (PDT)
Received: from [192.168.2.20] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id a1-20020a50da41000000b0041c83587300sm6014209edk.36.2022.04.05.05.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 05:36:42 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <88cf07a2-3bb6-5eda-0d99-d9491fd18669@redhat.com>
Date:   Tue, 5 Apr 2022 14:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, maximmi@nvidia.com,
        alexandr.lobakin@intel.com
Subject: Re: [PATCH bpf-next 05/10] ixgbe: xsk: terminate NAPI when XSK Rx
 queue gets full
Content-Language: en-US
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        magnus.karlsson@intel.com, bjorn@kernel.org
References: <20220405110631.404427-1-maciej.fijalkowski@intel.com>
 <20220405110631.404427-6-maciej.fijalkowski@intel.com>
In-Reply-To: <20220405110631.404427-6-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 05/04/2022 13.06, Maciej Fijalkowski wrote:
> Correlate -ENOBUFS that was returned from xdp_do_redirect() with a XSK
> Rx queue being full. In such case, terminate the softirq processing and
> let the user space to consume descriptors from XSK Rx queue so that
> there is room that driver can use later on.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 23 ++++++++++++-------
>   2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
> index bba3feaf3318..f1f69ce67420 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
> @@ -8,6 +8,7 @@
>   #define IXGBE_XDP_CONSUMED	BIT(0)
>   #define IXGBE_XDP_TX		BIT(1)
>   #define IXGBE_XDP_REDIR		BIT(2)
> +#define IXGBE_XDP_EXIT		BIT(3)
>   
>   #define IXGBE_TXD_CMD (IXGBE_TXD_CMD_EOP | \
>   		       IXGBE_TXD_CMD_RS)
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index dd7ff66d422f..475244a2c6e4 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -109,9 +109,10 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
>   
>   	if (likely(act == XDP_REDIRECT)) {
>   		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
> -		if (err)
> -			goto out_failure;
> -		return IXGBE_XDP_REDIR;
> +		if (!err)
> +			return IXGBE_XDP_REDIR;
> +		result = (err == -ENOBUFS) ? IXGBE_XDP_EXIT : IXGBE_XDP_CONSUMED;
> +		goto out_failure;
>   	}
>   
>   	switch (act) {
> @@ -130,6 +131,9 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
>   		if (result == IXGBE_XDP_CONSUMED)
>   			goto out_failure;
>   		break;
> +	case XDP_DROP:
> +		result = IXGBE_XDP_CONSUMED;
> +		break;
>   	default:
>   		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
>   		fallthrough;
> @@ -137,9 +141,6 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
>   out_failure:
>   		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
>   		fallthrough; /* handle aborts by dropping packet */
> -	case XDP_DROP:
> -		result = IXGBE_XDP_CONSUMED;
> -		break;
>   	}
>   	return result;
>   }
> @@ -304,10 +305,16 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
>   		xdp_res = ixgbe_run_xdp_zc(adapter, rx_ring, bi->xdp);
>   
>   		if (xdp_res) {
> -			if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR))
> +			if (xdp_res == IXGBE_XDP_EXIT) {

Micro optimization note: Having this as the first if()-statement
defaults the compiler to think this is the likely() case. (But compilers
can obviously be smarter and can easily choose that the IXGBE_XDP_REDIR
branch is so simple that it takes it as the likely case).
Just wanted to mention this, given this is fash-path code.

> +				failure = true;
> +				xsk_buff_free(bi->xdp);
> +				ixgbe_inc_ntc(rx_ring);
> +				break;

I was wondering if we have a situation where we should set xdp_xmit bit
to trigger the call to xdp_do_flush_map later in function, but I assume
you have this covered.

> +			} else if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR)) {
>   				xdp_xmit |= xdp_res;
> -			else
> +			} else {
>   				xsk_buff_free(bi->xdp);
> +			}
>   
>   			bi->xdp = NULL;
>   			total_rx_packets++;

