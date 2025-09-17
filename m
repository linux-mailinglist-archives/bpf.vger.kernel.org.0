Return-Path: <bpf+bounces-68657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC2B7EE1D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC14F3B7A55
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D81333A9E;
	Wed, 17 Sep 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyJj+cYJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B323333A81;
	Wed, 17 Sep 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113716; cv=none; b=rLSpavd/pI/LKPWyVAPZRpizBbTrsYJcroe6uGRxPWqVAx4xch5srjpamZjrWLFdPTHz4e5rWyJGPfq+kUUF9cUogXmydcIO4LCCNk8r0Ce/cieWaX96THfuUpq+HTPjG1eEXRPC7jnlJi4uEimVxVpqKIEp56rWP+b7kM6MxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113716; c=relaxed/simple;
	bh=TYQtlgvSng2iFA2KlYjo/e56uqI8meuMRZgjEowGrMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKogWHpgec2wpoDqcjZaCzZQjL/lHBrcw9tzy2kG+Xj3t/5a7YAkOvdum+ccBT8yPCCA7XAVvndphRlHcXomTdZxIvaM1yzzunFUERM52nw5GTrnlywoZCgGRXMUEzKkhJTip8fhUtPE9obLd0UGuUGRRt0wPZoGoI/T/JF8Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyJj+cYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A164C4CEF7;
	Wed, 17 Sep 2025 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113715;
	bh=TYQtlgvSng2iFA2KlYjo/e56uqI8meuMRZgjEowGrMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyJj+cYJH8/TjSQfgk7wpnEYPd6AxDkX5rJ2tyTC2r1YF+728aFMSAOCQdbqN7CPa
	 LQUCCyq2hS0slPTVVcoe9ao+uEowCwYgtfcWWU8I/JUApuQxZ8v+mZyUoJDAY2E2Wy
	 d7K+2Sy/6BicAasfd8yCDHgnhKCv86BpLTJh7LqGS2aOorFl96JoMee1x5+tbX4k2c
	 t+1huNrrN7AOHeaGxP4IVqIf+HJt6XzAokY4Wp5OFOw75QEAPTuPOO0jyKis+1kUac
	 UaHdu1meuwZFPkcAD8CgtNO0fVt/ygqBCNKBTU2FNQlka+Yrkcl1ghiF8lctBKvrxu
	 4qP2AGXYskzyw==
Date: Wed, 17 Sep 2025 13:55:09 +0100
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
Subject: Re: [PATCH net-next V2 07/10] net/mlx5e: Use multiple TX doorbells
Message-ID: <20250917125509.GH394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-8-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-8-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:41PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> First, allocate more doorbells in mlx5e_create_mdev_resources:
> - one doorbell remains 'global' and will be used by all non-channel
>   associated SQs (e.g. ASO, HWS, PTP, ...).
> - allocate additional 'num_doorbells' doorbells. This defaults to
>   minimum between 8 and max number of channels.
> 
> mlx5e_channel_pick_doorbell() now spreads out channel SQs across
> available doorbells.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


