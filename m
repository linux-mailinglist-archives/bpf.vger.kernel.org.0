Return-Path: <bpf+bounces-68348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B46B56CAC
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 23:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBF716D981
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFC2E7BB1;
	Sun, 14 Sep 2025 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1dzLLou"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256201D7E4A;
	Sun, 14 Sep 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886720; cv=none; b=a6W9qdjkFvstroMW/nHV1/+e9k4HmCXjzLMpHz1/1xccLeX6BJ9Alb825Iu20F1ucxBcODF62erVTSO+v9Cvia6sPEV8+NciCsHt0g66oN3luOZGH6V9WCqErIEvskzOSG2OWEO6HoMoT0boMBTs3Qui5CPj12GC8jdhJp9kGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886720; c=relaxed/simple;
	bh=WwHtLqZw4kdDN26qvzQW//nfjs0z4LF0Riy5C0UJb0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvDLOq9ecFOilIhdZVNyzi+G+P2mof3+pMvoNULfueMtAqZJeAGDC7Op2B9UBMTddp1aVfk5871ZadFSSkA57G84Nod2lCo6hT2WNb78EUIYisNeTq6r+gZPHBkMAV42hR3VvwxrctaxJrSGmF7b/J9QJ69zrMtI1It4dupha+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1dzLLou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF14CC4CEFC;
	Sun, 14 Sep 2025 21:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886719;
	bh=WwHtLqZw4kdDN26qvzQW//nfjs0z4LF0Riy5C0UJb0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1dzLLouio8VGU3CqIiy0XrVxaDHxFlWc73zJOvl8aYyS/+rmIoiIwcq3euYD4USD
	 ZsIwIDEBMZvFN/uPuQ0bMF+sRsf95qBBjCdg4JoOQOGyaDwrpT+Koado14i4BVR32U
	 q3PsYkO4YcudVjCtEy6wmwSg0LnjpnXjr2jJJIdUsfOed4J/luo8l8k2FUvQHfmYDj
	 NE7yJZ6J7zJh5j5WeR6lZZpjtPXN+CsWqXzJ0g6y7YuMjdxYhOfYYeJUpFzztTYfrb
	 2QQvy9vG+uCaOV2aBkmoPdsut41FnYVxZSHC9oUSTbKIsvgHzp0aKrNaejI9jYUbHF
	 vwb0vWsYwrlQA==
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
Subject: [PATCH v4 03/12] libbpf: Implement SHA256 internal helper
Date: Sun, 14 Sep 2025 23:51:32 +0200
Message-ID: <20250914215141.15144-4-kpsingh@kernel.org>
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


