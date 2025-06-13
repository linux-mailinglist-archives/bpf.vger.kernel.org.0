Return-Path: <bpf+bounces-60606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780AEAD909F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA981E2A43
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457AA1E1E16;
	Fri, 13 Jun 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbVKHHcY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E731AA1DA;
	Fri, 13 Jun 2025 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826924; cv=none; b=pbAcJdrzAx+kcsq3iHoQ0VmVG0Bxe144uIraH9wqCbSEG9HSstibU/9FxTbscpC9SVlV1MrXj+tt2aTXStaFyrsyKcyFT0Vpi5grI7OhUZKLV9kLdTS1S7K481fid8SY4xbUf+fBd80sPCRGAgtX9Yc8BQNPGJGKSKpcpoJY+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826924; c=relaxed/simple;
	bh=lob9a/rX2zwMnk7MdQZvnP3dVbVbnvB5IIsgo3k2oTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/tb4BLALc6umXuCH/eTMWZZQ+OvYQEiC4oSTsKh7gjBvvyiOd27owlvHLumvTzGYdZo0M4Nk4wym8Eo9DXgCbnPJa2CMKAO9fLLUJL3lSRowXZYvBuTO6KdOLSUQzsmcbQPwgXjSb7afovoPMW+CRjmS2c5kUvET9FZB3rpcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbVKHHcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D49C4CEF1;
	Fri, 13 Jun 2025 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826924;
	bh=lob9a/rX2zwMnk7MdQZvnP3dVbVbnvB5IIsgo3k2oTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XbVKHHcYbWjQFPgfcHDfQUknwEZ2cdrEVDoTGz4IxmKoPUuVL8hcGiX3j881sSXXL
	 6pBmArM20WrE8BPW5goFMp9o0PjDO49LbuWKjfSih/Lc52+/DzCdrn9ve7PiXBKfUX
	 ipWpDsx5S5O566AJx+R7tq7NB7mgX/5B3mfVh0REc0uPkyWkgfPy0IATiOFW8Rvdyb
	 FgiMLbQ+27rnCljyzryF2VwJ47J5RxezB820m7qt9uffyrz3jp6MnTQ94s+5QdSWK6
	 8rOlQ9o7XHXe87mOoESjMr9z/fDxNOrgZJKY1ckS5CYpoDAf6+/xHQ6OnSaYddsryk
	 BXEVCncYa7SMg==
Date: Fri, 13 Jun 2025 08:02:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: sashal@kernel.org
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Breno
 Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>, gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Message-ID: <20250613080202.28d25763@kernel.org>
In-Reply-To: <87zfecrq3d.fsf@toke.dk>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
	<20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
	<aEmwYU/V/9/Ul04P@gmail.com>
	<20250611131241.6ff7cf5d@kernel.org>
	<87jz5hbevp.fsf@toke.dk>
	<20250612070518.69518466@kernel.org>
	<87zfecrq3d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jun 2025 10:41:10 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>=20
> > On Thu, 12 Jun 2025 09:25:30 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wro=
te: =20
> >> Hmm, okay, guess we should ask Sasha to drop these, then?
> >>=20
> >> https://lore.kernel.org/r/20250610122811.1567780-1-sashal@kernel.org
> >> https://lore.kernel.org/r/20250610120306.1543986-1-sashal@kernel.org =
=20
> >
> > These links don't work for me? =20
>=20
> Oh, sorry, didn't realise the stable notifications are not archived on
> lore. Here are the patches in the stable queue:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-6.12/page_pool-move-pp_magic-check-into-helper-functions.patch
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-6.12/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-6.15/page_pool-move-pp_magic-check-into-helper-functions.patch
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-6.15/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch

Thanks!

Sasha, could we drop these please? They need more mileage before we
send them to LTS.

