Return-Path: <bpf+bounces-65548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53951B254CA
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CF59A470A
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A82F9995;
	Wed, 13 Aug 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg3fuv20"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C62F28FC;
	Wed, 13 Aug 2025 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118540; cv=none; b=WPbl7hvBqChxml3tyDnWORtmxeAAkJ790FPGfG4yfcB1ClAPtmiELYrQemhF1ZPssVgufnlc5VWVHCQouBc61fZpGJXNhMd8YKiy5qu6Qt0NKtJHZw+W7xDlHJpp0Hr7Wt7cRkiJGD9GDfuqqAgChK44BISKbWimFyphsroFtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118540; c=relaxed/simple;
	bh=R6RBBJ+UoXPm+YKr+z5Go8Pp/xR66pnVPokn7HqXPsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxCKOVmE3QMW86piC6okUDliu8frniSiCkbOgklC0NC8Qi3OStXOLZe6b/VpjHPCR/OkkDaNU6azjYobSdv8FTiLCAqGapvwfLPdKiy8GoRHng6vH2cfZd/r+Lr2A6ugzuZdlp0wTBV2i58YG+rcmpn9GXsIQ5Z15PKp9EeWlfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg3fuv20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CEFC4CEED;
	Wed, 13 Aug 2025 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755118538;
	bh=R6RBBJ+UoXPm+YKr+z5Go8Pp/xR66pnVPokn7HqXPsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jg3fuv20q2ecUeiC/5TLIMf5i+ME3Ubw+SSJXgVwQG425MUKMmHOKSLmaLTFZs8b+
	 oGtIpHmD+ggyH3Ta5eY2QsSCPfAFaYItokuF7oESK3Co7Kloz/ZotFtJduTLbgueii
	 xM4iJAkk5xz4Jg6zGmoI3cLEDW3JyRt2PU5uqJoyKJZKvERPzz1gr7MeGIJS8+Wguo
	 COIi49d3Vkj0UmsLJDm2NiJ13s9vfV4Z0G1+/cAGKdQwtnlBL1kGu6lg9SkevHwD2g
	 lrF1uxTaDr7r4BXpdkSSZrvMWuLxnrb6NMcmnB5BOrve5NIlHdyawq3qIAZIXgSHCw
	 1q+sELe8NdWHw==
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
Subject: [PATCH v3 03/12] libbpf: Implement SHA256 internal helper
Date: Wed, 13 Aug 2025 22:55:17 +0200
Message-ID: <20250813205526.2992911-4-kpsingh@kernel.org>
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

Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
used for the loader generation code to embed the metadata hash in the
loader program and also by the bpf_map__make_exclusive API to calculate
the hash of the program the map is exclusive to.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 59 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  4 +++
 2 files changed, 63 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8f5a81b672e1..0bb3d71dcd9f 100644
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
@@ -14207,3 +14210,59 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
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
+		return libbpf_err(-EINVAL);
+	}
+
+	sock_fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	if (sock_fd < 0) {
+		err = -errno;
+		pr_warn("failed to create AF_ALG socket for SHA256: %s\n", errstr(err));
+		return libbpf_err(err);
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
+	return libbpf_err(err);
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


