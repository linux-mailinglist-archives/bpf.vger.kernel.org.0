Return-Path: <bpf+bounces-26708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C38A3E2C
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 21:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4F6B212D4
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E37053E30;
	Sat, 13 Apr 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgp2IiMW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56623BE;
	Sat, 13 Apr 2024 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713035224; cv=none; b=jjLmx5mCkUN4sag/62BQ8adPrterfHy/MM74siOxx7xwCQ+/T7SQBRl+QZN+krm8UV/LumUaciMUbHVohKZeUuRf9rFdzWv82zqsDsey+HPPXq9/cbnGHdtRtBLUeOJ4AAm/KC1shpKYZLtTjdp5pFliBLozcy3pa5PVqjwICj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713035224; c=relaxed/simple;
	bh=DNhhbIc6L+IKpDdQxrC3Ktu1wDXXBPiMctnl9rg5itU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bbhmYAUGQs15i3QWJP2qmXo1QweoGyw+ZI6M+rKbh+ujmXpWaA0wzsZFtLrG3O48bNYA2gzAXVZqo+DvTYXvEKEWHYr68EZ8AjC2o0agJlpAvEYDLY6R0NmgH9cgPvTdQuM60bJDnobRa8e68N/PNHCfj0eCKozO+ctynJEMYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgp2IiMW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d6021e2e3so130749685a.1;
        Sat, 13 Apr 2024 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713035221; x=1713640021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqez31DaanVbX+mWuT0+GQUVsDTps4xeskVhFkNVA0E=;
        b=bgp2IiMWy9pv7iE97o2GSEvd7NtZOnKe2vnDcKZJOC5VKr5UnWJVqGqLhtUi6XQNqd
         iEK2qT0T8AZJIePnSInpPFjgmOU0opS6c7a9ncHWWvl2qxjtgtDl/29QBlKw/gcs/z0X
         929IZ/aFNeNOj8Ei18sUNeRqV4VkHjs+Z5nBFDZIB5m/Mo8itjGyVMY8Ol3h5sbwmdIl
         B+8p8Jn2dNXkI+1oRr63hehsy7lAsmDABgsJWaKaeuTkxcCTL9TpH+hfG4u6ZjozbnJy
         XQOKFM8al90NYdsICzTzF/+K55vcfn0T8kheEEIVtgoo5hG27RgV++g5j4rWur8f7TFy
         wawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713035221; x=1713640021;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqez31DaanVbX+mWuT0+GQUVsDTps4xeskVhFkNVA0E=;
        b=M7NsL1WhOuyKjDxi9zKN1WXlt5d0RDjM2Zk0Q7BqnhqN7XyVS2rrg5IRjtfUhgleNH
         paMmvR8GibSDLKzr4QicFGg8AQsj2yWW7Is6k3u2JK9M7rMyH0z6c9FzGThiCmut1V4N
         lACEQ+7FEw9Wy6qgiWEfzFEF4z7qLM+GflanIardRnf9qtJRoWGlBQ1JBCfFywLDeUlN
         njfW216X5cKvfXiZF2G5/6ozKZeWFrfiq9m2X02uovbl8jbyHe5KOCq6Z5KOz2N5WIQ5
         ZQIkvd+HlP/l/ZpPCifGJaGdKtxUzkXoescnnPYd/90tPDVQ6tyXJDinVZUvB89d52cy
         eLqw==
X-Forwarded-Encrypted: i=1; AJvYcCXVHaCi6R7Uxevuiw1laBKmpshXE8mwlY9d/lEslZcUFIkgidAukYe5rHGKd9OIm2V3idpsddJi0vFXXyZ6EfAy/Bt7f+AozottD/CP/CZEDzbYKfyaoTZcGW/nD0+YBjr9uSYkiNnQSWO88tY51uVfODH/H78ilA5H
X-Gm-Message-State: AOJu0YzTpxn8+uGNlW58TloncRWN5bOOwq95W02+7Hd/HQOYk5nF/0IM
	Qtmg3wAGBXJ+jfD8P/UFrxarhRfuZHnFb2M1l+naZOKoQKLEsDzn
X-Google-Smtp-Source: AGHT+IHkdAuWAYDB6LpnIPHdJm0zAMcyvrrhUxT4H57RvsW70LQWs7ATZMLrXlZtE/wUpIh4GtNiyA==
X-Received: by 2002:a05:620a:40cb:b0:78e:caa7:cd23 with SMTP id g11-20020a05620a40cb00b0078ecaa7cd23mr6967884qko.20.1713035221401;
        Sat, 13 Apr 2024 12:07:01 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id b18-20020a05620a0cd200b0078d670115fcsm4044059qkj.51.2024.04.13.12.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 12:07:01 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:07:00 -0400
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
Message-ID: <661ad7d4c65da_3be9a7294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412210125.1780574-3-quic_abchauha@quicinc.com>
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
 <20240412210125.1780574-3-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] net: Add additional bit to support
 userspace timestamp type
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
> tstamp_type can be real, mono or userspace timestamp.
> 
> This commit adds userspace timestamp and sets it if there is
> valid transmit_time available in socket coming from userspace.

Comment is outdated: we now set the actual clockid_t (compressed
into fewer bits), rather than an abstract "go see sk_clockid".
 
> To make the design scalable for future needs this commit bring in
> the change to extend the tstamp_type:1 to tstamp_type:2 to support
> userspace timestamp.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
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
>  include/linux/skbuff.h                        | 19 +++++++++++++++----
>  net/ipv4/ip_output.c                          |  2 +-
>  net/ipv4/raw.c                                |  2 +-
>  net/ipv6/ip6_output.c                         |  2 +-
>  net/ipv6/raw.c                                |  2 +-
>  net/packet/af_packet.c                        |  7 +++----
>  .../selftests/bpf/prog_tests/ctx_rewrite.c    |  8 ++++----
>  7 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a83a2120b57f..b6346c21c3d4 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -827,7 +827,8 @@ enum skb_tstamp_type {
>   *	@tstamp_type: When set, skb->tstamp has the
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *		skb->tstamp has the (rcv) timestamp at ingress and
> - *		delivery_time at egress.
> + *		delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
> + *		coming from userspace
>   *	@napi_id: id of the NAPI struct this skb came from
>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>   *	@alloc_cpu: CPU which did the skb allocation.
> @@ -955,7 +956,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> +	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;

A quick pahole for a fairly standard .config that I had laying around
shows a hole after this list of bits, so no huge concerns there from
adding a bit:

           __u8               slow_gro:1;           /*     3: 4  1 */
           __u8               csum_not_inet:1;      /*     3: 5  1 */

           /* XXX 2 bits hole, try to pack */

           __u16              tc_index;             /*     4     2 */

> @@ -1090,10 +1091,10 @@ struct sk_buff {
>   */
>  #ifdef __BIG_ENDIAN_BITFIELD
>  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
> -#define TC_AT_INGRESS_MASK		(1 << 6)
> +#define TC_AT_INGRESS_MASK		(1 << 5)

Have to be careful when adding a new 2 bit tstamp_type with both bits
set, that this does not incorrectly get interpreted as MONO.

I haven't looked closely at the BPF API, but hopefully it can be
extensible to return the specific type. If it is hardcoded to return
either MONO or not, then only 0x1 should match, not 0x3.

>  #else
>  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> -#define TC_AT_INGRESS_MASK		(1 << 1)
> +#define TC_AT_INGRESS_MASK		(1 << 2)
>  #endif
>  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>  
> @@ -4262,6 +4263,16 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>  	case CLOCK_MONO:

Come to think of it, these CLOCK_* names are too generic and shadow
existing ones like CLOCK_MONOTONIC.

Instead, define SKB_CLOCK_.

>  		skb->tstamp_type = kt && tstamp_type;
>  		break;
> +	/* if any other time base, must be from userspace
> +	 * so set userspace tstamp_type bit
> +	 * See skbuff tstamp_type:2
> +	 * 0x0 => real timestamp_type
> +	 * 0x1 => mono timestamp_type
> +	 * 0x2 => timestamp_type set from userspace
> +	 */
> +	default:
> +		if (kt && tstamp_type)
> +			skb->tstamp_type = 0x2;

Needs a constant.

Plan is to add SKB_CLOCK_TAI, rather than SKB_CLOCK_USER that
requires a further lookup to sk_clockid.

>  	}
>  }
>  
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 62e457f7c02c..c9317d4addce 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>  
>  	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>  	skb->mark = cork->mark;
> -	skb->tstamp = cork->transmit_time;
> +	skb_set_delivery_time(skb, cork->transmit_time, sk->sk_clockid);

If adding 1 or 2 specific clock types, like SKB_CLOCK_TAI, then
skb_set_delivery_time will have to detect unsupported sk_clockid
values and fail for those.

The function does not return an error, so just fail to set the
delivery time and WARN_ONCE.



