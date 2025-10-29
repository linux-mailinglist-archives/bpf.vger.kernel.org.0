Return-Path: <bpf+bounces-72666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B485CC17ED7
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 969964ED49B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418C2DEA73;
	Wed, 29 Oct 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2CacSQj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5D2D0637;
	Wed, 29 Oct 2025 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701640; cv=none; b=YRvLjjpXdjyDkWgLBB+IIZXtv8AYamcGiaVwp5JN61GLpgQyeyZWeG4oxvDjxrZsGIfl+4Q9IEAFTVUtvxdQP849Ym+TDqLgv6I4sfEnfgRlIaq2bF8DajVxvYW86Nx58hg1bNvh21M6KkxoVz9M87m0cYvfUg4Q0WETxchg/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701640; c=relaxed/simple;
	bh=z3Yc/tloRcuK+HMyEVQv+U3jCVDjfWF9XOBpQagP+cI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzLkxx8dVGWLz4CO2/83tiQpb0ap2OSOcSJJ94l3WeL7ExNhggunkMByOaKs8Uql2lLmqaxTPzcRu7SD6uOQrWPdZDnFsz0XHGddZwqFREsKgZNNpiHf8DIcfCwC9iTUwymWt06gSBv6+5lrUzZ3t0XXv6LY5Uhw/49iNpl9VTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2CacSQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA927C4CEE7;
	Wed, 29 Oct 2025 01:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701639;
	bh=z3Yc/tloRcuK+HMyEVQv+U3jCVDjfWF9XOBpQagP+cI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2CacSQjHmj9Ut0QvjXn1yYD5TGTQrCJ7pqAe6TCS1ETgHaXGlSxkPdPXJENowIKr
	 0dcWqbsoOMUnEU/I/CruVsiu1FngyDTvYg1X16idYC/1Zs+zy+SVhrgEe3k78xr5pA
	 n7QZZPCDOwjpz9h+DjS1S8uEFVcNmIbOSYJRD/BA2OloR2NxGyUW01F57/MCKEW5a9
	 bpQNcHPzyY7lIbPHuF2Ra5gUjlMSH29F+lI24DtTJLkpiWgvBjqg21XETQYbfePRvw
	 N/q2GamWYah9nYQeCmC+MHDHZb9qHEGFecyQ9MMnrAcDfUTGTfZye0kTc6deTq4r76
	 MiSZKe7WozKrw==
Date: Tue, 28 Oct 2025 18:33:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
 dtatulea@nvidia.com
Subject: Re: [RFC mm v4 1/2] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
Message-ID: <20251028183356.29601348@kernel.org>
In-Reply-To: <20251023074410.78650-2-byungchul@sk.com>
References: <20251023074410.78650-1-byungchul@sk.com>
	<20251023074410.78650-2-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 16:44:09 +0900 Byungchul Park wrote:
> As a preparation, the check for net_iov, that is not page-backed, should
> avoid using ->pp_magic since net_iov doens't have to do with page type.

doesn't

> Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to a
> page pool, by making sure nmdesc->pp is NULL otherwise.

Please explain in the commit message why the new branch in
netmem_is_pp() is necessary. We used to identify the pages based
on PP_SIGNATURE, now we identify them based on page_type.

