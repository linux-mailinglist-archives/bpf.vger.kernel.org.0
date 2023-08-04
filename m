Return-Path: <bpf+bounces-7043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061CA770A2E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E10281AC3
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F551DA53;
	Fri,  4 Aug 2023 20:59:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB381DA40;
	Fri,  4 Aug 2023 20:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC36AC433C7;
	Fri,  4 Aug 2023 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691182779;
	bh=xl9ztlWBE79b1gyAU0i58q8O4xnhwyApAJm9B8ORFps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLfT6PIF0sqgoaK3n/922Fa8/0gbGRWzzj/dTE1NEb80e9p+UDpiPw2Etmo+/399F
	 gj9QhBEPBBkXT5rVG+n+aVfTO5n5cQEgDp7vKsiCOQTWE2G5mVWENI7oF+HvuRKhei
	 n63JWg+aVkNjc7zs5ZpdAdJQ+twt7S4EIrIeLo9FxqBCcy0LQOCJGF4vI5ht4ChVQ3
	 EoPnAjDeuBIREbrezDZJYMGXa0DGk2DyGSOqh6Q7/MA5Te6zGXxa3yLrPxTPK1O0j8
	 HKREwC78Jxros3kkvSp3NchfTEtcKZI2/aVErOMd8Ta0xAk/6R1ljGKOrvZV5cWP9/
	 wcuhxNsK5XIow==
Date: Fri, 4 Aug 2023 22:59:33 +0200
From: Simon Horman <horms@kernel.org>
To: "huangjie.albert" <huangjie.albert@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Menglong Dong <imagedong@tencent.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 05/10] veth: use send queue
 tx napi to xmit xsk tx desc
Message-ID: <ZM1mtcIBUzL5kwll@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-6-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-6-huangjie.albert@bytedance.com>

On Thu, Aug 03, 2023 at 10:04:31PM +0800, huangjie.albert wrote:

Please include a patch description.

> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>

Please consider formatting this as:

	... Albert Huang <huangjie.albert@bytedance.com>

> ---
>  drivers/net/veth.c | 265 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 264 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 63c3ebe4c5d0..944761807ca4 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -27,6 +27,8 @@
>  #include <linux/bpf_trace.h>
>  #include <linux/net_tstamp.h>
>  #include <net/page_pool.h>
> +#include <net/xdp_sock_drv.h>
> +#include <net/xdp.h>
>  
>  #define DRV_NAME	"veth"
>  #define DRV_VERSION	"1.0"

> @@ -1061,6 +1063,176 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  	return done;
>  }
>  
> +static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool, int budget)
> +{
> +	struct veth_priv *priv, *peer_priv;
> +	struct net_device *dev, *peer_dev;
> +	struct veth_rq *peer_rq;
> +	struct veth_stats peer_stats = {};
> +	struct veth_stats stats = {};
> +	struct veth_xdp_tx_bq bq;
> +	struct xdp_desc desc;
> +	void *xdpf;
> +	int done = 0;

Please try to use reverse xmas tree ordering - longest line to shortest -
for local variable declarations in new Networking code.

https://github.com/ecree-solarflare/xmastree is your friend here.

> +
> +	bq.count = 0;
> +	dev = sq->dev;
> +	priv = netdev_priv(dev);
> +	peer_dev = priv->peer;

Sparse seems a bit unhappy about this.

  .../veth.c:1081:18: warning: incorrect type in assignment (different address spaces)
  .../veth.c:1081:18:    expected struct net_device *peer_dev
  .../veth.c:1081:18:    got struct net_device [noderef] __rcu *peer

Looking over existing code in this file, perhaps this is appropriate:

	peer_dev = rtnl_dereference(priv->peer);

Likewise in a few other places in this patch.

...

