Return-Path: <bpf+bounces-42792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635A9AB216
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BF61C225FE
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9201AD5DE;
	Tue, 22 Oct 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMrBfBaV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE511A3056
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610967; cv=none; b=Iye+/7Pe74ifXENIOSqnGOHBBw6/mYy6CgVcygZDN1mYZu+xL/z8V7YeWtCf3zj7NZoX4QgNUkMob5DrIEyTZYCjexqZWgeHMaJNNGdig1ulxjECSqCX3rIi9VwZjDq26TLoWkhbBh9T19AvEynSJ4roAbhAcNkk+UymsnLH5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610967; c=relaxed/simple;
	bh=IQywR3lFRN7aNWtJYEJ/wyQtPB6YrH7M0/VCMAkwKBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uNEqYsZNegQe7ILsQ4NQhPttx7rjq9mGMQhLIS5rOIeV11zNJAksCwgewqs8DLJM543oAG+VWgC2vXQuJtMHsMP7VGzUiIoT3GJHfZQzGyEhQs7CQVgEqpACsbOAMERiOj9LAr9eGoJjGugoAa6eq4qyv0AbDuxTCoADv2OKcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dMrBfBaV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7db4c1a55f5so4977949a12.3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729610965; x=1730215765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WY7mu2317PQTgnlqdNIzln+fHh6bcofJh5E/NHzXWh4=;
        b=dMrBfBaVEqyC3dWnSq4/74cE+Q7n7yM4zH7OdYG8KWVFqFyWcUYV7e9ADjmqHE27kk
         KnVnr7TBMYQclBlyyzW+ZVXvafVfpPafnZwyZUmWwaGnnKuiofgVK4W636StcLAgRjN3
         /DggYVa2Nyeyp5Fln7/MHIWTDcYVkZOhLjQIuYlzCI5qpuFBSu2ml6HaxBbGxRuNdMAj
         grALs8mOpB2omy0uBpLfN1SMWQORMjevurgBBCABZ8IGiyPm0ynTIBm460jSEZjo/TUT
         B49VconzFeQfDC/cMzuejnMWwm+aW+fUVDapClWykvFGlcauBbYlMC8GlrCsGyMQqhQr
         8TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610965; x=1730215765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WY7mu2317PQTgnlqdNIzln+fHh6bcofJh5E/NHzXWh4=;
        b=LCDiFbMB3xHHHzB5qrS3q/kcbUrOhDyQfXV6i4z18dAWGReMCjwpSVT8SjlZ1D/HP+
         Z3UAmCvfDI6ducK04spuquv9nAqnY4nfDLtquqH3Lqw99FBRfhjocUsOs6Z6l4Q9onFR
         +UJlwJdTt2e06NecAxLrY617aGgu40GnLeSPTC+gdST5x+DqUgsnybh7X6r79aScD7P5
         J77v8c7Tyxk8UHwbJj2X4MzhxOlF6lKi/ult7uxjZ/jIEANN3+xprWRkvz4ddmgArJ7l
         p8fnsOa8FwDegA635o030YNI++u4BinMAjKegMN3z8AlMKZPjnOsO9Pgip1LyITuQsV+
         g55Q==
X-Gm-Message-State: AOJu0YzNfVoaIP/fROnKng0igGriH0IXYp+Yc+VZp8NG1gBBDkckwiXH
	nCWFA3RLnzU1u6g7ptlrOaj0AApraq3960UTsVvWqWdLCw8ySaUqA70vC+YvY5YVTzhN+Ev5EKM
	zidZgqF0tjxKW5gLEvDGHW5mnhlpiWUdPUi524++sRZE9NoUgkKA5vJkCwXBFiKY3zknHxC+Byi
	boSOmuYEi9ERllZT9+5spDnks=
X-Google-Smtp-Source: AGHT+IGmqJUoy3IsGyBoSWo21FWveS3/PadC+8tnN+PS9h2l4Sjcs37cnTCg5SzYaOr2Pm9SmpOwWl/Lzw==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a63:3858:0:b0:7ea:6ca8:bec5 with SMTP id
 41be03b00d2f7-7eacc893602mr16989a12.7.1729610964128; Tue, 22 Oct 2024
 08:29:24 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:29:04 +0000
In-Reply-To: <20241022152913.574836-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022152913.574836-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022152913.574836-5-jrife@google.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Retire test_sock.c
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Completely remove test_sock.c and associated config.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/.gitignore  |   1 -
 tools/testing/selftests/bpf/Makefile    |   3 +-
 tools/testing/selftests/bpf/test_sock.c | 231 ------------------------
 3 files changed, 1 insertion(+), 234 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/test_sock.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index e6533b3400de..d45c9a9b304d 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -16,7 +16,6 @@ fixdep
 /test_progs-cpuv4
 test_verifier_log
 feature
-test_sock
 urandom_read
 test_sockmap
 test_lirc_mode2_user
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 28a76baa854d..c4fc9a3291a8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -84,7 +84,7 @@ endif
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_sock test_sockmap \
+	test_sockmap \
 	test_tcpnotify_user test_sysctl \
 	test_progs-no_alu32
 TEST_INST_SUBDIRS := no_alu32
@@ -335,7 +335,6 @@ JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 
-$(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
deleted file mode 100644
index f97850f1d84a..000000000000
--- a/tools/testing/selftests/bpf/test_sock.c
+++ /dev/null
@@ -1,231 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Facebook
-
-#include <stdio.h>
-#include <unistd.h>
-
-#include <arpa/inet.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-
-#include <linux/filter.h>
-
-#include <bpf/bpf.h>
-
-#include "cgroup_helpers.h"
-#include <bpf/bpf_endian.h>
-#include "bpf_util.h"
-
-#define CG_PATH		"/foo"
-#define MAX_INSNS	512
-
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-static bool verbose = false;
-
-struct sock_test {
-	const char *descr;
-	/* BPF prog properties */
-	struct bpf_insn	insns[MAX_INSNS];
-	enum bpf_attach_type expected_attach_type;
-	enum bpf_attach_type attach_type;
-	/* Socket properties */
-	int domain;
-	int type;
-	/* Endpoint to bind() to */
-	const char *ip;
-	unsigned short port;
-	unsigned short port_retry;
-	/* Expected test result */
-	enum {
-		LOAD_REJECT,
-		ATTACH_REJECT,
-		BIND_REJECT,
-		SUCCESS,
-		RETRY_SUCCESS,
-		RETRY_REJECT
-	} result;
-};
-
-static struct sock_test tests[] = {
-};
-
-static size_t probe_prog_length(const struct bpf_insn *fp)
-{
-	size_t len;
-
-	for (len = MAX_INSNS - 1; len > 0; --len)
-		if (fp[len].code != 0 || fp[len].imm != 0)
-			break;
-	return len + 1;
-}
-
-static int load_sock_prog(const struct bpf_insn *prog,
-			  enum bpf_attach_type attach_type)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, opts);
-	int ret, insn_cnt;
-
-	insn_cnt = probe_prog_length(prog);
-
-	opts.expected_attach_type = attach_type;
-	opts.log_buf = bpf_log_buf;
-	opts.log_size = BPF_LOG_BUF_SIZE;
-	opts.log_level = 2;
-
-	ret = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", prog, insn_cnt, &opts);
-	if (verbose && ret < 0)
-		fprintf(stderr, "%s\n", bpf_log_buf);
-
-	return ret;
-}
-
-static int attach_sock_prog(int cgfd, int progfd,
-			    enum bpf_attach_type attach_type)
-{
-	return bpf_prog_attach(progfd, cgfd, attach_type, BPF_F_ALLOW_OVERRIDE);
-}
-
-static int bind_sock(int domain, int type, const char *ip,
-		     unsigned short port, unsigned short port_retry)
-{
-	struct sockaddr_storage addr;
-	struct sockaddr_in6 *addr6;
-	struct sockaddr_in *addr4;
-	int sockfd = -1;
-	socklen_t len;
-	int res = SUCCESS;
-
-	sockfd = socket(domain, type, 0);
-	if (sockfd < 0)
-		goto err;
-
-	memset(&addr, 0, sizeof(addr));
-
-	if (domain == AF_INET) {
-		len = sizeof(struct sockaddr_in);
-		addr4 = (struct sockaddr_in *)&addr;
-		addr4->sin_family = domain;
-		addr4->sin_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr4->sin_addr) != 1)
-			goto err;
-	} else if (domain == AF_INET6) {
-		len = sizeof(struct sockaddr_in6);
-		addr6 = (struct sockaddr_in6 *)&addr;
-		addr6->sin6_family = domain;
-		addr6->sin6_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr6->sin6_addr) != 1)
-			goto err;
-	} else {
-		goto err;
-	}
-
-	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
-		/* sys_bind() may fail for different reasons, errno has to be
-		 * checked to confirm that BPF program rejected it.
-		 */
-		if (errno != EPERM)
-			goto err;
-		if (port_retry)
-			goto retry;
-		res = BIND_REJECT;
-		goto out;
-	}
-
-	goto out;
-retry:
-	if (domain == AF_INET)
-		addr4->sin_port = htons(port_retry);
-	else
-		addr6->sin6_port = htons(port_retry);
-	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
-		if (errno != EPERM)
-			goto err;
-		res = RETRY_REJECT;
-	} else {
-		res = RETRY_SUCCESS;
-	}
-	goto out;
-err:
-	res = -1;
-out:
-	close(sockfd);
-	return res;
-}
-
-static int run_test_case(int cgfd, const struct sock_test *test)
-{
-	int progfd = -1;
-	int err = 0;
-	int res;
-
-	printf("Test case: %s .. ", test->descr);
-	progfd = load_sock_prog(test->insns, test->expected_attach_type);
-	if (progfd < 0) {
-		if (test->result == LOAD_REJECT)
-			goto out;
-		else
-			goto err;
-	}
-
-	if (attach_sock_prog(cgfd, progfd, test->attach_type) < 0) {
-		if (test->result == ATTACH_REJECT)
-			goto out;
-		else
-			goto err;
-	}
-
-	res = bind_sock(test->domain, test->type, test->ip, test->port,
-			test->port_retry);
-	if (res > 0 && test->result == res)
-		goto out;
-
-err:
-	err = -1;
-out:
-	/* Detaching w/o checking return code: best effort attempt. */
-	if (progfd != -1)
-		bpf_prog_detach(cgfd, test->attach_type);
-	close(progfd);
-	printf("[%s]\n", err ? "FAIL" : "PASS");
-	return err;
-}
-
-static int run_tests(int cgfd)
-{
-	int passes = 0;
-	int fails = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
-		if (run_test_case(cgfd, &tests[i]))
-			++fails;
-		else
-			++passes;
-	}
-	printf("Summary: %d PASSED, %d FAILED\n", passes, fails);
-	return fails ? -1 : 0;
-}
-
-int main(int argc, char **argv)
-{
-	int cgfd = -1;
-	int err = 0;
-
-	cgfd = cgroup_setup_and_join(CG_PATH);
-	if (cgfd < 0)
-		goto err;
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	if (run_tests(cgfd))
-		goto err;
-
-	goto out;
-err:
-	err = -1;
-out:
-	close(cgfd);
-	cleanup_cgroup_environment();
-	return err;
-}
-- 
2.47.0.105.g07ac214952-goog


