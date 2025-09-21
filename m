Return-Path: <bpf+bounces-69137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478B7B8DBF3
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 15:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2203B2B49
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9652D4803;
	Sun, 21 Sep 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJlIHV/+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24002C08D1;
	Sun, 21 Sep 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461505; cv=none; b=rArwenu1xzUsI3TqDwDm+L9gzGVBRG7iYrXdK61Op7+eYliCUKGbQAXAfCE5tpBu2l3XE6km3ZFiCu+pHyGpMpdcuMYftlFx5NCRgo57wCnqoTsWpAi9hmBON53hHqo3bgDzENYZz9jMRjbXrcWiZh9ox+JojdL3ShTSz2RkQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461505; c=relaxed/simple;
	bh=WwHtLqZw4kdDN26qvzQW//nfjs0z4LF0Riy5C0UJb0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQI+1rrgg8ValCBJs5qqChxSlHxSOM/x/6iQTVVIV6LwTSYOJIZE+/y0nQXIBRUvEn6qnqCy/dZw+vA0gVB5Zm4LNoRwB9skdx45hoegGDsvynu2RBxsrp9IWFT/W4dmedsMUw1bj9O3m1qVrAYqe6YM29d59kZlj44m48+WCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJlIHV/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7555CC4CEE7;
	Sun, 21 Sep 2025 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461505;
	bh=WwHtLqZw4kdDN26qvzQW//nfjs0z4LF0Riy5C0UJb0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJlIHV/+Sxc/5l2+FSha3wPg8sREQf+hi7jp5vwcwHaP0tGr1LXnZaDCO9H2lBhkr
	 cI/p9MoN8QqevTuTLBjKk7Lz3AsCvKnaFACsPIm0+bRRq3BJIK0uazFH0ya6HH53Yi
	 2HpFkXERPZj/PNk/Jz/f86tqrqIeZoNk4IrR/HMv4ZYbykM+8a3RixRb0o+BanvwCU
	 +OCCgiV4v62JJIAWJdCsGqp1NJ5Ngubo5MGSNkZCklK5q886BciQRzYKo3H3yqCtB2
	 iuagcXgCrE8Tq8lErsM8WCZUadUUXz3yb721s53Dmsg538vzraMXW/rA7EiUMdcLju
	 pvP4b6xFRRsOw==
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
Subject: [PATCH v5 03/12] libbpf: Implement SHA256 internal helper
Date: Sun, 21 Sep 2025 15:31:24 +0200
Message-ID: <20250921133133.82062-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921133133.82062-1-kpsingh@kernel.org>
References: <20250921133133.82062-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
used for the loader generation code to embed the metadata hash in the
loader program and also by the bpf_map__make_exclusive API to calculate
the hash of the program the map is exclusive to.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 59 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  4 +++
 2 files changed, 63 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fe4fc5438678..a39640bd5448 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -43,6 +43,9 @@
 #include <sys/vfs.h>
 #include <sys/utsname.h>
 #include <sys/resource.h>
+#include <sys/socket.h>
+#include <linux/if_alg.h>
+#include <linux/socket.h>
 #include <libelf.h>
 #include <gelf.h>
 #include <zlib.h>
@@ -14217,3 +14220,59 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+int libbpf_sha256(const void *data, size_t data_sz, void *sha_out, size_t sha_out_sz)
+{
+	struct sockaddr_alg sa = {
+		.salg_family = AF_ALG,
+		.salg_type   = "hash",
+		.salg_name   = "sha256"
+	};
+	int sock_fd = -1;
+	int op_fd = -1;
+	int err = 0;
+
+	if (sha_out_sz != SHA256_DIGEST_LENGTH) {
+		pr_warn("sha_out_sz should be exactly 32 bytes for a SHA256 digest");
+		return -EINVAL;
+	}
+
+	sock_fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	if (sock_fd < 0) {
+		err = -errno;
+		pr_warn("failed to create AF_ALG socket for SHA256: %s\n", errstr(err));
+		return err;
+	}
+
+	if (bind(sock_fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		err = -errno;
+		pr_warn("failed to bind to AF_ALG socket for SHA256: %s\n", errstr(err));
+		goto out;
+	}
+
+	op_fd = accept(sock_fd, NULL, 0);
+	if (op_fd < 0) {
+		err = -errno;
+		pr_warn("failed to accept from AF_ALG socket for SHA256: %s\n", errstr(err));
+		goto out;
+	}
+
+	if (write(op_fd, data, data_sz) != data_sz) {
+		err = -errno;
+		pr_warn("failed to write data to AF_ALG socket for SHA256: %s\n", errstr(err));
+		goto out;
+	}
+
+	if (read(op_fd, sha_out, SHA256_DIGEST_LENGTH) != SHA256_DIGEST_LENGTH) {
+		err = -errno;
+		pr_warn("failed to read SHA256 from AF_ALG socket: %s\n", errstr(err));
+		goto out;
+	}
+
+out:
+	if (op_fd >= 0)
+		close(op_fd);
+	if (sock_fd >= 0)
+		close(sock_fd);
+	return err;
+}
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 477a3b3389a0..8a055de0d324 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -736,4 +736,8 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
 
 int probe_fd(int fd);
 
+#define SHA256_DIGEST_LENGTH 32
+#define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
+
+int libbpf_sha256(const void *data, size_t data_sz, void *sha_out, size_t sha_out_sz);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.43.0


