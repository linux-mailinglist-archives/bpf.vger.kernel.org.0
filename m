Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DC71EF818
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFEMkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jun 2020 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgFEMkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jun 2020 08:40:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DEEC08C5C2
        for <bpf@vger.kernel.org>; Fri,  5 Jun 2020 05:40:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so3266222pju.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2020 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnM2G7U56YfE91BOLfwcyKg2xjE8uBv7Ythb6eU+tHE=;
        b=Dih/um1Mx3FXjcI7pUe4T85w6CV/k5zKv7CnFb2GNHLvyJdK5j3zBLYigcqSznJnPX
         koRrFMz6Kjeqf1nG3ZssFrOj9Dxythxq0OtPKkO9HagS5EIt6EC12YCyJh+bwsItz/PK
         pWLZGf08M9RrH/xjPkO6fd/OOxUo6PBlA1SgPVv8X28SK7EXrgA6mcI33aINWrxj8Ph/
         wvpsphG2q/JiWbfHckbez+AhfLe4YEmugmZ7wNb7AAdqeFgCckJ6MUmBu6nN0HtqS30f
         sx7ShsC6SBC41z/Wyda/b9nFvvXRlnRhMDCrDvLoq6mvUyEVkMKtJMJ0f5cKjhfXlGtV
         I4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnM2G7U56YfE91BOLfwcyKg2xjE8uBv7Ythb6eU+tHE=;
        b=oQB1PdJKbzvvomRSEyGVeYNW8QQr4KU+nPWZgAYJCp7OUueoeoVIQcr23bEjTB8rn3
         TUyIoxjPkVJKPHj3xrjwa77Pr8TWG8vJVdce/WVc04VME08FttF9+/SgkmToPWZyqoOG
         +yr+QDT/UF4G0qaEi95rrQQfM+5rzGpKrrW+cHrgeZe1D1XzPgHpLuJqhXy5UxtLM9mj
         77zNFu41LPjRc3Hd8vtVxwesISr5yD5qKECC7M6UadrDJTiTYDz17eFjwH++qZ+xiVrF
         tFwcaif5GnHec39+lkNSrY/bsHmhimnQdcPBEYvPtmrVDbYEfm9WG9CV802Hh7TtfoTw
         NP8A==
X-Gm-Message-State: AOAM530P84fDKeSOHAEqTUsz0NkvtQZraOeeOysBFQPuXaFcSvoKnQym
        e/gYRLBOP2QC8Sx0A/M/kIdXWmjEvnNFxw==
X-Google-Smtp-Source: ABdhPJzYSYHsU52i2eoTc77ktkXvLlvs7hnp9mfWJSyjSJJwJR0yWyYk02IYyQC3W7skg5+0pgAAug==
X-Received: by 2002:a17:90a:c4:: with SMTP id v4mr2736987pjd.21.1591360822988;
        Fri, 05 Jun 2020 05:40:22 -0700 (PDT)
Received: from localhost.localdomain ([45.192.173.252])
        by smtp.gmail.com with ESMTPSA id i10sm7481493pfa.166.2020.06.05.05.40.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2020 05:40:22 -0700 (PDT)
From:   Wang Li <wangli8850@gmail.com>
X-Google-Original-From: Wang Li <wangli09@kuaishou.com>
To:     bpf@vger.kernel.org, daniel@iogearbox.net
Cc:     Wang Li <wangli09@kuaishou.com>,
        huangxuesen <huangxuesen@kuaishou.com>,
        yangxingwu <yangxingwu@kuaishou.com>
Subject: [PATCH] bpf: export the net namespace for bpf_sock_ops
Date:   Fri,  5 Jun 2020 20:40:11 +0800
Message-Id: <20200605124011.71043-1-wangli09@kuaishou.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sometimes we need net namespace as part of the key for BPF_MAP_TYPE_SOCKHASH to
distinguish the connections with same five-tuples, for example when we do the
sock_map acceleration for the proxy that uses 127.0.0.1 to 127.0.0.1 connections
in different containers on same node.
And we export the netns inum instead of the real pointer of struct net to avoid
the potential security issue.

Signed-off-by: Wang Li <wangli09@kuaishou.com>
Signed-off-by: huangxuesen <huangxuesen@kuaishou.com>
Signed-off-by: yangxingwu <yangxingwu@kuaishou.com>
---
 include/uapi/linux/bpf.h       |  2 ++
 net/core/filter.c              | 17 +++++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c65b374a5090..0fe7e459f023 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3947,6 +3947,8 @@ struct bpf_sock_ops {
 				 * there is a full socket. If not, the
 				 * fields read as zero.
 				 */
+	__u32 netns_inum;	/* The net namespace this sock belongs to */
+
 	__u32 snd_cwnd;
 	__u32 srtt_us;		/* Averaged RTT << 3 in usecs */
 	__u32 bpf_sock_ops_cb_flags; /* flags defined in uapi/linux/tcp.h */
diff --git a/net/core/filter.c b/net/core/filter.c
index d01a244b5087..bfe448ace25f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8450,6 +8450,23 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 					       is_fullsock));
 		break;
 
+	case offsetof(struct bpf_sock_ops, netns_inum):
+#ifdef CONFIG_NET_NS
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
+						struct bpf_sock_ops_kern, sk),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sock_ops_kern, sk));
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
+						struct sock_common, skc_net),
+				      si->dst_reg, si->dst_reg,
+				      offsetof(struct sock_common, skc_net));
+		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
+				      offsetof(struct net, ns.inum));
+#else
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, 0);
+#endif
+		break;
+
 	case offsetof(struct bpf_sock_ops, state):
 		BUILD_BUG_ON(sizeof_field(struct sock_common, skc_state) != 1);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c65b374a5090..0fe7e459f023 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3947,6 +3947,8 @@ struct bpf_sock_ops {
 				 * there is a full socket. If not, the
 				 * fields read as zero.
 				 */
+	__u32 netns_inum;	/* The net namespace this sock belongs to */
+
 	__u32 snd_cwnd;
 	__u32 srtt_us;		/* Averaged RTT << 3 in usecs */
 	__u32 bpf_sock_ops_cb_flags; /* flags defined in uapi/linux/tcp.h */
-- 
2.20.1 (Apple Git-117)

