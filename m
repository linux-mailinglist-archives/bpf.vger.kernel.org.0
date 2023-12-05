Return-Path: <bpf+bounces-16834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872DB80631D
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313471F21700
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD241760;
	Tue,  5 Dec 2023 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCcunRxY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970014123A;
	Tue,  5 Dec 2023 23:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DB5C433C7;
	Tue,  5 Dec 2023 23:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701820731;
	bh=y7BHMggNMyVLWocVtAJeFzIhuoTSI7WJB9Ya42bDpPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCcunRxYB49iecVNOoB875jbF2Efw6Fz9dexz6X6J4FR2np0/PhiID7vIYUARrKA9
	 jN7SrHTHP1w66d+kqvrjqYirJ1UGqg5Eib+uHe1ig73Ggd4Sfme6RgB/CCZ57dbgWa
	 j0t2EHNfFuEpU0Y6w5cWw43so4l+XY/bTcBpZx19ThHsymgAtDRifPhF662+jsh/sB
	 LCTdQF1qSL3nWuUKT9/BLW/+tYS4YMB0ZQLNwGJWQvCJBuPFH6OFZsW8ARD+LZGVuJ
	 ykjAOuDKF09uY+ooWecSC/XSNPjlnpvTBXwCzqzCSu0znxKNVy0YMr63S8UDY/S/z6
	 DeBWoPaP+B6Tw==
Date: Tue, 5 Dec 2023 15:58:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <20231205155849.49af176c@kernel.org>
In-Reply-To: <ZW-tX9EAnbw9a2lF@lore-desk>
References: <cover.1701437961.git.lorenzo@kernel.org>
	<c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
	<20231201194829.428a96da@kernel.org>
	<ZW3zvEbI6o4ydM_N@lore-desk>
	<20231204120153.0d51729a@kernel.org>
	<ZW-tX9EAnbw9a2lF@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 00:08:15 +0100 Lorenzo Bianconi wrote:
> v00 (NS:ns0 - 192.168.0.1/24) <---> (NS:ns1 - 192.168.0.2/24) v01 ==(XDP_REDIRECT)==> v10 (NS:ns1 - 192.168.1.1/24) <---> (NS:ns2 - 192.168.1.2/24) v11
> 
> - v00: iperf3 client (pinned on core 0)
> - v11: iperf3 server (pinned on core 7)
> 
> net-next veth codebase (page_pool APIs):
> =======================================
> - MTU  1500: ~ 5.42 Gbps
> - MTU  8000: ~ 14.1 Gbps
> - MTU 64000: ~ 18.4 Gbps
> 
> net-next veth codebase + page_frag_cahe APIs [0]:
> =================================================
> - MTU  1500: ~ 6.62 Gbps
> - MTU  8000: ~ 14.7 Gbps
> - MTU 64000: ~ 19.7 Gbps
> 
> xdp_generic codebase + page_frag_cahe APIs (current proposed patch):
> ====================================================================
> - MTU  1500: ~ 6.41 Gbps
> - MTU  8000: ~ 14.2 Gbps
> - MTU 64000: ~ 19.8 Gbps
> 
> xdp_generic codebase + page_frag_cahe APIs [1]:
> ===============================================

This one should say page pool?

> - MTU  1500: ~ 5.75 Gbps
> - MTU  8000: ~ 15.3 Gbps
> - MTU 64000: ~ 21.2 Gbps
> 
> It seems page_pool APIs are working better for xdp_generic codebase
> (except MTU 1500 case) while page_frag_cache APIs are better for
> veth driver. What do you think? Am I missing something?

IDK the details of veth XDP very well but IIUC they are pretty much 
the same. Are there any clues in perf -C 0 / 7?

> [0] Here I have just used napi_alloc_frag() instead of
> page_pool_dev_alloc_va()/page_pool_dev_alloc() in
> veth_convert_skb_to_xdp_buff()
> 
> [1] I developed this PoC to use page_pool APIs for xdp_generic code:

Why not put the page pool in softnet_data?

