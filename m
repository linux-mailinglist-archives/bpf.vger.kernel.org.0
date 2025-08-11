Return-Path: <bpf+bounces-65335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5427B209C6
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 15:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA97916B8A1
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451E2DC321;
	Mon, 11 Aug 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDEV5bt/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576522D8396;
	Mon, 11 Aug 2025 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917971; cv=none; b=akGh8DuhHlAYQ15OCvQnTbcpOueoRpX3PkBgyAt44j5VBCb9T83OQvnJzx2h8WGuowft1ACMLqCHSRPUzRL9qY4BilSvF8a17J3yOhO4ZT2K/lBvBAlh6lkL+UN+CPcMazFCM/4HSqQtV+KyYbokhIq0n5hjPedPlMGhSJr0bTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917971; c=relaxed/simple;
	bh=oBzWWJoN1QPNyOSxKqf7D6glqXrdFBCbqYE3ivYedr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDApiDrebG0pd2f4vAc/PAz3fapsO9QhXrL6LUSSaB/IUjVDLaV7ajSuf612jmHk6flhvmB4wq8fuEpAbBtCQpWjlpQX5uKOv1vuZt2E4zKRBjrRSBSV/ZLDjWXZuGyvTWGkRee2SUEhhj+qF+LTynxYoQS7WgOYJX/GcamFoOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDEV5bt/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747e41d5469so4796136b3a.3;
        Mon, 11 Aug 2025 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917968; x=1755522768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9bMX5czkugdCd7GUvhOGzTcA0HKj2Ez+rxgrDhb/l0=;
        b=nDEV5bt/Rtyt5LH4MIuRjyz0/n4KVZs/kVc69mgLysW9dJqD7pWQCug2hL6ierLRP7
         8G1iK2eOtrXzRF6e1eTfrc1Oit9UnvGW5kWb0wrLm0c3dp3NhVPovPYcfEQUUrCDBB0j
         ONM4/5zvuGLXbJxxH0eAsM2omuWLPtBgie/2oAvKyADNgmQcJJ13onhkMeQpAjjkfBT6
         E63lHqqivw4nJnzldtfRjA7pGWdpHovClKRYOzDyWYuFtpw0jFk4bmgJ1m7ZMmlrVkre
         GQtb4igI4z+YPLNQg077yB0y+y4vkHi2TZkXdwpJd7+LCT2Da8iRjhq9RXM4vm/9HfBA
         F5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917968; x=1755522768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9bMX5czkugdCd7GUvhOGzTcA0HKj2Ez+rxgrDhb/l0=;
        b=a2h637NRVK5pYJ2porxGcZzEL7FtOla4LfDVbqmk+k/sze7vM0JPEMp/C7NMoRZztT
         mDOHx16l8XHJXkQifDeenf1v84QIra22dUys0cl/1mzsTNKSmszHN/rxJ0AOHcrSbdfq
         uFe7sc4YaES80hVZmR6Di6MuEmjOXK+kiMZq0e+EPjxTgbh0tCLEiddmMD2IcJAsUK5Z
         XKymiDUnU0F4VBChLb2Sy93+E+snTWbTWvkqlUwRj43/SfBP093vOI5BJDQL2gXl9Xan
         2Umw91UtnO2/6/GF4PW8RRy2J3CXFLgOYC0ABCtxesuI03LgfnHidpwFFgxP+FGARxHb
         ZLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFfxWW8T3cd0tC1jftRicF2fLat671CAXljLgBwLNk2sl4h8i0Yi43O0fwoDnJZ2dbtK4TgWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCa9cDgAD0XOpzUM7lXKxuCjV6TSSJyvvvyW+dV/4OHLII6+ta
	/zMFMtcocmJVgaUvAwcMvMmEtab7hAwViwpX6LE0etnxd9MaUn3lOa+B
X-Gm-Gg: ASbGncv3h7KKc0A5cnPDiYUA3H3avf5/ORI9hJTPYUzqqvS9gXkCV7DnLcKOFZ2ZPkx
	WyyunNnjJJdxLPeE2XPVSPRSIaviVH4bv6+CZn3Gfy6XqTbDEYmi0KL1Gdh8HltzVLhS9mMujy2
	A2oGA+gEWe/K6WZ2epf3OfAhdv37J4iBtdSzAk+IkLh2ggMbPz0Ep27zRQeue8HWXlI6d0QSg7R
	UG4CsvLn+8OcY4bTuTxQ9VBn/ZYu2vQXPAmDJTa4fggucGBgLxHhB0HBImcfbdVaH9e2sNmXb4M
	zMeIjm3LoRgMnP+EtU++xqeUQWSJDPAswqS/kOGpA51MsOKLYUSO6uDXQzA73Cod4D4ztLb2LoS
	AuR62+uGJ1x/O7ltgPh2xVyIzYL3/m36AjHEPSjGCMQ5wS4gpSBHzj/In4KQ=
X-Google-Smtp-Source: AGHT+IEIgedl4CKDczNe96rDUi8n1WtC0Hio/1jJX+Fof36MTkqjvLLZ2ZC5+Sz9XUTKk2MTEpI9tA==
X-Received: by 2002:a05:6a00:3c86:b0:76b:ef0e:4912 with SMTP id d2e1a72fcca58-76c46195b38mr17273338b3a.20.1754917968240;
        Mon, 11 Aug 2025 06:12:48 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c46a05464sm8227069b3a.96.2025.08.11.06.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:12:47 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
Date: Mon, 11 Aug 2025 21:12:35 +0800
Message-Id: <20250811131236.56206-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250811131236.56206-1-kerneljasonxing@gmail.com>
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch is to prepare for later batch xmit in generic path. Add a new
socket option to provide an alternative to achieve a higher overall
throughput.

skb_batch will be used to store newly allocated skb at one time in the
xmit path.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 Documentation/networking/af_xdp.rst |  9 ++++++++
 include/net/xdp_sock.h              |  2 ++
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 32 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 45 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 50d92084a49c..1194bdfaf61e 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -447,6 +447,15 @@ mode to allow application to tune the per-socket maximum iteration for
 better throughput and less frequency of send syscall.
 Allowed range is [32, xs->tx->nentries].
 
+XDP_GENERIC_XMIT_BATCH
+----------------------
+
+It provides an option that allows application to use batch xmit in the copy
+mode. Batch process minimizes the number of grabbing/releasing queue lock
+without redundant actions compared to before to gain the overall performance
+improvement whereas it might increase the latency of per packet. The maximum
+value shouldn't be larger than xs->max_tx_budget.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..b5a3e37da8db 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -61,6 +61,7 @@ struct xdp_sock {
 		XSK_BOUND,
 		XSK_UNBOUND,
 	} state;
+	struct sk_buff **skb_batch;
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
@@ -70,6 +71,7 @@ struct xdp_sock {
 	 * preventing other XSKs from being starved.
 	 */
 	u32 tx_budget_spent;
+	u32 generic_xmit_batch;
 
 	/* Statistics */
 	u64 rx_dropped;
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c3acecc14b1..7a149f4ac273 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1122,6 +1122,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	kfree(xs->skb_batch);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1456,6 +1457,37 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		WRITE_ONCE(xs->max_tx_budget, budget);
 		return 0;
 	}
+	case XDP_GENERIC_XMIT_BATCH:
+	{
+		unsigned int batch, batch_alloc_len;
+		struct sk_buff **new;
+
+		if (optlen != sizeof(batch))
+			return -EINVAL;
+		if (copy_from_sockptr(&batch, optval, sizeof(batch)))
+			return -EFAULT;
+		if (batch > xs->max_tx_budget)
+			return -EACCES;
+
+		mutex_lock(&xs->mutex);
+		if (!batch) {
+			kfree(xs->skb_batch);
+			xs->generic_xmit_batch = 0;
+			goto out;
+		}
+		batch_alloc_len = sizeof(struct sk_buff *) * batch;
+		new = kmalloc(batch_alloc_len, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+		if (xs->skb_batch)
+			kfree(xs->skb_batch);
+
+		xs->skb_batch = new;
+		xs->generic_xmit_batch = batch;
+out:
+		mutex_unlock(&xs->mutex);
+		return 0;
+	}
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
-- 
2.41.3


