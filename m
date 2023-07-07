Return-Path: <bpf+bounces-4428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35AF74B24F
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DD11C20FD7
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027ED2FA;
	Fri,  7 Jul 2023 13:57:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A923D2F5
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 13:57:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F11FF7
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688738239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=II7D4UkorrIlx/YRRKom6yRl+Wlp37yJA4ro88dBbCU=;
	b=aCoO/ZShZgxDQo4AcO+dLPorTfJZSoEWYsBzK3KSfqqft6S5KGwuK9SOLEvdtmDP0ia7EI
	WWIy+FLRQ4fzUlIZhJ2v1CFv1FRZNPzjYHDLB6fOxKQbAKFslqdyCpyce5v0tbwiV6HxZ9
	iorLOUqfPG5V88Qx7XOpnp9NpWDAcMY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-uT9wCGDnPpy3fTVIM5HcXw-1; Fri, 07 Jul 2023 09:57:16 -0400
X-MC-Unique: uT9wCGDnPpy3fTVIM5HcXw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-977e6c94186so141198466b.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 06:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738235; x=1691330235;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=II7D4UkorrIlx/YRRKom6yRl+Wlp37yJA4ro88dBbCU=;
        b=QcYPftQBaBAjhF5G9YBzfxm4v6UfdmbY5fSUpxlLdG8Q+T8D5AnXG4c2tvKYIVvN8M
         dLu6UB3V/1u3Le7B8/V59t9MCPVJEx95IlDMKa3rtw7IH3nFIRiqUwZHc2tD2znMzWFe
         KHg7Ddh6ushAGjgyQOwsLZrnE1z6ekkgwRWwfeky6ZRigd29eYFc7Lr8Kz5n9zaNdEVz
         4Fk2xpt7AqS5hATKvIYXjyNrTr2xULA4Cwo7LwGy8VSAg8fw0S6i2w55Gw1+rbq9KFyT
         99QNfOzMJfCwOhN7BtHa+WbOUhagmUPYYSJRlOyjnzUvqtPb+D6ww6gddOP963LnhbqK
         iwuA==
X-Gm-Message-State: ABy/qLb3dEWX7dgtad7ZqVRKYpAB/xc0pjXa3OOuOfR9UpkiyRRAUBuS
	1Gs6B79/yqg+ourPHQcUyJhppKSUqF4Rm5D9UDqzB+7gWHNtt4hDREBFVT7/3hzY/R4ztZ/0p9E
	PwBl+ySnr7IoM
X-Received: by 2002:a17:906:300b:b0:98e:1deb:cb03 with SMTP id 11-20020a170906300b00b0098e1debcb03mr3768353ejz.56.1688738235000;
        Fri, 07 Jul 2023 06:57:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHa25BG2ejW+MgDXRT8DkWP17AYGNeGsrzkiOYO45jZiMUQuJvuW/992KFBYVq4l+5cpvFQcw==
X-Received: by 2002:a17:906:300b:b0:98e:1deb:cb03 with SMTP id 11-20020a170906300b00b0098e1debcb03mr3768339ejz.56.1688738234636;
        Fri, 07 Jul 2023 06:57:14 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906341900b0098d2f703408sm2220608ejb.118.2023.07.07.06.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:57:14 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <bb8e2be1-4df9-8b26-468e-4d5d13e006c1@redhat.com>
Date: Fri, 7 Jul 2023 15:57:13 +0200
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
 <e0050610-ee6f-7c3c-a303-7cddc73cff7c@redhat.com> <ZKbTxDKCRlnJxyf0@lincoln>
In-Reply-To: <ZKbTxDKCRlnJxyf0@lincoln>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 06/07/2023 16.46, Larysa Zaremba wrote:
> On Tue, Jul 04, 2023 at 04:18:04PM +0200, Jesper Dangaard Brouer wrote:
>>
>>
>> On 04/07/2023 13.02, Larysa Zaremba wrote:
>>> On Tue, Jul 04, 2023 at 12:23:45PM +0200, Jesper Dangaard Brouer wrote:
>>>>
>>>> On 04/07/2023 10.23, Larysa Zaremba wrote:
>>>>> On Mon, Jul 03, 2023 at 01:15:34PM -0700, John Fastabend wrote:
>>>>>> Larysa Zaremba wrote:
>>>>>>> Implement functionality that enables drivers to expose VLAN tag
>>>>>>> to XDP code.
>>>>>>>
>>>>>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>>>>>> ---
>>>>>>>     Documentation/networking/xdp-rx-metadata.rst |  8 +++++++-
>>>>>>>     include/linux/netdevice.h                    |  2 ++
>>>>>>>     include/net/xdp.h                            |  2 ++
>>>>>>>     kernel/bpf/offload.c                         |  2 ++
>>>>>>>     net/core/xdp.c                               | 20 ++++++++++++++++++++
>>>>>>>     5 files changed, 33 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
>>>>>>> index 25ce72af81c2..ea6dd79a21d3 100644
>>>>>>> --- a/Documentation/networking/xdp-rx-metadata.rst
>>>>>>> +++ b/Documentation/networking/xdp-rx-metadata.rst
>>>>>>> @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
>>>>>>>     metadata is supported, this set will grow:
>>>>>>>     .. kernel-doc:: net/core/xdp.c
>>>>>>> -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
>>>>>>> +   :identifiers: bpf_xdp_metadata_rx_timestamp
>>>>>>> +
>>>>>>> +.. kernel-doc:: net/core/xdp.c
>>>>>>> +   :identifiers: bpf_xdp_metadata_rx_hash
>>>>>>> +
>>>>>>> +.. kernel-doc:: net/core/xdp.c
>>>>>>> +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
>>>>>>>     An XDP program can use these kfuncs to read the metadata into stack
>>>>>>>     variables for its own consumption. Or, to pass the metadata on to other
>>>> [...]
>>>>>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>>>>>> index 41e5ca8643ec..f6262c90e45f 100644
>>>>>>> --- a/net/core/xdp.c
>>>>>>> +++ b/net/core/xdp.c
>>>>>>> @@ -738,6 +738,26 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>>>>>>>     	return -EOPNOTSUPP;
>>>>>>>     }
>>>>>>> +/**
>>>>>>> + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag with protocol
>>>>>>> + * @ctx: XDP context pointer.
>>>>>>> + * @vlan_tag: Destination pointer for VLAN tag
>>>>>>> + * @vlan_proto: Destination pointer for VLAN protocol identifier in network byte order.
>>>>>>> + *
>>>>>>> + * In case of success, vlan_tag contains VLAN tag, including 12 least significant bytes
>>>>>>> + * containing VLAN ID, vlan_proto contains protocol identifier.
>>>>>>
>>>>>> Above is a bit confusing to me at least.
>>>>>>
>>>>>> The vlan tag would be both the 16bit TPID and 16bit TCI. What fields
>>>>>> are to be included here? The VlanID or the full 16bit TCI meaning the
>>>>>> PCP+DEI+VID?
>>>>>
>>>>> It contains PCP+DEI+VID, in patch 16 ("selftests/bpf: Add flags and new hints to
>>>>> xdp_hw_metadata") this is more clear, because the tag is parsed.
>>>>>
>>>>
>>>> Do we really care about the "EtherType" proto (in VLAN speak TPID = Tag
>>>> Protocol IDentifier)?
>>>> I mean, it can basically only have two values[1], and we just wanted to
>>>> know if it is a VLAN (that hardware offloaded/removed for us):
>>>
>>> If we assume everyone follows the standard, this would be correct.
>>> But apparently, some applications use some ambiguous value as a TPID [0].
>>>
>>> So it is not hard to imagine, some NICs could alllow you to configure your
>>> custom TPID. I am not sure if any in-tree drivers actually do this, but I think
>>> it's nice to provide some flexibility on XDP level, especially considering
>>> network stack stores full vlan_proto.
>>>
>>
>> I'm buying your argument, and agree it makes sense to provide TPID in
>> the call signature.  Given weird hardware exists that allow people to
>> configure custom TPID.
>>
>> Looking through kernel defines (in uapi/linux/if_ether.h) I see evidence
>> that funky QinQ EtherTypes have been used in the past:
>>
>>   #define ETH_P_QINQ1	0x9100		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
>> REGISTERED ID ] */
>>   #define ETH_P_QINQ2	0x9200		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
>> REGISTERED ID ] */
>>   #define ETH_P_QINQ3	0x9300		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
>> REGISTERED ID ] */
>>
>>
>>> [0]
>>> https://techhub.hpe.com/eginfolib/networking/docs/switches/7500/5200-1938a_l2-lan_cg/content/495503472.htm
>>>
>>>>
>>>>    static __always_inline int proto_is_vlan(__u16 h_proto)
>>>>    {
>>>> 	return !!(h_proto == bpf_htons(ETH_P_8021Q) ||
>>>> 		  h_proto == bpf_htons(ETH_P_8021AD));
>>>>    }
>>>>
>>>> [1] https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L75-L79
>>>>
>>>> Cc. Andrew Lunn, as I notice DSA have a fake VLAN define ETH_P_DSA_8021Q
>>>> (in file include/uapi/linux/if_ether.h)
>>>> Is this actually in use?
>>>> Maybe some hardware can "VLAN" offload this?
>>>>
>>>>
>>>>> What about rephrasing it this way:
>>>>>
>>>>> In case of success, vlan_proto contains VLAN protocol identifier (TPID),
>>>>> vlan_tag contains the remaining 16 bits of a 802.1Q tag (PCP+DEI+VID).
>>>>>
>>>>
>>>> Hmm, I think we can improve this further. This text becomes part of the
>>>> documentation for end-users (target audience).  Thus, I think it is
>>>> worth being more verbose and even mention the existing defines that we
>>>> are expecting end-users to take advantage of.
>>>>
>>>> What about:
>>>>
>>>> In case of success. The VLAN EtherType is stored in vlan_proto (usually
>>>> either ETH_P_8021Q or ETH_P_8021AD) also known as TPID (Tag Protocol
>>>> IDentifier). The VLAN tag is stored in vlan_tag, which is a 16-bit field
>>>> containing sub-fields (PCP+DEI+VID). The VLAN ID (VID) is 12-bits
>>>> commonly extracted using mask VLAN_VID_MASK (0x0fff).  For the meaning
>>>> of the sub-fields Priority Code Point (PCP) and Drop Eligible Indicator
>>>> (DEI) (formerly CFI) please reference other documentation. Remember
>>>> these 16-bit fields are stored in network-byte. Thus, transformation
>>>> with byte-order helper functions like bpf_ntohs() are needed.
>>>>
>>>
>>> AFAIK, vlan_tag is stored in host byte order, this is how it is in skb.
>>
>> I'm not sure we should follow SKB storage scheme for XDP.
>>
> 
> I think following SKB convention is a good idea in this particular case. As I
> have mentioned below, in ice VLAN TCI in descriptor already comes in LE, so no
> point in converting it into BE, so somebody would use bpf_ntohs() later anyway.
> We are not the only manufacturer that does this.
> 

As long as other NIC hardware does the same this seems okay.


>>> In ice, we receive VLAN tag in descriptor already in LE.
>>> Only protocol is BE (network byte order). So I would replace the last 2
>>> sentences with the following:
>>>
>>> vlan_tag is stored in host byte order, so no byte order conversion is needed.
>>
>> Yikes, that was unexpected.  This needs to be heavily documented in docs.
> 
> You mean the motivation, why it is so and not the other way around?
> 

No, I don't mean the motivation.
I simply mean write it in *bold*.

Look at the description for bpf_xdp_metadata_rx_hash, how it gets
rendered [1] and how the code comments look [2].

  [1] 
https://kernel.org/doc/html/latest/networking/xdp-rx-metadata.html#general-design
  [2] https://elixir.bootlin.com/linux/v6.4/source/net/core/xdp.c#L724

To save you some time compiling htmldocs target:

  make SPHINXDIRS="networking" V=1  htmldocs

>>
>> When parsing packets, it is in network-byte-order, else my code is wrong
>> here[1]:
>>
>>    [1] https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L122
>>
>> I'm accessing the skb->vlan_tci here [2], and I notice I don't do any
>> byte-order conversions, so fortunately I didn't make a code mistake.
>>
>>    [2] https://github.com/xdp-project/bpf-examples/blob/master/traffic-pacing-edt/edt_pacer_vlan.c#L215
>>
> 
> In raw packet, VLAN TCI is in network byte order, but skb requires NIC/driver
> to convert it into host byte order before putting it into skb.
>

I'm interested in if *most* NIC hardware will deliver this in LE
(Little-Endian) which is host-byte order on x86 ?


>>> vlan_proto is stored in network byte order, the suggested way to use this value:
>>>
>>> vlan_proto == bpf_htons(ETH_P_8021Q)
>>>
>>>>
>>>>
>>
>> --Jesper
>>
> 


