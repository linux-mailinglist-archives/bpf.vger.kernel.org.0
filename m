Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9612BC5
	for <lists+bpf@lfdr.de>; Fri,  3 May 2019 12:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfECKn6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 May 2019 06:43:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35417 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfECKn4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 May 2019 06:43:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so6165191wmd.0
        for <bpf@vger.kernel.org>; Fri, 03 May 2019 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tslFcrcgD8lQiIU1dFiAcRKr0h3FWLPCM/MfQ/nJ1MQ=;
        b=NPYtpPq9nLowZkkSRBYSO8LskFQLhaVXyDNGrHIVnrwT0ummDVhDcbIisBH5X4n4HD
         0/212nHqupq5eOYp7FBadV0csikqF1UKeB07Bupc1n6TlFgXTXT5EOUP47qPerPGXJCE
         UgWjB95yw0elZEebWV0n6iutjh5xLABBwncKCPwm94mIeZE8UX5PoRIP+eJ23Dve51e/
         /2L43KpQOh9JsGiQMztt1Ei7uCxkU0Uj+bzLlgS98EKCQd6FIhnuIb88fi+VizBlY6wr
         SQ3AeZnu2qRDHB4nydbq6QDj9IMJCTdB0O7BPF0Ds6zMEW9Kq4B9p6aVAsVQsapRR2RE
         BDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tslFcrcgD8lQiIU1dFiAcRKr0h3FWLPCM/MfQ/nJ1MQ=;
        b=pBD4iVuJFq6tz6o3w7elhgk7zIFtk318U9xn5fiLUijd5KtVGV/kbC7FvtvzCGjlSy
         0TNYEmcP0CZxPNU23cAIkIstiqbMwVs8v7jR/xaxkysF8Jblgnv3ppcY0wR+Ja5IVaRR
         LymnLHdfA6Ptpnq3LedreXBm3Fky167OdPxxPtjZXsTJWR5CZHKQc3O8ga+ZPRuRqrAy
         gKaTYf1UZQvLLAdMU/SXB943DR+JCjwISzBVjkuXoUJaAl/J8NqNzFAihpIDihb1xdN8
         JLZHlHmN1FBvkXqCpv64GXZ4YuURvS+EUKoYc+otTr/rnTNrN+YOrj3zV331Ze689oIo
         eysg==
X-Gm-Message-State: APjAAAWmCdW+Bmqgo6bueQQE639lP0cma7ZCRf/kK+pGamHWVV36sAWZ
        KL9/Je10TZZhWg8pzZg/S4IWo+0nWpQ=
X-Google-Smtp-Source: APXvYqyx6iDNhr95yaNSS9cH99QQ7UWh1JYFWWSxWWHFurti35wwfhpLHCh6kCtwG4GA7s71L4ot9w==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr6029988wmh.74.1556880233965;
        Fri, 03 May 2019 03:43:53 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id r29sm1716999wra.56.2019.05.03.03.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 03:43:53 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v6 bpf-next 10/17] selftests: bpf: enable hi32 randomization for all tests
Date:   Fri,  3 May 2019 11:42:37 +0100
Message-Id: <1556880164-10689-11-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com>
References: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The previous libbpf patch allows user to specify "prog_flags" to bpf
program load APIs. To enable high 32-bit randomization for a test, we need
to set BPF_F_TEST_RND_HI32 in "prog_flags".

To enable such randomization for all tests, we need to make sure all places
are passing BPF_F_TEST_RND_HI32. Changing them one by one is not
convenient, also, it would be better if a test could be switched to
"normal" running mode without code change.

Given the program load APIs used across bpf selftests are mostly:
  bpf_prog_load:      load from file
  bpf_load_program:   load from raw insns

A test_stub.c is implemented for bpf seltests, it offers two functions for
testing purpose:

  bpf_prog_test_load
  bpf_test_load_program

The are the same as "bpf_prog_load" and "bpf_load_program", except they
also set BPF_F_TEST_RND_HI32. Given *_xattr functions are the APIs to
customize any "prog_flags", it makes little sense to put these two
functions into libbpf.

Then, the following CFLAGS are passed to compilations for host programs:
  -Dbpf_prog_load=bpf_prog_test_load
  -Dbpf_load_program=bpf_test_load_program

They migrate the used load APIs to the test version, hence enable high
32-bit randomization for these tests without changing source code.

Besides all these, there are several testcases are using
"bpf_prog_load_attr" directly, their call sites are updated to pass
BPF_F_TEST_RND_HI32.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 tools/testing/selftests/bpf/Makefile               | 10 +++---
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |  1 +
 tools/testing/selftests/bpf/test_sock_addr.c       |  1 +
 tools/testing/selftests/bpf/test_sock_fields.c     |  1 +
 tools/testing/selftests/bpf/test_socket_cookie.c   |  1 +
 tools/testing/selftests/bpf/test_stub.c            | 40 ++++++++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c        |  2 +-
 7 files changed, 51 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_stub.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 66f2dca..3f2c131 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -15,7 +15,9 @@ LLC		?= llc
 LLVM_OBJCOPY	?= llvm-objcopy
 LLVM_READELF	?= llvm-readelf
 BTF_PAHOLE	?= pahole
-CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(BPFDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
+CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(BPFDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include \
+	  -Dbpf_prog_load=bpf_prog_test_load \
+	  -Dbpf_load_program=bpf_test_load_program
 LDLIBS += -lcap -lelf -lrt -lpthread
 
 # Order correspond to 'make run_tests' order
@@ -78,9 +80,9 @@ $(OUTPUT)/test_maps: map_tests/*.c
 
 BPFOBJ := $(OUTPUT)/libbpf.a
 
-$(TEST_GEN_PROGS): $(BPFOBJ)
+$(TEST_GEN_PROGS): test_stub.o $(BPFOBJ)
 
-$(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/libbpf.a
+$(TEST_GEN_PROGS_EXTENDED): test_stub.o $(OUTPUT)/libbpf.a
 
 $(OUTPUT)/test_dev_cgroup: cgroup_helpers.c
 $(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c
@@ -176,7 +178,7 @@ $(ALU32_BUILD_DIR)/test_progs_32: test_progs.c $(OUTPUT)/libbpf.a\
 						$(ALU32_BUILD_DIR)/urandom_read
 	$(CC) $(TEST_PROGS_CFLAGS) $(CFLAGS) \
 		-o $(ALU32_BUILD_DIR)/test_progs_32 \
-		test_progs.c trace_helpers.c prog_tests/*.c \
+		test_progs.c test_stub.c trace_helpers.c prog_tests/*.c \
 		$(OUTPUT)/libbpf.a $(LDLIBS)
 
 $(ALU32_BUILD_DIR)/test_progs_32: $(PROG_TESTS_H)
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 23b159d..2623d15 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -22,6 +22,7 @@ static int check_load(const char *file)
 	attr.file = file;
 	attr.prog_type = BPF_PROG_TYPE_SCHED_CLS;
 	attr.log_level = 4;
+	attr.prog_flags = BPF_F_TEST_RND_HI32;
 	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
 	bpf_object__close(obj);
 	if (err)
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 3f110ea..5d0c4f0 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -745,6 +745,7 @@ static int load_path(const struct sock_addr_test *test, const char *path)
 	attr.file = path;
 	attr.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR;
 	attr.expected_attach_type = test->expected_attach_type;
+	attr.prog_flags = BPF_F_TEST_RND_HI32;
 
 	if (bpf_prog_load_xattr(&attr, &obj, &prog_fd)) {
 		if (test->expected_result != LOAD_REJECT)
diff --git a/tools/testing/selftests/bpf/test_sock_fields.c b/tools/testing/selftests/bpf/test_sock_fields.c
index e089477..f0fc103 100644
--- a/tools/testing/selftests/bpf/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/test_sock_fields.c
@@ -414,6 +414,7 @@ int main(int argc, char **argv)
 	struct bpf_prog_load_attr attr = {
 		.file = "test_sock_fields_kern.o",
 		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+		.prog_flags = BPF_F_TEST_RND_HI32,
 	};
 	int cgroup_fd, egress_fd, ingress_fd, err;
 	struct bpf_program *ingress_prog;
diff --git a/tools/testing/selftests/bpf/test_socket_cookie.c b/tools/testing/selftests/bpf/test_socket_cookie.c
index e51d637..cac8ee5 100644
--- a/tools/testing/selftests/bpf/test_socket_cookie.c
+++ b/tools/testing/selftests/bpf/test_socket_cookie.c
@@ -148,6 +148,7 @@ static int run_test(int cgfd)
 	memset(&attr, 0, sizeof(attr));
 	attr.file = SOCKET_COOKIE_PROG;
 	attr.prog_type = BPF_PROG_TYPE_UNSPEC;
+	attr.prog_flags = BPF_F_TEST_RND_HI32;
 
 	err = bpf_prog_load_xattr(&attr, &pobj, &prog_fd);
 	if (err) {
diff --git a/tools/testing/selftests/bpf/test_stub.c b/tools/testing/selftests/bpf/test_stub.c
new file mode 100644
index 0000000..84e81a8
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_stub.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Copyright (C) 2019 Netronome Systems, Inc. */
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <string.h>
+
+int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
+		       struct bpf_object **pobj, int *prog_fd)
+{
+	struct bpf_prog_load_attr attr;
+
+	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
+	attr.file = file;
+	attr.prog_type = type;
+	attr.expected_attach_type = 0;
+	attr.prog_flags = BPF_F_TEST_RND_HI32;
+
+	return bpf_prog_load_xattr(&attr, pobj, prog_fd);
+}
+
+int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
+			  size_t insns_cnt, const char *license,
+			  __u32 kern_version, char *log_buf,
+		     size_t log_buf_sz)
+{
+	struct bpf_load_program_attr load_attr;
+
+	memset(&load_attr, 0, sizeof(struct bpf_load_program_attr));
+	load_attr.prog_type = type;
+	load_attr.expected_attach_type = 0;
+	load_attr.name = NULL;
+	load_attr.insns = insns;
+	load_attr.insns_cnt = insns_cnt;
+	load_attr.license = license;
+	load_attr.kern_version = kern_version;
+	load_attr.prog_flags = BPF_F_TEST_RND_HI32;
+
+	return bpf_load_program_xattr(&load_attr, log_buf, log_buf_sz);
+}
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 3dcdfd4..71704de 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -879,7 +879,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (fixup_skips != skips)
 		return;
 
-	pflags = 0;
+	pflags = BPF_F_TEST_RND_HI32;
 	if (test->flags & F_LOAD_WITH_STRICT_ALIGNMENT)
 		pflags |= BPF_F_STRICT_ALIGNMENT;
 	if (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS)
-- 
2.7.4

