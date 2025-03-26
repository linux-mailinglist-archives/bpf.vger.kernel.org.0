Return-Path: <bpf+bounces-54744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A8A715C7
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 12:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828341894DEC
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB01DD0F6;
	Wed, 26 Mar 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A687vLK7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB9185920;
	Wed, 26 Mar 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988575; cv=none; b=HoYLI+W0nrO0FWdR/762F/rk/iR2m/PDy5iVpJSuxy1vLm9aNdOJnZXznC+lC4cbr52A7d6wFIT9j7f18dDUmsT3wAwEue2ZoH0fkjm5vCQhz2T13/u5c/zBnPW+Q/ivOTXZ68Wd5ca3jpwcf3HS5++nChaZX5Jvz7KL2ZAWnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988575; c=relaxed/simple;
	bh=7KrEIaFFiDJaGUzoqlsWeHvOc7wxtnz8IiRDhEdUP7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYxXF3MYlwlGkTRLPAksRGh10VpLEimLoVr3lfbKBCsnHlr0v4DJoSwZQDwByo1CgmFgK8GhLi4OZCSWamPOgRqUdmm4+sngIMI4hSmquVaNDRu3bpw8HehQVfxsd4um7nWr/FjmSdnD8MTpqNhATHBTqCaOW9P+NHIhoLshbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A687vLK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487A0C4CEE2;
	Wed, 26 Mar 2025 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742988575;
	bh=7KrEIaFFiDJaGUzoqlsWeHvOc7wxtnz8IiRDhEdUP7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A687vLK77cRScE2DQHe9r0x48BR3Dk/rrWIOaEJZSdhgkpLHZoHZZPxKNVX6ebjRN
	 6LfuimVd1GgCqYYlKj7nNxSBR87sv2WoLrTKintyZslPkRqQ+Hojegw6tvVvrlp8T9
	 bqdHpAiEmKHAKsOh5hAhWyE7Vj+ac08mZN8GeMRrbTkhekMJwgZYK/U9NDtzM/su8C
	 XOQNDcas05PlYoWp7by0dcFLWuOKGp/4+X149d+jcO6wsXKpYs3s4i/4B2RVVgAzZd
	 Qcj3A4tpwneSkrQqKpf/0DCTz9fU+DotHKCV6j8MIY0zQW0lMjCJCVc+k1iH9rfGwe
	 7dI4pZS3hU96A==
Date: Wed, 26 Mar 2025 04:29:33 -0700
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
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and
 dma_sync_cpu fields into a bitmap
Message-ID: <20250326042933.6bd0ae60@kernel.org>
In-Reply-To: <20250326042347.279f23a8@kernel.org>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
	<20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
	<20250325151743.7ae425c3@kernel.org>
	<87cye4qkgd.fsf@toke.dk>
	<20250326042347.279f23a8@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 04:23:47 -0700 Jakub Kicinski wrote:
> On Wed, 26 Mar 2025 09:12:34 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > > I don't see why we'd need to wipe them atomically.
> > > In fact I don't see why we're touching dma_sync_cpu, at all,
> > > it's driver-facing and the driver is gone in the problematic
> > > scenario.   =20
> >=20
> > No you're right, but it felt weird to change just one of them, so
> > figured I'd go with both. But keeping them both as bool, and just making
> > dma_sync a full-width bool works, so I'll respin with that and leave
> > dma_sync_cpu as-is. =20
>=20
> Opinion on dma_sync_cpu clearing probably depends on mental model.
> No strong feelings but perhaps add a comment next to clearing it
> for the likes of myself saying that this technically shouldn't be
> needed as we only expect drivers to ask for CPU sync?

Ah, misread, I thought you meant "as-is" =3D=3D "as is in this series".
Thanks!

