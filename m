Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A0229E38
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 19:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbgGVROl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 13:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731815AbgGVROX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 13:14:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737ABC08C5C0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 10:14:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so2722456wmo.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gp0OnWT+ezEb5kvY+8ZpcjBj/ySeUlAdu5kTWrUzIIE=;
        b=J6GjZ5OPG6ow57yZ7rrXnV1PgY01FRLTvi7AIfZmZmeq44ow4JFWTnBY0MI90eUVlG
         z1PSexB/fvV7txKRO5ti2t7tZt/sJaDWNRsRxBiQsoNwMVRpSx+V1FxegH5rWlsyxCji
         gh6UiSw5785r3iAoNQMZ+zEqwBK9Wyp+WyCJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gp0OnWT+ezEb5kvY+8ZpcjBj/ySeUlAdu5kTWrUzIIE=;
        b=G0EYcnAAsubtgnXq7MZu3/srBvLgj+FyLu0NGb9yRrLWjs3pbsY0o0NYt4ciI93Ssh
         6WJfA6gmF3jfmxz1OnDjMzXJ30w2YhkXOinYkDaahXVYFN2OTEdLf+amUvIVOAFDrnjD
         Ui1U9vL5dEf12x7YK7qq7abdURM8r2sKE0QVZEBUfpcLm+PC/u6eZUJASVjkdKLj07Hk
         djYMjYVySw3BG5qVcBx9xXE8qOWj9At2E6ttpjm5VisOrCYDnZdAzhrkmunstPFfT7ul
         XB9rXPOwBkyB5BaYXLDUo2cGu5Fb+pgRsghd+mBbI5Brglhnp18cGqJOk06e5unuaz5k
         BS8A==
X-Gm-Message-State: AOAM531zVeZmZJsRK1AQQaZM7esJ+R0poO2t5JrMjJDUFffabRhihsKY
        NlcAouw1zrsR7+JmGTfOgBwAgA==
X-Google-Smtp-Source: ABdhPJwCCXk9vaVuSY9tqLlBmznmzV2x0tC36L55ROdQS66E6XrJS66s/KAIr41aF/0pYaaqSU8YKw==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr600477wmj.160.1595438060818;
        Wed, 22 Jul 2020 10:14:20 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id 26sm349214wmj.25.2020.07.22.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:14:20 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 6/7] bpf: Allow local storage to be used from LSM programs
Date:   Wed, 22 Jul 2020 19:14:08 +0200
Message-Id: <20200722171409.102949-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200722171409.102949-1-kpsingh@chromium.org>
References: <20200722171409.102949-1-kpsingh@chromium.org>
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
 include/uapi/linux/bpf.h       |  8 ++++++--
 kernel/bpf/bpf_lsm.c           | 21 ++++++++++++++++++++-
 net/core/bpf_sk_storage.c      | 27 +++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 ++++++--
 5 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 4cdf37ac278c..d123807b5083 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -19,6 +19,8 @@ void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto sk_storage_get_btf_proto;
+extern const struct bpf_func_proto sk_storage_delete_btf_proto;
 
 struct bpf_sk_storage_diag;
 struct sk_buff;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0bdfbe6067be..5be19f93b159 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2790,7 +2790,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2806,6 +2806,10 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
+ *		For socket programs, *sk* should be a **struct bpf_sock** pointer
+ *		and an **ARG_PTR_TO_BTF_ID** of type **struct sock** for LSM
+ *		programs.
+ *
  *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
@@ -2818,7 +2822,7 @@ union bpf_attr {
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
index be0ed44d0887..17efb8a9196d 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -11,6 +11,7 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
+#include <linux/btf_ids.h>
 
 DEFINE_BPF_STORAGE_CACHE(sk_cache);
 
@@ -465,6 +466,32 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 	.arg2_type	= ARG_PTR_TO_SOCKET,
 };
 
+BTF_ID_LIST(sk_storage_get_btf_ids)
+BTF_ID(struct, sock)
+
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
+BTF_ID_LIST(sk_storage_delete_btf_ids)
+BTF_ID(struct, sock)
+
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
index 0bdfbe6067be..5be19f93b159 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2790,7 +2790,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2806,6 +2806,10 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
+ *		For socket programs, *sk* should be a **struct bpf_sock** pointer
+ *		and an **ARG_PTR_TO_BTF_ID** of type **struct sock** for LSM
+ *		programs.
+ *
  *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
@@ -2818,7 +2822,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
-- 
2.28.0.rc0.105.gf9edc3c819-goog

