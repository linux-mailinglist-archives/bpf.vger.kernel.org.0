Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F25B6D0E32
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjC3S5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjC3S5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B6DBF5
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680202584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0okzHNuuHJ7nFnN8RcKBErkj+TCd+hop8cnDkGfnQ8=;
        b=I0o1SOcOUr79XUU+Iy9R09ElXqumR8SQZterBSJc14Krn7IFdy1vDCuCKCIpEEsMELOD0Y
        EpypO4BphiA+NyF5hsmBv6PHEHH7TcKfDJ45aoJAvZleCBiY59hLCZEZJtH6kn9nId78Mg
        Dr3ne2J7DduiLb9lyi41pwA5huzH7xU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-rhGpYpDLNnOSxNzi33AlBw-1; Thu, 30 Mar 2023 14:56:22 -0400
X-MC-Unique: rhGpYpDLNnOSxNzi33AlBw-1
Received: by mail-lf1-f71.google.com with SMTP id g33-20020a0565123ba100b004dc6259b7acso7655042lfv.6
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202581;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0okzHNuuHJ7nFnN8RcKBErkj+TCd+hop8cnDkGfnQ8=;
        b=SrVsqnc0q6E+AI22CC/Qnoup7XSf0DxAFUsaeUXJEiGBLBNMzIgJWvintIGT5e/6ol
         oK9yvmXprN4ibW2Vax4Zt1n11p2KQ8r2CXVwOzvDH/jYTHBq2vbgNHQyQCqKwFbw1FXR
         pqXsLO0VeIJjhgCAhKg/O7SZZryCgE8AJVJ90I2P5/K8F0XRyTKIxPS8N6N5sRo/oLjb
         RcW1DepuYj9DBw7XZBoty9trTFrT8TdAOddOr3er/ddzOTAAuMsgJ/PYFRIhFcjV0EU+
         tik67cwpqBOop8vWy3nYSf96vQ83g2oSsDEqaE9sm8UIU6uhiQnHBxNTRH+Sf8zhzBaZ
         I7aA==
X-Gm-Message-State: AAQBX9d54ckxjEdyQGrPMigwTEnUL3CznBOdx2/wmh3a09DyQG5qmkmY
        KT9ZgBzKLZS3i4hansKElHfrJITodIpxESwHV7IfCTzlRfFf0lGNn7VwwijX/uVwp9s83LjJSdH
        JhVogn+j53KXK
X-Received: by 2002:a05:6512:250:b0:4e9:ccff:daa6 with SMTP id b16-20020a056512025000b004e9ccffdaa6mr7178081lfo.30.1680202581352;
        Thu, 30 Mar 2023 11:56:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zqt3JN5UFdxjITpltBXX6C9yIP1DjUue3LM+nCC5N3ax4dDfLfhxQFL/UiF4ELYpZEKGrQtg==
X-Received: by 2002:a05:6512:250:b0:4e9:ccff:daa6 with SMTP id b16-20020a056512025000b004e9ccffdaa6mr7178073lfo.30.1680202581033;
        Thu, 30 Mar 2023 11:56:21 -0700 (PDT)
Received: from [192.168.42.100] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id u1-20020a056512040100b004dc53353d15sm48564lfk.281.2023.03.30.11.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 11:56:20 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <04256caf-aa28-7e0a-59b1-ecf2b237c96f@redhat.com>
Date:   Thu, 30 Mar 2023 20:56:19 +0200
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
To:     Stanislav Fomichev <sdf@google.com>
References: <168019602958.3557870.9960387532660882277.stgit@firesoul>
 <168019606574.3557870.15629824904085210321.stgit@firesoul>
 <ZCXWerysZL1XwVfX@google.com>
In-Reply-To: <ZCXWerysZL1XwVfX@google.com>
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


On 30/03/2023 20.35, Stanislav Fomichev wrote:
> On 03/30, Jesper Dangaard Brouer wrote:
>> The RSS hash type specifies what portion of packet data NIC hardware used
>> when calculating RSS hash value. The RSS types are focused on Internet
>> traffic protocols at OSI layers L3 and L4. L2 (e.g. ARP) often get hash
>> value zero and no RSS type. For L3 focused on IPv4 vs. IPv6, and L4
>> primarily TCP vs UDP, but some hardware supports SCTP.
> 
>> Hardware RSS types are differently encoded for each hardware NIC. Most
>> hardware represent RSS hash type as a number. Determining L3 vs L4 often
>> requires a mapping table as there often isn't a pattern or sorting
>> according to ISO layer.
> 
>> The patch introduce a XDP RSS hash type (enum xdp_rss_hash_type) that
>> contain combinations to be used by drivers, which gets build up with bits
>> from enum xdp_rss_type_bits. Both enum xdp_rss_type_bits and
>> xdp_rss_hash_type get exposed to BPF via BTF, and it is up to the
>> BPF-programmer to match using these defines.
> 
>> This proposal change the kfunc API bpf_xdp_metadata_rx_hash() adding
>> a pointer value argument for provide the RSS hash type.
> 
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> ---
>>   include/linux/netdevice.h |    3 ++-
>>   include/net/xdp.h         |   46 +++++++++++++++++++++++++++++++++++++++++++++
>>   net/core/xdp.c            |   10 +++++++++-
>>   3 files changed, 57 insertions(+), 2 deletions(-)
> 

[...]
>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>> index 528d4b37983d..38d2dee16b47 100644
>> --- a/net/core/xdp.c
>> +++ b/net/core/xdp.c
>> @@ -734,14 +734,22 @@ __bpf_kfunc int 
>> bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *tim
>>    * bpf_xdp_metadata_rx_hash - Read XDP frame RX hash.
>>    * @ctx: XDP context pointer.
>>    * @hash: Return value pointer.
>> + * @rss_type: Return value pointer for RSS type.
>> + *
>> + * The RSS hash type (@rss_type) specifies what portion of packet headers NIC
>> + * hardware were used when calculating RSS hash value.  The type combinations
>> + * are defined via &enum xdp_rss_hash_type and individual bits can be decoded
>> + * via &enum xdp_rss_type_bits.
>>    *
>>    * Return:
>>    * * Returns 0 on success or ``-errno`` on error.
>>    * * ``-EOPNOTSUPP`` : means device driver doesn't implement kfunc
>>    * * ``-ENODATA``    : means no RX-hash available for this frame
>>    */
>> -__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, 
>> u32 *hash)
>> +__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, 
>> u32 *hash,
>> +                     enum xdp_rss_hash_type *rss_type)
>>   {
> 
> [..]
> 
>> +    BTF_TYPE_EMIT(enum xdp_rss_type_bits);
> 
> nit: Do we still need this with an extra argument?
> 

Yes, unfortunately (compiler optimizes out enum xdp_rss_type_bits).
Do notice the difference xdp_rss_type_bits vs xdp_rss_hash_type.
We don't need it for "xdp_rss_hash_type" but need it for 
"xdp_rss_type_bits".

--Jesper

