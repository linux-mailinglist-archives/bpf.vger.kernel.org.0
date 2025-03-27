Return-Path: <bpf+bounces-54834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F5A73F17
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 20:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BFB3A48D0
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501D1C68BE;
	Thu, 27 Mar 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyWbkIkQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B318DB1D;
	Thu, 27 Mar 2025 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104887; cv=none; b=u+grhobKtcpfYEF84kjVOcSzC7cCgUniELd9w86rsS+9+0rqQB35LtXIufSHtKo9sttzmQrGgFRFrs5X7kgFh7iwAzm1UcpVJcGjVw6EZ0F277vRhhP7AJl1R7/gBu34ovhw6tgW1VNYojPWd1ZKG6nyRDYQd4dXPNXkO51xYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104887; c=relaxed/simple;
	bh=28kjruSiqh684ht2B0qQ4T/a+5Cnx5UQ0hJSQyVknzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WK/IurYHqmlyCqZi80KJ74/mudWcN/MSb0l7lL7i0nk2Rn4ACyTW8Fh4ZutPRzlBjaAdimHxtzeYJONYCuqNiUol/nww0olyh1TJGHiVH5AJ9P8B74yfoKo7ngs13eYl2cnmxoXReOFp2g90LL7KK/AEZov81CDT8WxqqAjl96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyWbkIkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F3C4CEDD;
	Thu, 27 Mar 2025 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743104885;
	bh=28kjruSiqh684ht2B0qQ4T/a+5Cnx5UQ0hJSQyVknzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RyWbkIkQM8RAwAVFK4RbHDFEFMQsIbJPevb078oNZnIDEFifYjCkVsMDthJoXENhG
	 Opy3YFKZkoYtJGbr0DEs7XXQ1ZnlTSLc4pXES9XfrvR6xBYhMj6ANtWiTKVGrCrXv3
	 +I2eMGatCcfqurRShuyqkSvznsejJpOLdHNSgTa5qrqhMBI9Qw1LATVpkhZhbY2mZc
	 QemRCXM2nASmYcGxOlNUTnWAnBgKWmnOT8IMEC4/JMaXjKRBnUc8bvDcNN5W6alfLE
	 O9g6IqlNTcpyihbkFYUKXpXhEnI3f3FYGnImCZI3gNMIHS1SFk5SMRMbANvfsHx6CP
	 /Yk82fFB0z1yA==
Date: Thu, 27 Mar 2025 12:48:03 -0700
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
Subject: Re: [PATCH net-next v4 0/3] Fix late DMA unmap crash for page pool
Message-ID: <20250327124803.41feffed@kernel.org>
In-Reply-To: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
References: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Mar 2025 11:44:10 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> This series fixes the late dma_unmap crash for page pool first reported
> by Yonglong Liu in [0]. It is an alternative approach to the one
> submitted by Yunsheng Lin, most recently in [1]. The first two commits
> are small refactors of the page pool code, in preparation of the main
> change in patch 3. See the commit message of patch 3 for the details.

We see a crash and an UAF on:

[   18.574787] RIP: 0010:page_pool_put_unrefed_netmem (net/core/page_pool.c=
:465 net/core/page_pool.c:808 net/core/page_pool.c:866)=20
[   18.575880] napi_pp_put_page (net/core/skbuff.c:998)=20
[   18.575912] skb_release_data (./include/linux/skbuff_ref.h:40 ./include/=
linux/skbuff_ref.h:56 net/core/skbuff.c:1079)=20
[   18.575944] consume_skb (net/core/skbuff.c:1165 net/core/skbuff.c:1396 n=
et/core/skbuff.c:1390)=20

You should be able to repro with ping test over netdevsim
--=20
pw-bot: cr

