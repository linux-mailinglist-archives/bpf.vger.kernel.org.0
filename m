Return-Path: <bpf+bounces-68658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A00AB7EEFB
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7174A1886D2D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48E330D3F;
	Wed, 17 Sep 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyRjjmIy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A94333A81;
	Wed, 17 Sep 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113735; cv=none; b=pV36G2Ggg1wRMEj2YPgVV7cBE+qCV7nZCrZTx7ZuX9TRAGRTl4bWSE9p/JEvSL0zWzqyfFwpfHVXehbb28cjxBPbpGbvwwNPWesKKzQAjlhMyV7s0ddvnrjkgrECNxE4HRL93SPTnNj0mYhpZpi8DcipO4RMwSSC8FMJmQfddMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113735; c=relaxed/simple;
	bh=1rii4oGpASM1QR26Rz8kSoIQSEaQubBQ533eyDSQ9m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfPTTtqRhd5Rexv1IPEtcPUQH5qeyQRlxUCVtDmt6VtKyP1X85AgteW+y9NqcT3UhhwVp4ubIM/muR2I30aQiTkWShM1Bv0XDvR0QhkuYh3xihyh9paphjL5d80bbtwNMyZ0/88/20YOg6+B6xmMgRQYLyzX5/rv//b3KZru/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyRjjmIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63718C4CEF7;
	Wed, 17 Sep 2025 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113734;
	bh=1rii4oGpASM1QR26Rz8kSoIQSEaQubBQ533eyDSQ9m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyRjjmIy23OBUZVcu5h9WGQJmMAWCnBwHmsGcrv5Lx4BuzcahCCSfuitvcLlurEU2
	 LufL1DV9AwvCocoH65ie2ly+gvov4gzEEm+0+oIefB3g3MlCEnYkxm7lqN1AXns4F6
	 tMoCHIqNNfTWUv3KApJJKyc3dUikXRlHH35GjL1aXFPSPj+oan34jFy9GCwpJihtjH
	 wAM+MwoYTyFgRlkucGarHf81G0vV7n71d5DNB9KjRK+J6n5Zr/S2rZiw8e5sSx00U9
	 bkUZ7p5tPRfOWQYQUvZODBIhDYMdB+7ty2fN4SN5OgabVv/na2TkqGF6g8lDeGqe4R
	 pLATKqOFe8G2g==
Date: Wed, 17 Sep 2025 13:55:28 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next V2 08/10] net/mlx5e: Use multiple CQ doorbells
Message-ID: <20250917125528.GI394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-9-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-9-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:42PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Channel doorbells are now also used by all channel CQs.
> 
> A new 'uar' parameter is added to 'struct mlx5e_create_cq_param',
> which is then used in mlx5e_alloc_cq.
> 
> A single UAR page has two TX doorbells and a single CQ doorbell, so
> every consecutive pair of 'struct mlx5_sq_bfreg' (TX doorbells)
> uses the same underlying 'struct mlx5_uars_page' (CQ doorbell).
> So by using c->bfreg->up, CQs from every consecutive channel pair will
> share the same CQ doorbell.
> 
> Non-channel associated CQs keep using the global CQ doorbell.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


