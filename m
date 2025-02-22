Return-Path: <bpf+bounces-52244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBF9A406BA
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 10:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201813B8E0A
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E542066F3;
	Sat, 22 Feb 2025 09:18:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A746434;
	Sat, 22 Feb 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740215903; cv=none; b=A/sQ24DM+Rs4fW84zfv+Q+BrYyDvcXxP6tfIc9qbh/PWU2SSsivn7JQH796L8NLr2/Vu1H4NUZEuWRYY9VnVGURFTOBaamZVt8tVTO2DRruCJWs7W+QCqUQ3bolHIS4PAbPbq7D6szyQKOEpZWWFBHKXtnb9bpA7islZf4g8S50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740215903; c=relaxed/simple;
	bh=Mk6WuBoS1O12+dATtOsdWAT4h5ydjVAjz1XhAIFEwiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NsaTNq4+ZzezWp7jomDzH0i12zG4JFeb0aXkWrDj1P3cw4gbX4YDoXGG2tK7ISTts63zZ9xQmVll+s6MOnuooUxVIA3dohGjzhqlHZ9gXzYhTOM7AdUzNJ2WpVOIC0IhJAs8scamo1qu9SDz7ueA8d0z3DJzYNrY8rK4J49Onbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Z0Lrq1NGSz1GDfB;
	Sat, 22 Feb 2025 17:13:31 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A055140336;
	Sat, 22 Feb 2025 17:18:11 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 17:18:09 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] xsk: fix __xsk_generic_xmit() error code when cq is full
Date: Sat, 22 Feb 2025 17:30:07 +0800
Message-ID: <20250222093007.3607691-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200005.china.huawei.com (7.202.181.32)

When the cq reservation is failed, the error code is not set which is
initialized to zero in __xsk_generic_xmit(). That means the packet is not
send successfully but sendto() return ok.

Set the error code and make xskq_prod_reserve_addr()/xskq_prod_reserve()
return values more meaningful when the queue is full.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/xdp/xsk.c       | 3 ++-
 net/xdp/xsk_queue.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 89d2bef96469..7d0d2f40ca57 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -802,7 +802,8 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		if (xsk_cq_reserve_addr_locked(xs->pool, desc.addr))
+		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		if (err)
 			goto out;
 
 		skb = xsk_build_skb(xs, &desc);
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 46d87e961ad6..ac90b7fcc027 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -371,7 +371,7 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
 static inline int xskq_prod_reserve(struct xsk_queue *q)
 {
 	if (xskq_prod_is_full(q))
-		return -ENOSPC;
+		return -ENOBUFS;
 
 	/* A, matches D */
 	q->cached_prod++;
@@ -383,7 +383,7 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
 
 	if (xskq_prod_is_full(q))
-		return -ENOSPC;
+		return -ENOBUFS;
 
 	/* A, matches D */
 	ring->desc[q->cached_prod++ & q->ring_mask] = addr;
-- 
2.34.1


