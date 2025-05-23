Return-Path: <bpf+bounces-58855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A5AC2924
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D421C0463B
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5DC298CAC;
	Fri, 23 May 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="roTzoKLv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D69293736
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023120; cv=none; b=hEokFPIM/8O/Z7m0IgaU0K9Yl9d/vuvHjpUlcDM5i5QmX4Y+6QrUlQ22s+YItJFL2HzYANrNd1PvR+BDnuszYb7F4XZoh9tpSl0Gi8Npqa9HFnY0/tq6mOAoCdWsTkszif9+x/9EKcIJyU733JzdOj8D+4rEki9drsEVSk1Vojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023120; c=relaxed/simple;
	bh=yYUi1udmfUYcJ5YKVRKseXClYrhNKbYP3F+XpHNtIHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBb84UqDB11DHLVXoDnW3V8HV386KHb+TDgA9arNO6w6Z2Unsx4CrbDQVmnbAe0JKtpS+miTpbUeQ+8OBLIZuDL7tXytdS9PCbLGzz96sbA7QJSUgekl4RCnv1Sf0dgYp1UJqgvoOA+TYKDMDNdJ4tDqFDwRnXrFTk8lZcq5+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=roTzoKLv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231f61dc510so22615ad.0
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748023119; x=1748627919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MyXWu6zLRMWPH6yHtJnpQrGvuPbRE3t03DXROyNghU=;
        b=roTzoKLv/gm1v6/kWWqvdHmTclgVlQ8sdIfGcvud2iKzJisAuFpgYguGRNoW+Rt7HO
         vGPxQudwoWpOlLxRCjqG3Xq/s7DzrMVTSkUq4LpGTxx6uRAKH6NTLzV/aK2R5NY9Lntm
         xD97LMueOW+TauoAYhqm+y7AbqeOraExpmFRgl3J6fnxLruzxonfBmshbaszpMbeqcQH
         Tv4y3Gq5/vqi6qwWTGfDiJqbmyVRy7oG5FqF+C4PyXedMZsUtBg9ghf0L/uwUl1P7RGF
         c8AR+196rw9aYb9aM9T/Pk0O+KvHMLbH9S6HyHhWXGBXeretaxIDmUU11r0EEbGsLDw6
         Pcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748023119; x=1748627919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MyXWu6zLRMWPH6yHtJnpQrGvuPbRE3t03DXROyNghU=;
        b=KBTOVIQvI75bpzqULW4kk4ozq70CF2ohWircTEhSOxHmu/q6V/2pAVG7oJecvBzt1t
         0lkYtZOXFAF0PXMJYgITxstClx0RjGBvMRh08J+G8O4rQ/JzuiDryQ4xKLnF82hLoc5E
         VYtLvCTLr+eW/1GdH5GMDa9RBsN4Us7tROkEkCdwpgJa5JjXtz1XLilJtpjwkcm2KNig
         WVGZT5g2Ab2ZTAdIdIwfL56YalAoOjgY8sw/7ucnVQxK7mIWAfN1UElxg1bCZs1ee1bc
         E4ChVIW6suD0k1+aGNXZ0ViTK6c0n1j+g3cEU8PHDpAMEO6W7aII54dmCr9gHmQB52QO
         TY/g==
X-Forwarded-Encrypted: i=1; AJvYcCUIOZHQPtYhpSUGeFTcTbbH9D4FbuOl6uAdOC1QcCsU9YklNz7YbLIx89zxmnoljpeJxok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+4xHupZCMjYLBh8/bYZqc30eo+buyoGMmP9NzxxiSASpM7hI
	MjroPRL5MyhRglYf+s6PXvbaCfMCjXMXtVsZiVA2XVsC8N8qna5vBU2RDuz+Hn6BUoljTEx4yQx
	p9q/0fDicXCfm539fBuxpoCq4AU0DicmMfrqd7g5n
X-Gm-Gg: ASbGncvfgz219ZX9TufaRcI5wsQ4RjTN+Ff4PDSBKZDst/Gn+KWm0vuU0B51jHpEO+M
	oaPGTGjvLznn0ZDbjyRKKIhvqr9Qs/U2tRAm7YDOGbsXRtmw1/yJJ8G7QTsAaWuj7WPrwjo/UWV
	gJmepSXxmmkbe7S7p+/S0VFzYIrDXUqY16JNHBvnADNHhWom6sDJR8V8xKjfmQnIZjZI7YsHFU7
	g==
X-Google-Smtp-Source: AGHT+IEGY8dDXdk00hKfZkhUxriQXpiPPCR5IyFq/kqB79PhLQHBbOU2os91yMCjpc3IjFgm69TOwCQHLx4ADvLhU5w=
X-Received: by 2002:a17:903:2f85:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-233f345f871mr2976175ad.27.1748023118552; Fri, 23 May 2025
 10:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-9-git-send-email-tariqt@nvidia.com> <CAHS8izNeKdsys4VCEW5F1gDoK7dPJZ6fAew3700TwmH3=tT_ag@mail.gmail.com>
 <aC-5N9GuwbP73vV7@x130>
In-Reply-To: <aC-5N9GuwbP73vV7@x130>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:58:23 -0700
X-Gm-Features: AX0GCFtIQeUuZYzja1a1q1Km_umu-mPBIVJSyoxOHOUHS4AXUOAmnwmC0suSjaI
Message-ID: <CAHS8izNgY3APhLZWjYwEWyq3g=JiCBWFUcnY4nrXpntnp8zKhw@mail.gmail.com>
Subject: Re: [PATCH net-next V2 08/11] net/mlx5e: Convert over to netmem
To: Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 4:54=E2=80=AFPM Saeed Mahameed <saeed@kernel.org> w=
rote:
> >>  static inline void
> >>  mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
> >> -                     struct page *page, dma_addr_t addr,
> >> +                     netmem_ref netmem, dma_addr_t addr,
> >>                       int offset_from, int dma_offset, u32 headlen)
> >>  {
> >> -       const void *from =3D page_address(page) + offset_from;
> >> +       const void *from =3D netmem_address(netmem) + offset_from;
> >
> >I think this needs a check that netmem_address !=3D NULL and safe error
> >handling in case it is? If the netmem is unreadable, netmem_address
> >will return NULL, and because you add offset_from to it, you can't
> >NULL check from as well.
> >
>
> Nope, this code path is not for GRO_HW, it is always safe to assume this =
is
> not iov_netmem.
>

OK, thanks for checking. It may be worth it to add
DEBUG_NET_WARN_ON_ONCE(netmem_address(netmem)); in these places where
you're assuming the netmem is readable and has a valid address. It
would be a very subtle bug later on if someone moves the code or
something and suddenly you have unreadable netmem being funnelled
through these code paths. But up to you.

--=20
Thanks,
Mina

