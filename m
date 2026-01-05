Return-Path: <bpf+bounces-77869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC3CF544C
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 19:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71FE330CFFF7
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BEB33FE04;
	Mon,  5 Jan 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZXHaE3b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887B1A9F85
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638930; cv=none; b=AAhlLxMaqRjrDAzXLSGDoclV/S6ceF9nlQl62tgrq+7qHt8beEorqV5jgWrQXLvbq+Si+PoN/mp2VgU5Mjil0vhPo0tfB+1KBU1RdVturelmSJuX0wsQhtlDxS89OeoShFsH0jnqlKIm+bj4/mur7NQPEx8Lby7YLsR3nakZmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638930; c=relaxed/simple;
	bh=fErRiiJwHiwz5/ivXZzt7DohWO5HJQPRcltM0RL8gWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tFNbd0vFg4FvxMiA47/an68evP18uk964OaXqtuc+YBqiAhsAcicUXNiDHdVqkFY9CQfCvzks/VSAWhVevrW4ZUfoyTxt8vuQg4gGaFsuFoIvxUz1rpRzmaeu1ou2ilpnuZzSwwamO+DVh7atpq/Ph29s7qcDmoVMbUbyLCd6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZXHaE3b; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso111924a12.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638928; x=1768243728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fErRiiJwHiwz5/ivXZzt7DohWO5HJQPRcltM0RL8gWQ=;
        b=mZXHaE3bjY1/TLHF5TyYuHdY4BwYSzdALTXna81bzobEbk+9KYSXjbYXXDhrZKrcBu
         mlx3AHxaB2fq3Ei0pDazi224kQL2aA9tHqX4/uerpqJj455+XLed2fjgR8U4fxaHnsKt
         3zRoFHAD80q+nNFor/EqO9phzG499/DoEuWG38GKWnX7RSKCkPaEm57loNjTfub7yaW1
         swxb3aF2iUWqJwADBq4qmEP2IunJS487vkx1KvAkGOccxGmagWzmq5omj0l7XwS8sfRg
         Urv7z04pRI70OmaqYoinlmbzUFLAVZvZy9rRHqsSRSK9WWVXBJxiFjLa25RfEI0Ea9Wn
         Yzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638928; x=1768243728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fErRiiJwHiwz5/ivXZzt7DohWO5HJQPRcltM0RL8gWQ=;
        b=JGTVfKkPtMKNGvw9mSNBNY0KFgLPAI884/0xGGRniTwQmi39wnRVEIibCcW62RTjuL
         C66F3u8gN60kJ3T3o0mmPnHmGB1W8iNWYjuTp2P6m2voo0raOkzeM/V6gC2RKFHiou+j
         zlAkh+9OKZK6Mu1y4jrBSEfrdjyA3CpPZPE3GxB0/ZMejpHqhA+l/Db2sSOTPqGQ9cVW
         sI8AAE2OKKPznRHrYpkQ+RZd3eDZj+xc8Y5IgaruoUXk/iPSkUgQnJKZawLvWmJfmD50
         VLx+APGvLFVYWCgcfV0Ry3XiX0NgOEenS1I5u+cFqpzkLSmUjyN7uc80hP7b6CVeIsyl
         8MlA==
X-Forwarded-Encrypted: i=1; AJvYcCXpqLxEsu3N/dnN7qqey30UByr9axaAVVQYIx1p44Z130aZ9i1VKntR+aFUAbt+X8VV5Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9dG/+zjv1Sk8Xi5UZm3gMHgncq2WC4v9dlkXHGiJpkMg7bD7
	YdWnVR8aI9cjBU0jD7EPYVJ3EuHgvPX5+A9dgIdtMbwDURpaZ6xKMZhG
X-Gm-Gg: AY/fxX5QCZyW2D40hdVoNPEce52kY9HVf4MthoephBP/p35MPeAojhVRIfxt8FLrbGC
	zjlSjNAp6drwTZLCwGwCJnZ6cNOCoy2TngHS7nIBJtJBaTym5gGvN4csMZnGBbg4FZ3gia7mb3M
	VXijwpQ1p7lWJbDPnjS6wmoz2l7odS3IRIECuc0YJUMGprkkQnDCjL09/AHshD7zm/08iAPRtOq
	PljMkZ6DCujVa0kjk3zYK9t1f5qs0djZHkJ2DW7I6X/QSMYYpEKl+hilrqwF2yxpRCekcv4jsL/
	myQ7A7aCSFwipkYKSvBiPVLnz81xIOQESmKMkI4xOQPMvEAXrKfb20RYF0ZpnHv6jEkWO2HTx1J
	DiuXaFz53epepX+MD9pqPez+KAo9MriAfJtI+uakXAg9VOkl5VIgkFG5TWEHqR4PTZ4SiNxyuFW
	A/WCGxaJsnyFLb4EPDdoKOcaEYYwAfYlgR68az
X-Google-Smtp-Source: AGHT+IHo4MCvN8bh9kZUcHAWtaL5GHodrDBMQruJzO/juSsyL4pCoBv0ojoMYJFRnRAh6v2+mBtL1g==
X-Received: by 2002:a05:7301:70d:b0:2af:7f2:50b3 with SMTP id 5a478bee46e88-2b16f8389f0mr181239eec.5.1767638927938;
        Mon, 05 Jan 2026 10:48:47 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b16f18e22csm709561eec.14.2026.01.05.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:48:47 -0800 (PST)
Message-ID: <6b7a415fc9ede7adf7321a18d239c5054476ce17.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/16] bpf, verifier: Turn seen_direct_write
 flag into a bitmap
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
Date: Mon, 05 Jan 2026 10:48:44 -0800
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-12-a21e679b5afa@cloudflare.com>
References: 
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-12-a21e679b5afa@cloudflare.com>
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
> Convert seen_direct_write from a boolean to a bitmap (seen_packet_access)
> in preparation for tracking additional packet access patterns.
>=20
> No functional change.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

