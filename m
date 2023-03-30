Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C66D0E59
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 21:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjC3TJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjC3TJY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 15:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE1F768
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680203313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIyaaupty9iH5e8okKyS4faQPVv+h3/KYTHOe9P8lNM=;
        b=VThSusUP+pS4Zr3Own4DRkZ+Xb/nPdLDsKfpsxuk28kLfXHhOkHNy3oA9fScuoihZEhiVa
        b+ELLFcIO7z89SUerBk5gQQKzRbo1AQP60z/FoXdR0pXfhpuCcsw9BsEtKqwHi9NPmrtmQ
        xkalDTANBWSZpbh9suLlNPaArMFz3n8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-kckywEErPlGdZ8FbledyKA-1; Thu, 30 Mar 2023 15:08:31 -0400
X-MC-Unique: kckywEErPlGdZ8FbledyKA-1
Received: by mail-lj1-f198.google.com with SMTP id f12-20020a05651c02cc00b002a61d5315c7so637827ljo.17
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203310;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIyaaupty9iH5e8okKyS4faQPVv+h3/KYTHOe9P8lNM=;
        b=GkgfPpvuNOnvga343h07U9Mc2u/KXFZBS6+sjWvB8H56PRav5fA5HBh+OCDlwM2GuY
         sXB0nZ0Jl8npyO/SYBFFuMb3vJ2qZXiydIf6p38RX/IOdLkkvTMM2zIzzslZAgeXwaAi
         3+39T9RFs2VBxkryQsMvGKVBnsofNN6BangAawlBn9VRIqZ9lIWYnnsNE81B6PL6hr/n
         XlWTsjxMK+R+xYpXWIUGFk/ZYMMDiLBoQ1om4hYQnKimZPZQjDJUWEBKVOpZbS3jNESr
         +A6JCgRGekxjzqD0D5dMxWcYSdYX2BZOR63DaqNqhhxCzcVEfwaD27NbTx+cbSpl42xk
         jOsg==
X-Gm-Message-State: AAQBX9fSU8lrS1GY7adJq97zhXP8pQVEat5n0/cRmWn507PjYIkOwq3y
        OpLqJfwq+Q76MScJIa7zvKhjnOQAT5twpnf/UBYC/wMCjlxFvQBp0E6pXoJDCJdetO7AOP/zARi
        yC6esrk6cB2VI
X-Received: by 2002:ac2:52a7:0:b0:4e9:67ee:6383 with SMTP id r7-20020ac252a7000000b004e967ee6383mr7447708lfm.2.1680203310053;
        Thu, 30 Mar 2023 12:08:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKvSvkdF6fNAH+wrbQaLQufyKmJaCZnmEVpXJ2b/BW3Wbguqu1eLX/GMUXXgVjiD0k4RvRbw==
X-Received: by 2002:ac2:52a7:0:b0:4e9:67ee:6383 with SMTP id r7-20020ac252a7000000b004e967ee6383mr7447700lfm.2.1680203309722;
        Thu, 30 Mar 2023 12:08:29 -0700 (PDT)
Received: from [192.168.42.100] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id h3-20020a2e9ec3000000b00293d7c95df1sm33830ljk.78.2023.03.30.12.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 12:08:29 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <c305e8ed-bd2c-3301-3a19-c983ff14a3ed@redhat.com>
Date:   Thu, 30 Mar 2023 21:08:27 +0200
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
In-Reply-To: <CAKH8qBv9QngYcMjcL=sZR8wVCufPSAv-ZW72OJB-LhZF5a_DrQ@mail.gmail.com>
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


On 30/03/2023 21.02, Stanislav Fomichev wrote:
> On Thu, Mar 30, 2023 at 11:56 AM Jesper Dangaard Brouer
>>
>> On 30/03/2023 20.35, Stanislav Fomichev wrote:
>>> On 03/30, Jesper Dangaard Brouer wrote:
[...]
>> [...]
>>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>>> index 528d4b37983d..38d2dee16b47 100644
>>>> --- a/net/core/xdp.c
>>>> +++ b/net/core/xdp.c
>>>> @@ -734,14 +734,22 @@ __bpf_kfunc int
>>>> bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *tim
>>>>     * bpf_xdp_metadata_rx_hash - Read XDP frame RX hash.
>>>>     * @ctx: XDP context pointer.
>>>>     * @hash: Return value pointer.
>>>> + * @rss_type: Return value pointer for RSS type.
>>>> + *
>>>> + * The RSS hash type (@rss_type) specifies what portion of packet headers NIC
>>>> + * hardware were used when calculating RSS hash value.  The type combinations
>>>> + * are defined via &enum xdp_rss_hash_type and individual bits can be decoded
>>>> + * via &enum xdp_rss_type_bits.
>>>>     *
>>>>     * Return:
>>>>     * * Returns 0 on success or ``-errno`` on error.
>>>>     * * ``-EOPNOTSUPP`` : means device driver doesn't implement kfunc
>>>>     * * ``-ENODATA``    : means no RX-hash available for this frame
>>>>     */
>>>> -__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx,
>>>> u32 *hash)
>>>> +__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx,
>>>> u32 *hash,
>>>> +                     enum xdp_rss_hash_type *rss_type)
>>>>    {
>>> [..]
>>>
>>>> +    BTF_TYPE_EMIT(enum xdp_rss_type_bits);
>>> nit: Do we still need this with an extra argument?
>>>
>> Yes, unfortunately (compiler optimizes out enum xdp_rss_type_bits).
>> Do notice the difference xdp_rss_type_bits vs xdp_rss_hash_type.
>> We don't need it for "xdp_rss_hash_type" but need it for
>> "xdp_rss_type_bits".
 >
> Ah, I missed that. Then why not expose xdp_rss_type_bits?
> Keep xdp_rss_hash_type for internal drivers' tables, and export the
> enum with the bits?

Great suggestion, xdp_rss_hash_type will be internal for drivers.
I will do that in V4.

--Jesper


