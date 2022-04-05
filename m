Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3D4F411A
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389769AbiDEP0g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384598AbiDEOSP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 10:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4321511D7B1
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649163862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fzRIFCCGFmB+iA5S8VpxVvRYiZXdeCsQA0S+H3U05wI=;
        b=UrEJIW1ys4DxVVBgIJZPAlastLTWPOsYbkDBNnnKkexZkDCVQoauPjANlBnGYDIQ9tcg0X
        NMO/3TCqrUNVJQX5Qevk0pqvjpOtzgZTizHdnh8mz7lFhAPxuQcsToImxibEipYHsR8rUC
        Q5Vsk8iq1LhpNGWcz69mZez/tV//JLU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-16PBlhnKONqZMO_nyLsM-Q-1; Tue, 05 Apr 2022 09:04:21 -0400
X-MC-Unique: 16PBlhnKONqZMO_nyLsM-Q-1
Received: by mail-ed1-f70.google.com with SMTP id b24-20020a50e798000000b0041631767675so7171187edn.23
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 06:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=fzRIFCCGFmB+iA5S8VpxVvRYiZXdeCsQA0S+H3U05wI=;
        b=j/Eaf3ZzOHXVAFElZyPqRC0yC3Vv62xSege4jg6jMsXu7Mnr5jVQQRwZ8vRwkEjE27
         6eG5Uf8P0TyiYL6gFL1oS2muV72CigqP1SxXGLi+2BTpZIWiHQTqGrPQE/9P/NYIIzZb
         Fm2ZMlwmS0Ezr1dpb5pNLm4NkiAH+W/8h0Xk94r5LSF1JjVrdB+M3yxWTbefv93hUuYD
         BU8ew8l1oiowgssklaLrKWqC6L1NQHzGa/vPg76XTEtX0yT0+0+t9RagTPv9eV2hXS3u
         oP6/8pgZnQkajVmC8LJtpruha0mHB+9gVOQ0HsDf6riL9gnxEtBxDPYnkF2bAgsi0Yvx
         PH/Q==
X-Gm-Message-State: AOAM531D4rVt7u4ormwqhS6gMnJumvW+ov9RyxlLII10zVPBi8VnMaAd
        spvWoxSJY+eR2qxYNHb5yLa6uU9+EMpQ+4ZLbgqwGQphkdzKFHXMGKgkyNTTaXiuP4eD5X2u80b
        n00Ugw1b4ePOD
X-Received: by 2002:a05:6402:1941:b0:413:2b7e:676e with SMTP id f1-20020a056402194100b004132b7e676emr3583310edz.114.1649163859640;
        Tue, 05 Apr 2022 06:04:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp1RKUnKCUMwO4uT52gnvGTPVPeT+az47jhMyWGygUQOCkmYThSrOGP6A2+746Vwb01HDRrQ==
X-Received: by 2002:a05:6402:1941:b0:413:2b7e:676e with SMTP id f1-20020a056402194100b004132b7e676emr3583279edz.114.1649163859376;
        Tue, 05 Apr 2022 06:04:19 -0700 (PDT)
Received: from [192.168.2.20] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id qa30-20020a170907869e00b006df9ff41154sm5574905ejc.141.2022.04.05.06.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:04:18 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <8bb40f98-2f1f-c331-23d4-ed94a6a1ce76@redhat.com>
Date:   Tue, 5 Apr 2022 15:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, maximmi@nvidia.com,
        alexandr.lobakin@intel.com,
        Toke Hoiland Jorgensen <toke@redhat.com>
Subject: Re: [PATCH bpf-next 04/10] i40e: xsk: terminate NAPI when XSK Rx
 queue gets full
Content-Language: en-US
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        magnus.karlsson@intel.com, bjorn@kernel.org
References: <20220405110631.404427-1-maciej.fijalkowski@intel.com>
 <20220405110631.404427-5-maciej.fijalkowski@intel.com>
In-Reply-To: <20220405110631.404427-5-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
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
>   .../ethernet/intel/i40e/i40e_txrx_common.h    |  1 +
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 21 ++++++++++++-------
>   2 files changed, 15 insertions(+), 7 deletions(-)
> 
[...]

I noticed you are only doing this for the Zero-Copy variants.
Wouldn't this also be a benefit for normal AF_XDP ?


> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index c1d25b0b0ca2..9f9e4ce9a24d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -161,9 +161,10 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
>   
>   	if (likely(act == XDP_REDIRECT)) {
>   		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
> -		if (err)
> -			goto out_failure;
> -		return I40E_XDP_REDIR;
> +		if (!err)
> +			return I40E_XDP_REDIR;
> +		result = (err == -ENOBUFS) ? I40E_XDP_EXIT : I40E_XDP_CONSUMED;
> +		goto out_failure;
>   	}
>   
>   	switch (act) {
> @@ -175,6 +176,9 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
>   		if (result == I40E_XDP_CONSUMED)
>   			goto out_failure;
>   		break;
> +	case XDP_DROP:
> +		result = I40E_XDP_CONSUMED;
> +		break;
>   	default:
>   		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
>   		fallthrough;
> @@ -182,9 +186,6 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
>   out_failure:
>   		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
>   		fallthrough; /* handle aborts by dropping packet */
> -	case XDP_DROP:
> -		result = I40E_XDP_CONSUMED;
> -		break;
>   	}
>   	return result;
>   }
> @@ -370,6 +371,12 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>   		xsk_buff_dma_sync_for_cpu(bi, rx_ring->xsk_pool);
>   
>   		xdp_res = i40e_run_xdp_zc(rx_ring, bi);
> +		if (xdp_res == I40E_XDP_EXIT) {
> +			failure = true;
> +			xsk_buff_free(bi);
> +			next_to_clean = (next_to_clean + 1) & count_mask;
> +			break;
> +		}
>   		i40e_handle_xdp_result_zc(rx_ring, bi, rx_desc, &rx_packets,
>   					  &rx_bytes, size, xdp_res);
>   		total_rx_packets += rx_packets;
> @@ -382,7 +389,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>   	cleaned_count = (next_to_clean - rx_ring->next_to_use - 1) & count_mask;
>   
>   	if (cleaned_count >= I40E_RX_BUFFER_WRITE)
> -		failure = !i40e_alloc_rx_buffers_zc(rx_ring, cleaned_count);
> +		failure |= !i40e_alloc_rx_buffers_zc(rx_ring, cleaned_count);
>   
>   	i40e_finalize_xdp_rx(rx_ring, xdp_xmit);
>   	i40e_update_rx_stats(rx_ring, total_rx_bytes, total_rx_packets);
> 

