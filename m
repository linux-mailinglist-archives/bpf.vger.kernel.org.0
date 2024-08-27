Return-Path: <bpf+bounces-38172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B088960ECC
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD821C2099C
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B071C68B6;
	Tue, 27 Aug 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQeSxwdL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470361C5781
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770321; cv=none; b=XeRVZOLi5GUyxNnWkjw5RSHaGB3CfU8RniIKIbsfIGN1yP8Zl+LYu5jjZkpY8Ex/ST7TYRlQprRPZd5hpXXhVZRhyBYMZL113zHtqSMpN2PnvSgGH8BcUydL3iGW/sH88/G5/NAAOL9PxOnErdNJimxVfdo+5qvQ1n9yWO+rGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770321; c=relaxed/simple;
	bh=oEmaKdDA0f1kPBEUawJwo+/C8xG853En1f0dUTIk/Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNU8IKNbXRFNs+6AAp8EBzjgmPt06MWACh94tJBQuxMwJmxhybbWgW2UrEW43xbr4Lwwv+O18ul7bZqSFMTH0cwDFvRwdePNQkQ0DGSJBs7ia1Rr6LI1EPv/iVhpoQitUX+P80EdJJad7Kgll49s5fRn0iaMJ/9evlaSqo1TD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQeSxwdL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724770319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7axL6WwXjfqeItFfnW0Apw3Twvbt3qkjjPXlRSVYpCY=;
	b=SQeSxwdLN1pK3hO1Ohlk27hET5VJQ6P6Ynt8boXV6dQsRMI4IpoRU200H92DsI83afEI0Z
	AXZ0DzGb4d98ffCVyh7spc4GZwW5/bR6aMDP4sukduBkUZcA1R6+e4S7qtENONahjm547H
	1F6bPGk3ffbT/ZJiTuZRnRI3f2XowYo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-px1SVqNRPHKPN3jXmmLQ_A-1; Tue, 27 Aug 2024 10:51:53 -0400
X-MC-Unique: px1SVqNRPHKPN3jXmmLQ_A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so29429985e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 07:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770312; x=1725375112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7axL6WwXjfqeItFfnW0Apw3Twvbt3qkjjPXlRSVYpCY=;
        b=FU+Off2mSJ+FrB50cWJJ1EGAW9jNIOSGAOOB7jBcMqm+Yw2X5Hv9bzWjXuk5dPUR8J
         PdnjSGKLKWQLC/VCsVd8h1lC/nhnk6wwuErOx+3m+QKTj3lPetMHqBRk9OiSa5bklPV3
         F+0Wz8liigJy/B18JYT7TLDFOt9iie4Kv2DSrRq+G+lsErRI44SwOCM4dPu2Lg48IG3g
         6swh4oYf0krs2GMy6sLMw7Nom40FmvYUpHuCtmGUM8A+8RUJXL9iRqB9S1vt+cFY0jwk
         cx/e7Ng2tvUt2x36vOnRnvy9a/EjX118DGnqXaL1N1jpJm+7UJezj+sVi41H+7kn/IBI
         Nj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbbr4/sqX+yK68ES3i63iqelWA5QPvfpAk3sBk0GG/C27ZA+bfPVawZ+3Dxvy6YA7yzvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzstzZD+AM9243NHuWFXdL1Tc5eY6v9TQ8bd5hwd38+iQQtc8hi
	uhidj0uxIW3sWiEZ6dMk0tQ1i962j18P53NIpnYUMO30sM/MvOVVlwQO9hElQl7y1l+liuC8u4X
	yaoBiQn186lHaLM9EzAbGsX+x4hrgD81enQ/E3apgK5h75kfSUFUfYbJeeQ==
X-Received: by 2002:a05:600c:2a93:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-42b9a4712c4mr19881295e9.11.1724770312190;
        Tue, 27 Aug 2024 07:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZZ74kly+gbSlYShXQj2yuPWS3lSuYHmjvhCf+TLC1w87JRikCELmk2jBrsrWcEKpPgeZS/Q==
X-Received: by 2002:a05:600c:2a93:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-42b9a4712c4mr19881125e9.11.1724770311473;
        Tue, 27 Aug 2024 07:51:51 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9d945144sm23064825e9.0.2024.08.27.07.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:51:51 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:51:49 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] ipv4: Unmask upper DSCP bits when
 building flow key
Message-ID: <Zs3oBWRQtDjl4JxV@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-7-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:07PM +0300, Ido Schimmel wrote:
> build_sk_flow_key() and __build_flow_key() are used to build an IPv4
> flow key before calling one of the FIB lookup APIs.
> 
> Unmask the upper DSCP bits so that in the future the lookup could be
> performed according to the full DSCP value.
> 
> Remove IPTOS_RT_MASK since it is no longer used.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/route.h | 2 --
>  net/ipv4/route.c    | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/route.h b/include/net/route.h
> index b896f086ec8e..1789f1e6640b 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -266,8 +266,6 @@ static inline void ip_rt_put(struct rtable *rt)
>  	dst_release(&rt->dst);
>  }
>  
> -#define IPTOS_RT_MASK	(IPTOS_TOS_MASK & ~3)
> -

IPTOS_RT_MASK is still used by xfrm_get_tos() (net/xfrm/xfrm_policy.c).
To preserve bisectablility, this chunk should be moved to the next
patch. Or just swap patch 6 and 7, whatever you prefer :).


