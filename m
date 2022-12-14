Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44964C646
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbiLNJta (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 04:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbiLNJtY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 04:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2497B5FE2
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 01:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671011313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1076h34jNt+RFN/D62BHwwdDcIkby0OIjVTzlI1GGg=;
        b=fg/8Frsti3T3fR3wY5K/fbOg4D3re6bLmgdBnf87fFXrlyqNckN9JP3JDt+2JUKO4tvQW3
        q+qH20TSRA3YLz1l9UHSHTmm/rpQlY03tzENVW+N8XlTsOg7E7g0yOpUZSwbHBgsJ3Zya6
        d6dAmD+9mghnAPbKkv5bQM29XGQUr+o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-SRP21co4MbC-6pqTKAjq5A-1; Wed, 14 Dec 2022 04:48:31 -0500
X-MC-Unique: SRP21co4MbC-6pqTKAjq5A-1
Received: by mail-ed1-f72.google.com with SMTP id w20-20020a056402269400b004700a51c202so4931772edd.13
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 01:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1076h34jNt+RFN/D62BHwwdDcIkby0OIjVTzlI1GGg=;
        b=F/h9wqovxSAGmHGf4v3swDwZ78290BDgXmtriRsW0Ufp7s+NE/+K/7458gJP/uUmKe
         6NloisTmk3JqKOODIUD4VmtWdDsAyP0M3oCOI5o5RnsufiOebAnUaZVfRaRoA+wrTDEs
         lZyAmaKmPccj5lwvFKIh4vihwJwSvt8Yc5JLxy7kGNz+hKWHiaQBe+pFJ2v+4CqeTp85
         Pz7V1299dqA6y7WD7aCdXJULHgpLOK2+vmX293HdOFaADV8cpg8FOOVZbpuGJzX5TjyR
         O94e4R10+V0+rhJTu4DG6iT7VdisYPWb5yh6TtFa7Fk3Q5MndufWu3N1LUfifdF2eTrm
         K1sg==
X-Gm-Message-State: ANoB5pnjd2hhdoLfDMATTsTInMes41K8BIhrDhE+5DwxrNq5X6VAEccM
        U9l3nTs+H3I6ym8KZ5Yw55/KhGQkEyL1kpm0othiiMJ96mEdq8BnKaIQHfRNn0LzpaR4DiW+y1c
        9ud3Rf6bTCyeJ
X-Received: by 2002:a17:906:1711:b0:7c1:3fbd:d569 with SMTP id c17-20020a170906171100b007c13fbdd569mr17509269eje.8.1671011310275;
        Wed, 14 Dec 2022 01:48:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7eKBGc/LzVbcut6QdNbcvonPSSkkrSL8Da92pMNV0Uv65im4YaYAK47MXAVXUOIsUAnKJNEQ==
X-Received: by 2002:a17:906:1711:b0:7c1:3fbd:d569 with SMTP id c17-20020a170906171100b007c13fbdd569mr17509248eje.8.1671011310075;
        Wed, 14 Dec 2022 01:48:30 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090653c900b007ae693cd265sm5580900ejo.150.2022.12.14.01.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:48:29 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <4bac619d-8767-1364-1924-78c05b1ecf88@redhat.com>
Date:   Wed, 14 Dec 2022 10:48:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc:     brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 08/15] veth: Support RX XDP metadata
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20221213023605.737383-1-sdf@google.com>
 <20221213023605.737383-9-sdf@google.com>
 <7ca8ac2c-7c07-a52f-ec17-d1ba86fa45ab@redhat.com>
 <CAKH8qBvCxnJ2-5gd9j1HYxMA8CNi6cQM-5WOUBghiZjHUHya3A@mail.gmail.com>
In-Reply-To: <CAKH8qBvCxnJ2-5gd9j1HYxMA8CNi6cQM-5WOUBghiZjHUHya3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 13/12/2022 21.42, Stanislav Fomichev wrote:
> On Tue, Dec 13, 2022 at 7:55 AM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
>>
>>
>> On 13/12/2022 03.35, Stanislav Fomichev wrote:
>>> The goal is to enable end-to-end testing of the metadata for AF_XDP.
>>>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: David Ahern <dsahern@gmail.com>
>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Willem de Bruijn <willemb@google.com>
>>> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>>> Cc: Anatoly Burakov <anatoly.burakov@intel.com>
>>> Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
>>> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
>>> Cc: Maryam Tahhan <mtahhan@redhat.com>
>>> Cc: xdp-hints@xdp-project.net
>>> Cc: netdev@vger.kernel.org
>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>> ---
>>>    drivers/net/veth.c | 24 ++++++++++++++++++++++++
>>>    1 file changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> index 04ffd8cb2945..d5491e7a2798 100644
>>> --- a/drivers/net/veth.c
>>> +++ b/drivers/net/veth.c
>>> @@ -118,6 +118,7 @@ static struct {
>>>
>>>    struct veth_xdp_buff {
>>>        struct xdp_buff xdp;
>>> +     struct sk_buff *skb;
>>>    };
>>>
>>>    static int veth_get_link_ksettings(struct net_device *dev,
>>> @@ -602,6 +603,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
>>>
>>>                xdp_convert_frame_to_buff(frame, xdp);
>>>                xdp->rxq = &rq->xdp_rxq;
>>> +             vxbuf.skb = NULL;
>>>
>>>                act = bpf_prog_run_xdp(xdp_prog, xdp);
>>>
>>> @@ -823,6 +825,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>>>        __skb_push(skb, skb->data - skb_mac_header(skb));
>>>        if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
>>>                goto drop;
>>> +     vxbuf.skb = skb;
>>>
>>>        orig_data = xdp->data;
>>>        orig_data_end = xdp->data_end;
>>> @@ -1601,6 +1604,21 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>>>        }
>>>    }
>>>
>>> +static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
>>> +{
>>> +     *timestamp = ktime_get_mono_fast_ns();
>>
>> This should be reading the hardware timestamp in the SKB.
>>
>> Details: This hardware timestamp in the SKB is located in
>> skb_shared_info area, which is also available for xdp_frame (currently
>> used for multi-buffer purposes).  Thus, when adding xdp-hints "store"
>> functionality, it would be natural to store the HW TS in the same place.
>> Making the veth skb/xdp_frame code paths able to share code.
> 
> Does something like the following look acceptable as well?
> 
> *timestamp = skb_hwtstamps(_ctx->skb)->hwtstamp;
> if (!*timestamp)
>          *timestamp = ktime_get_mono_fast_ns(); /* sw fallback */
> 

How can the BPF programmer tell the difference between getting hardware 
or software timestamp?

This will get really confusing when someone implements a tcpdump feature
(like/extend xdpdump) and some packets (e.g. PTP packets) have HW
timestamps and some don't.  The time sequence in the pcap will be strange.

> Because I'd like to be able to test this path in the selftests. As
> long as I get some number from veth_xdp_rx_timestamp, I can test it.
> No amount of SOF_TIMESTAMPING_{SOFTWARE,RX_SOFTWARE,RAW_HARDWARE}
> triggers non-zero hwtstamp for xsk receive path. Any suggestions?
> 

You could implement the "store" operation I mentioned before.
For testing you can store an arbitrary value in the timestamp and check
it later by reading it back.

I can see you have changed the API to send down a pointer. Thus, a
simple flag could implement the writing the provided timestamp.

Regarding flags for reading the timestamp.  Should we be able to specify
what clock type we are asking for?
Have you notice that tcpdump can ask for different types of
timestamps[1]. e.g. for hardware timestamps it is either
'adapter_unsynced' or 'adaptor'. (See semantic in [1])

  # tcpdump -ni eth1 -j adapter_unsynced --time-stamp-precision=nano

[1] https://www.tcpdump.org/manpages/pcap-tstamp.7.txt


Hint list which your NIC 'adaptor' supports via this cmdline:

  # tcpdump -i mlx5p2 --list-time-stamp-types

--Jesper

