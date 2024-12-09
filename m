Return-Path: <bpf+bounces-46398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB899E9920
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A82F166E21
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D11B4230;
	Mon,  9 Dec 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECSQJAVS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069D1ACEC9;
	Mon,  9 Dec 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755039; cv=none; b=aV5g2AgUZjdJ6rUtQJ2muVKw4PIlaX5KMBViTxm/710A17moeg+1NvE2S7dnzZr9Eb9VXEFvZValCuPwYJlTVwYR92z7kK3+DN9bSYeCErG0EsrXzb774EYYgoL5MuEoUhoQGc1HeUjgdm41w6KuHPYsayDpXSHbu7wpx/L7HFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755039; c=relaxed/simple;
	bh=rvJ3c/1uK84Nv79rCi0I1ftRfklw7bWC0zyeI7Bfx2E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i7HuU7x7ZSHU+Jh8jY9DJcToytpyuSuvU/tIe+m3o1gPKOFC0RchEPu/YYB0TeHuYFeKNnjdR/luUNkYc6eT2LtHLxPXUpKqdUdcU14CC2zHj3guwl8laR6L0wg5MWSzWeNpQMARYv7yJbiEgUf9oYFRYyQ3+C/fYuW3kkpA3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECSQJAVS; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d900c27af7so17742096d6.2;
        Mon, 09 Dec 2024 06:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733755036; x=1734359836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23nKt9SwqWfOqPbejNVOg27k3iS3cWj+8lpmLIHCM54=;
        b=ECSQJAVSTs2qDr8AjOqak9mNS+RhD6ZAx3mHdmKSCfUnGdzqAle0Xhzm3/pMvTZbNP
         YD1zS1/cnWi+XB/ljjozuVeBOBZUnCRNwotUJ67GoVk1+insHFFoP0NKm2bqWf8xFqAl
         6zxYkuIelG6cOd140gWEtt3LePtuQYpo94OCbJDsQiHZryQCyhFMlPWU64liUTuO559b
         vtXgF38Av1qhRKuK3Gkzo/vA4E+q1hRBukBSD+ZRzgcmCC0u7OX7W6DmrXo2zLXGii4e
         JngV5HM/RuoMpbfF9R2kWoSg9bvokAu5dZsOxuYa7V6L3y5sIaMmVX68STHtsySaVYru
         vG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755036; x=1734359836;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23nKt9SwqWfOqPbejNVOg27k3iS3cWj+8lpmLIHCM54=;
        b=klrZUXTa61s6z/2PPut4oatSzwc4FpAtpFpiAYTobNCxPauXHn2/C6o9FK1ErYQgW+
         wfZMFAB1LEwrA3HDR2PLpxyz78jhfrK2Jybu7NjXRBnwURXIZLweI7mWAjzEfiaKUwje
         feoNKa7k3oopPzK5H+2I/iL3WZt8+SqF79C/hsJy6hn7weCFfLpbBnznQ01dZvdKQLDG
         FtpZC3nmcW1yJnOBWvY0EzVEzLv+sFyyb9Msa5m04PsfJ67otW4ri0l6PA+xci1OuUu1
         58VkK6AU6hM2sysXI9rDw41r0w3Nsp9QXNXpXimLE6mgksXgq2q3VZuwP1/ZFCBy2f5C
         E/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV7J9gVydA64Wmhrpu5isJAGJ38cXrLQEqGimKwbX6jX3eVrIYE7XFjCY2AsK8XCZT5QxiOgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEE6myN6pmvO7KGZxNcENgvu06Jrg7TiETc988kKP4SqwGF7X
	SIG/D7/lDOXFqx3iGnDsRsPsJHfRTQ6gqVab2dC5RKqZt2/RUgp8
X-Gm-Gg: ASbGncsCYc8mEj5sNY86vlZIOzhMgioA4gUDoXxIr35m2fNhuazaXTp1cUfLTKdC2KN
	EMg3DKqs8OstnrJVtLGjulcEDPD+o8w4lVt0EWowVpt7KadJpE0Oj0iOFlN5i8OPkpFoJtZehr5
	LF+wEodluE4cF2m00T/9ipBxbwRbMBhMkEELxXBZGKe9VuIMn2O7mcogfsJtbU19bxGWgw1INA7
	aBpODD97uNG6vtO06Ol3KmmqjnIAUWd/++D2cCrej+M6gQuCJvfTFkRCFpX4Kw+W8xLprPDY7qk
	zgB6EpjJQ6RE/3hiPWWRwA==
X-Google-Smtp-Source: AGHT+IH2XmPfFVTHLXiw20Wihr2Oq8p6h9GWJmLDn0cE4rTAO0kIQmXezMZTlHoqA8ElEv6M2kWbjQ==
X-Received: by 2002:ad4:5c69:0:b0:6d8:7f8a:73f5 with SMTP id 6a1803df08f44-6d8e71729abmr158823026d6.24.1733755036473;
        Mon, 09 Dec 2024 06:37:16 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66da32sm49656106d6.2.2024.12.09.06.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:37:15 -0800 (PST)
Date: Mon, 09 Dec 2024 09:37:15 -0500
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
Message-ID: <6757009b87461_31657c294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241207173803.90744-4-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v4 03/11] net-timestamp: reorganize in
 skb_tstamp_tx_output()
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
> It's a prep for bpf print function later. This patch only puts the
> original generating logic into one function, so that we integrate
> bpf print easily. No functional changes here.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/linux/skbuff.h |  4 ++--
>  net/core/dev.c         |  3 +--
>  net/core/skbuff.c      | 41 +++++++++++++++++++++++++++++++++++------
>  3 files changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 58009fa66102..53c6913560e4 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -39,6 +39,7 @@
>  #include <net/net_debug.h>
>  #include <net/dropreason-core.h>
>  #include <net/netmem.h>
> +#include <uapi/linux/errqueue.h>
>  
>  /**
>   * DOC: skb checksums
> @@ -4535,8 +4536,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
>  static inline void skb_tx_timestamp(struct sk_buff *skb)
>  {
>  	skb_clone_tx_timestamp(skb);
> -	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> -		skb_tstamp_tx(skb, NULL);
> +	__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND);
>  }
>  
>  /**
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 45a8c3dd4a64..5d584950564b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4350,8 +4350,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  	skb_reset_mac_header(skb);
>  	skb_assert_len(skb);
>  
> -	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> -		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
> +	__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);

This adds a function call in the hot path, as __skb_tstamp_tx is
defined in a .c file.

Currently this is only well predicted branch on a likely cache hot
variable.
>  
>  	/* Disable soft irqs for various locks below. Also
>  	 * stops preemption for RCU.
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6841e61a6bd0..74b840ffaf94 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5539,10 +5539,10 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>  
> -void __skb_tstamp_tx(struct sk_buff *orig_skb,
> -		     const struct sk_buff *ack_skb,
> -		     struct skb_shared_hwtstamps *hwtstamps,
> -		     struct sock *sk, int tstype)
> +static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> +				 const struct sk_buff *ack_skb,
> +				 struct skb_shared_hwtstamps *hwtstamps,
> +				 struct sock *sk, int tstype)
>  {
>  	struct sk_buff *skb;
>  	bool tsonly, opt_stats = false;
> @@ -5594,13 +5594,42 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  
>  	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
>  }
> +
> +static bool skb_tstamp_is_set(const struct sk_buff *skb, int tstype)
> +{
> +	switch (tstype) {
> +	case SCM_TSTAMP_SCHED:
> +		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> +			return true;
> +		return false;
> +	case SCM_TSTAMP_SND:
> +		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP))
> +			return true;

Also true for SKBTX_HW_TSTAMP

> +		return false;
> +	case SCM_TSTAMP_ACK:
> +		if (TCP_SKB_CB(skb)->txstamp_ack)
> +			return true;
> +		return false;
> +	}
> +
> +	return false;
> +}
> +
> +void __skb_tstamp_tx(struct sk_buff *orig_skb,
> +		     const struct sk_buff *ack_skb,
> +		     struct skb_shared_hwtstamps *hwtstamps,
> +		     struct sock *sk, int tstype)
> +{
> +	if (unlikely(skb_tstamp_is_set(orig_skb, tstype)))
> +		skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
> +}
>  EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
>  
>  void skb_tstamp_tx(struct sk_buff *orig_skb,
>  		   struct skb_shared_hwtstamps *hwtstamps)
>  {
> -	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk,
> -			       SCM_TSTAMP_SND);
> +	return skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->sk,
> +				    SCM_TSTAMP_SND);
>  }
>  EXPORT_SYMBOL_GPL(skb_tstamp_tx);
>  
> -- 
> 2.37.3
> 



