Return-Path: <bpf+bounces-3962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ABB746EE0
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573AD1C20944
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD046A1;
	Tue,  4 Jul 2023 10:39:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768725662
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 10:39:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1775918D
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688467151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKyh2YKZjw4dZMNDASEhnwjlZJjD/bk3lXbK1isJdxM=;
	b=Y+EFKtJWZHaUfqpvVkkUZvDQBtPDtbcgotL5BjklHXMt0OXdl56qsukOim3qPj0bzA5+E8
	FvPa3qBKdsGos6x+ug2NLTehbwy0UK91IN/q9/ftDFWGCbB44Gj5VasXtR5AwmXe9iAstW
	mGvy8amaUSlQ/467XIORfikgeCNLzJ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-lPCyOatiP52VCg01JshvRg-1; Tue, 04 Jul 2023 06:39:09 -0400
X-MC-Unique: lPCyOatiP52VCg01JshvRg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-313ec030acbso2242637f8f.0
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 03:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688467149; x=1691059149;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKyh2YKZjw4dZMNDASEhnwjlZJjD/bk3lXbK1isJdxM=;
        b=ONW4MvBXz6gXXoH2LbS1b4wrfK3F/eW50UGoiA5RC6Vy2BZfG1vZXejSchjqW+wYUU
         Qw02u4GXpROFcrd4qs56InnRccnvHjxFq5Ztdoc7CHI+rRKGpe2LlN2TqGTpmDsH+ECW
         /mUaqubgx5qehqBkrnMBtir0PkmglU6lADf83OSu0N1BI1pRurO1hDwoLmEsTg2OOjR5
         SVZqdgmnxlnXMSYZtv2n23Q4iSl0bsStuQaZqnAjpqJhgOHGoAOSGz1C/bkM/J6rsLHO
         5nBifSGhw/iKQeEKQHP9bjClpm4WbymCXzo3HnKw1/D9ml+xGREbZIhH9ueCLMM9FH6P
         /qbA==
X-Gm-Message-State: AC+VfDzcy7ExL6todCSQ8Vs0jcvksLGszx7RxMXfklpl+rOrnX5mlBuA
	7+Ae5KxXtjcsfDw0LkLib2QC13vrZYd+hVuqgHoamwp1FlY4X4Oiha2Izhn1JJPNP2kBcqDh/lj
	AfzQGOrnHvUk8
X-Received: by 2002:a5d:4244:0:b0:313:f0a7:133a with SMTP id s4-20020a5d4244000000b00313f0a7133amr16032461wrr.13.1688467148808;
        Tue, 04 Jul 2023 03:39:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7nCIDY7KPZacyNtybDMIiVOQFpcJ51/VuZA9mfRPufhxaz0fUdhkdLRNNWHSASiWsaGwUjdw==
X-Received: by 2002:a5d:4244:0:b0:313:f0a7:133a with SMTP id s4-20020a5d4244000000b00313f0a7133amr16032438wrr.13.1688467148506;
        Tue, 04 Jul 2023 03:39:08 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b0031424950a99sm10813720wrp.81.2023.07.04.03.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 03:39:07 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <9cd44759-416c-7274-f805-ee9d756f15b1@redhat.com>
Date: Tue, 4 Jul 2023 12:39:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/20] xdp: Add checksum level hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>,
 John Fastabend <john.fastabend@gmail.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
 <64a331c338a5a_628d3208cb@john.notmuch> <ZKPlZ6Z8ni5+ZJCK@lincoln>
In-Reply-To: <ZKPlZ6Z8ni5+ZJCK@lincoln>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Cc. DaveM+Alex Duyck, as I value your insights on checksums.

On 04/07/2023 11.24, Larysa Zaremba wrote:
> On Mon, Jul 03, 2023 at 01:38:27PM -0700, John Fastabend wrote:
>> Larysa Zaremba wrote:
>>> Implement functionality that enables drivers to expose to XDP code,
>>> whether checksums was checked and on what level.
>>>
>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>> ---
>>>   Documentation/networking/xdp-rx-metadata.rst |  3 +++
>>>   include/linux/netdevice.h                    |  1 +
>>>   include/net/xdp.h                            |  2 ++
>>>   kernel/bpf/offload.c                         |  2 ++
>>>   net/core/xdp.c                               | 21 ++++++++++++++++++++
>>>   5 files changed, 29 insertions(+)
>>>
>>> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
>>> index ea6dd79a21d3..4ec6ddfd2a52 100644
>>> --- a/Documentation/networking/xdp-rx-metadata.rst
>>> +++ b/Documentation/networking/xdp-rx-metadata.rst
>>> @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
>>>   .. kernel-doc:: net/core/xdp.c
>>>      :identifiers: bpf_xdp_metadata_rx_vlan_tag
>>>   
>>> +.. kernel-doc:: net/core/xdp.c
>>> +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
>>> +
>>>   An XDP program can use these kfuncs to read the metadata into stack
>>>   variables for its own consumption. Or, to pass the metadata on to other
>>>   consumers, an XDP program can store it into the metadata area carried
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 4fa4380e6d89..569563687172 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
>>>   			       enum xdp_rss_hash_type *rss_type);
>>>   	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
>>>   				   __be16 *vlan_proto);
>>> +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
>>>   };
>>>   
>>>   /**
>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>> index 89c58f56ffc6..61ed38fa79d1 100644
>>> --- a/include/net/xdp.h
>>> +++ b/include/net/xdp.h
>>> @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>>>   			   bpf_xdp_metadata_rx_hash) \
>>>   	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
>>>   			   bpf_xdp_metadata_rx_vlan_tag) \
>>> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
>>> +			   bpf_xdp_metadata_rx_csum_lvl) \
>>>   
>>>   enum {
>>>   #define XDP_METADATA_KFUNC(name, _) name,
>>> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
>>> index 986e7becfd42..a133fb775f49 100644
>>> --- a/kernel/bpf/offload.c
>>> +++ b/kernel/bpf/offload.c
>>> @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
>>>   		p = ops->xmo_rx_hash;
>>>   	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
>>>   		p = ops->xmo_rx_vlan_tag;
>>> +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
>>> +		p = ops->xmo_rx_csum_lvl;
>>>   out:
>>>   	up_read(&bpf_devs_lock);
>>>   
>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>> index f6262c90e45f..c666d3e0a26c 100644
>>> --- a/net/core/xdp.c
>>> +++ b/net/core/xdp.c
>>> @@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
>>>   	return -EOPNOTSUPP;
>>>   }
>>>   
>>> +/**
>>> + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
>>> + * @ctx: XDP context pointer.
>>> + * @csum_level: Return value pointer.
>>> + *
>>> + * In case of success, csum_level contains depth of the last verified checksum.
>>> + * If only the outermost checksum was verified, csum_level is 0, if both
>>> + * encapsulation and inner transport checksums were verified, csum_level is 1,
>>> + * and so on.
>>> + * For more details, refer to csum_level field in sk_buff.
>>> + *
>>> + * Return:
>>> + * * Returns 0 on success or ``-errno`` on error.
>>> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
>>> + * * ``-ENODATA``    : Checksum was not validated
>>> + */
>>> +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
>>
>> Istead of ENODATA should we return what would be put in the ip_summed field
>> CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,

I was thinking the same, what about checksum "type".

>>
>>   bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);
>>
>> or something like that? Or is the thought that its not really necessary?
>> I don't have a strong preference but figured it was worth asking.
>>
> 
> I see no value in returning CHECKSUM_COMPLETE without the actual checksum value.
> Same with CHECKSUM_PARTIAL and csum_start. Returning those values too would
> overcomplicate the function signature.
>   

So, this kfunc bpf_xdp_metadata_rx_csum_lvl() success is it equivilent 
to CHECKSUM_UNNECESSARY?

Looking at documentation[1] (generated from skbuff.h):
  [1] 
https://kernel.org/doc/html/latest/networking/skbuff.html#checksumming-of-received-packets-by-device

Is the idea that we can add another kfunc (new signature) than can deal
with the other types of checksums (in a later kernel release)?


>>> +{
>>> +	return -EOPNOTSUPP;
>>> +}
>>> +
>>>   __diag_pop();
> 


