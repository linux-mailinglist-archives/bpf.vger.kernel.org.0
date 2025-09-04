Return-Path: <bpf+bounces-67518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A6B44A1B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 01:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514ED1BC3A56
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F822F619B;
	Thu,  4 Sep 2025 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgHzOznB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D962F069E;
	Thu,  4 Sep 2025 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026646; cv=none; b=ZZHAXoUaJBZEtQATqASXc/dd+ANgfR/xIjSsxBS5GquHnQxZYufoImYbxXuC8u2M8ds9m7yMcv5G3CH3xuH1eaZ0AunGVD7JjywZb033gACUsCgtzQHg7rMlfJyDTZBmXrUBIj+/16wibdzUOK1fZCkZ1eRk0FYV4/hPR88GbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026646; c=relaxed/simple;
	bh=Rbqz6hs0vXU3xPDk3Nmm32JXlYH8ZvvlopxpDT7dshQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cweYy+KRPBehLxIcbf+VWIZEgsGXcBmhDU2ujMkdXa48xLumPAfjbEBXI9cprJAvmTNjjNqDnPm9zyj4fMMuRv1i0+QQ/9pdVWhmz08g+2rDMAXzuseWe16sweRU1m90nlt5Hhk2prbLUY+bGAwr6kZpo/8C9MYoQQ0jUq42FHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgHzOznB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 132C6C4CEF0;
	Thu,  4 Sep 2025 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757026646;
	bh=Rbqz6hs0vXU3xPDk3Nmm32JXlYH8ZvvlopxpDT7dshQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jgHzOznB4SnxXNwDGZTuffkBYx000ioaWoDkfWCuNwX4gZkxGNjh2LSfBm1GlEN8k
	 mrpK3waHDh+LDJdpbnyQ3K8dhs5NHTBHXq3LYvC99shmyE8fsqGF0c5n+j8HqoeuH9
	 da3BvOQfSY6QKkYvGHNrBjsfzOoLE8BnnJJtqvl2j4m9v2LlJ0dp1tJ4zgi3qQby5Q
	 BVnOmr2an6DL+b3HZ6nVitCzPnfVVJQ4Rw6frniZnzxgEn3qpotE49rvWh9qPWw0EU
	 /QJBV+xD7x0C1vKPDzXmRlhMZwALjOmE8CSoEyBNJENUp+5cWi76HXpsAi0p9lOLbR
	 nT3Wuu2/cFk/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC93CA1002;
	Thu,  4 Sep 2025 22:57:25 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Subject: [PATCH net-next v5 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
Date: Thu, 04 Sep 2025 15:53:34 -0700
Message-Id: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4YumgC/63PTYqEMBAF4Ks0WU8N+TXaq7nH0IsyKduAmqAiS
 uPdOyMD00NvXT4e1PfqwSYaA03senmwkZYwhTjkYD4uzLU43AmCz5lJLg23QoJLiJNrITVQSQs
 DzX23GsAlBg8upi0Md5hbgoRbF9HDHI/YY9dFRx5wJITCSF0Jq43BgmUrjdSE9djxzfLNfHed2
 S03bZjmOG7HwEUc/e8WddKWRQAHcki+dLLUmr5iogHDp4v9MWGRf2wpirNYmdlaiFrx2kkv+Bu
 rXlhpzmJVZo2RliqqC2rcG6tf2fIsVv982zhvuFJo7X923/cnsTlOSIoCAAA=
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
 Stanislav Fomichev <sdf@fomichev.me>, Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757026645; l=2867;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=Rbqz6hs0vXU3xPDk3Nmm32JXlYH8ZvvlopxpDT7dshQ=;
 b=rufRlFfQiR0sQ6+Xm/CZSr+zhJZeO7jWpfcGI549GFoslhla1aumNi5mkmgmu5MIfMSrP2GbC
 N9hUFFoNmkKAFv41Uk3sLK6xTTCrD66UR+E4LzCSL8QaZCq/fCFV5Td
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
Changes in v5:
- Fix patch #2 NULL-ptr deref when an xdp-prog is set. Instead of using
  skb->dev for eth_get_headlen, use rq->netdev. skb->dev will not be set
  in the xdp code-path. (Reported-by: Amery Hung <ameryhung@gmail.com>)
- Kept previous Reviewed-by as the change is minor.
- Link to v4: https://lore.kernel.org/r/20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com

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
base-commit: 5ef04a7b068cbb828eba226aacb42f880f7924d7
change-id: 20250712-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-6524917455a6

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



