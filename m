Return-Path: <bpf+bounces-78839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4BD1C8A6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 06:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D15EF30F7384
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CA2E8B8F;
	Wed, 14 Jan 2026 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgZZZiIz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAC30F545
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 04:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768366546; cv=none; b=Rrh6bxj6OaDX7L7HtIWJxxUufFY51mMKvEi7ZXe1TAgSHihfzleQBF19DwzGPkx/wVpVCARK5BCkmSJCteZ3pZUGL/pQ7nZUsvJlZ5HoIT41MsE1lG4BUyGYn/FzZo+WiU6VkI8UBM3PcbwiZEA4Fz9Y/C5Qz20qrFAD5lKAZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768366546; c=relaxed/simple;
	bh=qXrRAnJDiJuLc67vyqrVYIeOl/OYuI/APHE3Q76YrMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZIFYMkPb+igC1YC6A6KdCUDy/uaH+hJ+1+I97DGqjVaFYesjaJJQWyjipAjWzeC4y9Up5KziK/aTIFDZB1kUpCYhsoe+KAHZg+HM06Vl51V12suYcjWkEh3Mq2OSlAQgWOXEWeubFZHTXcuhO+Lvq2FUm3WUkvoTLK1OOkNv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgZZZiIz; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so3972756b3a.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 20:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768366528; x=1768971328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b35CdTfC9+2Q2zzsqa61PBXo7mnyKD58rRScqk01Ojk=;
        b=MgZZZiIzZR86T6ajF9tufVS59r9NEf57z+Zbxd58gsfaJDnQfA/yxqvQtLpYCXGhcA
         vzRRvlYyEvtBO8baZEOo2fre78XyguEYlPyXVhAUbCqtg58UrJ4odYi+7nQb3QGDf0P6
         18HKhPSpY5M5Lg3PrlFCQkwVI0P/bxWJk8JihhaXhKb6/siFQkMkO5YLWpV6bF/ISDES
         hQUEjhrC4GHG8xeFZwOKABDPTG5tJqe0d3fyfOdMEHbGEq4BvQXmrLoYhAwTSdnsBbZL
         CPzx4QwrNcK3a4mkJwuJG6jIruU6dvzjE+J9kxBo29oNMOA+u5svcSW0N5RKFene8AaT
         INAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768366528; x=1768971328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b35CdTfC9+2Q2zzsqa61PBXo7mnyKD58rRScqk01Ojk=;
        b=MLSBiCAABb7zRnZLe82A4ppSn809YqFT/SxDmwVbs3qNyA+1xopBxn4YdU/9bpqGYa
         /brcrTkk4l2GKlOR9Lsi4E0EoWyza2gvbZ03oPjzvNDvYZBSccipvgic4niuuYXa9v/Z
         J0EDXD8rh9UYfqztgLynY7LZLcVRJKeErvHLCv4J31y+CCqUMPtjbuZGn38VRuOwItfA
         VH0OCPfeRPJsRdNZifbPh29QokAs30Vxl0kNZ5ctcobU952DoiAPQhAtPtmmTq81pppz
         eR4rbrx9nDiAFM8C0ph0AGxzC7sF+5Krsw02MCnGxyPyq6w2r+t+nUr2/CfDKj99/wvd
         qLsw==
X-Gm-Message-State: AOJu0Yy7RpYc3n6aEjOYnTQzPnFxCaDY2VM36rKTFb+KYET1mhJZs92u
	NWmfx/DPggEuEK3IroP16VYZq6K6rzBJIluWW+32Hfirv3oNbliqMXt8KUdXrFFA
X-Gm-Gg: AY/fxX6FBBXsw855aWfjZOhutgGsz9G0gYx5tB/KdoAN8D0SzGUcgyUfUuP9Grfgedw
	D6b5g/u7Qov+TR/cyjv69eExC8RmN+Kyt/T8DLGfvfZK75pyyjwTbRtkDADZQtMJKhWYs4JFNw/
	euapPaSUlU+PtF70gt9EZeEC4AAMlCPP25++l600RucgRG1dahx4K7rydTIInHub2laCYooQXPO
	eJsmLy0DQDiy3F1XmOGS/Y/o4/AmGtB9+sdA5Uvi8FlNb1qNSYI0qRDhsi33wvQ3F7yJVU/e2+7
	y/LInXhn+p2ONO7KLKBXMd64HE4ueir9ZO+O5d/xVC/NZcaDMPxkIkw73t5qwxfm3ujddIdVqVS
	EGEARXC5eiz+yn0aJnceb4Qx7zeIquz8DsqKM2rNY1Vb8F/g361hk0fWerHJq1NuxcjQqBL5va/
	JPcFBZod6dbiNsnbL3cImZK+jUo68WsnhnnkwcGfD1WhST4OK/aDw=
X-Received: by 2002:a05:6a00:8c13:b0:81f:4999:ae46 with SMTP id d2e1a72fcca58-81f81f92681mr1128218b3a.48.1768366527561;
        Tue, 13 Jan 2026 20:55:27 -0800 (PST)
Received: from fedora (softbank036243121217.bbtec.net. [36.243.121.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c59b024cfb4sm9150994a12.14.2026.01.13.20.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 20:55:27 -0800 (PST)
From: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
Subject: [bpf-next,v2] bpf: cpumap: report queue_index to xdp_rxq_info
Date: Wed, 14 Jan 2026 13:55:09 +0900
Message-ID: <20260114045509.1281217-1-saiaunghlyanhtet2003@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When packets are redirected via cpumap, the original queue_index
information from xdp_rxq_info was lost. This is because the
xdp_frame structure did not include a queue_index field.

This patch adds a queue_index field to struct xdp_frame and ensures
it is properly preserved during the xdp_buff to xdp_frame conversion.
Now the queue_index is reported to the xdp_rxq_info.

Resolves the TODO comment in cpu_map_bpf_prog_run_xdp().

Signed-off-by: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
---
 drivers/net/veth.c  | 2 ++
 include/net/xdp.h   | 2 ++
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 1 +
 net/core/xdp.c      | 1 +
 5 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 14e6f2a2fb77..4a409802cdac 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -648,6 +648,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 
 		xdp_convert_frame_to_buff(frame, xdp);
 		xdp->rxq = &rq->xdp_rxq;
+		/* Preserve original queue_index from frame */
+		rq->xdp_rxq.queue_index = frame->queue_index;
 		vxbuf.skb = NULL;
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..feafeed327a2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -303,6 +303,7 @@ struct xdp_frame {
 	struct net_device *dev_rx; /* used by cpumap */
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	u32 queue_index;
 };
 
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
@@ -421,6 +422,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
 	xdp_frame->flags = xdp->flags;
+	xdp_frame->queue_index = xdp->rxq->queue_index;
 
 	return 0;
 }
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..f5b2ff17e328 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..7e8bfac4ca05 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -348,6 +348,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
+		rxq.queue_index = xdpf->queue_index;
 		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index fee6d080ee85..29f0b5ddb39e 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -606,6 +606,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
+	xdpf->queue_index = xdp->rxq->queue_index;
 
 	xsk_buff_free(xdp);
 	return xdpf;
-- 
2.52.0


