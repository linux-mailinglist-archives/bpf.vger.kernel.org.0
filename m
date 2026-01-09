Return-Path: <bpf+bounces-78282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB93D07D1E
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 09:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E83030AF9DA
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8941933FE1F;
	Fri,  9 Jan 2026 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfm24XKT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8B33CEAF
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947224; cv=none; b=iYmKCpE2s1axeq3iN9FJIq2JHwNO34zeiAqt5nX3/oeNgUgI5fSzN38lwH3G7Q1FED28S88+xbXfFq3hrrxPSs5g0Rnw9qRMZ8oeUvsM9PDNxzGzbdq7lNuMr9woy3HvuiY5nAfaqq0thefULe9M/kKgbMjHtdtwzJlzeV7nZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947224; c=relaxed/simple;
	bh=XFKYbdqek82e955LuFfB7XrslWtR7nToplf1ovT/uLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inyoQuFE2PZdADhiZycBLfSUzfpYQ7ck4hQ57VNOAFiDbYVtBjGmaeyE/uKa5HcJbNtC4rJ+SRn8MMDTSHmXWKuRJi0dNwJJWKojeH4mN9U1YNdhA4aPBj/h2qyu/pBRL2sPY3Qhua6Cml9ZX9U6Sgr5LeyyW19rQmsbHDDJR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfm24XKT; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0c20ee83dso38120345ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 00:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767947218; x=1768552018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwi+SQABySrXhJ73Aavan6sR47ltHo8LNgDoB9IyaJE=;
        b=Gfm24XKTXf9PFdCwdwbaUQPIP/O0JiUcF3utyhC7MGEFXfwOh8dw7bZ11BvbjXC7YJ
         9jnqI0k8bSrJ56tAhkd+bI0HNFHwaxidDfV43yCXUHmZcGrEgSqnDZqwFIweyG3g4rlN
         yzqWI0kGNOdOQlobZxtMKla8QCcJu9ZlhM8+TSXvbPAJTCg0iawoIyBz1E6i/DNURowO
         bwrtN7Yq9H2WoQPq2Y5yrGIcv/XUfty5fjQg9jUYOdx6rHBRHt2EezY+1w6+zxNYKggO
         3uRGm97e3VV+tFAoG3O78thfhlA6luMBo7VjmgvxuP71YMl8prrzGELOXA7jQU5D2j1V
         fBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947218; x=1768552018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zwi+SQABySrXhJ73Aavan6sR47ltHo8LNgDoB9IyaJE=;
        b=HG+BYPQmdpMjpcDTN/hP/7PTItu5cnTr1Up8sM6NfZLywHbBV1uuZqZwnLZG8vfhNW
         UiQ7PmZgCg3IeLDx2om5XyWIO6+kiQnSx9r31TvUVFnEmD8wA7Lwm5jHebtdlj6INxEC
         9JN67WqGtKYGaE4q0ATmwLpV1eNbW1Q9ZWssFPIHxBuY/em4r33h+cd/ZuxVOuHb7iUW
         a7LwyGtgCmNIV+qoHx8WbWHxGINwJ69K9iEqQUTO8wfXKoOcGsjp3+h/1ptJ+6kAfmCX
         RiScid2c+v/DeGE1GDcP3eJjoOE/QCnHhmgRY0ue+4vB7YGKLQz5Btt7uHAhw9y5EOqP
         APtw==
X-Forwarded-Encrypted: i=1; AJvYcCXLg4eUcjE7Dd6t0zZoAkjr9BcRJX2/n02bWLoECL/PdnMP+iqeah/1uJmwC5LG0mrpjv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+vwzyqwmJpot4Z4wDiva7mU8urN5090D8wTrRXaksfTxzJ4r
	NUNnInt5kSxKvyFmkVJoLeUEeDosfpiljLown9uFrO809LkkjYfzLNpu
X-Gm-Gg: AY/fxX5Ucrwc0fjXh7L65RCLjQx0MXHlk2NYcWEzVuT9VulaVl+IzejRgM3+rqs/TBv
	nfvTNfOFlqJp4mwf5p+08Zjw6sKDsPQARuHRGvyTkCvlKgKMBHy8xCIUd8vlJUTPZfeYPOVrL7l
	YCiuVO61Vka1prFV+FGSiA8J1SpyacqaPPIQVDG05n9v987MqVgLgXkJHMWS0WjKok/Dl/X8G6c
	esuB/Fhw6hik8QhYi7J8KUv4zgdkDFIti4jVGpO8jS58iMf/ZCiwg043RioBQLYHVAsqwkEBj5d
	emh9GjgPaVqJvvEz/qdtZj3pOrsTYwlqo4oewFVl/MpQBRUoYeu/QvU+LnsjNoNiwVSPM+MYMO4
	m5BOUeOH5AjDyyoF4H8g1WNCtFcIlu7fi2nQQkvwaNKMQ0pitEXxVRTJ/wyfOmv4OsuRoFDuUbT
	h5bif4jpk=
X-Google-Smtp-Source: AGHT+IFkmYIsAMugEppgaXOpQe5O3ZkdkSpkBnrFqRwXgUMwl1QncrAuD0R34kIn9aTM0yWLwMIwkw==
X-Received: by 2002:a17:903:1b43:b0:2a0:bb05:df4f with SMTP id d9443c01a7336-2a3ee49c701mr96639765ad.44.1767947218306;
        Fri, 09 Jan 2026 00:26:58 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7912sm100104695ad.67.2026.01.09.00.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:26:58 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: add TEST_TAG_KCONFIG_CHECK to test_loader
Date: Fri,  9 Jan 2026 16:26:30 +0800
Message-ID: <20260109082631.246647-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109082631.246647-1-dongml2@chinatelecom.cn>
References: <20260109082631.246647-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __kconfig_check() to specify the kernel config for the test case.
The test case will be skipped if the specified Kconfig option is not
matched.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  3 ++
 tools/testing/selftests/bpf/test_loader.c    | 46 +++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c9bfbe1bafc1..e230f135f580 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -129,6 +129,8 @@
  *
  * __linear_size     Specify the size of the linear area of non-linear skbs, or
  *                   0 for linear skbs.
+ *
+ * __kconfig_check   The test case is skipped if the specified Kconfig option is not set.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
 #define __not_msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_not_msg=" XSTR(__COUNTER__) "=" msg)))
@@ -163,6 +165,7 @@
 #define __stdout(msg)		__attribute__((btf_decl_tag("comment:test_expect_stdout=" XSTR(__COUNTER__) "=" msg)))
 #define __stdout_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stdout_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __linear_size(sz)	__attribute__((btf_decl_tag("comment:test_linear_size=" XSTR(sz))))
+#define __kconfig_check(config)	__attribute__((btf_decl_tag("comment:test_kconfig=" config)))
 
 /* Define common capabilities tested using __caps_unpriv */
 #define CAP_NET_ADMIN		12
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c3688..a5fbd70e37d6 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -4,6 +4,9 @@
 #include <stdlib.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
+#include <gelf.h>
+#include <zlib.h>
+#include <sys/utsname.h>
 
 #include "autoconf_helper.h"
 #include "disasm_helpers.h"
@@ -44,6 +47,7 @@
 #define TEST_TAG_EXPECT_STDOUT_PFX "comment:test_expect_stdout="
 #define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "comment:test_expect_stdout_unpriv="
 #define TEST_TAG_LINEAR_SIZE "comment:test_linear_size="
+#define TEST_TAG_KCONFIG_CHECK "comment:test_kconfig="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xbadcafe
@@ -93,6 +97,7 @@ struct test_spec {
 	int linear_sz;
 	bool auxiliary;
 	bool valid;
+	bool skip;
 };
 
 static int tester_init(struct test_loader *tester)
@@ -394,6 +399,41 @@ static int get_current_arch(void)
 	return ARCH_UNKNOWN;
 }
 
+static int kconfig_check(const char *kconfig)
+{
+	int len, err = -ENOENT;
+	char buf[PATH_MAX];
+	struct utsname uts;
+	gzFile file;
+
+	uname(&uts);
+	len = snprintf(buf, PATH_MAX, "/boot/config-%s", uts.release);
+	if (len < 0)
+		return -EINVAL;
+	else if (len >= PATH_MAX)
+		return -ENAMETOOLONG;
+
+	/* gzopen also accepts uncompressed files. */
+	file = gzopen(buf, "re");
+	if (!file)
+		file = gzopen("/proc/config.gz", "re");
+
+	if (!file) {
+		fprintf(stderr, "failed to open system Kconfig\n");
+		return -ENOENT;
+	}
+
+	while (gzgets(file, buf, sizeof(buf))) {
+		if (strstr(buf, kconfig)) {
+			err = 0;
+			break;
+		}
+	}
+
+	gzclose(file);
+	return err;
+}
+
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -650,6 +690,10 @@ static int parse_test_spec(struct test_loader *tester,
 				err = -EINVAL;
 				goto cleanup;
 			}
+		} else if (str_has_pfx(s, TEST_TAG_KCONFIG_CHECK)) {
+			val = s + sizeof(TEST_TAG_KCONFIG_CHECK) - 1;
+			if (kconfig_check(val))
+				spec->skip = true;
 		}
 	}
 
@@ -1151,7 +1195,7 @@ void run_subtest(struct test_loader *tester,
 	if (!test__start_subtest(subspec->name))
 		return;
 
-	if ((get_current_arch() & spec->arch_mask) == 0) {
+	if ((get_current_arch() & spec->arch_mask) == 0 || spec->skip) {
 		test__skip();
 		return;
 	}
-- 
2.52.0


