Return-Path: <bpf+bounces-66931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC259B3B1B1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4861C86567
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B42221F13;
	Fri, 29 Aug 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAKe1IzZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DD1FDE31;
	Fri, 29 Aug 2025 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438602; cv=none; b=NL+VylKC9n2kU5wsJ9vQx125jAY6HToRb4PmMHq6LplSVdUauv2xe+jH4Rc/Q6Z8d799xilq65ZFtdRTy4BXHOtFyN64dzfl6OaHy/MXWXY9JRTMcA30RZBeyXti6kuBVo1i271mvV/VYlRbfiFjXMml3VzFzAGIayuwC+/lud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438602; c=relaxed/simple;
	bh=lLD8NUQ1wv6nlx9YnRHQKnHbLnh1cRGdlvrFwAvOA0A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J7mDOvH6mutxYWLlLIoHrI9s6Qkq36BmPBJGfd0sluKAHVDlnbfy3AZNPdx5hfWJC9Ash5D2qdsnmc0FAp2hRBK4jfqgJ9QBaFTiUjRY8hxc2LiwcscpA5N0MFNLhFqLD0Ih1ruOpnx99wFUIcf/wB8Thjl4rFEtEDD+jt6LB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAKe1IzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6D9AC4CEF0;
	Fri, 29 Aug 2025 03:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756438601;
	bh=lLD8NUQ1wv6nlx9YnRHQKnHbLnh1cRGdlvrFwAvOA0A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iAKe1IzZMnpNbNPJ4zf4ZR4zzFNozZwbPx7sZ7QyVvL2eW6XmxNSHE7U/vCJ7wDrb
	 SRtZUHwMUvBhq4IcNv+bIK9BxxcVwltThYfuDC8n3MLRD/W9AqZjWZxzl9mwkNeG10
	 dmuByV53EbdmcjiT2X14h6NBgePmxhwv5vT3610sJc8GKprzrqDBVlFW05EfGGPuZO
	 o1Kqe+6iP87I0wyHbXgmysGtzJ0SmQveL4tSFCXDlxYT/L6yyjINHxKH0ihliuiWh4
	 JpOvMFMUBTf3VNRgTmZR4P6RRraVXtkS+K1FewNUM9UVMQrE4dA4uW5CPKNgrXGB/3
	 URfH6IDudx14A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F5CA0EED;
	Fri, 29 Aug 2025 03:36:41 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Subject: [PATCH net-next v4 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
Date: Thu, 28 Aug 2025 20:36:17 -0700
Message-Id: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADEgsWgC/63Oz2qEMBDH8VdZcu4UMyb+6anvUXoYk3ENqAlGg
 rL47htkoS29evwxMJ/vQ0ReHEfxcXuIhZOLzs95qLebMAPNdwZn8xZYoC5qiWACUTQDhB5arGH
 mdRo3DZS8s2B82N18h3VgCLSPniys/pwTjaM3bIEWJqg0qlbWSmuqRLbCwr3bzo4vkX/mv9sqv
 vNlcHH1y34GJnneXy3lRS1JQgFsiG1jsFGKP33gmdy78dOZkPCHbWR1FYuZ7aTsyqIzaGXxjy1
 /saivYsvMao01t9xV3Js/7HEcT+Uhei4TAgAA
X-Change-ID: 20250712-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-6524917455a6
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756438601; l=2427;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=lLD8NUQ1wv6nlx9YnRHQKnHbLnh1cRGdlvrFwAvOA0A=;
 b=PcmsDyofHgu6loGt6I8bnOR8TMUktjuYLu2lEeHuMJVwmsTKqikZSKvFx40vwU2IgzULpIPJZ
 fgo03BSVnDvA92y6Zt95rNTvtS5H8kNJ7I0FUdOKvtyP2ev3vmspCER
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
copies parts of the payload to the linear part of the skb.

This triggers suboptimal processing in GRO, causing slow throughput,...

This patch series addresses this by using eth_get_headlen to compute the
size of the protocol headers and only copy those bits. This results in
a significant throughput improvement (detailled results in the specific
patch).

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
Changes in v4:
- Use eth_get_headlen() instead of building a dissector based on struct mlx5_cqe64.
  This mimics what other drivers,... are doing as well. (Eric Dumazet
  <edumazet@google.com>)
- Link to v3: https://lore.kernel.org/r/20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-0-5527e9eb6efc@openai.com

Changes in v3:
- Avoid computing headlen when it is not absolutely necessary (e.g., xdp
  decides to "consume" the packet) (Dragos Tatulea <dtatulea@nvidia.com> & Jakub Kicinski <kuba@kernel.org>)
- Given the above change, consolidate the check for min3(...) in the new
  function to avoid code duplication.
- Make sure local variables are in reverse xmas-tree order.
- Refine comment about why the check for l4_type worsk as is.
- Link to v2: https://lore.kernel.org/r/20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-0-b11b30bc2d10@openai.com

Changes in v2:
- Refine commit-message with more info and testing data
- Make mlx5e_cqe_get_min_hdr_len() return MLX5E_RX_MAX_HEAD when l3_type
  is neither IPv4 nor IPv6. Same for the l4_type. That way behavior is
  unchanged for other traffic types.
- Rename mlx5e_cqe_get_min_hdr_len to mlx5e_cqe_estimate_hdr_len
- Link to v1: https://lore.kernel.org/r/20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com

---
Christoph Paasch (2):
      net/mlx5: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
      net/mlx5: Avoid copying payload to the skb's linear part

 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)
---
base-commit: 29828b81a46a3ae55ebc053fce512219172560ba
change-id: 20250712-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-6524917455a6

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



