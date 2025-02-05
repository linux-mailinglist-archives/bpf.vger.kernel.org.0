Return-Path: <bpf+bounces-50521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8CA2952F
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E236A1666AA
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DEE18FDDA;
	Wed,  5 Feb 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhOD8Zn/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A918CC1C;
	Wed,  5 Feb 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770464; cv=none; b=eECXw0ltGWBrmleutAkEkWl7TV0MwA/cei3jqSCHOgLOH1++3Dm5iNREVN0sfJTnvzqNeumWw/LA3KfdWgeygWgP24R8kxXV6EMeyQaumfYLRDtRxST0krpV3iWmgzJUe90L4xXAoddARzQaEn9FZhiY72dIsPjdHiYIIX1xKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770464; c=relaxed/simple;
	bh=Vhxa8Kluof8tQ57nZgFS8wLF/iP6g1qIWX2rzp/zJZ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZN5MTXyfLhB4sg349fGR4OusZmqtVMsEqIv/UIkBVZJ4uG6TFu948cMi0QKdEqS9zJPJ8Qxy9cR2bttbDTUyV6ZTK/8Kdd8s9ozyN4mZHLBj7wOPHdMmkY+ZhDdVfM8vem3pw58iwPQjG1XosHN6cjM8TthhdgHsHY95J170vqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhOD8Zn/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467b955e288so72880871cf.1;
        Wed, 05 Feb 2025 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738770461; x=1739375261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfj0x0hyRqHVRsHMvjTQF2w844aQ9AHgdYdX5KzT/UU=;
        b=bhOD8Zn/ctKbyY43ewhAcJcKrN36CyAZ3bWZvFXeKjtEA0GrItiDrpYlry4qebA3GH
         jrUK2oeHqSEgQUugA0xQv5BJMAQtWtwcBFQp7rQek/LiXL4IJOKkiUQwS/CxrShcc+7f
         83r6RqNyAyldzXyMZ/M5LtUYe3jmpSdtiBenCCWYZFVX1T0/639TS27HFyliXb4QPAj5
         gQOE7TVKCTvoYTWzX8fdRWR7yk9uMaZVWh/cDr3uDeyMFYm1nZWy3UiSwt6juwc5KM4B
         Mf0nHjtJd+d6pETWO2OtYr+p55vF92cx7/4AFlRSuBZkSBrp82NU5o3AS8s07HSFVgr0
         Ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770461; x=1739375261;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qfj0x0hyRqHVRsHMvjTQF2w844aQ9AHgdYdX5KzT/UU=;
        b=CsC9lldOQ6skoLKO3V0v3ShxgGsI1mTzxvJTTNcJOee3sBndmHzcxvVzIQ6AFXQJhu
         eBNB+7r1Qs4Meb+4ofWcidf7ZK58QCveqNdiQGXo6+nmCvQZq/gc0AfSk0vssxQIcZS/
         UO5UzrcFcjQpp25XUC4mWElkm2izfHQ/nhX/McAFF2zLtNpd2WG/W5159RRehe7xr5SQ
         Wm3+ey5qyuL9Ry6HoUa0TVTWhbmTCBvHymu08721JVZAAQNwBEHm+UX2WCLyI4vDmMyI
         NxFH1BIt8baELK7MQcNSpC3+jtmlN910tHobRtbD7WAOSpGPHTWcjFcA3dCG8953SELp
         l/zg==
X-Forwarded-Encrypted: i=1; AJvYcCUpgUGy+5Nbd9BJZcxqj47IEJNr0wg+WF2TiSBVsLyJ1bJ4LTY0iGZMSdCFJRVxyZXInRBQkvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGOECSBxwOflkP9hRnZl22bw5GiLVyDQZjgFkaEpM5xu05lQ7
	kn+5Ls6cJ0Ls36YEbD/85BqWEYDGWhf9kfAARWdHIVYgi5p5SkwR
X-Gm-Gg: ASbGnctqLZ5wDg+mPp0x1a3WhaUw9gPx+QfujcGTfwHGsKjJqqUiaE80isktJIrqmn+
	NfXFGZucXFzAVdl0A5bvbX5t8jJIfqGyUwskccD0oKVtO82gHenOmuAjWYVVaA9Pme4dgA1WkFC
	x6sC7J+Xw0FJ1HMXzwOhd/Y+2L5P3mx8MYz+3auh0tthKr9Wbxcb2jG2FK9hUWSb2kfcIhcUduz
	Jw1/JSNUstslYlyrMf6i13Od/RzNmaK614xZ7XO7Z/0Xxd3YDLbyM+0jmVsvyvOs1ocp196bDLX
	tD//HAYeRI5JJOMk0H1xsQ3wt7iFIRaw9Ku6LD13LwGRbXHGLhLJN7YhxzWI+s0=
X-Google-Smtp-Source: AGHT+IHOrjZS1paIhIjegZLUGkeyrRsAjdCxQKrIIghn/CAB6rlyloEkKwF3eVSLKYAOJohiuXYk9Q==
X-Received: by 2002:a05:6214:76a:b0:6d8:5642:d9dc with SMTP id 6a1803df08f44-6e42fbc2d4emr39099736d6.11.1738770461558;
        Wed, 05 Feb 2025 07:47:41 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e4228b176esm21066776d6.100.2025.02.05.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:47:41 -0800 (PST)
Date: Wed, 05 Feb 2025 10:47:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67a3881cd3846_14e083294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250204183024.87508-10-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-10-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v8 09/12] bpf: support SCM_TSTAMP_ACK of
 SO_TIMESTAMPING
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
> can work, but Introducing a new txstamp_ack_bpf to avoid cache

repeat comment: s/Introducing/introduce

> line misses in tcp_ack_tstamp() is needed. To be more specific,
> in most cases, normal flows would not access skb_shinfo as
> txstamp_ack is zero, so that this function won't appear in the
> hot spot lists. Introducing a new member txstamp_ack_bpf works
> similarly.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/net/tcp.h              | 3 ++-
>  include/uapi/linux/bpf.h       | 5 +++++
>  net/core/skbuff.c              | 3 +++
>  net/ipv4/tcp_input.c           | 3 ++-
>  net/ipv4/tcp_output.c          | 5 +++++
>  tools/include/uapi/linux/bpf.h | 5 +++++
>  6 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 293047694710..88429e422301 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -959,9 +959,10 @@ struct tcp_skb_cb {
>  	__u8		sacked;		/* State flags for SACK.	*/
>  	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
>  	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
> +			txstamp_ack_bpf:1,	/* ack timestamp for bpf use */
>  			eor:1,		/* Is skb MSG_EOR marked? */
>  			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
> -			unused:5;
> +			unused:4;
>  	__u32		ack_seq;	/* Sequence number ACK'd	*/
>  	union {
>  		struct {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4c3566f623c2..800122a8abe5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7047,6 +7047,11 @@ enum {
>  					 * timestamp that hardware just
>  					 * generates.
>  					 */
> +	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs in the
> +					 * same sendmsg call are acked
> +					 * when SK_BPF_CB_TX_TIMESTAMPING
> +					 * feature is on.
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 264435f989ad..a8463fef574a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5579,6 +5579,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
>  		if (!sw && hwtstamps)
>  			*skb_hwtstamps(skb) = *hwtstamps;
>  		break;
> +	case SCM_TSTAMP_ACK:
> +		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
> +		break;
>  	default:
>  		return;
>  	}
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 62252702929d..c8945f5be31b 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3323,7 +3323,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
>  	const struct skb_shared_info *shinfo;
>  
>  	/* Avoid cache line misses to get skb_shinfo() and shinfo->tx_flags */
> -	if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
> +	if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
> +		   !TCP_SKB_CB(skb)->txstamp_ack_bpf))

Here and elsewhere: instead of requiring multiple tests, how about
extending txstamp_ack to a two-bit field, so that a single branch
suffices.

>  		return;
>  
>  	shinfo = skb_shinfo(skb);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 695749807c09..fc84ca669b76 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1556,6 +1556,7 @@ static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int de
>  static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
>  {
>  	return TCP_SKB_CB(skb)->txstamp_ack ||
> +	       TCP_SKB_CB(skb)->txstamp_ack_bpf ||
>  		(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
>  }
>  
> @@ -1572,7 +1573,9 @@ static void tcp_fragment_tstamp(struct sk_buff *skb, struct sk_buff *skb2)
>  		shinfo2->tx_flags |= tsflags;
>  		swap(shinfo->tskey, shinfo2->tskey);
>  		TCP_SKB_CB(skb2)->txstamp_ack = TCP_SKB_CB(skb)->txstamp_ack;
> +		TCP_SKB_CB(skb2)->txstamp_ack_bpf = TCP_SKB_CB(skb)->txstamp_ack_bpf;
>  		TCP_SKB_CB(skb)->txstamp_ack = 0;
> +		TCP_SKB_CB(skb)->txstamp_ack_bpf = 0;
>  	}
>  }
>  
> @@ -3213,6 +3216,8 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
>  		shinfo->tskey = next_shinfo->tskey;
>  		TCP_SKB_CB(skb)->txstamp_ack |=
>  			TCP_SKB_CB(next_skb)->txstamp_ack;
> +		TCP_SKB_CB(skb)->txstamp_ack_bpf |=
> +			TCP_SKB_CB(next_skb)->txstamp_ack_bpf;
>  	}
>  }
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 974b7f61d11f..06e68d772989 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7040,6 +7040,11 @@ enum {
>  					 * timestamp that hardware just
>  					 * generates.
>  					 */
> +	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs in the
> +					 * same sendmsg call are acked
> +					 * when SK_BPF_CB_TX_TIMESTAMPING
> +					 * feature is on.
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> -- 
> 2.43.5
> 



