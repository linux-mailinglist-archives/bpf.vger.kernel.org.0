Return-Path: <bpf+bounces-14034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD757DFCCB
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 23:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1821C20F76
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 22:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D6E2374A;
	Thu,  2 Nov 2023 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZZ2lYtL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069FB224CE
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 22:58:56 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D904196
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 15:58:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b97a03aa53so1077445a12.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965935; x=1699570735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/kzkpf7mJPDxgqCP2JD59SSWcrFcpewjk7q9SbAWjE=;
        b=LZZ2lYtLNxxtIQTFMVwcWmMynegzwoI14IwMaJgopgB9QATvN2cFbeNc8QejUlMzfm
         jV4X+f1pKgoclQmAb4H7aocGOu9qWP7BxKoxiwoSVUkEzuZSk9LexCMVvEiy+ZILKMSI
         7Yw8ydUP2VsnNEKdDXaQnOymB64CGXpk2wKoqISCk9NsZ/oppcR79HOeayF0LMN8AB4y
         eOWD0dMS3/OAMUHe6y6QKiJ2b/BdvagcXL7t1AjaDiiu/Smm6MGgusdWX16NE4uxnZrQ
         Upu/WgNZwaxY1bQnQ1c5vY2tFkgsWavj0mc8OMG9mkCyr45Zpg1qknog8+ld1llczhSQ
         qMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965935; x=1699570735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/kzkpf7mJPDxgqCP2JD59SSWcrFcpewjk7q9SbAWjE=;
        b=vvObHQiNtwGXtnHVFgJpOajsisewdRbf+5FZHhBTgVzHX4lhzsqCkSaMUDOm/BXibR
         iKp1VRleCk9wUu2mgQI9BpmVCxAiTj9KsnUycURR12N293ILs/tQl32xX9fVgWMISVGH
         CiVxtfxZm7HBjuzelXfv67myzvxskj6tt3hPVqvyDblU3MUSf8oPuGZECGDROZClGdLC
         Mw+Ep27GmJTfmmA7h3ttehsrWT1B6BjjmvKT0p0m8GKfGdZLStBF46HDOdBhD8tgOsq6
         utzEG9h/Iu1ZDPwYAZF+xQMi9rpwj0aTaedMnV5Bluz9PdTnSBDnzV3w/1IJAON801B/
         Cb+g==
X-Gm-Message-State: AOJu0Yyd93zju3EfDDAHtjr0j+tbjIDXS7S2Jq+6PbpuJle0oA6N5f2l
	r9GTldL/mCfNxEUrnIpQHJulE/8ThHrX2oBpce/81yBe/yxMQFaTZLOfJlEHAvTMhgQR/4nkGdo
	a/pRoZi79WqSKjQQJ/PkDjAIUSM3E8vUvRJeTRjG0FMMQoc5yMA==
X-Google-Smtp-Source: AGHT+IGeHGTku3StH3yaDLbw7vu7lMh6tOBynVJJF9KK/TP8fFYcPyHqNZCmU0a6fMxM0JDPRMXFKL8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:444:b0:1cc:29fb:f39c with SMTP id
 iw4-20020a170903044400b001cc29fbf39cmr334431plb.1.1698965933297; Thu, 02 Nov
 2023 15:58:53 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:32 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-9-sdf@google.com>
Subject: [PATCH bpf-next v5 08/13] xsk: Add option to calculate TX checksum in SW
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

For XDP_COPY mode, add a UMEM option XDP_UMEM_TX_SW_CSUM
to call skb_checksum_help in transmit path. Might be useful
to debugging issues with real hardware. I also use this mode
in the selftests.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/networking/xsk-tx-metadata.rst | 9 +++++++++
 include/net/xsk_buff_pool.h                  | 1 +
 include/uapi/linux/if_xdp.h                  | 8 +++++++-
 net/xdp/xdp_umem.c                           | 7 ++++++-
 net/xdp/xsk.c                                | 6 ++++++
 net/xdp/xsk_buff_pool.c                      | 1 +
 tools/include/uapi/linux/if_xdp.h            | 8 +++++++-
 7 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index 4f376560b23f..97ecfa480d00 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -50,6 +50,15 @@ packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
 bit in the ``options`` field. Also note that in a multi-buffer packet
 only the first chunk should carry the metadata.
 
+Software TX Checksum
+====================
+
+For development and testing purposes its possible to pass
+``XDP_UMEM_TX_SW_CSUM`` flag to ``XDP_UMEM_REG`` UMEM registration call.
+In this case, when running in ``XDK_COPY`` mode, the TX checksum
+is calculated on the CPU. Do not enable this option in production because
+it will negatively affect performance.
+
 Querying Device Capabilities
 ============================
 
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 97f5cc10d79e..8d48d37ab7c0 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -83,6 +83,7 @@ struct xsk_buff_pool {
 	bool uses_need_wakeup;
 	bool dma_need_sync;
 	bool unaligned;
+	bool tx_sw_csum;
 	void *addrs;
 	/* Mutual exclusion of the completion ring in the SKB mode. Two cases to protect:
 	 * NAPI TX thread and sendmsg error paths in the SKB destructor callback and when
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index b0ee7ad19b51..bed6adc3e9b4 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -33,7 +33,13 @@
 #define XDP_USE_SG	(1 << 4)
 
 /* Flags for xsk_umem_config flags */
-#define XDP_UMEM_UNALIGNED_CHUNK_FLAG (1 << 0)
+#define XDP_UMEM_UNALIGNED_CHUNK_FLAG	(1 << 0)
+
+/* Force checksum calculation in software. Can be used for testing or
+ * working around potential HW issues. This option causes performance
+ * degradation and only works in XDP_COPY mode.
+ */
+#define XDP_UMEM_TX_SW_CSUM		(1 << 1)
 
 struct sockaddr_xdp {
 	__u16 sxdp_family;
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 946a687fb8e8..caa340134b0e 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -148,6 +148,11 @@ static int xdp_umem_account_pages(struct xdp_umem *umem)
 	return 0;
 }
 
+#define XDP_UMEM_FLAGS_VALID ( \
+		XDP_UMEM_UNALIGNED_CHUNK_FLAG | \
+		XDP_UMEM_TX_SW_CSUM | \
+	0)
+
 static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 {
 	bool unaligned_chunks = mr->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG;
@@ -167,7 +172,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 		return -EINVAL;
 	}
 
-	if (mr->flags & ~XDP_UMEM_UNALIGNED_CHUNK_FLAG)
+	if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
 		return -EINVAL;
 
 	if (!unaligned_chunks && !is_power_of_2(chunk_size))
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 0e81ae6bfff4..e109b2aaeb2a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -744,6 +744,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				skb->csum_start = hr + meta->request.csum_start;
 				skb->csum_offset = meta->request.csum_offset;
 				skb->ip_summed = CHECKSUM_PARTIAL;
+
+				if (unlikely(xs->pool->tx_sw_csum)) {
+					err = skb_checksum_help(skb);
+					if (err)
+						goto free_err;
+				}
 			}
 		}
 	}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 386eddcdf837..4f6f538a5462 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -86,6 +86,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	pool->umem = umem;
 	pool->addrs = umem->addrs;
 	pool->tx_metadata_len = umem->tx_metadata_len;
+	pool->tx_sw_csum = umem->flags & XDP_UMEM_TX_SW_CSUM;
 	INIT_LIST_HEAD(&pool->free_list);
 	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 29942c2c32dc..8ed2ed9d1b17 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -33,7 +33,13 @@
 #define XDP_USE_SG	(1 << 4)
 
 /* Flags for xsk_umem_config flags */
-#define XDP_UMEM_UNALIGNED_CHUNK_FLAG (1 << 0)
+#define XDP_UMEM_UNALIGNED_CHUNK_FLAG	(1 << 0)
+
+/* Force checksum calculation in software. Can be used for testing or
+ * working around potential HW issues. This option causes performance
+ * degradation and only works in XDP_COPY mode.
+ */
+#define XDP_UMEM_TX_SW_CSUM		(1 << 1)
 
 struct sockaddr_xdp {
 	__u16 sxdp_family;
-- 
2.42.0.869.gea05f2083d-goog


