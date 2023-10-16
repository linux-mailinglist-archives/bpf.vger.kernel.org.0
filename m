Return-Path: <bpf+bounces-12356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0FB7CB723
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 01:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885431C20BE8
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 23:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82563AC11;
	Mon, 16 Oct 2023 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjKzgOSg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADDE27EE0;
	Mon, 16 Oct 2023 23:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F588C433C7;
	Mon, 16 Oct 2023 23:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697499875;
	bh=oFuxPdpaNB8m5pp5S98JZPxGfiIVvYYQZLP+wDFXuxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HjKzgOSg1ndBP+2avMhlKbnTECj7h1DEdLwoKgfbtTExy2mvGRLti0ugpGhsWCVjG
	 QhcvgfpjH1o/rTJ0qh8ZUxzbVpPL9Jt11Iz+x7tbyi8kBiIPskFPefcfp+5N1t4G0p
	 awPvMKixGVglvhBHX88nM9NpdxVDpp+tdHbPK/auXa7fD8T9oj0WJgq/0gIGduyeIk
	 Iz24hvuKdeIuCWGRXizEyaSC/HtIP4Xbngaoz53arFOjJBLdS8Y3s8gEDHRvuU40s0
	 O3dZPSD8tvDA/RsO8GNsY6fc6Edarg7RSeRqO1ABjJ0xxYi++pzrg1lPGeWzQFA+WQ
	 hd1m96M3bokeA==
Date: Mon, 16 Oct 2023 16:44:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 13/19] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Message-ID: <20231016164434.3a1a51e1@kernel.org>
In-Reply-To: <20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
	<20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 20:00:27 +0800 Xuan Zhuo wrote:
> @@ -305,9 +311,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>  
>  			stats->bytes += xdp_get_frame_len(frame);
>  			xdp_return_frame(frame);
> +		} else {
> +			stats->bytes += virtnet_ptr_to_xsk(ptr);
> +			++xsknum;
>  		}
>  		stats->packets++;
>  	}
> +
> +	if (xsknum)
> +		xsk_tx_completed(sq->xsk.pool, xsknum);
>  }

sparse complains:

drivers/net/virtio/virtio_net.h:322:41: warning: incorrect type in argument 1 (different address spaces)
drivers/net/virtio/virtio_net.h:322:41:    expected struct xsk_buff_pool *pool
drivers/net/virtio/virtio_net.h:322:41:    got struct xsk_buff_pool
[noderef] __rcu *pool

please build test with W=1 C=1
-- 
pw-bot: cr

