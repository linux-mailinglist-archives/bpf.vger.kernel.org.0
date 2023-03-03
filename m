Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F476A9569
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 11:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCCKj7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 05:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCCKj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 05:39:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452974C6C7
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 02:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677839951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZYISymnHUJzQ9oGrozV91eykhzhId/Ob9/Pj/GYOnU=;
        b=EDxJNnfO/PECa/kqVH5OL5Vya4oqDWVbx4/B5cBXKKk45DK+5N2wFyS7Ja2eL8EQgqqYsc
        vW1xIhyqQZdLOiuFDc+7SJ6lRAGEQlwxzVxCsM6iYOjdpqkrGpg4rnwdhxtpX3rey8U+1N
        Ljre2ARnIx0e4/VR6uYe5XUGrbOqu0Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-5nL6mpAFPJ2KLtwh_Er_-g-1; Fri, 03 Mar 2023 05:39:09 -0500
X-MC-Unique: 5nL6mpAFPJ2KLtwh_Er_-g-1
Received: by mail-ed1-f70.google.com with SMTP id u10-20020a056402064a00b004c689813557so3231695edx.10
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 02:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZYISymnHUJzQ9oGrozV91eykhzhId/Ob9/Pj/GYOnU=;
        b=bxSGn5jEfWnzxtfLNgqG5Fke7h7s2OmWRcEJO5yLNQld7w6QHQ7iUTcmtzJBvf4FYN
         t2Z1gBABaLCDHlSHXgJeVD/tMSezRzGP4Y9vtXiW/wSfcga3EQ3YtniEwSRnJ5Zw2ef/
         f6yvH3EdUlKo+IGTk8SNU5Siier831EGvN5d5ABrRfQLDgHWmYk4GZ82pUJKX4/LSLee
         +Pbmcs16nFy0ltvTaBK+oumOiht842At56b+uNqfYS5j6mZWp57euvTUKDQc1abL8u2c
         Z3x47p0BKQ76ggUqUdWF8ce9tsbtevT/BSNxupx8ltzhAEsPMC6yJMLXsXA215JWKaJL
         nRTA==
X-Gm-Message-State: AO0yUKUrG0lYdcSFncnIy/TV8B4rTKl5CEz6ey9hl5zuJGsKZQHyK56q
        BAB1Qf/2OXD6PduAbD8+v9lGgJvH1YSknpOl9SCupa2Hw4Daw8PrPcjIU28kbIZb7DvrgAD6QHN
        rMLOjXS/le4pz
X-Received: by 2002:a17:906:d0ca:b0:88d:ba89:183a with SMTP id bq10-20020a170906d0ca00b0088dba89183amr4943410ejb.11.1677839948356;
        Fri, 03 Mar 2023 02:39:08 -0800 (PST)
X-Google-Smtp-Source: AK7set8plnpvyHVS2XtWbo4Yk9SK76K0Al5X/5xZLNnTMe4Kr7DlrMRSAMoG9vBm5d4bxXIduPqHdQ==
X-Received: by 2002:a17:906:d0ca:b0:88d:ba89:183a with SMTP id bq10-20020a170906d0ca00b0088dba89183amr4943389ejb.11.1677839948109;
        Fri, 03 Mar 2023 02:39:08 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id h17-20020a170906399100b008d1dc5f5692sm808927eje.76.2023.03.03.02.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:39:07 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <22ca47ca-325f-f4df-af5d-344be6b372d8@redhat.com>
Date:   Fri, 3 Mar 2023 11:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 0/2] xdp: recycle Page Pool backed skbs built
 from XDP frames
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
References: <20230301160315.1022488-1-aleksander.lobakin@intel.com>
In-Reply-To: <20230301160315.1022488-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 01/03/2023 17.03, Alexander Lobakin wrote:
> Yeah, I still remember that "Who needs cpumap nowadays" (c), but anyway.
> 
> __xdp_build_skb_from_frame() missed the moment when the networking stack
> became able to recycle skb pages backed by a Page Pool. This was making
                                                ^^^^^^^^^
When talking about page_pool, can we write "page_pool" instead of
capitalized "Page Pool", please. I looked through the git log, and here
we all used "page_pool".

> e.g. cpumap redirect even less effective than simple %XDP_PASS. veth was
> also affected in some scenarios.

Thanks for working on closing this gap :-)

> A lot of drivers use skb_mark_for_recycle() already, it's been almost
> two years and seems like there are no issues in using it in the generic
> code too. {__,}xdp_release_frame() can be then removed as it losts its
> last user.
> Page Pool becomes then zero-alloc (or almost) in the abovementioned
> cases, too. Other memory type models (who needs them at this point)
> have no changes.
> 
> Some numbers on 1 Xeon Platinum core bombed with 27 Mpps of 64-byte
> IPv6 UDP:

What NIC driver?

> 
> Plain %XDP_PASS on baseline, Page Pool driver:
> 
> src cpu Rx     drops  dst cpu Rx
>    2.1 Mpps       N/A    2.1 Mpps
> 
> cpumap redirect (w/o leaving its node) on baseline:
> 
>    6.8 Mpps  5.0 Mpps    1.8 Mpps
> 
> cpumap redirect with skb PP recycling:
> 
>    7.9 Mpps  5.7 Mpps    2.2 Mpps   +22%
> 

It is of cause awesome, that cpumap SKBs are faster than normal SKB path.
I do wonder where the +22% number comes from?

> Alexander Lobakin (2):
>    xdp: recycle Page Pool backed skbs built from XDP frames
>    xdp: remove unused {__,}xdp_release_frame()
> 
>   include/net/xdp.h | 29 -----------------------------
>   net/core/xdp.c    | 19 ++-----------------
>   2 files changed, 2 insertions(+), 46 deletions(-)
> 

