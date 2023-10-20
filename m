Return-Path: <bpf+bounces-12854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05087D1526
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F274B21594
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B5B208AA;
	Fri, 20 Oct 2023 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpjATt11"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C51DA22;
	Fri, 20 Oct 2023 17:49:46 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E36D67;
	Fri, 20 Oct 2023 10:49:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ca215cc713so8229115ad.3;
        Fri, 20 Oct 2023 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697824185; x=1698428985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5RsvVPeK0HG7sfE95t4B3GsOpnKWLyM2VBqKfrYhJQ=;
        b=IpjATt11bOObIE1H7VHclnrtkf8ZPO8Bebk8QNdUIz1FjQG96FHdpM2gY25raD9lWk
         JGfqUPCiNMCUMc/sAb59kd029UxaC7A9N6vAMKGQBpqDoLrS4wCMZrtQr2ep9wV1UqGv
         BI38JxoGhz5bPR9TBELvOuRB83FkNjt3B7D+lVkMfRcTSz3trlvkO8f++EE5CGO2Q0WZ
         Px6VvZsGMjChuQQQAk/M24F33sHpD4fHsoB4XW5+8Gq4ikNHGokUGHBWc4UHj4H4Y5vi
         HhgLb8skHN644K3QxO5NgZlqShyN9JvFrAGr7BxdyiSxNpwjF8SzSayRiRp97uDH+Qw+
         YVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824185; x=1698428985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5RsvVPeK0HG7sfE95t4B3GsOpnKWLyM2VBqKfrYhJQ=;
        b=Djw4FiqNnE65bCvclcKgxTArm+Cj0QgMXVzAKjLZtPe2p2qD/MObg3QD5clQImsVIQ
         suzgkUc0eCJ6e1fHaGY02P3iibq6UoV8KNlijh/TNxce39Sf3xnF3e1NftAMuREGEEwR
         IuLmnDBAWfWy9gO+kcKRPKqZSZIFrhSLAZQDRvh89MpAyGYQI9+mEFjliSiwvbn1Gmeq
         gPlAoTuGKRKqRMs8HqQ7wntAdl6lzjDYgCbPtni6XP3qv90NaYDhPb49Sdp/+k0pO1F1
         B7Hy4WWckBQgvIhcv968NA03eJC8TejcnY68nuzzZGYZ4CoqnFYU/cdoecAIMWc0igYY
         oJpg==
X-Gm-Message-State: AOJu0Yy+Ab81LgllTR+ziIvf8JvORhjErxjqwS5WP/F2fC1MKGRp3kxO
	IfGIzEnhwfdv5YELFiiYHk8=
X-Google-Smtp-Source: AGHT+IFnz68PR5GXy3/PUKZX+fizAkSM9rw7oE4h4HRWFmkYlG0Adre5E2jREon0GalpZ47vUsiDKA==
X-Received: by 2002:a17:903:11cc:b0:1c3:3363:8aea with SMTP id q12-20020a17090311cc00b001c333638aeamr2755996plh.61.1697824184869;
        Fri, 20 Oct 2023 10:49:44 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:821f])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001c74718f2f3sm1801104plb.119.2023.10.20.10.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 10:49:44 -0700 (PDT)
Date: Fri, 20 Oct 2023 10:49:40 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
	toke@kernel.org, willemb@google.com, dsahern@kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	yoong.siang.song@intel.com, netdev@vger.kernel.org,
	xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v4 02/11] xsk: Add TX timestamp and TX checksum
 offload support
Message-ID: <20231020174940.gjubehkouns2hmgz@MacBook-Pro-49.local>
References: <20231019174944.3376335-1-sdf@google.com>
 <20231019174944.3376335-3-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019174944.3376335-3-sdf@google.com>

On Thu, Oct 19, 2023 at 10:49:35AM -0700, Stanislav Fomichev wrote:
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 2ecf79282c26..ecfd67988283 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -106,6 +106,43 @@ struct xdp_options {
>  #define XSK_UNALIGNED_BUF_ADDR_MASK \
>  	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
>  
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
> +
> +/* Force checksum calculation in software. Can be used for testing or
> + * working around potential HW issues. This option causes performance
> + * degradation and only works in XDP_COPY mode.
> + */
> +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
> +
> +struct xsk_tx_metadata {
> +	union {
> +		struct {
> +			__u32 flags;
> +
> +			/* XDP_TX_METADATA_CHECKSUM */
> +
> +			/* Offset from desc->addr where checksumming should start. */
> +			__u16 csum_start;
> +			/* Offset from csum_start where checksum should be stored. */
> +			__u16 csum_offset;
> +		};
> +
> +		struct {
> +			/* XDP_TX_METADATA_TIMESTAMP */
> +			__u64 tx_timestamp;
> +		} completion;
> +	};
> +};

Could you add a comment to above union that csum fields are consumed by the driver
before it xmits the packet while timestamp is filled during xmit, so union
doesn't prevent using both features simultaneously.
It's clear from the example, but not obvious from uapi and the doc in patch 11
doesn't clarify it either.

Also please add a name to csum part of the union like you did for completion.
We've learned it the hard way with bpf_attr. All anon structs better have field name
within a union. Helps extensibility (avoid conflicts) in the long term.

Other than this the patch set looks great to me.
With Saeed and Magnus acks we can take it in.

