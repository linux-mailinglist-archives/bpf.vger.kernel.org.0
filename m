Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550867AF63
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 11:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjAYKNV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 05:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjAYKNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 05:13:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036CEF8E
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 02:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674641552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39uUoxo0wfRAwahgj1y7dgLynrBafUqvtoFkUK46E0w=;
        b=SSk6mGWAxgp6g0Nr8Hp0FDXUZBrQxchEiwZ3Uh5gQQyUBbn9pG7p3/enUB8uhGDBs67Czy
        HaBOBsri6N/VuvQnQRJf8l5crtCdIwj7mWdxy1FNuLnsy8YWF/NLN6pTGb+JDLdeUlc8AS
        KjLi7+kbwCZNdJOhtHdt0QpDyg+EHd8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-hdmydESoPmCK8oJCnum15A-1; Wed, 25 Jan 2023 05:12:31 -0500
X-MC-Unique: hdmydESoPmCK8oJCnum15A-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020a056402350f00b0049e42713e2bso12488113edd.0
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 02:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39uUoxo0wfRAwahgj1y7dgLynrBafUqvtoFkUK46E0w=;
        b=3lohvL/Zxpkral7xCs7A4Resj2BEJqYcQYDES5f7zg7NArvWvpwG3jNHJ3Rw3Sw/g5
         MocLA8jDISFdYHuPpNScY3rxlUDy4px9e99g0muNNORgM4aTtxFMNGg/JoPshf0MJh0H
         OeJZhkrwnBuTF72m0xMzq4l7+nQB7AF7gUfLzMhfHePbiluVqKRl5MrJWXc+VMTlVqCg
         AiHadOZRBfBpjsdiKgnBDvVXXACOEwfF4sC4tBq9VhbsWxagqi4s56Lpo7oPv0aHrHKX
         t5pJddZOEdyKtHaqmBYPSvOPG5Xoy1bDBQXgztWNUc6/L8DHMX8HeXZqIwaxmUxCYCYQ
         jG1w==
X-Gm-Message-State: AFqh2kpfKJKwDMObYzIlywoBkh6E1syk6x0tbk1r+nf30oSJjNljY+cJ
        BJHlzXsHcUpL8qX1WwnI1jJGVQ5R6EKNujF4UtcOccAw4HhkWVhf/WkaHW2BmjzP2y4G62Qk2gz
        NgKJXxQb34gTd
X-Received: by 2002:a05:6402:4019:b0:467:c3cb:49aa with SMTP id d25-20020a056402401900b00467c3cb49aamr39111446eda.4.1674641550378;
        Wed, 25 Jan 2023 02:12:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVVXP8jouC5bDivbcMNoye/GXXOZe7JAjOCC0dE5q1ukSbNqOwTCdV8EhiTmYy6uLAjflwGQ==
X-Received: by 2002:a05:6402:4019:b0:467:c3cb:49aa with SMTP id d25-20020a056402401900b00467c3cb49aamr39111405eda.4.1674641550076;
        Wed, 25 Jan 2023 02:12:30 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906a00800b0084d3bf4498csm2185594ejy.140.2023.01.25.02.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:12:29 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <5b849f25-3e2e-0a9a-01c2-6f1fa483cd57@redhat.com>
Date:   Wed, 25 Jan 2023 11:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, pabeni@redhat.com,
        edumazet@google.com, toke@redhat.com, memxor@gmail.com,
        alardam@gmail.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
        gospo@broadcom.com, vladimir.oltean@nxp.com, nbd@nbd.name,
        john@phrozen.org, leon@kernel.org, simon.horman@corigine.com,
        aelior@marvell.com, christophe.jaillet@wanadoo.fr,
        ecree.xilinx@gmail.com, mst@redhat.com, bjorn@kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        intel-wired-lan@lists.osuosl.org, lorenzo.bianconi@redhat.com,
        martin.lau@linux.dev
Subject: Re: [PATCH v2 bpf-next 1/8] netdev-genl: create a simple family for
 netdev stuff
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
References: <cover.1674606193.git.lorenzo@kernel.org>
 <b420eea0f362daa127448a5647a801d1ae9cb6dd.1674606196.git.lorenzo@kernel.org>
In-Reply-To: <b420eea0f362daa127448a5647a801d1ae9cb6dd.1674606196.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 25/01/2023 01.33, Lorenzo Bianconi wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 90f2be194bc5..2cbe9a6ede76 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -47,6 +47,7 @@
>   #include <uapi/linux/netdevice.h>
>   #include <uapi/linux/if_bonding.h>
>   #include <uapi/linux/pkt_cls.h>
> +#include <uapi/linux/netdev.h>
>   #include <linux/hashtable.h>
>   #include <linux/rbtree.h>
>   #include <net/net_trackers.h>
> @@ -2055,6 +2056,7 @@ struct net_device {
>   
>   	/* Read-mostly cache-line for fast-path access */
>   	unsigned int		flags;
> +	xdp_features_t		xdp_features;

Nice you found a 4 bytes hole to place the u32 xdp_features member in
and in a "Read-mostly cache-line for fast-path access" that is good :-)
(Added my pahole output for reference below)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

>   	unsigned long long	priv_flags;
>   	const struct net_device_ops *netdev_ops;
>   	const struct xdp_metadata_ops *xdp_metadata_ops;
> @@ -2839,6 +2841,7 @@ enum netdev_cmd {
>   	NETDEV_OFFLOAD_XSTATS_DISABLE,
>   	NETDEV_OFFLOAD_XSTATS_REPORT_USED,
>   	NETDEV_OFFLOAD_XSTATS_REPORT_DELTA,
> +	NETDEV_XDP_FEAT_CHANGE,
>   };
>   const char *netdev_cmd_to_name(enum netdev_cmd cmd);
>   
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 91292aa13bc0..8d1c86914f4c 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -7,6 +7,7 @@
>   #define __LINUX_NET_XDP_H__
>   
>   #include <linux/skbuff.h> /* skb_shared_info */
> +#include <uapi/linux/netdev.h>
>   
>   /**
>    * DOC: XDP RX-queue information
> @@ -43,6 +44,8 @@ enum xdp_mem_type {
>   	MEM_TYPE_MAX,
>   };
>   
> +typedef u32 xdp_features_t;
> +
>   /* XDP flags for ndo_xdp_xmit */
>   #define XDP_XMIT_FLUSH		(1U << 0)	/* doorbell signal consumer */
>   #define XDP_XMIT_FLAGS_MASK	XDP_XMIT_FLUSH


--Jesper

On 64 bit arch partial output from:
   pahole -C net_device net/core/skbuff.o

struct net_device {
         char                       name[16];             /*     0    16 */
         struct netdev_name_node *  name_node;            /*    16     8 */
         struct dev_ifalias *       ifalias;              /*    24     8 */
         long unsigned int          mem_end;              /*    32     8 */
         long unsigned int          mem_start;            /*    40     8 */
         long unsigned int          base_addr;            /*    48     8 */
         long unsigned int          state;                /*    56     8 */
         /* --- cacheline 1 boundary (64 bytes) --- */
         struct list_head           dev_list;             /*    64    16 */
         struct list_head           napi_list;            /*    80    16 */
         struct list_head           unreg_list;           /*    96    16 */
         struct list_head           close_list;           /*   112    16 */
         /* --- cacheline 2 boundary (128 bytes) --- */
         struct list_head           ptype_all;            /*   128    16 */
         struct list_head           ptype_specific;       /*   144    16 */
         struct {
                 struct list_head   upper;                /*   160    16 */
                 struct list_head   lower;                /*   176    16 */
         } adj_list;                                      /*   160    32 */
         /* --- cacheline 3 boundary (192 bytes) --- */
         unsigned int               flags;                /*   192     4 */

         /* XXX 4 bytes hole, try to pack */

         long long unsigned int     priv_flags;           /*   200     8 */
         const struct net_device_ops  * netdev_ops;       /*   208     8 */
         const struct xdp_metadata_ops  * xdp_metadata_ops; /*   216 
8 */
         int                        ifindex;              /*   224     4 */
         short unsigned int         gflags;               /*   228     2 */
         short unsigned int         hard_header_len;      /*   230     2 */
         unsigned int               mtu;                  /*   232     4 */
         short unsigned int         needed_headroom;      /*   236     2 */
         short unsigned int         needed_tailroom;      /*   238     2 */
         netdev_features_t          features;             /*   240     8 */
         netdev_features_t          hw_features;          /*   248     8 */
         /* --- cacheline 4 boundary (256 bytes) --- */
         netdev_features_t          wanted_features;      /*   256     8 */
         netdev_features_t          vlan_features;        /*   264     8 */
         netdev_features_t          hw_enc_features;      /*   272     8 */
         netdev_features_t          mpls_features;        /*   280     8 */
         netdev_features_t          gso_partial_features; /*   288     8 */
         unsigned int               min_mtu;              /*   296     4 */
         unsigned int               max_mtu;              /*   300     4 */
         short unsigned int         type;                 /*   304     2 */
         unsigned char              min_header_len;       /*   306     1 */
         unsigned char              name_assign_type;     /*   307     1 */

