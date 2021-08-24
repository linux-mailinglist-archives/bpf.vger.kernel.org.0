Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DBF3F5F31
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhHXNdc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 09:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236661AbhHXNdb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Aug 2021 09:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629811967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeV74JQJHRoEmeq7H6kmk/7VDFwFpt82W+iJfSrcr/0=;
        b=dI2EdCmDUHfLegT7gE2mirTT4JS1N/wZjyfD3GVXwNAN9eaFKMwqMcj1hmV/50knpBiZ2g
        /ESdT/mNx2+hRPhGcaMFG1p7BMqNSgmHDxf2srr5YX0az+RRIoYMd01f5xdzczzNMI72Sy
        5hA39ROmWZE2QQPeHc2POvCHYHgS4ew=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-4j8msKO8MT2-H6oO1ME6cA-1; Tue, 24 Aug 2021 09:32:43 -0400
X-MC-Unique: 4j8msKO8MT2-H6oO1ME6cA-1
Received: by mail-wr1-f72.google.com with SMTP id m2-20020a0560000082b0290154f6e2e51fso5732989wrx.12
        for <bpf@vger.kernel.org>; Tue, 24 Aug 2021 06:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QeV74JQJHRoEmeq7H6kmk/7VDFwFpt82W+iJfSrcr/0=;
        b=Bb6ahZucb6zyNamn8/3UQvzzL6YBIAHBvyjljAOa+DO0Vr6/JNCEFV7UBoBrppxPbc
         DwC9acd0mgKu8VvBg19+FVvDf6btq/jx1+aREFtIeC1tSVkTDFADCxg/IMvvtj+uAf/j
         dBIdB006asMYL4EqRGSncDXtDSeqPYZ/y8IBW+/n7OnRj1XABfEkb3vo8kHSCDgEUtop
         wpIpVgWhkARBwzuYjxywk4Tm6QZUbuAUodJBXxmNYbO+xIjoSohzGSB9TXkcmhLvtQDa
         IV+4Ep4x9Fv/xqmlLiA0KPifyqe0CqZfrqo3eV8ws2IG6Po1UKExLVlSfD4Koqje67in
         ea/g==
X-Gm-Message-State: AOAM533vzqIBrn8YruYkPzvRup2pvsPLu4804ttstnNM8T9JDjzhZ4bS
        6qj4jiUbqzdTRca6A7A8bKKsq8GduW+MNTgCp8mXzHE1ZhSkW5o+cFREkcr1L2Mq5ZDR8dwRn5L
        MGH4rLeqk7DEE
X-Received: by 2002:a1c:9acc:: with SMTP id c195mr4245376wme.69.1629811962584;
        Tue, 24 Aug 2021 06:32:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJOUQhZGHcg+h797DWQJpPSgDrZrkLJZOaYSjluUYhh54hujkxG8C8Pjz+eoTss4z6d9NpTg==
X-Received: by 2002:a1c:9acc:: with SMTP id c195mr4245358wme.69.1629811962408;
        Tue, 24 Aug 2021 06:32:42 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id z7sm2316517wmi.4.2021.08.24.06.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 06:32:42 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Jason Xing <xingwanli@kuaishou.com>,
        Shujin Li <lishujin@kuaishou.com>,
        =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Subject: Re: [PATCH] ixgbe: let the xdpdrv work with more than 64 cpus
To:     kerneljasonxing@gmail.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org
References: <20210824104918.7930-1-kerneljasonxing@gmail.com>
Message-ID: <59dff551-2d52-5ecc-14ac-4a6ada5b1275@redhat.com>
Date:   Tue, 24 Aug 2021 15:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824104918.7930-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 24/08/2021 12.49, kerneljasonxing@gmail.com wrote:
> From: Jason Xing <xingwanli@kuaishou.com>
> 
> Originally, ixgbe driver doesn't allow the mounting of xdpdrv if the
> server is equipped with more than 64 cpus online. So it turns out that
> the loading of xdpdrv causes the "NOMEM" failure.
> 
> Actually, we can adjust the algorithm and then make it work, which has
> no harm at all, only if we set the maxmium number of xdp queues.

This is not true, it can cause harm, because XDP transmission queues are 
used without locking. See drivers ndo_xdp_xmit function ixgbe_xdp_xmit().
As driver assumption is that each CPU have its own XDP TX-queue.

This patch is not a proper fix.

I do think we need a proper fix for this issue on ixgbe.


> Fixes: 33fdc82f08 ("ixgbe: add support for XDP_TX action")
> Co-developed-by: Shujin Li <lishujin@kuaishou.com>
> Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> Signed-off-by: Jason Xing <xingwanli@kuaishou.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  | 2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ---
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> index 0218f6c..5953996 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> @@ -299,7 +299,7 @@ static void ixgbe_cache_ring_register(struct ixgbe_adapter *adapter)
>   
>   static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
>   {
> -	return adapter->xdp_prog ? nr_cpu_ids : 0;
> +	return adapter->xdp_prog ? min_t(int, MAX_XDP_QUEUES, nr_cpu_ids) : 0;
>   }
>   
>   #define IXGBE_RSS_64Q_MASK	0x3F
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 14aea40..b36d16b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10130,9 +10130,6 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>   			return -EINVAL;
>   	}
>   
> -	if (nr_cpu_ids > MAX_XDP_QUEUES)
> -		return -ENOMEM;
> -
>   	old_prog = xchg(&adapter->xdp_prog, prog);
>   	need_reset = (!!prog != !!old_prog);
>   
> 

