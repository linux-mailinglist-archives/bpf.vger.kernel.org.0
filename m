Return-Path: <bpf+bounces-59968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F65AAD0A43
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349AE1892483
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C723ED69;
	Fri,  6 Jun 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZR2bwtQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD723E34F;
	Fri,  6 Jun 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252569; cv=none; b=UmBdCClTznHz0CcakEf5MB/6x/zyCUgGSZZMS0iupqp/1ne7eHczmRtZooq2kUw9skJ5KdPPnOfop5bXKa9K0I3XX3hEFtz7h9ydsMaEdKDj+6MLU45c2ybL72OYB0Vh4YbAZo3+/K08Xqtx6UyWFLgkZDkH6ugM+aQcBH7hvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252569; c=relaxed/simple;
	bh=iVHtSd1bM8+/vnFUFA297iXbye4dZZCeDANxJVgTTN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBKmosBcIgTGAfHwZ9CchS8WBI/YQ826xWSjLomTKqM1leDWYgNR3uVwUbMe+Fzz+12VbEe5KcDJHNJwc534d6sGFZZno3Pe1ADvH2tmLHmJRYXWAoieOOCbNnjn6RtJGXAORCAp1Xv6k97p9JBLpNzwQ1v7guew0didjzz+7QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZR2bwtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3931BC4CEEF;
	Fri,  6 Jun 2025 23:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252569;
	bh=iVHtSd1bM8+/vnFUFA297iXbye4dZZCeDANxJVgTTN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZR2bwtQrgR939ysUQ1+OXd8xplxR+6lmAutY2o+X33k40puefLdJXnqM91SC9aEW
	 u2fcQCPBEhOY9wZrLNn/ZLKxR++JcZ52C1VdGYRMiyv6au/FWkGWnr0+BfzdqhFi/I
	 hjH346ZPpuRlqYdbqANGGWxeZcw/jgj8NpXSM+4jkEi7we7B9YaF7Ed1SkqOBjLgDb
	 x7XkOPd1KBlaqpcjMmic4D5YGmoP6qFnJ3r3jt2kf8Rp6pDZdQCB3Wq18eljmnchUP
	 CJOJhKXUhGh1aL1ID65NILebw2au3VdqZNgumKam0dCE9US61Ds/T0eX9Emq5OfHsF
	 Pkrqbq3hAsuTA==
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
Subject: [PATCH 04/12] libbpf: Implement SHA256 internal helper
Date: Sat,  7 Jun 2025 01:29:06 +0200
Message-ID: <20250606232914.317094-5-kpsingh@kernel.org>
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

Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
used for the loader generation code to embed the metadata hash in the
loader program and also by the bpf_map__make_exclusive API to calculate
the hash of the program the map is exclusive to.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 57 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  9 ++++++
 2 files changed, 66 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e9c641a2fb20..475038d04cb4 100644
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
@@ -14161,3 +14164,57 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+int libbpf_sha256(const void *data, size_t data_size, void *sha_out)
+{
+	int sock_fd = -1;
+	int op_fd = -1;
+	int err = 0;
+
+	struct sockaddr_alg sa = {
+		.salg_family = AF_ALG,
+		.salg_type   = "hash",
+		.salg_name   = "sha256"
+	};
+
+	if (!data || !sha_out)
+		return -EINVAL;
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
+		goto out_sock;
+	}
+
+	op_fd = accept(sock_fd, NULL, 0);
+	if (op_fd < 0) {
+		err = -errno;
+		pr_warn("failed to accept from AF_ALG socket for SHA256: %s\n", errstr(err));
+		goto out_sock;
+	}
+
+	if (write(op_fd, data, data_size) != data_size) {
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
+	close(op_fd);
+out_sock:
+	close(sock_fd);
+	return libbpf_err(err);
+}
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 477a3b3389a0..79c6c0dac878 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -736,4 +736,13 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
 
 int probe_fd(int fd);
 
+#ifndef SHA256_DIGEST_LENGTH
+#define SHA256_DIGEST_LENGTH 32
+#endif
+
+#ifndef SHA256_DWORD_SIZE
+#define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
+#endif
+
+int libbpf_sha256(const void *data, size_t data_size, void *sha_out);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.43.0


