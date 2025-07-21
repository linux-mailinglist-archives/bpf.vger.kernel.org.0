Return-Path: <bpf+bounces-63946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25587B0CC60
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF713A9E48
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD8624167C;
	Mon, 21 Jul 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anS+FaPR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096C241663;
	Mon, 21 Jul 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132811; cv=none; b=F3HKrNNfDebqom5o+tnmrzxSn3SKP3XCGrK4yxL/5FzQVPiOTJWRrftQAfWiA27ot4mdCYcBTea976GhZmIveOIsaQwonyoHooPtxSPestTUocCIUdoFSS3yDORWEq1s3ssYjHulADWdWEXtNzU6sh/d2jseJKrJGDDNrodRj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132811; c=relaxed/simple;
	bh=dIoKK7WkUFCdrG3j9BrcyKI4D/KDP7mXc5svcUfW2wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8ZuFMIjw3jQUxIxcF6VNB2ugnF36DgXKJjbG1SJvDaQzSoNXjEnsUrMCzGKgy2CqtSgYXANOwjJaBCN65OX/nYOtRiM6ZILOyDTOSljz6XF9drgf5triMnBJYSGRym95a4etLZXaFMQVTuqpPuDCDsWl8Bvvh3M7DjTxm+ZNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anS+FaPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C2BC4CEF8;
	Mon, 21 Jul 2025 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132809;
	bh=dIoKK7WkUFCdrG3j9BrcyKI4D/KDP7mXc5svcUfW2wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=anS+FaPRI5TMqAEdJO58VvZ9Dyc1w9AhgBzxOmD5WdZtyPr52oXwTRiiAaFLhYu5K
	 XadNplcWoHWO3QPTi7fu7XFRyl3zN82XZU0ap6UpZP6j1OsYPAw6XWQ7BTOQ5jAupY
	 a8ctSWMCRuGWI4+WfPUsoHvhVgzjGjjTh9bTGq+BUJVGjMhYVYNbGNIaqkaoZ20w6W
	 F2zitoXuXXtfTIIIO13z6XV65Jla6RfbXqnfL7cPHdRbaB3kPXGwvHp7UrOoTa2jC/
	 TSALIrKmQT/Z/pR1r1U396fG/OmpBhxTBY5cboIFG8xXy205gqfc0u+/BtFVYH1sbi
	 5XG5GtVZ+8Z7A==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v2 02/13] bpf: Implement exclusive map creation
Date: Mon, 21 Jul 2025 23:19:47 +0200
Message-ID: <20250721211958.1881379-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721211958.1881379-1-kpsingh@kernel.org>
References: <20250721211958.1881379-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exclusive maps allow maps to only be accessed by program with a
program with a matching hash which is specified in the excl_prog_hash
attr.

For the signing use-case, this allows the trusted loader program
to load the map and verify the integrity

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/syscall.c           | 32 ++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c          |  6 ++++++
 tools/include/uapi/linux/bpf.h |  2 ++
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 06cb73df94b3..f1b259517bd6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -311,6 +311,7 @@ struct bpf_map {
 	bool free_after_rcu_gp;
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
+	char *excl_prog_sha;
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..7873ba7b9468 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1522,6 +1522,8 @@ union bpf_attr {
 		 * If provided, map_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32	map_token_fd;
+		__u32 excl_prog_hash_size;
+		__aligned_u64 excl_prog_hash;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e63039817af3..6ebcb7e4afbb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -858,6 +858,7 @@ static void bpf_map_free(struct bpf_map *map)
 	 * the free of values or special fields allocated from bpf memory
 	 * allocator.
 	 */
+	kfree(map->excl_prog_sha);
 	migrate_disable();
 	map->ops->map_free(map);
 	migrate_enable();
@@ -1335,9 +1336,9 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
+#define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bool kernel)
+static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1527,7 +1528,30 @@ static int map_create(union bpf_attr *attr, bool kernel)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = security_bpf_map_create(map, attr, token, kernel);
+	if (attr->excl_prog_hash) {
+		bpfptr_t uprog_hash = make_bpfptr(attr->excl_prog_hash, uattr.is_kernel);
+
+		map->excl_prog_sha = kzalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
+		if (!map->excl_prog_sha) {
+			err = -ENOMEM;
+			goto free_map;
+		}
+
+		if (attr->excl_prog_hash_size != SHA256_DIGEST_SIZE) {
+			err = -EINVAL;
+			goto free_map;
+		}
+
+		if (copy_from_bpfptr(map->excl_prog_sha, uprog_hash,
+				     SHA256_DIGEST_SIZE)) {
+			err = -EFAULT;
+			goto free_map;
+		}
+	} else if (attr->excl_prog_hash_size) {
+		return -EINVAL;
+	}
+
+	err = security_bpf_map_create(map, attr, token, uattr.is_kernel);
 	if (err)
 		goto free_map_sec;
 
@@ -6001,7 +6025,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr.is_kernel);
+		err = map_create(&attr, uattr);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..e062f9672da9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20321,6 +20321,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
+	if (map->excl_prog_sha &&
+	    memcmp(map->excl_prog_sha, prog->digest, SHA256_DIGEST_SIZE)) {
+		verbose(env, "program's hash doesn't match map's excl_prog_hash\n");
+		return -EACCES;
+	}
+
 	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
 	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
 		if (is_tracing_prog_type(prog_type)) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..7873ba7b9468 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1522,6 +1522,8 @@ union bpf_attr {
 		 * If provided, map_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32	map_token_fd;
+		__u32 excl_prog_hash_size;
+		__aligned_u64 excl_prog_hash;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
-- 
2.43.0


