Return-Path: <bpf+bounces-4485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2A74B731
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FD41C21099
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE67182B6;
	Fri,  7 Jul 2023 19:30:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE83182A5
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:38 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656302D75
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:26 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-682796bdb8bso3114184b3a.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758226; x=1691350226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D6eJsNbF+26Hlj3gojwwEfVn/Oe9YdnjjlvU7i1W0CU=;
        b=CR6BKcR7Wy2o07eut2Ft3PUgYRKMjrlupEts1sdVZegDw7Y2vBuhiB/6/TtRg4Y10v
         dF+ZmYEeeVDXsks9cWWilO2HwF4t3pMKZ+RYdonIqXVZqCvrVpLBcqQMW8tZyvHCgXBO
         OPP+VvR7fXPDnne/jIO+lYo1LaV14NdXxTDX3uoR1jnIL01L6AfQFG7qZPWypBh2kKWr
         Br6GyjpfbyMiWWIqmLxSepiidS77ECCeN8TzohrG1l5tEmdR+8p03mPrNspYO4UqResx
         tMAfj6lhP5tT1gzjlYg/VNwREhCgdp/DmWpcqTgG2vsalAWJ45pFwlUl9dhB+NPRZSJw
         r1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758226; x=1691350226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6eJsNbF+26Hlj3gojwwEfVn/Oe9YdnjjlvU7i1W0CU=;
        b=UZFXuG+sHrVf8lmz0kM3ohyMXFtLz+Z2Akn8bCWRNFQ/4MGb09TmnJtFZugdb85uEG
         lw03xalXu2OTdpVGA5kep/H47Ro2frgDDBmWzxMVHym5xCiVqzc6EAw/WE/tAzKnyMRy
         SNDjLlzgkp3TBrDZXQK8hx0afLHAmXeIxpWBPIuFu3nFx7+vYkNOOsQKFuIHQ7o0UHZX
         6y73Rtia+Scb0R/zi82j11wK0kBgP/RmaoNginFI7En/w0T75kLfRhCbxwupLozl/p42
         /hKNIOkPenxu5G+ruKU65XnKGYvF9mZXlceKdDWWc3QMLHJ+MJV2Hzr8ThHwbZf8MvcO
         6nxQ==
X-Gm-Message-State: ABy/qLa7iXR+Dc1JlpxotrG8YsjfYPAWJbv8br9E5KzYoMcXBEzPsvEA
	wTHSicAvVC02ZyfFdEZzvy1irwXFHhaqmSni0CkKPtYOwyiswb7SFl9MBZ/G1C/bde8bp8R2J3f
	5JMll+TQX1r7euCL4JNA8cekhWxCQd8HP0ZrXMezQgOmRgVvQNA==
X-Google-Smtp-Source: APBJJlGlPCsXSYtdOtBh5/L6+wNsA2GXrVg66+kTKWgIhr5kP0PSMj3CUf7R60wWUoAtPJsFFnWe6Wc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3990:b0:666:e42c:d5ec with SMTP id
 fi16-20020a056a00399000b00666e42cd5ecmr7969481pfb.3.1688758225753; Fri, 07
 Jul 2023 12:30:25 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:30:02 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-11-sdf@google.com>
Subject: [RFC bpf-next v3 10/14] selftests/xsk: Support XDP_TX_METADATA_LEN
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
2.41.0.255.g8b1d071c50-goog


