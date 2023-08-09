Return-Path: <bpf+bounces-7390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E2B7765BC
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA5D281BE7
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A651DA41;
	Wed,  9 Aug 2023 16:54:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC21D2F5
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:54:31 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F321BFE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:54:30 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56385c43eaeso1091791a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600070; x=1692204870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XXAjWuOtm6YNmo2ZHsGe+OokqWo6K0W0zM94x/Po2M=;
        b=sxOfDLfapWQWB/hhXXyI8M5A9fLFZUOnb5mkg0ycH0YhS8gctaSQgIAkLLp56dA1iu
         gmDE4h8ggIXcpBihQme8xXhnqOCCPISUMIz+DZ4U908LSIwGLePs53+Hrv99YIOt8D8D
         Y1dYxX+LbAkq15P6aC7B9dhvyMFfDsiGdwp/O25y6o4zy/2KfN7vZCjjAp2dXyI2i4Sh
         LFijGTdhU0BFWtXg04KitMEGXq97Yn4h/FSQ/8KV5XmHy+wP3vEjmnRs4yi45/sxRfNS
         tbnRIlIXqCekM+J3N2JLV54saE47Q98yHomlZrDTVFogzR2w3laPKnJ8s0N2DvQEVJ7o
         e19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600070; x=1692204870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XXAjWuOtm6YNmo2ZHsGe+OokqWo6K0W0zM94x/Po2M=;
        b=AaS+vaT3VlphVNQgOopp0tgJR16pW5PEChp2NIyIhbkszlQjVmWaSSYijpi4QyEwTz
         HBvPqFb6HgDv7VtLWAAgu8imJ7kBtITL7Y5DjA5sTEKVMI+A4rP+6qDff1NiffCkPu6F
         Vx42g9zELSa8HEMex5mGCpgO8KrASZhrZzUistdGv4NNRJUCZJLZq/xr9PwAPL+nXHs2
         23bzc/CMQdpRml9+KAcjXrrXZiD3DFoa4yxmnbHFGe6VjtCzqZGmiaHAWwmD4RWTXH2O
         Ukq8kuOx12pgirp1gCTlE0jRZpZwgmb8nVYR46PWrTIozXH6wVjsSexdicLauI198zTG
         h26g==
X-Gm-Message-State: AOJu0Yybub/6d5Gfqq8fA+fialPSN/AnGXxHmLyxAVNoWVhjIERITowc
	+BPSsFfin3VTP+OcwlyCSdTNyB1ZdAL2tsbktPJxfB1YJQzGv7ctdP4j4OZtDI496SIWiZgcNIX
	wStIvTscKHf1T5Efzu17fRFrRXCzhXEjExjI48dOEYXLOiZ1icQ==
X-Google-Smtp-Source: AGHT+IElNYWkuBNI6oxaQerIGrxmFs6Ms06U/Hm6h/zSlHg/lviZnI5o0kc4Aa59CV5yCmLs2JKNDgI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:714d:0:b0:564:480c:f405 with SMTP id
 b13-20020a63714d000000b00564480cf405mr293189pgn.1.1691600069926; Wed, 09 Aug
 2023 09:54:29 -0700 (PDT)
Date: Wed,  9 Aug 2023 09:54:14 -0700
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809165418.2831456-6-sdf@google.com>
Subject: [PATCH bpf-next 5/9] selftests/xsk: Support XDP_TX_METADATA_LEN
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new config field and call setsockopt.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xsk.c | 17 +++++++++++++++++
 tools/testing/selftests/bpf/xsk.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index d9fb2b730a2c..cb7e48f24289 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -49,6 +49,10 @@
  #define PF_XDP AF_XDP
 #endif
 
+#ifndef XDP_TX_METADATA_LEN
+#define XDP_TX_METADATA_LEN 9
+#endif
+
 #define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
 #define XSKMAP_SIZE 1
@@ -132,12 +136,14 @@ static int xsk_set_xdp_socket_config(struct xsk_socket_config *cfg,
 		cfg->rx_size = XSK_RING_CONS__DEFAULT_NUM_DESCS;
 		cfg->tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 		cfg->bind_flags = 0;
+		cfg->tx_metadata_len = 0;
 		return 0;
 	}
 
 	cfg->rx_size = usr_cfg->rx_size;
 	cfg->tx_size = usr_cfg->tx_size;
 	cfg->bind_flags = usr_cfg->bind_flags;
+	cfg->tx_metadata_len = usr_cfg->tx_metadata_len;
 
 	return 0;
 }
@@ -613,6 +619,17 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 			umem->tx_ring_setup_done = true;
 	}
 
+	if (xsk->config.tx_metadata_len) {
+		int optval = xsk->config.tx_metadata_len;
+
+		err = setsockopt(xsk->fd, SOL_XDP, XDP_TX_METADATA_LEN,
+				 &optval, sizeof(optval));
+		if (err) {
+			err = -errno;
+			goto out_put_ctx;
+		}
+	}
+
 	err = xsk_get_mmap_offsets(xsk->fd, &off);
 	if (err) {
 		err = -errno;
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index d93200fdaa8d..325fe0c83e5d 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -212,6 +212,7 @@ struct xsk_socket_config {
 	__u32 rx_size;
 	__u32 tx_size;
 	__u16 bind_flags;
+	__u8 tx_metadata_len;
 };
 
 /* Set config to NULL to get the default configuration. */
-- 
2.41.0.640.ga95def55d0-goog


