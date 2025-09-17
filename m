Return-Path: <bpf+bounces-68660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1CB7EF73
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706D018925AA
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239A332A57;
	Wed, 17 Sep 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/PC3TTo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42239332A48;
	Wed, 17 Sep 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113809; cv=none; b=iztCd3TcQ5gclgkoLIT0bte2oKLiQJXfq9yEoGY8ct/CRSDkkyWurFDf1xOAuJmT0hMI4v6eekc5d/LxqNdjk18oGzSPq/zIv/uZqfNYUCj5rQ148KkHYS3tJJJ/llII62pp4tG88xIal5zbF7N8fT7/nSKBHRzsuL7I/iPODyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113809; c=relaxed/simple;
	bh=zEj2Rp5RyjDVROtWpXDizElasqtxRk4iUytBJagOPEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OagbvW+bUWMW+x3ALyl+5fweevgQ3PY1d8+0yLcV9uovczkfZRQp4b4BOX4A1A3Jusc9cYKdbmSdnlil4gOghNi/cNYoYoSDmCf4ojJyU+x2O0b/au3jyrzWlPhvdvmsEhW2HrJLXiATnis0eTv/4HSDH+DfsS8fB9Fw+laR6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/PC3TTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A91C4CEF0;
	Wed, 17 Sep 2025 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113807;
	bh=zEj2Rp5RyjDVROtWpXDizElasqtxRk4iUytBJagOPEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/PC3TToIpCiYCLixtG9bxfOoxSmZNunsRNfIuI216czk9XQfcLnlmY/z0Nj0A3OL
	 CBnJqlEq9/EgmcxydSJ6Cel7fCmZvBCDDGR/4ymTjlxLEWcrKOMdAtYdDZxHMNyyNU
	 hkmXjHDx1XWhKlHGpN02/cqy/LyQAi0LkzXs7LemV9sLyrnZMOmQbLyslyyzQc+rE2
	 P+UEjjDEiIO6ttCVinYjNdi8L1TXG3ewjbtQsQvqgUFIIMirPxomTrukncdDzaO7ne
	 KfQ3FCWXVoPHBXrPnZOv95Vqx2i+txPfrNJsXM74Gqbk9fgVfiTCzWkwdTfkq77XYE
	 PezoyfUxMoMHg==
Date: Wed, 17 Sep 2025 13:56:41 +0100
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
Subject: Re: [PATCH net-next V2 10/10] net/mlx5e: Use the 'num_doorbells'
 devlink param
Message-ID: <20250917125641.GK394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-11-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-11-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:44PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Use the new devlink param to control how many doorbells mlx5e devices
> allocate and use. The maximum number of doorbells configurable is capped
> to the maximum number of channels. This only applies to the Ethernet
> part, the RDMA devices using mlx5 manage their own doorbells.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


