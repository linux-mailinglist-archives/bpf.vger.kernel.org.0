Return-Path: <bpf+bounces-6078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C63765554
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 15:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE732823B5
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870231772C;
	Thu, 27 Jul 2023 13:50:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB93174FC
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 13:50:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4AA2D68
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690465828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XiOfTE6mIe+no+efCzQfb1o2160qXLz3EBiZhKoPf8=;
	b=P8czg3dp6yrl1W3zXcIUK6neY18R83yW7igZkJQjTwvHN9lp0J3hAhx9NuCirWbmM86iFh
	IUmfpqBCRG/wK8bYb0RsObIwASAf3fdehNiCOkI8vQEvc8UYgHur5MU9pMqWD0pJU07ZDV
	jb2/za8ca0EtYNESQgTOFYVdvYrWe0o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-PQVx12ozMruQpE04FQGO-g-1; Thu, 27 Jul 2023 09:50:27 -0400
X-MC-Unique: PQVx12ozMruQpE04FQGO-g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-994320959f4so55977866b.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690465826; x=1691070626;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XiOfTE6mIe+no+efCzQfb1o2160qXLz3EBiZhKoPf8=;
        b=grMJWrIyD1Dsn8cd9kx6WvgeZZJxFoH9luOBsP516STZ6X8cd51ul0lyhImykAyu/a
         NxbFhw0YfBDKAjCyzdXgaWGWfotjO0Hq4hqJYGfBFcaHFgb1VWsOs1Qyts3B2KBcxhFU
         00DJMPVJYTtHOe4ZodDQnOWpYIkzwohN11huSJp+7hitYGMRaQcJXJKfW6sVFkDWts3d
         o7kRNWu6EpMMhmrCm6ryW7nogHnCF55lvN7TB6N63hBziQwrkIERMYGJkNZRV3Q3dwj8
         f/A1I/2dv4MT/XZVn+4MrRkySWLLBsE8d1dhP7ZDbCNSb/De8vIvCRFoDH2Jcpm55DZ4
         rtqw==
X-Gm-Message-State: ABy/qLYlMKlqUuH1Buxj5fEmiS7kmM8IiG9SVJNWkzNsOzVumqhcUfRc
	gTQlHp8UyLp5Elh3wO9KfxyrRINGzc+vXopO7YigDtkpuMehknSpb7Rm+A09ccaMJHX0OldLvld
	F8CyV3OjFX2VV
X-Received: by 2002:a17:906:845c:b0:994:4f10:fb39 with SMTP id e28-20020a170906845c00b009944f10fb39mr1964641ejy.16.1690465826178;
        Thu, 27 Jul 2023 06:50:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZM8PwoZjcMnC01i1MxwpCysmdHzYnZsReHy2hiY8stkm7Z/mE2+w3vCR/tyszu1A41BPdQg==
X-Received: by 2002:a17:906:845c:b0:994:4f10:fb39 with SMTP id e28-20020a170906845c00b009944f10fb39mr1964610ejy.16.1690465825835;
        Thu, 27 Jul 2023 06:50:25 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id gq15-20020a170906e24f00b00992b510089asm800108ejb.84.2023.07.27.06.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 06:50:25 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <cce9db50-8c9d-ea97-cb88-171fa46cc064@redhat.com>
Date: Thu, 27 Jul 2023 15:50:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org,
 willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org,
 netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] [RFC net-next v4 2/8] xsk: add TX timestamp and TX
 checksum offload support
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-3-sdf@google.com>
 <383cc1ce-3c87-4b80-9e70-e0c10a7c1dcc@redhat.com>
 <ZMGPMIpeBsfs4/8L@google.com>
In-Reply-To: <ZMGPMIpeBsfs4/8L@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 26/07/2023 23.25, Stanislav Fomichev wrote:
> On 07/26, Jesper Dangaard Brouer wrote:
>>
>>
>> On 25/07/2023 01.59, Stanislav Fomichev wrote:
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 11652e464f5d..8b40c80557aa 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -1660,6 +1660,31 @@ struct xdp_metadata_ops {
>>>    			       enum xdp_rss_hash_type *rss_type);
>>>    };
>>> +/*
>>> + * This structure defines the AF_XDP TX metadata hooks for network devices.
>>> + * The following hooks can be defined; unless noted otherwise, they are
>>> + * optional and can be filled with a null pointer.
>>> + *
>>> + * int (*tmo_request_timestamp)(void *priv)
>>> + *     This function is called when AF_XDP frame requested egress timestamp.
>>> + *
>>> + * int (*tmo_fill_timestamp)(void *priv)
>>> + *     This function is called when AF_XDP frame, that had requested
>>> + *     egress timestamp, received a completion. The hook needs to return
>>> + *     the actual HW timestamp.
>>> + *
>>> + * int (*tmo_request_timestamp)(u16 csum_start, u16 csum_offset, void *priv)
>>> + *     This function is called when AF_XDP frame requested HW checksum
>>> + *     offload. csum_start indicates position where checksumming should start.
>>> + *     csum_offset indicates position where checksum should be stored.
>>> + *
>>> + */
>>> +struct xsk_tx_metadata_ops {
>>> +	void	(*tmo_request_timestamp)(void *priv);
>>> +	u64	(*tmo_fill_timestamp)(void *priv);
>>> +	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
>>> +};
>>> +
>>>    /**
>>>     * enum netdev_priv_flags - &struct net_device priv_flags
>>>     *
>>> @@ -1844,6 +1869,7 @@ enum netdev_ml_priv_type {
>>>     *	@netdev_ops:	Includes several pointers to callbacks,
>>>     *			if one wants to override the ndo_*() functions
>>>     *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
>>> + *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
>>>     *	@ethtool_ops:	Management operations
>>>     *	@l3mdev_ops:	Layer 3 master device operations
>>>     *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
>>> @@ -2100,6 +2126,7 @@ struct net_device {
>>>    	unsigned long long	priv_flags;
>>>    	const struct net_device_ops *netdev_ops;
>>>    	const struct xdp_metadata_ops *xdp_metadata_ops;
>>> +	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
>>>    	int			ifindex;
>>>    	unsigned short		gflags;
>>>    	unsigned short		hard_header_len;
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index faaba050f843..5febc1a5131e 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -581,7 +581,10 @@ struct skb_shared_info {
>>>    	/* Warning: this field is not always filled in (UFO)! */
>>>    	unsigned short	gso_segs;
>>>    	struct sk_buff	*frag_list;
>>> -	struct skb_shared_hwtstamps hwtstamps;
>>> +	union {
>>> +		struct skb_shared_hwtstamps hwtstamps;
>>> +		struct xsk_tx_metadata *xsk_meta;
>>> +	};
>>>    	unsigned int	gso_type;
>>>    	u32		tskey;
>>> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
>>> index 467b9fb56827..288fa58c4665 100644
>>> --- a/include/net/xdp_sock.h
>>> +++ b/include/net/xdp_sock.h
>>> @@ -90,6 +90,54 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
>>>    int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
>>>    void __xsk_map_flush(void);
>>> +/**
>>> + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
>>> + *  and call appropriate xsk_tx_metadata_ops operation.
>>> + *  @meta: pointer to AF_XDP metadata area
>>> + *  @ops: pointer to struct xsk_tx_metadata_ops
>>> + *  @priv: pointer to driver-private aread
>>> + *
>>> + *  This function should be called by the networking device when
>>> + *  it prepares AF_XDP egress packet.
>>> + */
>>> +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
>>> +					   const struct xsk_tx_metadata_ops *ops,
>>> +					   void *priv)
>>
>> (As you mentioned) this gets inlined in drivers for performance.
>>
>>> +{
>>> +	if (!meta)
>>> +		return;
>>> +
>>> +	if (ops->tmo_request_timestamp)
>>> +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
>>> +			ops->tmo_request_timestamp(priv);
>>
>> We still have the overhead of function pointer call.
>> With RETPOLINE this is costly.
>>
>> Measured on my testlab CPU E5-1650 v4 @ 3.60GHz
>>   Type:function_call_cost:  3 cycles(tsc) 1.010 ns
>>   Type:func_ptr_call_cost: 30 cycles(tsc) 8.341 ns
>>
>> Given this get inlined in drivers, perhaps we can add some
>> INDIRECT_CALL_1 macros to avoid these indirect calls?
> 
> I'm assuming that the compiler is smart enough to resolve these const
> struct ops definitions as long as they are in the same file.
> 
> At least here is what I see for mlx5e_xmit_xdp_frame_mpwqe: those
> indirect jumps are resolved and the calls themselves are unrolled.
> TBF, I don't have retpolines enabled in the config, but I don't think
> it will bring indirect jumps back? Am I missing anything?
> 

I tried this with CONFIG_RETPOLINE and same results.
The compiler is smart and inlines the call to mlx5e_xsk_request_checksum().
This is great, no need for crazy INDIRECT_CALL_1 macros :-)

> 
> 0000000000001930 <mlx5e_xmit_xdp_frame_mpwqe>:
> ; mlx5e_xmit_xdp_frame_mpwqe():
> ; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:436
[...]
> ; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:381
> ; 	stats->mpwqe++;
>      1b4a: 49 ff 44 24 08               	incq	0x8(%r12)
> ; ././include/net/xdp_sock.h:107

How do you get objdump to add these file:line annotations?

I use:
  objdump -rS --visualize-jumps=color -Mintel | less -R

> ; 	if (!meta)
>      1b4f: 4d 85 ff                     	testq	%r15, %r15
>      1b52: 74 0e                        	je	0x1b62 <mlx5e_xmit_xdp_frame_mpwqe+0x232>
> ; ././include/net/xdp_sock.h:115
> ; 		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
>      1b54: 41 f6 07 02                  	testb	$0x2, (%r15)
>      1b58: 74 08                        	je	0x1b62 <mlx5e_xmit_xdp_frame_mpwqe+0x232>
> ; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:483
> ; 		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, &session->wqe->eth);
>      1b5a: 48 8b 43 50                  	movq	0x50(%rbx), %rax
> ; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:286
> ; 	eseg->cs_flags |= MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4_CSUM;
>      1b5e: 80 48 14 c0                  	orb	$-0x40, 0x14(%rax)

Yes, here mlx5e_xsk_request_checksum() gets inlined, as
  MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4_CSUM = 192
  192 = 0xC0 and signed byte value $-0x40, which we see in inst 'orb'.

I usually prefer Intel ASM code output via objdump -Mintel
and it decode ASM with unsigned value 0xc0 / 192:

  or     BYTE PTR ds:0x4,0xc0


> ; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:203
> ; 		(struct mlx5_wqe_data_seg *)session->wqe + session->ds_count;
>      1b62: 48 8b 43 50                  	movq	0x50(%rbx), %rax
[...]

Thank you for checking up on this! :-)

--Jesper


