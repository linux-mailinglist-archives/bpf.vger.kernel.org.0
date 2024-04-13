Return-Path: <bpf+bounces-26707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B68A3E25
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 20:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4BC1F2141B
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F8C53E18;
	Sat, 13 Apr 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdhnGOq7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FA3FE55;
	Sat, 13 Apr 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713034484; cv=none; b=dRDV1CJr1gSh4ayr79ZvZ9DW4dsauSfNDEabKBu8Fiu4ItveSrGGMTPj1f3XApFV2LbxGinL5H2fTCTVoKaZyYvraZgcJQV525tCu88QXY0TZJfGX/4mHXzBXeHocOQ9YqsqW8Dj0/JSkukOW/CQpVDlqGFHM6U6mn8Gqha2AGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713034484; c=relaxed/simple;
	bh=oarggZnPDxO4zbBN7WQd6RHzcVQo6Bm6TwGHk1kdNr8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XLGyxy7aZTi7nqCYnvyQGa6V98LKWFbLp8juvv9hePp5fyrl1dH2VfOTQD9x/T0u0c93KgzDQlqraWdFyrYnvV7IcAGmISdiYbZvpCTj8g1qJXJbaMm853l/ggnt0kYgwj7uiEaxNPPve/oUgN4fsbokW0Om4/88hdA1n1a56O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdhnGOq7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d743f3654so153378885a.0;
        Sat, 13 Apr 2024 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713034481; x=1713639281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzOGXim2vNdwdzX8IpzEzvZHcB/u0K5tNCKdVPMNuaQ=;
        b=FdhnGOq71wAwPUts5XPPhEfiAf8O0bX9czV/KzzpIzNDX8ZXhQZYmg6DXZmmScIJjL
         B6kYo4AjMw93PGnIIRXvZlGlAjR/rS/K1dDLmH0W/B6jjAy5xU6ZWsZRVQkO3iIQ4zum
         +hOLVqZOYZGM41BfrtU3SemBaFyM7OWXeQAWqLUXonBbPUtXdS638inW7CXphrIJH2pu
         8nJcy+f5zvr7wfHqjSlEQUS0i8332OONgWKmHUAGAjHwr2fHvzl2cLBZwKIEztta4YIS
         5Gz5YOh8Kjbs4kkqnAy3T4PdMEqPs1z52LzSkngqSS9jAo10rBhQQ0cjDglJ7qlUZhj7
         G88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713034481; x=1713639281;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wzOGXim2vNdwdzX8IpzEzvZHcB/u0K5tNCKdVPMNuaQ=;
        b=t/mO3esRsXoGexzuB6E6Qe+FMmyF6gZIBuyjfVAOQ86RCFCiwxXjV/wKxxSXHQ9SRc
         IDBa3ON0Yiac3Oeje4/PQKmRP2ynkmZqHtj/EuIhf9M9ojK+wQdGpMoXoIF+jN5cpky4
         7hxu4dk98LCKd1UOzon7F9WstGYZqMUkvCGhxIpc7vTioM5hqHRVnD+CFPZG6o6OKtEw
         F0O2+oSdVGzyME4+QUxHoAH5O3AqzEZm7lOzPiNGm3tDuWs1naa/NxnfGcn5t2/k/u31
         w5aBJaKTFSfgECyb5Sqs3A3gbbi8vKntwM7sTquzxbZrpPimCtMCO6gbTWgE3JT1OLeL
         31FA==
X-Forwarded-Encrypted: i=1; AJvYcCV21wsTRSXcz7TXuz2m4qh/pBs3SM/EynUeki+Lvz5OWQT/iZ/tNDM1b9nk87AhrePm0dQTLxn2sxR8g2CRk4Zw9D2ToGb+qU3yWhcgJzDSrdq43QSiwTSjeOD7AkiPI3DrmPOq5q8InvANFyiEmvTDeSKENbhFIC/p
X-Gm-Message-State: AOJu0YwxW6mRRUJ3Dyea7qO83ImMztC4D9FwY61oYaJr75G2HJOYK2Dn
	TOPjsCthzTnkl/g13C12Bdzu3tyzEc5DOjXJ9uoxB7Ly5BnUrcZ0
X-Google-Smtp-Source: AGHT+IFp9picPxyikN7qdvIX81Bd7aUswYq+ttiE7mTx+6CDs42ecgjVHphO6GC68hpJkPtn53WH7Q==
X-Received: by 2002:a05:620a:2101:b0:78e:d731:d85d with SMTP id l1-20020a05620a210100b0078ed731d85dmr2528472qkl.48.1713034481524;
        Sat, 13 Apr 2024 11:54:41 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a295100b0078d5ffa723asm4050417qkp.94.2024.04.13.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 11:54:41 -0700 (PDT)
Date: Sat, 13 Apr 2024 14:54:40 -0400
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
Message-ID: <661ad4f0e3766_3be9a7294a1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412210125.1780574-2-quic_abchauha@quicinc.com>
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
 <20240412210125.1780574-2-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
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
> mono_delivery_time was added to check if skb->tstamp has delivery
> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> timestamp in ingress and delivery_time at egress.
> 
> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> extensibilty for other timestamps such as userspace timestamp
> (i.e. SO_TXTIME) set via sock opts.
> 
> As we are renaming the mono_delivery_time to tstamp_type, it makes
> sense to start assigning tstamp_type based out if enum defined as
> part of this commit
> 
> Earlier we used bool arg flag to check if the tstamp is mono in
> function skb_set_delivery_time, Now the signature of the functions
> accepts enum to distinguish between mono and real time
> 
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> In future tstamp_type:1 can be extended to support userspace timestamp
> by increasing the bitfield.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v2
> - Minor changes to commit subject
> 
> Changes since v1
> - Squashed the two commits into one as mentioned by Willem.
> - Introduced switch in skb_set_delivery_time.
> - Renamed and removed directionality aspects w.r.t tstamp_type 
>   as mentioned by Willem.
> 
>  include/linux/skbuff.h                     | 33 +++++++++++++++-------
>  include/net/inet_frag.h                    |  4 +--
>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 ++--
>  net/core/dev.c                             |  2 +-
>  net/core/filter.c                          |  8 +++---
>  net/ipv4/inet_fragment.c                   |  2 +-
>  net/ipv4/ip_fragment.c                     |  2 +-
>  net/ipv4/ip_output.c                       |  8 +++---
>  net/ipv4/tcp_output.c                      | 14 ++++-----
>  net/ipv6/ip6_output.c                      |  6 ++--
>  net/ipv6/netfilter.c                       |  6 ++--
>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>  net/ipv6/reassembly.c                      |  2 +-
>  net/ipv6/tcp_ipv6.c                        |  2 +-
>  net/sched/act_bpf.c                        |  4 +--
>  net/sched/cls_bpf.c                        |  4 +--
>  16 files changed, 59 insertions(+), 46 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 7135a3e94afd..a83a2120b57f 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -702,6 +702,11 @@ typedef unsigned int sk_buff_data_t;
>  typedef unsigned char *sk_buff_data_t;
>  #endif
>  
> +enum skb_tstamp_type {
> +	CLOCK_REAL = 0, /* Time base is realtime */
> +	CLOCK_MONO = 1, /* Time base is Monotonic */
> +};

Minor: inconsistent capitalization

> +
>  /**
>   * DOC: Basic sk_buff geometry
>   *
> @@ -819,7 +824,7 @@ typedef unsigned char *sk_buff_data_t;
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
> - *	@mono_delivery_time: When set, skb->tstamp has the
> + *	@tstamp_type: When set, skb->tstamp has the
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *		skb->tstamp has the (rcv) timestamp at ingress and
>   *		delivery_time at egress.
> @@ -950,7 +955,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> +	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */

Also remove reference to MONO_DELIVERY_TIME_MASK, or instead refer to
skb_tstamp_type.

>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;
> @@ -4237,7 +4242,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
>  static inline void __net_timestamp(struct sk_buff *skb)
>  {
>  	skb->tstamp = ktime_get_real();
> -	skb->mono_delivery_time = 0;
> +	skb->tstamp_type = CLOCK_REAL;
>  }
>  
>  static inline ktime_t net_timedelta(ktime_t t)
> @@ -4246,10 +4251,18 @@ static inline ktime_t net_timedelta(ktime_t t)
>  }
>  
>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> -					 bool mono)
> +					  u8 tstamp_type)
>  {
>  	skb->tstamp = kt;
> -	skb->mono_delivery_time = kt && mono;
> +
> +	switch (tstamp_type) {
> +	case CLOCK_REAL:
> +		skb->tstamp_type = CLOCK_REAL;
> +		break;
> +	case CLOCK_MONO:
> +		skb->tstamp_type = kt && tstamp_type;
> +		break;
> +	}

Technically this leaves the tstamp_type undefined if (skb, 0, CLOCK_REAL)
>  }
>  
>  DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
> @@ -4259,8 +4272,8 @@ DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
>   */
>  static inline void skb_clear_delivery_time(struct sk_buff *skb)
>  {
> -	if (skb->mono_delivery_time) {
> -		skb->mono_delivery_time = 0;
> +	if (skb->tstamp_type) {
> +		skb->tstamp_type = CLOCK_REAL;
>  		if (static_branch_unlikely(&netstamp_needed_key))
>  			skb->tstamp = ktime_get_real();
>  		else
> @@ -4270,7 +4283,7 @@ static inline void skb_clear_delivery_time(struct sk_buff *skb)
>  
>  static inline void skb_clear_tstamp(struct sk_buff *skb)
>  {
> -	if (skb->mono_delivery_time)
> +	if (skb->tstamp_type)
>  		return;
>  
>  	skb->tstamp = 0;
> @@ -4278,7 +4291,7 @@ static inline void skb_clear_tstamp(struct sk_buff *skb)
>  
>  static inline ktime_t skb_tstamp(const struct sk_buff *skb)
>  {
> -	if (skb->mono_delivery_time)
> +	if (skb->tstamp_type == CLOCK_MONO)
>  		return 0;

Should this be if (skb->tstamp_type), in line with skb_clear_tstamp,
right above?

> @@ -1649,7 +1649,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
>  			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
>  								arg->csum));
>  		nskb->ip_summed = CHECKSUM_NONE;
> -		nskb->mono_delivery_time = !!transmit_time;
> +		nskb->tstamp_type = !!transmit_time;

In anticipation of more tstamp_types, explicitly set to CLOCK_MONO.

>  		if (txhash)
>  			skb_set_hash(nskb, txhash, PKT_HASH_TYPE_L4);
>  		ip_push_pending_frames(sk, &fl4);

