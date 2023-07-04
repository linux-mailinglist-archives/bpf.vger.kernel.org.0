Return-Path: <bpf+bounces-3961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B7746E80
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8C71C203DA
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490EE5680;
	Tue,  4 Jul 2023 10:23:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198175670
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 10:23:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB313D
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688466231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efMYYmzKcoxHmtIWpxVuDkCtLQ7YQKGr9WO/LVN59l8=;
	b=E/S1NCZ3mfBEj6z5GDJ0DoLV5Lz/N/8mSc+5KhYJjzvYOPr3dW/GYNW1qsR+ejTABy8Czv
	R28Ub+ninkrt8gjNPTw9FjNoRdLHzdtiwN+x3WxPpDUKiiazueL6bsMkXg8S6bDXSUhpZj
	SkRKfzFfG/s16qw4eyHHPe7wGnTd1pE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-3dnXv-tYMT-Rk9hQThVWrQ-1; Tue, 04 Jul 2023 06:23:50 -0400
X-MC-Unique: 3dnXv-tYMT-Rk9hQThVWrQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb76659d37so5077223e87.2
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 03:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688466228; x=1691058228;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efMYYmzKcoxHmtIWpxVuDkCtLQ7YQKGr9WO/LVN59l8=;
        b=TwuvHmnTsjK7AFAVYnyJ6ZtZliwWl4N2b1RFCCT1TOxD9P4Buw5H1sC8ZKDId5rLUx
         FcIAoXTbqxBWQGi+p8Q4BbI8kPYHkGPV+v8j8N+dCIBprLRKOH0l99APIoV7R7w3VINx
         Kw8kYRSS9bs4lW/j/vRKSqxSMBqvM3caiDhginOz9ijklBc+7OWccFdWym9tVAe+DO0c
         HgGG7t9E17jfBJCjirLCX+biex0znOUTL/h5nmL+c4GC4qhq3wo+OzK/7ET15/8K1HbM
         MovuUFHBtpJ0onMWnNB98BgXC/zVo5EbdU1BnrVoXlG6Zz3GHmBs284gQUjNnK3yZXjm
         IzLg==
X-Gm-Message-State: ABy/qLbdnIDbl7tjfeMFV0SnHYxap1gBRKRZVIR9aKoZrivo523CsfBm
	n37GtNajGPrGVaXC7GEeBO2XW9e+G0uem7zYRPx3NiKBs4Ev+IGNc7i5G/ayuas4BDQLY4gvuZ/
	6YDWhuGTjJXx+
X-Received: by 2002:a19:6d1c:0:b0:4f8:71bf:a25b with SMTP id i28-20020a196d1c000000b004f871bfa25bmr7822373lfc.9.1688466228713;
        Tue, 04 Jul 2023 03:23:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEe58T5Jt5/8xyxSsobmohA9Yv/PKPg7Rs8j5M5JhfU7oZKnDuXDiRkvSFgXLDFi43xiXB5BQ==
X-Received: by 2002:a19:6d1c:0:b0:4f8:71bf:a25b with SMTP id i28-20020a196d1c000000b004f871bfa25bmr7822350lfc.9.1688466228357;
        Tue, 04 Jul 2023 03:23:48 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fa968e9c27sm24855898wmo.9.2023.07.04.03.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 03:23:47 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <f7aa7eb6-4600-cebf-bd09-d05fc627fd0d@redhat.com>
Date: Tue, 4 Jul 2023 12:23:45 +0200
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
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH bpf-next v2 09/20] xdp: Add VLAN tag hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>,
 John Fastabend <john.fastabend@gmail.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-10-larysa.zaremba@intel.com>
 <64a32c661648e_628d32085f@john.notmuch> <ZKPW6azl0Ak27wSO@lincoln>
In-Reply-To: <ZKPW6azl0Ak27wSO@lincoln>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 04/07/2023 10.23, Larysa Zaremba wrote:
> On Mon, Jul 03, 2023 at 01:15:34PM -0700, John Fastabend wrote:
>> Larysa Zaremba wrote:
>>> Implement functionality that enables drivers to expose VLAN tag
>>> to XDP code.
>>>
>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>> ---
>>>   Documentation/networking/xdp-rx-metadata.rst |  8 +++++++-
>>>   include/linux/netdevice.h                    |  2 ++
>>>   include/net/xdp.h                            |  2 ++
>>>   kernel/bpf/offload.c                         |  2 ++
>>>   net/core/xdp.c                               | 20 ++++++++++++++++++++
>>>   5 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
>>> index 25ce72af81c2..ea6dd79a21d3 100644
>>> --- a/Documentation/networking/xdp-rx-metadata.rst
>>> +++ b/Documentation/networking/xdp-rx-metadata.rst
>>> @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
>>>   metadata is supported, this set will grow:
>>>   
>>>   .. kernel-doc:: net/core/xdp.c
>>> -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
>>> +   :identifiers: bpf_xdp_metadata_rx_timestamp
>>> +
>>> +.. kernel-doc:: net/core/xdp.c
>>> +   :identifiers: bpf_xdp_metadata_rx_hash
>>> +
>>> +.. kernel-doc:: net/core/xdp.c
>>> +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
>>>   
>>>   An XDP program can use these kfuncs to read the metadata into stack
>>>   variables for its own consumption. Or, to pass the metadata on to other
[...]
>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>> index 41e5ca8643ec..f6262c90e45f 100644
>>> --- a/net/core/xdp.c
>>> +++ b/net/core/xdp.c
>>> @@ -738,6 +738,26 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>>>   	return -EOPNOTSUPP;
>>>   }
>>>   
>>> +/**
>>> + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag with protocol
>>> + * @ctx: XDP context pointer.
>>> + * @vlan_tag: Destination pointer for VLAN tag
>>> + * @vlan_proto: Destination pointer for VLAN protocol identifier in network byte order.
>>> + *
>>> + * In case of success, vlan_tag contains VLAN tag, including 12 least significant bytes
>>> + * containing VLAN ID, vlan_proto contains protocol identifier.
>>
>> Above is a bit confusing to me at least.
>>
>> The vlan tag would be both the 16bit TPID and 16bit TCI. What fields
>> are to be included here? The VlanID or the full 16bit TCI meaning the
>> PCP+DEI+VID?
> 
> It contains PCP+DEI+VID, in patch 16 ("selftests/bpf: Add flags and new hints to
> xdp_hw_metadata") this is more clear, because the tag is parsed.
> 

Do we really care about the "EtherType" proto (in VLAN speak TPID = Tag
Protocol IDentifier)?
I mean, it can basically only have two values[1], and we just wanted to
know if it is a VLAN (that hardware offloaded/removed for us):

  static __always_inline int proto_is_vlan(__u16 h_proto)
  {
	return !!(h_proto == bpf_htons(ETH_P_8021Q) ||
		  h_proto == bpf_htons(ETH_P_8021AD));
  }

[1] 
https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L75-L79

Cc. Andrew Lunn, as I notice DSA have a fake VLAN define ETH_P_DSA_8021Q
(in file include/uapi/linux/if_ether.h)
Is this actually in use?
Maybe some hardware can "VLAN" offload this?


> What about rephrasing it this way:
> 
> In case of success, vlan_proto contains VLAN protocol identifier (TPID),
> vlan_tag contains the remaining 16 bits of a 802.1Q tag (PCP+DEI+VID).
> 

Hmm, I think we can improve this further. This text becomes part of the
documentation for end-users (target audience).  Thus, I think it is
worth being more verbose and even mention the existing defines that we
are expecting end-users to take advantage of.

What about:

In case of success. The VLAN EtherType is stored in vlan_proto (usually
either ETH_P_8021Q or ETH_P_8021AD) also known as TPID (Tag Protocol
IDentifier). The VLAN tag is stored in vlan_tag, which is a 16-bit field
containing sub-fields (PCP+DEI+VID). The VLAN ID (VID) is 12-bits
commonly extracted using mask VLAN_VID_MASK (0x0fff).  For the meaning
of the sub-fields Priority Code Point (PCP) and Drop Eligible Indicator
(DEI) (formerly CFI) please reference other documentation. Remember
these 16-bit fields are stored in network-byte. Thus, transformation
with byte-order helper functions like bpf_ntohs() are needed.



>> I think by "including 12 least significant bytes" you
>> mean bits,
> 
> Yes, my bad.
> 
>> but also not clear about those 4 other bits.
>>
>> I can likely figure it out in next patches from implementation but
>> would be nice to clean up docs.
>>
>>> + *
>>> + * Return:
>>> + * * Returns 0 on success or ``-errno`` on error.
>>> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
>>> + * * ``-ENODATA``    : VLAN tag was not stripped or is not available
>>> + */
>>> +__bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
>>> +					     __be16 *vlan_proto)
>>> +{
>>> +	return -EOPNOTSUPP;
>>> +}
>>> +


