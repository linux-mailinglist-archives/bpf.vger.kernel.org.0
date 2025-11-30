Return-Path: <bpf+bounces-75789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FC9C956CF
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 00:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB99D3A2113
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 23:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA83301460;
	Sun, 30 Nov 2025 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaXsnjVu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A4301035
	for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764545745; cv=none; b=trVaevg0FlzMd31Wrcvx0QhDF7MeillWtyFg2su6NQJCRyEUja1hmhpMtuz3durgCw79ztVzZ7pzDz7XirjTANPReULdG8RBRvZddTI5kIUhT6ImmHzUjVHlq9RxGpw3QPWY51aBBbI4s4IT3oVylpYxsc8+ElYYBdbyRXq9d+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764545745; c=relaxed/simple;
	bh=o4iyw2832atNMAZQImPFBGA5yCK+ZgPjuVFT1OuNVO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oefGenBKtabUugelVkBO4VEO7gLuaI7Ly2aeErBjuukauBdEN4ORge2GjMrYZZkOx/OwkSy8I7hU3GoFkuV5a6NbWktqb2Jv5vO6smBKqBPMxi+Cy/KwGMsRtJAvFano7DhHMf7y58NysnGT/dUgQ7lV2p5mZPnNcCk7ZZjqEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaXsnjVu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775ae77516so36805325e9.1
        for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 15:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764545742; x=1765150542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQMylrLW4Im9C3RrLyVskL4uzKLnQ4lYGDfbJ+ntA2k=;
        b=VaXsnjVufNs3gclDiScMqSFHNBjJVUDmV81FXsfFlmxopyAqW5eDl8ll1a/2R3De9B
         Rp4YRozymaxW3NV70+Gvvr2t6WdvDZlA8THrJ3tUp7Bc7JoK1xSGdUgUxbSZkxbtOBi2
         yIUdh5zzbIYcvfLhKgc6B+ltCaNIOsxUsyZhDibKKENqENs5EEOHjAfj0APfKj8Rw2HL
         zYbzTZg7CWmWsOKMBVkohX1FOVMhM2qeVDEz3GU2DYNkqjO9NdySbyDvpsb9yp0YnAKe
         eE9sDC0B02Q4cUSHHZnIoM+3YPVuupTYV30DeabL4z4b30epxpDoDfKKl5eYgID8dzdy
         yQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764545742; x=1765150542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQMylrLW4Im9C3RrLyVskL4uzKLnQ4lYGDfbJ+ntA2k=;
        b=vomocTng0hiliILmHvaYosUUIhRAN7VkVROdEi6VvmUnzcabEeEg0jzQIBG/xx7PkE
         vIzbBDxD2WRs0lJoyduI151HZEG/CYOrzBX3A4b+JfVI7d6o5j9uF2WwfZZGtyBp5zGU
         XuiVPvrOf7uHiMxv8NRHkSPkSo4pahlyatuh/WrFG+h53OWyvBV0vEo7cA5p5fwTtfad
         GG80e+UtBLIFNJOZ72asLXPdzIRyZbyqsvYEUQnrtRE5RWomtT1HDF/f+Of/ReEWtzwT
         23WXjn2YqFxWf9B55wZUg8xcN5llQuBndUy90MHpd0EDyK7htv5yCsdK/tN6DHt0vm/n
         kZIg==
X-Forwarded-Encrypted: i=1; AJvYcCXoaNpJQFVxb4VuUC+zT93w9SrusjUr6cz8CLgKAKnQUPdYSouvSGEeFE5KOFOxZA9p4M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1YDruxImdqKlKCyRHyLXkFErEhgibT0cKfZtzKRJi7Yyo045
	qFL4ZlFqXrd8bJCyd2jmWgfzan688T1stJ/EuaqYU1hAG0/DYMCexFCc
X-Gm-Gg: ASbGncsCfKkVzHGyyVuwM5k/k9RfZYAwlFFAGYQTPh1x9sFGIPi5GpvWF26yk7CQm3t
	JfONKtE7V8CON8RF/OqzqjZ31yI79cSKnXMPq26ZgCQCWqVwTGFsr0iK3U7vWKBhRebo02TbHcd
	rHnkFpf/rZzfHQ8wfA6woGido+DFiw8V8wv8vFGcEcf46vYDQcHTgUw9Un8aW405oXZcxTvYtWU
	VUXFwy3lJGEDqPbrT14IVkUwhruQp5bMimAJ7ZMAy9e/VfURBwwBauFv9bTUxXESpojLQeTZmTa
	1xKpyyavgN6vyAZY+tHoF1YZ4VR5lcPgrl+Si8GYXWIYoiY2hNQQpdFYXdLa8ZlgVWSgu6gJxTX
	7lvLEBhiTQfP777WLITGKCmwRjVwSpikR5LUPuVluZehvKcArxk2CYOHH3NgHepSilcLLy13ZyO
	2vKxxBpbtWuppZ5EKkF/5yk7pR7qRvvfQ9uVcbdDVGztakjW2zVX8fPl4rTX62IZsUgQhfMgUTs
	aVIUri6DMwwsrdZ
X-Google-Smtp-Source: AGHT+IFRNy69yAJEtLTkHqjePuEbcPuedCzCBZDYARz00zxMJbUrkfp5Acqq1qnoxF/x8wIlVCZ83w==
X-Received: by 2002:a05:600c:1c29:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-477c10c85e2mr406364115e9.4.1764545741617;
        Sun, 30 Nov 2025 15:35:41 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040b3092sm142722075e9.1.2025.11.30.15.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 15:35:39 -0800 (PST)
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
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	David Wei <dw@davidwei.uk>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v7 6/9] eth: bnxt: adjust the fill level of agg queues with larger buffers
Date: Sun, 30 Nov 2025 23:35:21 +0000
Message-ID: <df309468ba5127fc91dc4fcba9056fab826812bf.1764542851.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764542851.git.asml.silence@gmail.com>
References: <cover.1764542851.git.asml.silence@gmail.com>
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
[pavel: rebase on top of agg_size_fac, assert agg_size_fac]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 +++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f4c2ec243e9a..e9840165c7d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3816,16 +3816,34 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
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
+	if (WARN_ON_ONCE(agg_size_fac == 0))
+		agg_size_fac = 1;
+
+	pp.pool_size = bnxt_rx_agg_ring_fill_level(bp, rxr) / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
 
@@ -4403,11 +4421,13 @@ static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
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


