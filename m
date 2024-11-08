Return-Path: <bpf+bounces-44322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD269C1513
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 05:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705F61C2193C
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 04:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CAA194A68;
	Fri,  8 Nov 2024 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu2T0CLN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB3D528;
	Fri,  8 Nov 2024 04:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038694; cv=none; b=VlZdzANH1vbrhzc1CylSd0LIRzjG4HNPGXC/VF8eSmaBgnHn3Fsg0s8xQaUyyCfIxmJahx7LB8u8FbD/tETvQ7pdFUG0T36dz+UHIEohpE6k05/xhp9jXZAzcNX0/RR9lc0QFN1+DjRKt741qEjlcesruIfkArD9eiKBQbpTQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038694; c=relaxed/simple;
	bh=/yloo3atEVaYveWLXvZYwTZ+TkL5nPz8okgTjlmuNkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/EQGJPxDiiVcWkKtFGDU9BI4x14MsKBWebfo1XBbTFOaKMGw3zJc+E316dSbYYiznjS+yFlNjzY4fhW0x13YkRaF1eWAiyqcY1EEJ+QsL8wC5x2A9aJf+anxwJ2k1/xN8rBtd9m9yztJ/OhBC/0V+eXT8LboTJ+E8PgVx93168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu2T0CLN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720d5ada03cso1636971b3a.1;
        Thu, 07 Nov 2024 20:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731038693; x=1731643493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6rzU0PyYikhQZwL7BWTrF2snRYX+I0s4f7tJfKjjjc=;
        b=Fu2T0CLNDv89CGQS2KdfzchN0om6+U7Ps6mjh4HF6YbeArh8O5+KhFu5GvIMYvLRW/
         upgcY3dBdZbJ3FYbOEeTbL301H4jxAdjpw5+ZpAM/rzFL/aa1Pj/FNEkYHs43+CgMAsN
         yD7cp+JLJgsEjuuWq6s67HaXSyHD7gqaYRwalqQ/gKHy1QbkSe+2+853fFMFw4wUR6A6
         /7vkXXZAaE2/iKBO5E/JdJaJSpBSRiXqqS9CXMCWHsiCiIDHIf3aM1olYTUfn1ZQNNrR
         7t0YzIuKnjpUuY6Ue7lvfB/W5U9B4xR6F6TzNLwvS4AP4jAiNMTlKLRL4jLg023PhGAk
         3n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731038693; x=1731643493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6rzU0PyYikhQZwL7BWTrF2snRYX+I0s4f7tJfKjjjc=;
        b=FizqQylFLszLnT96hAUBZY5pZbSrco7RLQ95zbiTOOe1ht/ZcIS+OlJFTgML5FANqc
         QbgpX9iquIfPI3A2w23WoUsvgxZfXBTkk6A2X+X6+5ecpPGK0/XoL+OkSaE8gYxBSj6R
         5Gaxojh0IYYhjGRjJhg9rpJq9YgL1qqk7sR98bz/41P8M2Dby2osd7KuhF86wFYD5YUa
         nHBiBi5oPRBOap4ImEvGOGwJfDwbT16Fwvpmj7/l/HFt4z0/1sEA5XwZ0EnHsV3jbU+n
         tLzO8yBJ/9KH3i9lUcND9aKWRDYkpnS9At8POihEuCD4/IjEl+fyk/IHxTSMEjZsuhBK
         edAA==
X-Forwarded-Encrypted: i=1; AJvYcCXMuhU/RaoyNni0IgSo1MyOeR8Bj/qwBWdlZM4NEHzYCQgXZpO+rQtZMQGOHlCHJAl+Xrf22Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9IOHaL7LUfKYKU9/M0mfiR6Tq0c7E+Sc9A48ysFrH+y66VBDy
	4axePMZdq+WAiB+pD82uH3EL9T15KUzUKbPoi47qfIlODTRa2dFr
X-Google-Smtp-Source: AGHT+IHIu7EabOU47a2yz3J3IYDGtKmcNQZbntekh3UyvpTjS8XxAN3WoNkVGDdq/BW50iwrLB3VTA==
X-Received: by 2002:a05:6a00:2d29:b0:71e:7e8e:f684 with SMTP id d2e1a72fcca58-7241328f2b9mr2026996b3a.9.1731038692594;
        Thu, 07 Nov 2024 20:04:52 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:7950:9609:53e9:c7fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a404csm2664745b3a.126.2024.11.07.20.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:04:52 -0800 (PST)
Date: Thu, 7 Nov 2024 20:04:51 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: zijianzhang@bytedance.com
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
	cong.wang@bytedance.com
Subject: Re: [PATCH bpf 2/2] tcp_bpf: add sk_rmem_alloc related logic for
 ingress redirection
Message-ID: <Zy2N48atzfYYTY6X@pop-os.localdomain>
References: <20241017005742.3374075-1-zijianzhang@bytedance.com>
 <20241017005742.3374075-3-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017005742.3374075-3-zijianzhang@bytedance.com>

On Thu, Oct 17, 2024 at 12:57:42AM +0000, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Although we sk_rmem_schedule and add sk_msg to the ingress_msg of sk_redir
> in bpf_tcp_ingress, we do not update sk_rmem_alloc. As a result, except
> for the global memory limit, the rmem of sk_redir is nearly unlimited.
> 
> Thus, add sk_rmem_alloc related logic to limit the recv buffer.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---
>  include/linux/skmsg.h | 11 ++++++++---
>  net/core/skmsg.c      |  6 +++++-
>  net/ipv4/tcp_bpf.c    |  4 +++-
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index d9b03e0746e7..2cbe0c22a32f 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -317,17 +317,22 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>  	kfree_skb(skb);
>  }
>  
> -static inline void sk_psock_queue_msg(struct sk_psock *psock,
> +static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  				      struct sk_msg *msg)
>  {
> +	bool ret;
> +
>  	spin_lock_bh(&psock->ingress_lock);
> -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
> +	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>  		list_add_tail(&msg->list, &psock->ingress_msg);
> -	else {
> +		ret = true;
> +	} else {
>  		sk_msg_free(psock->sk, msg);
>  		kfree(msg);
> +		ret = false;
>  	}
>  	spin_unlock_bh(&psock->ingress_lock);
> +	return ret;
>  }
>  
>  static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index b1dcbd3be89e..110ee0abcfe0 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -445,8 +445,10 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  			if (likely(!peek)) {
>  				sge->offset += copy;
>  				sge->length -= copy;
> -				if (!msg_rx->skb)
> +				if (!msg_rx->skb) {
>  					sk_mem_uncharge(sk, copy);
> +					atomic_sub(copy, &sk->sk_rmem_alloc);
> +				}
>  				msg_rx->sg.size -= copy;
>  
>  				if (!sge->length) {
> @@ -772,6 +774,8 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
>  
>  	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
>  		list_del(&msg->list);
> +		if (!msg->skb)
> +			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
>  		sk_msg_free(psock->sk, msg);

Why not calling this atomic_sub() in sk_msg_free_elem()?

Thanks.

