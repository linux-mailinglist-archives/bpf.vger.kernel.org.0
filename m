Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D56B6E2AE6
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 22:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDNUGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDNUF7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 16:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9565A8
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681502711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8b8ehHOsU++QqrM70j/M9clO0F9dJb97/yhmghDZiY=;
        b=huMVy3fD3abj3d2rPfp3JkrMYEH2T8yvqkhMZMyFjb3/EoKGAGKgbtYUFwn7vepji0OFPd
        lw4+ZpXBbNPjzXY+kk1bZi5yb6aURbnZ/HQqE5RPDnw1vX6TUFlUg0bzw6lhTKZoEnNi2n
        ePDPcQzEecf4VuVoL6rHv4UatJgPlbg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-FCEjAF-bPpqfSmK1tJ0fuw-1; Fri, 14 Apr 2023 16:05:08 -0400
X-MC-Unique: FCEjAF-bPpqfSmK1tJ0fuw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-504728f9332so3787554a12.2
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 13:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681502707; x=1684094707;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8b8ehHOsU++QqrM70j/M9clO0F9dJb97/yhmghDZiY=;
        b=HSdA1FJ5Oix7GCQNBJwq8t2ShGK0XeCLfb0gVHGQi/5vL05ETMMv3RNUv3LfrQt3RF
         Me3MZxCXjVFzgnc+lY22mjc2Z4qGzQoURzfy4i5zVvF2K3+EwLDRShScotZPBFZfiln8
         pFIdlnNCa5cN1S2BoEhn+NTe6LKruyp3EuMHDW0hJM8wdd8+nlyvRJ2Z81/3iucy6p+X
         FhUn7jCECEle9yRztLAVvfdM++W9WsC3Gsuun9eM78FsA2o7+9DR12RLgksei/+osVBd
         LbxdjNrsDpyrihtsBDOYzYnMw9wij7igZnH2dVP0yQ8Ne/PBmM46N0Y7tTlZwv0+dgBe
         +pVA==
X-Gm-Message-State: AAQBX9d5Y2/Lf4NZJK+wF+/WWBPOC8ZOZVScbDWjlzq5xiZ/859v4FrN
        83l0EW7IEatiT+M9LWcgwbzTjYJWEkQjycOQo4uA4NQIJenndc+niy/kx/PyHi3L1OSBBPD1gI3
        hQdHMnJGYDmlS
X-Received: by 2002:aa7:d28e:0:b0:4fa:6767:817b with SMTP id w14-20020aa7d28e000000b004fa6767817bmr7724742edq.41.1681502707429;
        Fri, 14 Apr 2023 13:05:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350YxIOswwl7UdXivfvk380SENlMobnVIRpUteIMxXlizKeOqOgvOSiZA+w+CLL4G0spm0zCdMA==
X-Received: by 2002:aa7:d28e:0:b0:4fa:6767:817b with SMTP id w14-20020aa7d28e000000b004fa6767817bmr7724719edq.41.1681502707087;
        Fri, 14 Apr 2023 13:05:07 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id fy15-20020a1709069f0f00b0094a5b8791cfsm2826970ejc.109.2023.04.14.13.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 13:05:06 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <934a4204-1920-f5e1-bcde-89429554d0d6@redhat.com>
Date:   Fri, 14 Apr 2023 22:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net,
        stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] igc: read before write to SRRCTL register
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
        Stanislav Fomichev <sdf@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        David Laight <David.Laight@ACULAB.COM>
References: <20230414154902.2950535-1-yoong.siang.song@intel.com>
In-Reply-To: <20230414154902.2950535-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 14/04/2023 17.49, Song Yoong Siang wrote:
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
> 
> Command on DUT:
>    sudo ./xdp_hw_metadata <interface name>
> 
> Command on Link Partner:
>    echo -n skb | nc -u -q1 <destination IPv4 addr> 9092
> 
> Result before this patch:
>    skb hwtstamp is not found!
> 
> Result after this patch:
>    found skb hwtstamp = 1677800973.642836757
> 
> Optionally, read PHC to confirm the values obtained are almost the same:
> Command:
>    sudo ./testptp -d /dev/ptp0 -g
> Result:
>    clock time: 1677800973.913598978 or Fri Mar  3 07:49:33 2023
> 
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Cc: <stable@vger.kernel.org> # 5.14+
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---

LGTM, thank for the adjustments :-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

> v2 -> v3: Refactor SRRCTL definitions to more human readable definitions
> v1 -> v2: Fix indention
> ---
>   drivers/net/ethernet/intel/igc/igc_base.h | 11 ++++++++---
>   drivers/net/ethernet/intel/igc/igc_main.c |  7 +++++--
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
> index 7a992befca24..9f3827eda157 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.h
> +++ b/drivers/net/ethernet/intel/igc/igc_base.h
> @@ -87,8 +87,13 @@ union igc_adv_rx_desc {
>   #define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */
>   
>   /* SRRCTL bit definitions */
> -#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
> -#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
> -#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
> +#define IGC_SRRCTL_BSIZEPKT_MASK	GENMASK(6, 0)
> +#define IGC_SRRCTL_BSIZEPKT(x)		FIELD_PREP(IGC_SRRCTL_BSIZEPKT_MASK, \
> +					(x) / 1024) /* in 1 KB resolution */
> +#define IGC_SRRCTL_BSIZEHDR_MASK	GENMASK(13, 8)
> +#define IGC_SRRCTL_BSIZEHDR(x)		FIELD_PREP(IGC_SRRCTL_BSIZEHDR_MASK, \
> +					(x) / 64) /* in 64 bytes resolution */
> +#define IGC_SRRCTL_DESCTYPE_MASK	GENMASK(27, 25)
> +#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	FIELD_PREP(IGC_SRRCTL_DESCTYPE_MASK, 1)
>   
>   #endif /* _IGC_BASE_H */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 25fc6c65209b..a2d823e64609 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -641,8 +641,11 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
>   	else
>   		buf_size = IGC_RXBUFFER_2048;
>   
> -	srrctl = IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
> -	srrctl |= buf_size >> IGC_SRRCTL_BSIZEPKT_SHIFT;
> +	srrctl = rd32(IGC_SRRCTL(reg_idx));
> +	srrctl &= ~(IGC_SRRCTL_BSIZEPKT_MASK | IGC_SRRCTL_BSIZEHDR_MASK |
> +		    IGC_SRRCTL_DESCTYPE_MASK);
> +	srrctl |= IGC_SRRCTL_BSIZEHDR(IGC_RX_HDR_LEN);
> +	srrctl |= IGC_SRRCTL_BSIZEPKT(buf_size);
>   	srrctl |= IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
>   
>   	wr32(IGC_SRRCTL(reg_idx), srrctl);

