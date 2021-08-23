Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7A3F5079
	for <lists+bpf@lfdr.de>; Mon, 23 Aug 2021 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhHWSjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 14:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbhHWSjA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 14:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629743897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGeRK61kiXK1K05tade+IDVRPgDSs9Mu5QBfh6lgm+Q=;
        b=djNEjY4Fguk8kZOlSfsvJ+wW7HO//F2kxNF6l9ZIb6m2rvsSPVfT83NaKHheUfjNcX6F++
        MezfFSYPryBSo0h06eJmOx1fUKfpjQBHeNyFjcqIFO0oM+bB9uSvGanlsnSmmubUt9YQLk
        eBhVraaDeDp6bui2cMqSlsCceMF9Ua4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-QkOGdbLsO6ektg9UBV_VXQ-1; Mon, 23 Aug 2021 14:38:15 -0400
X-MC-Unique: QkOGdbLsO6ektg9UBV_VXQ-1
Received: by mail-wm1-f71.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so40463wmj.8
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 11:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aGeRK61kiXK1K05tade+IDVRPgDSs9Mu5QBfh6lgm+Q=;
        b=ceeAQ5+Fx+d+Mwq5T70e7PvJX1A3+MYmKFUfZL9mJ2NF07U53nRVMcNJ1rR895Lr3Z
         QRueLO7dtTdkzAwzXKSE+y/VfXMhMf0u1tC8HF7ow9SNoMSNoDqowoRJwnof0awkW5gw
         0Q+8+/dFIB5HD6CfEkC+JWjvna3nr9/RIAYBF93ncLaGFPQAJW0ok6FClb6xjj+HQACT
         P9UWl08Dz3YMW63AYJju+u688492o61uCxcAMK0djInpNlNssE1oCtteOvEQ91YFbktL
         0J/sKuopdKO3kS0veu5R4uP78Vx0w++AqGkKBVCyaZRIP3HAagc2rm13P4fPpdHTPB1/
         nTpA==
X-Gm-Message-State: AOAM531G8xiZavQ49iWtmB9oQ5x4v1s9pO1hH6dfhhtyPrlob9VtD0GG
        +vUmCGeJSiyqn8hAVwROXT3Uaqw89d13UvPPIXIasFheIL4koSRmOhMCG36eC9oVQNjh5QhDoMA
        W5mNeaqaAVJcG
X-Received: by 2002:a05:600c:4656:: with SMTP id n22mr13403720wmo.74.1629743894355;
        Mon, 23 Aug 2021 11:38:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx30LR2fj61cxgWt2sNK/230aqlYfdRAsV6ILtvVucKEAcOOWdUh1RddfLWL/j+m/rLgt1jrQ==
X-Received: by 2002:a05:600c:4656:: with SMTP id n22mr13403712wmo.74.1629743894249;
        Mon, 23 Aug 2021 11:38:14 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id l2sm13936162wme.28.2021.08.23.11.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 11:38:13 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com
Subject: Re: [PATCH net-next] netdevice: move xdp_rxq within netdev_rx_queue
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
References: <20210823180135.1153608-1-kuba@kernel.org>
Message-ID: <b2cd6882-4e31-18f6-315b-7b0937b8942c@redhat.com>
Date:   Mon, 23 Aug 2021 20:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823180135.1153608-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 23/08/2021 20.01, Jakub Kicinski wrote:
> Both struct netdev_rx_queue and struct xdp_rxq_info are cacheline
> aligned. This causes extra padding before and after the xdp_rxq
> member. Move the member upfront, so that it's naturally aligned.
> 
> Before:
> 	/* size: 256, cachelines: 4, members: 6 */
> 	/* sum members: 160, holes: 1, sum holes: 40 */
> 	/* padding: 56 */
> 	/* paddings: 1, sum paddings: 36 */
> 	/* forced alignments: 1, forced holes: 1, sum forced holes: 40 */
> 
> After:
> 	/* size: 192, cachelines: 3, members: 6 */
> 	/* padding: 32 */
> 	/* paddings: 1, sum paddings: 36 */
> 	/* forced alignments: 1 */
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   include/linux/netdevice.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


LGTM

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 9579942ac2fd..514ec3a0507c 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -722,13 +722,13 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index, u32 flow_id,
>   
>   /* This structure contains an instance of an RX queue. */
>   struct netdev_rx_queue {
> +	struct xdp_rxq_info		xdp_rxq;
>   #ifdef CONFIG_RPS
>   	struct rps_map __rcu		*rps_map;
>   	struct rps_dev_flow_table __rcu	*rps_flow_table;
>   #endif
>   	struct kobject			kobj;
>   	struct net_device		*dev;
> -	struct xdp_rxq_info		xdp_rxq;
>   #ifdef CONFIG_XDP_SOCKETS
>   	struct xsk_buff_pool            *pool;
>   #endif
> 

