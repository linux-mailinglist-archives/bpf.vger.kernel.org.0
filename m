Return-Path: <bpf+bounces-5996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24395763F7B
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4596B1C21217
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4FB4CE9E;
	Wed, 26 Jul 2023 19:25:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE44CE7A
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 19:25:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53F2727
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690399506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHY6puW3nOI/U4qtJv8yKQr5CJoUzjywbPXurWGe+CU=;
	b=Zvhu9Rxp9xDUCtP6skp/CC1m+qHhu+ypMEHXiEgJSK2V0InEO7RUPwAw72jQiqj1F5cs+D
	yue54Klb1Txy/AslqRsCwOCek8lSDiEBo3ywL4M2HYHjgJGJy5UDWjiNsMof0YcSbMGZYQ
	EP/lmMglS0nDxaLkfH8oG81TvSG+D8Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-5YihXbkyOHiAqOTMkEz4Bg-1; Wed, 26 Jul 2023 15:25:05 -0400
X-MC-Unique: 5YihXbkyOHiAqOTMkEz4Bg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb3f3a87d4so716903e87.1
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 12:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399504; x=1691004304;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHY6puW3nOI/U4qtJv8yKQr5CJoUzjywbPXurWGe+CU=;
        b=VBrM3jmJewG08qX5ZoHBxQmagBfpWP25f6ra6Rku12RCuLA93w5dkLMoUY3ogS4G6d
         oe+zSOzcHghv+zmR2nN6UZx540Neu1cSPxzwfSWr2d7+MSqJpgbjLlfwxEkRNnqhcXJF
         7slpi2pwi5qVQKEy+RQ3pnw7Q5X9iRWrQkuJwdR/aGmtIPwzhWZu0r1c6BYPD7YWLKQ4
         c8tAazRkF8udLCw8882JG0VHfTn7iJ9QSmwDlPxwsjyX05wiOwxydcbzsN+290zdgSo5
         JfiQgtJbHv793RPx1jyRfEB0cLRidmb4fke1C1u4XevwgGCOzroqAnJ0H9YEi6vDadOU
         KJ+A==
X-Gm-Message-State: ABy/qLaKQAsxOh3OX2vKqGnaHSi4AA/2SpdhLlTJ7q4XtG//7ZtMPcWW
	evA+snbKUYhA9o4C1grCUtEOFVfnxXEiebsMy3EQrRFkcx7JgNMyDTjZAs2zoLJPJ/mKEd5xI1+
	lm6oh9PLrnQa9
X-Received: by 2002:a05:6512:3b87:b0:4f8:6ac4:1aa9 with SMTP id g7-20020a0565123b8700b004f86ac41aa9mr2411lfv.21.1690399503953;
        Wed, 26 Jul 2023 12:25:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjiKCpkX+P4Z3nt2t+ufZnzpxiL4Gj0TH3p3OJqMF5PL8k5Iv6RKEIjFlz16Dmr71XroFz7A==
X-Received: by 2002:a05:6512:3b87:b0:4f8:6ac4:1aa9 with SMTP id g7-20020a0565123b8700b004f86ac41aa9mr2388lfv.21.1690399503524;
        Wed, 26 Jul 2023 12:25:03 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id m26-20020a056512015a00b004fb745fd22fsm3428341lfo.32.2023.07.26.12.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 12:25:02 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <383cc1ce-3c87-4b80-9e70-e0c10a7c1dcc@redhat.com>
Date: Wed, 26 Jul 2023 21:25:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com,
 dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] [RFC net-next v4 2/8] xsk: add TX timestamp and TX
 checksum offload support
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-3-sdf@google.com>
In-Reply-To: <20230724235957.1953861-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 25/07/2023 01.59, Stanislav Fomichev wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 11652e464f5d..8b40c80557aa 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1660,6 +1660,31 @@ struct xdp_metadata_ops {
>   			       enum xdp_rss_hash_type *rss_type);
>   };
>   
> +/*
> + * This structure defines the AF_XDP TX metadata hooks for network devices.
> + * The following hooks can be defined; unless noted otherwise, they are
> + * optional and can be filled with a null pointer.
> + *
> + * int (*tmo_request_timestamp)(void *priv)
> + *     This function is called when AF_XDP frame requested egress timestamp.
> + *
> + * int (*tmo_fill_timestamp)(void *priv)
> + *     This function is called when AF_XDP frame, that had requested
> + *     egress timestamp, received a completion. The hook needs to return
> + *     the actual HW timestamp.
> + *
> + * int (*tmo_request_timestamp)(u16 csum_start, u16 csum_offset, void *priv)
> + *     This function is called when AF_XDP frame requested HW checksum
> + *     offload. csum_start indicates position where checksumming should start.
> + *     csum_offset indicates position where checksum should be stored.
> + *
> + */
> +struct xsk_tx_metadata_ops {
> +	void	(*tmo_request_timestamp)(void *priv);
> +	u64	(*tmo_fill_timestamp)(void *priv);
> +	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
> +};
> +
>   /**
>    * enum netdev_priv_flags - &struct net_device priv_flags
>    *
> @@ -1844,6 +1869,7 @@ enum netdev_ml_priv_type {
>    *	@netdev_ops:	Includes several pointers to callbacks,
>    *			if one wants to override the ndo_*() functions
>    *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
> + *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
>    *	@ethtool_ops:	Management operations
>    *	@l3mdev_ops:	Layer 3 master device operations
>    *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
> @@ -2100,6 +2126,7 @@ struct net_device {
>   	unsigned long long	priv_flags;
>   	const struct net_device_ops *netdev_ops;
>   	const struct xdp_metadata_ops *xdp_metadata_ops;
> +	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
>   	int			ifindex;
>   	unsigned short		gflags;
>   	unsigned short		hard_header_len;
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index faaba050f843..5febc1a5131e 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -581,7 +581,10 @@ struct skb_shared_info {
>   	/* Warning: this field is not always filled in (UFO)! */
>   	unsigned short	gso_segs;
>   	struct sk_buff	*frag_list;
> -	struct skb_shared_hwtstamps hwtstamps;
> +	union {
> +		struct skb_shared_hwtstamps hwtstamps;
> +		struct xsk_tx_metadata *xsk_meta;
> +	};
>   	unsigned int	gso_type;
>   	u32		tskey;
>   
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 467b9fb56827..288fa58c4665 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -90,6 +90,54 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
>   int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
>   void __xsk_map_flush(void);
>   
> +/**
> + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> + *  and call appropriate xsk_tx_metadata_ops operation.
> + *  @meta: pointer to AF_XDP metadata area
> + *  @ops: pointer to struct xsk_tx_metadata_ops
> + *  @priv: pointer to driver-private aread
> + *
> + *  This function should be called by the networking device when
> + *  it prepares AF_XDP egress packet.
> + */
> +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
> +					   const struct xsk_tx_metadata_ops *ops,
> +					   void *priv)

(As you mentioned) this gets inlined in drivers for performance.

> +{
> +	if (!meta)
> +		return;
> +
> +	if (ops->tmo_request_timestamp)
> +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> +			ops->tmo_request_timestamp(priv);

We still have the overhead of function pointer call.
With RETPOLINE this is costly.

Measured on my testlab CPU E5-1650 v4 @ 3.60GHz
  Type:function_call_cost:  3 cycles(tsc) 1.010 ns
  Type:func_ptr_call_cost: 30 cycles(tsc) 8.341 ns

Given this get inlined in drivers, perhaps we can add some
INDIRECT_CALL_1 macros to avoid these indirect calls?

> +
> +	if (ops->tmo_request_checksum)
> +		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
> +			ops->tmo_request_checksum(meta->csum_start, meta->csum_offset, priv);
> +}
> +


