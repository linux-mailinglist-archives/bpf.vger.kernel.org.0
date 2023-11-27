Return-Path: <bpf+bounces-15972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F77FA992
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C75228173D
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F13FE55;
	Mon, 27 Nov 2023 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIVjk+U+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8FD64
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cd573c2cccso27462067b3.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111816; x=1701716616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QvtONr4OjbkhkoDPQ2air09KCE/816l/OMoWhPA4kI=;
        b=eIVjk+U+yo/SqZViQJPge6E0rN5WX+uhQLx/l7vgSwVKN0AnzOYHnTlY8nkzOCmMvZ
         A0RANphhj1LIwgJed2pmCoiVvMzrNAhoUxjH90FiFk9vtxsypWjLHBdsBEvX7F7FLA+C
         MYtWIHc+wUFkXO2QlRPCj0ILMlnUIqbAi9gz9nqkljMqOQG0hUW1xNwx9K4BBfWjR82Q
         lPNSPy7Tx2Wk7OYzjkDcBwE1H9S8JtnHvf1byasA8bYFFo7OZOTXitdj37BHaGdWi0CT
         LwSEXUM+UI/x/TAbJaylJ/3aJ5lwXsQu9cC6tBFFDfz7GFDxf4Mgj8jiZgIk19Gi81uH
         9ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111816; x=1701716616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QvtONr4OjbkhkoDPQ2air09KCE/816l/OMoWhPA4kI=;
        b=n1wA2FGWFcRmVBZMM6LLAeDWQFcwVdNGc/z9KbSMFGoUDAs6hVMoZVRimbf5rIX8I8
         5ViVbZOuTjI3GqVug6r5B78Df7er5XEqxePiGPQmAZHycvyc06WNS4CZZQzsqwPnOqbL
         AzXgQJgPciEZnOpp0uvF4OEhtxsJkSy4islUuHIX+e2BhYZbCySwZ4JSUkituoysxvDk
         Zf9avhHZfhHx18BeBMYrR1WBp4LJhlhjOwkRcCmP0skVVOwlqp5fYJAqTgETg/3XciY4
         QEwwFG7WAWFSOg/c5xNt6VpsUgaIFjvcdEKh82dr3h4zG3ls3Fy5fe1un10HlKByuKVX
         C0ZQ==
X-Gm-Message-State: AOJu0Yzoy+/kZ3IUm7Na/imHvOwTkbHjmJJkVUsEhqkkfI8PuMB9qaaY
	9iaku3GtYTCfVj4DotlB0mLAZxqTnvqNuttarQ5pWeJoqvCAYMfQCDlbS36gp1ed50Jd3CyG0Wz
	AjoDXV7iiOXUH2Tw6d2wHFdtNWQfN4Hr/x6pqlG5so+O+PcQL2Q==
X-Google-Smtp-Source: AGHT+IF7uTKY5e37aqevUScyDnyGHkG7JIEfn64W34mnrvyLoyNqrtOGVcerCTq7PO979xB+WpnVmmA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:844:b0:5cc:ba30:bcd1 with SMTP id
 bz4-20020a05690c084400b005ccba30bcd1mr487498ywb.3.1701111816186; Mon, 27 Nov
 2023 11:03:36 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:14 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-9-sdf@google.com>
Subject: [PATCH bpf-next v6 08/13] xsk: Add option to calculate TX checksum in SW
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
index 95de66d5a26c..d31698410410 100644
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
index d66ba9d6154f..281d49b4fca4 100644
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
index d0882edc1642..638c606dfa74 100644
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
2.43.0.rc1.413.gea7ed67945-goog


