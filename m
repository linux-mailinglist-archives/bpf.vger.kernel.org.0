Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8B6D1F6D
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 13:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCaLuK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 07:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCaLuJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 07:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C310C1
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680263366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zD7Fcr7w9U80vT79GcOoW/MaviXOYk1Az8mLggNbZ00=;
        b=a/UjXmyiOk/RAUzl/+U2Y+ONhxQrdJ2oZrV4khj3PbXaCINC118nJwt3KOw5O1DLT8z406
        IVyaGgcONetc92IHvLa1ffhLeJfAOiCLlYEgkkXqxRPkcsjwTnC8f13M7fcW+ILA5zewXG
        kF0B60heRtjVa5zaZYRvGVlxPTg2QB4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-gNUDw0SdM9OHwQZVmH_Gyg-1; Fri, 31 Mar 2023 07:49:20 -0400
X-MC-Unique: gNUDw0SdM9OHwQZVmH_Gyg-1
Received: by mail-lj1-f198.google.com with SMTP id s4-20020a05651c200400b002a623adbf16so298106ljo.20
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 04:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680263358;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD7Fcr7w9U80vT79GcOoW/MaviXOYk1Az8mLggNbZ00=;
        b=1oHpgoazOQXIXernyxqQt2X85LdEvPomnBX2Zd0OYhECmOJ5Jy65UTWk52OVKUolvB
         ZJevJ1pjbJzfwhXwvgYaywafnXJNKgPf4SJo/3rOLmQtpHPPXadjtr4E6TUR8aikoYUX
         xnOts/2S8yv9H3ZlV21R6aPzWzHzL0Epthq4ttWigx3Y4z3UJg4nh+ZFqyVSSUFu7gHB
         vKVqVrmyhvHCPTG13DiNcjfue9fAh8sE3RZMTAC1Z7QhNl2Tu0BY/49NAujuLCCBYgCV
         575KvwyzeT2AKOWzGCPpzbCEF2Z4nwnjfxA6Uz/10yYd6oB6CVD5jXMCGLVVsEZy1AFY
         Q/8w==
X-Gm-Message-State: AAQBX9d1KZWdC5bAtmZsMcR7vDMGZ7dLeUVmfgyGrN74o39pZ5Jd8hUh
        +fKM7/P6pCxtfdENzK4/HrMsdBadHZq6zMmqZ+dvYeI1R1k37fdZW2xQevpZbhX095M941X6Hxo
        yXsKuoMSXqznn
X-Received: by 2002:a19:550b:0:b0:4e9:c627:195d with SMTP id n11-20020a19550b000000b004e9c627195dmr7334167lfe.57.1680263358573;
        Fri, 31 Mar 2023 04:49:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350YXUZu270+8qjZ4z0+edJ3P9KJHYqAy5QUXqjX7+ncQ8rXhZDHeTQST65e/JzidOlbbZmKR2Q==
X-Received: by 2002:a19:550b:0:b0:4e9:c627:195d with SMTP id n11-20020a19550b000000b004e9c627195dmr7334151lfe.57.1680263358254;
        Fri, 31 Mar 2023 04:49:18 -0700 (PDT)
Received: from [192.168.42.100] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id f4-20020a19ae04000000b004db3e2d3efesm346623lfc.204.2023.03.31.04.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 04:49:16 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <39b58460-6322-2c07-990a-864dc210ba0a@redhat.com>
Date:   Fri, 31 Mar 2023 13:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH bpf RFC-V3 1/5] xdp: rss hash types representation
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <168019602958.3557870.9960387532660882277.stgit@firesoul>
 <168019606574.3557870.15629824904085210321.stgit@firesoul>
 <ZCXWerysZL1XwVfX@google.com>
 <04256caf-aa28-7e0a-59b1-ecf2b237c96f@redhat.com>
 <CAKH8qBv9QngYcMjcL=sZR8wVCufPSAv-ZW72OJB-LhZF5a_DrQ@mail.gmail.com>
 <c305e8ed-bd2c-3301-3a19-c983ff14a3ed@redhat.com>
In-Reply-To: <c305e8ed-bd2c-3301-3a19-c983ff14a3ed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 30/03/2023 21.08, Jesper Dangaard Brouer wrote:
> 
> On 30/03/2023 21.02, Stanislav Fomichev wrote:
>> On Thu, Mar 30, 2023 at 11:56 AM Jesper Dangaard Brouer
>>>
>>> On 30/03/2023 20.35, Stanislav Fomichev wrote:
>>>> On 03/30, Jesper Dangaard Brouer wrote:
> [...]
>>> [...]
>>>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>>>> index 528d4b37983d..38d2dee16b47 100644
>>>>> --- a/net/core/xdp.c
>>>>> +++ b/net/core/xdp.c
>>>>> @@ -734,14 +734,22 @@ __bpf_kfunc int
>>>>> bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *tim
>>>>>     * bpf_xdp_metadata_rx_hash - Read XDP frame RX hash.
>>>>>     * @ctx: XDP context pointer.
>>>>>     * @hash: Return value pointer.
>>>>> + * @rss_type: Return value pointer for RSS type.
>>>>> + *
>>>>> + * The RSS hash type (@rss_type) specifies what portion of packet 
>>>>> headers NIC
>>>>> + * hardware were used when calculating RSS hash value.  The type 
>>>>> combinations
>>>>> + * are defined via &enum xdp_rss_hash_type and individual bits can 
>>>>> be decoded
>>>>> + * via &enum xdp_rss_type_bits.
>>>>>     *
>>>>>     * Return:
>>>>>     * * Returns 0 on success or ``-errno`` on error.
>>>>>     * * ``-EOPNOTSUPP`` : means device driver doesn't implement kfunc
>>>>>     * * ``-ENODATA``    : means no RX-hash available for this frame
>>>>>     */
>>>>> -__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx,
>>>>> u32 *hash)
>>>>> +__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx,
>>>>> u32 *hash,
>>>>> +                     enum xdp_rss_hash_type *rss_type)
>>>>>    {
>>>> [..]
>>>>
>>>>> +    BTF_TYPE_EMIT(enum xdp_rss_type_bits);
>>>> nit: Do we still need this with an extra argument?
>>>>
>>> Yes, unfortunately (compiler optimizes out enum xdp_rss_type_bits).
>>> Do notice the difference xdp_rss_type_bits vs xdp_rss_hash_type.
>>> We don't need it for "xdp_rss_hash_type" but need it for
>>> "xdp_rss_type_bits".
>  >
>> Ah, I missed that. Then why not expose xdp_rss_type_bits?
>> Keep xdp_rss_hash_type for internal drivers' tables, and export the
>> enum with the bits?
> 
> Great suggestion, xdp_rss_hash_type will be internal for drivers.
> I will do that in V4.

I'm running into annoying compiler warnings [-Wenum-conversion]
about enum conversions.  I'll try to workaround this...
The easiest solution seem to be to only have a single enum, that both 
contains the BIT()s and combinations of bits (for driver usage).

E.g.
  warning: implicit conversion from 'enum xdp_rss_type_bits' to 'enum 
xdp_rss_hash_type' [-Wenum-conversion]

