Return-Path: <bpf+bounces-77868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A50ECF543A
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A66F302C9FF
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80433336ED4;
	Mon,  5 Jan 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW20XOiC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E8227599
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638895; cv=none; b=n7TiCfHX58vY48E7kHk4QdsHXtmnLMzDNLQxjcPClN8GMOY7iKBs+t+ivudqV0peOshFypYdAArlch8IdhSwWumPBToHHRMerp/973u/QVK9zCbCYrFgtcuPKY8/a56WyNPgaww12HaDy9c2JdciTPghuztfpCV3kW1wpT9/gjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638895; c=relaxed/simple;
	bh=823ZyIiv6dLZZNtG94sIeR24IfpH1FUXwvJ8imTbqWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDjarcnpAAi/57lN7hVTuuXhsRZeDaIIyCf1xwgvN2bsFiOneGIxNr/br5owJoostU+b9vGg2apKPpocAy+MSSVqe8WgKm43KjBXV/f5+3Code5vtzNlXa4SHY5bBwIk2vDSwQwAUbWQVohEO3TEInNlnaZK14niMiQv6zi9S3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW20XOiC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0834769f0so2293035ad.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 10:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638893; x=1768243693; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=823ZyIiv6dLZZNtG94sIeR24IfpH1FUXwvJ8imTbqWU=;
        b=dW20XOiCTi9rOwCAi2T6NMJGlq3HQnpRfa1WopFFlecH1GaDQMVskHdQm3ARbfydIT
         tfrgpspvvI/Ux6lGIMwLS81Hi3e8wLJ//4+eaHt1v8nUiLgZlQ2FUvOJuZtvG8WUCLJg
         2Dwt5IQfjjj0AUk0j9MaoFPPG0s3dGRfW4Dyej1p93qgYTtXmP7YEn0tRAxstp9BmRxc
         ePtAoIPV8UXs/cb0D0AG4hdgeTRGUiVyH7APrGXcivQ1aM1cKQrRH55mLIjyZcMLOa6n
         dYqjGlaVTEy961p2ihTw3qvAkyBtgACncUp8ZaFNBjeIOArtMcX3u3wIn6+4IQOxVW90
         8zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638893; x=1768243693;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=823ZyIiv6dLZZNtG94sIeR24IfpH1FUXwvJ8imTbqWU=;
        b=Q76dtFmOlZ/d/NSM7ii986/m0td8SH+vp3I/9jnxgd/PzXL4BA0MAfxxsJDoAQ8ga3
         RZT1hh/D2SsGj06+BaBuuBBRDlbIW0mMKrtIcLQnUGzOOSu7/jz+a4uR3/chlXFlgfM3
         wZFpHYDJ78odk4APdycHUWZHSTaBsF1M3BXJ2yAAsMOuXH3g93LqjNuanFoTc4D3L6Z7
         h4C3euWhtN85eeUdu5GGvIWBZkAWDeRPknxsU2P4B5J3dKzRwbVVNgA9oy0dobI5pGBW
         m+d3b49iDqiidL7OOzz1DeMi3bctctl02vvARPg/Z+F887LThJSvxMdogj12jmpRod/F
         Oenw==
X-Forwarded-Encrypted: i=1; AJvYcCX+rpxdjZqZ909BHZd6rlnIAcDTh3NKFHYBoB0rYcBD5GPJlXu3+jwcjLwpkgjlkbOHtQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvugezLmkLn4aY7AW7b1ebecV12cZXUsBQyCDrJ6mZIvG6Tew6
	JYFKfdyfTPOJwiYXdU0Vq/64tuX2n2Cj8klw1WEZkw9wcHvbEl74gmWV
X-Gm-Gg: AY/fxX5PfLGk8Cf7YvxFYsKY1nR9LlrtLzgE82WkrmQmFTeK6bLYV4SQqVesD2ehiit
	Py3ZRMRPevK159JXDLXmiJd+M2VFHpuucYNKlb+qrTZcmQsy+ynmq/mczJTJZaUD09qeY7P/K/p
	4U7BC6oJq2g2UP8CDYrz5wfEnFoJLsnrfo6wXNLG4QlCe1Y2gFc5dlNu6hHKYHyvCvinbfxJlx0
	cXB6F1hO74UHr054/ODjDkp5r4RA8E2XafP06IUzte76wXlQosoNoSKAH/jsa+nYR1dU6PHh/b2
	t9bziWQK2ypgyh3vwD//wUKOpGxqYI4GmpiYrY1ajf6PMQBmMbXZ7q6VfBCW2fiTJkW5IhxrbSl
	YkD86J0Ov+ih7P9x/x8DUQXTedSHmYun7k2AEnSizMbtF2yS6eCnvU3xQfZjZmmXpDalVUHpkt1
	AWmCUx2RjdF0Nu2UtC2hEUFSm346MTB5OkXU7m
X-Google-Smtp-Source: AGHT+IGADnk0qu5rOZ12dW8/R5G6hKBZVjkflPwlw1XupSRGqqWwvD2EvQkybFKsbIobCX9s/oFOkA==
X-Received: by 2002:a05:7022:264b:b0:11b:9386:8259 with SMTP id a92af1059eb24-121f18f2f6dmr164053c88.46.1767638892921;
        Mon, 05 Jan 2026 10:48:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f1220a05sm1139671c88.4.2026.01.05.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:48:12 -0800 (PST)
Message-ID: <53f4ed220bbdfd1828dc5a54b9392e532ad9d9b6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 14/16] bpf, verifier: Track when data_meta
 pointer is loaded
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
Date: Mon, 05 Jan 2026 10:48:09 -0800
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-14-a21e679b5afa@cloudflare.com>
References: 
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-14-a21e679b5afa@cloudflare.com>
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
> Introduce PA_F_DATA_META_LOAD flag to track when a BPF program loads the
> skb->data_meta pointer.
>=20
> This information will be used by gen_prologue() to handle cases where the=
re
> is a gap between metadata end and skb->data, requiring metadata to be
> realigned.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

