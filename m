Return-Path: <bpf+bounces-4476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8374B714
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF79F281894
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A27017737;
	Fri,  7 Jul 2023 19:30:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BB1772D
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:25 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F22D4E
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b2ac94f31so3240345a12.2
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758210; x=1691350210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUwtriwyOracwMOZXeZy5WPkxcNh6yxf9oRms7nzKTY=;
        b=qE5Myo3wSjo3LsuFxTz4/bRnyf+YOr2aksD2nwWyYWNgX6cRUXFqVARhtybvHNFe2f
         X++li3s3pABDk1Pj2x076dgfLsz8sO8UUwby8PqoEm3ylyPf3b6nk0yfr2ncwiuNfxtv
         FlSe2PDnS81ctP2tZ9izhJsjjrdC8ypj2YO6EnzIq0o4zjKFoVJpf23cIfoAbK7pP3PF
         S7NCA0RPcXDrXVJKI5pMDrq9ztkWeupEf4mLSg0+HjGxbMRl9PthU29Yvk2K5kvVC0QT
         sgOfkQsmLCWiPGHdnbuyWhzdpdCgOWDeigkPrcZunAiBSjxTXgIJ7RPr7DkyLsvpCqPp
         eN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758210; x=1691350210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUwtriwyOracwMOZXeZy5WPkxcNh6yxf9oRms7nzKTY=;
        b=K1FXlQUKDVZfz5cZvo/QDvXS322yUZj0B6Dw2blacaR34ZfW/G3FX359VE1p6g9OTG
         jg43PD6+hJ/Sir3EBGs63U3FML8YZq9vB/NZ7HU2y+uKJo6FLmxnp1S5Alh+pWKlomEr
         PTi1CIZEqguf8hZErvkqI9FMG8rQwyLrt+5fzZZYEGWp/lxfOHOIRTOA2vXaUbRdxhly
         RYGrSThqrf8EdQZmNZgVB+qoTi01qd2IHgOXsjcWiB+RVhMQ2hpawyMa2elK2rsLkBFY
         MHjVLm8i1ZzCwXflTPC8es+pVQMuPSQRkVOR/VTIjDmP5Zi53Nb1iLZM4y/zrtdHKRbK
         /qRQ==
X-Gm-Message-State: ABy/qLYlmLwCUNN/WDCyhxQDELR7dkKgVSZ/kOdBLbUhaAcHhSLp1z5L
	uCEOFeTt6DvouOnlqXsUI5xzwXHCz0p0UKuunzyI/VTc2MH+1BN0XeFQj0r45uZgxqQ+Ilb+Qds
	g26wwnl/tw/HDy8JS8NR0G6O1vymFVffqFhnmmCxoipAhHJC+fA==
X-Google-Smtp-Source: APBJJlHfnmoyS4495xHVU6VUWBR28u6C2ELCQ1/k8iKyN9B++NBMhgpA3UyTUK0+bu6zEa88AdAOVgU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7015:0:b0:553:3b6c:b3b3 with SMTP id
 l21-20020a637015000000b005533b6cb3b3mr4002662pgc.4.1688758209600; Fri, 07 Jul
 2023 12:30:09 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:53 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-2-sdf@google.com>
Subject: [RFC bpf-next v3 01/14] bpf: Rename some xdp-metadata functions into dev-bound
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

No functional changes.

To make existing dev-bound infrastructure more generic and be
less tightly bound to the xdp layer, rename some functions and
move kfunc-related things into kernel/bpf/offload.c

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/offload.h | 28 ++++++++++++++++++++++++++++
 include/net/xdp.h     | 18 +-----------------
 kernel/bpf/offload.c  | 26 ++++++++++++++++++++++++--
 kernel/bpf/verifier.c |  4 ++--
 net/core/xdp.c        | 20 ++------------------
 5 files changed, 57 insertions(+), 39 deletions(-)
 create mode 100644 include/net/offload.h

diff --git a/include/net/offload.h b/include/net/offload.h
new file mode 100644
index 000000000000..264a35881473
--- /dev/null
+++ b/include/net/offload.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_NET_OFFLOAD_H__
+#define __LINUX_NET_OFFLOAD_H__
+
+#include <linux/types.h>
+
+#define XDP_METADATA_KFUNC_xxx	\
+	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
+			      bpf_xdp_metadata_rx_timestamp) \
+	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
+			      bpf_xdp_metadata_rx_hash)
+
+enum {
+#define NETDEV_METADATA_KFUNC(name, _) name,
+XDP_METADATA_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+MAX_NETDEV_METADATA_KFUNC,
+};
+
+#ifdef CONFIG_NET
+u32 bpf_dev_bound_kfunc_id(int id);
+bool bpf_is_dev_bound_kfunc(u32 btf_id);
+#else
+static inline u32 bpf_dev_bound_kfunc_id(int id) { return 0; }
+static inline bool bpf_is_dev_bound_kfunc(u32 btf_id) { return false; }
+#endif
+
+#endif /* __LINUX_NET_OFFLOAD_H__ */
diff --git a/include/net/xdp.h b/include/net/xdp.h
index d1c5381fc95f..de4c3b70abde 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -9,6 +9,7 @@
 #include <linux/skbuff.h> /* skb_shared_info */
 #include <uapi/linux/netdev.h>
 #include <linux/bitfield.h>
+#include <net/offload.h>
 
 /**
  * DOC: XDP RX-queue information
@@ -384,19 +385,6 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 
 #define DEV_MAP_BULK_SIZE XDP_BULK_QUEUE_SIZE
 
-#define XDP_METADATA_KFUNC_xxx	\
-	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
-			   bpf_xdp_metadata_rx_timestamp) \
-	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
-			   bpf_xdp_metadata_rx_hash) \
-
-enum {
-#define XDP_METADATA_KFUNC(name, _) name,
-XDP_METADATA_KFUNC_xxx
-#undef XDP_METADATA_KFUNC
-MAX_XDP_METADATA_KFUNC,
-};
-
 enum xdp_rss_hash_type {
 	/* First part: Individual bits for L3/L4 types */
 	XDP_RSS_L3_IPV4		= BIT(0),
@@ -444,14 +432,10 @@ enum xdp_rss_hash_type {
 };
 
 #ifdef CONFIG_NET
-u32 bpf_xdp_metadata_kfunc_id(int id);
-bool bpf_dev_bound_kfunc_id(u32 btf_id);
 void xdp_set_features_flag(struct net_device *dev, xdp_features_t val);
 void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg);
 void xdp_features_clear_redirect_target(struct net_device *dev);
 #else
-static inline u32 bpf_xdp_metadata_kfunc_id(int id) { return 0; }
-static inline bool bpf_dev_bound_kfunc_id(u32 btf_id) { return false; }
 
 static inline void
 xdp_set_features_flag(struct net_device *dev, xdp_features_t val)
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 8a26cd8814c1..235d81f7e0ed 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -844,9 +844,9 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	if (!ops)
 		goto out;
 
-	if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
+	if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
 		p = ops->xmo_rx_timestamp;
-	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
+	else if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
 		p = ops->xmo_rx_hash;
 out:
 	up_read(&bpf_devs_lock);
@@ -854,6 +854,28 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	return p;
 }
 
+BTF_SET_START(dev_bound_kfunc_ids)
+#define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
+XDP_METADATA_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+BTF_SET_END(dev_bound_kfunc_ids)
+
+BTF_ID_LIST(dev_bound_kfunc_ids_unsorted)
+#define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
+XDP_METADATA_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+
+u32 bpf_dev_bound_kfunc_id(int id)
+{
+	/* dev_bound_kfunc_ids is sorted and can't be used */
+	return dev_bound_kfunc_ids_unsorted[id];
+}
+
+bool bpf_is_dev_bound_kfunc(u32 btf_id)
+{
+	return btf_id_set_contains(&dev_bound_kfunc_ids, btf_id);
+}
+
 static int __init bpf_offload_init(void)
 {
 	return rhashtable_init(&offdevs, &offdevs_params);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..e7b2d0a6d7c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2721,7 +2721,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		}
 	}
 
-	if (bpf_dev_bound_kfunc_id(func_id)) {
+	if (bpf_is_dev_bound_kfunc(func_id)) {
 		err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
 		if (err)
 			return err;
@@ -17923,7 +17923,7 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 	void *xdp_kfunc;
 	bool is_rdonly;
 
-	if (bpf_dev_bound_kfunc_id(func_id)) {
+	if (bpf_is_dev_bound_kfunc(func_id)) {
 		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
 		if (xdp_kfunc) {
 			*addr = (unsigned long)xdp_kfunc;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 41e5ca8643ec..819767697370 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -741,9 +741,9 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
+#define NETDEV_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
 XDP_METADATA_KFUNC_xxx
-#undef XDP_METADATA_KFUNC
+#undef NETDEV_METADATA_KFUNC
 BTF_SET8_END(xdp_metadata_kfunc_ids)
 
 static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
@@ -751,22 +751,6 @@ static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
 	.set   = &xdp_metadata_kfunc_ids,
 };
 
-BTF_ID_LIST(xdp_metadata_kfunc_ids_unsorted)
-#define XDP_METADATA_KFUNC(name, str) BTF_ID(func, str)
-XDP_METADATA_KFUNC_xxx
-#undef XDP_METADATA_KFUNC
-
-u32 bpf_xdp_metadata_kfunc_id(int id)
-{
-	/* xdp_metadata_kfunc_ids is sorted and can't be used */
-	return xdp_metadata_kfunc_ids_unsorted[id];
-}
-
-bool bpf_dev_bound_kfunc_id(u32 btf_id)
-{
-	return btf_id_set8_contains(&xdp_metadata_kfunc_ids, btf_id);
-}
-
 static int __init xdp_metadata_init(void)
 {
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
-- 
2.41.0.255.g8b1d071c50-goog


