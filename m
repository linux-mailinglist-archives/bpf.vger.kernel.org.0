Return-Path: <bpf+bounces-54776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD9A71FD6
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 21:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DC73B8F27
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53382254841;
	Wed, 26 Mar 2025 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gd7x8KLV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836343398B
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019383; cv=none; b=jNwyY5WMcVJyGSj9SwiUl076eu7WLGaH8k3rGcHQexrcdegDcKJhBA6aWGji54Vq3YLhhobHMbXEFI2yIkk8OVYml3/IIbxZT5pvZ8fWSpree4ughekSD1qHnnBPiPp8pKVoiFTqrKwfPgbn6B+XRuHmynVVdztzMzsIx6RDqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019383; c=relaxed/simple;
	bh=+Jn/IScUMjS4Ljw3DR8smqRGBCJ5wuOgYhY7MDcFlHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvUhDmaEQbkRck0R+9Azt9+1jejNLeVWmkqoKjgQONJ6sG6nivsNN3eWTev31Fu6q3Fx39kmROOaYeExBiVlyJGcL2+drRYMc87uW/4tA+66+mm9mWar5ubFamwdc46E4mcqUpTDfdcaQZb6kdnlYGNfm+USbTH9FnEx3r732CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gd7x8KLV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2264c9d0295so49565ad.0
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743019382; x=1743624182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Jn/IScUMjS4Ljw3DR8smqRGBCJ5wuOgYhY7MDcFlHM=;
        b=Gd7x8KLVZtGWEll9DZ7sZP2owhGlc5HMJ+kqOS90WxLY77EvDSVNo7g3RmTnCmHXgs
         WecDcB2IIYrvjc/fPvVYPq7nuIbVIclN/MFacvrS0RmwZVe7TTlkhwtPGu3zcAtRmoa1
         gTW6g4/uZFdyr965AH7iUTlSSZXBQcNI0Ug8A00s7xtrYhdqZ6pJsLwQbGo6FXfkOR3R
         qVdwQYN5SswvDI/cBA0mKwAhNVsrqrxbzAoF+ifgD/M5LdoOqZiwNm3TmXImVGzZWn+5
         kQ2/xRNYI3DmoFn5yCg+TbeOoLxbc+VlI6TlWfYlT/zSr0M03ouvEw2YPgDGNiE/mTDy
         mlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019382; x=1743624182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jn/IScUMjS4Ljw3DR8smqRGBCJ5wuOgYhY7MDcFlHM=;
        b=HwYaK/jbaLgHfos8Oj+ypmcyY23td2xgwWj7IWn18N6KVn7oxAS28BUiYhNXIOpwnh
         4El4cK54rB2HTG84hiElfcqmSjPbsI/nflKp00yE82YAyUXUOO1Hh5gLeamBYLCP9HnL
         N2Z7CxLv/mTuNIhmob0qedxov/Gfcct6xo3V1q0UavC5uEY6z3Liggts3LBp+ZNzBfyG
         vhv5KgIW31uBKWhRqbgy/huEyhifp04bUdq3w/MnrMikUvyfV7rqvCVeqHJ415e1mFl6
         CBMLRm5iuGp9UmKyRbdELnD/CWJq49Ac8idVg7YsdfVe/qEkDQ9R78GG+u4KfEdUxV61
         BV9w==
X-Forwarded-Encrypted: i=1; AJvYcCWYKEXdaJhwnegOKvfdF8J2vcm261xJtO0BTHM+rbI0q+QmfqEys1pnTf0xyuGhVrmGZgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTE8ld4SJSoBP+7plrYuDHEUHxbJqQA9l/NMud/MMcjIgKzRfK
	S/ds+wETm/f9eF/QAjiJcnF6uquA7i5DSvcHUNvknuBwtOye0MoFn+W5uCzWbPk8/Ktmj7oDNyj
	c9qdWeSKd+U4HrxOVz7Me6Z9y8g6NMu2Yq5az
X-Gm-Gg: ASbGncutPIgsYHIAQ/dnjvHuz6VvR1GiwQ8JUwYjYFvZhkJUR2jbFZuo0rRTl2Gu6S6
	2GtyP4wjnBMUXUDDIwjVvWbOMTvC2nBcPvVAIHCBFoNqu3EwtGneuQ7mQFh8sv6Hloy99eEWa+0
	2/uwN2wCffKYatKkEICELqjtoEapHrxTZV+wHBNgIrB82cnadp+hfL9mXC
X-Google-Smtp-Source: AGHT+IHyPZSjmwsfq6GL9V2mdi4AJh86d77SZIS1dGb/WuVS1w50xrfuefF5cJ781EQYYgtygSKDYkcpT6oW3EQsMpk=
X-Received: by 2002:a17:902:b20b:b0:223:5696:44f5 with SMTP id
 d9443c01a7336-22806bc2039mr138385ad.12.1743019381382; Wed, 26 Mar 2025
 13:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com> <Z-RF4_yotcfvX0Xz@x130>
In-Reply-To: <Z-RF4_yotcfvX0Xz@x130>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 26 Mar 2025 13:02:48 -0700
X-Gm-Features: AQ5f1Jp4SZZ5mE4AjxOxiWClioRQd_IS8oLYCgWXk_1st2N-aMHQasCWsZn1xYo
Message-ID: <CAHS8izMj2aBeu=TreUM-O3XNqqF75vb4rvMvf7pr8mGh+N_+kw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org, 
	Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:22=E2=80=AFAM Saeed Mahameed <saeedm@nvidia.com>=
 wrote:
>
> On 25 Mar 16:45, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >When enabling DMA mapping in page_pool, pages are kept DMA mapped until
> >they are released from the pool, to avoid the overhead of re-mapping the
> >pages every time they are used. This causes resource leaks and/or
> >crashes when there are pages still outstanding while the device is torn
> >down, because page_pool will attempt an unmap through a non-existent DMA
> >device on the subsequent page return.
> >
>
> Why dynamically track when it is guaranteed the page_pool consumer (drive=
r)
> will return all outstanding pages before disabling the DMA device.
> When a page pool is destroyed by the driver, just mark it as "DMA-inactiv=
e",
> and on page_pool_return_page() if DMA-inactive don't recycle those pages
> and immediately DMA unmap and release them.

That doesn't work, AFAIU. DMA unmaping after page_pool_destroy has
been called in what's causing the very bug this series is trying to
fix. What happens is:

1. Driver calls page_pool_destroy,
2. Driver removes the net_device (and I guess the associated iommu
structs go away with it).
3. Page-pool tries to unmap after page_pool_destroy is called, trying
to fetch iommu resources that have been freed due to the netdevice
gone away =3D bad stuff.

(but maybe I misunderstood your suggestion)

--=20
Thanks,
Mina

