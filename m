Return-Path: <bpf+bounces-66984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E367CB3BDFD
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6C11C8001D
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6302E7F08;
	Fri, 29 Aug 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Fq9PkDql"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF819F115
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478225; cv=none; b=ZjGVF1ich9gmrq1MFUghsa6yViwFSGNtp5tcz505HD0Q5+ZSA84Od7dwlRtAL3nWWerjCP3Im+cJpwmLxUCwG1rj1P+hdtUP2tfiFrApOkyBhRMUQ9lfUcmgG4N8wDeROELT9UPnyYg09+fSi0tEtDfDRGNySy3zLSyxPNrsrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478225; c=relaxed/simple;
	bh=DXCe+elungflqXBwSMN9kd8YI3ZsM7YcO8N8QzUbAzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHq6j253knL0IuuxB4TXl4JflQY/xJQVCrBE2XyrDNaMQTaqzGYbe+r0UtgfkVe6Sk1KU9tnZ5aT/DwTxcBSGqafFRc7lK1pa2yY1fjglaLrcb3+agY5ZydW8boVTudueh62zy0YVw1GIoNLP9HO9SAMBh9gXcdOQ291oiMOJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Fq9PkDql; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RDbAgww2vIzU2P8a5yZbeXJjgjAlrlZI+RVmchdVFMI=; b=Fq9PkDqlcZVnUNKeoqef/j4w05
	AL6loFF4xi4A8HVwxs4hqhapD4Div+Zslc1tCQhKGlQXFYYWALeftf42DGFrBCVLPNXn2fJFeuoP6
	wRcuPA9hJMrLj5tarRsnwly8rbogMKPG4/bZ5d1fydncdYcKleXC9+oGVTf/YLzbDqcuTC+dtAl7r
	pa3vy4JznayQwlyCtZfMtfJvWHq6heVfVAFEeI4pJ50FXVf80y39caVw/T5LD19n4hBeZPpM0QYrR
	i/PIvek81ie5qhF7sXcPod+zmWk6jLGMli5MBIpl+vAaY8oGzvYNnYWjyRUuh5EXu4gMvCLjD3UJa
	e9suTK/Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1us0Dr-000CFs-0Q;
	Fri, 29 Aug 2025 16:36:59 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH bpf 2/2] selftests/bpf: Extend crypto_sanity selftest with invalid dst buffer
Date: Fri, 29 Aug 2025 16:36:57 +0200
Message-ID: <20250829143657.318524-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829143657.318524-1-daniel@iogearbox.net>
References: <20250829143657.318524-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27747/Fri Aug 29 10:27:03 2025)

Small cleanup and test extension to probe the bpf_crypto_{encrypt,decrypt}()
kfunc when a bad dst buffer is passed in to assert that an error is returned.

Also, encrypt_sanity() and skb_crypto_setup() were explicit to set the global
status variable to zero before any test, so do the same for decrypt_sanity().
Do not explicitly zero the on-stack err before bpf_crypto_ctx_create() given
the kfunc is expected to do it internally for the success case.

Before kernel fix:

  # ./vmtest.sh -- ./test_progs -t crypto
  [...]
  [    1.531200] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.533388] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #87/1    crypto_basic/crypto_release:OK
  #87/2    crypto_basic/crypto_acquire:OK
  #87      crypto_basic:OK
  test_crypto_sanity:PASS:skel open 0 nsec
  test_crypto_sanity:PASS:ip netns add crypto_sanity_ns 0 nsec
  test_crypto_sanity:PASS:ip -net crypto_sanity_ns -6 addr add face::1/128 dev lo nodad 0 nsec
  test_crypto_sanity:PASS:ip -net crypto_sanity_ns link set dev lo up 0 nsec
  test_crypto_sanity:PASS:open_netns 0 nsec
  test_crypto_sanity:PASS:AF_ALG init fail 0 nsec
  test_crypto_sanity:PASS:if_nametoindex lo 0 nsec
  test_crypto_sanity:PASS:skb_crypto_setup fd 0 nsec
  test_crypto_sanity:PASS:skb_crypto_setup 0 nsec
  test_crypto_sanity:PASS:skb_crypto_setup retval 0 nsec
  test_crypto_sanity:PASS:skb_crypto_setup status 0 nsec
  test_crypto_sanity:PASS:create qdisc hook 0 nsec
  test_crypto_sanity:PASS:make_sockaddr 0 nsec
  test_crypto_sanity:PASS:attach encrypt filter 0 nsec
  test_crypto_sanity:PASS:encrypt socket 0 nsec
  test_crypto_sanity:PASS:encrypt send 0 nsec
  test_crypto_sanity:FAIL:encrypt status unexpected error: -5 (errno 95)
  #88      crypto_sanity:FAIL
  Summary: 1/2 PASSED, 0 SKIPPED, 1 FAILED

After kernel fix:

  # ./vmtest.sh -- ./test_progs -t crypto
  [...]
  [    1.540963] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.542404] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #87/1    crypto_basic/crypto_release:OK
  #87/2    crypto_basic/crypto_acquire:OK
  #87      crypto_basic:OK
  #88      crypto_sanity:OK
  Summary: 2/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../selftests/bpf/progs/crypto_sanity.c       | 46 +++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c b/tools/testing/selftests/bpf/progs/crypto_sanity.c
index 645be6cddf36..dfd8a258f14a 100644
--- a/tools/testing/selftests/bpf/progs/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
@@ -14,7 +14,7 @@ unsigned char key[256] = {};
 u16 udp_test_port = 7777;
 u32 authsize, key_len;
 char algo[128] = {};
-char dst[16] = {};
+char dst[16] = {}, dst_bad[8] = {};
 int status;
 
 static int skb_dynptr_validate(struct __sk_buff *skb, struct bpf_dynptr *psrc)
@@ -59,10 +59,9 @@ int skb_crypto_setup(void *ctx)
 		.authsize = authsize,
 	};
 	struct bpf_crypto_ctx *cctx;
-	int err = 0;
+	int err;
 
 	status = 0;
-
 	if (key_len > 256) {
 		status = -EINVAL;
 		return 0;
@@ -70,8 +69,8 @@ int skb_crypto_setup(void *ctx)
 
 	__builtin_memcpy(&params.algo, algo, sizeof(algo));
 	__builtin_memcpy(&params.key, key, sizeof(key));
-	cctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
 
+	cctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
 	if (!cctx) {
 		status = err;
 		return 0;
@@ -80,7 +79,6 @@ int skb_crypto_setup(void *ctx)
 	err = crypto_ctx_insert(cctx);
 	if (err && err != -EEXIST)
 		status = err;
-
 	return 0;
 }
 
@@ -92,6 +90,7 @@ int decrypt_sanity(struct __sk_buff *skb)
 	struct bpf_dynptr psrc, pdst;
 	int err;
 
+	status = 0;
 	err = skb_dynptr_validate(skb, &psrc);
 	if (err < 0) {
 		status = err;
@@ -110,13 +109,23 @@ int decrypt_sanity(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	/* dst is a global variable to make testing part easier to check. In real
-	 * production code, a percpu map should be used to store the result.
+	/* Check also bad case where the dst buffer is smaller than the
+	 * skb's linear section.
+	 */
+	bpf_dynptr_from_mem(dst_bad, sizeof(dst_bad), 0, &pdst);
+	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, NULL);
+	if (!status)
+		status = -EIO;
+	if (status != -EINVAL)
+		goto err;
+
+	/* dst is a global variable to make testing part easier to check.
+	 * In real production code, a percpu map should be used to store
+	 * the result.
 	 */
 	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
-
 	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, NULL);
-
+err:
 	return TC_ACT_SHOT;
 }
 
@@ -129,7 +138,6 @@ int encrypt_sanity(struct __sk_buff *skb)
 	int err;
 
 	status = 0;
-
 	err = skb_dynptr_validate(skb, &psrc);
 	if (err < 0) {
 		status = err;
@@ -148,13 +156,23 @@ int encrypt_sanity(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	/* dst is a global variable to make testing part easier to check. In real
-	 * production code, a percpu map should be used to store the result.
+	/* Check also bad case where the dst buffer is smaller than the
+	 * skb's linear section.
+	 */
+	bpf_dynptr_from_mem(dst_bad, sizeof(dst_bad), 0, &pdst);
+	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, NULL);
+	if (!status)
+		status = -EIO;
+	if (status != -EINVAL)
+		goto err;
+
+	/* dst is a global variable to make testing part easier to check.
+	 * In real production code, a percpu map should be used to store
+	 * the result.
 	 */
 	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
-
 	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, NULL);
-
+err:
 	return TC_ACT_SHOT;
 }
 
-- 
2.43.0


