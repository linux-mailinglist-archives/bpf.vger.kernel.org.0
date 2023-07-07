Return-Path: <bpf+bounces-4480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AA74B723
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39119280C04
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09117ADB;
	Fri,  7 Jul 2023 19:30:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F417AC5
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:34 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B492D67
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b88dee40ecso30372445ad.3
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758217; x=1691350217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tiu69YMe2M+wf4vbIlXmUvKcMNINiQeYanMmI5AOt4s=;
        b=OKXQqOlyynsQJhOyVPnqD/bFpdqEp8ugLvHEc91O6ItK+f44sM9EakNc+gyOsRdBdT
         0NlYKejJBNAQFcJ+3jJOGjNNUKgn8H9JtJwjkPA2QNutCsXMluQnmgCa3bV0KZfxw6Vg
         bFd3vnOOLWuppe3JjeVOKY0/SOkAgzZxsw56e9Un1DlD/kxRzWHg/agVHydxWXCgi+9A
         0gF2UUZWdBSoWx4EtTUWfL72YKNA51KpZLV9A7H69Qw0V53Jzy0ymOnFouLd/HiW00f/
         edJUrC2/DJAq5i8N4SM2rLm/h+ZyHk+MjBNISIUsOs0YDBWYWfKFzHQp9tMgHDd5DHdR
         7g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758217; x=1691350217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiu69YMe2M+wf4vbIlXmUvKcMNINiQeYanMmI5AOt4s=;
        b=eT7GObPESGPhkkAEo0bI7QuIokjL96tgsdkNyvL7GCOCmFirwt3d0MgwVs+Vl+kNbH
         m14C43U7z5a0XhHk+6N73MTi+en23qpwMU0HDWaP5kAF85X8t1+TkaOA5yMGFsj4g6hR
         FsfQ9hFc8USSmKrsWyiE1TJ7JeEAowQOsEbeTX1bCmI87UUSMBiuE05hYiYm0IfIFh/s
         5smSbDemdtx/LKPbuvUmFvQQpDpCo+OSFrM6N5J0Crcj1XmYFAIArVpj42Ktd80s98kG
         LpE5kFtdEb85uU/67OiYQHnmVhNR97ZNO4O+zwUKQ5HKakmoaD+ktZCpOR8WGNMdSWi/
         j96A==
X-Gm-Message-State: ABy/qLb+NjnnKn/USi9NPwwsOSUu+YsWHAmpjId7Wn7cCoAPzp+sUlbE
	hcJ1IaCZuur1a/HMAu0a7Ck/TxU7MtDI72nQv2KwQ8SqmY5K/HiAKD7jzF4XE3wbSzLWmBV6qX6
	sBSg28kRs0hxr23BBZBTLJQNGbSJWtiY9QciQ7Du5FKSk6NgTPA==
X-Google-Smtp-Source: APBJJlFH2HMTcWpgEIHGrf9Hp7SUBEchBVje2Sf7hJhOlQ2k/NwoH55R1nb2gSXRyhWVvGmBVY/BNx4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:7c8a:b0:1b8:246f:de22 with SMTP id
 y10-20020a1709027c8a00b001b8246fde22mr5260849pll.8.1688758217456; Fri, 07 Jul
 2023 12:30:17 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:57 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-6-sdf@google.com>
Subject: [RFC bpf-next v3 05/14] bpf: Implement devtx timestamp kfunc
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

Two kfuncs, one per hook point:

1. at submit time - bpf_devtx_sb_request_timestamp - to request HW
   to put TX timestamp into TX completion descriptors

2. at completion time - bpf_devtx_cp_timestamp - to read out
   TX timestamp

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/netdevice.h |  4 +++
 include/net/offload.h     | 12 +++++++
 kernel/bpf/offload.c      |  6 ++++
 net/core/devtx.c          | 73 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..5be6649ea3fa 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1654,10 +1654,14 @@ struct net_device_ops {
 						  bool cycles);
 };
 
+struct devtx_ctx;
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
+	int	(*xmo_request_tx_timestamp)(const struct devtx_ctx *ctx);
+	int	(*xmo_tx_timestamp)(const struct devtx_ctx *ctx, u64 *timestamp);
 };
 
 /**
diff --git a/include/net/offload.h b/include/net/offload.h
index de0fac38a95b..7e2c19c5aaef 100644
--- a/include/net/offload.h
+++ b/include/net/offload.h
@@ -12,9 +12,21 @@
 			      bpf_xdp_metadata_rx_hash, \
 			      xmo_rx_hash)
 
+#define DEVTX_SUBMIT_KFUNC_xxx	\
+	NETDEV_METADATA_KFUNC(DEVTX_KFUNC_REQUEST_TX_TIMESTAMP, \
+			      bpf_devtx_request_tx_timestamp, \
+			      xmo_request_tx_timestamp)
+
+#define DEVTX_COMPLETE_KFUNC_xxx	\
+	NETDEV_METADATA_KFUNC(DEVTX_KFUNC_TX_TIMESTAMP, \
+			      bpf_devtx_tx_timestamp, \
+			      xmo_tx_timestamp)
+
 enum {
 #define NETDEV_METADATA_KFUNC(name, _, __) name,
 XDP_METADATA_KFUNC_xxx
+DEVTX_SUBMIT_KFUNC_xxx
+DEVTX_COMPLETE_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 MAX_NETDEV_METADATA_KFUNC,
 };
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index a4423803b3dd..fe793387c972 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -862,6 +862,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 #define NETDEV_METADATA_KFUNC(name, _, xmo) \
 	if (func_id == bpf_dev_bound_kfunc_id(name)) p = ops->xmo;
 	XDP_METADATA_KFUNC_xxx
+	DEVTX_SUBMIT_KFUNC_xxx
+	DEVTX_COMPLETE_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 
 out:
@@ -873,12 +875,16 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 BTF_SET_START(dev_bound_kfunc_ids)
 #define NETDEV_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
+DEVTX_SUBMIT_KFUNC_xxx
+DEVTX_COMPLETE_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 BTF_SET_END(dev_bound_kfunc_ids)
 
 BTF_ID_LIST(dev_bound_kfunc_ids_unsorted)
 #define NETDEV_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
+DEVTX_SUBMIT_KFUNC_xxx
+DEVTX_COMPLETE_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 
 u32 bpf_dev_bound_kfunc_id(int id)
diff --git a/net/core/devtx.c b/net/core/devtx.c
index 6ae1aecce2c5..991a52fe81a3 100644
--- a/net/core/devtx.c
+++ b/net/core/devtx.c
@@ -76,3 +76,76 @@ void devtx_hooks_unregister(struct btf_id_set8 *set)
 	mutex_unlock(&devtx_hooks_lock);
 }
 EXPORT_SYMBOL_GPL(devtx_hooks_unregister);
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/**
+ * bpf_devtx_request_tx_timestamp - Request TX timestamp on the packet.
+ * Callable only from the devtx-submit hook.
+ * @ctx: devtx context pointer.
+ *
+ * Returns 0 on success or ``-errno`` on error.
+ */
+__bpf_kfunc int bpf_devtx_request_tx_timestamp(const struct devtx_ctx *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * bpf_devtx_tx_timestamp - Read TX timestamp of the packet. Callable
+ * only from the devtx-complete hook.
+ * @ctx: devtx context pointer.
+ * @timestamp: Return value pointer.
+ *
+ * Returns 0 on success or ``-errno`` on error.
+ */
+__bpf_kfunc int bpf_devtx_tx_timestamp(const struct devtx_ctx *ctx, __u64 *timestamp)
+{
+	return -EOPNOTSUPP;
+}
+
+__diag_pop();
+
+BTF_SET8_START(devtx_sb_kfunc_ids)
+#define NETDEV_METADATA_KFUNC(_, name, __) BTF_ID_FLAGS(func, name, 0)
+DEVTX_SUBMIT_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+BTF_SET8_END(devtx_sb_kfunc_ids)
+
+static const struct btf_kfunc_id_set devtx_sb_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &devtx_sb_kfunc_ids,
+};
+
+BTF_SET8_START(devtx_cp_kfunc_ids)
+#define NETDEV_METADATA_KFUNC(_, name, __) BTF_ID_FLAGS(func, name, 0)
+DEVTX_COMPLETE_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+BTF_SET8_END(devtx_cp_kfunc_ids)
+
+static const struct btf_kfunc_id_set devtx_cp_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &devtx_cp_kfunc_ids,
+};
+
+static int __init devtx_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &devtx_sb_kfunc_set);
+	if (ret) {
+		pr_warn("failed to register devtx_sb kfuncs: %d", ret);
+		return ret;
+	}
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &devtx_cp_kfunc_set);
+	if (ret) {
+		pr_warn("failed to register devtx_cp completion kfuncs: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+late_initcall(devtx_init);
-- 
2.41.0.255.g8b1d071c50-goog


