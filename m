Return-Path: <bpf+bounces-6387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2F47686FD
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 20:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F3D281746
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024914F78;
	Sun, 30 Jul 2023 18:05:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68954E565;
	Sun, 30 Jul 2023 18:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B4C433C8;
	Sun, 30 Jul 2023 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690740350;
	bh=JcmP0jZQuU7m7iyGqTMMeCJYBU3IouKkKwVIcw4W+A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQ/f0JlHkBmgyEZOF1pj6vH3VJfaiZemWh5agS/RAXQxPeh/HeH6k/Rw3M2DsLIVx
	 mnX2neqey9P6zcEsaRjHNtIsVsV/l8Yo8j6iQcdCs+6rYCPnOnVQUQuy4pqCATXhEV
	 0ER2Cob/lhE5tSTe5i+7f5oQrG85b0XaZ07MISzUKsAm8w8+DHgjoFCPCecr5ANeJ0
	 u59hLccXyyRqJ8Dm+mPi4ZbNYlYLoreAyBUnPgQry06c5q6Dgq/vZp9+rq7iathX6W
	 313krYnxdk41TNyni8hv1dmvIM3EheLTOS4847Tuc+O1UliEgC05lsNMqciBX8k0Ne
	 O1IdMYqhWTvCQ==
Date: Sun, 30 Jul 2023 20:05:46 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: Remove unused function declarations
Message-ID: <ZMamembdZQC1+F80@kernel.org>
References: <20230729122644.10648-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729122644.10648-1-yuehaibing@huawei.com>

On Sat, Jul 29, 2023 at 08:26:44PM +0800, Yue Haibing wrote:
> commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
> left behind tcp_bpf_get_proto() declaration. And tcp_v4_tw_remember_stamp()
> function is remove in ccb7c410ddc0 ("timewait_sock: Create and use getpeer op.").
> Since commit 686989700cab ("tcp: simplify tcp_mark_skb_lost")
> tcp_skb_mark_lost_uncond_verify() declaration is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


