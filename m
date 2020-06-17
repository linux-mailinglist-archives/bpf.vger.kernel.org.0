Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034BA1FD614
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 22:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFQU3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgFQU3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 16:29:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71967C0613F0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:29:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so3120734wme.3
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ap3xo3wk7ngmLhz5XWEnW0IF0vRvINTquEf3Jswtafk=;
        b=AquIAq5nNA/hYZnZ3GsMW+/mJbzUKY9SzGYeAJrrFUIVpzJz1frhdE5JviNQXJdCPS
         NL7Upk9JbEHu0JmP5Qi9kSuIhpuU4jG9zsddrIZRFKhknmvRjv69jEGd21EAp2gPK20S
         1rJ8WEE5L4McKyJOsUGzt1HGdt8/GpmM1OWCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ap3xo3wk7ngmLhz5XWEnW0IF0vRvINTquEf3Jswtafk=;
        b=gmwrWEbvJUgsScgeJDsTDF6nsUd7JnaLqmCcCk/cTYOJD7wiZzhtmK/p+YiWO1nDc7
         XGmrxxkWZdAVs+pxt8ruh7FxexA5koQOskT6xXm67VZJB+M79Hxfa0yXIogMBk1oxgSF
         7Cv0l5Nlt3gl5N5aKXZH3oZmpil8+J9eEndNZAXZhLarJjvTWMGGJJVcH0JTCoPdByye
         lBqRfU5r+KLTVdRbaumF/9BW8rb/q2d6dGdcxU17Jbq6bchsZw9HLzObMQMw3yAOhFTs
         8bx+1mP7sHv1NoPfE4Fpeo081mQzmIeOmNovudi7PX9lNoxN2Pki5r6nyJxKqVk6AKHb
         V4xw==
X-Gm-Message-State: AOAM532dwMpD2BpXcgbaewDpx79WOGodFkoUbcNP3LaxfLfCbvDIfGjb
        jNp21HRSMLv2fikDzelwgt/nMiB/qfI=
X-Google-Smtp-Source: ABdhPJyUdSDwhXpkqwu1uaBYYrlvkyUN4ejqH0LH9wuS++eyfOOnkkPgJP0kJh108YmSpY7afCqm8A==
X-Received: by 2002:a05:600c:28e:: with SMTP id 14mr422286wmk.167.1592425789841;
        Wed, 17 Jun 2020 13:29:49 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id o10sm812845wrq.40.2020.06.17.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:29:49 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: [PATCH bpf-next v2 3/4] bpf: Allow local storage to be used from LSM programs
Date:   Wed, 17 Jun 2020 22:29:40 +0200
Message-Id: <20200617202941.3034-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200617202941.3034-1-kpsingh@chromium.org>
References: <20200617202941.3034-1-kpsingh@chromium.org>
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
 include/linux/bpf_local_storage.h |  2 ++
 include/uapi/linux/bpf.h          |  4 ++--
 kernel/bpf/bpf_local_storage.c    | 22 ++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c              | 20 +++++++++++++++++++-
 tools/include/uapi/linux/bpf.h    |  4 ++--
 5 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 7488487b1099..cf43ed0b6c3b 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -10,6 +10,8 @@ void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto sk_storage_get_btf_proto;
+extern const struct bpf_func_proto sk_storage_delete_btf_proto;
 extern const struct bpf_func_proto bpf_inode_storage_get_proto;
 extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 679a50562e72..6867e24f8c77 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2783,7 +2783,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2811,7 +2811,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * int bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * int bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 572ed711c3fd..c944fc0cc81d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -1276,6 +1276,28 @@ const struct bpf_func_proto bpf_inode_storage_delete_proto = {
 	.btf_id		= bpf_inode_storage_delete_btf_ids,
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
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index fb278144e9fd..e97dbbf56285 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -11,6 +11,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
 #include <linux/bpf_verifier.h>
+#include <linux/bpf_local_storage.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -45,10 +46,27 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 679a50562e72..6867e24f8c77 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2783,7 +2783,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2811,7 +2811,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * int bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * int bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
-- 
2.27.0.111.gc72c7da667-goog

