Return-Path: <bpf+bounces-66391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC7B34282
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C569F3A61E1
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182442F5499;
	Mon, 25 Aug 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi8PaWkD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75472F5301;
	Mon, 25 Aug 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130065; cv=none; b=rbcAM+mAoH9lN885GD+i+ayH+kKR23lclsREXwQ0BFWSQHs/ji7S1x2BdeUYrJEG1WiHoFg1yRdnI4M60SXIfvIcNSQNziNEuHU67Yw7agKrKt0B7L/RwYDTvuB9/Sa92cN8Y5uv5MBMKPB4Sgwk7atL4QouhgKhfZ+5guJspSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130065; c=relaxed/simple;
	bh=/cUVjljH4v+rjIJ+X4AtcLIMQFnzzBgzIPh85E/kfmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mD8pA7J1499K9OdbsSHDIT4Pvxok/J9OPmmf2w7KKydCUy+UNC0+dV0RsdUEAX7mcowGu15XCTNOLrAthlZVnPtd1/PVR1GKVTw1fkUgzAYJbpnQ8GECiC7lCXbLrZ8CSePb6DvOxUd3eS6Nd1a8cRnpiibwUAZpnNfwsID7c/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi8PaWkD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e20aadso5152984a91.2;
        Mon, 25 Aug 2025 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130062; x=1756734862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhlitc/6SPZSWyzdJjzOhFDWFTiiXgtelaxMfX4TO6M=;
        b=Xi8PaWkDY7Ab775kiVRBP6Cn9h+0B6nXeCEfPNGYFhNGjBJcwj5nR9YWDqq2pffNjI
         R0qoZubYW2/Gc/qJhyt90c7AMpe3GENIkePrLRISMeKs7ioMUCQCp6ShKulOxk/+fGFQ
         FCwNOjPZ3UKAbEnUA1ioNCWmClwnBoIKCsvT6335WNiMmx8QvBcoCcKy9IV/5rNDG3nV
         wZEFx3ahpkhZCUjYdpEGVMaHH+L/KxqntMHtIZ22PgocWSMUA4GPAEGrgwpiY7J9W6Ol
         mmOWeYT79cADzD8+sSayuOWhpxICTrmjfRW38hwyhnn5VlZaFyziZ60Kwx8NPkKTZES6
         /QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130062; x=1756734862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhlitc/6SPZSWyzdJjzOhFDWFTiiXgtelaxMfX4TO6M=;
        b=CP2uVWZ1OuReVtvwGIQyFS14vfoORkGqoujkhrKkmJHC/vdIy2jroqUH9hG96LJHOC
         oW7S+m+oBOH9eNwFnUvkgpMjoT3RC/AWm39++wUPTcuXt4qBZ0eiJbk6B7UhPTrCu2GA
         SYk+KEB0BTZq+HYG3czntRgK+UARLPpur68rXva9m5HffUqhkCLcutlcESiqM7FYsDIo
         aR585eziwAV1wb28Pa3HJisNFZ+3zhn2gIhnA0KKPesdysgrtrwdsygSBsTVynwNwksK
         O9KM1LXJc7fFENcgfBxIxcfy0hftPM/AcuT3rO2ZDx+jPQfPdJiFkJbWkc/zle5eTYNH
         SkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOnTJmA2anXC6sWje7RTQRku83D8VwesLPanJMwI/HIjfgI7hs53V1mC8z1UUzoC+xFAkuMPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eOilghZBNYuDMZXbTAJ989bUiXNhFDqQ39n2pnLg2cEUetZ2
	7t5rmSL7SMOzKfxQr0YbZHaKviu6F/MnudDT88lCK+rCPezvpUGHqwyN
X-Gm-Gg: ASbGnctPJPJzdIIbOlBGfbucRZ3FLFVYzDE4vrkBENkExpoez9Z05Lht802mWZPbR+9
	m5YE3z/4n5WqPID9Nm+hL7SAorKIjbjlaWIwVSZ/3ObI4EtjB/waAmHRlw4hGAyeNrOVoLfhUyg
	UJqGtCzR5MtTrDmDy+FgwbJKgbBy7QZl6JI8n+6GxLxjqtO1u8uaKIkvLPilHGNONGSqN7ad4JS
	RU8m2HYFxTRq2WVENvQAS6oNUT/W7aHhtiI/MDULl4qghev2jAgj341+l6vRu5iTzwKkv/oczap
	TlZPwlPDgg+l+9wpDKG8zUcapMHHrJRkmyc3JSRJn1oskB5lNMaMCdmlbGnrz+9DrnN1IAFBESu
	T/FFlmheR7oVRafHD3neTzz6aqUZ6ThPNeJFm7ai8lrUIMwlOPAwUXzhMrz0=
X-Google-Smtp-Source: AGHT+IHH8wQDFK60n8ySToedw5zu99QdIoX0y0jeNiA98XihhSdb2gFPshdsBxyYhF/RP+53Aq/yuA==
X-Received: by 2002:a17:90b:3952:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-32515e50960mr15879102a91.13.1756130062007;
        Mon, 25 Aug 2025 06:54:22 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:21 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/9] xsk: introduce locked version of xskq_prod_write_addr_batch
Date: Mon, 25 Aug 2025 21:53:36 +0800
Message-Id: <20250825135342.53110-4-kerneljasonxing@gmail.com>
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

Add xskq_prod_write_addr_batch_locked() helper for batch xmit.

xskq_prod_write_addr_batch() is used in the napi poll env which is
already in the softirq so it doesn't need any lock protection. Later
this function will be used in the generic xmit path that is non irq,
so the locked version as this patch adds is needed.

Also add nb_pkts in xskq_prod_write_addr_batch() to count how many
skbs instead of descs will be used in the batch xmit at one time, so
that main batch xmit function can decide how many skbs will be
allocated. Note that xskq_prod_write_addr_batch() was designed to
help zerocopy mode because it only cares about descriptors/data itself.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_queue.h | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 47741b4c285d..c444a1e29838 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -389,17 +389,37 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 	return 0;
 }
 
-static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
-					      u32 nb_entries)
+static inline u32 xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
+					     u32 nb_entries)
 {
 	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
 	u32 i, cached_prod;
+	u32 nb_pkts = 0;
 
 	/* A, matches D */
 	cached_prod = q->cached_prod;
-	for (i = 0; i < nb_entries; i++)
+	for (i = 0; i < nb_entries; i++) {
 		ring->desc[cached_prod++ & q->ring_mask] = descs[i].addr;
+		if (!xp_mb_desc(&descs[i]))
+			nb_pkts++;
+	}
 	q->cached_prod = cached_prod;
+
+	return nb_pkts;
+}
+
+static inline u32
+xskq_prod_write_addr_batch_locked(struct xsk_buff_pool *pool,
+				  struct xdp_desc *descs, u32 nb_entries)
+{
+	unsigned long flags;
+	u32 nb_pkts;
+
+	spin_lock_irqsave(&pool->cq_lock, flags);
+	nb_pkts = xskq_prod_write_addr_batch(pool->cq, descs, nb_entries);
+	spin_unlock_irqrestore(&pool->cq_lock, flags);
+
+	return nb_pkts;
 }
 
 static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
-- 
2.41.3


