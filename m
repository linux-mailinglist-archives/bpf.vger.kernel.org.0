Return-Path: <bpf+bounces-64090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A9B0E3AA
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9884D18955DA
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9915283155;
	Tue, 22 Jul 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMFwqko8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835025C833;
	Tue, 22 Jul 2025 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210160; cv=none; b=bt/GbZ2NhE7RB2KxRVFTvdW6y69YVa85reteh18ZrF8O3oaWknZdZ5ZTWemyphu0xdZkk/g5H0dvPvh+sNoLkEYXlj/uAugX+im4kOq8ZIu8fM1ZQmCOa20LKUf0I79GakOG5IlSSdwXXNHut0nXkO5Mz1s2WSFHqHJpELufgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210160; c=relaxed/simple;
	bh=r1+sqIlBADCb6mqjRanffunkgG17o49q2AL4JcEBTOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOHZgf4NvAY5a+5EHvpxmFwDRNfRVoIK4AUIzJSLfOV2vaTS6q4WFrTTvPo5JbL9SaWy0tGQwTBUawquFy11ox7Hd7/xe270H8c7SACkwXtJ/LojjqW7hiKmcRY39N6eWS1VGIF/VQ8sC7jXI88GaL9w6M31ENxQKpp2VZSz+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMFwqko8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167b30so54753565ad.1;
        Tue, 22 Jul 2025 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753210157; x=1753814957; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EindGHJlktQVX7xZxD8UDEuice7aiYGONICYOdlL4hs=;
        b=AMFwqko8FGKazRpoR+vaeMHfB5Gfw5qgp3c2TCi2HIrC5VAKY+3+z+D+fMMdF/xcx0
         RYXTqELdyVQi25osr+ifEYSJcweC2SaOsc65/yQaxV0sGcvc08Dyty45GeZhmNbLZM9q
         yrHhtMVMehqHPNCtaJlkkYNVj7XOZ+HJ3BAYvAlzEOQufMYGu30RNTcyNIdRVpHJD7oh
         vUeH5d3xTIWQOKhqVHZY27PuPfLF/FlcZNb4GTTVRp1YikAno8eL4DuB9U3BLWHJBGyb
         TjKg0Dhfzf2zzGXK659VagCzA5QOzHrQ/mdLBtfdGsZV7H4UHUWn9Be/mYMzS/sMKxF6
         whkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210157; x=1753814957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EindGHJlktQVX7xZxD8UDEuice7aiYGONICYOdlL4hs=;
        b=m97maS1t0mU6+lXdeWx6zIiFsgfRDcAk0bRprpy9ognvEqBn9YaHFrVtaiMZroQWhE
         qtbwMNmzj/NjR1IcB66Dbtwwre91pGf4Pl+XNV0aDGSuyvd0ozmBnkRyF5bcXu+2YHYn
         TSzEnhSnxOPIqEunbm6l4qcFjxQbHHjJDSlVRPmg5pZsFpty4nEhbsIcNeZapNlQvA+a
         SMbHXMIUc9dUIQTMQ1g+oUT7J8bg8sUsAgRq+PxXJwMVQpNEoR/5avMuLwHrj8K23vjn
         vHnXGh81iA7znfmRKoVUl3D2appYtwBjEoc6Aek8vpyns59Em8VPNc5Elw29cbcFb6Vi
         OAmg==
X-Forwarded-Encrypted: i=1; AJvYcCV+l7IARJWGsjsavh2C/YjMJJDtPuLdhmvmCVma6+SDcIN4rgRgAacuDoPEF4ZeqLa2tIE=@vger.kernel.org, AJvYcCX6TB6jAFAssfWREoC+RREVycWdja1IRkyXiDJYzzRXIIQAVaBgQ6IgUs0BSr1C1wOnXpRSQPGS@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYBYMvZnG61bvkLWUtpDgLizjvEpSo18vA4VnqW0K6B6k3+ok
	B/A7aQmgi548+fTpgnw1e+LBmSh8j92Qmu8+BLBJfFizylRE81+uxNO8
X-Gm-Gg: ASbGnct8imLLsSfQJRnnb0+375jat5wIjM7f7bwEbeYRi8s8qPq07fWjzYJVEG1nuNP
	tT718AkxLrXeaaUm/UIJ7iGwgzRfdDYQZrGmqdCtLqgzRM64uRPFjQ//dbte23E4gylMpCKurE/
	8Rm+ARhNi9D8Jrq+c4ULUerClZ3md8OuZBS44ywd6atcjpcv9DbyP2qMPHi1I4y2S5hei/M0pUY
	mI5ewz/f2sKDa+Q5fcl5nHorAuVHtm/RqQLnAGCCk9mJw0SuC2QvZi0R5zUleTjQC3+Q94uoToO
	PXJCAO+1Q8bXTqsaFJ9suJvnLWl9GVsD3fTriEVpX/XEgmQzc+NuUAu4iIkoGmMO/podPtmAWwD
	FP83JI6sqdgFNYCUeb3uLVzIcYtFS
X-Google-Smtp-Source: AGHT+IGTFymfKW7BmroCxzprZYf2l8q1fweZLWCbI0IqH+5i5m/gFs0nsiGUb9nzOcz+fE44wVvZig==
X-Received: by 2002:a17:902:cece:b0:234:d292:be72 with SMTP id d9443c01a7336-23f9820c7abmr455945ad.26.1753210157475;
        Tue, 22 Jul 2025 11:49:17 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8dc32sm7551758a12.23.2025.07.22.11.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:49:16 -0700 (PDT)
Message-ID: <3d765f43d5b2d186f2de09c1dddeb32d8ff6e46a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 02/10] bpf: Enable read access to skb
 metadata with bpf_dynptr_read
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer	 <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong	
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>, kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev	 <sdf@fomichev.me>
Date: Tue, 22 Jul 2025 11:49:14 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-2-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-2-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:

[...]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index c17b628c08f5..4b787c56b220 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11978,6 +11978,18 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>  	return func;
>  }
> =20
> +int bpf_skb_meta_load_bytes(const struct sk_buff *skb, u32 offset,
> +			    void *dst, u32 len)
> +{
> +	u32 meta_len =3D skb_metadata_len(skb);
> +
> +	if (len > meta_len || offset > meta_len - len)
> +		return -E2BIG; /* out of bounds */
> +
> +	memmove(dst, skb_metadata_end(skb) - meta_len + offset, len);
> +	return 0;
> +}
> +

Nit: is it possible to use bpf_skb_meta_pointer() here to avoid
     duplicating range check in both bpf_skb_meta_load_bytes()
     and bpf_skb_meta_store_bytes()?

>  static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
>  				struct bpf_dynptr *ptr_, bool rdonly)
>  {

