Return-Path: <bpf+bounces-63953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B9B0CC70
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4C11AA603D
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E2241131;
	Mon, 21 Jul 2025 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewzpIjwY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1012405F6;
	Mon, 21 Jul 2025 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132825; cv=none; b=BpeUUiuSIWbp4oLYWlveLSXxL+pXCxbNSb+UdG3GCLl8bzWR0pbDUaQRdTGE57CHhyJCekeu24+/rO+LYwCfEbtmjqtlNf3oLvS7Z0d+ZxkcxH4mGogmHb7mRRSMs3d4FfV/w08vBpi2cI4W/qGM3UPKpurJ7ZO5MAgjmDfYI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132825; c=relaxed/simple;
	bh=kFEa5/yaSuk5eufnujmavGUVySXY0cMwC4HO63qkRW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPzVvycsyNZFsPodXdVdEct4RYOU0B0geK4pTFbwx2jODx1Oqt/1OIYhZJSRbHC22G32gzSs3xNmBSpSv//nHjGm0Kms+fI776G0yyZ7W7VGOmSCAnPja6jZe8Rcb2IjKMhcOExa9vft7AMVkz06F6U9cpD3kjOqkZ9q6ctrTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewzpIjwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB2DC4AF09;
	Mon, 21 Jul 2025 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132825;
	bh=kFEa5/yaSuk5eufnujmavGUVySXY0cMwC4HO63qkRW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewzpIjwYO1ovo7c1mEr24IWS2GLEYW6lLpy452JhVzbatO28qyTwO9e22fz0HmFZK
	 FmHgBzYkAJUNamaf2o/rRALoKDhonwKKCr1UY3AJgfvUp7LR9xS6kvR/Or0Z4So9R+
	 /I9/RgTfCInJIoIvsq28I/h3lX9sQ2bsAD1XcYxlLiOVFjWNZVse0yhDyEZ6CEH3Zr
	 6hf0Vp428rpWeQ0cuCVl0gfLlzPIi3fSWkvaeo4nt3GazCk9srEKvKxJulqw4PeG8P
	 oPGYog9C4yXwgKYBZF3axDDjPGGTgVapRd32DsIs3jzjTciOPfX4kUwp+oU+NtlSmL
	 RcvsEUhhqRBRg==
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
Subject: [PATCH v2 09/13] libbpf: Update light skeleton for signing
Date: Mon, 21 Jul 2025 23:19:54 +0200
Message-ID: <20250721211958.1881379-10-kpsingh@kernel.org>
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

* The metadata map is created with as an exclusive map (with an
excl_prog_hash) This restricts map access exclusively to the signed
loader program, preventing tampering by other processes.

* The map is then frozen, making it read-only from userspace.

* BPF_OBJ_GET_INFO_BY_ID instructs the kernel to compute the hash of the
  metadata map (H') and store it in bpf_map->sha.

* The loader is then loaded with the signature which is then verified by
  the kernel.

The sekeleton currently uses the session keyring
(KEY_SPEC_SESSION_KEYRING) by default but this can
be overridden by the user of the skeleton.

loading signed programs prebuilt into the kernel are not currently
supported. These can supported by enabling BPF_OBJ_GET_INFO_BY_ID to be
called from the kernel.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/skel_internal.h | 75 +++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 4d5fa079b5d6..5b6d1b09dc8a 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -13,10 +13,15 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
+#include <linux/keyctl.h>
 #include <stdlib.h>
 #include "bpf.h"
 #endif
 
+#ifndef SHA256_DIGEST_LENGTH
+#define SHA256_DIGEST_LENGTH 32
+#endif
+
 #ifndef __NR_bpf
 # if defined(__mips__) && defined(_ABIO32)
 #  define __NR_bpf 4355
@@ -64,6 +69,11 @@ struct bpf_load_and_run_opts {
 	__u32 data_sz;
 	__u32 insns_sz;
 	const char *errstr;
+	void *signature;
+	__u32 signature_sz;
+	__u32 keyring_id;
+	void * excl_prog_hash;
+	__u32 excl_prog_hash_sz;
 };
 
 long kern_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
@@ -220,14 +230,19 @@ static inline int skel_map_create(enum bpf_map_type map_type,
 				  const char *map_name,
 				  __u32 key_size,
 				  __u32 value_size,
-				  __u32 max_entries)
+				  __u32 max_entries,
+				  const void *excl_prog_hash,
+				  __u32 excl_prog_hash_sz)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash);
 	union bpf_attr attr;
 
 	memset(&attr, 0, attr_sz);
 
 	attr.map_type = map_type;
+	attr.excl_prog_hash = (unsigned long) excl_prog_hash;
+	attr.excl_prog_hash_size = excl_prog_hash_sz;
+
 	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
 	attr.key_size = key_size;
 	attr.value_size = value_size;
@@ -300,6 +315,34 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
 }
 
+static inline int skel_obj_get_info_by_fd(int fd)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, info);
+	__u8 sha[SHA256_DIGEST_LENGTH];
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	union bpf_attr attr;
+
+	info.hash = (long) &sha;
+	info.hash_size = SHA256_DIGEST_LENGTH;
+
+	memset(&attr, 0, attr_sz);
+	attr.info.bpf_fd = fd;
+	attr.info.info = (long) &info;
+	attr.info.info_len = info_len;
+	return skel_sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, attr_sz);
+}
+
+static inline int skel_map_freeze(int fd)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, map_fd);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_fd = fd;
+
+	return skel_sys_bpf(BPF_MAP_FREEZE, &attr, attr_sz);
+}
 #ifdef __KERNEL__
 #define set_err
 #else
@@ -308,12 +351,13 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 
 static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 {
-	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, fd_array);
+	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, keyring_id);
 	const size_t test_run_attr_sz = offsetofend(union bpf_attr, test);
 	int map_fd = -1, prog_fd = -1, key = 0, err;
 	union bpf_attr attr;
 
-	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1);
+	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1,
+				       opts->excl_prog_hash, opts->excl_prog_hash_sz);
 	if (map_fd < 0) {
 		opts->errstr = "failed to create loader map";
 		set_err;
@@ -327,11 +371,34 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 		goto out;
 	}
 
+#ifndef __KERNEL__
+	err = skel_map_freeze(map_fd);
+	if (err < 0) {
+		opts->errstr = "failed to freeze map";
+		set_err;
+		goto out;
+	}
+	err = skel_obj_get_info_by_fd(map_fd);
+	if (err < 0) {
+		opts->errstr = "failed to fetch obj info";
+		set_err;
+		goto out;
+	}
+#endif
+
 	memset(&attr, 0, prog_load_attr_sz);
 	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
 	attr.insns = (long) opts->insns;
 	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
 	attr.license = (long) "Dual BSD/GPL";
+#ifndef __KERNEL__
+	attr.signature = (long) opts->signature;
+	attr.signature_size = opts->signature_sz;
+#else
+	if (opts->signature || opts->signature_sz)
+		pr_warn("signatures are not supported from bpf_preload\n");
+#endif
+	attr.keyring_id = opts->keyring_id;
 	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
 	attr.fd_array = (long) &map_fd;
 	attr.log_level = opts->ctx->log_level;
-- 
2.43.0


