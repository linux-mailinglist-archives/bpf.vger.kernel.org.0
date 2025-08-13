Return-Path: <bpf+bounces-65546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10317B254C5
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE6A9A49D4
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57D2EB5DB;
	Wed, 13 Aug 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS+mpfYr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9502D0275;
	Wed, 13 Aug 2025 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118536; cv=none; b=aSe25Ssmbi1nWMuE7YBIuCFvHrx9gTcYMhrkLbEOD6IA/QaNSvLvdlerVWYP6QWMK+vZpp9xpB9PW0WAa9IdvK/adnMJ1H4/QqFq2FAooy9prIVQAhHTVzujTXvjngV9ns511spwTw2aHRxqcLNRejSQr5XIJhzLA5/YSkS2ZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118536; c=relaxed/simple;
	bh=qiM16ol4XWlWiottEkZ9ol41+7UWQ9lxZaMSNIiuIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4TdCKjY+OymGncpXVeEdlSRNqxL0OUj5iBUAUn6B159iHb9UF7ALkajJbm0f9kdrnlkJbOFXTAG7jvOl6Z2dob0yJUQbvM2h5V4ooFokZ+PizNQZ2FS9fXTLPp/KrqzYr1yd0vwSBGZfql4r9SvcQsWwSEodulX/Q0dyoCHtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS+mpfYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9DBC4CEED;
	Wed, 13 Aug 2025 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755118536;
	bh=qiM16ol4XWlWiottEkZ9ol41+7UWQ9lxZaMSNIiuIBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WS+mpfYrNM18YR8ssgQ0xg3V7dtLdwB1HmeaJ/zfsCEyi72+6ZVfXYMEF2Dpn17nB
	 wS9JoFS+HzBQvvkRX5yC6/oIquv1nDGZ4JYWn8acR54ESHziSYcMphvneStx99xV3w
	 HWXyCY0uRSgyU5JDoJmO38C157pQNNitt2mLjoWsz88RBR0HabPwyd/4B4nr8DahiW
	 ga1jEwFNVeWE3Ato1w1go2n+cEGbcsLdVykqI4ddYsQMrc5mFyvDDc2U3+80tbpo73
	 J010p9hBgnAewXFp1vXhxfSFomSgxg4t/ykA1AN71VvALPo2B6Ieb21BLJ19G6gc4T
	 or7ruStD1eJwQ==
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
Subject: [PATCH v3 02/12] bpf: Implement exclusive map creation
Date: Wed, 13 Aug 2025 22:55:16 +0200
Message-ID: <20250813205526.2992911-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813205526.2992911-1-kpsingh@kernel.org>
References: <20250813205526.2992911-1-kpsingh@kernel.org>
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
index b98c5b5bf2a1..b23804733f2f 100644
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
index 0fbfa8532c39..943811165510 100644
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
+#define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bool kernel)
+static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1534,7 +1535,30 @@ static int map_create(union bpf_attr *attr, bool kernel)
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
 
@@ -6008,7 +6032,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr.is_kernel);
+		err = map_create(&attr, uattr);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3a3982fe20d4..2dd4449b946b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20360,6 +20360,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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


