Return-Path: <bpf+bounces-67043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EFDB3C517
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FB2A66529
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EEB2D0C7B;
	Fri, 29 Aug 2025 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQyoJhCK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629EC27B343;
	Fri, 29 Aug 2025 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507166; cv=none; b=CTyx5oxHA+qHNoS4fwKYXKmo0hHcLaqrGgkLcURmXPcODIiDsRaqUX15JA7lxe4kMR5rbeD20EzJLkMhGkPh8VTQIoOj2VP6mtBjsWot08mCHSkIUBtm2nA9zYLJKp828HC+eZLa61e9Z8Sik0GfQjeBkTmd1XQ7H9ZzykLRubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507166; c=relaxed/simple;
	bh=t2zZa6cbOCIKOz62d3QuseK7Ch3T+oSbhGOp7t2vibU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMNEJ2ncbt52ug0wYX2HbIBa3CPKYKd6XvqSOtEQwgO3ASfWr2TOUCeUVeAOrmAPpjmzZ8cm90Oh05Yh28r3qTzxWqHzjJUDHXY7o8pHivMVKU//QvGEIv0uMttcRkjp34KCxGWfXwk107eJSIdAfxZ449XZaX9hf+fv8iN8wgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQyoJhCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD19AC4CEF0;
	Fri, 29 Aug 2025 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756507166;
	bh=t2zZa6cbOCIKOz62d3QuseK7Ch3T+oSbhGOp7t2vibU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQyoJhCKLC5zBOiw+VWg+BHxV5v2Hx9Uc2SLDRRDlYYzRK5N2mveTLjI+hBuxALRT
	 9wedkCz0CJMPjERQ4+UycivctCDk76UUel8Qv9Ff+gw9h36UcAm+SGVLv9VbjdaOJb
	 8igjtpAo4dwGDAhVp977T6FaUU2Yk97TP57sD0xi0p7ftcjl6uo8FAQN8b1A//yY6r
	 U7qj9gm9EWdpzz1F7aDgcQR7/y5oNEaLHSQQyPgKLo8s9oAnFljTYfoGQHNXTn5CQp
	 7wXjejcWfjFMngDcsWrnItXQ+Eb6XjSYnbhrp1qL/7Hhw4Nx74h6QLiwdP97L+1RQ2
	 dzVNoG9mnghZg==
Date: Fri, 29 Aug 2025 15:39:25 -0700
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
Subject: Re: [PATCH net-next v4 1/2] net/mlx5: DMA-sync earlier in
 mlx5e_skb_from_cqe_mpwrq_nonlinear
Message-ID: <aLIsHYBqvTNhqlBf@x130>
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>

On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
>From: Christoph Paasch <cpaasch@openai.com>
>
>Doing the call to dma_sync_single_for_cpu() earlier will allow us to
>adjust headlen based on the actual size of the protocol headers.
>
>Doing this earlier means that we don't need to call
>mlx5e_copy_skb_header() anymore and rather can call
>skb_copy_to_linear_data() directly.
>
>Signed-off-by: Christoph Paasch <cpaasch@openai.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>


