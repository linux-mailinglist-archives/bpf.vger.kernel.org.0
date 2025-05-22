Return-Path: <bpf+bounces-58793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04963AC1832
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5EEA43F62
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D923F2BF3EE;
	Thu, 22 May 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWuWDToP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DD18DB3D;
	Thu, 22 May 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957411; cv=none; b=gOjk4KnfA3yyplbqEUVuquLwHkTHOVqP1gBNnLA6tdFzrD0I+74oAUDwG0c+UchKuSEA3eG+c0mbLFsiaPy/aTeDQxmaX/aDfY+A1RiihOHC5wgno9xKrj84mbk9ET7Mwap/LygaJJe/N05y7ElwV9fpXUVgeGxC+s5CFmnuufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957411; c=relaxed/simple;
	bh=7Gb32f9bYDWi1Og1ZY2jtns/XFCPsjEPQI+QrgJnOts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA91rByxH35lrxd/9T40Omq8z4kNMEXzKsafwRMEuEIIPqZRK6e3QfbCMEHugRYS3d9wfaKpLTYTDdfzsgBg2NQ/pFpzzTPlsWqlQU4GY+scf5DlGY8lJXgjGU393vbOmkIv9a1iIuZUHs3A6qrliS1xfXS3MY0pDn61D69pna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWuWDToP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B6CC4CEE4;
	Thu, 22 May 2025 23:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747957411;
	bh=7Gb32f9bYDWi1Og1ZY2jtns/XFCPsjEPQI+QrgJnOts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWuWDToP0rDCUNe9++IHIlNdhY1b3/q9m0R2Rn7wZVQfCq10lqbrSgHZptYNqZruS
	 Iz47lKjyKR5o1nri1fcHZM9nGHGrFWd+xB2GuRS6bmLtCYRxNcQRcNMWewb69nydKO
	 jWdcb4WA34A+pTCmJ1J1ApJbT7HdKJdkncilb4ztb0eqSzTne2w+Yby+wiuk/lqNcD
	 H5ip+6ogWqkAdJZ8iIgvumRTkEr4pnIqSM+IgmL0VvSDYwvnOGrtNDXofrzkRkTWdV
	 L3z5SoFBCDb0aC7f/lFM8sjQipLCeU1j6X/zYrCvfP/cL1xmOFG63H0V3EIM5mp8SC
	 5aEO2Rt6bUvUg==
Date: Thu, 22 May 2025 16:43:30 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 06/11] net/mlx5e: SHAMPO: Separate pool for
 headers
Message-ID: <aC-2ol2jMkHxV3RM@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-7-git-send-email-tariqt@nvidia.com>
 <20250522153013.62ac43be@kernel.org>
 <aC-ugDzGHB_WqKew@x130>
 <CAHS8izNPJjAwbVwDnVQwHmjTKfxSqbt-jEnNzcWzTfQNGr9Lag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNPJjAwbVwDnVQwHmjTKfxSqbt-jEnNzcWzTfQNGr9Lag@mail.gmail.com>

On 22 May 16:24, Mina Almasry wrote:
>On Thu, May 22, 2025 at 4:09 PM Saeed Mahameed <saeed@kernel.org> wrote:
>>
>> On 22 May 15:30, Jakub Kicinski wrote:
>> >On Fri, 23 May 2025 00:41:21 +0300 Tariq Toukan wrote:
>> >> Allocate a separate page pool for headers when SHAMPO is enabled.
>> >> This will be useful for adding support to zc page pool, which has to be
>> >> different from the headers page pool.
>> >
>> >Could you explain why always allocate a separate pool?
>>
>> Better flow management, 0 conditional code on data path to alloc/return
>> header buffers, since in mlx5 we already have separate paths to handle
>> header, we don't have/need bnxt_separate_head_pool() and
>> rxr->need_head_pool spread across the code..
>>
>> Since we alloc and return pages in bulks, it makes more sense to manage
>> headers and data in separate pools if we are going to do it anyway for
>> "undreadable_pools", and when there's no performance impact.
>>
>
>Are you allocating full pages for each incoming header (which is much
>smaller than a page)? Or are you reusing the same PAGE_SIZE from the
>page_pool to store multiple headers?
>

Multiple headers MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;

>-- 
>Thanks,
>Mina

