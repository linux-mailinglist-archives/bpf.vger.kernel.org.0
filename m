Return-Path: <bpf+bounces-9566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAB79928F
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0797B1C20E32
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367A7479;
	Fri,  8 Sep 2023 22:58:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD97472
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 22:58:13 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5946C1FED
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 15:58:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e1154756so28651157b3.2
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694213891; x=1694818691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/AfsWqTsY33pj6en+LuS4ONjftbdwS42oVsfuILkVY=;
        b=erqVLWXuveiH69YMmc0+Soj+KnzXjg4TCdltw+X6bVgM86GoSZqkQWCvN8Diydqb3G
         VAtKO4/lc8LfZKJ72wdvLVkBZWWgsHF4jArdpWcqvT0QMcm3vNbrYqqU8je96cW0dxD9
         RhbVg3P/HTgjsx6354YOOUobGQj+xjUCTM5fpxn2vRwvhPMnTxqZQherpDOJQunw9+QN
         5wjX98lVXuf0EjhjE8YlrMg76d7Q9AiqKGRGnkZDlhqvI9Q9xr5vbax4DGUvxEWX/ZRb
         LtHWtNzhtIvVDXjEqn6Bi+mw2V9lPIN6StCoqkIkXJIbgIlq1pwmf14kwmTw7q2vHPZ6
         0qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213891; x=1694818691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/AfsWqTsY33pj6en+LuS4ONjftbdwS42oVsfuILkVY=;
        b=rWnWiZKFN3R2WxN+YfXCEDGyZva40X3NGS92S1qADYsfG/JkM5LfIDXY9Gay8IdQqu
         Oy8KKL0jfcn0FTUzwIpe1YtwcTiCtn5WshQus+FG3YHfmiKl0suk5K9fzyeDdB1Zwt1T
         oOwuAF4GvS1tKpldpgKc6nS/Qr7NKMgCoIJnEvRPYI1i7rCApnCBe/m3aQVJnEpae3Wk
         64u7Xpc/cmSi5ckjY5f8BIrFdwX68ZaMepFB0+rB2/jgd4FSmPyoIRqVHFFcr0IlssLc
         YgYtqKHhXl2qcDNmfWIZimmJi/ITDyUjVd0ujJYubamDMHPEZ0wY3has8NsHQFlPzqa3
         14LA==
X-Gm-Message-State: AOJu0YylV1149abb5QKoUFSz+6+6JqvC3REkFXZkFW1FoVlOzdQXATmx
	AJf2Oyg/JFjicZAhGsRF3Dg+QRiOPqilfN95Pt1sBcaq66oeN/PkvC303XjZ+bsfWdhvdWfN0JE
	76jFpE4o1o9CaWMc6UpkW91YnAb6fKoXJF21Up1D/fxcFcj+idg==
X-Google-Smtp-Source: AGHT+IFjX8JEC8XEveMpC8MYE49/Aul0kPR9Anr1gzBFnau2FsPE2dM2D68XwCvM0958Aqy/ISyUJnw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ca0b:0:b0:58c:9fda:d043 with SMTP id
 p11-20020a81ca0b000000b0058c9fdad043mr99015ywi.10.1694213891119; Fri, 08 Sep
 2023 15:58:11 -0700 (PDT)
Date: Fri,  8 Sep 2023 15:58:05 -0700
In-Reply-To: <20230908225807.1780455-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908225807.1780455-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908225807.1780455-2-sdf@google.com>
Subject: [PATCH bpf-next 1/3] bpf: make it easier to add new metadata kfunc
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

No functional changes.

Instead of having hand-crafted code in bpf_dev_bound_resolve_kfunc,
move kfunc <> xmo handler relationship into XDP_METADATA_KFUNC_xxx.
This way, any time new kfunc is added, we don't have to touch
bpf_dev_bound_resolve_kfunc.

Also document XDP_METADATA_KFUNC_xxx arguments since we now have
more than two and it might be confusing what is what.

Cc: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp.h    | 16 ++++++++++++----
 kernel/bpf/offload.c |  9 +++++----
 net/core/xdp.c       |  4 ++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index de08c8e0d134..d59e12f8f311 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -383,14 +383,22 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 
 #define DEV_MAP_BULK_SIZE XDP_BULK_QUEUE_SIZE
 
+/* Define the relationship between xdp-rx-metadata kfunc and
+ * various other entities:
+ * - xdp_rx_metadata enum
+ * - kfunc name
+ * - xdp_metadata_ops field
+ */
 #define XDP_METADATA_KFUNC_xxx	\
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
-			   bpf_xdp_metadata_rx_timestamp) \
+			   bpf_xdp_metadata_rx_timestamp, \
+			   xmo_rx_timestamp) \
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
-			   bpf_xdp_metadata_rx_hash) \
+			   bpf_xdp_metadata_rx_hash, \
+			   xmo_rx_hash) \
 
-enum {
-#define XDP_METADATA_KFUNC(name, _) name,
+enum xdp_rx_metadata {
+#define XDP_METADATA_KFUNC(name, _, __) name,
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 MAX_XDP_METADATA_KFUNC,
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 3e4f2ec1af06..6aa6de8d715d 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -845,10 +845,11 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	if (!ops)
 		goto out;
 
-	if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
-		p = ops->xmo_rx_timestamp;
-	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
-		p = ops->xmo_rx_hash;
+#define XDP_METADATA_KFUNC(name, _, xmo) \
+	if (func_id == bpf_xdp_metadata_kfunc_id(name)) p = ops->xmo;
+	XDP_METADATA_KFUNC_xxx
+#undef XDP_METADATA_KFUNC
+
 out:
 	up_read(&bpf_devs_lock);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a70670fe9a2d..bab563b2f812 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
+#define XDP_METADATA_KFUNC(_, name, __) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 BTF_SET8_END(xdp_metadata_kfunc_ids)
@@ -752,7 +752,7 @@ static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
 };
 
 BTF_ID_LIST(xdp_metadata_kfunc_ids_unsorted)
-#define XDP_METADATA_KFUNC(name, str) BTF_ID(func, str)
+#define XDP_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 
-- 
2.42.0.283.g2d96d420d3-goog


