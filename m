Return-Path: <bpf+bounces-66390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1547BB3427A
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB63BDC6B
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1902ECE8B;
	Mon, 25 Aug 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1lYNOSz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A31F4165;
	Mon, 25 Aug 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130060; cv=none; b=hf4wOzIom166rAwb1CORpK9AR/DMLOXwvFvJw2uF8iXv84UGZ7GYqCtSsiqMHG2/vJOzrlr6Ww1uosuISfXM+0xSmC8QVoZgjniVYl0j9yEnjm93XAldNB4T6xN59gwGj67nY8l5auo1q8KiE6VFfxD8Y20o/TtcvRc3B3M0Hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130060; c=relaxed/simple;
	bh=y6aGJy+/jhJr0jVoe9VeHLchJFie2M7s+2FfJp9y8cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mqs/K3MoxvuDQon+ELwcpULHApm7Xr386bAx3J86H+gG3UBLEuEMUUlHLh2U/bq/kzhZuk5CR7+OBzl1O8tct3ndEYQUFzrpgqPtfHzdhnnfmCukuh+ZtoKZvERjcjrkigZ2QrbxGOUesoljwZLfvnv4E2nm443efZEyxioyuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1lYNOSz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771f3f89952so55625b3a.0;
        Mon, 25 Aug 2025 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130057; x=1756734857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6h1W6gArpUn1tdjOUgJkiZ+r6exSoV/9YgIfi1KHng=;
        b=k1lYNOSzTejmvZgO9gBXibhKfzE0zNf7Aa7BPdDlrj2Lu8HLxRGlIN7XwjHswcXtd7
         J9/GRKVOx0M4XRkMEKQUjokw+Jq6y/OuirmonluJP9d3NWcv8ELSHUNTM117PpK4lVAk
         Yk9EzftZ9Td7XmatYuc0EkRzYHf9mXaonS6PhnVB8nnzrxdDoIx3Z9j4JmKXjF6Y5Sq7
         t0V4mtL5csAd3j2tAsTECJ87dH0Q4vQB4rFtv3M8W+BDYwtbKpVER8ZocEDkfZxp7kwT
         7k3iHTGXG+DAI9m6Kvvd89iwjqFF5Ax5UXcRzGo1cBoP/wnVPKtLgwFGRoPqpLY9Rgic
         I3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130057; x=1756734857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6h1W6gArpUn1tdjOUgJkiZ+r6exSoV/9YgIfi1KHng=;
        b=k3xbyZg3y5adRvx8X3VeyMaW5g6AseLFO+MWmLjXc5mmTaDH/VtDFnfi7+OYfowLrQ
         B/qmRGJqUId3id7PJLSizogwhTX2BGNF6pTuPbrAYOfWAZPtkucQ7KSw6+jCZ0Ypjur9
         iZd9f8MasQX4ztq87fsIVYTAtdRVvF4NiGH/ovuXsrQA0WIAio0OcnjFCTarGE41zaKS
         dmaqbtgtO+SBBUfn1nLhkbQfTG1OEM/2EzXTpI55LfQZNS09fugNRs3R8FUt08oYuaUC
         uJLsC1r6Zb9OYzerkQ9+gpI9bv0zfUaaCK2eitND40vNbHfjkgYYbBwJydGJnWRM6l5s
         dD0g==
X-Forwarded-Encrypted: i=1; AJvYcCWHQBxGG98kc1WMUidNyP3BB4HBzaMTrxfcDAOW6wftpoy+cZ/rJkic3h1Z6rS7LJ5oA9ypogg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwYP9UXKNfL0eUbfKLSo3t6zO/iJw+qlcWf1i4t32G6JDdGim
	YkJq1CHtgkIp6Oa5rvO7fpZKNc/GWW9kTpSi49b3OFtESryvgLo4j9Q4
X-Gm-Gg: ASbGncu8AYNr3F/mD/LqR1hf0AQYKNqLvhSzq0pPNTBActpBV3wNjKWiGq1d/kWi3ts
	kT8/PaWFpFlcgsonuCkmQ2BePgg52FKzqRBO0iKvipe+Euq1u3OB2Toy75V2uEPNQscc6Ia6wue
	tz4HmXK50iElc3PpRsx0d3Z4ROcVAYvBFZOREbUcF/7O/+4FNk7p1bP7m3/Ru97XClqKOZX4x3g
	laOV1UBPtErTcDCTB2VPDaSXRluzPv5HT3BZmctI+98D4CqKyKGN931zHwaTvpYIuT939hzxc/c
	X5js+ssevO3Mm+p1Zga1tO5/ReeYY6/8n5Dx/ee6tqqSoMmKtFChNlwuzUg/TzSihiTZobKJg1X
	GIlRrUOzEQhTklIqqTg12ai+xiFN1TL+U3H1ZhEwGqLJ+lEn2YEGTA9oG34o=
X-Google-Smtp-Source: AGHT+IHqgKZPy0Hj/AwwyvEmQTS7PdDF2Tc2uDN9LraQUSAT9feuvp6yjcCnPMsQmBxI1NfbkkFF7g==
X-Received: by 2002:a05:6a20:4307:b0:243:7379:53a9 with SMTP id adf61e73a8af0-2437379889emr5057912637.9.1756130056989;
        Mon, 25 Aug 2025 06:54:16 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/9] xsk: add descs parameter in xskq_cons_read_desc_batch()
Date: Mon, 25 Aug 2025 21:53:35 +0800
Message-Id: <20250825135342.53110-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new parameter to let generic xmit call this interface in the
subsequent patches.

Prior to this patch, pool->tx_descs in xskq_cons_read_desc_batch() is
only used to store a small number of descs in zerocopy mode. Later
another similar cache named xs->desc_batch will be used in copy mode.
So adjust the parameter for copy mode.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       | 2 +-
 net/xdp/xsk_queue.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e75a6e2bab83..173ad49379c3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -509,7 +509,7 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	if (!nb_pkts)
 		goto out;
 
-	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
+	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, pool->tx_descs, nb_pkts);
 	if (!nb_pkts) {
 		xs->tx->queue_empty_descs++;
 		goto out;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 46d87e961ad6..47741b4c285d 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -235,10 +235,9 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
 
 static inline
 u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
-			      u32 max)
+			      struct xdp_desc *descs, u32 max)
 {
 	u32 cached_cons = q->cached_cons, nb_entries = 0;
-	struct xdp_desc *descs = pool->tx_descs;
 	u32 total_descs = 0, nr_frags = 0;
 
 	/* track first entry, if stumble upon *any* invalid descriptor, rewind
-- 
2.41.3


