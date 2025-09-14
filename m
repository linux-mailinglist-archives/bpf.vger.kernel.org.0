Return-Path: <bpf+bounces-68354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B93B56CBA
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F7C16E1A3
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770D2E6CAF;
	Sun, 14 Sep 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL786TqX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4622E7BCF;
	Sun, 14 Sep 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886734; cv=none; b=DWzg1IQtchiEVm3EW5w3n/cjFmUcY9pfiEy1hwGrQmGOTjtG95WZlEZ0+gh4nfDsSGZkZ0rqB6z8tIzMbkcGEeHMOyW5MS5MAamkN2Q48w8HMd5OYP85dGI/lY+L7SA/0t8DycxQobPz24QtmN+7DUpewK7WQPZ0UZ3sUzO2Rco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886734; c=relaxed/simple;
	bh=RD4Eksupqy51vhCP3PXBc44t4YTaDSTGpYm5QhEO5iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROHxEIVKwpm0T4xaIoT5eaglJpXnk762p44pUAgqcXgoco0N1Dc7XN3YlLGvgYm4fNWFGikEddykXKsRjGYAfZQbRHCoX7XFHNpUni5/e7QTeOgluetTGv/tnQdydPkErSXYnY/V6q76pMrDvvMJ8++bJac/PFmiYcWsU87E0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL786TqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A25C4CEF5;
	Sun, 14 Sep 2025 21:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886734;
	bh=RD4Eksupqy51vhCP3PXBc44t4YTaDSTGpYm5QhEO5iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dL786TqXkcsD7jO3XY38uimhfmhvYRISpeQLZgWw6LUCV7VeH1ip4YV7TFqZJKHG3
	 d0WPDww+RgzgwGZyui9TcQQ1CFp731bl/lW7SJmNRdBNg9+pyafW4P6zcLMXLgJN6+
	 9CAefxD6OspaAShj28WIKmtsUjyzekapRl8xQWAah7f1wUXzRGaDyTX6fX4mBCFp2k
	 HWjCl3uvmSlckbgTGwHNzegd1CFccOOF3jUzmAs3PhVnoCgiWGzl+fJcsZSboCgi0j
	 ScECr1+V61boiuayqDW1Qw+Y5k2yJDrkDpQjunruLk5IazakYXR+yS5q9ycD1FMLxb
	 SMI6iFciGXrZg==
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
Subject: [PATCH v4 09/12] libbpf: Update light skeleton for signing
Date: Sun, 14 Sep 2025 23:51:38 +0200
Message-ID: <20250914215141.15144-10-kpsingh@kernel.org>
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


