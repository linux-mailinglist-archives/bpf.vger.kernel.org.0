Return-Path: <bpf+bounces-58996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8E7AC5209
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E946C177E6B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BEC27AC39;
	Tue, 27 May 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJdhWEyw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F868253B4C;
	Tue, 27 May 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359798; cv=none; b=HClO7PZ7PIBEWojZCguv9DCv5EXmHQwyRoAHF6/qwROO7mW1Ki+dYlssDZDRSlQlVSf2kOP+5K2saqio+WQ+sWTq86gevzDGH5PVPktnqPh4WH0WM6O+xFWXu0MRM6xPiOrbxmNgezVmBKcLuHoUK+b+meqf8rA19LJm7bThSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359798; c=relaxed/simple;
	bh=Vk53fYt1nW4pK+qZUNUp633gvpFt+L8UJhtfUNw23gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5S0Y+TuOfVOlC3qaKCHFN3ussmuOYkrEP/P78NeMnrw2NMh/byO7zBA6EKSYZpN+ghvkY+ztFEaI7JeVtxHa6Eg+GaNrTlA5uOEgBeNSsBPq+fi+xJT5HyYFSdrUF+9SNH868rfbg3Ita+edeBk65Fk73sJRHuu05gdUnHm6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJdhWEyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEC8C4CEE9;
	Tue, 27 May 2025 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748359798;
	bh=Vk53fYt1nW4pK+qZUNUp633gvpFt+L8UJhtfUNw23gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJdhWEywDMnzdI0MAPmPF6BwluSLZkutQF14TOWNJAq6P7cVJWblLBbHtxEQBvi+A
	 u8sgJ/vn4S3iod8x7dkHgMnne50S+s8BRqJ7NROIKLaPyDZtmvshtfPKxPAHvWlUrl
	 jG6AY3zA11iAkQ2R/GxO8igePkbZHnWtRCeEsbetDBX7mWN2y4Z2rHi5QAlaoL4BcW
	 vhls81ic+zyqSqfBYdwU4jJhH/II+nj8BEvjg2JA+V7Cuq3bvrxc0mtL5VRQzmp2ED
	 63Oawz6EPtsOi8rCpM9FlVj7l443ZMtUamcKHqIimMJ38u51yn/fOtIpFPH9WzHrbQ
	 uTDejf0vw9dhQ==
Date: Tue, 27 May 2025 08:29:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 06/11] net/mlx5e: SHAMPO: Separate pool for
 headers
Message-ID: <20250527082956.12e57fe5@kernel.org>
In-Reply-To: <aC-ugDzGHB_WqKew@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	<1747950086-1246773-7-git-send-email-tariqt@nvidia.com>
	<20250522153013.62ac43be@kernel.org>
	<aC-ugDzGHB_WqKew@x130>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 16:08:48 -0700 Saeed Mahameed wrote:
> On 22 May 15:30, Jakub Kicinski wrote:
> >On Fri, 23 May 2025 00:41:21 +0300 Tariq Toukan wrote:  
> >> Allocate a separate page pool for headers when SHAMPO is enabled.
> >> This will be useful for adding support to zc page pool, which has to be
> >> different from the headers page pool.  
> >
> >Could you explain why always allocate a separate pool?  
> 
> Better flow management, 0 conditional code on data path to alloc/return
> header buffers, since in mlx5 we already have separate paths to handle
> header, we don't have/need bnxt_separate_head_pool() and
> rxr->need_head_pool spread across the code.. 
> 
> Since we alloc and return pages in bulks, it makes more sense to manage
> headers and data in separate pools if we are going to do it anyway for 
> "undreadable_pools", and when there's no performance impact.

I think you need to look closer at the bnxt implementation.
There is no conditional on the buffer alloc path. If the head and
payload pools are identical we simply assign the same pointer to 
(using mlx5 naming) page_pool and hd_page_pool.

Your arguments are not very convincing, TBH.
The memory sitting in the recycling rings is very much not free.

