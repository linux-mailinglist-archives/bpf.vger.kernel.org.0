Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1936E14D1
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 21:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDMTGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMTGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 15:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7576AA
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681412736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCBVyFd5BBmA+6Xv/IIgNhhtsz0B8DYXHt8AQVnFyEY=;
        b=ADZ53R42VBZxh8v38I9Xot5FvqsXejzzFSD5/8ggefm2wP9Pw+WhRxmNjrmerEPI7wJ6zi
        5D7weuwiYNx5XmDxC1mAjQNmOLPxpKMHkCzW8kftROq95hDsSVrjsBuoLVCyvMMW/Lvgi2
        4jn3epuqvvN83ARin0EZJl5XVSK0Mns=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-UjoPvLktP_-nCjgtB3zopA-1; Thu, 13 Apr 2023 15:05:35 -0400
X-MC-Unique: UjoPvLktP_-nCjgtB3zopA-1
Received: by mail-ej1-f72.google.com with SMTP id tq24-20020a170907c51800b0093138c6f2f8so5836013ejc.22
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 12:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681412734; x=1684004734;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCBVyFd5BBmA+6Xv/IIgNhhtsz0B8DYXHt8AQVnFyEY=;
        b=ZzJL8fAAhpube32tHb99VFlJng8JRIORQPLly/k0xqv2Lpiy8YL5nyN7qvJoK+ARMc
         iPoJBCLbQe/enkWvWgxZNRgZgo376yld2mBMIFnWUVSul3UN55Em9Y1zYxs+wUyFr8aE
         FhtikgbLtulnv6ebD9D4oCQaHn8dQmoCpkfJ61epMZO0XEFP2lzpVRXfjqgLzgM41+QG
         558mRHMqsh4PNeA9Fb6BIq3UCxImGE3eSkSZH3jTcCudYeX0E7E79vN3/JakY9YrzELj
         woinRqJJxR4ftMDCkY3qIKC04royV01pPIDzJxH9IPJkg5INHXvcKuB8v/JHiJdiudGW
         T32Q==
X-Gm-Message-State: AAQBX9cfOhPShAKxc6DVFISffWH2ppKL3lWiKl52q1ozpZIqiXXyVSrN
        vX2oUiSyoRyTa144rVkRfxF4jw2I+nWoH8CmeLEsrzbaQ2IZF0INbo4+qAKcqVeYOBy9k/DmERu
        MPbsvQI66frwd
X-Received: by 2002:a17:907:7783:b0:92b:f118:ef32 with SMTP id ky3-20020a170907778300b0092bf118ef32mr3344082ejc.48.1681412734069;
        Thu, 13 Apr 2023 12:05:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350b0NoeyqPTndxzzpsGhufBoItrSucdDKVSwz86SIeJfM9Bqvf0Y1jAxX92P52cAl7P9mNqd0A==
X-Received: by 2002:a17:907:7783:b0:92b:f118:ef32 with SMTP id ky3-20020a170907778300b0092bf118ef32mr3344059ejc.48.1681412733732;
        Thu, 13 Apr 2023 12:05:33 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id gz1-20020a170907a04100b0094a6ba1f5ccsm1368474ejc.22.2023.04.13.12.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 12:05:33 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <e7d81a89-da60-1da6-7966-7739ad545834@redhat.com>
Date:   Thu, 13 Apr 2023 21:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net,
        stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] igc: read before write to SRRCTL register
Content-Language: en-US
To:     Song Yoong Siang <yoong.siang.song@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        Stanislav Fomichev <sdf@google.com>
References: <20230413151222.1864307-1-yoong.siang.song@intel.com>
In-Reply-To: <20230413151222.1864307-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 13/04/2023 17.12, Song Yoong Siang wrote:
> igc_configure_rx_ring() function will be called as part of XDP program
> setup. If Rx hardware timestamp is enabled prio to XDP program setup,
> this timestamp enablement will be overwritten when buffer size is
> written into SRRCTL register.
> 
> Thus, this commit read the register value before write to SRRCTL
> register. This commit is tested by using xdp_hw_metadata bpf selftest
> tool. The tool enables Rx hardware timestamp and then attach XDP program
> to igc driver. It will display hardware timestamp of UDP packet with
> port number 9092. Below are detail of test steps and results.
[...]
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
> index 7a992befca24..b95007d51d13 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.h
> +++ b/drivers/net/ethernet/intel/igc/igc_base.h
> @@ -87,8 +87,11 @@ union igc_adv_rx_desc {
>   #define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */
>   
>   /* SRRCTL bit definitions */
> -#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
> -#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
> +#define IGC_SRRCTL_BSIZEPKT_MASK	GENMASK(6, 0)
> +#define IGC_SRRCTL_BSIZEPKT_SHIFT	10 /* Shift _right_ */
> +#define IGC_SRRCTL_BSIZEHDRSIZE_MASK	GENMASK(13, 8)
> +#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT	2  /* Shift _left_ */
> +#define IGC_SRRCTL_DESCTYPE_MASK	GENMASK(27, 25)
>   #define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
>   
>   #endif /* _IGC_BASE_H */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 25fc6c65209b..de7b21c2ccd6 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -641,7 +641,10 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
>   	else
>   		buf_size = IGC_RXBUFFER_2048;
>   
> -	srrctl = IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
> +	srrctl = rd32(IGC_SRRCTL(reg_idx));
> +	srrctl &= ~(IGC_SRRCTL_BSIZEPKT_MASK | IGC_SRRCTL_BSIZEHDRSIZE_MASK |
> +		  IGC_SRRCTL_DESCTYPE_MASK);
                   ^^
Please fix indention, moving IGC_SRRCTL_DESCTYPE_MASK such that it
aligns with IGC_SRRCTL_BSIZEPKT_MASK.  This make is easier for the eye
to spot that it is part of the negation (~).

> +	srrctl |= IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
>   	srrctl |= buf_size >> IGC_SRRCTL_BSIZEPKT_SHIFT;
>   	srrctl |= IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
>   

