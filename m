Return-Path: <bpf+bounces-59219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C374EAC74CB
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661741891E34
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 00:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAB7A95E;
	Thu, 29 May 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq05mI+E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48810E4;
	Thu, 29 May 2025 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477053; cv=none; b=Gl/2oxQw4vYDU7z5NE+wVe9VCfVwD5u20iUZ13x6Ou93EZCGq6jKdQTo82id3mZTKGotTrX3uc/w4xsIYeZlR+jHebQnZQIeO23YrIreXiRTcGM4xcCzwOah4AwqPohIqAWb650m69FToVGG/IJgd/3aGLJZcgCRguVwCDpDZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477053; c=relaxed/simple;
	bh=oSSHNpPzsj1rOzfn00+b1MZqPrYhvc+fMQvVQmUS18o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT6rh2eTUtX8gNUwpfEenPA7hX2yN5uUNs/AllAeElIhV7+fNDdJtbWiD8jpT/G05srwaAMTPlla9FkSZ8F+ZjtJmfaB5VY5mSyAkA/LbGoPW3YYZcSLRuIdgoRVdiTkDsiV7j2esONTtIJA4YaFGATXnVZmhQJWnUmqV3Nww30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq05mI+E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-231e98e46c0so3629905ad.3;
        Wed, 28 May 2025 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748477051; x=1749081851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ZfYC+HxLPw3qSKUcJstolHkzilJWLIqOV2x8aXzBY=;
        b=Yq05mI+E6sO92cQ0Y/sEDXBiaHoGtzHT4FNhO4PMV/a2sAa1S9R3+nfBz1BHW1Y4OS
         5hYgAPLKVAr1OrgqDglxQAM9R0V44MINnzNTI7Q3TEKbI4sLsFuZlCUY6igswqK4qvrm
         N3eGdn4JlxODV7BbZyX3v+4MEp+UNvcfdaLOjo/kQseVM0n0x+N1oOjj/60s3wKgfQfC
         osW50EUwIbt+SD6h5X9Qg8KmielvzB9DoIZ4QOPAOBTKJ6oBA0UiyWhrNKq2WLHF5CAm
         MefeYSmF+A8YKI8snu5fzgjbsuSlHWixHLNfn8zMBdXFUn4oZ+2lafDLAxLDECOgkDy+
         oAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748477051; x=1749081851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+ZfYC+HxLPw3qSKUcJstolHkzilJWLIqOV2x8aXzBY=;
        b=dCu8Ke4P1pJTSAEORqgRxZyaF/orAG9MjIgZVbl3Qmob3kXFbRAKPhhyK/tHTFmVYd
         1pryQeLQED2IuqNBdsYg4NcjIArsJgWN+jORiK8v6pKFrhuof+Ka9K2HnbAnRDE5Idht
         yzMD2NRnNA2sFlvppt57KXQWFRdehzR8uFK4iM8J1i036k+GQfX58ZJ+jXCqZn8T3wyz
         KCzjroGMlADlJPVUDLJSoumtxFppWjiEWkEpDGwfys9QeKKYPRjp10UvcciMA7Cct6bE
         67tUvLOJburxc9vdMk8biEoBmcQTssw6uLrnPXrC0g5MkJm3Shrkoqtb9m2O6CN+lloJ
         7dAA==
X-Forwarded-Encrypted: i=1; AJvYcCUceWSew3fyvT6y73TeLe/ZgpEAoaPAU88JPSCtCepQEYreObvuLUdYozcwDIfYUtYpUMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2FykQF4z53EF6F95h8u13RX6ILWL9x2XIRWxipDOKBRRSEpT
	U8vOcPJwwL8t1Z1ezN/H2jXy+5jC7oZ0d6Ujs34yxT8/2ARksVPm7RAdXo2CcA==
X-Gm-Gg: ASbGnctUBGGwcyYh346nOBXziVZPEm/1ONOh8nWaKu2siQQ+OXmHB8QEDVekXH6PMgH
	Z28WqMLsyRV4U2rOHIWxcZ4QFTDREbRc5M+v4XnumNWSqo+VrBRQdodKfKyc7LnJ2W1IrTmr7eJ
	boO74C07zBzcbLCAfhrkjWUVzK4tr5Ge20LiWsiJqPfJCRtDOf2UyO6uCc9e3+E05J8AT0fPOUU
	RBDLgUUkejFCFxwsM1nENJdEyFwsckzkIPXseOnUc514uZpRCxrj73DYsAnh2HlC7F/j1prMNaf
	HSFRzxZO6gJUe3xgQh4bxbqh7DT8UE0mv1wAXlwPwQvup+uj3diy
X-Google-Smtp-Source: AGHT+IFIsUJXzE6cpHqD9iAzsUlj4Z9xIb0cR6MAJH+p4Bq6pd53TrwevVEtUuSFDeR4I7Zaa/H3Zw==
X-Received: by 2002:a17:903:1b6d:b0:231:f064:aae8 with SMTP id d9443c01a7336-23414fc7276mr285356495ad.45.1748477050862;
        Wed, 28 May 2025 17:04:10 -0700 (PDT)
Received: from gmail.com ([98.97.34.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc86c2sm1587855ad.43.2025.05.28.17.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:04:10 -0700 (PDT)
Date: Wed, 28 May 2025 17:04:05 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com, zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v3 2/4] skmsg: implement slab allocator cache
 for sk_msg
Message-ID: <20250529000348.upto3ztve36ccamv@gmail.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519203628.203596-3-xiyou.wangcong@gmail.com>

On 2025-05-19 13:36:26, Cong Wang wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Optimizing redirect ingress performance requires frequent allocation and
> deallocation of sk_msg structures. Introduce a dedicated kmem_cache for
> sk_msg to reduce memory allocation overhead and improve performance.
> 
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---
>  include/linux/skmsg.h | 21 ++++++++++++---------
>  net/core/skmsg.c      | 28 +++++++++++++++++++++-------
>  net/ipv4/tcp_bpf.c    |  5 ++---
>  3 files changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index d6f0a8cd73c4..bf28ce9b5fdb 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -121,6 +121,7 @@ struct sk_psock {
>  	struct rcu_work			rwork;
>  };
>  
> +struct sk_msg *sk_msg_alloc(gfp_t gfp);
>  int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
>  		  int elem_first_coalesce);
>  int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
> @@ -143,6 +144,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  		   int len, int flags);
>  bool sk_msg_is_readable(struct sock *sk);
>  
> +extern struct kmem_cache *sk_msg_cachep;
> +
>  static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
>  {
>  	WARN_ON(i == msg->sg.end && bytes);
> @@ -319,6 +322,13 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>  	kfree_skb(skb);
>  }
>  
> +static inline void kfree_sk_msg(struct sk_msg *msg)
> +{
> +	if (msg->skb)
> +		consume_skb(msg->skb);
> +	kmem_cache_free(sk_msg_cachep, msg);
> +}
> +
>  static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  				      struct sk_msg *msg)
>  {
> @@ -330,7 +340,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  		ret = true;
>  	} else {
>  		sk_msg_free(psock->sk, msg);
> -		kfree(msg);
> +		kfree_sk_msg(msg);

Isn't this a potential use after free on msg->skb? The sk_msg_free() a
line above will consume_skb() if it exists and its not nil set so we would
consume_skb() again?

>  		ret = false;
>  	}
>  	spin_unlock_bh(&psock->ingress_lock);
> @@ -378,13 +388,6 @@ static inline bool sk_psock_queue_empty(const struct sk_psock *psock)
>  	return psock ? list_empty(&psock->ingress_msg) : true;
>  }
>  
> -static inline void kfree_sk_msg(struct sk_msg *msg)
> -{
> -	if (msg->skb)
> -		consume_skb(msg->skb);
> -	kfree(msg);
> -}
> -
>  static inline void sk_psock_report_error(struct sk_psock *psock, int err)
>  {
>  	struct sock *sk = psock->sk;
> @@ -441,7 +444,7 @@ static inline void sk_psock_cork_free(struct sk_psock *psock)
>  {
>  	if (psock->cork) {
>  		sk_msg_free(psock->sk, psock->cork);
> -		kfree(psock->cork);
> +		kfree_sk_msg(psock->cork);

Same here.

>  		psock->cork = NULL;
>  	}
>  }

