Return-Path: <bpf+bounces-59973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D4CAD0A4C
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B9B17568E
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7123F41A;
	Fri,  6 Jun 2025 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8ZQHsrF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B51F4C94;
	Fri,  6 Jun 2025 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252580; cv=none; b=mvl2ghF98bKQ+LuZtmDJNNSGyBhqEPbXNS8KMI31q9xTG2JvjQk35qIjCV97ikEfG6+Ix8cgULKqUqu3bgbgoYhVy2FoY5RmXH40TkItgOgFUK8tC47Iqvkr/qfKlpKtngYBDdBkxOxWcCzPZlN3JyKelvIKO6IOMFWpQJOJIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252580; c=relaxed/simple;
	bh=0vLjJm41PJNMAxExS1w9RYwKvN27S2/KOcukoFpI9+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leyEXVNDVLtwKo79LVZMjq3zaZdIP543Wwpc0msYBKY9jL/9imIRDvdJopEN8wFxUk5U6hdwDLhjBNlo5CZf0tn8gNfQ/8I0DNjUNUJhMyslWlQQMdDVPB4Rp1wUlu5A2gEGeRSLQq/0YkPZe0i5zQNpLPibp11GwMRSdJ9f4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8ZQHsrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7544BC4CEF2;
	Fri,  6 Jun 2025 23:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252580;
	bh=0vLjJm41PJNMAxExS1w9RYwKvN27S2/KOcukoFpI9+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8ZQHsrFYqICw4E+pXvuulu/upMh5DdY7ubE5dG7NGaQBzLL+rhukuFjyXZIOj4oI
	 8gtapODsPSA/RAyTJH6Kx9rEXY59zE9UwB66cni3bpMFQWKJuQ/DrSc1DYWN9P/G8N
	 49v9/eJ6dNg6ho7ZuHIsjHOJhccZiLlqNMQwcqwqP6JDKj9ffFrZn1/oDYs7/a5OJp
	 VepU6duVVxWysO6Y0zAjk8JYIIlqLcz8M3MqJ+7HPfNQUMqM9Tspwa698yveDBM40B
	 KF7Od1iYtCKObr8QFKTYKkQiKbwG8EoEnRBF5M9qST7Ii6JesBN17/HzZYHwDf4YMC
	 SQwn0gWbSVaTQ==
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
Subject: [PATCH 09/12] libbpf: Update light skeleton for signing
Date: Sat,  7 Jun 2025 01:29:11 +0200
Message-ID: <20250606232914.317094-10-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
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

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/skel_internal.h | 57 +++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 4d5fa079b5d6..25502925ff36 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -13,6 +13,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
+#include <linux/keyctl.h>
 #include <stdlib.h>
 #include "bpf.h"
 #endif
@@ -64,6 +65,11 @@ struct bpf_load_and_run_opts {
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
@@ -218,16 +224,21 @@ static inline int skel_closenz(int fd)
 
 static inline int skel_map_create(enum bpf_map_type map_type,
 				  const char *map_name,
+				  const void *excl_prog_hash,
+				__u32 excl_prog_hash_sz,
 				  __u32 key_size,
 				  __u32 value_size,
 				  __u32 max_entries)
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
@@ -300,6 +311,26 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
 }
 
+static inline int skel_obj_get_info_by_fd(int fd)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, info);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.info.bpf_fd = fd;
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
@@ -308,12 +339,15 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 
 static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 {
-	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, fd_array);
+	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, keyring_id);
 	const size_t test_run_attr_sz = offsetofend(union bpf_attr, test);
 	int map_fd = -1, prog_fd = -1, key = 0, err;
 	union bpf_attr attr;
 
-	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1);
+	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map",
+				       opts->excl_prog_hash,
+				       opts->excl_prog_hash_sz, 4,
+				       opts->data_sz, 1);
 	if (map_fd < 0) {
 		opts->errstr = "failed to create loader map";
 		set_err;
@@ -327,10 +361,27 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 		goto out;
 	}
 
+	err = skel_map_freeze(map_fd);
+	if (err < 0) {
+		opts->errstr = "failed to freeze map";
+		set_err;
+		goto out;
+	}
+
+	err = skel_obj_get_info_by_fd(map_fd);
+	if (err < 0) {
+		opts->errstr = "failed to fetch obj info";
+		set_err;
+		goto out;
+	}
+
 	memset(&attr, 0, prog_load_attr_sz);
 	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
 	attr.insns = (long) opts->insns;
 	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
+	attr.signature = (long) opts->signature;
+	attr.signature_size = opts->signature_sz;
+	attr.keyring_id = opts->keyring_id;
 	attr.license = (long) "Dual BSD/GPL";
 	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
 	attr.fd_array = (long) &map_fd;
-- 
2.43.0


