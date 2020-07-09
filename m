Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7D21956B
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGIA5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 20:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgGIA5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 20:57:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A10C03541F
        for <bpf@vger.kernel.org>; Wed,  8 Jul 2020 17:57:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so5071245wmc.1
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2020 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6LDMWBimly/S6HLQdr62HUq5FOYHBE4+UIvjiG4swM=;
        b=fKxXjjJmt7Tja0v5f2skLPMiQiomHlm0rzdDapCsFItn+qurOuzlwlpPwi7Wv/7Bgq
         TSrPwFz+IHJGaJV9KOv6pC33zWJ2IL+IqbRtbW3y5I26j748i/QhILTk/R3r7llYWJq+
         wyx+Yp79PHMVoxw24nZr0hy/ziiCvUIuokIL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6LDMWBimly/S6HLQdr62HUq5FOYHBE4+UIvjiG4swM=;
        b=rOk3hQgr1fXxeMXkKH4OQ+IB+TtROSrYSDfJNhqU96Df6jBK8BFaJjrsCEybONQdhQ
         EUjeDxp1Q08X778uoNuSYUG2F54QPUPeg1Lx5wc+7PNdCccbgVsKgPZb9VQvKZjhSxMv
         pT1Bzl9BziPe8IXdN7V5LVvjQaBZAcu7yPgefy25KFwX8M4tOc68DfBPrt/TXXDpjGSX
         nGRTe2hgaRCsR5/9kSzzfNhformdAzovhGN3skIQhySHc7BDymhXexhpP2pQ1XHnH8Z+
         L0hYB6lLzQxtJBDdHFGEEKdcafFeMWuLeJj1d3osS9x4lgQRifPKx5toqnG2TvQ8Bdmp
         Rgsg==
X-Gm-Message-State: AOAM531Lz557lKEoD9ZHxZkc8GkFyrcvNYkAatKtGwYV9CMG7AeTXO9P
        70xMNWobIM4vJPGL+iifthUllvbtpkQ=
X-Google-Smtp-Source: ABdhPJymvSt3aawLOrI0rKXLQ7Qv7Yu5qd9/qTrjdfn7ORQsQ6UjgWYPtndARnoulfP6qegsRR2M7w==
X-Received: by 2002:a1c:e908:: with SMTP id q8mr12387914wmc.59.1594256220345;
        Wed, 08 Jul 2020 17:57:00 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id f15sm2465498wrx.91.2020.07.08.17.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 17:56:59 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 3/4] bpf: Allow local storage to be used from LSM programs
Date:   Thu,  9 Jul 2020 02:56:53 +0200
Message-Id: <20200709005654.3324272-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
In-Reply-To: <20200709005654.3324272-1-kpsingh@chromium.org>
References: <20200709005654.3324272-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Adds support for both bpf_{sk, inode}_storage_{get, delete} to be used
in LSM programs. These helpers are not used for tracing programs
(currently) as their usage is tied to the life-cycle of the object and
should only be used where the owning object won't be freed (when the
owning object is passed as an argument to the LSM hook). Thus, they
are safer to use in LSM hooks than tracing. Usage of local storage in
tracing programs will probably follow a per function based whitelist
approach.

Since the UAPI helper signature for bpf_sk_storage expect a bpf_sock,
it, leads to a compilation warning for LSM programs, it's also updated
to accept a void * pointer instead.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/net/bpf_sk_storage.h   |  2 ++
 include/uapi/linux/bpf.h       |  4 ++--
 kernel/bpf/bpf_lsm.c           | 21 ++++++++++++++++++++-
 net/core/bpf_sk_storage.c      | 22 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++--
 5 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 5036c94c0503..d231da1b57ca 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -9,6 +9,8 @@ void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto sk_storage_get_btf_proto;
+extern const struct bpf_func_proto sk_storage_delete_btf_proto;
 
 struct bpf_sk_storage_diag;
 struct sk_buff;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 42fc442f4586..3d2859ccc7ae 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2787,7 +2787,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2815,7 +2815,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index fb278144e9fd..9cd1428c7199 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -11,6 +11,8 @@
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
 #include <linux/bpf_verifier.h>
+#include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -45,10 +47,27 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 	return 0;
 }
 
+static const struct bpf_func_proto *
+bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_inode_storage_get:
+		return &bpf_inode_storage_get_proto;
+	case BPF_FUNC_inode_storage_delete:
+		return &bpf_inode_storage_delete_proto;
+	case BPF_FUNC_sk_storage_get:
+		return &sk_storage_get_btf_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &sk_storage_delete_btf_proto;
+	default:
+		return tracing_prog_func_proto(func_id, prog);
+	}
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
 const struct bpf_verifier_ops lsm_verifier_ops = {
-	.get_func_proto = tracing_prog_func_proto,
+	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 62b6526acf7e..add0340e9ad3 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -455,6 +455,28 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 	.arg2_type	= ARG_PTR_TO_SOCKET,
 };
 
+static int sk_storage_get_btf_ids[4];
+const struct bpf_func_proto sk_storage_get_btf_proto = {
+	.func		= bpf_sk_storage_get,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	= ARG_ANYTHING,
+	.btf_id		= sk_storage_get_btf_ids,
+};
+
+static int sk_storage_delete_btf_ids[2];
+const struct bpf_func_proto sk_storage_delete_btf_proto = {
+	.func		= bpf_sk_storage_delete,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.btf_id		= sk_storage_delete_btf_ids,
+};
+
 struct bpf_sk_storage_diag {
 	u32 nr_maps;
 	struct bpf_map *maps[];
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 42fc442f4586..3d2859ccc7ae 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2787,7 +2787,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2815,7 +2815,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
-- 
2.27.0.389.gc38d7665816-goog

