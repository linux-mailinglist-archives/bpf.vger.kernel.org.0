Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4826BD6C5
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 18:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCPRLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 13:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCPRL1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 13:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE49EF45
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678986632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZTQMrsIX/IeLCwGq7gJekCkDfhbKmPVXG90DA14gRc=;
        b=X/3h4TzcIHIhbSIrV81d8IxbXicUMXjRlaP8/vsXhS/T5zRAxG8Cs1nPjPKK0HwTzLVH1P
        dUs3HqMT6Tck/thLJLictG7IQT8fJa3rMFXRKIDazpCB6/wVX1qoEGl6tM5KjMm/XESPWx
        NtivcA/d17B8F5sglsywb+NjEogYpAY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Xp6en4TeMNG0F-T_DU6duA-1; Thu, 16 Mar 2023 13:10:30 -0400
X-MC-Unique: Xp6en4TeMNG0F-T_DU6duA-1
Received: by mail-ed1-f71.google.com with SMTP id w6-20020a05640234c600b004fc0e5b4433so3919060edc.18
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 10:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678986629;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZTQMrsIX/IeLCwGq7gJekCkDfhbKmPVXG90DA14gRc=;
        b=UoWfGu9DxeV+JqhW9o+RIRH17XoibANEJwn41LUSWM1uBWY725kY+DecKy+gy9nsZ1
         eofLBmSsCXoTef09zlMNBDdvZPNmTSfeaKsdXfxpbNOXNPIte5EXbSgeTFutBALrmadS
         P0Jo7ymRIoVo6yAp9f66XSo1IbKkknJ9YemyfrNUFKkR6FfXO/teyE1F1XUW4ZW4tzJd
         SNYKxAbzeUTkIYRBCGlj8WxMZU4KmmatLYZPMhl0Gwe9XGoEdd6p2YXcSLyIdrTNRX3w
         krhwkqw9j8laDVuflNK/7rZiRlszmmRmlp1tjVsG84X7gEK6Flsh8boCRE7CyFsQCkXL
         kovw==
X-Gm-Message-State: AO0yUKV7EhJZ4t8S3Y1sd3k3pl8fVWo6T3Qoezm0Kx/ti7s26koVBUNb
        tNzYUym9I7s05hZ7jbQv7IcHFV/9jn00RXMOM1Li+lom4qajbeQgOsZgiFuKpqfeG8N4/6BUTNM
        5JlGFPFEUGtL2
X-Received: by 2002:aa7:cb4f:0:b0:4fb:1b0d:9f84 with SMTP id w15-20020aa7cb4f000000b004fb1b0d9f84mr364329edt.6.1678986629041;
        Thu, 16 Mar 2023 10:10:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set+0JeqVaVx07XZo7EVzLMP/yLmcLIMvIyZESAzWeDEsUdXWf7gZiG66vhAKtrpgzbvpGyiyAQ==
X-Received: by 2002:aa7:cb4f:0:b0:4fb:1b0d:9f84 with SMTP id w15-20020aa7cb4f000000b004fb1b0d9f84mr364303edt.6.1678986628740;
        Thu, 16 Mar 2023 10:10:28 -0700 (PDT)
Received: from [192.168.42.100] (cgn-cgn10-212-237-176-220.static.kviknet.net. [212.237.176.220])
        by smtp.gmail.com with ESMTPSA id r3-20020a50d683000000b004c0239e41d8sm2930edi.81.2023.03.16.10.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:10:27 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <0377c85c-5d59-49e5-017f-212821849a18@redhat.com>
Date:   Thu, 16 Mar 2023 18:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Mykola Lysenko <mykolal@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Freysteinn Alfredsson <Freysteinn.Alfredsson@kau.se>
Subject: Re: [PATCH bpf-next v3 3/4] xdp: recycle Page Pool backed skbs built
 from XDP frames
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230313215553.1045175-1-aleksander.lobakin@intel.com>
 <20230313215553.1045175-4-aleksander.lobakin@intel.com>
 <11e480dd-7969-7b58-440e-3207b98d0ac5@redhat.com>
 <85d803a2-a315-809a-5eff-13892aff5401@intel.com>
In-Reply-To: <85d803a2-a315-809a-5eff-13892aff5401@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 15/03/2023 15.58, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Date: Wed, 15 Mar 2023 15:55:44 +0100
> 
>> On 13/03/2023 22.55, Alexander Lobakin wrote:
[...]
>>>
>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>> index 8c92fc553317..a2237cfca8e9 100644
>>> --- a/net/core/xdp.c
>>> +++ b/net/core/xdp.c
>>> @@ -658,8 +658,8 @@ struct sk_buff *__xdp_build_skb_from_frame(struct
>>> xdp_frame *xdpf,
>>>         * - RX ring dev queue index    (skb_record_rx_queue)
>>>         */
>>>    -    /* Until page_pool get SKB return path, release DMA here */
>>> -    xdp_release_frame(xdpf);
>>> +    if (xdpf->mem.type == MEM_TYPE_PAGE_POOL)
>>> +        skb_mark_for_recycle(skb);
>>
>> I hope this is safe ;-) ... Meaning hopefully drivers does the correct
>> thing when XDP_REDIRECT'ing page_pool pages.
> 
> Safe when it's done by the schoolbook. For now I'm observing only one
> syzbot issue with test_run due to that it assumes yet another bunch
> o'things I wouldn't rely on :D (separate subthread)
> 
>>
>> Looking for drivers doing weird refcnt tricks and XDP_REDIRECT'ing, I
>> noticed the driver aquantia/atlantic (in aq_get_rxpages_xdp), but I now
>> see this is not using page_pool, so it should be affected by this (but I
>> worry if atlantic driver have a potential race condition for its refcnt
>> scheme).
> 
> If we encounter some driver using Page Pool, but mangling refcounts on
> redirect, we'll fix it ;)
> 

Thanks for signing up for fixing these issues down-the-road :-)

For what is it worth, I've rebased to include this patchset on my
testlab.

For now, I've tested mlx5 with cpumap redirect and net stack processing,
everything seems to be working nicely. When disabling GRO/GRO, then the
cpumap get same and sometimes better TCP throughput performance,
even-though checksum have to be done in software. (Hopefully we can soon
close the missing HW checksum gap with XDP-hints).

--Jesper

