Return-Path: <bpf+bounces-70060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31ABAE9DF
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 23:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2314D170B9E
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFE729D268;
	Tue, 30 Sep 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiYJMWJm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F029D295
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267613; cv=none; b=WMoNMcjqPn0ym/+vzy3i7PmJDftzkEbqAGmnI9XvNpu4fP4NFZRvtZvjZGz3YKJ+gXptbXwFQ2/T7LFDDMucQSa755/M33b6grKlofB7I/eIckwyj36sjGI1pYgt+PT6Fok07KSHndyBpOgD0FNLxhFZ+eHFXJzSxsMArUZdSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267613; c=relaxed/simple;
	bh=qgTcBPKmqH9hFUCtm4cJl0MvK7CA2MqIVISE0URU7dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVW77J3muoDA5gb+s7uli4NU03jIhWNlafxJp1V837XLLzi5jPLiruKDy7tKtfWG/yHjyvUWKVDzop3c0nZ4N3CwyrvEKJsSU4iOYPXlZG9V21ym+wv5RcXFbQGh7RJXvbfYY9GYUVqT+rb2a/bTslhHZRfx9JX7Ap1wI4atEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiYJMWJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813DBC4CEF0;
	Tue, 30 Sep 2025 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759267612;
	bh=qgTcBPKmqH9hFUCtm4cJl0MvK7CA2MqIVISE0URU7dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiYJMWJmSlqaUorUSPSiu0LW+6d7AbKQT7upYnumWP2iYAaYPMw3BLepJ1kqhVDl9
	 kmMXS3KdcPGdKvolaktVzcRT4o9LHk7ScisnCrstjd3T/OMCeua21xRGzycaYtzUgu
	 cG5Hnhocm9rBdC85Q7CfSaTu0P+1X1HkFeoGxfHwQgtsuU08dRzhE2Gh9H7LGXYv+o
	 cGr7/UhkDcF93T6ViOSTzBxn92TyEeMNIpcKeW3v4RXCSalobDePbX7j92LEjXGD4k
	 F8RYEularW27a8mhdSYpe04hQniBpR1ruWZ5WwXL2QN/ISPqP0nxAu7vf8MVzp+q1o
	 Lbhv8P4MZ89fw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 4/5] libbpf: move libbpf_sha256() implementation into libbpf_utils.c
Date: Tue, 30 Sep 2025 14:26:18 -0700
Message-ID: <20250930212619.1645410-5-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930212619.1645410-1-andrii@kernel.org>
References: <20250930212619.1645410-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sha256 implementation out of already large and unwieldy libbpf.c
into libbpf_utils.c where we'll keep reusable helpers.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 98 ---------------------------------
 tools/lib/bpf/libbpf_internal.h |  5 ++
 tools/lib/bpf/libbpf_utils.c    | 95 ++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 98 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6d19e0db492c..dd3b2f57082d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -35,7 +35,6 @@
 #include <linux/perf_event.h>
 #include <linux/bpf_perf_event.h>
 #include <linux/ring_buffer.h>
-#include <linux/unaligned.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
@@ -14282,100 +14281,3 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
-
-static inline __u32 ror32(__u32 v, int bits)
-{
-	return (v >> bits) | (v << (32 - bits));
-}
-
-#define SHA256_BLOCK_LENGTH 64
-#define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
-#define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
-#define Sigma_0(x) (ror32((x), 2) ^ ror32((x), 13) ^ ror32((x), 22))
-#define Sigma_1(x) (ror32((x), 6) ^ ror32((x), 11) ^ ror32((x), 25))
-#define sigma_0(x) (ror32((x), 7) ^ ror32((x), 18) ^ ((x) >> 3))
-#define sigma_1(x) (ror32((x), 17) ^ ror32((x), 19) ^ ((x) >> 10))
-
-static const __u32 sha256_K[64] = {
-	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
-	0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
-	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
-	0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
-	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
-	0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
-	0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
-	0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
-	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
-	0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
-	0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
-};
-
-#define SHA256_ROUND(i, a, b, c, d, e, f, g, h)                                \
-	{                                                                      \
-		__u32 tmp = h + Sigma_1(e) + Ch(e, f, g) + sha256_K[i] + w[i]; \
-		d += tmp;                                                      \
-		h = tmp + Sigma_0(a) + Maj(a, b, c);                           \
-	}
-
-static void sha256_blocks(__u32 state[8], const __u8 *data, size_t nblocks)
-{
-	while (nblocks--) {
-		__u32 a = state[0];
-		__u32 b = state[1];
-		__u32 c = state[2];
-		__u32 d = state[3];
-		__u32 e = state[4];
-		__u32 f = state[5];
-		__u32 g = state[6];
-		__u32 h = state[7];
-		__u32 w[64];
-		int i;
-
-		for (i = 0; i < 16; i++)
-			w[i] = get_unaligned_be32(&data[4 * i]);
-		for (; i < ARRAY_SIZE(w); i++)
-			w[i] = sigma_1(w[i - 2]) + w[i - 7] +
-			       sigma_0(w[i - 15]) + w[i - 16];
-		for (i = 0; i < ARRAY_SIZE(w); i += 8) {
-			SHA256_ROUND(i + 0, a, b, c, d, e, f, g, h);
-			SHA256_ROUND(i + 1, h, a, b, c, d, e, f, g);
-			SHA256_ROUND(i + 2, g, h, a, b, c, d, e, f);
-			SHA256_ROUND(i + 3, f, g, h, a, b, c, d, e);
-			SHA256_ROUND(i + 4, e, f, g, h, a, b, c, d);
-			SHA256_ROUND(i + 5, d, e, f, g, h, a, b, c);
-			SHA256_ROUND(i + 6, c, d, e, f, g, h, a, b);
-			SHA256_ROUND(i + 7, b, c, d, e, f, g, h, a);
-		}
-		state[0] += a;
-		state[1] += b;
-		state[2] += c;
-		state[3] += d;
-		state[4] += e;
-		state[5] += f;
-		state[6] += g;
-		state[7] += h;
-		data += SHA256_BLOCK_LENGTH;
-	}
-}
-
-void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH])
-{
-	__u32 state[8] = { 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
-			   0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19 };
-	const __be64 bitcount = cpu_to_be64((__u64)len * 8);
-	__u8 final_data[2 * SHA256_BLOCK_LENGTH] = { 0 };
-	size_t final_len = len % SHA256_BLOCK_LENGTH;
-	int i;
-
-	sha256_blocks(state, data, len / SHA256_BLOCK_LENGTH);
-
-	memcpy(final_data, data + len - final_len, final_len);
-	final_data[final_len] = 0x80;
-	final_len = round_up(final_len + 9, SHA256_BLOCK_LENGTH);
-	memcpy(&final_data[final_len - 8], &bitcount, 8);
-
-	sha256_blocks(state, final_data, final_len / SHA256_BLOCK_LENGTH);
-
-	for (i = 0; i < ARRAY_SIZE(state); i++)
-		put_unaligned_be32(state[i], &out[4 * i]);
-}
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index a8f204139371..35b2527bedec 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -722,6 +722,11 @@ static inline bool is_pow_of_2(size_t x)
 	return x && (x & (x - 1)) == 0;
 }
 
+static inline __u32 ror32(__u32 v, int bits)
+{
+	return (v >> bits) | (v << (32 - bits));
+}
+
 #define PROG_LOAD_ATTEMPTS 5
 int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
 
diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
index ee3013e9b77c..f8290a0b3aaf 100644
--- a/tools/lib/bpf/libbpf_utils.c
+++ b/tools/lib/bpf/libbpf_utils.c
@@ -11,6 +11,9 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
+#include <inttypes.h>
+#include <linux/kernel.h>
+#include <linux/unaligned.h>
 
 #include "libbpf.h"
 #include "libbpf_internal.h"
@@ -145,3 +148,95 @@ const char *libbpf_errstr(int err)
 		return buf;
 	}
 }
+
+#define SHA256_BLOCK_LENGTH 64
+#define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
+#define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
+#define Sigma_0(x) (ror32((x), 2) ^ ror32((x), 13) ^ ror32((x), 22))
+#define Sigma_1(x) (ror32((x), 6) ^ ror32((x), 11) ^ ror32((x), 25))
+#define sigma_0(x) (ror32((x), 7) ^ ror32((x), 18) ^ ((x) >> 3))
+#define sigma_1(x) (ror32((x), 17) ^ ror32((x), 19) ^ ((x) >> 10))
+
+static const __u32 sha256_K[64] = {
+	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
+	0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
+	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
+	0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
+	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
+	0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
+	0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
+	0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
+	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
+	0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
+	0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
+};
+
+#define SHA256_ROUND(i, a, b, c, d, e, f, g, h)                                \
+	{                                                                      \
+		__u32 tmp = h + Sigma_1(e) + Ch(e, f, g) + sha256_K[i] + w[i]; \
+		d += tmp;                                                      \
+		h = tmp + Sigma_0(a) + Maj(a, b, c);                           \
+	}
+
+static void sha256_blocks(__u32 state[8], const __u8 *data, size_t nblocks)
+{
+	while (nblocks--) {
+		__u32 a = state[0];
+		__u32 b = state[1];
+		__u32 c = state[2];
+		__u32 d = state[3];
+		__u32 e = state[4];
+		__u32 f = state[5];
+		__u32 g = state[6];
+		__u32 h = state[7];
+		__u32 w[64];
+		int i;
+
+		for (i = 0; i < 16; i++)
+			w[i] = get_unaligned_be32(&data[4 * i]);
+		for (; i < ARRAY_SIZE(w); i++)
+			w[i] = sigma_1(w[i - 2]) + w[i - 7] +
+			       sigma_0(w[i - 15]) + w[i - 16];
+		for (i = 0; i < ARRAY_SIZE(w); i += 8) {
+			SHA256_ROUND(i + 0, a, b, c, d, e, f, g, h);
+			SHA256_ROUND(i + 1, h, a, b, c, d, e, f, g);
+			SHA256_ROUND(i + 2, g, h, a, b, c, d, e, f);
+			SHA256_ROUND(i + 3, f, g, h, a, b, c, d, e);
+			SHA256_ROUND(i + 4, e, f, g, h, a, b, c, d);
+			SHA256_ROUND(i + 5, d, e, f, g, h, a, b, c);
+			SHA256_ROUND(i + 6, c, d, e, f, g, h, a, b);
+			SHA256_ROUND(i + 7, b, c, d, e, f, g, h, a);
+		}
+		state[0] += a;
+		state[1] += b;
+		state[2] += c;
+		state[3] += d;
+		state[4] += e;
+		state[5] += f;
+		state[6] += g;
+		state[7] += h;
+		data += SHA256_BLOCK_LENGTH;
+	}
+}
+
+void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH])
+{
+	__u32 state[8] = { 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
+			   0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19 };
+	const __be64 bitcount = cpu_to_be64((__u64)len * 8);
+	__u8 final_data[2 * SHA256_BLOCK_LENGTH] = { 0 };
+	size_t final_len = len % SHA256_BLOCK_LENGTH;
+	int i;
+
+	sha256_blocks(state, data, len / SHA256_BLOCK_LENGTH);
+
+	memcpy(final_data, data + len - final_len, final_len);
+	final_data[final_len] = 0x80;
+	final_len = round_up(final_len + 9, SHA256_BLOCK_LENGTH);
+	memcpy(&final_data[final_len - 8], &bitcount, 8);
+
+	sha256_blocks(state, final_data, final_len / SHA256_BLOCK_LENGTH);
+
+	for (i = 0; i < ARRAY_SIZE(state); i++)
+		put_unaligned_be32(state[i], &out[4 * i]);
+}
-- 
2.47.3


