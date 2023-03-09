Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD76B2B3D
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 17:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCIQyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 11:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCIQxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 11:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D50E484D
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678380237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBYjTI8PgGxLAtEJnnuZ8LRWuHsJNFJKEu/Uajd9epk=;
        b=PjCgm+VKjNq+c4a3M7quRAaOdQBBr+3Hyoeaj0Fpz7i8hsIgri8JCxFjkdmwgLb73JSHOG
        6fWGvxfv9Xw98Tpg9AxbwuM0D6/uUiULWZ0MwcBvG6ThcwlDE9lGdDUla1mffgqd2tdOjR
        m+h0WITcETZV7nxaB3kNDQXc6JXjcPE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-sazuDx_lPO2ocZ06nE_3oA-1; Thu, 09 Mar 2023 11:43:55 -0500
X-MC-Unique: sazuDx_lPO2ocZ06nE_3oA-1
Received: by mail-ed1-f72.google.com with SMTP id d35-20020a056402402300b004e37aed9832so3685565eda.18
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 08:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678380234;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBYjTI8PgGxLAtEJnnuZ8LRWuHsJNFJKEu/Uajd9epk=;
        b=34tL1T08NuczxsCTXnAq25atXUmBax7458LBu/94o8KU55aa6GivXz3w5A8CF7i7Bl
         73X+NzvHAnlN2mDXLbi6/CJf5tS2JZ5lmIt9UDLnYIGP/kEODCpsSyzkfUhFXCRzoxpN
         OVLLHcfUpqxSEr93FVrnRY6XxQJrICRx5QDNlRjA+yChN8IEJftTHqO5KHno0veYMTvW
         F8/ILnUzzW5arY54hpTq/dwcolW95XvFcCQjUQR+0sM9y7rLSIH7ZadB6+mrAm1Zo4M7
         ua6rWL7yEqLT1I6+gKdDtyx24jDzlkkJ9ofOj5WkCF6XTsgzIQkrehQimvePAL/02A00
         A6YQ==
X-Gm-Message-State: AO0yUKXUMJANwLF6TmVskCZ9AhHs9ggLtNLL+blJCcRuyIhADlevehTI
        d4SG0Y4gfcagO3wb4+aBiUuXaRSyPmeR+gLjHCgZoOpEHkSMp8oV+U5vrL8ckpOvuyB+YyKuspc
        lxpxVjDnJuacQ
X-Received: by 2002:aa7:d385:0:b0:4ac:d8a1:7385 with SMTP id x5-20020aa7d385000000b004acd8a17385mr22723868edq.3.1678380234024;
        Thu, 09 Mar 2023 08:43:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+YXdWGTr+wwyLt6gx1zoE1Sr4/UFcOwc798aU7m3XxYsJQWmujjulXzcRp+Ar11o7JCqfjAg==
X-Received: by 2002:aa7:d385:0:b0:4ac:d8a1:7385 with SMTP id x5-20020aa7d385000000b004acd8a17385mr22723846edq.3.1678380233757;
        Thu, 09 Mar 2023 08:43:53 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id t30-20020a50ab5e000000b004ad601533a3sm9926098edc.55.2023.03.09.08.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 08:43:53 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <73b5076c-335b-c746-b227-0edd40435ef5@redhat.com>
Date:   Thu, 9 Mar 2023 17:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] xdp: recycle Page Pool backed skbs built
 from XDP frames
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
References: <20230303133232.2546004-1-aleksander.lobakin@intel.com>
In-Reply-To: <20230303133232.2546004-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 03/03/2023 14.32, Alexander Lobakin wrote:
> Yeah, I still remember that "Who needs cpumap nowadays" (c), but anyway.
> 
> __xdp_build_skb_from_frame() missed the moment when the networking stack
> became able to recycle skb pages backed by a page_pool. This was making
> e.g. cpumap redirect even less effective than simple %XDP_PASS. veth was
> also affected in some scenarios.
> A lot of drivers use skb_mark_for_recycle() already, it's been almost
> two years and seems like there are no issues in using it in the generic
> code too. {__,}xdp_release_frame() can be then removed as it losts its
> last user.
> Page Pool becomes then zero-alloc (or almost) in the abovementioned
> cases, too. Other memory type models (who needs them at this point)
> have no changes.
> 
> Some numbers on 1 Xeon Platinum core bombed with 27 Mpps of 64-byte
> IPv6 UDP, iavf w/XDP[0] (CONFIG_PAGE_POOL_STATS is enabled):
> 
> Plain %XDP_PASS on baseline, Page Pool driver:
> 
> src cpu Rx     drops  dst cpu Rx
>    2.1 Mpps       N/A    2.1 Mpps
> 
> cpumap redirect (w/o leaving its node) on baseline:

What does it mean "without leaving its node" ?
I interpret this means BPF program CPU redirect to "same" CPU ?
Or does the "node" reference a NUMA node?

> 
>    6.8 Mpps  5.0 Mpps    1.8 Mpps
> 
> cpumap redirect with skb PP recycling:

Does this test use two CPUs?

> 
>    7.9 Mpps  5.7 Mpps    2.2 Mpps
>                         +22% (from cpumap redir on baseline)
> [0] https://github.com/alobakin/linux/commits/iavf-xdp
> 
> Alexander Lobakin (3):
>    net: page_pool, skbuff: make skb_mark_for_recycle() always available
>    xdp: recycle Page Pool backed skbs built from XDP frames
>    xdp: remove unused {__,}xdp_release_frame()
> 
>   include/linux/skbuff.h |  4 ++--
>   include/net/xdp.h      | 29 -----------------------------
>   net/core/xdp.c         | 19 ++-----------------
>   3 files changed, 4 insertions(+), 48 deletions(-)
> 
> ---
>  From v1[1]:
> * make skb_mark_for_recycle() always available, otherwise there are build
>    failures on non-PP systems (kbuild bot);
> * 'Page Pool' -> 'page_pool' when it's about a page_pool instance, not
>    API (Jesper);
> * expanded test system info a bit in the cover letter (Jesper).
> 
> [1] https://lore.kernel.org/bpf/20230301160315.1022488-1-aleksander.lobakin@intel.com

