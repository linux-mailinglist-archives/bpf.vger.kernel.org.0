Return-Path: <bpf+bounces-12884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF37D1A2C
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE315B2161A
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F67EE;
	Sat, 21 Oct 2023 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjV0ID+J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058FE641;
	Sat, 21 Oct 2023 01:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B1AC433C8;
	Sat, 21 Oct 2023 01:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697850253;
	bh=TztBAVeNWfN2qZHh7HR9xEyQGkggIVGD+m3B8zr7oLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mjV0ID+JHdrbz33LML3oY5PPqlSwi6pCm3RIIHP9UMf74ODBPmOjEfL2uYvrvObde
	 l+xVgas6mf0NM2fOqcCbxRVCc85HSLDHegtXKgu35ejUdjQnzH2/axw62KLtC4AkT1
	 8zQ+UNfDE+jWQvvyCmorunx0aRK8fvmL0woIUPyBMgCf6xqGN+YuXdMWjrr6XnOn88
	 cdtuWF0qrsq8wKT1Scq613Z4g6LGbs1cK4JQYn/C5/UT1N0YeR/XNxcAbw8N9Nm6hh
	 djvLuHA58rCW8ZCRqe6srTL9q8JJ1nAtw4gBiJuWAfwmo0eNL/z8zNLZhYDo7HBs/B
	 DQVLc5MLjfg9w==
Date: Fri, 20 Oct 2023 18:04:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v4 02/11] xsk: Add TX timestamp and TX checksum
 offload support
Message-ID: <20231020180411.2a9f573d@kernel.org>
In-Reply-To: <20231019174944.3376335-3-sdf@google.com>
References: <20231019174944.3376335-1-sdf@google.com>
	<20231019174944.3376335-3-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 10:49:35 -0700 Stanislav Fomichev wrote:
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 14511b13f305..22d2649a34ee 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -55,6 +55,19 @@ name: netdev
>          name: hash
>          doc:
>            Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
> +  -
> +    type: flags
> +    name: xsk-flags
> +    render-max: true

I don't think you're using the MAX, maybe don't render it.
IDK what purpose it'd serve for feature flag enums.

> +/*
> + * This structure defines the AF_XDP TX metadata hooks for network devices.

s/This structure defines the //

> + * The following hooks can be defined; unless noted otherwise, they are
> + * optional and can be filled with a null pointer.
> + *
> + * void (*tmo_request_timestamp)(void *priv)
> + *     This function is called when AF_XDP frame requested egress timestamp.

s/This function is // in many places

> + * u64 (*tmo_fill_timestamp)(void *priv)
> + *     This function is called when AF_XDP frame, that had requested
> + *     egress timestamp, received a completion. The hook needs to return
> + *     the actual HW timestamp.
> + *
> + * void (*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv)
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

Could you move the definition of the struct to include/net/xdp_sock.h ?
netdevice.h doesn't need it.

> +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
> + * field of struct xsk_tx_metadata.
> + */
> +#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
> +
> +/* Request transmit checksum offload. Checksum start position and offset
> + * are communicated via csum_start and csum_offset fields of struct
> + * xsk_tx_metadata.
> + */
> +#define XDP_TX_METADATA_CHECKSUM		(1 << 1)

Reuse of enum netdev_xsk_flags is not an option?

> +/* Force checksum calculation in software. Can be used for testing or
> + * working around potential HW issues. This option causes performance
> + * degradation and only works in XDP_COPY mode.
> + */
> +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)

Is there a need for this to be on packet-by-packet basis?
HW issues should generally be fixed by the driver, is there 
any type of problem in particular you have in mind here?

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index fe61f85bcf33..5d889c2425fd 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -14,6 +14,7 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
>  		   const struct genl_info *info)
>  {
>  	u64 xdp_rx_meta = 0;
> +	u64 xsk_features = 0;

rev xmas tree? :)

> +			meta = buffer - xs->pool->tx_metadata_len;
> +
> +			if (meta->flags & XDP_TX_METADATA_CHECKSUM) {

Do we need to worry about reserved / unsupported meta->flags ?

> +				if (unlikely(meta->csum_start + meta->csum_offset +
> +					     sizeof(__sum16) > len)) {
> +					err = -EINVAL;
> +					goto free_err;
> +				}


