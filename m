Return-Path: <bpf+bounces-69150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E01BB8DD92
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD973A4C91
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B972153E7;
	Sun, 21 Sep 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR1BZj/g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30420E6E2;
	Sun, 21 Sep 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758469503; cv=none; b=LrTM9e4CvKbqEpe2tzfEdH5FbS7b2Ya+jFQHZgjQPLXABqg4fPfb9Fn/HMntB/CuUp72K3kV3LxSjh02VkN+DWyehYguKSwizWA6sskn7ZS3eeZ1+8leMRK7CXkGKlkuR4P8idpevGse4WwGrThxxN7WXlgJsNFarzmH7LzlH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758469503; c=relaxed/simple;
	bh=RD4Eksupqy51vhCP3PXBc44t4YTaDSTGpYm5QhEO5iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8nS+PWswPSH2cxJ/zDcqAsW81CIYazpdZqC49xfHA2mjlBD2X/1+CYVJDxwIAF7Bm9rCsqWldE9tR/bBOP1zmojXLs9+8g92zI/BHm2f2X+YeT7X+raYh0J629ZexPxH3L+Eq3HONrzz4MYD7w+JEgcYaJQHTUzoLU0ZL5HWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR1BZj/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3288C4CEE7;
	Sun, 21 Sep 2025 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758469502;
	bh=RD4Eksupqy51vhCP3PXBc44t4YTaDSTGpYm5QhEO5iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lR1BZj/gSmrL1tXVS5kvMp7wVR5Tzsk+I43QvvLxsv8431uylV7FbZ/L3RErLHXtG
	 ICsE5VZJXuGClHF7F0HF6mgK/MZVXqUlB7JcR1z4vtfCgV7lPVB2vudBa14yK39/y+
	 TNZlWdM0V21Gy5dtgd/E4thm7wv9Jv+xSmD4UvQeyeMeg8K8aNizFy1naXQafhWzXd
	 MdLU5mPl6rpG4LHcZdK//sR+dC8l9BaSfWoji0F6OzykPuWemoS9HhCSeA/EOlje7F
	 bBWrRJ6Eoc6g40XVD3Wl7gcTuI40T5M1Ymacox1O4GB3Emw14CdZbRiezE+ll6N4t5
	 FjcW6GOuAbdtw==
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
Subject: [PATCH v6 2/5] libbpf: Update light skeleton for signing
Date: Sun, 21 Sep 2025 17:44:49 +0200
Message-ID: <20250921154452.8881-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921154452.8881-1-kpsingh@kernel.org>
References: <20250921154452.8881-1-kpsingh@kernel.org>
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

loading signed programs prebuilt into the kernel are not currently
supported. These can supported by enabling BPF_OBJ_GET_INFO_BY_ID to be
called from the kernel.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/skel_internal.h | 76 +++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 4d5fa079b5d6..7f784c32b967 100644
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
+	__s32 keyring_id;
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
+	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
 	union bpf_attr attr;
 
 	memset(&attr, 0, attr_sz);
 
 	attr.map_type = map_type;
+	attr.excl_prog_hash = (unsigned long) excl_prog_hash;
+	attr.excl_prog_hash_size = excl_prog_hash_sz;
+
 	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
 	attr.key_size = key_size;
 	attr.value_size = value_size;
@@ -300,6 +315,35 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
 }
 
+static inline int skel_obj_get_info_by_fd(int fd)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, info);
+	__u8 sha[SHA256_DIGEST_LENGTH];
+	struct bpf_map_info info;
+	__u32 info_len = sizeof(info);
+	union bpf_attr attr;
+
+	memset(&info, 0, sizeof(info));
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
@@ -308,12 +352,13 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 
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
@@ -327,11 +372,34 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
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


