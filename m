Return-Path: <bpf+bounces-50520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D0A29522
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BD81883A2A
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBD518FDA5;
	Wed,  5 Feb 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVd3gtBV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C516DC28;
	Wed,  5 Feb 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770322; cv=none; b=pfV+GBW7ylE7PwRzGXWsXxoqRtM0VPtJ3xt0YNxeJw5Ke4NFPhjpp+SocK3b07hwpbYrwBjT0Aa2Bf1wgJ/KRfv71sbZi+uGILMeVLUn/Ue1ajdp8D0iIGEXLYIZNekoMFboH+KWpqdy68TXc3369LMaIgM/yEN5PqufNqICAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770322; c=relaxed/simple;
	bh=WNexLnhvXI/cYkCoTcvwSZ9lTnq0nYYrYJ74L5mnogE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=e2Fk1vYVESFqKJfKSVqk/F9xWgabcx92B4NB9Z5vRIKjW2bHYOWL1c/OHtuarSX6OGW/BAgwluK8KXOaWUry2PEuJhqDhngb3X+XQagXx8RTIZMX806kCqgRGBhGss3bKPokAxFzdt0VMw53gg0tkVtg/asiB32gyJw49pWX+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVd3gtBV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6f95d2eafso720724385a.3;
        Wed, 05 Feb 2025 07:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738770320; x=1739375120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo3Xf90QQLwGqoomfT9hwt9eW5NSAcc/F4Rk1wRCQYE=;
        b=gVd3gtBVl5j/iVl9e338yWEUdgC5/dmfBl4iHfthjt/O23pqdWN7qOWrx9T26ApUhF
         Uq4GRUCAVq6G41JOIuFJ3DYhD68gSw6Gn1QIgp0f8XnuCj/lla1uf8ysHCrArJSrWXpr
         9LHX8HRjSu6bX3R+x9TYINX04AkGm/MOlu8LUlnlIEP7LLs/E+bR5dJk3ibp3RhyPd2M
         G4hrFhjSRv5191OTl2w4ru7G6HgYeuHX8Hqk6aL1sjBN2tVZ422+aHKvY//vGupSYM62
         A0NUurfsheLR58p6e1kOoWKr4ISKsu3g1AEKLZ6+WFoWt+8U2/kU22uw4x/2Evk/k8O6
         rsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770320; x=1739375120;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zo3Xf90QQLwGqoomfT9hwt9eW5NSAcc/F4Rk1wRCQYE=;
        b=vRUdW3fFSy+bAebAMfAMy+91oyOsS0M2okQhu0TsaQM87Qa2hX044WYLc40i+o532K
         wnL+RrN1oJ9iuDGg072/tBiRVZhgG6UhEAnDS2eTRcTQcsN9/Fxn30JJovL8PrpKb52b
         2/e+54YnheHa6Xrj5smfVJTvZpAdpJfbuMKX6OAtShdrj0bXr9wX+QeIQhTtB6SMJF8r
         5O9dQIUpa3VVb5jThRvYOHy64lGyE9urjTn+8JODzJB52Kfw41TX0YlFeieVxiMyONxh
         jcLd/QGpRKtNXQYSREHUYxZUbv2XQ1XzQUOd6FqxS/DfoDUGKlMN7usbYF50Cr5GnBMN
         zQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8GX71ybN5fK0VqFKG8rd+gxYj1cM3tEAM8+H2gsIfw8oDMcP4qAXeMaabBkTpI7bX9k72N8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTkuvP/2013+la+dAUM7iy2wwXxzoVQoVxMwMZ8lnCk04SOjf
	8Q/PMRpZM9Brce/1M553CvfHORo9zIhK2D/1MxPeAL6j3Q/53ny3
X-Gm-Gg: ASbGncue1B7/E4LLIWmLPw1lUlGhVO1a/gD+qh/yKoNMr07uFOWwQIAEmbRYJwOYjjb
	4b5WBr+W08QRbaLw887mR2UTby7vkPiXvKKWZix/6qL5u5jNo0TQr5rPNzfAdu7h5jsmFo7QoCC
	DMSC29YCbjbkW3NBh9zs39aYzKvpLDRPBXrubfM5oEX3O04ghiv7uEi1r1bAaCXhvPuIDX1eUQK
	fRrEPdpjIw7eybpNcVB9kjWqtKQUHAU8eK7PyOamqbyr72VbBfJBvnnlG+8XJnD/g7/2A6L1YVb
	FP7AdXWEWMgAL2GGUm2iZme8TVgqZ5G+4N0JBJyV8ZNMz6gOvcEWY58PsgtsiVc=
X-Google-Smtp-Source: AGHT+IGLp/u0OqPzrnSrS45uHxoaZ2nFCou/BnFxVnQNF7SGVXnmncpDZkcFjvv/oTtEkyvJpSmTWA==
X-Received: by 2002:a05:620a:294e:b0:7b6:da21:751c with SMTP id af79cd13be357-7c039fa9445mr327220885a.11.1738770319752;
        Wed, 05 Feb 2025 07:45:19 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9055adsm770903185a.73.2025.02.05.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:45:19 -0800 (PST)
Date: Wed, 05 Feb 2025 10:45:18 -0500
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
Message-ID: <67a3878eaefdf_14e08329415@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250204183024.87508-9-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-9-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v8 08/12] bpf: support hw SCM_TSTAMP_SND of
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
> Patch finishes the hardware part.

For consistency with previous patches, and to make sense of this
commit message on its own, when stumbling on it, e.g., through
git blame, replace the above with

Support hw SCM_TSTAMP_SND case. 

> Then bpf program can fetch the
> hwstamp from skb directly.
> 
> To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
> use this simple modification like this patch does to support printing
> hardware timestamp.

Which simple modification? Please state explicitly.
 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/linux/skbuff.h         |  4 +++-
>  include/uapi/linux/bpf.h       |  7 +++++++
>  net/core/skbuff.c              | 13 +++++++------
>  net/dsa/user.c                 |  2 +-
>  net/socket.c                   |  2 +-
>  tools/include/uapi/linux/bpf.h |  7 +++++++
>  6 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index de8d3bd311f5..df2d790ae36b 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -471,7 +471,7 @@ struct skb_shared_hwtstamps {
>  /* Definitions for tx_flags in struct skb_shared_info */
>  enum {
>  	/* generate hardware time stamp */
> -	SKBTX_HW_TSTAMP = 1 << 0,
> +	__SKBTX_HW_TSTAMP = 1 << 0,

Perhaps we can have a more descriptive name. SKBTX_HW_TSTAMP_NOBPF?

>  
>  	/* generate software time stamp when queueing packet to NIC */
>  	SKBTX_SW_TSTAMP = 1 << 1,
> @@ -495,6 +495,8 @@ enum {
>  	SKBTX_BPF = 1 << 7,
>  };
>  
> +#define SKBTX_HW_TSTAMP		(__SKBTX_HW_TSTAMP | SKBTX_BPF)
> +
>  #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
>  				 SKBTX_SCHED_TSTAMP | \
>  				 SKBTX_BPF)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6a1083bcf779..4c3566f623c2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7040,6 +7040,13 @@ enum {
>  					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
>  					 * feature is on.
>  					 */
> +	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
> +					 * SK_BPF_CB_TX_TIMESTAMPING feature
> +					 * is on. At the same time, hwtstamps
> +					 * of skb is initialized as the
> +					 * timestamp that hardware just
> +					 * generates.

"hwtstamp of skb is initialized" is this something new? Or are you
just conveying that when this callback is called, skb_hwtstamps(skb)
is non-zero? If the latter, drop, because the wording is confusing.

> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b22d079e7143..264435f989ad 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5548,7 +5548,7 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
>  		flag = SKBTX_SCHED_TSTAMP;
>  		break;
>  	case SCM_TSTAMP_SND:
> -		flag = sw ? SKBTX_SW_TSTAMP : SKBTX_HW_TSTAMP;
> +		flag = sw ? SKBTX_SW_TSTAMP : __SKBTX_HW_TSTAMP;
>  		break;
>  	case SCM_TSTAMP_ACK:
>  		if (TCP_SKB_CB(skb)->txstamp_ack)
> @@ -5565,7 +5565,8 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
>  }
>  
>  static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
> -			      int tstype, bool sw)
> +			      int tstype, bool sw,
> +			      struct skb_shared_hwtstamps *hwtstamps)
>  {
>  	int op;
>  
> @@ -5574,9 +5575,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
>  		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>  		break;
>  	case SCM_TSTAMP_SND:
> -		if (!sw)
> -			return;
> -		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
> +		op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
> +		if (!sw && hwtstamps)
> +			*skb_hwtstamps(skb) = *hwtstamps;

Isn't this called by drivers that have actually set skb_hwtstamps?
>  		break;
>  	default:
>  		return;
> @@ -5599,7 +5600,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  
>  	/* bpf extension feature entry */
>  	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> -		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw);
> +		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw, hwtstamps);
>  
>  	/* application feature entry */
>  	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 291ab1b4acc4..ae715bf0ae75 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_user_priv *p,
>  {
>  	struct dsa_switch *ds = p->dp->ds;
>  
> -	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> +	if (!(skb_shinfo(skb)->tx_flags & __SKBTX_HW_TSTAMP))
>  		return;
>  
>  	if (!ds->ops->port_txtstamp)
> diff --git a/net/socket.c b/net/socket.c
> index 262a28b59c7f..70eabb510ce6 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
>  	u8 flags = *tx_flags;
>  
>  	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
> -		flags |= SKBTX_HW_TSTAMP;
> +		flags |= __SKBTX_HW_TSTAMP;
>  
>  		/* PTP hardware clocks can provide a free running cycle counter
>  		 * as a time base for virtual clocks. Tell driver to use the
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 9bd1c7c77b17..974b7f61d11f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7033,6 +7033,13 @@ enum {
>  					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
>  					 * feature is on.
>  					 */
> +	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
> +					 * SK_BPF_CB_TX_TIMESTAMPING feature
> +					 * is on. At the same time, hwtstamps
> +					 * of skb is initialized as the
> +					 * timestamp that hardware just
> +					 * generates.
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> -- 
> 2.43.5
> 



