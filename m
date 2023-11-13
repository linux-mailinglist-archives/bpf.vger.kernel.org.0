Return-Path: <bpf+bounces-14994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0007E9CE7
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 14:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3001C20963
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E61F947;
	Mon, 13 Nov 2023 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du/ch0FD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE881D6A4;
	Mon, 13 Nov 2023 13:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1556C433C8;
	Mon, 13 Nov 2023 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699881417;
	bh=x6T88uvFtsLiSLkHay51/pUOvdwJS3qiqD8AtZCpLNY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=du/ch0FDLjSN2cVb/4kP7sSPE3WSKZVJi1bbcXXeWaZaQzRXnJL4ndCi19+dz6cbP
	 5+Z8L3TdTHw1jNwbhZYaotNBuAlT4j8rLszF3GbR029wjnXh6C3LCZo4EME/GQVvsl
	 mZ2NG4eS0E6r3EfHEWCwZwcDMwjMyBYqVd/w3kW3pqBjkF0YFniqEzQKrZwc1WISo6
	 Md6cnSyfr+mnw8n+7obIQC2JcnKc7wJKsbqLmZHkoiYJdascUCKMMfqhoyjCKeo0yt
	 Kps5mAcnd4FiUiQoksWlBLv3yzEk8bgh9GE5uOy04ChF0vl50BI7/qvMB1Fsg4EQcQ
	 Fn/UhwDH/WtzA==
Message-ID: <c9bfe356-1942-4e49-b025-115faeec39dd@kernel.org>
Date: Mon, 13 Nov 2023 14:16:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hawk@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
 toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 yoong.siang.song@intel.com, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v5 02/13] xsk: Add TX timestamp and TX checksum
 offload support
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20231102225837.1141915-1-sdf@google.com>
 <20231102225837.1141915-3-sdf@google.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231102225837.1141915-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/2/23 23:58, Stanislav Fomichev wrote:
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 2ecf79282c26..b0ee7ad19b51 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -106,6 +106,41 @@ struct xdp_options {
>   #define XSK_UNALIGNED_BUF_ADDR_MASK \
>   	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
>   
> +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
> + * field of struct xsk_tx_metadata.
> + */
> +#define XDP_TXMD_FLAGS_TIMESTAMP		(1 << 0)
> +
> +/* Request transmit checksum offload. Checksum start position and offset
> + * are communicated via csum_start and csum_offset fields of struct
> + * xsk_tx_metadata.
> + */
> +#define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
> +
> +/* AF_XDP offloads request. 'request' union member is consumed by the driver
> + * when the packet is being transmitted. 'completion' union member is
> + * filled by the driver when the transmit completion arrives.
> + */
> +struct xsk_tx_metadata {
> +	union {
> +		struct {
> +			__u32 flags;
> +
> +			/* XDP_TXMD_FLAGS_CHECKSUM */
> +
> +			/* Offset from desc->addr where checksumming should start. */
> +			__u16 csum_start;
> +			/* Offset from csum_start where checksum should be stored. */
> +			__u16 csum_offset;
> +		} request;
> +
> +		struct {
> +			/* XDP_TXMD_FLAGS_TIMESTAMP */
> +			__u64 tx_timestamp;
> +		} completion;
> +	};
> +};

This looks wrong to me. It looks like member @flags is not avail at
completion time.  At completion time, I assume we also want to know if
someone requested to get the timestamp for this packet (else we could
read garbage).

Another thing (I've raised this before): It would be really practical to
store an u64 opaque value at TX and then read it at Completion time.
One use-case is a forwarding application storing HW RX-time and
comparing this to TX completion time to deduce the time spend processing
the packet.

--Jesper

