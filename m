Return-Path: <bpf+bounces-3052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F498738C9D
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE6E28171B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FDF1ACA3;
	Wed, 21 Jun 2023 17:02:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181D19E6B
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:02:57 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539B110D
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-65026629c1eso2880660b3a.0
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366976; x=1689958976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=feixGtICBDKSGOY8r1mfjPfsz/6VV1h1omDCXVYez4I=;
        b=ny/L+aW+10oezDk6bM0bGp76eorWQRHnGyYJZANTy21DBw1rgYeQQ+1m4bkt990Ikg
         REx5PzHEFFOaMZRiRnVD3nGjvh0jNBm/DJ5wTPqcgxNBDA8fbKd0r08wxchNjWXstgVV
         4JwGIaUtnDvrhH2yzLCSA/00nRa/Rfx51XtK/y9Xi0O0ZO9hzUwSsFfV+bTvOsGE5h9W
         E/fYMlIg9SCa33bvv2RViEoBC4FbHHTHcVu+OSBV88zbOR+d1RHKgZLomMR7N++8E8s4
         QiavWPt1pwCx+PzTfcL81y+xDdXadA9EpBnhE2+Veab5V0SGo5I2ZETY2MdthpUJFnau
         oPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366976; x=1689958976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feixGtICBDKSGOY8r1mfjPfsz/6VV1h1omDCXVYez4I=;
        b=Xavb0GMgtZoel1AtfUAM0GKxuT7R2jHVgUGu/z7DiHfTCsaSJSOYNWrZ32VUWB7yAw
         xdVRAEdEp2oaq3uXxQ/8ATa+AY26/ABiMwkEKSkVmewnqaJ/1PHABnGnPG9W3dyTaOII
         dOq0oms5WZg78Z3FeXwc6gs+S40RQY2WsU7DLJrb+eAB7D9IaBJEk74ITDfkc4k8oW72
         2NW+E39Uq0tkc19G+JSOtpQu1Yu3w4P2KK77Ksz4Abs5Xq0p19sX3LI7oxMv9yKA7+up
         bEhsv23GxOmOUdy1Rj541+TwcUpITcSIILKDISDS9QdTVVtf7N/6LdHETGQeUb+D81AN
         8ThA==
X-Gm-Message-State: AC+VfDyg2EztVownivgIavh3ySg8Wy4w2lOkuP6hIvHYChjxldzV/47X
	0Yp4ggTSDB+82mNB/IkF38VZfXTrctCzQ7WvKvEquYVtDz0CA31OeruwgtcH0Y6IfGav2SrfhfJ
	KO4LDycMFDxc/rDnUbC18AE3bviE/mZf7sA+Zt0FP5G7fH8U4mg==
X-Google-Smtp-Source: ACHHUZ6ISDHeZVa+4R7W5zMDkFKy97bcfl3K0mzhnyE5pRgRBS/MYd4Bk0izNG84FFWKoP1YUaMWXWQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:9a3:b0:668:7ad6:81f2 with SMTP id
 u35-20020a056a0009a300b006687ad681f2mr2572942pfg.4.1687366975783; Wed, 21 Jun
 2023 10:02:55 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:38 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-6-sdf@google.com>
Subject: [RFC bpf-next v2 05/11] bpf: Implement devtx timestamp kfunc
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
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

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/netdevice.h |  4 +++
 include/net/offload.h     | 10 ++++++
 kernel/bpf/offload.c      |  8 +++++
 net/core/devtx.c          | 73 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 08fbd4622ccf..2fdb0731eb67 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1651,10 +1651,14 @@ struct net_device_ops {
 						  bool cycles);
 };
 
+struct devtx_frame;
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
+	int	(*xmo_sb_request_timestamp)(const struct devtx_frame *ctx);
+	int	(*xmo_cp_timestamp)(const struct devtx_frame *ctx, u64 *timestamp);
 };
 
 /**
diff --git a/include/net/offload.h b/include/net/offload.h
index 264a35881473..36899b64f4c8 100644
--- a/include/net/offload.h
+++ b/include/net/offload.h
@@ -10,9 +10,19 @@
 	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
 			      bpf_xdp_metadata_rx_hash)
 
+#define DEVTX_SB_KFUNC_xxx	\
+	NETDEV_METADATA_KFUNC(DEVTX_SB_KFUNC_REQUEST_TIMESTAMP, \
+			      bpf_devtx_sb_request_timestamp)
+
+#define DEVTX_CP_KFUNC_xxx	\
+	NETDEV_METADATA_KFUNC(DEVTX_CP_KFUNC_TIMESTAMP, \
+			      bpf_devtx_cp_timestamp)
+
 enum {
 #define NETDEV_METADATA_KFUNC(name, _) name,
 XDP_METADATA_KFUNC_xxx
+DEVTX_SB_KFUNC_xxx
+DEVTX_CP_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 MAX_NETDEV_METADATA_KFUNC,
 };
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index f01a1aa0f627..45a243af49be 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -863,6 +863,10 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 		p = ops->xmo_rx_timestamp;
 	else if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
 		p = ops->xmo_rx_hash;
+	else if (func_id == bpf_dev_bound_kfunc_id(DEVTX_SB_KFUNC_REQUEST_TIMESTAMP))
+		p = ops->xmo_sb_request_timestamp;
+	else if (func_id == bpf_dev_bound_kfunc_id(DEVTX_CP_KFUNC_TIMESTAMP))
+		p = ops->xmo_cp_timestamp;
 out:
 	up_read(&bpf_devs_lock);
 
@@ -872,12 +876,16 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 BTF_SET_START(dev_bound_kfunc_ids)
 #define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
+DEVTX_SB_KFUNC_xxx
+DEVTX_CP_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 BTF_SET_END(dev_bound_kfunc_ids)
 
 BTF_ID_LIST(dev_bound_kfunc_ids_unsorted)
 #define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
+DEVTX_SB_KFUNC_xxx
+DEVTX_CP_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 
 u32 bpf_dev_bound_kfunc_id(int id)
diff --git a/net/core/devtx.c b/net/core/devtx.c
index bad694439ae3..4267a8fe6711 100644
--- a/net/core/devtx.c
+++ b/net/core/devtx.c
@@ -74,3 +74,76 @@ void devtx_hooks_unregister(struct btf_id_set8 *set)
 	}
 	mutex_unlock(&devtx_hooks_lock);
 }
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/**
+ * bpf_devtx_sb_request_timestamp - Request TX timestamp on the packet.
+ * Callable only from the devtx-submit hook.
+ * @ctx: devtx context pointer.
+ *
+ * Returns 0 on success or ``-errno`` on error.
+ */
+__bpf_kfunc int bpf_devtx_sb_request_timestamp(const struct devtx_frame *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * bpf_devtx_cp_timestamp - Read TX timestamp of the packet. Callable
+ * only from the devtx-complete hook.
+ * @ctx: devtx context pointer.
+ * @timestamp: Return value pointer.
+ *
+ * Returns 0 on success or ``-errno`` on error.
+ */
+__bpf_kfunc int bpf_devtx_cp_timestamp(const struct devtx_frame *ctx, __u64 *timestamp)
+{
+	return -EOPNOTSUPP;
+}
+
+__diag_pop();
+
+BTF_SET8_START(devtx_sb_kfunc_ids)
+#define NETDEV_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
+DEVTX_SB_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+BTF_SET8_END(devtx_sb_kfunc_ids)
+
+static const struct btf_kfunc_id_set devtx_sb_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &devtx_sb_kfunc_ids,
+};
+
+BTF_SET8_START(devtx_cp_kfunc_ids)
+#define NETDEV_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
+DEVTX_CP_KFUNC_xxx
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
2.41.0.162.gfafddb0af9-goog


