Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBF6493D0
	for <lists+bpf@lfdr.de>; Sun, 11 Dec 2022 12:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiLKLKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 06:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLKLKf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 06:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94728FC4
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 03:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670756980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khqYQ6ao58HEonL3Tw0vVUzswYB2HQq7BgFa7siHNew=;
        b=aTz5FjjCbsNm0tUSGy680uf7qII0wfSk9iBft4pPueF1KFZsxitjK1RSwm4Gj15BS9kT6K
        HFRFPXUK9QeF9ZS9L6kkEFZoXSSEmsV0Yxy2vUtVNrqEIWf802VVJf9VtaBIcNlU6Axgjy
        6RTED+HOStp8NZYMrOkfnIg4ByWAmZc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-BexZolYPOuC_QYvMzKE9MQ-1; Sun, 11 Dec 2022 06:09:39 -0500
X-MC-Unique: BexZolYPOuC_QYvMzKE9MQ-1
Received: by mail-ej1-f69.google.com with SMTP id hs18-20020a1709073e9200b007c0f9ac75f9so5402060ejc.9
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 03:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khqYQ6ao58HEonL3Tw0vVUzswYB2HQq7BgFa7siHNew=;
        b=0XQ03S/do2YXvj9mdax53ERprT9GbhVzSeAZFNTwSOoZiiby4M3nyWM5XJ5i2Zkm2V
         AsSMPN12fenv/kilv+etkRd6ymyMbS53hw81lvVgJSid7dJn9E8z/v6bJbBnzehZ4vOC
         lpzROjsl7mx0Ng4Rq2NglFiok9jKHHdXJOq37rdJK0zolQIVtKG0/GI+3VOvubDK7LPg
         yoc+T0HoWTvmumBuzWOBWsIKGDL/uDHYPe4jiblouKZYJ+oNMNHiRybBGIoBTz50FRay
         70aSJz1LnGEzdaPyeEQ8xY8IMBbWITVX21MgNYcBK3qetvLaCKXYc9UivsOq1tKsyG6R
         Zexg==
X-Gm-Message-State: ANoB5pk2p1eiuBEcNYBdxU34tsvjLDZaV29Vk/RN0HZHCcZglFrC7dM1
        ca2K1T6fgL6EszKEeyu9PCPyHvs4h2NJVrplG91O2tvIn2XFCWlSkRzp5BBjr3WQF0GF5qL8NfF
        aMdg1lkys9r2a
X-Received: by 2002:a17:907:6e20:b0:7bc:fbd1:4ca with SMTP id sd32-20020a1709076e2000b007bcfbd104camr19461911ejc.69.1670756978133;
        Sun, 11 Dec 2022 03:09:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6N6n+Vnd4vzu9yXAgvM4CfIZVvrUH2lwFn6sv4kXMHxZCB46RvwHkhInlqea0H7MpGbx6FZQ==
X-Received: by 2002:a17:907:6e20:b0:7bc:fbd1:4ca with SMTP id sd32-20020a1709076e2000b007bcfbd104camr19461878ejc.69.1670756977896;
        Sun, 11 Dec 2022 03:09:37 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090631c300b007b9269a0423sm2004034ejf.172.2022.12.11.03.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 03:09:36 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <c6855fd7-6569-e5fc-0794-352f1bbc573d@redhat.com>
Date:   Sun, 11 Dec 2022 12:09:28 +0100
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
Subject: Re: [PATCH bpf-next v3 03/12] bpf: XDP metadata RX kfuncs
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20221206024554.3826186-1-sdf@google.com>
 <20221206024554.3826186-4-sdf@google.com>
 <f2c89c57-c377-2f8e-fb4d-b047e58d3d38@redhat.com>
 <CAKH8qBuhYUZEbs0UaUDaBOnmqjcSuim4vQhUzsLcOzPRY_eLrw@mail.gmail.com>
In-Reply-To: <CAKH8qBuhYUZEbs0UaUDaBOnmqjcSuim4vQhUzsLcOzPRY_eLrw@mail.gmail.com>
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


On 09/12/2022 18.47, Stanislav Fomichev wrote:
> On Fri, Dec 9, 2022 at 3:11 AM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
>>
>>
>> On 06/12/2022 03.45, Stanislav Fomichev wrote:
>>> There is an ndo handler per kfunc, the verifier replaces a call to the
>>> generic kfunc with a call to the per-device one.
>>>
>>> For XDP, we define a new kfunc set (xdp_metadata_kfunc_ids) which
>>> implements all possible metatada kfuncs. Not all devices have to
>>> implement them. If kfunc is not supported by the target device,
>>> the default implementation is called instead.
>>>
>>> Upon loading, if BPF_F_XDP_HAS_METADATA is passed via prog_flags,
>>> we treat prog_index as target device for kfunc resolution.
>>>
>>
>> [...cut...]
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 5aa35c58c342..2eabb9157767 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -74,6 +74,7 @@ struct udp_tunnel_nic_info;
>>>    struct udp_tunnel_nic;
>>>    struct bpf_prog;
>>>    struct xdp_buff;
>>> +struct xdp_md;
>>>
>>>    void synchronize_net(void);
>>>    void netdev_set_default_ethtool_ops(struct net_device *dev,
>>> @@ -1611,6 +1612,10 @@ struct net_device_ops {
>>>        ktime_t                 (*ndo_get_tstamp)(struct net_device *dev,
>>>                                                  const struct skb_shared_hwtstamps *hwtstamps,
>>>                                                  bool cycles);
>>> +     bool                    (*ndo_xdp_rx_timestamp_supported)(const struct xdp_md *ctx);
>>> +     u64                     (*ndo_xdp_rx_timestamp)(const struct xdp_md *ctx);
>>> +     bool                    (*ndo_xdp_rx_hash_supported)(const struct xdp_md *ctx);
>>> +     u32                     (*ndo_xdp_rx_hash)(const struct xdp_md *ctx);
>>>    };
>>>
>>
>> Would it make sense to add a 'flags' parameter to ndo_xdp_rx_timestamp
>> and ndo_xdp_rx_hash ?
>>
>> E.g. we could have a "STORE" flag that asks the kernel to store this
>> information for later. This will be helpful for both the SKB and
>> redirect use-cases.
>> For redirect e.g into a veth, then BPF-prog can use the same function
>> bpf_xdp_metadata_rx_hash() to receive the RX-hash, as it can obtain the
>> "stored" value (from the BPF-prog that did the redirect).
>>
>> (p.s. Hopefully a const 'flags' variable can be optimized when unrolling
>> to eliminate store instructions when flags==0)
> 
> Are we concerned that doing this without a flag and with another
> function call will be expensive?

Yes, but if we can unroll (to avoid the function calls) it would be more
flexible and explicit API with below instead.

> For xdp->skb path, I was hoping we would be to do something like:
> 
> timestamp = bpf_xdp_metadata_rx_hash(ctx);
> bpf_xdp_metadata_export_rx_hash_to_skb(ctx, timestamp);
> 
> This should also let the users adjust the metadata before storing it.
> Am I missing something here? Why would the flag be preferable?

I do like this ability to let the users adjust the metadata before
storing it.  This would be a more flexible API for the BPF-programmer.
I like your "export" suggestion.  The main concern for me was
performance overhead of the extra function call, which I guess can be
removed via unrolling later.
Unrolling these 'export' functions might be easier to accept from a
maintainer perspective, as it is not device driver specific, thus we can
place that in the core BPF code.

--Jesper

