Return-Path: <bpf+bounces-9567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22597799291
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454641C20E86
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F97488;
	Fri,  8 Sep 2023 22:58:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6E747E
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 22:58:15 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73291FEF
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 15:58:13 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26f51ce1a11so3261115a91.0
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 15:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694213893; x=1694818693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkwc7yrTBpsjyrTjJIwx/4oLtksDFcPPgxIaa+w6Cdc=;
        b=3Xep5bjzf1YiJ4YonrvdA8Ift8tzDLCVP7MqTG60mgofrtKy3TdVhR20s9t6EH3xk9
         eDr0lm35dvMR4dZ/pQiqXoZRimbey9yXn4rKbINXjoG/GRiNEnraweXLJeIZPagmMTTe
         ubSv9CYioKSR9tifwDs44669lK9WzNJ3SHwg65jppuSVx9zOrvS07acE14hPZuoKYfoD
         HKviJCsklrmjlOoFYBCNqDrEsY94omkqlyzyaDV7T1SSJQmzAwvSztXJ6LLcQOs92yEi
         REybcBcQJbeE8gFQeCrrc4gA/wtaqxNCk/blZ0bnKyL1yVIhLEIxU6Cd6In/Yuwc8NkA
         Abgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213893; x=1694818693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkwc7yrTBpsjyrTjJIwx/4oLtksDFcPPgxIaa+w6Cdc=;
        b=U+grYnl2sS2U7MFpjAlVynqL/ygFgI5bcg2V3tZRS/QSS29+2B9sDtvxn4y8bhEpUN
         K8ArvXbTNub6KtL57kDRUZr19TPiEzWceaAAAxCYSy6Dy7yYDJ/NaMpqahdoC53oSt8T
         8npM0gZ/BdB/HclD6isURiBQ2TuM56E2Pjf9x6Q95dGaBxkORZcvZuVnAbG8ciPx8ljW
         0OtXwVXE405ue8P5fYKpPlIHIlOyBaRg4Kk7IDT9zK7vmwkXUR4ogJHWLGDYeBd0veIM
         1Md50yS824ONebTOyxN//eLVXAdlwxQunTgxv8JBthds5NdcoX34MGYcrFYY83yvj0gg
         yc5g==
X-Gm-Message-State: AOJu0YyLbNVYHOu+DuyLKiMqMq1a81lE3+x4ktXE9VTLvkK7ywdsc64L
	YYLM5kX2X9r5QS5X8uu44uOIJ0TdU8s0BxoOxgj57XvO7+V1PMEK4t9r2uDy8dMTsStLeNYs9/h
	0Txk7InuDawgNH6ZkAop78XFQat2tulAjVQcm16mZ/1c6snlX9Q==
X-Google-Smtp-Source: AGHT+IHB5Ul8wCt1RYIjg6HXPXfiSTr9kLJwbaVv/my1W2lh/+rJo2DzbENdicrY/RaVOtJoptRJr4I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:a0f:b0:268:1d63:b9ae with SMTP id
 gg15-20020a17090b0a0f00b002681d63b9aemr1005306pjb.3.1694213893048; Fri, 08
 Sep 2023 15:58:13 -0700 (PDT)
Date: Fri,  8 Sep 2023 15:58:06 -0700
In-Reply-To: <20230908225807.1780455-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908225807.1780455-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908225807.1780455-3-sdf@google.com>
Subject: [PATCH bpf-next 2/3] bpf: expose information about supported xdp
 metadata kfunc
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new xdp-rx-metadata-features member to netdev netlink
which exports a bitmask of supported kfuncs. Most of the patch
is autogenerated (headers), the only relevant part is netdev.yaml
and the changes in netdev-genl.c to marshal into netlink.

Example output on veth:

$ ip link add veth0 type veth peer name veth1 # ifndex == 12
$ ./tools/net/ynl/samples/netdev 12

Select ifc ($ifindex; or 0 = dump; or -2 ntf check): 12
   veth1[12]    xdp-features (23): basic redirect rx-sg xdp-rx-metadata-features (3): timestamp hash xdp-zc-max-segs=0

Cc: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/netlink/specs/netdev.yaml      | 21 ++++++++++++++++++++
 Documentation/networking/xdp-rx-metadata.rst |  7 +++++++
 include/net/xdp.h                            |  5 ++++-
 include/uapi/linux/netdev.h                  | 16 +++++++++++++++
 kernel/bpf/offload.c                         |  2 +-
 net/core/netdev-genl.c                       | 12 ++++++++++-
 net/core/xdp.c                               |  4 ++--
 tools/include/uapi/linux/netdev.h            | 16 +++++++++++++++
 8 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 1c7284fd535b..c46fcc78fc04 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -42,6 +42,19 @@ name: netdev
         doc:
           This feature informs if netdev implements non-linear XDP buffer
           support in ndo_xdp_xmit callback.
+  -
+    type: flags
+    name: xdp-rx-metadata
+    render-max: true
+    entries:
+      -
+        name: timestamp
+        doc:
+          Device is capable of exposing receive HW timestamp via bpf_xdp_metadata_rx_timestamp().
+      -
+        name: hash
+        doc:
+          Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
 
 attribute-sets:
   -
@@ -68,6 +81,13 @@ name: netdev
         type: u32
         checks:
           min: 1
+      -
+        name: xdp-rx-metadata-features
+        doc: Bitmask of supported XDP receive metadata features.
+             See Documentation/networking/xdp-rx-metadata.rst for more details.
+        type: u64
+        enum: xdp-rx-metadata
+        enum-as-flags: true
 
 operations:
   list:
@@ -84,6 +104,7 @@ name: netdev
             - ifindex
             - xdp-features
             - xdp-zc-max-segs
+            - xdp-rx-metadata-features
       dump:
         reply: *dev-all
     -
diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index 25ce72af81c2..205696780b78 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -105,6 +105,13 @@ bpf_tail_call
 Adding programs that access metadata kfuncs to the ``BPF_MAP_TYPE_PROG_ARRAY``
 is currently not supported.
 
+Supported Devices
+=================
+
+It is possible to query which kfunc the particular netdev implements via
+netlink. See ``xdp-rx-metadata-features`` attribute set in
+``Documentation/netlink/specs/netdev.yaml``.
+
 Example
 =======
 
diff --git a/include/net/xdp.h b/include/net/xdp.h
index d59e12f8f311..349c36fb5fd8 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -386,19 +386,22 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 /* Define the relationship between xdp-rx-metadata kfunc and
  * various other entities:
  * - xdp_rx_metadata enum
+ * - netdev netlink enum (Documentation/netlink/specs/netdev.yaml)
  * - kfunc name
  * - xdp_metadata_ops field
  */
 #define XDP_METADATA_KFUNC_xxx	\
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
+			   NETDEV_XDP_RX_METADATA_TIMESTAMP, \
 			   bpf_xdp_metadata_rx_timestamp, \
 			   xmo_rx_timestamp) \
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
+			   NETDEV_XDP_RX_METADATA_HASH, \
 			   bpf_xdp_metadata_rx_hash, \
 			   xmo_rx_hash) \
 
 enum xdp_rx_metadata {
-#define XDP_METADATA_KFUNC(name, _, __) name,
+#define XDP_METADATA_KFUNC(name, _, __, ___) name,
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 MAX_XDP_METADATA_KFUNC,
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index c1634b95c223..2943a151d4f1 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -38,11 +38,27 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_MASK = 127,
 };
 
+/**
+ * enum netdev_xdp_rx_metadata
+ * @NETDEV_XDP_RX_METADATA_TIMESTAMP: Device is capable of exposing receive HW
+ *   timestamp via bpf_xdp_metadata_rx_timestamp().
+ * @NETDEV_XDP_RX_METADATA_HASH: Device is capable of exposing receive packet
+ *   hash via bpf_xdp_metadata_rx_hash().
+ */
+enum netdev_xdp_rx_metadata {
+	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
+	NETDEV_XDP_RX_METADATA_HASH = 2,
+
+	/* private: */
+	NETDEV_XDP_RX_METADATA_MASK = 3,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
 	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
+	NETDEV_A_DEV_XDP_RX_METADATA_FEATURES,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 6aa6de8d715d..e7a1752b5a09 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -845,7 +845,7 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	if (!ops)
 		goto out;
 
-#define XDP_METADATA_KFUNC(name, _, xmo) \
+#define XDP_METADATA_KFUNC(name, _, __, xmo) \
 	if (func_id == bpf_xdp_metadata_kfunc_id(name)) p = ops->xmo;
 	XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index c1aea8b756b6..d9bef2f56bd2 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -5,6 +5,7 @@
 #include <linux/rtnetlink.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
+#include <net/xdp.h>
 
 #include "netdev-genl-gen.h"
 
@@ -12,15 +13,24 @@ static int
 netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 		   const struct genl_info *info)
 {
+	u64 xdp_rx_meta = 0;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
 		return -EMSGSIZE;
 
+#define XDP_METADATA_KFUNC(_, flag, __, xmo) \
+	if (netdev->xdp_metadata_ops->xmo) \
+		xdp_rx_meta |= flag;
+XDP_METADATA_KFUNC_xxx
+#undef XDP_METADATA_KFUNC
+
 	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
 	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_FEATURES,
-			      netdev->xdp_features, NETDEV_A_DEV_PAD)) {
+			      netdev->xdp_features, NETDEV_A_DEV_PAD) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_RX_METADATA_FEATURES,
+			      xdp_rx_meta, NETDEV_A_DEV_PAD)) {
 		genlmsg_cancel(rsp, hdr);
 		return -EINVAL;
 	}
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bab563b2f812..df4789ab512d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-#define XDP_METADATA_KFUNC(_, name, __) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
+#define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 BTF_SET8_END(xdp_metadata_kfunc_ids)
@@ -752,7 +752,7 @@ static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
 };
 
 BTF_ID_LIST(xdp_metadata_kfunc_ids_unsorted)
-#define XDP_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
+#define XDP_METADATA_KFUNC(name, _, str, __) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index c1634b95c223..2943a151d4f1 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -38,11 +38,27 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_MASK = 127,
 };
 
+/**
+ * enum netdev_xdp_rx_metadata
+ * @NETDEV_XDP_RX_METADATA_TIMESTAMP: Device is capable of exposing receive HW
+ *   timestamp via bpf_xdp_metadata_rx_timestamp().
+ * @NETDEV_XDP_RX_METADATA_HASH: Device is capable of exposing receive packet
+ *   hash via bpf_xdp_metadata_rx_hash().
+ */
+enum netdev_xdp_rx_metadata {
+	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
+	NETDEV_XDP_RX_METADATA_HASH = 2,
+
+	/* private: */
+	NETDEV_XDP_RX_METADATA_MASK = 3,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
 	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
+	NETDEV_A_DEV_XDP_RX_METADATA_FEATURES,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
-- 
2.42.0.283.g2d96d420d3-goog


