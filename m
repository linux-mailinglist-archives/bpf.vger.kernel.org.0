Return-Path: <bpf+bounces-18347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1058193F1
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 23:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C005B2262B
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50133D0C5;
	Tue, 19 Dec 2023 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xhkXf21S"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C03D0AE;
	Tue, 19 Dec 2023 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=M7vYwyFBTmXa7mBCYsTu/n+QlJGbIPVud40PFjUfiyM=; b=xhkXf21S7LYXVoeF3VpoobRnb1
	Dv/PMqOfwlfkkNy03gDBHnf/IIFG77n6wGj0BTrf8LNTtz8SO9dBU+okjGyKQEGNouOKTwGupcAdH
	QEdbpM11JGfsOi69JGBQ5sHDaj4XjsPX+ZCJzy34OlxUIf397A4FHIEW6w5tMQLxXbcbbULfCsVK+
	36/PLyjx85RGIXKof1LCC8rO0Euokn+xoMjE8j/Nv8q/kPMxpP4lFvJuYTCQxYygpuoByjK4zKKSf
	SQ9SG+/Kh97kOTdsb4dsMpazvluGNzPLaTYf4UKtDg7XKTrO0MOoFZwSy/gzY0uFAQt5HQg9IICMu
	2m7ELvOQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFj1v-00Fdwd-1k;
	Tue, 19 Dec 2023 22:57:39 +0000
Message-ID: <41abf11c-dbd4-48b1-8ca3-746b62256da8@infradead.org>
Date: Tue, 19 Dec 2023 14:57:38 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] xsk: make struct xsk_cb_desc available outside
 CONFIG_XDP_SOCKETS
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 03:02, Vladimir Oltean wrote:
> The ice driver fails to build when CONFIG_XDP_SOCKETS is disabled.
> 
> drivers/net/ethernet/intel/ice/ice_base.c:533:21: error:
> variable has incomplete type 'struct xsk_cb_desc'
>         struct xsk_cb_desc desc = {};
>                            ^
> include/net/xsk_buff_pool.h:15:8: note:
> forward declaration of 'struct xsk_cb_desc'
> struct xsk_cb_desc;
>        ^
> 
> Fixes: d68d707dcbbf ("ice: Support XDP hints in AF_XDP ZC mode")
> Closes: https://lore.kernel.org/netdev/8b76dad3-8847-475b-aa17-613c9c978f7a@infradead.org/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> Posting to net-next since this tree is broken at this stage, not only
> bpf-next.
> 
>  include/net/xdp_sock_drv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index b62bb8525a5f..526c1e7f505e 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -12,14 +12,14 @@
>  #define XDP_UMEM_MIN_CHUNK_SHIFT 11
>  #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
>  
> -#ifdef CONFIG_XDP_SOCKETS
> -
>  struct xsk_cb_desc {
>  	void *src;
>  	u8 off;
>  	u8 bytes;
>  };
>  
> +#ifdef CONFIG_XDP_SOCKETS
> +
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

