Return-Path: <bpf+bounces-26450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1DA89FBE5
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925861F228C3
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6C616F0E1;
	Wed, 10 Apr 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QooDu5VM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43816EC1D;
	Wed, 10 Apr 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763739; cv=none; b=TDLufEM0UAXOS8i6UtKOVJchMLPPTZBNELLS5T135xtIdCU/UrQNVwfzDVF/ZbBO99Xa8LhUneA+j90FeueVzJEi6SIwXf8x/+slmQEGwUkaVJesSGgFGA/YgPbZC7mU5P5DI1YBhc1+hPQS/KkyVSFSV50cd7IgP58vC7SR2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763739; c=relaxed/simple;
	bh=bIYuIMobN4c7QVS8/DFCKFrNDf/uvx+QUbwB6/Ik8qs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o4eyv+G0nDa6pUyA2uKvJgTcHju6bZZpZZgCBS0BC40bGZQ3q9iXQ/eCaZ8TElHpJUdBnhVOpqsdbGZ0mfCZwD/W/Vg4JVVGuNXC29xDSdNrlhKLEaNpzHaf7VcgVixKhAu2cUuEv45AAVnZsl3CK50Z9AsIwAr5hpKRnZkb71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QooDu5VM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d62c1e82bso261365385a.3;
        Wed, 10 Apr 2024 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763737; x=1713368537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zRUuA7h1m8dPrK2eFWYrvmvpUZ/gqDhSGLftQ4YK8M=;
        b=QooDu5VM3QlNarMMplZotesJrGOPI4rIXkXlQsF7HJSK8IEEobT+NHGTt7bP2PL2AN
         SMFBIMahgMEhy0EH+hrZYGs1pSmrH1uyQvPydtUq2/DZO1Xzo2O7vQH/26HBxZGb4PCY
         CedXd8d2HdhFiOrMsB+Vbtouk2qHj6hpvVqBxCu17cp/BmfMUhkYcDRbrYPgZVyui5Zb
         L47Gn6tWMoXgBwmFjjE0RpFaQg806vETNzM7E4HTvn7LPcqwbwafsXnaf2vNkrXmKZwA
         ecUua4VvLZMj5VZzTY/67tC+A5pEKlg1UJ49nzvy4AmmRTEb3TUlxl204eJ8ilLa4aPP
         Jbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763737; x=1713368537;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8zRUuA7h1m8dPrK2eFWYrvmvpUZ/gqDhSGLftQ4YK8M=;
        b=hn+fK/9NOj3W4Z61R8i8gsAWcuHP4bSzlvZjuff07/092nZhaksfv2fTtw/GTYWERB
         BRYPxUhmvxG7RRubhF9swVWF/UBqBEOOOJYs9IzmRKd51q9mljJDhGn4CtE/e/Ybl8dz
         Jb/rttX9tWCPsmZ1Moxx76bui3h5V+IpRP0bviGr12IlvtZUTrfQhZNDQm1CS7av78xu
         dGULFu4zufEPcmukB2B903u7a2inKbz+dUFTgEsGn4JF8Etl6Kihm36B1rU/SYrTqxGh
         /kDBQEXrMPnVSh/klMuSeJh1KNeNBxiVKRuGMyzcr9xfq0udx5CaaR2JLzMtMAmc0dAs
         8QQA==
X-Forwarded-Encrypted: i=1; AJvYcCWXBUzwNbbB7bNPVhiM8O2Z+jVcWzHMSYHbO5orID1b7x62nbtH29emu0OoubMf4yqTp9RKpBsngkkPKcrnUCw21Ldw3oQYCmP6+o1sdjltaS+jyPxDTP0PxvLl4ffJO1Ubrx49e+sEKRkZceY5zrug1zFav7/VE3GD
X-Gm-Message-State: AOJu0YzU49awHomh0+/zp952N3Ygos56H7ADun9nFLwK06DJO5C1OGcA
	8LNNZ7ZI4D5ucwcyDniN/O00SDypuzwMM+11sxH+SH86A3PrBjf9
X-Google-Smtp-Source: AGHT+IEZhcmcOP0DfRYpnTQkbaXNlRT9QT3bt6hOGI8ZueLGbjAPe/HOaEXcim4f/379gTUyPzra7A==
X-Received: by 2002:a05:620a:1035:b0:78b:c6c4:a6c8 with SMTP id a21-20020a05620a103500b0078bc6c4a6c8mr2699168qkk.5.1712763736648;
        Wed, 10 Apr 2024 08:42:16 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id c19-20020a05620a135300b0078d5ef01b24sm4053408qkl.25.2024.04.10.08.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:42:16 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:42:16 -0400
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
Message-ID: <6616b3587520_2a98a5294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240409210547.3815806-4-quic_abchauha@quicinc.com>
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
 <20240409210547.3815806-4-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v1 3/3] net: Add additional bit to support
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
> 
> To make the design scalable for future needs this commit bring in
> the change to extend the tstamp_type:1 to tstamp_type:2 to support
> userspace timestamp.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
>  include/linux/skbuff.h | 19 +++++++++++++++++--
>  net/ipv4/ip_output.c   |  2 +-
>  net/ipv4/raw.c         |  2 +-
>  net/ipv6/ip6_output.c  |  2 +-
>  net/ipv6/raw.c         |  2 +-
>  net/packet/af_packet.c |  6 +++---
>  6 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6160185f0fe0..2f91a8a2157a 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -705,6 +705,9 @@ typedef unsigned char *sk_buff_data_t;
>  enum skb_tstamp_type {
>  	SKB_TSTAMP_TYPE_RX_REAL = 0,    /* A RX (receive) time in real */
>  	SKB_TSTAMP_TYPE_TX_MONO = 1,    /* A TX (delivery) time in mono */
> +	SKB_TSTAMP_TYPE_TX_USER = 2,    /* A TX (delivery) time and its clock
> +									 * is in skb->sk->sk_clockid.
> +									 */

Weird indentation?

More fundamentally: instead of defining a type TX_USER, can we use a
real clockid (e.g., CLOCK_TAI) based on skb->sk->sk_clockid? Rather
than store an id that means "go look at sk_clockid".

>  };
>  
>  /**
> @@ -830,6 +833,9 @@ enum skb_tstamp_type {
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *		skb->tstamp has the (rcv) timestamp at ingress and
>   *		delivery_time at egress.
> + *		delivery_time in mono clock base (i.e., EDT) or a clock base chosen
> + *		by SO_TXTIME. If zero, skb->tstamp has the (rcv) timestamp at
> + *		ingress.
>   *	@napi_id: id of the NAPI struct this skb came from
>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>   *	@alloc_cpu: CPU which did the skb allocation.
> @@ -960,7 +966,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> +	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;

With pahole, does this have an effect on sk_buff layout?

> @@ -4274,7 +4280,16 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>  					enum skb_tstamp_type tstamp_type)
>  {
>  	skb->tstamp = kt;
> -	skb->tstamp_type = kt && tstamp_type;
> +
> +	if (skb->tstamp_type)
> +		return;
> +

Why bail if a type is already set? And what if
skb->tstamp_type != tstamp_type? Should skb->tstamp then not be
written to (i.e., the test moved up), and perhaps a rate limited
warning.

> +	if (kt && tstamp_type == SKB_TSTAMP_TYPE_TX_MONO)
> +		skb->tstamp_type = SKB_TSTAMP_TYPE_TX_MONO;
> +
> +	if (kt && tstamp_type == SKB_TSTAMP_TYPE_TX_USER)
> +		skb->tstamp_type = SKB_TSTAMP_TYPE_TX_USER;

Simpler

    if (kt)
        skb->tstamp_type = tstamp_type;

