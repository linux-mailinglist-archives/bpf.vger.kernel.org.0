Return-Path: <bpf+bounces-4477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21F74B71B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AEE1C21083
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95DD17AA6;
	Fri,  7 Jul 2023 19:30:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04917AA1
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:30 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C72D53
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-262ffe98bcfso2806695a91.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758212; x=1691350212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MKED6r0fOSDG2OitoAAOgEtvC/DPkEhJBtkp+m4JxY=;
        b=xruGGNlMKaVcqxRIP0wIULlOAxnVjAZI1dldXXdPF4RQYpP+OtG/qxFIq+hfCLkgx9
         f3rNt1m3aqdWctECAanKbXLh/gxXD3PBXHh/Ki8XZrUaf9oEQiab8yBP2cB+QBy+NbcX
         1ZodPiFfIjJF4LfWnch92WxDZcQlAs/cJSYCiRHv8viZLc8bnHX0eK0j5nOf8TnjtQR5
         gAFmrCgWL89X3C5Oj5t5V8FjeinImPCxlKVfFUXmCXzaWLC/D0c2SbjgF6EvOXix9EGV
         Rr17sSwVPKuXHFVgqGLnRfj+FjGhLuPrm9aaWgS2aPPprsiGWO5Lpfshf6S6d1ybkU5i
         XJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758212; x=1691350212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MKED6r0fOSDG2OitoAAOgEtvC/DPkEhJBtkp+m4JxY=;
        b=Vm7liE+J1jm3DfCa0JJDJlEpYq3wYMHbzYev6ZUrrDXUyvwjH4o4WbZhv/dlBcViRo
         1lVq1QzF8EidyXF25hK53WkUabqOkh0ZNWASZbhJtWv7d6gjNETXUnKI7WNrvezNG/5J
         oE6ylP/gdJHg+807ho5aByncRj2hy6ww+4ZfV6YCdmDwEY59j80XoyKBMLeB15eouH9m
         JwmcSmOtsbAskYzJN89FZJmF6yY7cuk7OLaCIxT5i61VPspzmFc2otzmIcWu+0XQYsBX
         keFeYrio6n88JnPghKcsss78+XvDPqp1QC9upmhSse5GtFhl56Htd5gVCGLmM8KZ3Ak7
         0UNQ==
X-Gm-Message-State: ABy/qLamzu+9cFMWYM0SSQrbVOFJ8Y1tIMu3cN4Kx1QZ38SZVH+NlIO7
	2hWqEcbWyA7WZX1e/5T20hFX4XRhTAwzAgo9eefXKFvOvDXs6ZwIOdvPEzfsrH48npFVrXITPKQ
	nvquHhHt9ocGd5l7bbzjIqdcoRJr7ErvS38R22Q1zmNhUFOr/pg==
X-Google-Smtp-Source: APBJJlGIZBvJPkKFv/Q5I+xIa3tblE8GIDGj+rcewIcapBo9qV5OybfQAFp23jqwnP4fXgxyIaOajVk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:f481:b0:263:4dca:ae63 with SMTP id
 bx1-20020a17090af48100b002634dcaae63mr4830732pjb.6.1688758211652; Fri, 07 Jul
 2023 12:30:11 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:54 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-3-sdf@google.com>
Subject: [RFC bpf-next v3 02/14] bpf: Make it easier to add new metadata kfunc
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

Instead of having hand-crafted code in bpf_dev_bound_resolve_kfunc,
move kfunc <> xmo handler relationship into XDP_METADATA_KFUNC_xxx.
This way, any time new kfunc is added, we don't have to touch
bpf_dev_bound_resolve_kfunc.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/offload.h |  8 +++++---
 kernel/bpf/offload.c  | 13 +++++++------
 net/core/xdp.c        |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/net/offload.h b/include/net/offload.h
index 264a35881473..de0fac38a95b 100644
--- a/include/net/offload.h
+++ b/include/net/offload.h
@@ -6,12 +6,14 @@
 
 #define XDP_METADATA_KFUNC_xxx	\
 	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
-			      bpf_xdp_metadata_rx_timestamp) \
+			      bpf_xdp_metadata_rx_timestamp, \
+			      xmo_rx_timestamp) \
 	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
-			      bpf_xdp_metadata_rx_hash)
+			      bpf_xdp_metadata_rx_hash, \
+			      xmo_rx_hash)
 
 enum {
-#define NETDEV_METADATA_KFUNC(name, _) name,
+#define NETDEV_METADATA_KFUNC(name, _, __) name,
 XDP_METADATA_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 MAX_NETDEV_METADATA_KFUNC,
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 235d81f7e0ed..cec63c76dce5 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -844,10 +844,11 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	if (!ops)
 		goto out;
 
-	if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
-		p = ops->xmo_rx_timestamp;
-	else if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
-		p = ops->xmo_rx_hash;
+#define NETDEV_METADATA_KFUNC(name, _, xmo) \
+	if (func_id == bpf_dev_bound_kfunc_id(name)) p = ops->xmo;
+	XDP_METADATA_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+
 out:
 	up_read(&bpf_devs_lock);
 
@@ -855,13 +856,13 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 }
 
 BTF_SET_START(dev_bound_kfunc_ids)
-#define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
+#define NETDEV_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 BTF_SET_END(dev_bound_kfunc_ids)
 
 BTF_ID_LIST(dev_bound_kfunc_ids_unsorted)
-#define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
+#define NETDEV_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 819767697370..c4be4367f2dd 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-#define NETDEV_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
+#define NETDEV_METADATA_KFUNC(_, name, __) BTF_ID_FLAGS(func, name, 0)
 XDP_METADATA_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 BTF_SET8_END(xdp_metadata_kfunc_ids)
-- 
2.41.0.255.g8b1d071c50-goog


