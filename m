Return-Path: <bpf+bounces-45919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA749DFC0C
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3540281CF8
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFC71F9F63;
	Mon,  2 Dec 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDcjEmGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F711F9F47
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128703; cv=none; b=sljon4I1JLxp2y/bi+45ZyLX35NXJjFS39pFkSqzR4G+vEBmrbfa5MSIFaQqNjW6frwWtzBZ++COXTWwOs6CFmUKJg04FS4tdS4SA3TrWojUuK4Nt+045cY7LS5NcXPO/8NHEWvDBJqarFKwfD2Waa24LLecHei9RGeXBOtvaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128703; c=relaxed/simple;
	bh=rOJw+8D1KBgKbyd/PvbKSgkm0K4bIXQsue4PbVNzj80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZuHsADVUxilbPjaLJtzPGGJduDSqatnu34am498wNtegOlp0WWZO0zENwOsVO6Co2Wb28xvVrqNNftSPWDZzpJDRv5wYmh0hBJeFD6l1AypdJ9pmbwEuS9SOy5vwwdQjIzczfunYMd8l0Lio91qXDxIH+TmyhZJzhSaINfve4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDcjEmGx; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso32805545e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 00:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733128700; x=1733733500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyFMKAQH+vfZKPjYMh2i7WVy9DY6zU2NazglKYcnS7M=;
        b=cDcjEmGxyCv1MZg9tuZfgFrnhoqsF2+K3SgNbQ7Oux9gyX5i3+6z2RGV7T//nS6T8B
         ay5x2wMpLuD8MX0kUk1PJ7H9ma5+ZpHMClsc4hGLUnyOl/x+MfOhCgqVEGHB8A+k/6z4
         DDCmtiU3PPtDdrNUuoLbwMVRC9pIIyNfZsgE49JvZ/4INf+0cpLVUGl6H/WvVeMokZMm
         HW3AX+Km41LXw9mYStWLHUDvtQ+r24ZRP3utjbVrcn3osytnI3fQgsl44AIhEcBvrprp
         199ygA5Llke2hc2G4/6p+/xI/4qBBsZW48oVq7tVb6TKAhUXSX3Ew0zPmYs8MRqX0IBq
         iilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128700; x=1733733500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyFMKAQH+vfZKPjYMh2i7WVy9DY6zU2NazglKYcnS7M=;
        b=MOzsm7evCjoFZWU02Yp8HpuNLHKcpFhbbZBFqe1OrGqin7c1K5c7bq1H4QBvNTwcz3
         aS88fx7GN9/iUNo35fTNJMR+OWRmviCowbi89oKsCaMPSd9LsA2obo3lRGN0ZePdXNT8
         xk37E5qZp8tUmhrgkAe01yDJt16k4vJ9KNYaNbJRuxf0t2ybtpZhTxtBDH4kGPu6Kn/6
         jz7vtyIOW1orfGaLYnI6FptkvZngLXl1dupamzDxXkUBr1lKsiCG9+IP+c8D2zZnRsB5
         8Kmq1ZDCavJJexSTEP9tnx+LYK1ymLMbSJtJzREuXcFFhoZvORLKUhnlM5qlyUV/aUxX
         aI4w==
X-Gm-Message-State: AOJu0YxqrLnAKhtOhd7mrKJxMfG6mNo2x8JpNmlIYeEWiB0hiFe5vb5V
	8PGlBbXabScnb0dZpoQrPoAyFbdpZzMgW/qtDqulwOYtCGDu167zB0N0IwUaDWc=
X-Gm-Gg: ASbGnctWBCcOLSj4qCvUdgBcZGvaEVE36GNxhQwhacHvgNOEju7C+418ybF3p5kL8fH
	baj1YgMPTFCIhq4fn5Evp01Rgr8HrLKagl9qsygI8/Zh+3rHK7DeYt6kYZGUXx1IhyWbfS/iXq0
	dEDYkSGiOvDqTcjQnzFze+3CI5R0CHbPnvv0mYiCEQ5Fvzblahnhm0DoleakLApAUxy3iSK1lbx
	05I0ojdjde5F5iivYJ084qf30PxCHOyGWNXFxiy3EhxAGeuyXhcwuh3EgwJy1kYt3qE5RchVdSd
	YQ==
X-Google-Smtp-Source: AGHT+IEdgbwEq3elQiQXjU2DkkqEzcvoWlvH8MohDf8oAdcM7otMEUB+WAcLM5hKYSJB8ZCIUJB/YA==
X-Received: by 2002:a05:600c:4f12:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-434a9db8171mr206503535e9.4.1733128699622;
        Mon, 02 Dec 2024 00:38:19 -0800 (PST)
Received: from localhost (fwdproxy-cln-033.fbsv.net. [2a03:2880:31ff:21::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d26b5sm174583335e9.35.2024.12.02.00.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:38:19 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Introduce __caps_unpriv annotation for tests
Date: Mon,  2 Dec 2024 00:38:12 -0800
Message-ID: <20241202083814.1888784-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241202083814.1888784-1-memxor@gmail.com>
References: <20241202083814.1888784-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6375; i=memxor@gmail.com; h=from:subject; bh=U62+fxodhxglrXh9TNGKlIpaS7jvsh0J+Sl94Vgvjdw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTXG0l4E8mtmSMqHl8P3bOo8clFEq4YdqXIoGr+r0 eCvHANKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ01xtAAKCRBM4MiGSL8Ryg8zD/ wPNOaloqWcEy7s6zfhoioNi4rmaCnSe0YGJcLv0pO2zs92xfROFKxzrR+6G+vMwoT5y7HH3Iskk3gU 9049iD3omIPIeW8FQ4GZ2TpnWdGPeVE6EzxppcN5xkKe1UXlvPqBtEj3+nNF+GAM9v0ZHUeL4RdaMu nsOFs5UI0PqGecsVCKPb7Yd0USzdfOJjTK3ntQvdzNOoA78/VIOJAGAXYUx2CZ0myyKEI/7v/J+0Qq xkuWGqawfxD7pjih0EVBwOEaPVQ0ndpzaKcOKNGmjnEV/BFW+O4MPR47dEQaQlU2WqdRSN5PObFgzr Q9TJDz966+9hxMyQBFI4b855hnDdDZxiNFva69OanMFyqWxPxRdcown3oILWGLot+Y4SdUwUm6TTAN PMPOmIQsbkSuuyHqoHeq67AJ+jd5PaYBJoLIt84X6unvtnSQd/2ENYiXv7RUFhExYolWm7tNQ00RBw WAQyJmvvG/qcKhv79gAOqFL4z3PX4XYvRh9m7/U551pDMe7tVIIbkif8Jj15YOWg8TTUWQ9AglZnxy JmB5FBmC0ZkXtBL6oZQhNaZT+0hhGG8fwBLOLpgTLXDRV298jEGvOYuZz/YUhGqzddL7Cj6Vf5engX uuzkh2Tlx/OHtLJ8yQ6mkSBF3xUTALLyKoH0vszGggFKjyOCVLYFUhvy05fQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Add a __caps_unpriv annotation so that tests requiring specific
capabilities while dropping the rest can conveniently specify them
during selftest declaration instead of munging with capabilities at
runtime from the testing binary.

While at it, let us convert test_verifier_mtu to use this new support
instead.

The original diff for this idea is available at link [0].

  [0]: https://lore.kernel.org/bpf/a1e48f5d9ae133e19adc6adf27e19d585e06bab4.camel@gmail.com

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
[ Kartikeya: rebase on bpf-next, remove unnecessary bits, convert test_verifier_mtu ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       | 19 +--------
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  2 +
 .../selftests/bpf/progs/verifier_mtu.c        |  3 +-
 tools/testing/selftests/bpf/test_loader.c     | 41 +++++++++++++++++++
 4 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d9f65adb456b..3ee40ee9413a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -225,24 +225,7 @@ void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
-
-void test_verifier_mtu(void)
-{
-	__u64 caps = 0;
-	int ret;
-
-	/* In case CAP_BPF and CAP_PERFMON is not set */
-	ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, &caps);
-	if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
-		return;
-	ret = cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFMON, NULL);
-	if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
-		goto restore_cap;
-	RUN(verifier_mtu);
-restore_cap:
-	if (caps)
-		cap_enable_effective(caps, NULL);
-}
+void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index eccaf955e394..cd9dd427a91d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -106,6 +106,7 @@
  * __arch_*          Specify on which architecture the test case should be tested.
  *                   Several __arch_* annotations could be specified at once.
  *                   When test case is not run on current arch it is marked as skipped.
+ * __caps_unpriv     Specify the capabilities that should be set when running the test
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
@@ -129,6 +130,7 @@
 #define __arch_x86_64		__arch("X86_64")
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
+#define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" XSTR(caps))))
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/progs/verifier_mtu.c b/tools/testing/selftests/bpf/progs/verifier_mtu.c
index 70c7600a26a0..88b1fa5f6030 100644
--- a/tools/testing/selftests/bpf/progs/verifier_mtu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_mtu.c
@@ -6,7 +6,8 @@
 
 SEC("tc/ingress")
 __description("uninit/mtu: write rejected")
-__failure __msg("invalid indirect read from stack")
+__success __failure_unpriv __msg_unpriv("invalid indirect read from stack")
+__caps_unpriv(CAP_BPF)
 int tc_uninit_mtu(struct __sk_buff *ctx)
 {
 	__u32 mtu;
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3e9b009580d4..d693e1fc6fa5 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -36,6 +36,7 @@
 #define TEST_TAG_ARCH "comment:test_arch="
 #define TEST_TAG_JITED_PFX "comment:test_jited="
 #define TEST_TAG_JITED_PFX_UNPRIV "comment:test_jited_unpriv="
+#define TEST_TAG_CAPS_UNPRIV "comment:test_caps_unpriv="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -74,6 +75,7 @@ struct test_subspec {
 	struct expected_msgs jited;
 	int retval;
 	bool execute;
+	__u64 caps;
 };
 
 struct test_spec {
@@ -276,6 +278,33 @@ static int parse_int(const char *str, int *val, const char *name)
 	return 0;
 }
 
+static int parse_caps(const char *str, __u64 *val, const char *name)
+{
+	int cap_flag = 0;
+	char *token = NULL, *saveptr = NULL;
+
+	char *str_cpy = strdup(str);
+	if (str_cpy == NULL) {
+		PRINT_FAIL("Memory allocation failed\n");
+		return -EINVAL;
+	}
+
+	token = strtok_r(str_cpy, "|", &saveptr);
+	while (token != NULL) {
+		errno = 0;
+		cap_flag = strtol(token, NULL, 10);
+		if (errno) {
+			PRINT_FAIL("failed to parse caps %s\n", name);
+			return -EINVAL;
+		}
+		*val |= (1ULL << cap_flag);
+		token = strtok_r(NULL, "|", &saveptr);
+	}
+
+	free(str_cpy);
+	return 0;
+}
+
 static int parse_retval(const char *str, int *val, const char *name)
 {
 	struct {
@@ -541,6 +570,12 @@ static int parse_test_spec(struct test_loader *tester,
 			jit_on_next_line = true;
 		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
 			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
+		} else if (str_has_pfx(s, TEST_TAG_CAPS_UNPRIV)) {
+			val = s + sizeof(TEST_TAG_CAPS_UNPRIV) - 1;
+			err = parse_caps(val, &spec->unpriv.caps, "test caps");
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
 		}
 	}
 
@@ -917,6 +952,12 @@ void run_subtest(struct test_loader *tester,
 			test__end_subtest();
 			return;
 		}
+		if (subspec->caps) {
+			err = cap_enable_effective(subspec->caps, NULL);
+			if (err)
+				PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(err));
+			goto subtest_cleanup;
+		}
 	}
 
 	/* Implicitly reset to NULL if next test case doesn't specify */
-- 
2.43.5


