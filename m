Return-Path: <bpf+bounces-6194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA2766C36
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 13:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15FF1C218A0
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1532312B7F;
	Fri, 28 Jul 2023 11:56:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49C12B70
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 11:56:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76F421B
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690545368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUj3D03qBfef9Tczj1Cf1fqQ1YGETV0MpO2kGe686CA=;
	b=d3ruc6+bE8ux3JhZv0giZso/lDYbJI+AnIffwdj7+3f1I87tRTic17GDxkQ/wUm7lvJyLU
	0Z+97icJA5WqA1bkDeAqJk1Txgo2c+qmRmLs2gVdO39y420tXRMxdFD+EJWd64dvKY9FWA
	1kt7+kLhsHMfqYV6Bis7S60nzYYPnI0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-BsM6ws9aOX2-VO0P5BdU3Q-1; Fri, 28 Jul 2023 07:56:07 -0400
X-MC-Unique: BsM6ws9aOX2-VO0P5BdU3Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bca0b9234so145554166b.2
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 04:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545366; x=1691150166;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUj3D03qBfef9Tczj1Cf1fqQ1YGETV0MpO2kGe686CA=;
        b=bnTHfYy023yjCu+DWU/RS570on91WOb9RSuj0Mko2cZVH0vDmyAhxzrNAmCUCKYfpm
         1Kju5tqWsFMxGitPG4IqEW4hGsTgdtJjhOTlyqBYhXBBFRXvS1RFBHw9TYAtDjU17dkp
         vtluY9vlEpM9P95YIszu0l5bnFJp51FurAaKPU9qLtLVrCEmW6SfrhLhs1iTVoFT7KLF
         dqjJ3c5mbSDblIqu80kwC8ppe4P8vEDG1SuSHBEK8xClZhO954GVtKIm/fPlsrE/Y5BU
         YonoLyXTbsUNWFFQs4IhCzNMXVPsIGoL9buEOETwKm6eIccHUA6bPRON/lE7RelyseI1
         J6rA==
X-Gm-Message-State: ABy/qLY2NOqX/2kA9XW5ACyTHbwce+0TWK5RNiz14KFv+uy8kU/b1Dzz
	Mmf4YtyfuWVMdLuYrLKKnoEdXEu2lih59kxGvfzrnW+3zuux98vjjdB+3Sjl5JwaNYrWIL5Z6zr
	29JUvG6VXyIPO
X-Received: by 2002:a17:906:20d1:b0:993:fe68:569d with SMTP id c17-20020a17090620d100b00993fe68569dmr1980269ejc.17.1690545366223;
        Fri, 28 Jul 2023 04:56:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHrluxGWSNV6SRMlaOCkYmqguMnSKr1xiZgJoOvoYc766R9fw7lJYa5H6palIkCtFqHR+nvWw==
X-Received: by 2002:a17:906:20d1:b0:993:fe68:569d with SMTP id c17-20020a17090620d100b00993fe68569dmr1980241ejc.17.1690545365849;
        Fri, 28 Jul 2023 04:56:05 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id gl13-20020a170906e0cd00b00982d0563b11sm1954956ejb.197.2023.07.28.04.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:56:05 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <92cd917b-6757-d834-5e5a-7899c5338117@redhat.com>
Date: Fri, 28 Jul 2023 13:56:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com,
 dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-3-sdf@google.com>
 <64c0376cd946a_3fe1bc2947a@willemb.c.googlers.com.notmuch>
In-Reply-To: <64c0376cd946a_3fe1bc2947a@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 25/07/2023 22.58, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
>> This change actually defines the (initial) metadata layout
>> that should be used by AF_XDP userspace (xsk_tx_metadata).
>> The first field is flags which requests appropriate offloads,
>> followed by the offload-specific fields. The supported per-device
>> offloads are exported via netlink (new xsk-flags).
>>
>> The offloads themselves are still implemented in a bit of a
>> framework-y fashion that's left from my initial kfunc attempt.
>> I'm introducing new xsk_tx_metadata_ops which drivers are
>> supposed to implement. The drivers are also supposed
>> to call xsk_tx_metadata_request/xsk_tx_metadata_complete in
>> the right places. Since xsk_tx_metadata_{request,_complete}
>> are static inline, we don't incur any extra overhead doing
>> indirect calls.
>>
>> The benefit of this scheme is as follows:
>> - keeps all metadata layout parsing away from driver code
>> - makes it easy to grep and see which drivers implement what
>> - don't need any extra flags to maintain to keep track of that
>>    offloads are implemented; if the callback is implemented - the offload
>>    is supported (used by netlink reporting code)
>>
>> Two offloads are defined right now:
>> 1. XDP_TX_METADATA_CHECKSUM: skb-style csum_start+csum_offset
>> 2. XDP_TX_METADATA_TIMESTAMP: writes TX timestamp back into metadata
>>     area upon completion (tx_timestamp field)
>>
>> The offloads are also implemented for copy mode:
>> 1. Extra XDP_TX_METADATA_CHECKSUM_SW to trigger skb_checksum_help; this
>>     might be useful as a reference implementation and for testing
>> 2. XDP_TX_METADATA_TIMESTAMP writes SW timestamp from the skb
>>     destructor (note I'm reusing hwtstamps to pass metadata pointer)
>>
>> The struct is forward-compatible and can be extended in the future
>> by appending more fields.
>>
>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> ---
>>   Documentation/netlink/specs/netdev.yaml | 19 ++++++++
>>   include/linux/netdevice.h               | 27 +++++++++++
>>   include/linux/skbuff.h                  |  5 ++-
>>   include/net/xdp_sock.h                  | 60 +++++++++++++++++++++++++
>>   include/net/xdp_sock_drv.h              | 13 ++++++
>>   include/uapi/linux/if_xdp.h             | 35 +++++++++++++++
>>   include/uapi/linux/netdev.h             | 15 +++++++
>>   net/core/netdev-genl.c                  | 12 ++++-
>>   net/xdp/xsk.c                           | 38 ++++++++++++++++
>>   net/xdp/xsk_queue.h                     |  2 +-
>>   tools/include/uapi/linux/if_xdp.h       | 50 ++++++++++++++++++---
>>   11 files changed, 268 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
>> index e41015310a6e..bf9c1cc32614 100644
>> --- a/Documentation/netlink/specs/netdev.yaml
>> +++ b/Documentation/netlink/specs/netdev.yaml
>> @@ -42,6 +42,19 @@ name: netdev
>>           doc:
>>             This feature informs if netdev implements non-linear XDP buffer
>>             support in ndo_xdp_xmit callback.
>> +  -
>> +    type: flags
>> +    name: xsk-flags
>> +    render-max: true
>> +    entries:
>> +      -
>> +        name: tx-timestamp
>> +        doc:
>> +          HW timestamping egress packets is supported by the driver.
>> +      -
>> +        name: tx-checksum
>> +        doc:
>> +          L3 checksum HW offload is supported by the driver.
>>   
>>   attribute-sets:
>>     -
>> @@ -68,6 +81,12 @@ name: netdev
>>           type: u32
>>           checks:
>>             min: 1
>> +      -
>> +        name: xsk-features
>> +        doc: Bitmask of enabled AF_XDP features.
>> +        type: u64
>> +        enum: xsk-flags
>> +        enum-as-flags: true
>>   
>>   operations:
>>     list:
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 11652e464f5d..8b40c80557aa 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -1660,6 +1660,31 @@ struct xdp_metadata_ops {
>>   			       enum xdp_rss_hash_type *rss_type);
>>   };
>>   
>> +/*
>> + * This structure defines the AF_XDP TX metadata hooks for network devices.
>> + * The following hooks can be defined; unless noted otherwise, they are
>> + * optional and can be filled with a null pointer.
>> + *
>> + * int (*tmo_request_timestamp)(void *priv)
>> + *     This function is called when AF_XDP frame requested egress timestamp.
>> + *
>> + * int (*tmo_fill_timestamp)(void *priv)
>> + *     This function is called when AF_XDP frame, that had requested
>> + *     egress timestamp, received a completion. The hook needs to return
>> + *     the actual HW timestamp.
>> + *
>> + * int (*tmo_request_timestamp)(u16 csum_start, u16 csum_offset, void *priv)
> 
> typo: tmo_request_checksum
> 
>> + *     This function is called when AF_XDP frame requested HW checksum
>> + *     offload. csum_start indicates position where checksumming should start.
>> + *     csum_offset indicates position where checksum should be stored.
>> + *
>> + */
>> +struct xsk_tx_metadata_ops {
>> +	void	(*tmo_request_timestamp)(void *priv);
>> +	u64	(*tmo_fill_timestamp)(void *priv);
>> +	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
>> +};
>> +
>>   /**
>>    * enum netdev_priv_flags - &struct net_device priv_flags
>>    *
>> @@ -1844,6 +1869,7 @@ enum netdev_ml_priv_type {
>>    *	@netdev_ops:	Includes several pointers to callbacks,
>>    *			if one wants to override the ndo_*() functions
>>    *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
>> + *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
>>    *	@ethtool_ops:	Management operations
>>    *	@l3mdev_ops:	Layer 3 master device operations
>>    *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
>> @@ -2100,6 +2126,7 @@ struct net_device {
>>   	unsigned long long	priv_flags;
>>   	const struct net_device_ops *netdev_ops;
>>   	const struct xdp_metadata_ops *xdp_metadata_ops;
>> +	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
>>   	int			ifindex;
>>   	unsigned short		gflags;
>>   	unsigned short		hard_header_len;
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index faaba050f843..5febc1a5131e 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -581,7 +581,10 @@ struct skb_shared_info {
>>   	/* Warning: this field is not always filled in (UFO)! */
>>   	unsigned short	gso_segs;
>>   	struct sk_buff	*frag_list;
>> -	struct skb_shared_hwtstamps hwtstamps;
>> +	union {
>> +		struct skb_shared_hwtstamps hwtstamps;
>> +		struct xsk_tx_metadata *xsk_meta;
>> +	};
>>   	unsigned int	gso_type;
>>   	u32		tskey;
>>   
>> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
>> index 467b9fb56827..288fa58c4665 100644
>> --- a/include/net/xdp_sock.h
>> +++ b/include/net/xdp_sock.h
>> @@ -90,6 +90,54 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
>>   int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
>>   void __xsk_map_flush(void);
>>   
>> +/**
>> + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
>> + *  and call appropriate xsk_tx_metadata_ops operation.
>> + *  @meta: pointer to AF_XDP metadata area
>> + *  @ops: pointer to struct xsk_tx_metadata_ops
>> + *  @priv: pointer to driver-private aread
>> + *
>> + *  This function should be called by the networking device when
>> + *  it prepares AF_XDP egress packet.
>> + */
>> +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
>> +					   const struct xsk_tx_metadata_ops *ops,
>> +					   void *priv)
>> +{
>> +	if (!meta)
>> +		return;
>> +
>> +	if (ops->tmo_request_timestamp)
>> +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
>> +			ops->tmo_request_timestamp(priv);
>> +
>> +	if (ops->tmo_request_checksum)
>> +		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
>> +			ops->tmo_request_checksum(meta->csum_start, meta->csum_offset, priv);
>> +}
> 
> Might be cheaper to test the flag in the hot cacheline before
> dereferencing ops?
> 

I was thinking the same thing, but I was wrong, see below, as these ops
deref's are optimized out by the compiler.

> Also, just add these functions to net_device_ops directly,
> rather than dereferencing another pointer to xsk_tx_metadata_ops?
> 

After the ASM/objdump discussion[1] in this thread, I think Stanislav's
code approach here is actually optimal. Because when the 'const' ops are
defined locally in the same file that use/does the inlining of
xsk_tx_metadata_request() then the compilers (both llvm and gcc) are
smart enough to inline and do dead-code elimination.  E.g. I noticed
that generated ASM code eliminated `if (ops->tmo_request_timestamp)`
code path in mlx5 as its not implemented.

  [1] 
https://lore.kernel.org/all/cce9db50-8c9d-ea97-cb88-171fa46cc064@redhat.com/

--Jesper


