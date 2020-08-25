Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4A251F0C
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHYS3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 14:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHYS3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 14:29:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA07C0617A0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 11:29:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l2so11822911eji.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d10PijIPuG0Iy1sT+yUZyIWJTUgD/5/pscV7dWlrwCs=;
        b=in178nvC/wWOGVHO8LUcePDeuaHSWE0dopDVO/ffY3s8OthG82JXPlnBj8RLjdt1Qt
         0ypaEAUjtF1wbOEN9QvUyw96i7VvtuXL5DtdodzcH53cex1Xy+6YKLewuRBh0Br2RAUY
         yVst+DKxCxEzEiKsnSeVwxWCudoySEz3A6kyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d10PijIPuG0Iy1sT+yUZyIWJTUgD/5/pscV7dWlrwCs=;
        b=tml+IuzrJsF7H2iQn9X7lN0iqrui5pCcDHjKng4ljTDFRpeOhXKEG4JTf/WwSvcTQZ
         ktL8c/I2Vg1TXHoOMCnQgrB5Tt2wVFpz2wacnEV3ROmGfxk4/ry97OW/ySWNqMxqo9N9
         g3qTFAmQcoCrw9jjWs4BNzLiOrEdgzmOoVZpHn7rO5eByWgiUZ6UD+DQEdA0TjVt9ZkZ
         Xjv7diaeA/yvDp+YXptTdfKUlzN+OYqZz4o6YgdriSg5KiRPBvp7CZnIzF9Slq6Ko9mO
         ppyJse/IuUlLyZtSDlDPrgRHG1AtWpU00ZWOuU8/NpOOGrqGUyQ3I1JfafBrO86Txb57
         ZqPw==
X-Gm-Message-State: AOAM530t9KrXL0mVcERX/wZ7Mk5Mc1wrcYHVxf6TL2OZGVIY+3qqL276
        lhiEgVpBXhZ5+yff6/L5m4vC0dp6GALXMw==
X-Google-Smtp-Source: ABdhPJzpRkSaE0z8A85wKfv7Sqklv7tJuzfkaazGf1AfXeeuhe2y8k1c1zBOKZU4BiEkWGCdX+DKPw==
X-Received: by 2002:a17:906:3a81:: with SMTP id y1mr11363532ejd.464.1598380169682;
        Tue, 25 Aug 2020 11:29:29 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id dr21sm15323286ejc.112.2020.08.25.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:29:28 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v10 6/7] bpf: Allow local storage to be used from LSM programs
Date:   Tue, 25 Aug 2020 20:29:18 +0200
Message-Id: <20200825182919.1118197-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200825182919.1118197-1-kpsingh@chromium.org>
References: <20200825182919.1118197-1-kpsingh@chromium.org>
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

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/net/bpf_sk_storage.h   |  2 ++
 include/uapi/linux/bpf.h       |  7 +++++--
 kernel/bpf/bpf_lsm.c           | 21 ++++++++++++++++++++-
 net/core/bpf_sk_storage.c      | 25 +++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++--
 5 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 3c516dd07caf..119f4c9c3a9c 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -20,6 +20,8 @@ void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto sk_storage_get_btf_proto;
+extern const struct bpf_func_proto sk_storage_delete_btf_proto;
 
 struct bpf_local_storage_elem;
 struct bpf_sk_storage_diag;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b6bfcd085a76..0e1cdf806fe1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2808,7 +2808,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2824,6 +2824,9 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
+ *		*sk* is a kernel **struct sock** pointer for LSM program.
+ *		*sk* is a **struct bpf_sock** pointer for other program types.
+ *
  *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
@@ -2836,7 +2839,7 @@ union bpf_attr {
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
index f29d9a9b4ea4..55fae03b4cc3 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -12,6 +12,7 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
+#include <linux/btf_ids.h>
 
 DEFINE_BPF_STORAGE_CACHE(sk_cache);
 
@@ -377,6 +378,30 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 	.arg2_type	= ARG_PTR_TO_SOCKET,
 };
 
+BTF_ID_LIST(sk_storage_btf_ids)
+BTF_ID_UNUSED
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
+	.btf_id		= sk_storage_btf_ids,
+};
+
+const struct bpf_func_proto sk_storage_delete_btf_proto = {
+	.func		= bpf_sk_storage_delete,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.btf_id		= sk_storage_btf_ids,
+};
+
 struct bpf_sk_storage_diag {
 	u32 nr_maps;
 	struct bpf_map *maps[];
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b6bfcd085a76..0e1cdf806fe1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2808,7 +2808,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2824,6 +2824,9 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
+ *		*sk* is a kernel **struct sock** pointer for LSM program.
+ *		*sk* is a **struct bpf_sock** pointer for other program types.
+ *
  *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
@@ -2836,7 +2839,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
-- 
2.28.0.297.g1956fa8f8d-goog

