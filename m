Return-Path: <bpf+bounces-34256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672792BEDB
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0466E1F236EF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B50719D8A2;
	Tue,  9 Jul 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9iv6GQE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9D19CCEF;
	Tue,  9 Jul 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540405; cv=none; b=eZL19t8cxxcU4XcW7CvhXzse4tr6KrZ9x3kFcbpQtMklSmlzqBBbyBdaO/0/eHs0SjR6vb5J2jYzljrTE+Y8w4HWsuZLGRViHonTKutbjTe/6vooC3aDJ1djkOYzRDFDdyVpEm0afBGwRcCetuQtitUwwPHw4ioUzjpszvyaHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540405; c=relaxed/simple;
	bh=SKSlJoE4caZrBNWB9BQBC1IdudklWV8ccmjKdXCVS+g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pFqeMIMa36Sw3VEXJabik4JZ7MedNmEyCMzhE9j4iOxIsJsPjPOovUP45xzLzz79ZIbUw9K05aN/MNQbQRkkBpDG70zfKpcyrScttrufKCVorja440uXRYlllSXMy+LEFA5ozdiS5Gqt2TaW7FBeHKD9UHnzBiqRmKPgO3zq2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9iv6GQE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5f3348f05so23303566d6.0;
        Tue, 09 Jul 2024 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720540403; x=1721145203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWnAKMwNVbrEF4g9KJLYzg7AqLAcv1Oom2u6uWGj45M=;
        b=B9iv6GQEBQEn4BqiAGkb4X5dg5C8a9lyuLuC3DXpbJIKPw0nGMNOVKIvMv+lKukQUA
         xVUrEY0MZ9pP+eLENlaoQmH4wlFfG8l3f1kLXcq3ZIDM7SYfuFtIrUHNLkyuRzKhhdHw
         zJgn8gPe1iYuusbouMxqo41+RrrkT6KcYrDXw6yXupW5ycNReTtAP8WLWN6aeTQTBCej
         gOn2x/r/x1+Ku3RYsHLdTntCsF21yWrHYmc6qKerKcjGVX/6Rzm8ucoYnZeodsTWomNS
         YiotUVhbYII85vmFvXkWp05rG/8+WIgIR2g+gW66ZTf4T+PhEnTgec6/wxWSMXt9UQEh
         9Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720540403; x=1721145203;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWnAKMwNVbrEF4g9KJLYzg7AqLAcv1Oom2u6uWGj45M=;
        b=vE+qDIrRH/xnMpOgKk0c2vJ/Cvvn/xCLSbnxAfpP4feJh95cCCEeo1eHKIfQmatejH
         +6yJS9zaRaYyxUe+Ywwi+iw+jZ7A+coq+0P6ZSE78ntUthdAeMqSJBJjBsIRdWru/4J8
         x4Vtm8n/oC6FefobCE7muO8hCbhj41H4TwaVMtOdnC4XCqIlb3bG4pHo6yEIt3EYQTR0
         WdnTrwHncitNFyVOb1FwAylVddBBScnzAY+an6DYtdqE+9wGqdItQ5WwqrEQHf7pYza2
         75dU4fKis7WKDeUt6mv/HCr80IG4cjUHMgCbGr8E6wAb9RQgW1yXR6GB01jYHs1r/cOD
         gWOg==
X-Forwarded-Encrypted: i=1; AJvYcCUOmueW46cK27QCyBIqYfskSsl437PXg+A2h/+GN64BRVgZ5fXXZK+rIleDkp9UAwo8MrgnrxWR1mzde1YPkPQK6J/Gu39YC6ZVZF0QWocwaXNHfrCiMeX9oXJTcE7Z7Zt66brQ8Yd/bkH+Xr77i1FMiXhiQsgqQZRF
X-Gm-Message-State: AOJu0YxBUmrXskJkoVVNmxc3XCgySwuqII5HW3bS1T3NEc6tCYzkL7y4
	2x6QXkOhi0TLOts5f8J1u5ykLARgBJ0/ulwJP559T69rOoHJLAvm
X-Google-Smtp-Source: AGHT+IFWBPefgvh3ow4GfzEOH9QSIJyF1g+c0ssiefWaA/3s0uMkYOmWOYkqHCVrpMuylMX7YlGrAw==
X-Received: by 2002:a05:6214:f6c:b0:6b5:d94f:cf53 with SMTP id 6a1803df08f44-6b61bca398emr39121116d6.22.1720540402978;
        Tue, 09 Jul 2024 08:53:22 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4f67sm9830846d6.10.2024.07.09.08.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:53:22 -0700 (PDT)
Date: Tue, 09 Jul 2024 11:53:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Fred Li <dracodingfly@gmail.com>, 
 willemdebruijn.kernel@gmail.com
Cc: aleksander.lobakin@intel.com, 
 andrii@kernel.org, 
 ast@kernel.org, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 dracodingfly@gmail.com, 
 edumazet@google.com, 
 haoluo@google.com, 
 hawk@kernel.org, 
 herbert@gondor.apana.org.au, 
 john.fastabend@gmail.com, 
 jolsa@kernel.org, 
 kpsingh@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux@weissschuh.net, 
 martin.lau@linux.dev, 
 mkhalfella@purestorage.com, 
 nbd@nbd.name, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 sashal@kernel.org, 
 sdf@google.com, 
 song@kernel.org, 
 yonghong.song@linux.dev
Message-ID: <668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240708143128.49949-1-dracodingfly@gmail.com>
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
 <20240708143128.49949-1-dracodingfly@gmail.com>
Subject: Re: [PATCH] net: linearizing skb when downgrade gso_size
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Fred Li wrote:
> Here is a patch that linearizing skb when downgrade
> gso_size and sg should disabled, If there are no issues,
> I will submit a formal patch shortly.

Target bpf.

Probably does not need quite as many direct CCs. 
 
> Signed-off-by: Fred Li <dracodingfly@gmail.com>
> ---
>  include/linux/skbuff.h | 22 ++++++++++++++++++++++
>  net/core/filter.c      | 16 ++++++++++++----
>  net/core/skbuff.c      | 19 ++-----------------
>  3 files changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 5f11f9873341..99b7fc1e826a 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2400,6 +2400,28 @@ static inline unsigned int skb_headlen(const struct sk_buff *skb)
>  	return skb->len - skb->data_len;
>  }
>  
> +static inline bool skb_is_nonsg(const struct sk_buff *skb)
> +{

is_nonsg does not cover the functionality, which is fairly subtle.
But maybe we don't need this function at all, see below..

> +	struct sk_buff *list_skb = skb_shinfo(skb)->frag_list;
> +	struct sk_buff *check_skb;

No need for separate check_skb

> +	for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
> +		if (skb_headlen(check_skb) && !check_skb->head_frag) {
> +			/* gso_size is untrusted, and we have a frag_list with
> +                         * a linear non head_frag item.
> +                         *
> +                         * If head_skb's headlen does not fit requested gso_size,
> +                         * it means that the frag_list members do NOT terminate
> +                         * on exact gso_size boundaries. Hence we cannot perform
> +                         * skb_frag_t page sharing. Therefore we must fallback to
> +                         * copying the frag_list skbs; we do so by disabling SG.
> +                         */
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static inline unsigned int __skb_pagelen(const struct sk_buff *skb)
>  {
>  	unsigned int i, len = 0;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index df4578219e82..c0e6e7f28635 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3525,13 +3525,21 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *shinfo = skb_shinfo(skb);
>  
> -		/* Due to header grow, MSS needs to be downgraded. */
> -		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
> -			skb_decrease_gso_size(shinfo, len_diff);
> -
>  		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_type |= gso_type;
>  		shinfo->gso_segs = 0;
> +
> +		/* Due to header grow, MSS needs to be downgraded.
> +		 * There is BUG_ON When segment the frag_list with
> +		 * head_frag true so linearize skb after downgrade
> +		 * the MSS.
> +		 */
> +		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
> +			skb_decrease_gso_size(shinfo, len_diff);
> +			if (skb_is_nonsg(skb))
> +				return skb_linearize(skb) ? : 0;
> +		}
> +

No need for ternary statement.

Instead of the complex test in skb_is_nonsg, can we just assume that
alignment will be off if having frag_list and changing gso_size.

The same will apply to bpf_skb_net_shrink too.

Not sure that it is okay to linearize inside a BPF helper function.
Hopefully bpf experts can chime in on that.

>  	}
>  
>  	return 0;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b1dab1b071fc..81e018185527 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4458,23 +4458,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  
>  	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
>  	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
> -		struct sk_buff *check_skb;
> -
> -		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
> -			if (skb_headlen(check_skb) && !check_skb->head_frag) {
> -				/* gso_size is untrusted, and we have a frag_list with
> -				 * a linear non head_frag item.
> -				 *
> -				 * If head_skb's headlen does not fit requested gso_size,
> -				 * it means that the frag_list members do NOT terminate
> -				 * on exact gso_size boundaries. Hence we cannot perform
> -				 * skb_frag_t page sharing. Therefore we must fallback to
> -				 * copying the frag_list skbs; we do so by disabling SG.
> -				 */
> -				features &= ~NETIF_F_SG;
> -				break;
> -			}
> -		}
> +		if (skb_is_nonsg(head_skb))
> +			features &= ~NETIF_F_SG;
>  	}
>  
>  	__skb_push(head_skb, doffset);
> -- 
> 2.33.0
> 



