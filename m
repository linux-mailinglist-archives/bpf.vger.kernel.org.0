Return-Path: <bpf+bounces-50519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C4A29518
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2B27A6BFB
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F27197A8B;
	Wed,  5 Feb 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bae+Oojd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C91194A44;
	Wed,  5 Feb 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769781; cv=none; b=Ei9jhnPHviW1I1yjNsenL27Ye+AtapdGUphN5o2HNeTgyOrhtnOBr79Vlg6OVAqYl2yp7s+FPVzLRYPegGEveMCU7YrX5rL1n84+e2HlHeuwDdbut6o7ObszKcb5b4Z0Wo5qVoSuZY+gZt1hhlW++E8tGSzPWzZ9ofeMqk9yexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769781; c=relaxed/simple;
	bh=acd69ybmAaefI2UIi93kjIrlsXXIZefVsb/cQ26qJMg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AxZXcPy/BQcNSetNvwvkftUEYnEhiM7vofirGRR7a+pufePp4b65pdICTHMlKK5X36oQl6B9QBl8O0QmYOE0cgsF8PTtwcLSOl4ceYTh2IIZZW+1VQPgHMrQfZoRe0AgN7Ntt3+TZO/vj6tg+oiPAPR/8lNcnP5If4hHIRLUfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bae+Oojd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7bcf33f698dso651048185a.2;
        Wed, 05 Feb 2025 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738769778; x=1739374578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeD4rvqrlJBnv5BCcpriot1nC9bm/iyvru1yz7lNDKo=;
        b=Bae+OojdPgEzq5e9VzOu3qHhfDugkmos7NiNXgcuUUbQpZi9cUvXB5scesADwHxPa3
         +xwJ2tt48M2587fJlrQ1n0an20voXyyAsUR0n0CFHLPyWR8K1CVuw1BK52Q/n3wnWMQN
         DQfHcsY1sTy2Q6KEKjq3m4cyuFXrsaZENkteQzhpcBDtJZZlXjceDfULrsu8l17KbPoi
         SrQ53gNqIG9O0LFMuiLWW6SkWL6iwoD4U6Ny5o1BXPwwyumTL7bOychHiADhbuN6K4Y/
         wA/UVG+TuvBUzfre4Xxk1LqdMg3IVJcByKpcxdVGQFd1/cef01CToj/MAcd3ky52SN6a
         P75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738769778; x=1739374578;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IeD4rvqrlJBnv5BCcpriot1nC9bm/iyvru1yz7lNDKo=;
        b=J88s2ovsIWX7GvHA20hvOB721kSHPCUqPceV+UdhWigm1Gga70L/gBsglM9xgb0frQ
         KKOjd6snmAxaEGg5Nl+2XH0kbbIUaFi3CVkGYiLxNIp3HDfYrBJJW6C7LVewmG0ZJr/C
         30xaooOFcYDvC7wu20tkeC9bRaWFmxQDmGBP14+aCoMemH9CLCtxCplN0Wwt++op9Uwr
         bQJcP7zxsGXzrhZ4D2PU75t+TIC4/14aHCn+sLqku2HVPGazCjaKfn5CvN+YhguSZXMG
         D36YhB2nkOdsQ68LhMCFphNXGlXU8XPg1RYzmdfYcS6u4z9TZoE0NSZ/uMDj5giATv5f
         fawg==
X-Forwarded-Encrypted: i=1; AJvYcCX8844jArQiv6WfjyhEUAEZZwVebrLbivSKhd3waTCj5M8duC7KWfW+C2F05S1ocq+Cy/aNARk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkbatAbHy6nO8SfSl29x6cujpz1vFzILRbc3gEjwpAmAa5Q0w
	cAv2i4ru+b45S6G6WSqlKA5gnwITaGbU0r05ekeU1YI8kdQO+6GS
X-Gm-Gg: ASbGnctbq1/Dhwt3E53fHENXVJa9T78uKBsVvDLt2QPyt9MAQxjZD7LC1jSvTC8AsWC
	PW/4OSIIHpDYQDTaJ5v0foB4eZuWUSUti9eVsgvsV5Pv+jVgAWbQAPhr6asC+JsJvsQ9P+e/yEX
	9BOWecOr/yN6qkeC6/XtEYGI+CJhFh7EjvQynJWfO8dw5RMuo0rvOp2lQ+GogkX0V5agyJqhcIc
	FC0xewP55fD1hm00earSfEA/SaBRQo3Jz5Re2R0n0UE5ZflKpr+r03qAHJzuD3dib+KmWtJcOL4
	/2nyJP1OLN0NE6QtRjkamK+au8TzfipgNYu9Mb/oZp1StNMJXmnr8eru3jBDD34=
X-Google-Smtp-Source: AGHT+IHNsmuXPiC+5uniGnkvab3UoBYXzBVp9aH0hiNgy+8OJBSghLKMOZPC0VomiOQ2pTg/qOhmjA==
X-Received: by 2002:a05:620a:4713:b0:7b6:6701:7a4d with SMTP id af79cd13be357-7c03a03e074mr531177485a.56.1738769778245;
        Wed, 05 Feb 2025 07:36:18 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d0713sm761951885a.42.2025.02.05.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:36:17 -0800 (PST)
Date: Wed, 05 Feb 2025 10:36:17 -0500
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
Message-ID: <67a385716d03f_14e08329459@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250204183024.87508-7-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-7-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v8 06/12] bpf: support SCM_TSTAMP_SCHED of
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
> Introducing SKBTX_BPF is used as an indicator telling us whether
> the skb should be traced by the bpf prog.

Should this say support the SCM_TSTAMP_SCHED case?

Also: imperative mood: Introduce instead of Introducing.

 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/linux/skbuff.h         |  6 +++++-
>  include/uapi/linux/bpf.h       |  4 ++++
>  net/core/dev.c                 |  3 ++-
>  net/core/skbuff.c              | 20 ++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 ++++
>  5 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index dfc419281cc9..35c2e864dd4b 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -490,10 +490,14 @@ enum {
>  
>  	/* generate software time stamp when entering packet scheduling */
>  	SKBTX_SCHED_TSTAMP = 1 << 6,
> +
> +	/* used for bpf extension when a bpf program is loaded */
> +	SKBTX_BPF = 1 << 7,
>  };
>  
>  #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
> -				 SKBTX_SCHED_TSTAMP)
> +				 SKBTX_SCHED_TSTAMP | \
> +				 SKBTX_BPF)
>  #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
>  				 SKBTX_HW_TSTAMP_USE_CYCLES | \
>  				 SKBTX_ANY_SW_TSTAMP)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6116eb3d1515..30d2c078966b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7032,6 +7032,10 @@ enum {
>  					 * by the kernel or the
>  					 * earlier bpf-progs.
>  					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
> +					 * feature is on.
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d77b8389753e..4f291459d6b1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4500,7 +4500,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  	skb_reset_mac_header(skb);
>  	skb_assert_len(skb);
>  
> -	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> +	if (unlikely(skb_shinfo(skb)->tx_flags &
> +		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
>  		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SCHED);
>  
>  	/* Disable soft irqs for various locks below. Also
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6042961dfc02..b7261e886529 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5564,6 +5564,21 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
>  	return false;
>  }
>  
> +static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
> +{
> +	int op;
> +
> +	switch (tstype) {
> +	case SCM_TSTAMP_SCHED:
> +		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	bpf_skops_tx_timestamping(sk, skb, op);
> +}
> +
>  void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  		     const struct sk_buff *ack_skb,
>  		     struct skb_shared_hwtstamps *hwtstamps,
> @@ -5576,6 +5591,11 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  	if (!sk)
>  		return;
>  
> +	/* bpf extension feature entry */
> +	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> +		skb_tstamp_tx_bpf(orig_skb, sk, tstype);
> +
> +	/* application feature entry */
>  	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
>  		return;
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 70366f74ef4e..eed91b7296b7 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7025,6 +7025,10 @@ enum {
>  					 * by the kernel or the
>  					 * earlier bpf-progs.
>  					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
> +					 * feature is on.
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> -- 
> 2.43.5
> 



