Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4865223AAD3
	for <lists+bpf@lfdr.de>; Mon,  3 Aug 2020 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHCQr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHCQrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 12:47:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747BEC061756
        for <bpf@vger.kernel.org>; Mon,  3 Aug 2020 09:47:07 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o23so11894722ejr.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2020 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xw+YeVAkYYzHLwuyjncDi0ZmQIzf4pVy1RZau8ySYdE=;
        b=GaxLyit+mDeSrNp1Njie1wUzBMpJ2eDFZlW3ITHpLu4mhJt7sItvgqdwMDeD/sBGwr
         3YvASXGV14CYPld/x3F+1eN1iXGgZlrPv+2ni0K5u6T2YiCkMUReYi8+vrU7k23Lvr0N
         7cAB2v9WapQcutD0YvmW/ddG2wL8XdprUCps4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xw+YeVAkYYzHLwuyjncDi0ZmQIzf4pVy1RZau8ySYdE=;
        b=Qb6r4E1qyqX6HhyrBYXBlQfrEfxDubWcjErz+isG4F/JysBUPI+rtdAx61B8h8TH6p
         O2kuEjE4E4mh8R9Fcydp7k6HAidKUz0RIGOm+GiZjybXc1YFZpMI7LlrZYIRPm6gth2Q
         B8R0xBfFpnhZ5HupaHkQqhPAX4Tl0YmdzO4IikRGyzIMxcxqo+5c6gB5Uvyz3/upHaU/
         dBCFhYHJWY7qEcYOyyrFrolBBcodoOmArIiQQqWC4aO66VQVbIcSifr5RO1mN6DzYcZ6
         C9mzPS1OnIifLt7SA5cZcCg+G+ay7hpmAZniZgMavLPBf0AYDmjxvoFQyOx9kehG9jVd
         6zdg==
X-Gm-Message-State: AOAM531LcC4C2qxvAz6bFJVznd49DlvXScHh4Xolc0UTjy42Pq6Y4cH2
        fT+Eo7FbLMGYbffDXrJ8oAEaKA==
X-Google-Smtp-Source: ABdhPJw7AFd9FAu1C0ULUq6HwYjdzU+5Af19gf8T5SPrMhpuJ/a/yNun3gfXs3TqBqqytZyCJ0Zfiw==
X-Received: by 2002:a17:906:3ec7:: with SMTP id d7mr18577179ejj.9.1596473226027;
        Mon, 03 Aug 2020 09:47:06 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id j7sm16385654ejb.64.2020.08.03.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:47:05 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v8 6/7] bpf: Allow local storage to be used from LSM programs
Date:   Mon,  3 Aug 2020 18:46:54 +0200
Message-Id: <20200803164655.1924498-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803164655.1924498-1-kpsingh@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
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
 net/core/bpf_sk_storage.c      | 25 +++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 ++++++--
 5 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 847926cf2899..c5702d7baeaa 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -20,6 +20,8 @@ void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto sk_storage_get_btf_proto;
+extern const struct bpf_func_proto sk_storage_delete_btf_proto;
 
 struct bpf_sk_storage_diag;
 struct sk_buff;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e17c00eea5d8..6ffc61dafc5c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2807,7 +2807,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2823,6 +2823,10 @@ union bpf_attr {
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
@@ -2835,7 +2839,7 @@ union bpf_attr {
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
index 8f6a8d6549be..43d7e5fa918e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -12,6 +12,7 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
+#include <linux/btf_ids.h>
 
 DEFINE_BPF_STORAGE_CACHE(sk_cache);
 
@@ -374,6 +375,30 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
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
index e17c00eea5d8..6ffc61dafc5c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2807,7 +2807,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2823,6 +2823,10 @@ union bpf_attr {
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
@@ -2835,7 +2839,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
-- 
2.28.0.163.g6104cc2f0b6-goog

