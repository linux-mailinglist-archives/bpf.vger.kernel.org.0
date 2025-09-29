Return-Path: <bpf+bounces-69988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A7BAA747
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54B11923711
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3B246795;
	Mon, 29 Sep 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii1NB8sZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633A72614;
	Mon, 29 Sep 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174083; cv=none; b=tasm1jvdi1UNXWD5Ny8aBCUvNnX3P7fMZuPiicr/J6OR+tKkYehpSEf7/0NwA+jYDV9arVLc8Gy0hC/zEDYnFOLJkg+WEMwJJlfikgzIW5RPWWFFPv8csS/29rsohVAJQZWb4/ZLtP56BDC/TpIbRH6IlfAMdUwU+8sXEeDRmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174083; c=relaxed/simple;
	bh=oaGTFnx38NxkPsnynmtWkqJ3cT3BV/CcfvpZyK46Lg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ywtlxk0q02a0BBpA6hqvHz/lpVyBDXsmOo7pbgXtb5Kcmh7Rr6bkj9AOslcrBWppnFKG0t3DuIeekta6XoK+FqRcnm2fknkuXyUDycCY4Y5D7x5fn4YKncWpyM3mBE2YuGEtrdDTcMZUBaTMkIQVD/fySqFRyQc4ohVYJxnzDSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii1NB8sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8BAC4CEF4;
	Mon, 29 Sep 2025 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174082;
	bh=oaGTFnx38NxkPsnynmtWkqJ3cT3BV/CcfvpZyK46Lg0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ii1NB8sZF8bt6GUOjrt68rDuwzi88ccbXGNSfI7j4tSUk0cMzyYpv9CoY6Mw+zKkw
	 9LvTChQ5ItJ7bRx33EskVHIu4q4VMNPPalRXhFsL9ylhGK83aNmALCDdwne5rRqWRh
	 vRu3VNxpjEYSYtzaaK8UnBzf6LtRUBhbaoXERsvj5aUeNYVZktcLuy1GeWsc2tf06L
	 KAeBmDB0y1QuQhzdMRCon16pUVyjFarE4zVF9qSyXRhjJDrEms6T6OzOhlaF2zor6d
	 L0qP5d6hQQL8NVZcXpXfroFtiRtEklCBo7+NnqQv1qi/G4QJEEvayNgCiFBEzcmAx3
	 Xuul6S2EJrmvQ==
From: Eric Biggers <ebiggers@kernel.org>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Add test for libbpf_sha256()
Date: Mon, 29 Sep 2025 12:27:21 -0700
Message-ID: <20250929192721.144640-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that libbpf_sha256() calculates SHA-256 digests correctly.

Tested with:
    make -C tools/testing/selftests/bpf/
    ./tools/testing/selftests/bpf/test_progs -t sha256 -v

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/sha256.c | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sha256.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sha256.c b/tools/testing/selftests/bpf/prog_tests/sha256.c
new file mode 100644
index 0000000000000..604a0b1423d55
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sha256.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2025 Google LLC */
+
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+
+#define MAX_LEN 4096
+
+/* Test libbpf_sha256() for all lengths from 0 to MAX_LEN inclusively. */
+void test_sha256(void)
+{
+	/*
+	 * The correctness of this value was verified by running this test with
+	 * libbpf_sha256() replaced by OpenSSL's SHA256().
+	 */
+	static const __u8 expected_digest_of_digests[SHA256_DIGEST_LENGTH] = {
+		0x62, 0x30, 0x0e, 0x1d, 0xea, 0x7f, 0xc4, 0x74,
+		0xfd, 0x8e, 0x64, 0x0b, 0xd8, 0x5f, 0xea, 0x04,
+		0xf3, 0xef, 0x77, 0x42, 0xc2, 0x01, 0xb8, 0x90,
+		0x6e, 0x19, 0x91, 0x1b, 0xca, 0xb3, 0x28, 0x42,
+	};
+	__u64 seed = 0;
+	__u8 *data = NULL, *digests = NULL;
+	__u8 digest_of_digests[SHA256_DIGEST_LENGTH];
+	size_t i;
+
+	data = malloc(MAX_LEN);
+	if (!ASSERT_OK_PTR(data, "malloc"))
+		goto out;
+	digests = malloc((MAX_LEN + 1) * SHA256_DIGEST_LENGTH);
+	if (!ASSERT_OK_PTR(digests, "malloc"))
+		goto out;
+
+	/* Generate MAX_LEN bytes of "random" data deterministically. */
+	for (i = 0; i < MAX_LEN; i++) {
+		seed = (seed * 25214903917 + 11) & ((1ULL << 48) - 1);
+		data[i] = (__u8)(seed >> 16);
+	}
+
+	/* Calculate a digest for each length 0 through MAX_LEN inclusively. */
+	for (i = 0; i <= MAX_LEN; i++)
+		libbpf_sha256(data, i, &digests[i * SHA256_DIGEST_LENGTH]);
+
+	/* Calculate and verify the digest of all the digests. */
+	libbpf_sha256(digests, (MAX_LEN + 1) * SHA256_DIGEST_LENGTH,
+		      digest_of_digests);
+	ASSERT_MEMEQ(digest_of_digests, expected_digest_of_digests,
+		     SHA256_DIGEST_LENGTH, "digest_of_digests");
+out:
+	free(data);
+	free(digests);
+}

base-commit: 4ef77dd584cfd915526328f516fec59e3a54d66e
-- 
2.51.0


