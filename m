Return-Path: <bpf+bounces-7245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E503773E4F
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC181C20F54
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D96C14A86;
	Tue,  8 Aug 2023 16:29:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7B13AFC
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:29:05 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC99892F
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:28:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so7766210a12.1
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 09:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512091; x=1692116891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRlMu9hgkYW/FeU0nHZiGCBVwfKuFqETGDXHSQIM1Ws=;
        b=XW5y77RDaymn91qKX0CPhf2hL9Wuas13jjDfI4M+hwt699FFGftowUanItCK76qsER
         1vw6AQrkTSslPWV9dl0NwXjPFOeOsAsE2jWVCf1F0Vi5RDPBNRgP81xV6Egd/OfiDuo6
         xiZkUFvgrvKLPSoL47UYtItnSQbQPlk/LqlxuL33st4LYJzKP4sjd8WzNx8rvS49N2t7
         S3JKv3e8a66Ff4d2hORXQw0BCidVqOkzC04jfQrgAZ/1/speMUGDN3vIQIpb/QXpzjWW
         sWfZysAEztLqpyiWmFP152ORQ9w552gOkIfSUvgnEWiaZtf3+QLNkGkpK41Urf+6deXu
         gEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512091; x=1692116891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRlMu9hgkYW/FeU0nHZiGCBVwfKuFqETGDXHSQIM1Ws=;
        b=NNt9lf2lfOU3HJgxIXScEIay1/794L0uf4KOChHdfhPOiNhNqtTdGt8EEvUFNwihbA
         EwJ0DDc/MEACzaO8oL2H4iwMQmU0wTlLKlQzJpnnI/S9DulEpEa5E4lxzBpbgXssvi/C
         rlKyAYbX8i2mpvWwgEVzCvUQMn/qPF0JR4oqHkrsw9dwxYDTxe1+5I7EDIFyKE87oKWx
         MY/VmaqWTevk8pW/3pYlL/TH/UQKTXE9iTXTunbQ9n/CEnfI/8s48SG3F83IFldj0COV
         Kp6RP2RRisFIMrhuqAv+MxIaIB+Ee3OgiHe5xtOkMAB8oQC3Ve9WvtcAIvS6WGMc7xcO
         KQ1w==
X-Gm-Message-State: AOJu0YzGgis5yx4cQYEcGCcTES/4Ul+DAkTI2oIHFwNww4viKY1B25xF
	ydZS/I1Gc/+u/iOllqIFyYe3I0xi+f8=
X-Google-Smtp-Source: AGHT+IEtKElyK5C/AhENlIdt8PEMd7F5RWGMP0OSniwXrRu2NDfDcTFzUtSAXJIIQrJ4EpKkMqlObg==
X-Received: by 2002:a05:6402:60e:b0:522:3849:48db with SMTP id n14-20020a056402060e00b00522384948dbmr302967edv.3.1691512091421;
        Tue, 08 Aug 2023 09:28:11 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a25-20020a50ff19000000b0050488d1d376sm6872445edu.0.2023.08.08.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 09:28:11 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: relax expected log messages to allow emitting BPF_ST
Date: Tue,  8 Aug 2023 19:27:55 +0300
Message-ID: <20230808162755.392606-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update [1] to LLVM BPF backend seeks to enable generation of BPF_ST
instruction when CPUv4 is selected. This affects expected log messages
for the following selftests:
- log_fixup/missing_map
- spin_lock/lock_id_mapval_preserve
- spin_lock/lock_id_innermapval_preserve

Expected messages in these tests hard-code instruction numbers for BPF
programs compiled from C. These instruction numbers change when
BPF_ST is allowed because single BPF_ST instruction replaces a pair of
BPF_MOV/BPF_STX instructions, e.g.:

    r1 = 42;
    *(u32 *)(r10 - 8) = r1;  --->  *(u32 *)(r10 - 8) = 42;

This commit updates expected log messages to avoid matching specific
instruction numbers (program position still could be uniquely
identified).

[1] https://reviews.llvm.org/D140804
    "[BPF] support for BPF_ST instruction in codegen"

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/log_fixup.c      |  2 +-
 .../selftests/bpf/prog_tests/spin_lock.c      | 37 ++++++++++++++++---
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index dba71d98a227..effd78b2a657 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -124,7 +124,7 @@ static void missing_map(void)
 	ASSERT_FALSE(bpf_map__autocreate(skel->maps.missing_map), "missing_map_autocreate");
 
 	ASSERT_HAS_SUBSTR(log_buf,
-			  "8: <invalid BPF map reference>\n"
+			  ": <invalid BPF map reference>\n"
 			  "BPF map 'missing_map' is referenced but wasn't created\n",
 			  "log_buf");
 
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index d9270bd3d920..f29c08d93beb 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <regex.h>
 #include <test_progs.h>
 #include <network_helpers.h>
 
@@ -19,12 +20,16 @@ static struct {
 	  "; R1_w=map_value(off=0,ks=4,vs=4,imm=0)\n2: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_mapval_preserve",
-	  "8: (bf) r1 = r0                       ; R0_w=map_value(id=1,off=0,ks=4,vs=8,imm=0) "
-	  "R1_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)\n9: (85) call bpf_this_cpu_ptr#154\n"
+	  "[0-9]\\+: (bf) r1 = r0                       ;"
+	  " R0_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)"
+	  " R1_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)\n"
+	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_innermapval_preserve",
-	  "13: (bf) r1 = r0                      ; R0=map_value(id=2,off=0,ks=4,vs=8,imm=0) "
-	  "R1_w=map_value(id=2,off=0,ks=4,vs=8,imm=0)\n14: (85) call bpf_this_cpu_ptr#154\n"
+	  "[0-9]\\+: (bf) r1 = r0                      ;"
+	  " R0=map_value(id=2,off=0,ks=4,vs=8,imm=0)"
+	  " R1_w=map_value(id=2,off=0,ks=4,vs=8,imm=0)\n"
+	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_mismatch_kptr_kptr", "bpf_spin_unlock of different lock" },
 	{ "lock_id_mismatch_kptr_global", "bpf_spin_unlock of different lock" },
@@ -45,6 +50,24 @@ static struct {
 	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of different lock" },
 };
 
+static int match_regex(const char *pattern, const char *string)
+{
+	int err, rc;
+	regex_t re;
+
+	err = regcomp(&re, pattern, REG_NOSUB);
+	if (err) {
+		char errbuf[512];
+
+		regerror(err, &re, errbuf, sizeof(errbuf));
+		PRINT_FAIL("Can't compile regex: %s\n", errbuf);
+		return -1;
+	}
+	rc = regexec(&re, string, 0, NULL, 0);
+	regfree(&re);
+	return rc == 0 ? 1 : 0;
+}
+
 static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
@@ -74,7 +97,11 @@ static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
 		goto end;
 	}
 
-	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
+	ret = match_regex(err_msg, log_buf);
+	if (!ASSERT_GE(ret, 0, "match_regex"))
+		goto end;
+
+	if (!ASSERT_TRUE(ret, "no match for expected error message")) {
 		fprintf(stderr, "Expected: %s\n", err_msg);
 		fprintf(stderr, "Verifier: %s\n", log_buf);
 	}
-- 
2.41.0


