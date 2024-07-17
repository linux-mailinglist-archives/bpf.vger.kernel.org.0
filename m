Return-Path: <bpf+bounces-34953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4A093407C
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17ECA1C22E87
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725F2181D01;
	Wed, 17 Jul 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttkm+dh5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843AB6FB9;
	Wed, 17 Jul 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233932; cv=none; b=tMTC4d3TnpLUoGQUBq2QI6GKd35eT0AkBPfoxHkLdAwUF32SogGyLvnXq7qEandoj8dofIziEHmAPJYACPpPu7H1VrXyfr2jSqeu6CHbOyerQHOY5eXFhtMCuUA6eOf0utmPONKMaAUfghGWcqCY/BWMZBYGwEg1EM7mpZK05Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233932; c=relaxed/simple;
	bh=3fUCNNaJXzS7JuiTOKDc4frw9Riwja6uOzB2OgTupcs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pk5cO9vEp3qciwHTH5h1pRfM6XGsK0MttQk63Arqfyh5y1Q+s2+2+IxVJRL0DUYeovQnRTHxdar13wGMhlriszsJF57z+2oXyN/+Q3pA0yWe7N0E9CCBHyj+pLu9EfldfnUgBpW3Sdo2fmVI0fvcfi1CT98Nxz6JR+WYTnp3PZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttkm+dh5; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a05b4fa525so84084085a.1;
        Wed, 17 Jul 2024 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233929; x=1721838729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmMW3QotAs6Her4vmCKKRFApsHyxNhbddH+wP64vdF4=;
        b=Ttkm+dh576N/85bgOm2jVXyfwDlfZBslSU5CAq0ha6plNDdcAlG9M+nOdeN+yAIeJt
         xnBbdiEHKRHBXu6ECk+3+0u3Dmm7On8joa9FwdYiY/CWfXDVCvfk06aHh06e94kNo5km
         Lwy5ljz3Eyka+R9Gxm0AVMGqCdZ/D1rX8yS5+hoKESvhBtYwc4fYHunWrndswuzFPt08
         E61sEFVGJ5dI+j6Y9jrLQvz8O8pHByoFo56M4wC8mzk6dvq+KXW83QyeufPh2xw3UgeS
         CK2mg97jI7GHhualOCoSEwSCd+nx9vdTT5YuCysfWTDsjuHcgfFW2eTiXCZdlEjhwmIe
         TAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233929; x=1721838729;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tmMW3QotAs6Her4vmCKKRFApsHyxNhbddH+wP64vdF4=;
        b=Wqq8BcZe+RS8TojqOyuiK+ZziSI0BYLuNwoHM8ICz08aFTO6jj9V+5MtILhild21Hs
         +V0EC7okyR6TSWDhPio/ofmWK+xqSasQ5JBKaFSSUrl8QmJrSUaMeRC86eWsPvxjvuWs
         r4wvL8C17Y2vTmgVGIWcF3cola7IDYjrD7HUsULojFf2iq7u67Lfwv45j1DpuRwtHn9N
         5ybqoIA7mGDA3+7noi3Jg1maR+JxvOU1UjpcIe34ArouEK1lrizoSctxGF0VAjP+BC/H
         tYU3WPLI6Php7mR+4T4W6tTUtCWeitzKfouQ/rfkqH4MeYaYDJ4FeYnoMRH9KFoa+Yti
         DqWw==
X-Forwarded-Encrypted: i=1; AJvYcCX2Cw1OFBTCUk8f6XMRjeXQ+BbPUI10dB9ht2FbaSqOSGW3olzrKPQjusEcLxti7QtiKuUFHs8SHwppPATbptNSgg0KFSVTvBDtQAmPcsRBQDmDP1T7m4x6oVeARxB9j3TDgFev
X-Gm-Message-State: AOJu0Yy5wpex+sysxykUXdPR+LZ9KBtCQYOW0c3//lLrPQX4G5Pfkar5
	VvZfaEXT0Q9x6lLSocRsrBV+AHvBtGn8/g184dl0vMmlIt4QmVxV
X-Google-Smtp-Source: AGHT+IEWVMngP8w6cNex5dWAr9Yp33iJOatF0vo2y029Lbb3iYHvJwJf5hFjDKhq5B+bjXSSb99uWw==
X-Received: by 2002:a05:620a:858:b0:79d:554d:731f with SMTP id af79cd13be357-7a18dc06099mr26838685a.29.1721233929273;
        Wed, 17 Jul 2024 09:32:09 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160b9c31dsm418156485a.20.2024.07.17.09.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:32:08 -0700 (PDT)
Date: Wed, 17 Jul 2024 12:32:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Fred Li <dracodingfly@gmail.com>, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 herbert@gondor.apana.org.au
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 Fred Li <dracodingfly@gmail.com>
Message-ID: <6697f20876b11_34277329417@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240717053540.2438-1-dracodingfly@gmail.com>
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
 <20240717053540.2438-1-dracodingfly@gmail.com>
Subject: Re: [PATCH v3] net: linearizing skb when downgrade gso_size
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
> Linearizing skb when downgrade gso_size because it may
> trigger the BUG_ON when segment skb as described in [1].
> 
> v3 changes:
>   linearize skb if having frag_list as Willem de Bruijn suggested[2].
> 
> [1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail.com/
> [2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch/
> 
> Signed-off-by: Fred Li <dracodingfly@gmail.com>

A fix needs a Fixed tag.

This might be the original commit that introduced gso_size adjustment,
commit 6578171a7ff0c ("bpf: add bpf_skb_change_proto helper")

Unless support for frag_list came later.

> ---
>  net/core/filter.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index df4578219e82..70919b532d68 100644
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

Super tiny nit: no capitalization of When in the middle of a sentence.

> +		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
> +			skb_decrease_gso_size(shinfo, len_diff);
> +			if (shinfo->frag_list)
> +				return skb_linearize(skb);

I previously asked whether it was safe to call pskb_expand_head from
within a BPF external function. There are actually plenty of existing
examples of this, so this is fine.

> +		}
> +
>  	}
>  
>  	return 0;
> -- 
> 2.33.0
> 



