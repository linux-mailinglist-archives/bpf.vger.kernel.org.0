Return-Path: <bpf+bounces-54223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B537A65B64
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C2C175362
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6561A5BBA;
	Mon, 17 Mar 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsw/PHjP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9815746E;
	Mon, 17 Mar 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233706; cv=none; b=KOLF6nuvYRmrNWnWzmy+Um7/Es+LqlNcRW55SKWRtyiIdLzjDG4N3l1y+n3tAOVXBi1RFPpME3hMWmv0kR79vw6dWPH0tptt1iAr+dJanPdBqGD+jz4aYgpVVJg4pT+OS3bdd3liEmeUXtSeT8RbPDlAPbj+vBwA3SJBSx9eqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233706; c=relaxed/simple;
	bh=jANrJGPCyN1ENGofCDsmrdbfDzAVpbWotyj6LZoktuM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tTcVOWV8NeU/E7KJ54rgyd5GAvaQbleTafAaxGt4RGrXLzuBtSudF+ptBjpP74wXZ1h478qDtzUn+nyzaRTJCMiaKti5gsAEdyujytXx2ZDy6XRnFJJ7t4LpEoRz763wPoTtG0aMzitpWMaWGyO+N+IgBxuJz1iFRQF7qiIKQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsw/PHjP; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c04df48a5bso463724285a.2;
        Mon, 17 Mar 2025 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233703; x=1742838503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sOyrPbmXQ63TnutnM3S005YMgSv7BoVvtaZFgKnYWI=;
        b=Xsw/PHjPebMEXiqaef8DHohYV9nIsOghWuBT2BG+/+2GHX2XFfw2orunIZqpO5C7iH
         i6pVcEYcwQmSHTfFWvheaig8FZsLyg7C9zTkTcFLAdwBpPA+aRevR8Iiia4e7I2eF+zP
         e8pSqM/8qo+WPaMZSexDFVn5tjo92r4sbkeRkTI/0gQtqYXRBc63sy7ijPRNP8kBBEyF
         qf1/yAN5eyNhHAh/+TgFBmMWgVYSivPU/dVRY/zF6qCBy5+oXbmbIP4p0m2mZTzlBjhU
         +jzhoCS1Lb4o0/JBzTMZJgfnjrVDkPVspTLI7mXw7aYPWdZgMfpvOhTyfXUVyG9bbvWq
         Xtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233703; x=1742838503;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9sOyrPbmXQ63TnutnM3S005YMgSv7BoVvtaZFgKnYWI=;
        b=vqAe9Yeiqsk1W3vC1veJSZPGLw+9pV2E0zJkguO+a+kBy8JqMEJtTQoaskuikP6wO7
         mZ0W7snq4MoRZELad29jAcirGZde+UYrjzURvvl6HKvz9B6vP3Tw2x76DjNp2ffqq0Rd
         ayfLSmS4bUiihwF/vFokTq/31J5/+g5r+gyHfhiU4w95+Bv5IvJWw58vzGyI2qiRvm67
         V8kyfmW/M0YrUrlryGMmoBLAzsEkkZDCKKDGP5V5B/5KqC842TXOYr6fgqY9uxkMguV8
         N7QG4y7/yUM0v44c10+62+QjM9FLFYFGQb07hrjSa1kxQ6dJ7ilp+eu9I71kZJlDcGUY
         dxkA==
X-Forwarded-Encrypted: i=1; AJvYcCVU6WTH+G7TqJXZmv5SQbJZj8yoMRPAbDdmCM9TUjJIG6LrHXSzXBLL8Ynyyb+O6kCQVaqL3jKG@vger.kernel.org, AJvYcCXm68XTsyQZO40Z6b1cYd5dV+JiiW57pnTNdW/gj5ZK83DGGTdp0dtLEKt+bliWJI2xvUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/MAZhUrIkx2M0HN0AnCdNAQ04v2JmX9IISSKZvsUeWaZYfZ1
	pfUDsAv2DoUr7LYpjB+Lrlj2Rhd9WE9cpkasz+xXfLTniFBWerAm6tWb4g==
X-Gm-Gg: ASbGncs/uxIvH6QDTlAHGaTNzE0yRNzxnZQhLnjMdIphUewljzVoowVE+MSGmrAQjiS
	KGoQHnbpyEOuxFXXvMhLGF2E9NeviPAHWlb7MUU7XYJJJKf3m9ehClTH01TUwAyRY+ywkHZEbew
	Gf01HfGQM7k2JTpzUWK1q3/t7iN8ab4xvJJAd1l4cgItoRH1XG9iKiz+f34gCBSp/FNHe+sumb2
	P3KofulnqkZCr916YV17TuhpY/ZbJB4Xty+yvUDlwNMZmIK2PCdb2r4P0YswepU9wmdw2AeaFDR
	1ObCtQh5MBIPOra93UHYdgX0bwMuVz6wwREWl44JszQPNmRntHm4ocKdMQdYJBZ7wiaJPOQaaWH
	OeSPfMUYrLBMPSnySCNNRAg==
X-Google-Smtp-Source: AGHT+IEGXp1muDUVcEK0ZdbYSu2H9+k7Z3C3YZwsIBz6zjsfJjOkRTJ8WCb3z0KQOQsyiD73wabRPA==
X-Received: by 2002:a05:620a:44c2:b0:7c5:60c7:339 with SMTP id af79cd13be357-7c57c7b99b8mr1750126585a.9.1742233703507;
        Mon, 17 Mar 2025 10:48:23 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9b193sm613925185a.57.2025.03.17.10.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:48:22 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:48:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jordan Rife <jrife@google.com>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Aditi Ghag <aditi.ghag@isovalent.com>
Message-ID: <67d860665588c_32b524294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250313233615.2329869-2-jrife@google.com>
References: <20250313233615.2329869-1-jrife@google.com>
 <20250313233615.2329869-2-jrife@google.com>
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: udp: Avoid socket skips during
 iteration
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jordan Rife wrote:
> Replace the offset-based approach for tracking progress through a bucket
> in the UDP table with one based on unique, monotonically increasing
> index numbers associated with each socket in a bucket.
> 
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>  include/net/sock.h |  2 ++
>  include/net/udp.h  |  1 +
>  net/ipv4/udp.c     | 38 +++++++++++++++++++++++++-------------
>  3 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8036b3b79cd8..b11f43e8e7ec 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -228,6 +228,7 @@ struct sock_common {
>  		u32		skc_window_clamp;
>  		u32		skc_tw_snd_nxt; /* struct tcp_timewait_sock */
>  	};
> +	__s64			skc_idx;
>  	/* public: */
>  };
>  
> @@ -378,6 +379,7 @@ struct sock {
>  #define sk_incoming_cpu		__sk_common.skc_incoming_cpu
>  #define sk_flags		__sk_common.skc_flags
>  #define sk_rxhash		__sk_common.skc_rxhash
> +#define sk_idx			__sk_common.skc_idx
>  
>  	__cacheline_group_begin(sock_write_rx);
>  
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 6e89520e100d..9398561addc6 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -102,6 +102,7 @@ struct udp_table {
>  #endif
>  	unsigned int		mask;
>  	unsigned int		log;
> +	atomic64_t		ver;
>  };
>  extern struct udp_table udp_table;
>  void udp_table_init(struct udp_table *, const char *);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index a9bb9ce5438e..d7e9b3346983 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -229,6 +229,11 @@ static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hslot)
>  	return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
>  }
>  
> +static inline __s64 udp_table_next_idx(struct udp_table *udptable, bool pos)
> +{
> +	return (pos ? 1 : -1) * atomic64_inc_return(&udptable->ver);
> +}

Can this BPF feature be fixed without adding extra complexity and cost
to the normal protocol paths?

