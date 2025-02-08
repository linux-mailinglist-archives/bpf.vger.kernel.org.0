Return-Path: <bpf+bounces-50871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01410A2D7DD
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 18:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5793A7E32
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDAA1922F8;
	Sat,  8 Feb 2025 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG8vSLRV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32084241103;
	Sat,  8 Feb 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739037252; cv=none; b=AsoET0MCC8rbc23Wvw/my4BDvQ6mhK6eAKIV/iAZYTCYybOUsQMcQK/P/6ztBkqJxsR/G6wJKSsaD+vslHfFqpMGi26uu6NDL5KG/hT7rDXFDjO+mEK0aQtNP1J+c1uhyELYwEdHzik+mh/l/Kontu//dorxAfhd4OF8Z8dN1G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739037252; c=relaxed/simple;
	bh=0PVro0gUVvzQBouIK3AlBAd02LKCtyxzRT/S3wUsjZA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G7BcVcN3sQAR4KuRypikuW/+AsWKFalmHyTRj3a3Z6pVQxef4la+kxV6sAIsUzzMQQq+Qiwkvxfb92KqkxmVhw3x8Yte95u0ifYeq4/yAZky7q2kQSSLGgvIfmL24ypyRD0PK952sK9HES1pcwl6axfoarUZjYzIL6uK1Am+x/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG8vSLRV; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5203149c8e9so296903e0c.3;
        Sat, 08 Feb 2025 09:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739037250; x=1739642050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODPfWA5FJeQXJ9Sg2qOFReyedtyHAGRXFc0zVluYrzg=;
        b=dG8vSLRVse3Jwn2MaU+sNmmbrYkDRaurp0FEHBP9s9+U2yPyQV+y7oyv+nfZFlggLv
         +IgUa4U13V0eFFh1WSewIzmW4yfj90M90EPCarG1xrmbAPTEQpJCBd8+PK7+u/qPLc6u
         FaFcsGTIgHkBqyXB0EocDVkCqrfbLgVObkJNkLtHGhAuLyqueZ7PFXQ52bfaNb9TtAFt
         WADxMbW6/nwY4/lGKac5xOSEJ5AsNB/SYifuJk1sq69tgvhWZsuF3LjrCJaDwvyeeK5F
         3/2tBFG8d0dg2yJHXmGjEV1+o49v5tuOGKmNBHBmlUjq9nP4X/BnPqUJWF/+qayyPgiu
         O8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739037250; x=1739642050;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODPfWA5FJeQXJ9Sg2qOFReyedtyHAGRXFc0zVluYrzg=;
        b=aIyaA52j7fRPU/eSM5xgigfysD/J+4IEbE4aEFHL6/1HcAp6ljylkrIMz5fV3fl4AO
         MR5KF1jeDGG4f5iLufzz331+dg3u7Ybx8jE6uMvhJ65kvyLyF1Ixq0L5qGJM2xFBxbqh
         xkekAEXhuGw8iwdgna4rr25Tm58koK80lV2CK06uPs9L5MH/2NywuZ81YfSIkXHaY+sb
         u3MXbyezGdcM8QqwdutT5mWyqMKl2lT5NQxUnrXEuiuwoSJ3U2Wv4k5wlBhZY+Z0D4Wy
         TYMDFH3yKYLR+SDs88iAJjn2vPiKqGofidsq1RjJ3yxSxfO5AcbZX5sfOSIqqlryVwzc
         /K2A==
X-Forwarded-Encrypted: i=1; AJvYcCV2w1amRv8REAoBmh6obtmLisg5adaVvQ0PrgkkLOA4oSrRXugDJO8e8RZuG7SJBXITcztxr+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1GRgWdmlL57xqJ3WXUOPqSVnn4SQqFUwtOzK9YXfQwwrRqMr
	Vnvt1jHdmHBhcWpyz4YmUhLdup1EUDK06i2+YIaCPixwdapwXd8E
X-Gm-Gg: ASbGncskgl9VswHRsn9eUhM/wdDmRAIok7y995pHfaBcEw3vq3T9YV4yiq7a0cqdIZJ
	GrpsM1RRsrd2NaLAIIw8WKR45tCmsRHFu2UyOmxAbTPjZ+8x2z1Lz6RseYY+d85tXlQ7G3jbOZX
	y9uqEfCZKO66FCj3vzxnVFHSg9xb8h5D4rZy2Ekunus4SMELHgeOzitLUIYGPkI2LNNkcStVsZn
	zxxNu4O92JYAa6eHNu0QGPU1Up1iKDdpF8TWahN8xIqIzZob2oIczjq0NCiKzZ0HP3pOy3+DXGf
	fyrupuR1JQ8yiHqawQlB4F5ZX2wQc3krrUixvp2cz8Z6c63MOyNH9U/8tMzB2og=
X-Google-Smtp-Source: AGHT+IEcLY7ddFVQUmNxx2h+FkAFQSBCaYaYdcSHuQilYwtT+Wlfbvh9FGx/CBfBEiPsJZUX5+wzBQ==
X-Received: by 2002:a05:6122:54f:b0:518:89d9:dd99 with SMTP id 71dfb90a1353d-51f2e0de362mr6503768e0c.3.1739037249838;
        Sat, 08 Feb 2025 09:54:09 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866f9685897sm1062224241.14.2025.02.08.09.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 09:54:08 -0800 (PST)
Date: Sat, 08 Feb 2025 12:54:07 -0500
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
Message-ID: <67a79a3f9c7ed_3488ef294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250208103220.72294-10-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-10-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v9 09/12] bpf: support SCM_TSTAMP_ACK of
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
> Support the ACK timestamp case. Extend txstamp_ack to two bits:
> 1 stands for SO_TIMESTAMPING mode, 2 bpf extension. The latter
> will be used later.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/net/tcp.h              | 4 ++--
>  include/uapi/linux/bpf.h       | 5 +++++
>  net/core/skbuff.c              | 5 ++++-
>  tools/include/uapi/linux/bpf.h | 5 +++++
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4c4dca59352b..ef30f3605e04 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -958,10 +958,10 @@ struct tcp_skb_cb {
>  
>  	__u8		sacked;		/* State flags for SACK.	*/
>  	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
> -	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
> +	__u8		txstamp_ack:2,	/* Record TX timestamp for ack? */
>  			eor:1,		/* Is skb MSG_EOR marked? */
>  			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
> -			unused:5;
> +			unused:4;
>  	__u32		ack_seq;	/* Sequence number ACK'd	*/
>  	union {
>  		struct {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e71a9b53e7bc..c04e788125a7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7044,6 +7044,11 @@ enum {
>  					 * SK_BPF_CB_TX_TIMESTAMPING feature
>  					 * is on.
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
> index ca1ba4252ca5..c0f4d6f6583d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5549,7 +5549,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
>  		return skb_shinfo(skb)->tx_flags & (sw ? SKBTX_SW_TSTAMP :
>  						    SKBTX_HW_TSTAMP_NOBPF);
>  	case SCM_TSTAMP_ACK:
> -		return TCP_SKB_CB(skb)->txstamp_ack;
> +		return TCP_SKB_CB(skb)->txstamp_ack == 1;

For the two to coexist, this should be txstamp_ack & 1

And in the patch that introduces the BPF bit, txstamp_ack |= 2, rather than txstamp_ack = 2.

And let's define labels rather than use constants directly: 

  #define TSTAMP_ACK_SK  0x1
  #define TSTAMP_ACK_BPF 0x2

