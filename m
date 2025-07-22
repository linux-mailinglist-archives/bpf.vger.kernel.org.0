Return-Path: <bpf+bounces-64089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B751EB0E3A4
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D810016A9D8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4B280A58;
	Tue, 22 Jul 2025 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWbrD07b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AB1422DD;
	Tue, 22 Jul 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209989; cv=none; b=dbTCi1o9W3pJJz+8A4rxqHcnPl1AgG9maTiLPuKwZL+Spi8cLKPCEkNbdy+iS6cFZemGMU14RsWxy8pR3M+BxK/gDHDxpXZGrKWvvR4yC/gP3RhEViwOOvHPo26wZH1LWHz79If2Ejl9gDjAf/oGoRcAD9nPby+bxWgkNRjgp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209989; c=relaxed/simple;
	bh=s6iHcO7ev7x6SMN/DJPhm0XzVwaWbWWNZcK0pgfVgYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqziB6BsrMKhRhZ3+tWfdNQpg7VMFBymUMxr6dQWKmp1Bx57GtDpZQ1pbwDlf/MAPUQno04fLgdMT7IVAC20jKcirLYNOvUCoD2ESVMdjVtf4KJTvTAFVju+MPnKQIOM8/cbsBUlEbp3uUfMqZNnchJ0xok4EudwfLPlASBlfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWbrD07b; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b27c1481bso3688876b3a.2;
        Tue, 22 Jul 2025 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753209987; x=1753814787; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=65Az4Wxdxvqs4dOM93HUOKOPXtzUe2vIUQScfGOXooY=;
        b=ZWbrD07bbO3abNTg//4sacgJGeI1ub3waq4FkTq4cY1o95bmY+y5qbeh1Zjo2AojBT
         ZEBLRvN/TjP2M9QDiDRU+GKAjLiHZNNyPapaAaVBdn0WyIY9w/+2cBNSbCht5QmKh/1c
         oIusr7LJcZYInEB8aqewufEGbKGBDU2SqL033A8OKXRYGEgaao/CUcdt6YS6yZl+vHWC
         Ym7278mhByMLfgvCCBWwzYX4+yQBGmxeMseDQ9LRU8GGyCt4PeDEqssM11LStp0XPQ3V
         UY0wKuPH7yNZraEq1zP/GwGAeLEEGSZYkaFscs1Ros7SGckp1G3RX1t5ljG1j8PGV5jW
         ImRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753209987; x=1753814787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65Az4Wxdxvqs4dOM93HUOKOPXtzUe2vIUQScfGOXooY=;
        b=NTdN1GZy8VHvQEYYV9F6CLI9CkpzW5HHCz6dql+Nk2ixAg3jQQSEoi66sD9+s961rO
         cEjM9zdKBNb13PCW5+mU98uejfqupDbQMvtux3DeySRQccMAVj6t8Ip0BoPPdeHYMsXK
         Zb+nGvIP8OpWRzI9pwfwBQCg2GlMhnqHOhQ8/TuKViRYrmEsvAduCtMDrFvRSKLCw3dE
         +LczD9+nyWZ5iKHm51wu/ov4EdJ8YduemdQoSwFxLlB9KlBy4/er6QGPVCCgXndRnL9p
         h/6f+ZiOPRfNqIGEDwyv7hzOcRDr9nKLwlC4gVp8vwV5fEGCnwWMDxW0JC+wyWdEjW6J
         7iFw==
X-Forwarded-Encrypted: i=1; AJvYcCUDYGb+ZQlTta9CH9OfFlWcpoMca+HSaC3BcU3zxXVIYx5nnwP9tki997Yd4Yn0qQgJfzK64Aql@vger.kernel.org, AJvYcCWbMko6bixHVohGjrdSiVColEU8deZE55625QzFiNtCrHfz4Gz1NiaookNLJwxOEsoB4Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHmzxgMzyBz7+CmSVdbh/LUvAH7z1/ef7Ph6HV5p6u9WTikfq
	aZLyTL6GQVnRIX2Sm5Y1EilOb6WxzwHMBG5eUeQJ9DNbWJheWRP+JN+3
X-Gm-Gg: ASbGncstO50jmOdzoBlcu3QKB0Wz0iFJe+NHNm0ySTcWakUHxmBFVNtayUiaYv3Cq1s
	GVqs7dW9X9GnsxvVXNevy/ZBPLv1d9+qqKnvt4K6fxtvEZ6+IVyVoYHhd3zC43wQTyyE37HA4El
	6gymscnKrIw5ZTbMq4KUllEhsW3xMD8/Ptu+4DnGOZYAFO/IJM3sXe/AYO0PfWX+zE+NQG4Gpm6
	q+bSC+aDwArx6xmcAJ8sxwBTgvrcMcybKPS/GjkkjLukYHwzQSQUDAK3iozorStoZES8pzgFFCH
	FT/YA9wAlZZm0uk4vMLd7SIfE7WcR2lSY/lCQ1HknaYFtos6l1uWAX2VOnnQzQ7qOqwTG31x7Cc
	mW5sTURsL+11qETDTA/UwytlcRbyab1i8R/MdKuY=
X-Google-Smtp-Source: AGHT+IESzTrDH63hwTIDvXOMM1+xCLoYCntl6AgTqPbcvSscvyMk3XFrln3OrEiJmMOSjbumuLhTRw==
X-Received: by 2002:a05:6a21:e85:b0:235:51b8:8d9f with SMTP id adf61e73a8af0-237d701a492mr43974605637.25.1753209987390;
        Tue, 22 Jul 2025 11:46:27 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe67facsm7562966a12.9.2025.07.22.11.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:46:26 -0700 (PDT)
Message-ID: <83977f81df181ba05a6388f3f542ec027ff44189.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Add dynptr type for skb metadata
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
Date: Tue, 22 Jul 2025 11:46:24 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
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
> Add a dynptr type, similar to skb dynptr, but for the skb metadata access=
.
>=20
> The dynptr provides an alternative to __sk_buff->data_meta for accessing
> the custom metadata area allocated using the bpf_xdp_adjust_meta() helper=
.
>=20
> More importantly, it abstracts away the fact where the storage for the
> custom metadata lives, which opens up the way to persist the metadata by
> relocating it as the skb travels through the network stack layers.
>=20
> A notable difference between the skb and the skb_meta dynptr is that writ=
es
> to the skb_meta dynptr don't invalidate either skb or skb_meta dynptr
> slices, since they cannot lead to a skb->head reallocation.
>=20
> skb_meta dynptr ops are stubbed out and implemented by subsequent changes=
.
>=20
> Only the program types which can access __sk_buff->data_meta today are
> allowed to create a dynptr for skb metadata at the moment. We need to
> modify the network stack to persist the metadata across layers before
> opening up access to other BPF hooks.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


> @@ -2274,7 +2278,8 @@ static bool reg_is_pkt_pointer_any(const struct bpf=
_reg_state *reg)
>  static bool reg_is_dynptr_slice_pkt(const struct bpf_reg_state *reg)
>  {
>  	return base_type(reg->type) =3D=3D PTR_TO_MEM &&
> -		(reg->type & DYNPTR_TYPE_SKB || reg->type & DYNPTR_TYPE_XDP);
> +	       (reg->type &
> +		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
>  }

Note: This function is used to identify pointers to packet data that
      might be stale after call to one of the functions in list [1].
      Once such pointers are identified, verifier would disallow
      access through these pointers.
      dynptr_from_skb_meta() is implemented as:

        bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metadata=
_len(skb));

      here any read or write goes through skb object, not a pointer derived=
 from it.
      Given above, is it still necessary to list DYNPTR_FROM_SKB_META here?
      Or some functions from [1] can change skb_metadata_len(skb)?

[1] https://elixir.bootlin.com/linux/v6.15.7/source/net/core/filter.c#L7989

[...]

