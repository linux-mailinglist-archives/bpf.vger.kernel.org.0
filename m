Return-Path: <bpf+bounces-67885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05DB5026E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DF9177647
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAB335207E;
	Tue,  9 Sep 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hpRl7Gy6"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE7A350D79;
	Tue,  9 Sep 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435043; cv=none; b=RRKxvd9c5rSQ+BBDshgSnPLudOrNPQsziornBYr9iXFvke2bOkTx/lCc/PdJ8DBur1esRYU/6HVV3Yll+UD/nBR2SkFAR1bkmvRVW7e/VRstVWJMVIwrGuAG9yIitRH15a+ptbvVzTpfKUfywFlxqMVaJPzv+reWnBFPRHZ3gLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435043; c=relaxed/simple;
	bh=9gUEC6ysVus8wdntY/iVOMvunK8HIq6hLROXssVMbH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+Nb+xQqga6bAX0gqh/poRTBRC8YEqee/RXY8anYA0CbSuZUjllTgIsD3y2nEXfHSihsi4eyqMxBJxSgJf9/wNNHvp3ojkY9lG6czy1GeB+YapgAmhkKMF3iFS3hMItRWSH2RQIZoIDFiaHQVgHGDsTToX2EFkhpT7/zV+izV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hpRl7Gy6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4060E211AA27;
	Tue,  9 Sep 2025 09:23:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4060E211AA27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757435036;
	bh=azm34o6VEYpJ6Pd4FyheG1pljATVOhQzgjpKhcrSLBQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hpRl7Gy69M+1Ww8r8eT7LuneGvXHMvpQAe8o2EuNoto7iqbkvKyezbsS9/fOfxx5q
	 2tuAq6rKY2Grcsp1QlX2lTgCGGOq0nvMcaqDfS6/fFeLyTPitfG9V0iel5Xab8+HUh
	 vIHSp9BRr7kJtcC1/InJY45Y9zX2MZFOa1VqrqrU=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kpsingh@kernel.org,
	bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	James.Bottomley@hansenpartnership.com,
	wufan@linux.microsoft.com
Subject: [RFC 1/2] bpf: Add hash chain signature support for arbitrary maps
Date: Tue,  9 Sep 2025 09:20:58 -0700
Message-ID: <20250909162345.569889-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909162345.569889-1-bboscaccy@linux.microsoft.com>
References: <20250909162345.569889-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces hash chain support for signature verification of
arbitrary bpf map objects which was described here:
https://lore.kernel.org/linux-security-module/20250721211958.1881379-1-kpsingh@kernel.org/

The UAPI is extended to allow for in-kernel checking of maps passed in
via the fd_array. A hash chain is constructed from the maps, in order
specified by the signature_maps field. The hash chain is terminated
with the hash of the program itself.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/uapi/linux/bpf.h       |  6 +++
 kernel/bpf/syscall.c           | 75 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  6 +++
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b42c3740e053e..c83f2a34674fd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1617,6 +1617,12 @@ union bpf_attr {
 		 * verification.
 		 */
 		__u32 		keyring_id;
+		/* Pointer to a buffer containing the maps used in the signature
+		 * hash chain of the BPF program.
+		 */
+		__aligned_u64   signature_maps;
+		/* Size of the signature maps buffer. */
+		__u32		signature_maps_size;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 10fd3ea5d91fd..f7e9bcabd9dcc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2780,15 +2780,36 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static inline int bpf_map_get_hash(int map_fd, void *buffer)
+{
+	struct bpf_map *map;
+
+	CLASS(fd, f)(map_fd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	if (!map->ops->map_get_hash)
+		return -EINVAL;
+
+	return map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, buffer);
+}
+
 static noinline int bpf_prog_verify_signature(struct bpf_prog *prog,
 					      union bpf_attr *attr,
 					      bool is_kernel)
 {
 	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
-	struct bpf_dynptr_kern sig_ptr, insns_ptr;
+	bpfptr_t umaps;
+	struct bpf_dynptr_kern sig_ptr, insns_ptr, hash_ptr;
 	struct bpf_key *key = NULL;
 	void *sig;
+	int *maps;
+	int map_fd;
 	int err = 0;
+	u64 buffer[8];
+	u64 hash[4];
+	int n;
 
 	if (system_keyring_id_check(attr->keyring_id) == 0)
 		key = bpf_lookup_system_key(attr->keyring_id);
@@ -2808,16 +2829,62 @@ static noinline int bpf_prog_verify_signature(struct bpf_prog *prog,
 	bpf_dynptr_init(&insns_ptr, prog->insnsi, BPF_DYNPTR_TYPE_LOCAL, 0,
 			prog->len * sizeof(struct bpf_insn));
 
-	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_ptr,
-					 (struct bpf_dynptr *)&sig_ptr, key);
+	if (!attr->signature_maps_size) {
+		err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_ptr,
+						 (struct bpf_dynptr *)&sig_ptr, key);
+	} else {
+		bpf_dynptr_init(&hash_ptr, hash, BPF_DYNPTR_TYPE_LOCAL, 0,
+				sizeof(hash));
+		umaps = make_bpfptr(attr->signature_maps, is_kernel);
+		maps = kvmemdup_bpfptr(umaps, attr->signature_maps_size * sizeof(*maps));
+		if (!maps) {
+			err = -ENOMEM;
+			goto out;
+		}
+		n = attr->signature_maps_size - 1;
+		err = copy_from_bpfptr_offset(&map_fd, make_bpfptr(attr->fd_array, is_kernel),
+					      maps[n] * sizeof(map_fd),
+					      sizeof(map_fd));
+		if (err < 0)
+			goto free_maps;
+
+		err = bpf_map_get_hash(map_fd, hash);
+		if (err != 0)
+			goto free_maps;
+
+		n--;
+		while (n >= 0) {
+			memcpy(buffer, hash, sizeof(hash));
+			err = copy_from_bpfptr_offset(&map_fd,
+						      make_bpfptr(attr->fd_array, is_kernel),
+						      maps[n] * sizeof(map_fd),
+						      sizeof(map_fd));
+			if (err < 0)
+				goto free_maps;
+
+			err = bpf_map_get_hash(map_fd, buffer+4);
+			if (err != 0)
+				goto free_maps;
+			sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
+			n--;
+		}
+		sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&buffer);
+		memcpy(buffer+4, hash, sizeof(hash));
+		sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
+		err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&hash_ptr,
+						 (struct bpf_dynptr *)&sig_ptr, key);
 
+free_maps:
+		kvfree(maps);
+	}
+out:
 	bpf_key_put(key);
 	kvfree(sig);
 	return err;
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD keyring_id
+#define BPF_PROG_LOAD_LAST_FIELD signature_maps_size
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b42c3740e053e..c83f2a34674fd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1617,6 +1617,12 @@ union bpf_attr {
 		 * verification.
 		 */
 		__u32 		keyring_id;
+		/* Pointer to a buffer containing the maps used in the signature
+		 * hash chain of the BPF program.
+		 */
+		__aligned_u64   signature_maps;
+		/* Size of the signature maps buffer. */
+		__u32		signature_maps_size;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.48.1


