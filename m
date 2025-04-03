Return-Path: <bpf+bounces-55272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F9A7B210
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DA93BA910
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C219190477;
	Thu,  3 Apr 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Htf1EKTi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29119F416;
	Thu,  3 Apr 2025 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719492; cv=none; b=e+8sDc8gJsPaDhJ9wR1aGnYt9fiUme+Iu9U4Au2gbQtJmAzkdeI5riOuS4P/YMMXiFZ/+9oFpOGFodIXVfTPyIm7KvK8sBGh59/S76E6BiaWIYEUygLKr/LEiMYCy/hSSZSlRLUmcdK6ZJKLhuw9LEu12J74orutTQNrwXXDBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719492; c=relaxed/simple;
	bh=q7aT1Vc9FCJL3FCej7Qo+diDR5o13VyLs2ps027u9VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HD/DAlSavmh+jvjE8LDRWB48TG8GZBNA8KySz8a8KPNyxDzHvYEG8hKtSP0Prtrn9xtxT6Imrl+aNiCjmkYo9iHUIgUuCvgddPCxgjyRI3efY51fXbE4irrgNmCyz2AdSKeEOjPMs0B/11YRVrm34sdE5pfAB9NjA9SPA0FcrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Htf1EKTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A635C4CEE3;
	Thu,  3 Apr 2025 22:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743719491;
	bh=q7aT1Vc9FCJL3FCej7Qo+diDR5o13VyLs2ps027u9VQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Htf1EKTiwevBUPUymLkFuUGQbfKsvyB4rrmwSzMbJK8Y/m0/v0q6tpcET1MnXN4No
	 s+7bbLHyQGG8IzECdarQuPoOBHhuoFrdFHRIj/UD/8Wq5NTGnOT1W5BpFwN/Oh9wec
	 Gk21QN/coOp4Da8BO1qw+o8tUURfcZJ4AiyPFO4Kc7avSRMH0ybdosuxga7Tg7V22a
	 LHKUDGTZmmN3Mb00N3PM0d9jtHHHUzooslffkmBUccQVJnTNHMJXnGgu38hPZ9jHO8
	 CKMBaRVDJSPqwdt9GdbqbE635vMX6nDVo8UFwIqrHaTSMHdG8B9PTKFqR/SYWm4Z3B
	 81/zCJ2RElWcA==
Date: Thu, 3 Apr 2025 15:31:29 -0700
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
Subject: Re: [PATCH net-next v6 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Message-ID: <20250403153129.013a7bdd@kernel.org>
In-Reply-To: <20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
References: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
	<20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 01 Apr 2025 11:27:19 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> +	if (err) {
> +		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
>  		goto unmap_failed;

FWIW I second Pavel's concern about the warning being too drastic.
I have the feeling Meta's fleet will hit this.
How about WARN_ONCE(err !=3D -ENOMEM, ... ? I presume you care mostly
about the array filling up so -EBUSY

> +	}
> =20
> +	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
> +		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
> +		goto unmap_failed;
> +	}

I think this is ever so slightly leaking the id, if it ever happens?

