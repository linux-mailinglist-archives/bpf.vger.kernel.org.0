Return-Path: <bpf+bounces-3054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F82738CA6
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F481C20F74
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0D1B8F8;
	Wed, 21 Jun 2023 17:03:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21021B8E2
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:03:00 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328F10C
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5538f216c7aso2000790a12.0
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366979; x=1689958979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8oJ5/OEX1pF9nKL0tJ4RgAA4zY2+vJRV/bxjv3VyJo=;
        b=yqIO9pNDHL5lnesoiE6dji/e40TET35LO0r4r68gm3RLNDFg78HfKUqrh77HexkKJX
         l1Aq2FlXV7MY2fYEPYkIJDk/Emuki2dRSX+ZtM+u/qQnddM867uFqJLy0UYK739Gz0HC
         pn1gffq7MNCUBNZ6QbcTw6fSkxq+j4JJ2UHqq/2etTFTMQXTvfd3bPDr67YOTw9yrcJl
         tMtCwgFr9RL05VnFxSkWeIBCauyIxJxlSmy8oJ8dpwnzXgbx6IOUWPlANHj9Q2F5PEdD
         +UkQvymnRdQM/4NbA3mBEYT72ipEfM88lU4npVevujhyHGd0ID7+YADCK0lAH9gdTgG4
         ysZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366979; x=1689958979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8oJ5/OEX1pF9nKL0tJ4RgAA4zY2+vJRV/bxjv3VyJo=;
        b=XULHcAsKpCN85vhf8OSy65Wz+OcUVr0mCtNvKiOjRszOGk08bVKUKHDilePtxbOvBI
         jFZ3K6YoJfg2+4vTsj9Nv8SaF7iUMNpXI/egs/gWpoMVMJ7cva+0hBxLp/4KIaJyjADz
         J0jVhuYKM8s8teuGcDwukbvOW6JBF0Xr9FEIn+4NnZx/uDON4ZdzKcf63IGidwz7rUmp
         lAu10M+BCjzzoqQDXQZajbw6hc4Rbsqfi1WdDLBycDBmB/+zXeOyQkd4L/CXr5WNQK+0
         JGFBoBh/gRzlBsoRtEik8aH85wR/WBC+Dbpw3APxcnUOyyu9119MTKiUOsDRb3/aaIBJ
         my7Q==
X-Gm-Message-State: AC+VfDy2+Kf3Vk+fJll5P22UFU9hQgSpcp7HZD4B6I7iZoG6sbHnKpk3
	oVSf/8AZ19QufnjDvzrhzzpilOFNpEjnMMWPiRbxHPTFDvplPGsq9q73HVwZGoD0SyEKHQq7n0A
	xUpNurcCIgDQti6vkXb/arIDL2UNaGekfuHza5n140MBYnjCcgg==
X-Google-Smtp-Source: ACHHUZ7MXaeIj+L3sJhtCwKD2+lI8agv7n+0CugRgLu0uoJG7O3LAjcGs2Hk/XL2sCA1Yg6JLGvA/yQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:4382:0:b0:551:eb6:1ea6 with SMTP id
 q124-20020a634382000000b005510eb61ea6mr1810212pga.10.1687366979318; Wed, 21
 Jun 2023 10:02:59 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:40 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-8-sdf@google.com>
Subject: [RFC bpf-next v2 07/11] selftests/xsk: Support XDP_TX_METADATA_LEN
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new config field and call setsockopt.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xsk.c | 17 +++++++++++++++++
 tools/testing/selftests/bpf/xsk.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index 687d83e707f8..c659713e2d43 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -47,6 +47,10 @@
  #define PF_XDP AF_XDP
 #endif
 
+#ifndef XDP_TX_METADATA_LEN
+#define XDP_TX_METADATA_LEN 9
+#endif
+
 #define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
 #define XSKMAP_SIZE 1
@@ -124,12 +128,14 @@ static int xsk_set_xdp_socket_config(struct xsk_socket_config *cfg,
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
@@ -479,6 +485,17 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
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
index 8da8d557768b..57e0af403aa8 100644
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
2.41.0.162.gfafddb0af9-goog


