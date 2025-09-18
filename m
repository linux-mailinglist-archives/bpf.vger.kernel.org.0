Return-Path: <bpf+bounces-68347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD4B56CA8
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 23:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9ED916FE55
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FCF2E719C;
	Sun, 14 Sep 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN6vhxwM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA821D7E4A;
	Sun, 14 Sep 2025 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886718; cv=none; b=I7pi0UUQhiiVdFc6lzcKZNr3bir3ctJtjvspIzkL8GZ1zz/fCCTzFdAu+KHZIzq+kyEJoFMXUAgME6by0NsOMPbmi8WM0A0cyi7f6K/7bSa/kYcPpz0ungGsrmmEVHeLJqrATR2Nq/GGcKG0nFJQrlTtGbPBAOPK7tDV2Nu+1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886718; c=relaxed/simple;
	bh=wXDbQK+aWTdpaYfGDHxwyCYWo18Y0oqrAkQrZuKUZzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASYZawQmCSlaH5THGpIGXBMkat+w8Cp1nJj9djMfFCiHlK0gBIF5R281ylMnfPE0TH+5UpoUg2qM987vrQEcMuOfr3/m3p1BqJosaG5Aj18nGBFv4PlEmQyxHlgBGDmlrm9EuuVhRLP3ghWRAWaHrc27Xiu1Y3leftJBy/xtrAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN6vhxwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC47C4CEF5;
	Sun, 14 Sep 2025 21:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886717;
	bh=wXDbQK+aWTdpaYfGDHxwyCYWo18Y0oqrAkQrZuKUZzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JN6vhxwMHgcrNnr6k7he6irhDqrC0/e2YhuaJmGM9t+Hp2Pm74WwVsZcw2K1iqXqF
	 Dr42V8Z7kHf20zhuA2VucvugSrXj76z4Oymwcd5anM+eFZFjZnlgflYkUcyT9ovzi4
	 7AT8CEYulZUnBSGE3wr8sBAOT61sH0341Hz1QcTGs3kg1YT0MOszMhTs/9sel2RIXe
	 ftCv9ET7RHxCLy6WgQb9dydMH17p+shnIv8mS3AAtCpk16dy5+xHBMWXr/WxiCRWE8
	 dadOwng+QASQS0W7OSJvy2nQtwhSwzBfHUG0DwgbZThQGKthmTqP6yy40YLaaluL8j
	 nxNfgdePdPytw==
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
Subject: [PATCH v4 02/12] bpf: Implement exclusive map creation
Date: Sun, 14 Sep 2025 23:51:31 +0200
Message-ID: <20250914215141.15144-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914215141.15144-1-kpsingh@kernel.org>
References: <20250914215141.15144-1-kpsingh@kernel.org>
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
 include/uapi/linux/bpf.h       |  6 ++++++
 kernel/bpf/syscall.c           | 31 +++++++++++++++++++++++++++----
 kernel/bpf/verifier.c          |  6 ++++++
 tools/include/uapi/linux/bpf.h |  6 ++++++
 5 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d75902074bd1..c6a6ee1b2938 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -329,6 +329,7 @@ struct bpf_map {
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
 	u64 cookie; /* write-once */
+	char *excl_prog_sha;
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..57687b2e1c47 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1522,6 +1522,12 @@ union bpf_attr {
 		 * If provided, map_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32	map_token_fd;
+
+		/* Hash of the program that has exclusive access to the map.
+		 */
+		__aligned_u64 excl_prog_hash;
+		/* Size of the passed excl_prog_hash. */
+		__u32 excl_prog_hash_size;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3f178a0f8eb1..c8ef91acfe98 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -860,6 +860,7 @@ static void bpf_map_free(struct bpf_map *map)
 	 * the free of values or special fields allocated from bpf memory
 	 * allocator.
 	 */
+	kfree(map->excl_prog_sha);
 	migrate_disable();
 	map->ops->map_free(map);
 	migrate_enable();
@@ -1338,9 +1339,9 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
+#define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bool kernel)
+static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1534,7 +1535,29 @@ static int map_create(union bpf_attr *attr, bool kernel)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = security_bpf_map_create(map, attr, token, kernel);
+	if (attr->excl_prog_hash) {
+		bpfptr_t uprog_hash = make_bpfptr(attr->excl_prog_hash, uattr.is_kernel);
+
+		if (attr->excl_prog_hash_size != SHA256_DIGEST_SIZE) {
+			err = -EINVAL;
+			goto free_map;
+		}
+
+		map->excl_prog_sha = kzalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
+		if (!map->excl_prog_sha) {
+			err = -ENOMEM;
+			goto free_map;
+		}
+
+		if (copy_from_bpfptr(map->excl_prog_sha, uprog_hash, SHA256_DIGEST_SIZE)) {
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
 
@@ -6008,7 +6031,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr.is_kernel);
+		err = map_create(&attr, uattr);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17fe623400a5..9c5a88ec5abe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20382,6 +20382,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
index 233de8677382..57687b2e1c47 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1522,6 +1522,12 @@ union bpf_attr {
 		 * If provided, map_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32	map_token_fd;
+
+		/* Hash of the program that has exclusive access to the map.
+		 */
+		__aligned_u64 excl_prog_hash;
+		/* Size of the passed excl_prog_hash. */
+		__u32 excl_prog_hash_size;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
-- 
2.43.0


