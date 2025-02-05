Return-Path: <bpf+bounces-50513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D174CA294AC
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2556B1889AE9
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46717B505;
	Wed,  5 Feb 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRuijMbo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861D17C79;
	Wed,  5 Feb 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768929; cv=none; b=c1nT6d+WmIpNnzv2p11/CqUR6zun/dN5gcUD9yvVbcAx6ucqoh2ldiKXo2q21MMwu1bUlpWFE7YZu3BYWWrxCCEJuIAwCiRzdCZyA0WP5uCFsLYjf4P1FjWIRCW7lcr1OxzmakGvY8zwYXyT906wtQsKR7cYW7iYWQZVMoFY3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768929; c=relaxed/simple;
	bh=0Msz/rSJUYCKfabmGezpBc/npBw0LDfEK+TxnozhQ7s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oTh6hY7VKPF6PJCGVdOoCPNVVBVPPs++qc79nTEqJYuq6+NYZ84PxHDANSYlrOn+ROBPfkcg40DZQWg9nYrOT6sNxi7us1PBaYT2wXgfj6JgKk7iQg8V+15Lt9I3PPbWwCYP3X+tMGBZdsoAfIr1AIQYUkp1a3jfpYLTnUOSh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRuijMbo; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-866e5a0303dso405448241.1;
        Wed, 05 Feb 2025 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738768926; x=1739373726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZaTXNgiQ+0ml21hW9Pw+HKxlz7vgH5W2AJovcqheVg=;
        b=mRuijMbo7PVHBKaGlQY+lqBb7N0YfGQIaS1dLwK+XcEa7m4z26EOpn3snueRpyOwKP
         n2DpQTaowYFe05qSMxLf7MVcT1qJaUaFZB03flGmO2d+lIsGSbhq1E91S/03SeW4AN9O
         075SnaIuYwb82GhmDVO+jOd5NBZnXcbJVN80h2ewvs+/5VYXVjR4HivlhrXT8AysjfOv
         ik4PBDPqT59lYyJbSaugmrFsY9Wv5kEuWb1JnmdKpovSbIv86OLNAmCTWesPKu0PJ0E6
         XOCm1etO4jv92y2890dCWVf+7QsEkmVlRHjbGRymlZvM5eFFQehUzsOQgaLmw5JRrMW/
         v5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738768926; x=1739373726;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hZaTXNgiQ+0ml21hW9Pw+HKxlz7vgH5W2AJovcqheVg=;
        b=ED/ZWK2PYNTiLUW+TKqwx9QPPWPxW//vhP0DvKK+TEPcY5TT6ar2nzfQS+FZ2wA74l
         RvVOBJlgotqUz0Cf/46diwRNoeY5cEznzVW5+7swOlV5GCwGFMFlnsRPQliUAI22i8Ew
         KhL5NF58SCHaykG0vN2SOymZNysDxCWI5SXO0yqjmEt9H75qF+4bA4a7JMDsOeJWbzkK
         L19r4ItRJ4DtgkynSLAXEFnVd24LjRJw/gY3Dc19zYED6Ll8U0nvsvHo/AgPQHn4AO5V
         PTYrgaEOP0rHmLvmeudvRUVbmpEn4u14XD29COC89hsfKk0bqkv8YtDEHJusRTYtxIdJ
         DZng==
X-Forwarded-Encrypted: i=1; AJvYcCVzRXY5IL2yHkahzoRVIXwL0veKfjJbt5a0itPlMfhaRochHkHMSJb29D8drrdCh/O5CpT6NRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KlZHU9gCTiwjnlILVRedIIFIm4gForL2H2jHmUT65Fo68P9U
	zIRZSeZ8xmSIu3rIhE+xW1AhL0cSrylPq2Z9ZZ9M/PT7fXClOmM6
X-Gm-Gg: ASbGnctMiTVyx3bZKyRtBgG+r4rU+qFMzefL8o1qEgiVS9Z+VYVoJsYU3osjMnxCO1e
	qJYUIx6AYT8pcilAY8ho+jRDsPvwMjXMBQELjvbm/KIykkX4GZ/IMnpYwXNhSF1IMfT4um5Mu1M
	Rue6oiLWkwmV2PGh7zU68IombYFIfDfBv87ChHJYF3f8TiwE8nGFmhYe09cTwIVvJphegLIeOVv
	JrCYWAXq7nHGxAeSbKvKveqQ90BB+0/EQDsCz64t0z5xx4gr8Kl0Vg1pFLjLTs5CbjbzCyF+4Es
	w50ie9wgwD0D28yU4XBe9cUzMBpaJ9TpADZusLPKvaI+nVkX0LfNt27hQg6KBYc=
X-Google-Smtp-Source: AGHT+IG0+ibnrSKmHAO0dURI3gtdZMYOEeYv/DIr0c6F3Yg/OXIHEXbsSB/IAHUS0JQjR6ROOASTbA==
X-Received: by 2002:a05:6102:3c8e:b0:4b2:ae3a:35d6 with SMTP id ada2fe7eead31-4ba47a716f6mr2508104137.19.1738768926334;
        Wed, 05 Feb 2025 07:22:06 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9bad168c0sm2348989137.26.2025.02.05.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:22:05 -0800 (PST)
Date: Wed, 05 Feb 2025 10:22:05 -0500
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
Message-ID: <67a3821d3ae5b_14e0832944c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250204183024.87508-2-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v8 01/12] bpf: add support for bpf_setsockopt()
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
> Users can write the following code to enable the bpf extension:
> int flags = SK_BPF_CB_TX_TIMESTAMPING;
> int opts = SK_BPF_CB_FLAGS;
> bpf_setsockopt(skops, SOL_SOCKET, opts, &flags, sizeof(flags));
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/net/sock.h             |  3 +++
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  net/core/filter.c              | 23 +++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 35 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8036b3b79cd8..7916982343c6 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -303,6 +303,7 @@ struct sk_filter;
>    *	@sk_stamp: time stamp of last packet received
>    *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
>    *	@sk_tsflags: SO_TIMESTAMPING flags
> +  *	@sk_bpf_cb_flags: used in bpf_setsockopt()
>    *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
>    *			   Sockets that can be used under memory reclaim should
>    *			   set this to false.
> @@ -445,6 +446,8 @@ struct sock {
>  	u32			sk_reserved_mem;
>  	int			sk_forward_alloc;
>  	u32			sk_tsflags;
> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> +	u32			sk_bpf_cb_flags;
>  	__cacheline_group_end(sock_write_rxtx);
>  
>  	__cacheline_group_begin(sock_write_tx);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2acf9b336371..6116eb3d1515 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6913,6 +6913,13 @@ enum {
>  	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
>  };
>  
> +/* Definitions for bpf_sk_cb_flags */
> +enum {
> +	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
> +	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
> +					   SK_BPF_CB_TX_TIMESTAMPING
> +};
> +
>  /* List of known BPF sock_ops operators.
>   * New entries can only be added at the end
>   */
> @@ -7091,6 +7098,7 @@ enum {
>  	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
>  	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
>  	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
> +	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
>  };
>  
>  enum {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ec162dd83c4..1c6c07507a78 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5222,6 +5222,25 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
>  	.arg1_type      = ARG_PTR_TO_CTX,
>  };
>  
> +static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
> +{
> +	u32 sk_bpf_cb_flags;
> +
> +	if (getopt) {
> +		*(u32 *)optval = sk->sk_bpf_cb_flags;
> +		return 0;
> +	}
> +
> +	sk_bpf_cb_flags = *(u32 *)optval;
> +
> +	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
> +		return -EINVAL;
> +
> +	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;

I don't know BPF internals that well:

Is there mutual exclusion between these sol_socket_sockopt calls?
Or do these sk field accesses need WRITE_ONCE/READ_ONCE.

> +
> +	return 0;
> +}
> +
>  static int sol_socket_sockopt(struct sock *sk, int optname,
>  			      char *optval, int *optlen,
>  			      bool getopt)
> @@ -5238,6 +5257,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>  	case SO_MAX_PACING_RATE:
>  	case SO_BINDTOIFINDEX:
>  	case SO_TXREHASH:
> +	case SK_BPF_CB_FLAGS:
>  		if (*optlen != sizeof(int))
>  			return -EINVAL;
>  		break;
> @@ -5247,6 +5267,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>  		return -EINVAL;
>  	}
>  
> +	if (optname == SK_BPF_CB_FLAGS)
> +		return sk_bpf_set_get_cb_flags(sk, optval, getopt);
> +
>  	if (getopt) {
>  		if (optname == SO_BINDTODEVICE)
>  			return -EINVAL;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 2acf9b336371..70366f74ef4e 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7091,6 +7091,7 @@ enum {
>  	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
>  	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
>  	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
> +	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
>  };
>  
>  enum {
> -- 
> 2.43.5
> 



