Return-Path: <bpf+bounces-50516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9454A2950B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42603AC784
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F1194A44;
	Wed,  5 Feb 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok6fPt9r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2D5B211;
	Wed,  5 Feb 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769646; cv=none; b=D6abL1XGtBKcz06cL6wrMJxAxqY8oSqaCIUQNzBkj9IHTveM+526koTCnEVATNcLLlXdm8qVhwPe/1Dgrc4al5ALpRMLJ69rfPmkvV/wBTEt8+iTREfXwPPzxka9SzFVlbPf6bk93iIYzueXShaVPOzXp8XG4iqoNI7Y9wckQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769646; c=relaxed/simple;
	bh=jeQVnHV/TXthSqBG7JGEjui5gTxt2bFLOfJARfhafv0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sXyg21mu7GgWl6hS0DlSo2CNgMOe06r4Rpaf7zNCtAWsap937hLwSqLb+m56YBNole8ud+BqdhZVIGEWYh4JbnxZcmHpZeCnNDySYOLKA2BEgkTLUFFqEMCPw7rYLogWt2P9zsrHWyj/luC70FoyXwoIj5tpA4YG4KMJ4hTGsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok6fPt9r; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0155af484so667420285a.0;
        Wed, 05 Feb 2025 07:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738769643; x=1739374443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQs4elm7mEJwMqjnW83VUlhtgzg+Yl5voVHq9zPYdDc=;
        b=Ok6fPt9rJLcERNLNmQHI7OOVhUmNMhZmk6DyklTx4dxeD/oy63Wj/JIgcimBRlhIH1
         8rjM3hhxM3knc8EXQ4S03VLoa78O48SzarceGdQdVgn1y7Nce8PTbvgz9tfAPf00eiSy
         xhsz8A/l4TnDUevDo4R/yzWoY7GcxLoNACW4bjaJgXINCnA80duG7yn981iK6OtU7a0J
         L2Nz8FICC/n5e3/OKU7RxFH+M7ndhMn8XeFQdkEobn3PobI0yWqG+2rQgjW46TZnsZLJ
         YwcR4r/wJk/wKuKX/3UPoay9dENabbxuXKrKfMlqmnQ2uaRLSlmn1In+S+Nz5baSqU6K
         FkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738769643; x=1739374443;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQs4elm7mEJwMqjnW83VUlhtgzg+Yl5voVHq9zPYdDc=;
        b=ehM4gzz/8Bod2mILiI9kN1ehM0U1Pk/rqWhX751CfLxNacn5xNSzn1QUY3LSCiXNxc
         wLgg26v/+AiOzKK32Y6qaO+5W/mkiSz+AcQMoy+5hx1OW9o6AHSVApQTkXtF2pLnoyH2
         ac4c32DKq77EVLwVL7EgNWU9f2A1WBhKNrJ3P84LAFM2g13HJw9h0/V058PWOU17eXOd
         4SBI+KdAG/Rv+SNLe03q0tpwCOuJy4QdO2WAUiMhsTY9g+ImLsktNYig8nHjIrXsFx3e
         kGOYuKTkRuUL9w4T9Qx7f4lt5AD0agSWYZSPVe3KkW9l1Um4ENJUXkQ7DoLApVIXikLD
         /P7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcGJsW3AuGgqbb9djde9eekHifq4jEDnVr4QurxtceBrXVWoeAK0PMBU0MUBmhvbtaI2I4C6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUyBNZhv5rSONucVP1SiawGKeoXvGnW2QW/rI5MFwauOtZw3Na
	DvGAKOILtrirWWh+QWcN9EddMr+bKyfSWeddi6K7ywq/9GLD9b1q
X-Gm-Gg: ASbGncsuVh78ytZqbmekLRmfCpp+PXQt+a8rkOaTAXt/KCQo+ocLa7P5s3/9ot4A4Mn
	97y6rzHPQPRwe12FNm8FZiNZT/NC89aJd+t6kkXW4p+0Ok2q0DKtz32dI9/btZkgWbWW4KPRJss
	SjK7XIjoXg8BJEBtrY0ZeyifcmJYGjpQlGVFx0Av5SzwXmSw2oxMVVSG8hd9pojVC4hGHhIFU0H
	YBYOXfXBDDNOKf/HgtuuWBV+jzpFW9Ou0BgirN6sXbIQzy+m1doxwcfaUN+H2i+i2N02AVxRzGM
	p6SIyLN/63aNOWdx3QZZYlaVZs1W5QJ2PkhUvKOTfXjXscfTTUYISWDpvwjND/Q=
X-Google-Smtp-Source: AGHT+IExuk8vpU/fV3fsFTNnqO942A2M9RiUdEdKgZPnCPxf/7zIhjSXbtW9Ry/tRrgPuyHEtAFrIA==
X-Received: by 2002:a05:620a:28cd:b0:7b1:52a9:ae1d with SMTP id af79cd13be357-7c039fa3936mr528111085a.6.1738769642946;
        Wed, 05 Feb 2025 07:34:02 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90ef8esm762272285a.113.2025.02.05.07.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:34:02 -0800 (PST)
Date: Wed, 05 Feb 2025 10:34:02 -0500
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
Message-ID: <67a384ea2d547_14e0832942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250204183024.87508-6-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-6-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
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
> No functional changes here, only add skb_enable_app_tstamp() to test
> if the orig_skb matches the usage of application SO_TIMESTAMPING
> or its bpf extension. And it's good to support two modes in
> parallel later in this series.
> 
> Also, this patch deliberately distinguish the software and
> hardware SCM_TSTAMP_SND timestamp by passing 'sw' parameter in order
> to avoid such a case where hardware may go wrong and pass a NULL
> hwstamps, which is even though unlikely to happen. If it really
> happens, bpf prog will finally consider it as a software timestamp.
> It will be hardly recognized. Let's make the timestamping part
> more robust.

Disagree. Don't add a crutch that has not shown to be necessary for
all this time.

Just infer hw from hwtstamps != NULL.
 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/linux/skbuff.h | 13 +++++++------
>  net/core/dev.c         |  2 +-
>  net/core/skbuff.c      | 32 ++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_input.c   |  3 ++-
>  4 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..dfc419281cc9 100644
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
> @@ -4533,18 +4534,18 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>  
>  void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *ack_skb,
>  		     struct skb_shared_hwtstamps *hwtstamps,
> -		     struct sock *sk, int tstype);
> +		     struct sock *sk, bool sw, int tstype);
>  
>  /**
> - * skb_tstamp_tx - queue clone of skb with send time stamps
> + * skb_tstamp_tx - queue clone of skb with send HARDWARE timestamps

Unfortunately this cannot be modified to skb_tstamp_tx_hw, as that
would require updating way too many callers.

>   * @orig_skb:	the original outgoing packet
>   * @hwtstamps:	hardware time stamps, may be NULL if not available
>   *
>   * If the skb has a socket associated, then this function clones the
>   * skb (thus sharing the actual data and optional structures), stores
> - * the optional hardware time stamping information (if non NULL) or
> - * generates a software time stamp (otherwise), then queues the clone
> - * to the error queue of the socket.  Errors are silently ignored.
> + * the optional hardware time stamping information (if non NULL) then
> + * queues the clone to the error queue of the socket.  Errors are
> + * silently ignored.
>   */
>  void skb_tstamp_tx(struct sk_buff *orig_skb,
>  		   struct skb_shared_hwtstamps *hwtstamps);
> @@ -4565,7 +4566,7 @@ static inline void skb_tx_timestamp(struct sk_buff *skb)
>  {
>  	skb_clone_tx_timestamp(skb);
>  	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> -		skb_tstamp_tx(skb, NULL);
> +		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SND);

If a separate version for software timestamps were needed, I'd suggest
adding a skb_tstamp_tx_sw() wrapper. But see first comment.

>  }
>  
>  /**
> diff --git a/net/core/dev.c b/net/core/dev.c
> index afa2282f2604..d77b8389753e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4501,7 +4501,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  	skb_assert_len(skb);
>  
>  	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> -		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
> +		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SCHED);
>  
>  	/* Disable soft irqs for various locks below. Also
>  	 * stops preemption for RCU.
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a441613a1e6c..6042961dfc02 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5539,10 +5539,35 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>  
> +static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)

app is a bit vague. I suggest

skb_tstamp_tx_report_so_timestamping

and

skb_tstamp_tx_report_bpf_timestamping

> +{
> +	int flag;
> +
> +	switch (tstype) {
> +	case SCM_TSTAMP_SCHED:
> +		flag = SKBTX_SCHED_TSTAMP;
> +		break;

Please just have a one line statements in the case directly:

    case SCM_TSTAMP_SCHED:
        return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
    case SCM_TSTAMP_SND:
        return skb_shinfo(skb)->tx_flags & (sw ? SKBTX_SW_TSTAMP :
                                                 SKBTX_HW_TSTAMP);
    case SCM_TSTAMP_ACK:
        return TCP_SKB_CB(skb)->txstamp_ack;

> +	case SCM_TSTAMP_SND:
> +		flag = sw ? SKBTX_SW_TSTAMP : SKBTX_HW_TSTAMP;
> +		break;
> +	case SCM_TSTAMP_ACK:
> +		if (TCP_SKB_CB(skb)->txstamp_ack)
> +			return true;
> +		fallthrough;
> +	default:
> +		return false;
> +	}
> +
> +	if (skb_shinfo(skb)->tx_flags & flag)
> +		return true;
> +
> +	return false;
> +}
> +
>  void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  		     const struct sk_buff *ack_skb,
>  		     struct skb_shared_hwtstamps *hwtstamps,
> -		     struct sock *sk, int tstype)
> +		     struct sock *sk, bool sw, int tstype)
>  {
>  	struct sk_buff *skb;
>  	bool tsonly, opt_stats = false;
> @@ -5551,6 +5576,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  	if (!sk)
>  		return;
>  
> +	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
> +		return;
> +
>  	tsflags = READ_ONCE(sk->sk_tsflags);
>  	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
>  	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
> @@ -5599,7 +5627,7 @@ EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
>  void skb_tstamp_tx(struct sk_buff *orig_skb,
>  		   struct skb_shared_hwtstamps *hwtstamps)
>  {
> -	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk,
> +	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk, false,
>  			       SCM_TSTAMP_SND);
>  }
>  EXPORT_SYMBOL_GPL(skb_tstamp_tx);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 77185479ed5e..62252702929d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3330,7 +3330,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
>  	if (!before(shinfo->tskey, prior_snd_una) &&
>  	    before(shinfo->tskey, tcp_sk(sk)->snd_una)) {
>  		tcp_skb_tsorted_save(skb) {
> -			__skb_tstamp_tx(skb, ack_skb, NULL, sk, SCM_TSTAMP_ACK);
> +			__skb_tstamp_tx(skb, ack_skb, NULL, sk, true,
> +					SCM_TSTAMP_ACK);
>  		} tcp_skb_tsorted_restore(skb);
>  	}
>  }
> -- 
> 2.43.5
> 



