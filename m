Return-Path: <bpf+bounces-9406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B140797340
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF0B281622
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6A11CA8;
	Thu,  7 Sep 2023 15:12:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA211C96;
	Thu,  7 Sep 2023 15:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA86C4E661;
	Thu,  7 Sep 2023 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694099575;
	bh=MPXGxJFR8NmLLHTV3zFKRhMrwBtqjiGU9svB9/VPn7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRw7KfQZUDN+6xmxcblj9xKHDAcSTsHQhosMnKBkwf8WiGGPVT9Tb0bgqPt/FrRXc
	 vKdsS4taHYAVXzS0aFjKljE1S2NzBlmYsBF9fDbO8aO2uPUgMEPZy8vZFxMO/b8+23
	 WE665YbljsH7ARYCPLxiWs79Og+TJJdywc1lQfAFA1Y+xkOrVVehNFfmdZaa+6EGuh
	 PYBjisiqCgh9hdkDj2o7YnLBPOzVCiEh+AC0Alqr53RjZxZZl77nmrGOKQG4UgYMUk
	 OKIWe5Rk4eto+PRrkhq/dICAQ/DYvwor1DT4U912V8FPXyVaDcVIGpvoYUNU91u3I3
	 0Cmjp5qb32dKw==
Date: Thu, 7 Sep 2023 17:12:50 +0200
From: Simon Horman <horms@kernel.org>
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next] xsk: add multi-buffer support for sockets
 sharing umem
Message-ID: <20230907151250.GH434333@kernel.org>
References: <20230907035032.2627879-1-tirthendu.sarkar@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907035032.2627879-1-tirthendu.sarkar@intel.com>

On Thu, Sep 07, 2023 at 09:20:32AM +0530, Tirthendu Sarkar wrote:
> Userspace applications indicate their multi-buffer capability to xsk
> using XSK_USE_SG socket bind flag. For sockets using shared umem the
> bind flag may contain XSK_USE_SG only for the first socket. For any
> subsequent socket the only option supported is XDP_SHARED_UMEM.
> 
> Add option XDP_UMEM_SG_FLAG in umem config flags to store the
> multi-buffer handling capability when indicated by XSK_USE_SG option in
> bing flag by the first socket. Use this to derive multi-buffer capability
> for subsequent sockets in xsk core.
> 
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> Fixes: 81470b5c3c66 ("xsk: introduce XSK_USE_SG bind flag for xsk socket")
> ---
>  include/net/xdp_sock.h  | 2 ++
>  net/xdp/xsk.c           | 2 +-
>  net/xdp/xsk_buff_pool.c | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 1617af380162..69b472604b86 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -14,6 +14,8 @@
>  #include <linux/mm.h>
>  #include <net/sock.h>
>  
> +#define XDP_UMEM_SG_FLAG (1 << 1)

nit: This could be BIT(1)

