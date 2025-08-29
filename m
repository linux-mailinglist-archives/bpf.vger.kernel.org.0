Return-Path: <bpf+bounces-66933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673ACB3B1B4
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CA41653B2
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53652222BA;
	Fri, 29 Aug 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo5N1zBG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B54202980;
	Fri, 29 Aug 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438602; cv=none; b=nRf3HMOxNZGFcHioiyPEHTr96nIIF3GuQ9r/gyfDEYrJIRnfI0o32h7MyW2Jp7M/XO99THEbZTX1BYzzTcbsCn7HwPBd50eobCxF0liIabwfHImJmDbE/RuogsO45FWYwTmjipK5IVTH7M6m+H6At+3EIDyQZeAAkWBmBjaV3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438602; c=relaxed/simple;
	bh=Qdi5PQByB+cZnsu7FZTp9R8jf7yPNPN2X4NHeN6UBbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9Z96fOCHKlWjVuCIJH+U+ce6K6ucb05bz77CoNmLmeK3l8abk6111APiGeqZx3jdIeE7RCqjbH0FKGmddaBs3zgoLbmJyKGTskoEgZbx6l0f2W2U/YMbOrP8gPbn9LfxpB8hHfrh7KQpMhy/vN80C8EXmxguJkFZUBu46cqiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo5N1zBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5011C4CEF7;
	Fri, 29 Aug 2025 03:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756438601;
	bh=Qdi5PQByB+cZnsu7FZTp9R8jf7yPNPN2X4NHeN6UBbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uo5N1zBGKRdd2Rtvul9ZMoPWYzBf5k71mOB/WockOb96ZpgwZeaywirpcBFiDMRZk
	 4Z1UjF9RzbVBAeLKmdbVXfosfkGsC17LhH/yTG7uz2BLZvBMMrrwyiMhBvOixft815
	 xONjbmASYOwhyHxgmSza9bFE1HHkIRRXCOvG6Lz298hc1pbDrigjfBveiwlE66H9/T
	 MHcX/2soYSeWPTj4bKwOsN1vBRkPoepwekE6SVaobQR6LsDpLQ0L++JPBpmm4urHU7
	 gIxjPWC6wpw5KCzbw53yROngTRd7PwVxQH9f5/Ah1mE9aW0XRteRFxxF02zlwnj4vF
	 1sQbkjgRz2Ouw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF57FCA0FF6;
	Fri, 29 Aug 2025 03:36:41 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Thu, 28 Aug 2025 20:36:19 -0700
Subject: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
To: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756438601; l=3043;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=y7LtUbcF5JRYBgmDw1NmNcS7qz3njkpiJ46UXeQKaCA=;
 b=gGL2dBi6b5WvPIfnKANxlMK5GS+xlLDFfZzpE/RbJFL6HXaKAleVBVuHG3e8MVgQtgHpHUAHB
 0E+4z1eaWTgBkvFDh+nki1wdDeP6vX8t2EaFOgcSIS6aC/+bjNPRUl3
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
bytes from the page-pool to the skb's linear part. Those 256 bytes
include part of the payload.

When attempting to do GRO in skb_gro_receive, if headlen > data_offset
(and skb->head_frag is not set), we end up aggregating packets in the
frag_list.

This is of course not good when we are CPU-limited. Also causes a worse
skb->len/truesize ratio,...

So, let's avoid copying parts of the payload to the linear part. We use
eth_get_headlen() to parse the headers and compute the length of the
protocol headers, which will be used to copy the relevant bits ot the
skb's linear part.

We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
stack needs to call pskb_may_pull() later on, we don't need to reallocate
memory.

This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
LRO enabled):

BEFORE:
=======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.01    32547.82

(netserver pinned to adjacent core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52531.67

AFTER:
======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52896.06

(netserver pinned to adjacent core receiving interrupts)
 $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    85094.90

Additional tests across a larger range of parameters w/ and w/o LRO, w/
and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
better performance with this patch.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..792bb647ba28668ad7789c328456e3609440455d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		dma_sync_single_for_cpu(rq->pdev, addr + head_offset, headlen,
 					rq->buff.map_dir);
 
+		headlen = eth_get_headlen(skb->dev, head_addr, headlen);
+
 		frag_offset += headlen;
 		byte_cnt -= headlen;
 		linear_hr = skb_headroom(skb);
@@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				pagep->frags++;
 			while (++pagep < frag_page);
 		}
+
+		headlen = eth_get_headlen(skb->dev, mxbuf->xdp.data, headlen);
+
 		__pskb_pull_tail(skb, headlen);
 	} else {
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {

-- 
2.50.1



