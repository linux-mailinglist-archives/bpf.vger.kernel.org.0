Return-Path: <bpf+bounces-67045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AAAB3C54F
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F50CA209A8
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 22:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF972D6E64;
	Fri, 29 Aug 2025 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnocQWii"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B92DAFBD;
	Fri, 29 Aug 2025 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507393; cv=none; b=q9MRyDAjsSq7NdYOKL/aFfub8/fFu0Ns/Qc5t3R4+p58supWzHIiH2jBrWLWx/dhrTpq0n74ssjek2pIuM5w2iFRbWqNJ+v/T5ZZ7pojOKTGb1i3SNdsucEeRRD3JjH+BOecOMFoEQuE7KQ2QQBywp3r/J75fV8u58/5luSAcBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507393; c=relaxed/simple;
	bh=ndLcDPeWdN0wA/DqMpvNhcnp+pz1BGrAusiuh4ipoZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQSKIsSJPeH7+oELkltYz5zGN7M0+etPAFFoKMZrktVKyMh56FeVE0u0mLlh5HG0tHJAvhGgetROouVW+My3Ge0lB+lcKzYFhLohxEQK18V/xZWMNyRZRoVAUQ9KbXFf3en1TLwhGNc057FKr/WtfGmYHfV38FBHTOpv+YQlrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnocQWii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F0C4CEF0;
	Fri, 29 Aug 2025 22:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756507392;
	bh=ndLcDPeWdN0wA/DqMpvNhcnp+pz1BGrAusiuh4ipoZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnocQWiiwbqNCSnULb0Q8VaKKsRkgCBvomsAiupePPOlZ0m4VDs5AX4u/M3C9mP+q
	 p0NwzqV10rYMOw2wnnFKztItsSfVIrI5Ngsr31s8UjvO0bMkXWYRKz//dpdH+VOqej
	 s1Pw92nQwOZ8H+v2YLUzXxTyNqrwxdBUNOejpflfqjcph/OxPL+abaWehP/yXfeMGO
	 /bzZsxjCh2lX36xQM1GofOpISlIAoW6vgyOGBDnzxxOk0Wmv1sY5XHc22m0wrxu3+n
	 qGuoK9CoV52thU7J+qbO2bzAB4uzi5/KhxKWNu3wbn6kouPp/g6zVrMIfbNRYL6dj4
	 uXoJg8FTIsdOA==
Date: Fri, 29 Aug 2025 15:43:11 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
Message-ID: <aLIs_-lDKHCLTrTy@x130>
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>

On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
>When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
>copies parts of the payload to the linear part of the skb.
>
>This triggers suboptimal processing in GRO, causing slow throughput,...
>
>This patch series addresses this by using eth_get_headlen to compute the
>size of the protocol headers and only copy those bits. This results in
>a significant throughput improvement (detailled results in the specific
>patch).
>
>Signed-off-by: Christoph Paasch <cpaasch@openai.com>

LGTM, I would love to take this to net-next-mlx5 and submit it back to
netdev after regression testing if that's ok? Christoph? 
Anyway I will wait for Jakub to mark this as "awaiting-upstream" or if he
applies it directly then fine.



