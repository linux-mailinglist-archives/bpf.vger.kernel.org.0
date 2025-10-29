Return-Path: <bpf+bounces-72710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64BC1981D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EB3F50006C
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF12E427B;
	Wed, 29 Oct 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JYBckGY5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548A20C48A
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731243; cv=none; b=FfyOGm/fJvA+uJYvkxVwoRKzXjwxg/8Fa/fshCxXsJ4idH35oYF559mvf+ckbntVpedTO4XWo9D94idKe3zYUVAEJC+a9bOrLSePMZxHLhf3OOEw7DcEiQt/y6Gv7zmJ8PifmHW0QNQmT/1Jm96zJO3UTK6dvnMG/MBcOhTkcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731243; c=relaxed/simple;
	bh=TxXp8NYE2HWggcco1B815t2GjIRWdAt8g4iwcn7hx+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3Ax1SeppjcEluHMWA8bHXNsXljhEGO/fUrvpBJ7HE+GNwe024ZVWLljxzLtJmlk9Jw4zx7kXCAmDgoBZoI7Z12sypqt7b4x74IOb8L8/dA+JjK4dCrwPuRCNUUZcOO06SlF5gWrIZtlMvaMi/KJLhfTDFGNssCzJPp0ip409hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JYBckGY5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gusv031399;
	Wed, 29 Oct 2025 09:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2Jxti
	UcfR159bsTN+by1TAAZ3q4ggm+7i3DUsk+mzpY=; b=JYBckGY5v7qCd/55Zczrd
	Ive1xo/zbyWD1uFCYcTgw7jWZjYiXpaZh6xCKd+Bx2Zh1CxXOLhfilXbQ+6YAJCd
	lsbmhz8BCw4FUeaLRF3g8VZ13tnvaGrCklWGGZQS9icu3X/TWrYq7GUB1coUffI4
	rfbS7Ff/5UcWnsnZpfDmonFmB7w8vS4N+TGjlylSZQaMg3polhSBtaeJJxcuxoND
	oFtWhFEJkhrMHZQtZcYq2/e8Prjn8PGn9Xj1PpGnxC/Pyb/eCPT4nrDWfiCmhO5k
	5fBOB1sw7vg2QVBvjK1cYkK0u2+ctvTQkSRZ0NdBsTqffzrH/XnZZ+EYlHV28HGD
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cbtgfjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:46:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9CImk007741;
	Wed, 29 Oct 2025 09:46:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wk0cgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:46:48 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59T9kbKc030346;
	Wed, 29 Oct 2025 09:46:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-155.vpn.oracle.com [10.154.55.155])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a33wk0cah-3;
	Wed, 29 Oct 2025 09:46:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, terrelln@fb.com,
        dsterba@suse.com, acme@redhat.com, irogers@google.com, leo.yan@arm.com,
        namhyung@kernel.org, tglozar@redhat.com, blakejones@google.com,
        yuzhuo@google.com, charlie@rivosinc.com, ebiggers@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 2/2] bpftool: Use libcrypto feature test to optionally support signing
Date: Wed, 29 Oct 2025 09:46:31 +0000
Message-ID: <20251029094631.1387011-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251029094631.1387011-1-alan.maguire@oracle.com>
References: <20251029094631.1387011-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290072
X-Proofpoint-GUID: fnibBl9O5glmxUPJzpC1_RswNNOHFbDq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzNSBTYWx0ZWRfX4ZDJrlP3Icd0
 TIAfEyOsKT3V9qhth9sHcUyDQPRwTei2DKh7GwwCkfXLmAbwL8DnmkmHmxnEK9MdFeG+ZE61Djn
 ogn4U/BWqKA2lD38SeD5nXl2pFnRoYWmJ8PpmT6rd9cE3G+9XX+h/G141nANFm1uD9x939OslF+
 D0rMwEE6738NaWb3XO1wZGf87Ezr0b1Q9gqpP2DfHGu0OTc3GbcMcM2oYmmQO3EDdZaqsG3vkbi
 xAV0RTEpllQ+eGjSTsoM+wmaKwZJSG3U6uufjspHGlaSPiSTDkc/9OeCLolJD7CuTG0WXpi6Ejz
 wMl8CAm2TarfgTGm/BVa2t2Fu4McxtzrQRefLTsGAPGgUQIF6j5RL0GuPjX+1wG73RzSovvUb3x
 zuFc0jWK0p5/5KqLsVYme1qL7fJ5bA==
X-Authority-Analysis: v=2.4 cv=A8Nh/qWG c=1 sm=1 tr=0 ts=6901e289 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=dJxC-xBYrheAFNSb3qsA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: fnibBl9O5glmxUPJzpC1_RswNNOHFbDq

New libcrypto test verifies presence of openssl3 needed for BPF
signing; use that feature to conditionally compile signing-related
code so bpftool build will not break in the absence of libcrypto v3.

Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
Suggested-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/Makefile | 17 ++++++++++++++---
 tools/bpf/bpftool/gen.c    | 17 ++++++++++++-----
 tools/bpf/bpftool/prog.c   | 12 +++++++-----
 tools/bpf/bpftool/sign.c   |  2 ++
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 586d1b2595d1..3e59fd97ada8 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -101,6 +101,7 @@ FEATURE_TESTS := clang-bpf-co-re
 FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
 FEATURE_TESTS += libbfd
+FEATURE_TESTS += libcrypto
 FEATURE_TESTS += libbfd-liberty
 FEATURE_TESTS += libbfd-liberty-z
 FEATURE_TESTS += disassembler-four-args
@@ -110,6 +111,7 @@ FEATURE_TESTS += libelf-zstd
 FEATURE_DISPLAY := clang-bpf-co-re
 FEATURE_DISPLAY += llvm
 FEATURE_DISPLAY += libcap
+FEATURE_DISPLAY += libcrypto
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
 FEATURE_DISPLAY += libbfd-liberty-z
@@ -130,8 +132,14 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-LIBS = $(LIBBPF) -lelf -lz -lcrypto
-LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
+LIBS = $(LIBBPF) -lelf -lz
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
+
+ifeq ($(feature-libcrypto),1)
+CFLAGS += -DUSE_CRYPTO
+LIBS += -lcrypto
+LIBS_BOOTSTRAP += -lcrypto
+endif
 
 ifeq ($(feature-libelf-zstd),1)
 LIBS += -lzstd
@@ -194,7 +202,10 @@ endif
 
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
-BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o sign.o)
+BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
+ifeq ($(feature-libcrypto),1)
+BOOTSTRAP_OBJS += $(addprefix $(BOOTSTRAP_OUTPUT),sign.o)
+endif
 $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
 
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 993c7d9484a4..257d3c89dc4a 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -688,16 +688,15 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard)
 {
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
-	struct bpf_load_and_run_opts sopts = {};
-	char sig_buf[MAX_SIG_SIZE];
-	__u8 prog_sha[SHA256_DIGEST_LENGTH];
 	struct bpf_map *map;
 
 	char ident[256];
 	int err = 0;
 
+#ifdef USE_CRYPTO
 	if (sign_progs)
 		opts.gen_hash = true;
+#endif
 
 	err = bpf_object__gen_loader(obj, &opts);
 	if (err)
@@ -790,7 +789,12 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		\n\
 		\";\n");
 
+#ifdef USE_CRYPTO
 	if (sign_progs) {
+		struct bpf_load_and_run_opts sopts = {};
+		char sig_buf[MAX_SIG_SIZE];
+		__u8 prog_sha[SHA256_DIGEST_LENGTH];
+
 		sopts.insns = opts.insns;
 		sopts.insns_sz = opts.insns_sz;
 		sopts.excl_prog_hash = prog_sha;
@@ -831,7 +835,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			opts.keyring_id = skel->keyring_id;			\n\
 		");
 	}
-
+#endif /* USE_CRYPTO */
 	codegen("\
 		\n\
 			opts.ctx = (struct bpf_loader_ctx *)skel;	    \n\
@@ -1406,13 +1410,14 @@ static int do_skeleton(int argc, char **argv)
 
 		printf("\t} links;\n");
 	}
-
+#ifdef USE_CRYPTO
 	if (sign_progs) {
 		codegen("\
 		\n\
 			__s32 keyring_id;				   \n\
 		");
 	}
+#endif /* USE_CRYPTO */
 
 	if (btf) {
 		err = codegen_datasecs(obj, obj_name);
@@ -1990,7 +1995,9 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
+#ifdef USE_CRYPTO
 		"                    {-L|--use-loader} | [ {-S|--sign } {-k} <private_key.pem> {-i} <certificate.x509> ]}\n"
+#endif
 		"",
 		bin_name, "gen");
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 6daf19809ca4..914b0fc175a4 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1931,12 +1931,10 @@ static int try_loader(struct gen_loader_opts *gen)
 {
 	struct bpf_load_and_run_opts opts = {};
 	struct bpf_loader_ctx *ctx;
-	char sig_buf[MAX_SIG_SIZE];
-	__u8 prog_sha[SHA256_DIGEST_LENGTH];
 	int ctx_sz = sizeof(*ctx) + 64 * max(sizeof(struct bpf_map_desc),
 					     sizeof(struct bpf_prog_desc));
 	int log_buf_sz = (1u << 24) - 1;
-	int err, fds_before, fd_delta;
+	int err = 0, fds_before, fd_delta;
 	char *log_buf = NULL;
 
 	ctx = alloca(ctx_sz);
@@ -1947,7 +1945,7 @@ static int try_loader(struct gen_loader_opts *gen)
 		ctx->log_size = log_buf_sz;
 		log_buf = malloc(log_buf_sz);
 		if (!log_buf)
-			return -ENOMEM;
+			goto out;
 		ctx->log_buf = (long) log_buf;
 	}
 	opts.ctx = ctx;
@@ -1956,8 +1954,11 @@ static int try_loader(struct gen_loader_opts *gen)
 	opts.insns = gen->insns;
 	opts.insns_sz = gen->insns_sz;
 	fds_before = count_open_fds();
-
+#ifdef USE_CRYPTO
 	if (sign_progs) {
+		char sig_buf[MAX_SIG_SIZE];
+		__u8 prog_sha[SHA256_DIGEST_LENGTH];
+
 		opts.excl_prog_hash = prog_sha;
 		opts.excl_prog_hash_sz = sizeof(prog_sha);
 		opts.signature = sig_buf;
@@ -1976,6 +1977,7 @@ static int try_loader(struct gen_loader_opts *gen)
 			goto out;
 		}
 	}
+#endif
 	err = bpf_load_and_run(&opts);
 	fd_delta = count_open_fds() - fds_before;
 	if (err < 0 || verifier_logs) {
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index b34f74d210e9..5f613d3e2766 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2025 Google LLC.
  */
 
+#ifdef USE_CRYPTO
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
@@ -209,3 +210,4 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	DISPLAY_OSSL_ERR(err < 0);
 	return err;
 }
+#endif /* USE_CRYPTO */
-- 
2.39.3


