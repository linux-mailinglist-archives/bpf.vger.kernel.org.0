Return-Path: <bpf+bounces-3982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6539F7473EA
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9581E1C209F7
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32763B9;
	Tue,  4 Jul 2023 14:18:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B22575
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 14:18:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BA21B2
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688480290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4W0Ogxpa8sJrFSBMqpX3IACkQSfwLXhF0ZJKwAmgao=;
	b=Tbwx9GwAfl/FuWd2vo5/EBP5atq/GccaZ/R3mcjF2qMF+2om+HGXjR4dVr9OKLvxZnfUph
	lONa2J9CNfYMr75Ln3ciLIEkRk/3r+SWcLMLHIEGkVmoJ751AsThvRV6fExiFZX9/Ntjn5
	JTZRokmRkzFfg9oWdDZdriPALaM1BTg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-2o5WCAf0Nda5yXwbzu4CoQ-1; Tue, 04 Jul 2023 10:18:08 -0400
X-MC-Unique: 2o5WCAf0Nda5yXwbzu4CoQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3142665f122so2424263f8f.0
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 07:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480287; x=1691072287;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4W0Ogxpa8sJrFSBMqpX3IACkQSfwLXhF0ZJKwAmgao=;
        b=IMDmYWzdcYAhr9NIRIZfMKFAiC5bZc6wB6gQkPwPwjTp9y8sXdmkg9iaIAQShZh8Se
         /C2sLreUnicvKo/foZzomgKKAwYY0eUnY850WirtwV7cmGaKSn8MIO0F3NVCWiUGiyFN
         cdqStGMCawLRndoK8sZlxw+KZ0U72CEyMcYiym1IYn3a5o81PhumizrhztmQdAMrqqqr
         7QZ21bBLQI+v+j0jTSu9hmDlBuC3NljAWaKEM9hH5gyxAa5+eMFAuCAz+OLrmNTAR1PE
         pXCf8egnJhhM6WjiiLcMdpY63Jz+ScC6z5H8Qq0/jwL80b8t2sBHmfjGQFxNF4jwlzvj
         dCdw==
X-Gm-Message-State: ABy/qLYnyAl01d9LxjoY0HqE3SVkkE9zMyqezI4Y7PyAJnPbFY8ya007
	4IVzjMNQhlJPAN3nLV2nW4yPhD4HBBm07YtCbUQx5AszuLxgXCpH4thYpMAKYael2YzMz/veWff
	36TlVqACSg02O
X-Received: by 2002:a05:6000:a:b0:30f:c1c3:8173 with SMTP id h10-20020a056000000a00b0030fc1c38173mr10890240wrx.26.1688480287605;
        Tue, 04 Jul 2023 07:18:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpeSoz/H9agHQn4Iqt+dYO6GmEXxow7iabaTyxRXg7CjU9CY9DFkQO5OFPhu8Z0GhngELNMA==
X-Received: by 2002:a05:6000:a:b0:30f:c1c3:8173 with SMTP id h10-20020a056000000a00b0030fc1c38173mr10890204wrx.26.1688480287289;
        Tue, 04 Jul 2023 07:18:07 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id f3-20020adff443000000b00314367cf43asm6145953wrp.106.2023.07.04.07.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:18:06 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <e0050610-ee6f-7c3c-a303-7cddc73cff7c@redhat.com>
Date: Tue, 4 Jul 2023 16:18:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, John Fastabend <john.fastabend@gmail.com>,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH bpf-next v2 09/20] xdp: Add VLAN tag hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-10-larysa.zaremba@intel.com>
 <64a32c661648e_628d32085f@john.notmuch> <ZKPW6azl0Ak27wSO@lincoln>
 <f7aa7eb6-4600-cebf-bd09-d05fc627fd0d@redhat.com> <ZKP8KRy04IqyHXuI@lincoln>
In-Reply-To: <ZKP8KRy04IqyHXuI@lincoln>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 04/07/2023 13.02, Larysa Zaremba wrote:
> On Tue, Jul 04, 2023 at 12:23:45PM +0200, Jesper Dangaard Brouer wrote:
>>
>> On 04/07/2023 10.23, Larysa Zaremba wrote:
>>> On Mon, Jul 03, 2023 at 01:15:34PM -0700, John Fastabend wrote:
>>>> Larysa Zaremba wrote:
>>>>> Implement functionality that enables drivers to expose VLAN tag
>>>>> to XDP code.
>>>>>
>>>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>>>> ---
>>>>>    Documentation/networking/xdp-rx-metadata.rst |  8 +++++++-
>>>>>    include/linux/netdevice.h                    |  2 ++
>>>>>    include/net/xdp.h                            |  2 ++
>>>>>    kernel/bpf/offload.c                         |  2 ++
>>>>>    net/core/xdp.c                               | 20 ++++++++++++++++++++
>>>>>    5 files changed, 33 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
>>>>> index 25ce72af81c2..ea6dd79a21d3 100644
>>>>> --- a/Documentation/networking/xdp-rx-metadata.rst
>>>>> +++ b/Documentation/networking/xdp-rx-metadata.rst
>>>>> @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
>>>>>    metadata is supported, this set will grow:
>>>>>    .. kernel-doc:: net/core/xdp.c
>>>>> -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
>>>>> +   :identifiers: bpf_xdp_metadata_rx_timestamp
>>>>> +
>>>>> +.. kernel-doc:: net/core/xdp.c
>>>>> +   :identifiers: bpf_xdp_metadata_rx_hash
>>>>> +
>>>>> +.. kernel-doc:: net/core/xdp.c
>>>>> +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
>>>>>    An XDP program can use these kfuncs to read the metadata into stack
>>>>>    variables for its own consumption. Or, to pass the metadata on to other
>> [...]
>>>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>>>> index 41e5ca8643ec..f6262c90e45f 100644
>>>>> --- a/net/core/xdp.c
>>>>> +++ b/net/core/xdp.c
>>>>> @@ -738,6 +738,26 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>>>>>    	return -EOPNOTSUPP;
>>>>>    }
>>>>> +/**
>>>>> + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag with protocol
>>>>> + * @ctx: XDP context pointer.
>>>>> + * @vlan_tag: Destination pointer for VLAN tag
>>>>> + * @vlan_proto: Destination pointer for VLAN protocol identifier in network byte order.
>>>>> + *
>>>>> + * In case of success, vlan_tag contains VLAN tag, including 12 least significant bytes
>>>>> + * containing VLAN ID, vlan_proto contains protocol identifier.
>>>>
>>>> Above is a bit confusing to me at least.
>>>>
>>>> The vlan tag would be both the 16bit TPID and 16bit TCI. What fields
>>>> are to be included here? The VlanID or the full 16bit TCI meaning the
>>>> PCP+DEI+VID?
>>>
>>> It contains PCP+DEI+VID, in patch 16 ("selftests/bpf: Add flags and new hints to
>>> xdp_hw_metadata") this is more clear, because the tag is parsed.
>>>
>>
>> Do we really care about the "EtherType" proto (in VLAN speak TPID = Tag
>> Protocol IDentifier)?
>> I mean, it can basically only have two values[1], and we just wanted to
>> know if it is a VLAN (that hardware offloaded/removed for us):
> 
> If we assume everyone follows the standard, this would be correct.
> But apparently, some applications use some ambiguous value as a TPID [0].
> 
> So it is not hard to imagine, some NICs could alllow you to configure your
> custom TPID. I am not sure if any in-tree drivers actually do this, but I think
> it's nice to provide some flexibility on XDP level, especially considering
> network stack stores full vlan_proto.
>

I'm buying your argument, and agree it makes sense to provide TPID in
the call signature.  Given weird hardware exists that allow people to
configure custom TPID.

Looking through kernel defines (in uapi/linux/if_ether.h) I see evidence
that funky QinQ EtherTypes have been used in the past:

  #define ETH_P_QINQ1	0x9100		/* deprecated QinQ VLAN [ NOT AN 
OFFICIALLY REGISTERED ID ] */
  #define ETH_P_QINQ2	0x9200		/* deprecated QinQ VLAN [ NOT AN 
OFFICIALLY REGISTERED ID ] */
  #define ETH_P_QINQ3	0x9300		/* deprecated QinQ VLAN [ NOT AN 
OFFICIALLY REGISTERED ID ] */


> [0]
> https://techhub.hpe.com/eginfolib/networking/docs/switches/7500/5200-1938a_l2-lan_cg/content/495503472.htm
> 
>>
>>   static __always_inline int proto_is_vlan(__u16 h_proto)
>>   {
>> 	return !!(h_proto == bpf_htons(ETH_P_8021Q) ||
>> 		  h_proto == bpf_htons(ETH_P_8021AD));
>>   }
>>
>> [1] https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L75-L79
>>
>> Cc. Andrew Lunn, as I notice DSA have a fake VLAN define ETH_P_DSA_8021Q
>> (in file include/uapi/linux/if_ether.h)
>> Is this actually in use?
>> Maybe some hardware can "VLAN" offload this?
>>
>>
>>> What about rephrasing it this way:
>>>
>>> In case of success, vlan_proto contains VLAN protocol identifier (TPID),
>>> vlan_tag contains the remaining 16 bits of a 802.1Q tag (PCP+DEI+VID).
>>>
>>
>> Hmm, I think we can improve this further. This text becomes part of the
>> documentation for end-users (target audience).  Thus, I think it is
>> worth being more verbose and even mention the existing defines that we
>> are expecting end-users to take advantage of.
>>
>> What about:
>>
>> In case of success. The VLAN EtherType is stored in vlan_proto (usually
>> either ETH_P_8021Q or ETH_P_8021AD) also known as TPID (Tag Protocol
>> IDentifier). The VLAN tag is stored in vlan_tag, which is a 16-bit field
>> containing sub-fields (PCP+DEI+VID). The VLAN ID (VID) is 12-bits
>> commonly extracted using mask VLAN_VID_MASK (0x0fff).  For the meaning
>> of the sub-fields Priority Code Point (PCP) and Drop Eligible Indicator
>> (DEI) (formerly CFI) please reference other documentation. Remember
>> these 16-bit fields are stored in network-byte. Thus, transformation
>> with byte-order helper functions like bpf_ntohs() are needed.
>>
> 
> AFAIK, vlan_tag is stored in host byte order, this is how it is in skb.

I'm not sure we should follow SKB storage scheme for XDP.

> In ice, we receive VLAN tag in descriptor already in LE.
> Only protocol is BE (network byte order). So I would replace the last 2
> sentences with the following:
> 
> vlan_tag is stored in host byte order, so no byte order conversion is needed.

Yikes, that was unexpected.  This needs to be heavily documented in docs.

When parsing packets, it is in network-byte-order, else my code is wrong 
here[1]:

   [1] 
https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L122

I'm accessing the skb->vlan_tci here [2], and I notice I don't do any
byte-order conversions, so fortunately I didn't make a code mistake.

   [2] 
https://github.com/xdp-project/bpf-examples/blob/master/traffic-pacing-edt/edt_pacer_vlan.c#L215

> vlan_proto is stored in network byte order, the suggested way to use this value:
> 
> vlan_proto == bpf_htons(ETH_P_8021Q)
> 
>>
>>

--Jesper


