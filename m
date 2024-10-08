Return-Path: <bpf+bounces-41284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF1899570D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E661028B56E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF212139B1;
	Tue,  8 Oct 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ5vvoAC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D4212D2E;
	Tue,  8 Oct 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413108; cv=none; b=HMuCAh9TL9BNP1kia6l9WGw37LTn7+C/wPpSY3mSwdTewi6mpHq6i5ThAA3X08RkxDCD9T75HtDA2eYOneGA4txSG+obtKVp0KO50MIrUo3IKUdgGGPqts4qh6L95SBJDDlnAZ8Bzzi7TcOGL7zf4zhkwVjI+74/q8UFDuAZ8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413108; c=relaxed/simple;
	bh=jIC68F1OC6BbJXpuQwd+KwwM/sirhRMLrwxLvaArtJo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DM0n+wr/CKtLFX0Cb2LeAmsf4Wj9u/07CMNgoLcTHiGFzFRl5f/HOczhADIG6b5leOl86bCOAxCusNd4cJvIfnne6n3gJhcIbUplg7Aw80zmz2t8YXG3TKcgCu9yJb1njkYG1KmXN2J/jpt7dFQITClbcq3VrTEo8LORxsMzYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ5vvoAC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7ac83a98e5eso11145185a.0;
        Tue, 08 Oct 2024 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728413105; x=1729017905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE5V2wMMD5mk5mg1cJWguzVyP8eB7B/SKaHS+bXDjCM=;
        b=XZ5vvoAC3UL4/O8F5RnkOUa7yxyOESMe1vQpjrmwQ97otIsbTaQgh85NaVK1mj4aDV
         RkwirixQLi8AmPeMMc1bdA0P3IzaH89H7XgsDfatgRPgd1LasdGh7jTVSKe2DmDIfr+f
         f8phf1PZn52hmrjgafOWclwTiDPfKTXR+wDh5BEGjPV+C4gcjht91tzusqUBZPAmSbqP
         5iI/2fWlOjAc7kmvoCbEkHA1q4vJkTt/980VLVAJlkImSNppGt0xz61n3TeRV5Ke6crg
         nJPHZSTofEGbZyWbsaDwZ5+Y5sJ2Ly1XMVt7U6QVOUdjcU1CX9B6zQWD/TwpGxeP8t+w
         WvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728413105; x=1729017905;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lE5V2wMMD5mk5mg1cJWguzVyP8eB7B/SKaHS+bXDjCM=;
        b=ek4nv4G5Jj6YGmgYzSYdoYmdN/EPvaBpL3QWoKFHMK1UvmEGDr9IbWvk9Lc6wlHAG9
         XyCPtJM/n/QgTTJKxmIR3UYMsP2oB/J6o/CB7dDkcnY93nKsiEizyKhcXXhWWm1Xsyqu
         hPtcO8N1jpRPqCpY1PMKvRDY+WuZmCXrtMp9kOh+SZNTLuLeiUeD96XQRCYt2MgMwAT0
         ujefV2z47OoW2Wx9fFj9slkBd67okADqKKRsOp7VeJrJIwr3FKWuzlceCKqhZ+pntPp6
         JzRf+8EgxMh8TQn9sJPQJvlVbqIsr+DgqZ9gh1+l/v65JzosZx67W2GdtUI2cU37PZps
         oUbg==
X-Forwarded-Encrypted: i=1; AJvYcCU/wHVB+F2NZ2M4kYaaMgrDSaRc7SjsjVBNJpPatBdw8XhvLkvw4+o/8X4MDTIiG25YONnAyV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGLYBBbDPEcypcMOOZJLKJ70JXGvTq3nPMezzS27GGGogL4x6
	8w6KCElhbBRrQiRrObGPGNG6SkR4o+7hNJ6IEoj4ZExUKrc8DA+P
X-Google-Smtp-Source: AGHT+IHyRhEXXYXfR88grwJWvGrFzTbA6UunAYmsgTJvtiO1dm8ksaiS848o+m5DGqbHn40i4iD5Dg==
X-Received: by 2002:a05:620a:1a1b:b0:7a9:aba6:d00f with SMTP id af79cd13be357-7affafa4fcdmr9585085a.8.1728413105314;
        Tue, 08 Oct 2024 11:45:05 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7566141bsm378168485a.78.2024.10.08.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:45:04 -0700 (PDT)
Date: Tue, 08 Oct 2024 14:45:04 -0400
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
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67057db07a8c6_1a4199294b6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008095109.99918-2-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 1/9] net-timestamp: add bpf infrastructure to
 allow exposing more information later
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
> From: Jason Xing <kernelxing@tencent.com>
> 
> Implement basic codes so that we later can easily add each tx points.
> Introducing BPF_SOCK_OPS_ALL_CB_FLAGS used as a test statement can help use
> control whether to output or not.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/uapi/linux/bpf.h       |  5 ++++-
>  net/core/skbuff.c              | 18 ++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  5 ++++-
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c6cd7c7aeeee..157e139ed6fc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6900,8 +6900,11 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> +	/* Call bpf when the kernel is generating tx timestamps.
> +	 */
> +	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>  };
>  
>  /* List of known BPF sock_ops operators.
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 74149dc4ee31..5ff1a91c1204 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5539,6 +5539,21 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>  
> +static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
> +			      struct skb_shared_hwtstamps *hwtstamps)
> +{
> +	struct tcp_sock *tp;
> +
> +	if (!sk_is_tcp(sk))
> +		return false;
> +
> +	tp = tcp_sk(sk);
> +	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG))
> +		return true;
> +
> +	return false;
> +}
> +
>  void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  		     const struct sk_buff *ack_skb,
>  		     struct skb_shared_hwtstamps *hwtstamps,
> @@ -5551,6 +5566,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  	if (!sk)
>  		return;
>  
> +	if (bpf_skb_tstamp_tx(sk, tstype, hwtstamps))
> +		return;
> +

Eventually, this whole feature could probably be behind a
static_branch.



