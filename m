Return-Path: <bpf+bounces-79075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30588D26838
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7DF1320491B
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D151C3C199F;
	Thu, 15 Jan 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh9CH+0P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB03C1966
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497158; cv=none; b=radEHtBKrYH6t11facgXU5m7kyc+SmsiP84JwImK2jnousd8vb2BAF+LSvHMhlLF2K9xno/NRF9SJZhK758pfW1ExVuHPnR/Znn2eOn8SH+wY3adGqV4VGZUwvVkvuWBqEBi+Q9cme3v6RUirvelff6kKxT8U2I45BrqWd1cj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497158; c=relaxed/simple;
	bh=m8NMYH4g6lQKcDnWsulwGjwfrhYH+1zKunQ0vgAfNRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhSmsQZ0DFP1sZpbZ+rcojbffsNBnnV1DCnJBcr16v2g2DeDFnckTjfryMA8eKbp9UimaqaGMutqft8JHsXWwJdN6exX3On5HuFqrS1Z8yE/X/6Q8VPEZ6iWZuGa7HPZZY61/aWDf9V77Nr5W5T8Jjc1bxxAOk2iEowXxEXFtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh9CH+0P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so6711495e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 09:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497155; x=1769101955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz1yS4KnsLbiuKsdPkEkvSuKGyQ7NQwQMS3x7qa8DNs=;
        b=Uh9CH+0PtQFoy2xX4gBfxnddb1lL+DfYCnOwBWThGJGyKEhSKwlEOJD4+E9X0CnwSz
         pkLyHv82T0T+DMKi3nhFSclTexl9/CncwFV87UxsnoBcDzarZCMsreQzhQBEvZ3yJYXj
         LdZyv8Swohkgt1nr+PEYKOAut1ysA/XlKHcBC/nDWWksu+2qptZ+Ujf/6av7aIyJNtIK
         bw/doxp+F8kFjkCsakvon4Dut0+ACoS/Ca3/fBJsHyiWHvjIOmUSLQCHJqy/I/SEPL7b
         PFyb7EVK7oB5ApOBjDwZy/tsyfi2CJYhXUQaEeyIWCLt4vrZGrfZyqiA3G0a21Hj9TgT
         el3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497155; x=1769101955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wz1yS4KnsLbiuKsdPkEkvSuKGyQ7NQwQMS3x7qa8DNs=;
        b=ia9TpOfSLusL1AgxFT4WPcKwsRUNnOuAEact9SPwow13xGAAxdOCZX9yFzHMp1APg7
         mgtNzq7a5Lph4MEhJozj8bL9o7DnQP3VrDst0g4dlk1bIC5rjtyVm5fy5XJBNx1BvcR8
         DFQvMe9ghEDKCe/0kbAueFApErMSukH2x55osHBBMV7lvvpui73qHwegqtVx9f0zbvGJ
         IgKyuf7vnuPPcMV/1QlX3WsXiH4UhaCBSBHMhqeIekRGvSzCXojhgQSH3rr7tAsbEbwy
         5RBXGscbzMgaL9UJsygyimKM1VokYdKUYuTE5oUVaNdLdTctqObn6oK60LuzXgXInXy4
         0Reg==
X-Forwarded-Encrypted: i=1; AJvYcCV4hgUOMRfhvGDeV95FPg6wUcZogN4tfnE6f/g9rDy6vgUiFhWQQdGNUhtunktSFLUe8iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqRQzqQzu0yOfO8rhLDkIeOCfM2IUaHUGesQHPDMXLxY+rLqQ
	E0HGQaM/MlVq9YiwMs6R4yx/JiKeeBC5ZP3C2jIKJl7kD8IIkRFwbG4M
X-Gm-Gg: AY/fxX7QcK+NPioY+UaovaXCj8/5uTjbXLnxAF2Gd30LzU9NmybmKbEVZlSvBH8oPYF
	ZoW9+l8EIGyj/j984xYcOFnqWKGVAHd315jZ3UYionk9lCAtla039blJvLsTscy5nUDzJaRixYM
	CUOGwulKEPzVnHOFPtRakGIIRr5+MN1h7HQMeiG90CfIMK+vyWjqgE9H855vtVZTjb+2ov8AEpY
	ODGl2JgDFduinnMSM8jLom+UaDtF38vyEse0lTt7H1bE+7CPG6LrOyoM6tqISIJvDsAPs3w1qIT
	D48xpd4nJZoMy9eT1b1KR8kxf429Ebhf8GNf70jBikkP+ZLRW9sgDutxM+mNIZcT3gvW2oTa1Dj
	rzVTA/B6zySAvcLjHSMj28zGQKlspjOkrDwlOo0pPX/HOnK3heehJHjF7eFUz5IOXCTYnfdW013
	EV28ZSEcx9rptcIw9/kHXElTjHX/xDzlU7QpU+rz33sEekSapRS8j017bIRrucsN+BDrw9YUSs6
	h1SYJaURsMWDMqKqQ==
X-Received: by 2002:a05:600c:1c05:b0:47e:e952:86ca with SMTP id 5b1f17b1804b1-4801e2f28edmr6191145e9.2.1768497155155;
        Thu, 15 Jan 2026 09:12:35 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:34 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 6/9] eth: bnxt: adjust the fill level of agg queues with larger buffers
Date: Thu, 15 Jan 2026 17:11:59 +0000
Message-ID: <c55bf90a2112d7a831d8427034b71ff9fbb78285.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

The driver tries to provision more agg buffers than header buffers
since multiple agg segments can reuse the same header. The calculation
/ heuristic tries to provide enough pages for 65k of data for each header
(or 4 frags per header if the result is too big). This calculation is
currently global to the adapter. If we increase the buffer sizes 8x
we don't want 8x the amount of memory sitting on the rings.
Luckily we don't have to fill the rings completely, adjust
the fill level dynamically in case particular queue has buffers
larger than the global size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: rebase on top of agg_size_fac]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 +++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 196b972263bd..f011cf792abe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3825,16 +3825,31 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 	}
 }
 
+static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr)
+{
+	/* User may have chosen larger than default rx_page_size,
+	 * we keep the ring sizes uniform and also want uniform amount
+	 * of bytes consumed per ring, so cap how much of the rings we fill.
+	 */
+	int fill_level = bp->rx_agg_ring_size;
+
+	if (rxr->rx_page_size > BNXT_RX_PAGE_SIZE)
+		fill_level /= rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
+
+	return fill_level;
+}
+
 static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr,
 				   int numa_node)
 {
-	const unsigned int agg_size_fac = PAGE_SIZE / BNXT_RX_PAGE_SIZE;
+	unsigned int agg_size_fac = rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
 	const unsigned int rx_size_fac = PAGE_SIZE / SZ_4K;
 	struct page_pool_params pp = { 0 };
 	struct page_pool *pool;
 
-	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
+	pp.pool_size = bnxt_rx_agg_ring_fill_level(bp, rxr) / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
 
@@ -4412,11 +4427,13 @@ static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
 					  struct bnxt_rx_ring_info *rxr,
 					  int ring_nr)
 {
+	int fill_level, i;
 	u32 prod;
-	int i;
+
+	fill_level = bnxt_rx_agg_ring_fill_level(bp, rxr);
 
 	prod = rxr->rx_agg_prod;
-	for (i = 0; i < bp->rx_agg_ring_size; i++) {
+	for (i = 0; i < fill_level; i++) {
 		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_agg_ring_size);
-- 
2.52.0


