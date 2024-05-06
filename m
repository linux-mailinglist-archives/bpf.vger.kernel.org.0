Return-Path: <bpf+bounces-28706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9748BD512
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2FD1F21C6B
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94691591E8;
	Mon,  6 May 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeAxvAQp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD08158DD5;
	Mon,  6 May 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022013; cv=none; b=WRmd7TTD/7k+Dkpp37m3S9SHHJa3fFNuEA5NnD7Mj1mgxBxc9DowM5ye4q/EHnnqz2BEUfP1U18gA/yLZOYMRfi5trYnq/u0nzVVkEZ6/uuV7Gl8+dVTcmoH6QAH1U2XnIBTEMybfzGXDv2l5by2m5T3J70ZRXoCnu1NSffqiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022013; c=relaxed/simple;
	bh=Euxs9KJIZ78yPcSwjEnEjjpolNGSmMSxOuzS39fMApw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gxS8sxH5uUbNERvJUpxWDag+DVNVP49QMQ5NNhpziyfZ2rooldAsxf8eaX/12AhMLA92ayQrLrPtzJC3XYy/5n1/1hsv6pA9UPMCu9u1b0QZDWIxQfkpYnMn/IqP9o6OTOYIRimxwR0pQtWoY8FhHVFfgJpJbAeSA8W7uug1V1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeAxvAQp; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c963880aecso795535b6e.3;
        Mon, 06 May 2024 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715022011; x=1715626811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10T5rur33Yqm4wo0EFQIMeMbzR3ugz/vLCFUG/913qA=;
        b=OeAxvAQpS0YniMgCoUR7YYDNOp0zS9aKqAPwAvr/cZ06DL+oy7ypZtDEe+RgZgYySC
         bUhx4XMML2WQxLBjuv5UkVa/TZWIYqfHvD1XEezF+UPUDYZV0sEHCLmY37w959q6YnkN
         iCioqbXs8nv28rxqyfAl4EndCnEExtUWqc6t15uMHum4q3aQCBn3kZHcgZHI5oGt9+Wm
         bOClfzdTMOd/J0Iq0DmWXENHkOXosCsT3H8gI6s0XzMYRVTXELtxgU4AFN5ylsnLqVDX
         r89PZI4a9yCtsCIiKYgcYLIC8FPnEZ2eOimZZWA4B3y225HavEveczTkQY6gs4xLLkkP
         3YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715022011; x=1715626811;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10T5rur33Yqm4wo0EFQIMeMbzR3ugz/vLCFUG/913qA=;
        b=MeJLOqDXYW464WUF5nG/1iEVWgKeJzTciyjVPc/hRitysoO3mqR7kLkjQuLPQXN5nk
         fzW/Sww+YsAAJvc3jGWt+36omiumajgV4gichR2Gi6Luy+s66DhKZ2Y+LDoSg509Q1fe
         F7Uj7VmY7qC/1m7cSPic2sQMTStE2SaUzrNMCN94MK63pzONg+mmMXCIp+kaeXtsJKuz
         9x0RXH1zcc4hEY2c5He07JRLz81ONXYGT6A62jjaWFvuiixEqNpEe4HhANuKdPC+Jjud
         6zwxarYbRW6gIwqrUSCHhV2rQvMI/xktLW+ZSH83ppJgUHJMTcfV5M+dWagzA/E0z2G1
         pTiA==
X-Forwarded-Encrypted: i=1; AJvYcCVWOHIxEQ5v2zD84A1Mrgp10Ccv2RCMa2Rzb1keE8Y8Cfcj9MlLUu+/jnvBN+esqGyRFugGWw1XWcClStK7PufNAz2ybeSObX47i6v3RNm+2SCySdMaxg50XkVcRTa6z4Ty0nNpEZRtgZRMFC0i+EZzVCTbbTNG3Eo+
X-Gm-Message-State: AOJu0YyoqZAwGKDhTLyeoXVmTU3gZVBauj5laTeHAXEGlhBwtOvcuJMD
	y0Dq5ffqvVSDWVEJjAnkQzMnJCVdyW2z4gXVR3aGSyhApV7T5Fsa
X-Google-Smtp-Source: AGHT+IH81W3pk5PMOmTI1vvKSy20nxCJhSKpPacLnEmZF16zekZuYD1rSSrd9+9/uqXptPu8aJqqWw==
X-Received: by 2002:aca:d01:0:b0:3c9:6c3b:77a with SMTP id 1-20020aca0d01000000b003c96c3b077amr4420310oin.13.1715022010764;
        Mon, 06 May 2024 12:00:10 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ceb8c000000b006a0f012fab9sm3982949qvo.52.2024.05.06.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:00:10 -0700 (PDT)
Date: Mon, 06 May 2024 15:00:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <663928ba373e3_516de294d5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240504031331.2737365-3-quic_abchauha@quicinc.com>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-3-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v6 2/3] net: Add additional bit to support
 clockid_t timestamp type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> tstamp_type is now set based on actual clockid_t compressed
> into 2 bits.
> 
> To make the design scalable for future needs this commit bring in
> the change to extend the tstamp_type:1 to tstamp_type:2 to support
> other clockid_t timestamp.
> 
> We now support CLOCK_TAI as part of tstamp_type as part of this
> commit with exisiting support CLOCK_MONOTONIC and CLOCK_REALTIME.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v5
> - Took care of documentation comments of tstamp_type 
>   in skbuff.h as mentioned by Willem.
> - Use of complete words instead of abbrevation in 
>   macro definitions as mentioned by Willem.
> - Fixed indentation problems 
> - Removed BPF_SKB_TSTAMP_UNSPEC and marked it 
>   Deprecated as documentation, and introduced 
>   BPF_SKB_CLOCK_REALTIME instead. 
> - BUILD_BUG_ON for additional enums introduced.
> - __ip_make_skb and ip6_make_skb now has 
>   tcp checks to mark tcp packet as mono tstamp base. 
> - separated the selftests/bpf changes into another patch.
> - Made changes as per Martin in selftest bpf code and 
>   tool/include/uapi/linux/bpf.h 
> 
> Changes since v4
> - Made changes to BPF code in filter.c as per 
>   Martin's comments
> - Minor fixes on comments given on documentation
>   from Willem in skbuff.h (removed obvious ones)
> - Made changes to ctx_rewrite.c and test_tc_dtime.c
> - test_tc_dtime.c i am not really sure if i took care 
>   of all the changes as i am not too familiar with 
>   the framework.
> - Introduce common mask SKB_TSTAMP_TYPE_MASK instead
>   of multiple SKB mask.
> - Optimisation on BPF code as suggested by Martin.
> - Set default case to SKB_CLOCK_REALTME.  
> 
> Changes since v3
> - Carefully reviewed BPF APIs and made changes in 
>   BPF code as well. 
> - Re-used actual clockid_t values since skbuff.h 
>   indirectly includes uapi/linux/time.h
> - Added CLOCK_TAI as part of the skb_set_delivery_time
>   handling instead of CLOCK_USER
> - Added default in switch for unsupported and invalid 
>   timestamp with an WARN_ONCE
> - All of the above comments were given by Willem  
> - Made changes in filter.c as per Martin's comments
>   to handle invalid cases in bpf code with addition of
>   SKB_TAI_DELIVERY_TIME_MASK
> 
> Changes since v2
> - Minor changes to commit subject
> 
> Changes since v1 
> - identified additional changes in BPF framework.
> - Bit shift in SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK.
> - Made changes in skb_set_delivery_time to keep changes similar to 
>   previous code for mono_delivery_time and just setting tstamp_type
>   bit 1 for userspace timestamp.
> 
> 
>  include/linux/skbuff.h   | 21 +++++++++++--------
>  include/uapi/linux/bpf.h | 15 +++++++++-----
>  net/core/filter.c        | 44 +++++++++++++++++++++++-----------------
>  net/ipv4/ip_output.c     |  5 ++++-
>  net/ipv4/raw.c           |  2 +-
>  net/ipv6/ip6_output.c    |  5 ++++-
>  net/ipv6/raw.c           |  2 +-
>  net/packet/af_packet.c   |  7 +++----
>  8 files changed, 61 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index de3915e2bfdb..fe7d8dbef77e 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -709,6 +709,8 @@ typedef unsigned char *sk_buff_data_t;
>  enum skb_tstamp_type {
>  	SKB_CLOCK_REALTIME,
>  	SKB_CLOCK_MONOTONIC,
> +	SKB_CLOCK_TAI,
> +	__SKB_CLOCK_MAX = SKB_CLOCK_TAI,
>  };
>  
>  /**
> @@ -829,8 +831,7 @@ enum skb_tstamp_type {
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
>   *	@tstamp_type: When set, skb->tstamp has the
> - *		delivery_time in mono clock base Otherwise, the
> - *		timestamp is considered real clock base.
> + *		delivery_time clock base of skb->tstamp.
>   *	@napi_id: id of the NAPI struct this skb came from
>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>   *	@alloc_cpu: CPU which did the skb allocation.
> @@ -958,7 +959,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			tstamp_type:1;	/* See skb_tstamp_type */
> +	__u8			tstamp_type:2;	/* See skb_tstamp_type */
>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;
> @@ -1088,15 +1089,16 @@ struct sk_buff {
>  #endif
>  #define PKT_TYPE_OFFSET		offsetof(struct sk_buff, __pkt_type_offset)
>  
> -/* if you move tc_at_ingress or mono_delivery_time
> +/* if you move tc_at_ingress or tstamp_type
>   * around, you also must adapt these constants.
>   */
>  #ifdef __BIG_ENDIAN_BITFIELD
> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
> -#define TC_AT_INGRESS_MASK		(1 << 6)
> +#define SKB_TSTAMP_TYPE_MASK		(3 << 6)
> +#define SKB_TSTAMP_TYPE_RSHIFT		(6)
> +#define TC_AT_INGRESS_MASK		(1 << 5)
>  #else
> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> -#define TC_AT_INGRESS_MASK		(1 << 1)
> +#define SKB_TSTAMP_TYPE_MASK		(3)
> +#define TC_AT_INGRESS_MASK		(1 << 2)
>  #endif
>  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>  
> @@ -4213,6 +4215,9 @@ static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
>  	case CLOCK_MONOTONIC:
>  		tstamp_type = SKB_CLOCK_MONOTONIC;
>  		break;
> +	case CLOCK_TAI:
> +		tstamp_type = SKB_CLOCK_TAI;
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		kt = 0;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 90706a47f6ff..25ea393cf084 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6207,12 +6207,17 @@ union {					\
>  	__u64 :64;			\
>  } __attribute__((aligned(8)))
>  
> +/* The enum used in skb->tstamp_type. It specifies the clock type
> + * of the time stored in the skb->tstamp.
> + */
>  enum {
> -	BPF_SKB_TSTAMP_UNSPEC,
> -	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
> -	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
> -	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
> -	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
> +	BPF_SKB_TSTAMP_UNSPEC = 0,		/* DEPRECATED */
> +	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,	/* DEPRECATED */
> +	BPF_SKB_CLOCK_REALTIME = 0,
> +	BPF_SKB_CLOCK_MONOTONIC = 1,
> +	BPF_SKB_CLOCK_TAI = 2,
> +	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
> +	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
>  	 */
>  };
>  
> diff --git a/net/core/filter.c b/net/core/filter.c
> index a3781a796da4..9f3df4a0d1ee 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7726,16 +7726,20 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
>  		return -EOPNOTSUPP;
>  
>  	switch (tstamp_type) {
> -	case BPF_SKB_TSTAMP_DELIVERY_MONO:
> +	case BPF_SKB_CLOCK_MONOTONIC:
>  		if (!tstamp)
>  			return -EINVAL;
>  		skb->tstamp = tstamp;
>  		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
>  		break;
> -	case BPF_SKB_TSTAMP_UNSPEC:
> -		if (tstamp)
> +	case BPF_SKB_CLOCK_TAI:
> +		if (!tstamp)
>  			return -EINVAL;
> -		skb->tstamp = 0;
> +		skb->tstamp = tstamp;
> +		skb->tstamp_type = SKB_CLOCK_TAI;
> +		break;
> +	case BPF_SKB_CLOCK_REALTIME:
> +		skb->tstamp = tstamp;
>  		skb->tstamp_type = SKB_CLOCK_REALTIME;

Only since there is another reason to respin.

The previous code did not do this, but let's order cases by their enum
value, starting with realtime.

Also in anticipation with possible future expansions.



