Return-Path: <bpf+bounces-27818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 938F58B2442
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4111F23354
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B61C14AD0D;
	Thu, 25 Apr 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1dI3voJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4514A622;
	Thu, 25 Apr 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056171; cv=none; b=AAqBK21NnX8dvcdDZgkzjXAW9YzokXobQxWX2OHJBeeJ6tm17pcMV2tW8obM8gCACsP5cN4ZgV2txIGq7zmNk0URV2CuMPoXGvqoeNEfe2CwruBYCC4skc7dxKWcUM7l/UhDk5ytfUtQwT9M10/PDbe9UacdjCHIndv/33I+97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056171; c=relaxed/simple;
	bh=RLEWmqtBtrpZPVVfXoZ4Fx5SjHlhnjzmtiqohhXwtUc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WY3HHA+qK7NUPbvQojIJLf8ax7/1e4LGVHuDdR/Z7uBe/5Tf02Adkrqpc4k3EOnTm+i1geNbqyPJvMRRYmpR+aTyNP7l3yqe/WcfAflHFCdizQpxR8CJOx5cT2v+X0VtUzYBoDQgXPuwrhcASooHDi7075r6R1xagOobSFyDe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1dI3voJ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c74a75d9adso748181b6e.0;
        Thu, 25 Apr 2024 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714056169; x=1714660969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aCWY+qk5d2DEjGUd6wNU0MLhGO6MuLkRc4d4CIwvHY=;
        b=E1dI3voJcGZbAeG19/sgI4Fs+zzPv+pYt0yKJtYD42EYMkh7rzTceFKmsTpwzr+u7U
         YoQ+i2xLihd8dHzYFt5ulVf26CsEwFeIDLfmgTA7to7x/4CbhT+meUgMRQMh3f+mZA9n
         IIMDo8Kphu8z+mKnP7hEOwhpmCkLrfP9J6TwBDMM1iIBLvbg9gGMpOF2igw+89pUCtv0
         +zkqGPA4KBIT4nWBr+9PBFrvcTgGeNmNvlmaZ/8BFtl1TeuFMk++PugPDo5dQkU8Ym6T
         tCXyvpaDv7+pm+s+rWrs+3vW8JUizC7c7gRhwv3VRWovVoKXx4/c+InlEg9kKiBcxvsr
         3wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714056169; x=1714660969;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7aCWY+qk5d2DEjGUd6wNU0MLhGO6MuLkRc4d4CIwvHY=;
        b=CWYZBx7/2VxguwKalomMtYAsfG12JM/RIeSR7GeFhXpx8ISLTXmWS3oXdqDnwYKgLf
         Y4ThSNl6m9gxHH2ACKaU5COK4q5TIbt+/mPfBZpCdveoHR8WHusCSzfE/AKhVZBh9B5F
         6flSfmYsaf2p+OhihyrAG6x3ptC8zNGuZJOn1B0h0+j0Q1QSanP/5uuu/h13bBPa4c3H
         ZPg88rgbS7LDNI3GC1dKKyWc76O0VC4phVuK4rvDUJgmTW2BqL/1lyPueAb3oW8o/MM4
         T0gnhOOOflwE8ok21FzOb12StmgVwBEm624kqNFQQ3dxsPMvZnreCUFBlJj41G4OChR1
         bNnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhF4Td7Nhy1dCskfTVbdLxiOtt5Y6LIs8IZLFjOk0GkT5MFTq7jbCqYC+IlvFj3CVnczCBIKzw5tt7pm5BMFFJdz5kTYm/PV4rt0NLVegCadZ6VR04+/btOPY1wQzoT7bGt/nHzPBI352Nz8+DpuS22PUp+IhEDElN
X-Gm-Message-State: AOJu0Yx3tL3ruiul1Wlts1IeZExWLzglLdJFfiNXhUQUuH79icilBsFb
	UBNAXr0rm4by3DRLaJbZPpB1NpSBaSoypLfIHg0qegrXAR1WGz0+
X-Google-Smtp-Source: AGHT+IEGjh6A/kbKDvE+IilR4x+Cf/tT5YxgoM6mQWVZhNVQ8L5Oixu8z8lX92bn/hK8t3iZvDVkiA==
X-Received: by 2002:a54:418b:0:b0:3c7:4579:7526 with SMTP id 11-20020a54418b000000b003c745797526mr5515852oiy.59.1714056169233;
        Thu, 25 Apr 2024 07:42:49 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b007907a91e573sm3203565qkk.130.2024.04.25.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:42:48 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:42:48 -0400
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
Message-ID: <662a6be8aed1a_1de39b2946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424222028.1080134-3-quic_abchauha@quicinc.com>
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
 clockid_t timestamp type
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
> tstamp_type is now set based on actual clockid_t compressed
> into 2 bits.
> 
> To make the design scalable for future needs this commit bring in
> the change to extend the tstamp_type:1 to tstamp_type:2 to support
> other clockid_t timestamp.
> 
> We now support CLOCK_TAI as part of tstamp_type as part of this
> commit with exisiting support CLOCK_MONOTONIC and CLOCK_REALTIME.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index e464d0ebc9c1..3ad0de07d261 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -711,6 +711,8 @@ typedef unsigned char *sk_buff_data_t;
>  enum skb_tstamp_type {
>  	SKB_CLOCK_REALTIME,
>  	SKB_CLOCK_MONOTONIC,
> +	SKB_CLOCK_TAI,
> +	__SKB_CLOCK_MAX = SKB_CLOCK_TAI,
>  };
>  
>  /**
> @@ -831,8 +833,8 @@ enum skb_tstamp_type {
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
>   *	@tstamp_type: When set, skb->tstamp has the
> - *		delivery_time in mono clock base Otherwise, the
> - *		timestamp is considered real clock base.
> + *		delivery_time in mono clock base or clock base of skb->tstamp.

drop "in mono clock base or "

> + *		Otherwise, the timestamp is considered real clock base

drop this: whenever in realtime clock base, tstamp_type is zero, so
the above shorter statement always holds.

>   *	@napi_id: id of the NAPI struct this skb came from
>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>   *	@alloc_cpu: CPU which did the skb allocation.
> @@ -960,7 +962,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			tstamp_type:1;	/* See skb_tstamp_type */
> +	__u8			tstamp_type:2;	/* See skb_tstamp_type */
>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;
> @@ -1090,15 +1092,17 @@ struct sk_buff {
>  #endif
>  #define PKT_TYPE_OFFSET		offsetof(struct sk_buff, __pkt_type_offset)
>  
> -/* if you move tc_at_ingress or mono_delivery_time
> +/* if you move tc_at_ingress or tstamp_type:2
>   * around, you also must adapt these constants.
>   */
>  #ifdef __BIG_ENDIAN_BITFIELD
> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
> -#define TC_AT_INGRESS_MASK		(1 << 6)
> +#define SKB_TSTAMP_TYPE_MASK		(3 << 6)
> +#define SKB_TSTAMP_TYPE_RSH		(6)
> +#define TC_AT_INGRESS_RSH		(5)

I had to find BPF_RSH to understand this abbreviation.

use SHIFT instead of RSH, as that is so domain specific?

> +#define TC_AT_INGRESS_MASK		(1 << 5)
>  #else
> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> -#define TC_AT_INGRESS_MASK		(1 << 1)
> +#define SKB_TSTAMP_TYPE_MASK		(3)
> +#define TC_AT_INGRESS_MASK		(1 << 2)
>  #endif
>  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>  

> -	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO) {
> +	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO ||
> +		  skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI) {

Peculiar indentation?

Just FYI that I'm not the best person to review the BPF part.
Thankfully Martin is helping you with that.




