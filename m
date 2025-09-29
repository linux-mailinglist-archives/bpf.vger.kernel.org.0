Return-Path: <bpf+bounces-69991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46913BAAA68
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 23:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8E11C037C
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39133254864;
	Mon, 29 Sep 2025 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CpOtvuTT"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4184D23D7E5;
	Mon, 29 Sep 2025 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759181730; cv=none; b=px8gnj3oMQbrnO6U9ZlTWL/aPn5mU01NoElFlLrtt4fmhsY+Su7AuyF0NpepA9jpdEPshVIYKdAimVY8XrNOosQqtNv+mpFQgEICLQBOqSSDBdX00fK8NMTcmdDlZoqgXPWWMtaXjFmDckVt5mwehOkVu4LK8zy0v34sq/INaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759181730; c=relaxed/simple;
	bh=/D8nAmnHWUJeRU9BVQpvzcKHYnFsi1AJfvz+5IrM6HY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXdfmjQZJneBVnkpe5DOEttS0RNSU6QUkI/ygOCA9f4suNL+dNjsUXwpINjdZTtK6peYQk/GsE3XJhjEW3pk+d38rZIuFRatqBifT39dzCpgaHAh5dG2DwbA6JpJgNOw/KRRsmupDSGWlj/6M/5ssQekfUAOs3q/vGf3EkZCMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CpOtvuTT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 50994201A7ED;
	Mon, 29 Sep 2025 14:35:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50994201A7ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759181728;
	bh=prYK+HM2ROaEVHkqQpOji8wrGrxdkVmBd8fzO/0tgGs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CpOtvuTTq7YsHJOH2L0FHWU/05vpgxBUA18b1kzLFFkBteoYyWLEUDjECmptB3oZz
	 Hwu5HASglaOhSG7nUYD04m/3tHVTZpDBEBz+dgjpUhMomJwbrG+lpXKIDJDuIqO4n9
	 nkcTfj6gbc7PBs7aUQ8WA92GrCC1ohMFk58QrbWM=
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
	wufan@linux.microsoft.com,
	qmo@kernel.org
Subject: [PATCH bpf-next v2 1/3] bpf: Add hash chain signature support for arbitrary maps
Date: Mon, 29 Sep 2025 14:34:25 -0700
Message-ID: <20250929213520.1821223-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
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

Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/uapi/linux/bpf.h       |  6 +++
 kernel/bpf/syscall.c           | 73 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  6 +++
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ae83d8649ef1c..a436a2ff49437 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1621,6 +1621,12 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		/* Pointer to a buffer containing the maps used in the signature
+		 * hash chain of the BPF program.
+		 */
+		__aligned_u64   signature_maps;
+		/* Size of the signature maps buffer. */
+		__u32		signature_maps_size;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a48fa86f82a7f..f728f663765c4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2802,14 +2802,35 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
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
 static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr,
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
+	u64 buffer[SHA256_DIGEST_SIZE * 2 / sizeof(u64)];
+	u64 hash[SHA256_DIGEST_SIZE / sizeof(u64)];
+	int n;
 
 	if (system_keyring_id_check(attr->keyring_id) == 0)
 		key = bpf_lookup_system_key(attr->keyring_id);
@@ -2830,16 +2851,60 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
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
+		if (IS_ERR(maps)) {
+			err = PTR_ERR(maps);
+			goto out;
+		}
+		/* Process the map array in reverse order to generate a hash chain
+		 * h(n) = sha256(h(n + 1), sha256(map(n)))
+		 * h(n_len) = sha256(map(n_len))
+		 */
+		for (n = attr->signature_maps_size - 1; n >= 0; n--) {
+			err = copy_from_bpfptr_offset(&map_fd,
+						      make_bpfptr(attr->fd_array, is_kernel),
+						      maps[n] * sizeof(map_fd),
+						      sizeof(map_fd));
+			if (err)
+				goto free_maps;
+
+			if (n == attr->signature_maps_size - 1)
+				err = bpf_map_get_hash(map_fd, hash);
+			else {
+				memcpy(buffer, hash, sizeof(hash));
+				err = bpf_map_get_hash(map_fd, buffer + ARRAY_SIZE(hash));
+				sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
+			}
+			if (err)
+				goto free_maps;
+		}
+		/* Calculate final hash with program instructions
+		 * f_hash = sha256(sha256(prog), h(0))
+		 */
+		sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&buffer);
+		memcpy(buffer + ARRAY_SIZE(hash), hash, sizeof(hash));
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
index ae83d8649ef1c..a436a2ff49437 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1621,6 +1621,12 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
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


