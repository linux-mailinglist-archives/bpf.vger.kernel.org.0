Return-Path: <bpf+bounces-68654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F65B7EDD2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69897323563
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67CE32898F;
	Wed, 17 Sep 2025 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpvVpZN9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162132898D;
	Wed, 17 Sep 2025 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113653; cv=none; b=lDYkUZpZiA2dWp4uRxvtXWRuX9eKnC4WGZX7bTDjuNZxuSyN/Or+6IzOLM7HuWAz/Eongxc05Q9olTNt6BR+G9gmS5rBgFT+XuVzi2DdzLKjzefyI4VNb1fdzJzUSA2v+NQ2v751CBZNSBu/G8iseRSzezWfDf/x9TZS8XdF2U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113653; c=relaxed/simple;
	bh=fKWWjan0F+DRvN6Ki79/EKzldq4RAA5ia6Zi71l1aRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsnT+9xVA/3OVT0qb7Pqx6VHMLbW6vJA0Dvl0UWj8/cEAgx92pmVv6Sq+3fqMlXTrI0pRuGsZslQ46+CqV9Z/QLLqhqkClbCgpIE+AnXvyhhxSM+ugWdM8NU3xj2H9A+/+dDdyKIeOTcz+dXgRAyfo5rsKCwH8Dafg8y3lG/Vlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpvVpZN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64112C4CEF5;
	Wed, 17 Sep 2025 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113652;
	bh=fKWWjan0F+DRvN6Ki79/EKzldq4RAA5ia6Zi71l1aRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpvVpZN9xBesMlb6Pn3qnXkpdpFW1ofyyu/GQJBqb4b8yDGMnaPaznFWs1lfEBOqQ
	 R/E2K0bv1x21mQf5V2gKWge/xzXGX4APCtz/i6VMXnSggX0ZtFRaaZQpHGk/7SK2AR
	 lERP9qCaEwBqRlEBWfzcKSUEGv8l7HOof7y3Lof05rLRuNkMbxg/Bd5w2QbY+iZfoa
	 YMebQ3v7ewFwC3yeQjhG1mwP+zgMfKdLsxnHfXUtRhS9OjrVs/0+Ty+z+V0hPsN3GG
	 ER803p4bJmssPD9GHoNvXR/0iBZNI+OOUf9YZpsb7FIsmavwmdKQHj4rK4k8Smwy5j
	 s+LjvGjauRjhg==
Date: Wed, 17 Sep 2025 13:54:06 +0100
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
Subject: Re: [PATCH net-next V2 04/10] net/mlx5: Store the global doorbell in
 mlx5_priv
Message-ID: <20250917125406.GE394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-5-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:38PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The global doorbell is used for more than just Ethernet resources, so
> move it out of mlx5e_hw_objs into a common place (mlx5_priv), to avoid
> non-Ethernet modules (e.g. HWS, ASO) depending on Ethernet structs.
> 
> Use this opportunity to consolidate it with the 'uar' pointer already
> there, which was used as an RX doorbell. Underneath the 'uar' pointer is
> identical to 'bfreg->up', so store a single resource and use that
> instead.
> 
> For CQ doorbells, care is taken to always use bfreg->up->index instead
> of bfreg->index, which may refer to a subsequent UAR page from the same
> ALLOC_UAR batch on some NICs.
> 
> This paves the way for cleanly supporting multiple doorbells in the
> Ethernet driver.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


