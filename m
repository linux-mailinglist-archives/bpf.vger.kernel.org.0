Return-Path: <bpf+bounces-54745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D089DA7160F
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 12:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E1D188B291
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F861DE2A6;
	Wed, 26 Mar 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTVy1Lw3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC264C6C;
	Wed, 26 Mar 2025 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989737; cv=none; b=kZnyAXD5Th+vm5yD79/6u789aq4kHkTWZWTzzgn7gDrpumn/Rak0x0fpRybn/+HA58z1aDdw4ddxlQtfZApaYLGlZrWhynxbkM7X5LD4hjYbkF506usMwFqjlHHL7QoDQRqSvpHSX2C4rzt7tLld4EPccHyHZmwLgIIFwO9kfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989737; c=relaxed/simple;
	bh=0RrYw3Lbm9JhXV4WGhiDBvYMd8envGDzH/0Fi2B96jY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMyP7UIEcTXMCqrtZwJAASp5iXpjcFLuq6nM3WGZ8yDcXyHMTyGURov0yXjV1m2HI2ZFQ9iGdxycU+/9n6EArqXDyP6CrOQ1hUzdOc7jWbxgZoXdXovE1MsTW6j+pSKx8XqkfkTTHt6rQyYoAAOcYdNa8QVnW++mTKMCHMLC4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTVy1Lw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0AEC4CEE2;
	Wed, 26 Mar 2025 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742989737;
	bh=0RrYw3Lbm9JhXV4WGhiDBvYMd8envGDzH/0Fi2B96jY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hTVy1Lw3pxsKXatMVAW/GCcU2UBomgGc2NHLAg+jIljKUtaCli1MaIYQ3DrszUO+t
	 Fh1iVQfOkJVmimYHez3IYS2hJ1EP9ShkGx5HL8YMWPZjVIcuSmDlHJE/larnqBF10m
	 ITn3n1//G9TNZfo6XWml0GyWs4+VXIUHGgQatX+CiMu2DrxPDa4Tn+IIdSxEPJJaK8
	 3Dm1k1CEpwb4Y66QDUBEoPGoNSFPrCwfn/jcv26M2nDmg4ShNYaig955ZfSq2No8qp
	 jd6gGEmEYN0LZPidKhi+/YusvVjiIjo6TGD2VPBgLeqTUir07b5H2TVN/wodXKmswm
	 ahZhambT2JjOg==
Date: Wed, 26 Mar 2025 04:48:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] Fix late DMA unmap crash for page pool
Message-ID: <20250326044855.433a0ed1@kernel.org>
In-Reply-To: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 09:18:37 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> This series fixes the late dma_unmap crash for page pool first reported
> by Yonglong Liu in [0]. It is an alternative approach to the one
> submitted by Yunsheng Lin, most recently in [1]. The first two commits
> are small refactors of the page pool code, in preparation of the main
> change in patch 3. See the commit message of patch 3 for the details.

Doesn't apply, FWIW, maybe rebase/repost after Linus pull net-next,=20
in case something conflicts on the MM side
--=20
pw-bot: cr

