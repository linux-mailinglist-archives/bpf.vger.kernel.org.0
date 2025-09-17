Return-Path: <bpf+bounces-68652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDA4B7EC8D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2125223D0
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18437288A;
	Wed, 17 Sep 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLrpvsbO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D117BB21;
	Wed, 17 Sep 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113612; cv=none; b=REt4d5kLt1KlTinH2ltOr0uoal/kmg0vd1xT1G7haEw37Gs/rS4MwKRyaJDFzJ85U/Qm3ANZind++zDQcoSGGPbsXdD72lw+LD0vicX35hpOhdChsqACP8TS077pehbXBD8EQGAk/P9Ia9FN8BCUFL9KobGS39wK5R6Xy5LdcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113612; c=relaxed/simple;
	bh=4/Ck4aYQJVRizYktx+vPIdxt5Gb8eCdlFraPkgODyf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apXxWlSRis9B9ETjr1O6cYt7hCDPqWNtWoc19ft6JM8obvhfms6Yz1Mdx9SByGNUPsAIZcwTYvvgZjTw0btLSxnIkg1gqOXj23qE8uUzRb5L6BzIMWKvJYEMS37RBPgHHOPak8mxqYRpwsFL3bvBrpiI72v1O8FOjsCNMnwjptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLrpvsbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1C3C4CEF0;
	Wed, 17 Sep 2025 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113612;
	bh=4/Ck4aYQJVRizYktx+vPIdxt5Gb8eCdlFraPkgODyf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLrpvsbOjESXCznjip/QDnEcSYLw5Vjk3t8QSEXlxIQnzVl8MpN/u/ERXL9fYHTxL
	 KPOdIf2PE+fGtIv3HUOQbqivx0bl7+DTM6T4ynk3pn7tAP45nkzAhucP6jPWOz+X/K
	 23819b9oOcAFKZ9Df6DEgl81dw4k7rRvwnoeNTUPiN84FECbb6gDQaU3wXxw5aLi4G
	 DDdQDo1mD+6SUPUDGDFIugLE9G9XiaQ6KxdU4mU/xIE3hsnkd1oWA37+gBvcvzCrtp
	 3oYCMMsAwXwbpCTME5TewAuTHrlKbbM973qBdFsxmN+F6gf8+RG1oeCtdgYlo7K0xk
	 +gGajWJWn+xmg==
Date: Wed, 17 Sep 2025 13:53:25 +0100
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
Subject: Re: [PATCH net-next V2 02/10] net/mlx5: Remove unused 'offset' field
 from mlx5_sq_bfreg
Message-ID: <20250917125325.GC394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-3-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:36PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The 'offset' field was introduced in the original commit [1] and never
> used until commit [2], which added an unnecessary use.
> 
> Remove the field and refactor the write-combining test to use a local
> variable instead.
> 
> [1] commit a6d51b68611e ("net/mlx5: Introduce blue flame register
> allocator")
> [2] commit d98995b4bf98 ("net/mlx5: Reimplement write combining test")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


