Return-Path: <bpf+bounces-77870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7456BCF5452
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 19:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E17730D6DC0
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4903340A4C;
	Mon,  5 Jan 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+P1gYVK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15D22424C
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638962; cv=none; b=SHqgryIoPnI+pEwfksnNxulLLjP6sCaw0FI8AyhAqS/vHbnc2+tR6fMkQc+G2Xj6kUk0qoDPcsJdMBUCvtysslhzyLfvnfAp6Ob3ORS5TbG5MRkiXlqsfbiAbsSgpLnBpui2wnvL4VwKS8gWVJQW2To5gDPHfJDl1iKFvWv3GmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638962; c=relaxed/simple;
	bh=e003jG5vdieFFJDuCcrJsIwtjPz7vudFpkvsD/FMFE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THm8ZOaB3qTJgnfk0d5aDXT2gLHvH0y+8vGGK546eo21yLKQhLTc7j6du6YMt8QrFSIKKSYilbvhjT4aK57PJoz66Ft1wjfkZGAMV0146xkhQu31i8CwnN7kqXhScLKktqjC2mtDUm6k0C3mS0nmVQHtQp2TPWWWzA6hJbbUKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+P1gYVK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29efd139227so2513605ad.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638960; x=1768243760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e003jG5vdieFFJDuCcrJsIwtjPz7vudFpkvsD/FMFE8=;
        b=Q+P1gYVKay8WSOrdhPI/auxGuVzyBRhvBLQ+fwlZXXKQ11URfCW6ZxCm29AnsCeHbq
         zvF2BK7zxRrNlk84sa8grHEXZQAC5PoaylPgNfaVDD+4sZlsqaPAViCwDb6vpYyQKhKI
         8DaLE3a3fB0PBSVgOEj7RCntEoA5w/jG67SYgUM8nZauoPAzxB8ahBTZelGHBE6UJ/Qj
         5G736UDAuKjZa5kq2TzOYqbag5vjefKf4M1BzZUjMZ5ZfMl3CpIi18X/JYfPIdLyqSco
         9r7jO+XDoKOqcGMDzn0vfButUDA44HAOrALIjDfb0n1FbuWMrhNgho6npzOSe3axN5Ic
         ZVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638960; x=1768243760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e003jG5vdieFFJDuCcrJsIwtjPz7vudFpkvsD/FMFE8=;
        b=PUpSz4T1rD6BwZ2Z03zPPU46zGwdeJRxRgXSxI/ewiyyd3RB3kDiM1igXLPU8CNEl1
         609sXOzE4z5sPh9/BiXhZCuhsbTNmgltshOrtD0xkUX/lD2UM8EMjLqyTG+kxHN6gLl+
         541NZPOoJaWxcLpShW9Cf7bwVJMCBkZsLxsMGVUpezIpXcxogzjsuL+sruDnwUg515SZ
         p/bt4+n9PCEUjnt8Rwp/O2JnL/db59dTrfO2tAMybfctntQMLMbs9F6G//DOeGNszJpO
         Na9hpvS+DTxv/iWuAZ4YNLb1zAt0yrI4LCmZBEcFchX++6znlshcZXzsrX6MoDLYUKoR
         hbpw==
X-Forwarded-Encrypted: i=1; AJvYcCV6+ZyHgj3JIuY6xQsPaYL8TuXpyoA0xHMFKos2fKxmXXlOhHo9oShftXipflXLOHGwoJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzs4j49Xbdf3509q3GZbmctFan0zVqerdv9BUSNhJxB7uVg3Ob
	VYe7gmA6KaywFHgzW7kWNkTsKggYyHfeHatcYU8tZJwethWc2Pr0UkqGd2P500/G
X-Gm-Gg: AY/fxX4r5DryoV8t2ulen1D3ul3TDN1ouMT4g+AxdZg7v5KHk4CaYw/HBVAuxio1uJl
	MBHJiSozKXoxfmcps0CZYgbUUtB1NR3EbUqyxPsyZrACtHvMzlTgbAHqwR9mNVxCRcoOdaktTko
	D9sriDvLv0Bn/IsTeg9bL8Gz0Q5lRP3WUZrHFZOydCxwE4BR2KJeMukzkKCWqavOzjtCkQvFRZ1
	9X1+HCGXw448LCUUqIaPyT5Al99sQNB5V8V5XjnKcoWRCLU9rBBcjCY0KIVDy0b5MYcxCvPm2fW
	slWtHSugGkedzL4p98NkENz73YP0JizZuxyAclLqbEzWI5zyFC36LX+IC58erMvZCpt8iMoj/HE
	7lutRROJMSl4JvF0bWjafav6ZHpk9BZPkUbSKBNVqR5Dg3ZAFF8E0e7eSDQrRVjQZaA6D4EW0rN
	3x+ZOuBiKVEBqIFaQwXY0e91QK+YBq6wV0KudK
X-Google-Smtp-Source: AGHT+IGo39NsQJ7PSdxFpuDGG5ulm3AIDxQrQW7tgt1k+akXwhbnJ6bNsI1NqEVpcSsafRJxeHoNPg==
X-Received: by 2002:a05:7022:6288:b0:119:e569:f277 with SMTP id a92af1059eb24-121f18dd993mr338414c88.32.1767638960393;
        Mon, 05 Jan 2026 10:49:20 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f13b7a88sm1118677c88.17.2026.01.05.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:49:20 -0800 (PST)
Message-ID: <d3f5cba91613e34ef5008c616f16a2fbef9d0391.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 13/16] bpf, verifier: Propagate packet
 access flags to gen_prologue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev	
 <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh	
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, 	kernel-team@cloudflare.com
Date: Mon, 05 Jan 2026 10:49:17 -0800
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-13-a21e679b5afa@cloudflare.com>
References: 
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-13-a21e679b5afa@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 13:14 +0100, Jakub Sitnicki wrote:
> Change gen_prologue() to accept the packet access flags bitmap. This allo=
ws
> gen_prologue() to inspect multiple access patterns when needed.
>=20
> No functional change.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

