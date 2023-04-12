Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350E06DF3C3
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDLLeN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjDLLeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 07:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819177DA0
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681299083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nk2HN4LYcyDaWmfUhz3C+OW0ZEf1uFXTpNavnDkV0cc=;
        b=iSSNlxBG3vCcLR4kZk41eUoiMccBNsEhhO230ppJs46jzDaBfRiqoMvwiCjNmIePApShlD
        /eThYrWxzEme9B5KNfgNH8RL4XAA7QhVL7rs6hONkry5BRujebhT824YXec/sRXm4leJrw
        ONq2+3bQlPEbrbF9JwZRDBOWxEQmbE0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-hmKBC-_-NZa9QnzSwBhAqQ-1; Wed, 12 Apr 2023 07:31:22 -0400
X-MC-Unique: hmKBC-_-NZa9QnzSwBhAqQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso141346266b.3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 04:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681299081; x=1683891081;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk2HN4LYcyDaWmfUhz3C+OW0ZEf1uFXTpNavnDkV0cc=;
        b=L1wrBVHjEXziRRef3HdLCFtPRCTpS8VKfWGIyW0CMXqpquI251sWVWXhBYRMSPjSVG
         rxIO0KM92nt0GldH3p6M3aH0OdvLhTPYe8F5d0HTMstQI1AV4csLX21e+YtnXWbjPmcO
         FWb9EN1Qsn6kf7M/EQPseMeHjAVIstunFvbkpbXOGmQPvrcuT3Qoo6O/SuQNWmLvFE5D
         6zcxGWXACPmtSSg1TeRGJmT1jW78YEkojiCWsNAf5KMDYO8lXlcKQ+avCfImEq2FUH3O
         nXARvdSpyujCOGTcTmrhtvvFCB3Bk/yoZ16aArYLW9tPp/9sP2i3WXnBzUUYj+xAypfQ
         UVvA==
X-Gm-Message-State: AAQBX9d6fwtvIitdBGYasHdHk8x2+LWHHWC9K6Vgr4YktrZQg6hgHDuU
        Tpfx5FZ3dmEftVQZZSKnXEZoLEk0TOckA3YrIvfFYuyhZWxtJI3q4vruHDu4YWadU9hXq+8kE7r
        C/EG6peezhzNS
X-Received: by 2002:a05:6402:752:b0:504:b5e2:1106 with SMTP id p18-20020a056402075200b00504b5e21106mr1901057edy.31.1681299081166;
        Wed, 12 Apr 2023 04:31:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bWSnMhtYTS7XybJW7QFtVttBmNYOBb1gK7QmiwkJ3R5PmWWhPKTh95b+l/GZUnSauQBragxw==
X-Received: by 2002:a05:6402:752:b0:504:b5e2:1106 with SMTP id p18-20020a056402075200b00504b5e21106mr1901027edy.31.1681299080782;
        Wed, 12 Apr 2023 04:31:20 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id o2-20020a056402444200b00501c2a9e16dsm6523178edb.74.2023.04.12.04.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:31:20 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <8cd2d200-09ec-57c2-0619-963dfe5efd58@redhat.com>
Date:   Wed, 12 Apr 2023 13:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?= =?UTF-8?Q?sen?= 
        <toke@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net, tariqt@nvidia.com, saeedm@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH bpf V7 4/7] mlx5: bpf_xdp_metadata_rx_hash add xdp rss
 hash type
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
References: <168098183268.96582.7852359418481981062.stgit@firesoul>
 <168098189656.96582.16141211495116669329.stgit@firesoul>
 <ZDQnFmZdESpF1BEz@corigine.com>
In-Reply-To: <ZDQnFmZdESpF1BEz@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/04/2023 17.11, Simon Horman wrote:
> On Sat, Apr 08, 2023 at 09:24:56PM +0200, Jesper Dangaard Brouer wrote:
>> Update API for bpf_xdp_metadata_rx_hash() with arg for xdp rss hash type
>> via mapping table.
>>
>> The mlx5 hardware can also identify and RSS hash IPSEC.  This indicate
>> hash includes SPI (Security Parameters Index) as part of IPSEC hash.
>>
>> Extend xdp core enum xdp_rss_hash_type with IPSEC hash type.
>>
>> Fixes: bc8d405b1ba9 ("net/mlx5e: Support RX XDP metadata")
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> Acked-by: Stanislav Fomichev <sdf@google.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |   60 ++++++++++++++++++++++
>>   include/linux/mlx5/device.h                      |   14 ++++-
>>   include/net/xdp.h                                |    2 +
>>   3 files changed, 73 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>> index efe609f8e3aa..97ef1df94d50 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>> @@ -34,6 +34,7 @@
>>   #include <net/xdp_sock_drv.h>
>>   #include "en/xdp.h"
>>   #include "en/params.h"
>> +#include <linux/bitfield.h>
>>   
>>   int mlx5e_xdp_max_mtu(struct mlx5e_params *params, struct mlx5e_xsk_param *xsk)
>>   {
>> @@ -169,15 +170,72 @@ static int mlx5e_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
>>   	return 0;
>>   }
>>   
>> +/* Mapping HW RSS Type bits CQE_RSS_HTYPE_IP + CQE_RSS_HTYPE_L4 into 4-bits*/
>> +#define RSS_TYPE_MAX_TABLE	16 /* 4-bits max 16 entries */
>> +#define RSS_L4		GENMASK(1, 0)
>> +#define RSS_L3		GENMASK(3, 2) /* Same as CQE_RSS_HTYPE_IP */
>> +
>> +/* Valid combinations of CQE_RSS_HTYPE_IP + CQE_RSS_HTYPE_L4 sorted numerical */
>> +enum mlx5_rss_hash_type {
>> +	RSS_TYPE_NO_HASH	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IP_NONE) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_NONE)),
>> +	RSS_TYPE_L3_IPV4	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV4) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_NONE)),
>> +	RSS_TYPE_L4_IPV4_TCP	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV4) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_TCP)),
>> +	RSS_TYPE_L4_IPV4_UDP	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV4) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_UDP)),
>> +	RSS_TYPE_L4_IPV4_IPSEC	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV4) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_IPSEC)),
>> +	RSS_TYPE_L3_IPV6	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV6) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_NONE)),
>> +	RSS_TYPE_L4_IPV6_TCP	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV6) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_TCP)),
>> +	RSS_TYPE_L4_IPV6_UDP	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV6) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_UDP)),
>> +	RSS_TYPE_L4_IPV6_IPSEC	= (FIELD_PREP_CONST(RSS_L3, CQE_RSS_IPV6) |
>> +				   FIELD_PREP_CONST(RSS_L4, CQE_RSS_L4_IPSEC)),
>> +} mlx5_rss_hash_type;
> 
> Hi Jesper,
> 
> Sparse seems confused about 'mlx5_rss_hash_type' on the line above.
> And I am too. Perhaps it can be removed?
> 

Yes, it can be removed (in V8).

The reason/trick for doing this was to get compiler to create the enum
symbol, which allowed me to inspect the type using pahole (see cmd
below).  (This will also expose this to BTF, but it isn't actually
useful to keep around for BTF, so I will remove it in V8.)


$ pahole -C mlx5_rss_hash_type 
drivers/net/ethernet/mellanox/mlx5/core/en/xdp.o
enum mlx5_rss_hash_type {
	RSS_TYPE_NO_HASH       = 0,
	RSS_TYPE_L3_IPV4       = 4,
	RSS_TYPE_L4_IPV4_TCP   = 5,
	RSS_TYPE_L4_IPV4_UDP   = 6,
	RSS_TYPE_L4_IPV4_IPSEC = 7,
	RSS_TYPE_L3_IPV6       = 8,
	RSS_TYPE_L4_IPV6_TCP   = 9,
	RSS_TYPE_L4_IPV6_UDP   = 10,
	RSS_TYPE_L4_IPV6_IPSEC = 11,
};

This is practical to for reviewers to see if below code is correct:

 > +/* Invalid combinations will simply return zero, allows no boundary 
checks */
 > +static const enum xdp_rss_hash_type 
mlx5_xdp_rss_type[RSS_TYPE_MAX_TABLE] = {
 > +	[RSS_TYPE_NO_HASH]	 = XDP_RSS_TYPE_NONE,
 > +	[1]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
 > +	[2]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
 > +	[3]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
 > +	[RSS_TYPE_L3_IPV4]	 = XDP_RSS_TYPE_L3_IPV4,
 > +	[RSS_TYPE_L4_IPV4_TCP]	 = XDP_RSS_TYPE_L4_IPV4_TCP,
 > +	[RSS_TYPE_L4_IPV4_UDP]	 = XDP_RSS_TYPE_L4_IPV4_UDP,
 > +	[RSS_TYPE_L4_IPV4_IPSEC] = XDP_RSS_TYPE_L4_IPV4_IPSEC,
 > +	[RSS_TYPE_L3_IPV6]	 = XDP_RSS_TYPE_L3_IPV6,
 > +	[RSS_TYPE_L4_IPV6_TCP]	 = XDP_RSS_TYPE_L4_IPV6_TCP,
 > +	[RSS_TYPE_L4_IPV6_UDP]   = XDP_RSS_TYPE_L4_IPV6_UDP,
 > +	[RSS_TYPE_L4_IPV6_IPSEC] = XDP_RSS_TYPE_L4_IPV6_IPSEC,
 > +	[12]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
 > +	[13]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
 > +	[14]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
 > +	[15]			 = XDP_RSS_TYPE_NONE, /* Implicit zero */
 > +};

> drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:198:3: warning: symbol 'mlx5_rss_hash_type' was not declared. Should it be static?
> 
> ...
> 

