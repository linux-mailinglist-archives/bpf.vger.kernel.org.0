Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B32596D6D
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiHQLSJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 07:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiHQLSI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 07:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C7B88
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660735085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydY6cJx0pclWkJPMpKzWti/elKURftRB5jlFflR3WtA=;
        b=Z7UWtKSyEu5w09WMfpcX9/e4mWuC8VlbJIHmEYqyP0hqAEs6nHiIhWu30ORKgWe78Ku12x
        wLCukPo/mkQjYHCTVK7uhzUgjcPJK+IRXxr40qL/Udfgvsg0a86VRugJIoEhxNGlzslNrS
        TUyLcjpQ7AU9ei9Su0d+sWMf9cpMAo4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-ydex7u4-M0uuv-6VfXvQ9g-1; Wed, 17 Aug 2022 07:18:04 -0400
X-MC-Unique: ydex7u4-M0uuv-6VfXvQ9g-1
Received: by mail-lj1-f200.google.com with SMTP id l6-20020a2ea306000000b0025ff55d64afso4073517lje.0
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc;
        bh=ydY6cJx0pclWkJPMpKzWti/elKURftRB5jlFflR3WtA=;
        b=hBKukiJhQt0TQiMmtcP4Lw+ea695cTiWf7mjjSsWXJrFWe72T6DSObqc+OzD3KlK21
         UwunFKeLEMA1r4nGFSnFaPNQ+VK1OUTdEfA1zqPCBY7Pmuw8qFRltZCNH0TVJD3JlzYo
         nTGk4cm6PEc53Dts+QARiF67Ajo8ur3LGLWEPpIsWC8f8Fh/e3q4+RHTXyzfjEoYm/sO
         EUs2GtqWtoKF196hyYKKr8V6PnhsvaeV5MJBwZIKcs1gBk6RSUIXaS48g37oN3C5bLRq
         EyvN88TYJzNLA8Rmq3/JWzcHSukusmFoxTRuyUA9i6WUfJ4VKnbV8Gy3CCVYYhqtYWJN
         2W/g==
X-Gm-Message-State: ACgBeo3pP20bv0pg7UtqlHsnrPGxTUvuGZRE+ivgvT8kZLxJbnWwCF4b
        tNe+n02LEMJntSr3nb7LezS9qxGi7ZaDo7nQM/jYWEkuDIsWwJ69V0CWjWDiLiILrgfyMMwPKaz
        9t7lGSR7rYDzf
X-Received: by 2002:a2e:a791:0:b0:25e:7673:4402 with SMTP id c17-20020a2ea791000000b0025e76734402mr7533795ljf.263.1660735082571;
        Wed, 17 Aug 2022 04:18:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4WoTOUkS9CPELsQaHddTcAUuzEaN30t96gxPZoVKQ6BkZraZL31G6/SpxChA7MmIArnWYfWg==
X-Received: by 2002:a2e:a791:0:b0:25e:7673:4402 with SMTP id c17-20020a2ea791000000b0025e76734402mr7533784ljf.263.1660735082374;
        Wed, 17 Aug 2022 04:18:02 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id a20-20020a056512201400b0048aeff37812sm1640075lfb.308.2022.08.17.04.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 04:18:01 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <ccccfb6b-b72f-382f-48f6-c639b8b0b2cd@redhat.com>
Date:   Wed, 17 Aug 2022 13:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
        hawk@kernel.org, john.fastabend@gmail.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH bpf-next] xdp: report rx queue index in xdp_frame
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
References: <181f994e13c816116fa69a1e92c2f69e6330f749.1658746417.git.lorenzo@kernel.org>
In-Reply-To: <181f994e13c816116fa69a1e92c2f69e6330f749.1658746417.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 25/07/2022 12.56, Lorenzo Bianconi wrote:
> Report rx queue index in xdp_frame according to the xdp_buff xdp_rxq_info
> pointer. xdp_frame queue_index is currently used in cpumap code to covert
> the xdp_frame into a xdp_buff.

Hmm, I'm unsure about this change, because the XDP-hints will also
contain the rx_queue number.

I do think it is relevant for the BPF-prog to get access to the rx_queue
index, because it can be used for scaling the workload.

> xdp_frame size is not increased adding queue_index since an alignment padding
> in the structure is used to insert queue_index field.

The rx_queue could be reduced from u32 to u16, but it might be faster to
keep it u32, and reduce it when others need the space.

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   include/net/xdp.h   | 2 ++
>   kernel/bpf/cpumap.c | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 04c852c7a77f..3567866b0af5 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -172,6 +172,7 @@ struct xdp_frame {
>   	struct xdp_mem_info mem;
>   	struct net_device *dev_rx; /* used by cpumap */
>   	u32 flags; /* supported values defined in xdp_buff_flags */
> +	u32 queue_index;
>   };
>   
>   static __always_inline bool xdp_frame_has_frags(struct xdp_frame *frame)
> @@ -301,6 +302,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
>   
>   	/* rxq only valid until napi_schedule ends, convert to xdp_mem_info */
>   	xdp_frame->mem = xdp->rxq->mem;
> +	xdp_frame->queue_index = xdp->rxq->queue_index;
>   
>   	return xdp_frame;
>   }
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index f4860ac756cd..09a792d088b3 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -228,7 +228,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>   
>   		rxq.dev = xdpf->dev_rx;
>   		rxq.mem = xdpf->mem;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index = xdpf->queue_index;
>   
>   		xdp_convert_frame_to_buff(xdpf, &xdp);
>   

