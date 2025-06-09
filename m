Return-Path: <bpf+bounces-60067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0697AD2247
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C5816461B
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5031E5702;
	Mon,  9 Jun 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPnLMRsZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95619992D;
	Mon,  9 Jun 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482514; cv=none; b=XqXAsoSlNr08X+pULI8Fb5J1+mPPCCkHnxrWWRnDl+/c/N8Fs8pOncwyZQALdQ8RwKBNJhx+9oCD0gwLLy5yJVdBSKe/iWErWzLiR/0t/UAnZ6k0S5AWE3YERUbK2aoj4PKlunQjofEJTRxQHQMZ/VJNwt/mlrfKmnzxsGNCEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482514; c=relaxed/simple;
	bh=RAIZr91P52A43t1NLsPlreqriBfynim6B6+rykmjSu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDqtxhsWZSQSfUrcmfZzIuFmopZIS7pvChquHdhwZ4T6IDsiwJqIn9MXbV1n0woLHBnjcb7ga/eykAIWYVd2BaU2ETbrx7TMMd1jhIkCjzF/yXFPKqpvgTcm/oCRBLrHvI2QZtfxQZaOCYbH3i6I70eppbCbbHflVthfyCQnRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPnLMRsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D931C4CEEB;
	Mon,  9 Jun 2025 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482514;
	bh=RAIZr91P52A43t1NLsPlreqriBfynim6B6+rykmjSu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QPnLMRsZVXoD9cUFtGg3aWli2wJ0wmm2pflTfFNeWsVVVs4OGLd+wK2wE0K4y27CD
	 jzROgPEOCf7Hn5zEg+KX25MgN8wfi8RxktENKFJiArT3aRv4m2N/203ZIIpaXUsJOn
	 IIln02tuIC5/0MkJXoUUL8vhl4HNTR2yhzEZkeSHmMmZxngL5OlkdhqX+T5gZRyONm
	 VlQ73VKgKQiyBJ9ydOvweJYSuREDNy408GbccYzyXE0lWrIFb2cSUG11Zb6Q+sb+4n
	 TgAKe4U749EnqQZblQcUm4ipDOZHqI2OHrlbmxEovoSCFP2LkCuTV4220nnOLn/fHs
	 416eyT7/qJ3dA==
Date: Mon, 9 Jun 2025 08:21:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, <saeedm@nvidia.com>, <gal@nvidia.com>,
 <leonro@nvidia.com>, <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Simon Horman <horms@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v3 07/12] net/mlx5e: SHAMPO: Headers page pool
 stats
Message-ID: <20250609082152.29244fca@kernel.org>
In-Reply-To: <20250609145833.990793-8-mbloch@nvidia.com>
References: <20250609145833.990793-1-mbloch@nvidia.com>
	<20250609145833.990793-8-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 17:58:28 +0300 Mark Bloch wrote:
> Expose the stats of the new headers page pool.

Y'all asked for clarifications on this patch 2 weeks after v2 was
posted and then reposted v3 before I could answer. This patch must go.
-- 
pw-bot: cr

