Return-Path: <bpf+bounces-46058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD839E32BF
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 05:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFE4282DA8
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F4017DFFD;
	Wed,  4 Dec 2024 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkMyIGjo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92A13A409
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287689; cv=none; b=iobjG28R6L/3KYAQ7W/zHkmosPGM1GqU7yLBu0ariDmZEFmLbfWo1wAyGaHwGI4rb9w8/byOafxFc7LMqDie2vPhzQ1a0yRAcdJ6C5L9f514e9NHC5syrsTsO2rPgfrMDHb3IffIx2DFYKPYB84byvm3MRAQXjlOqBQWiMryxqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287689; c=relaxed/simple;
	bh=cus25vwv5PBT+UkSlVsZSL89g1Dj1ZctmIyYjrEfAcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8sZ9motK/vO/oxlSnmslWEXkFd4DZAC4EkoqtYbZcn7fWPvjaN8TfOq8YujYb5MRa9QWfvgHOlWzIEX+/3IummuhPkju8M2eQ3Pz90dqK7Jn5YPc5avhWHuvemqcfs0eYl6Ua/d3GSKE4+AViXsYhQas0ksysTUjQxCarbqaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkMyIGjo; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a736518eso77344435e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 20:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733287684; x=1733892484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBMNIJ7E3at74h2O41m5yjnbsTv9InkCA6bR0cP4q0k=;
        b=HkMyIGjoMoOzAS0VroHGMf/rWZuKHikjHzX96JlJf6JcB9AzG92BzjYkS/hQ+bndr5
         9u30I0nxRDBz4OpxCAV8kim2rdcSDdl6gwLxk9IQj28uTzM4ThFtLdIyoWAbA7TLO4ct
         X7RwqXXyOsFraQCLdAmb0ex+UWeRlRmmouPxKhuy1IX5ELVn3Qv0cKZP0ao7+/IFVX3H
         rF5gDbhwED1/OgrNr2IxQ/dW6cm6Tzxdn8NHTQAryifLEJ9HecMmXtzyVk61WsVnsrZk
         VJPartgAJsODtiVrudeZv46x+6dDI2R1UjvQNbfq8l8/4w37eWdIJE8U77WrzHO46sIg
         Rnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733287684; x=1733892484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBMNIJ7E3at74h2O41m5yjnbsTv9InkCA6bR0cP4q0k=;
        b=MVDgZ2uxSjOZPrW9X2wyIusGYhPKYFWQyqN4ivnr/501W4cceecQjGAQYCqM04V5k0
         lWiEy+7HI9a/ZzqBkB2WEeTL6vwlHrynu6nCiSLXp8GH44GfA7/4JUFO4YPDo7FY0OlK
         i52y+Gs7+3mZnTqR1MiPBT/hxq+SBhN+l0JDQDk6ty1zUccej4BvoTh9XR9QGkSXNxgT
         hCuZDqfeGjd0F3JQlQNXe24DwOLFrK/BCTucx/Dy9IKmjP4Lj/sbOCVyjQSD9eItg+2s
         Xra4Gzq/oMBi/LZYID+Zq2URVNxPALPNo6a2Hc49diZizb5TT/D1YlMLrEmv7qdVFtLb
         xKMw==
X-Gm-Message-State: AOJu0Yw1UAABja5jNh2Un6epV9msHi/3c3QAcnvrvLEYE93KwKEGKbKd
	Yj6uRNTCNE7CmCgAzUmjPZB4OJ4UcjmwQRFS+Hy+JTk7HNw8hMztZOtQT8pTjYQ=
X-Gm-Gg: ASbGncsNLCjse4+Z+gIt2pRirfaaX3nSmzesYK7EgrXmg25NSJrLA0+UNvKncBp6Q2U
	vVCMdU8IdPyeu10/lMS/sTfJzW7sB6xGC3WUX/qKgkgvH9EmX1PbsRFGO/5vepmtj3NzWlv2TLx
	+YbTYfUJ1V5mhGSiX0gsdh2XsDNvUyDl21Q+BAwl/DSUj0c0zG0FQwxJc4wdWJhE2H4c8in7hAt
	iIi495JmqSRpzTt0q53s3Ae5Bq5tH5lB7U35Yg5B9kiTXdwVZV1VAL1sdOIoQvCKmBzj4mtf2JQ
	cg==
X-Google-Smtp-Source: AGHT+IHvg+ZXBKSxvfod3eP843soaBPGD2xbdXgrsyc5EK5/185N+UzVDksmjtFzA4RcBs766e2aVQ==
X-Received: by 2002:a05:600c:4f03:b0:434:a852:ba77 with SMTP id 5b1f17b1804b1-434d09d0432mr48070555e9.15.1733287683678;
        Tue, 03 Dec 2024 20:48:03 -0800 (PST)
Received: from localhost (fwdproxy-cln-112.fbsv.net. [2a03:2880:31ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a710sm17005813f8f.57.2024.12.03.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:48:02 -0800 (PST)
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
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v4 3/5] selftests/bpf: Introduce __caps_unpriv annotation for tests
Date: Tue,  3 Dec 2024 20:47:55 -0800
Message-ID: <20241204044757.1483141-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204044757.1483141-1-memxor@gmail.com>
References: <20241204044757.1483141-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7508; i=memxor@gmail.com; h=from:subject; bh=B0YfKWpxO5lLY+pZW7PE+2YsYxRNwAAS3dXH5V8Xc6M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT97Ght3U3pVKXpxegX7tzWR3ZlDTLwi5Ps1m2M92 vMEsreWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/exgAKCRBM4MiGSL8Ryrp+D/ 9XqPL+zlkuzL2RvuP3UrGNuslbFjon1G1K0bOV6tHgatRGfsoadWEJghtSC5vNXEXkTpzg6+QUdPx8 Ifm5Qxut7qmw//25miInPzCQ9HT2mxLALB4vo3HBM95Qo5tzlhmkCcEgehnGvJu5s8jpZ4N/w+qFG8 bjHmjmcYm8QMnD6LO43KJqptV0vQez+R8ADunkgZYS9TZTaxe2cYDX2LzZPVeXxbYJQZ1pEpvhdptY kwALQo5AUO1oDTFEibsrvOnfwFfDfPe6pl3Q0HLqs/myhAjQOKBR04a8YmBV/AvJ57nAoc3vlMFYpo HiWFf5A2G8Q6Rlz/pFwbjND8gY2MnFF5xEkAufffJTJuwcdxYvsYqaxLBuKqcNXu8jeRmisg50ybM3 jX0d74byCGtqawATu9YoBpVdKFKh9jFQNFMVcqExWzDGPYevAIgy/qUIlN7PPT8crv5v6d2sM1AlPW jb9/vTE4hgJU4B9iyQm0Bi5gercHBed00QNr0BLgkFqXNi8MfofICEAt4i1vaNXJiokjxA7CRHot2t ZOw7EFW7f8P9UahfdBAOywmKiWLng114GHuUjvlTuUaCxKhagKSRfNmYPGVyEh8qAlgAD6LpbD6D8J XyXpUzaKdjcZ7sC4VDDwHrdBJ/p0/UMCq0ym0JxUPvioeDyV6QZWNz1ie37g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Add a __caps_unpriv annotation so that tests requiring specific
capabilities while dropping the rest can conveniently specify them
during selftest declaration instead of munging with capabilities at
runtime from the testing binary.

While at it, let us convert test_verifier_mtu to use this new support
instead.

Since we do not want to include linux/capability.h, we only defined the
four main capabilities BPF subsystem deals with in bpf_misc.h for use in
tests. If the user passes a CAP_SYS_NICE or anything else that's not
defined in the header, capability parsing code will return a warning.

Also reject strtol returning 0. CAP_CHOWN = 0 but we'll never need to
use it, and strtol doesn't errno on failed conversion. Fail the test in
such a case.

The original diff for this idea is available at link [0].

  [0]: https://lore.kernel.org/bpf/a1e48f5d9ae133e19adc6adf27e19d585e06bab4.camel@gmail.com

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
[ Kartikeya: rebase on bpf-next, add warn to parse_caps, convert test_verifier_mtu ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       | 19 +-------
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 12 +++++
 .../selftests/bpf/progs/verifier_mtu.c        |  4 +-
 tools/testing/selftests/bpf/test_loader.c     | 46 +++++++++++++++++++
 4 files changed, 62 insertions(+), 19 deletions(-)

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
index eccaf955e394..f45f4352feeb 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -5,6 +5,10 @@
 #define XSTR(s) STR(s)
 #define STR(s) #s
 
+/* Expand a macro and then stringize the expansion */
+#define QUOTE(str) #str
+#define EXPAND_QUOTE(str) QUOTE(str)
+
 /* This set of attributes controls behavior of the
  * test_loader.c:test_loader__run_subtests().
  *
@@ -106,6 +110,7 @@
  * __arch_*          Specify on which architecture the test case should be tested.
  *                   Several __arch_* annotations could be specified at once.
  *                   When test case is not run on current arch it is marked as skipped.
+ * __caps_unpriv     Specify the capabilities that should be set when running the test.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
@@ -129,6 +134,13 @@
 #define __arch_x86_64		__arch("X86_64")
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
+#define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
+
+/* Define common capabilities tested using __caps_unpriv */
+#define CAP_NET_ADMIN		12
+#define CAP_SYS_ADMIN		21
+#define CAP_PERFMON		38
+#define CAP_BPF			39
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/progs/verifier_mtu.c b/tools/testing/selftests/bpf/progs/verifier_mtu.c
index 70c7600a26a0..4ccf1ebc42d1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_mtu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_mtu.c
@@ -6,7 +6,9 @@
 
 SEC("tc/ingress")
 __description("uninit/mtu: write rejected")
-__failure __msg("invalid indirect read from stack")
+__success
+__caps_unpriv(CAP_BPF|CAP_NET_ADMIN)
+__failure_unpriv __msg_unpriv("invalid indirect read from stack")
 int tc_uninit_mtu(struct __sk_buff *ctx)
 {
 	__u32 mtu;
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3e9b009580d4..53b06647cf57 100644
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
@@ -276,6 +278,37 @@ static int parse_int(const char *str, int *val, const char *name)
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
+		if (!strncmp("CAP_", token, sizeof("CAP_") - 1)) {
+			PRINT_FAIL("define %s constant in bpf_misc.h, failed to parse caps\n", token);
+			return -EINVAL;
+		}
+		cap_flag = strtol(token, NULL, 10);
+		if (!cap_flag || errno) {
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
@@ -541,6 +574,12 @@ static int parse_test_spec(struct test_loader *tester,
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
 
@@ -917,6 +956,13 @@ void run_subtest(struct test_loader *tester,
 			test__end_subtest();
 			return;
 		}
+		if (subspec->caps) {
+			err = cap_enable_effective(subspec->caps, NULL);
+			if (err) {
+				PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(err));
+				goto subtest_cleanup;
+			}
+		}
 	}
 
 	/* Implicitly reset to NULL if next test case doesn't specify */
-- 
2.43.5


