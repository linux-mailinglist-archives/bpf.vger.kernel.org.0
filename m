Return-Path: <bpf+bounces-59220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B6AC74D6
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057A717BFA1
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 00:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB141401C;
	Thu, 29 May 2025 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMmTlEsV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B84A94F;
	Thu, 29 May 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477566; cv=none; b=pXxN6WLuHNz6CtSboICYHxwhrruf/qvIxon7OgUztxNbXWCn+YkBQuE3TaWKKodtqH8Qnm9sJGeXlofmhsL0NjtgawBnpM7g+1mBxhKuL1NLD2y5ho+5PK18A5voCIoPpta/QuwQstFo3sTeYwEJity283mxgktVQLOR7DFS/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477566; c=relaxed/simple;
	bh=jNERr1Xk5bpz4F/WT2JXlFK4lNMh7d3tBp6wYSlqrVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVh/OM0WFecLPW8nCOrsq4LLyt8qJE2Y7kAbkataHOtoN+OvyxOyib8OiXjCOz9YHsqhee7FmgHg0CyVv2rWxsLMuOxZalUj+hKXREV2E1EpVjGkTizyeCl4vTcI6MxQyitxf669GSB201GYbNK7rh4oalUyPU+NvXKTHuD6x+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMmTlEsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68460C4CEE3;
	Thu, 29 May 2025 00:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748477566;
	bh=jNERr1Xk5bpz4F/WT2JXlFK4lNMh7d3tBp6wYSlqrVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XMmTlEsVcghWCw7O9F26+oCZiJ1IynDUpqCiLg9N75XpabPkeLtlh25LGrBFMFvcg
	 LCqj8uYt3hGoXa3RbRA/M2aSxWpkZglZeSd0LxO62g50udAgEMgMigIHdPQHMbWb7u
	 r8eN7UOss7LN0HSZKBAjWqeXktDFOiqjLLhS+HrtVM2eDwTuZBl3iyGcDQ5ZGxGKKE
	 XEKG2N8hZiuJqKzyacZt/SShPL7REDjiz6TVgbuTM8pjUgBtNDMAjALVByQ3njdNVQ
	 spnBLn2+5CnQAwm5MC9KgBp3NFzgbojB5Bfqop3KbL9B6+hFxN/oKZgfB/S0g79x35
	 Feo8pjtCf5kvA==
Date: Wed, 28 May 2025 17:12:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Moshe Shemesh
 <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool
 tcp-data-split settings
Message-ID: <20250528171244.188534ec@kernel.org>
In-Reply-To: <676de326-df44-45c4-8ca2-3d1a2758abf2@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	<1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
	<20250522155518.47ab81d3@kernel.org>
	<aC-xAK0Unw2XE-2T@x130>
	<20250527091023.206faecb@kernel.org>
	<676de326-df44-45c4-8ca2-3d1a2758abf2@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 08:10:46 +0300 Gal Pressman wrote:
> >    features = on
> > hw_features = off
> > 
> > is how we indicate the feature is "on [fixed]"
> > Tho, I'm not sure how much precedent there is for making things fixed
> > at runtime.  
> 
> Isn't this something that should be handled through fix_features?

Yes, should work.
Off the top of my head after setting HDS to enabled and trying 
to disable HW-GRO we should see: "on [requested off]" right?

