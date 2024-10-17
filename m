Return-Path: <bpf+bounces-42351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057569A3105
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF5B28692B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDA81D969C;
	Thu, 17 Oct 2024 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1fm2o0G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810F1D86CD
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205459; cv=none; b=RUv6USS+XR2mGB3R0Sbx11vDHoCcz5YsjCtJaXMaKYijgsnkRcfYjeM6Kl2rW49vdXSR+Eb3Kk0tOcm2fVGeX/yjUdeg2pf3Bg2A/AQcFS44cG2TEKDvfsu4J3jPb28tACWN8Xuem2vbudv4mS3SH4CKFCPgjN2AK+VZO1r98SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205459; c=relaxed/simple;
	bh=aVNtV8GwMuZVkiYFkKbuTMqRFI5Mfyx2KtMQzSy7Vf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzoo42qT8EekFAkUhPVslt5QgPhGROK+1CMv8inkHvbZ8vWFw4HNnbA/yw24sMtR5AuVv0bQTnsCTRNx3bKm+THZAj+Fzl7dEBKORDN7dGCSBucqhU8YBbKX+/wL0F6rm+HADNDd1PyNQaDo27fH1+yTRmyBa4r9ESoRV0WGThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1fm2o0G; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c45296b3fso17598305ad.0
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729205457; x=1729810257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhk9joV6R0TOMDNjxCxV/zzdAgOxK1FiltkWvC0V3YQ=;
        b=g1fm2o0GlL8631X/3k3vCdlUqRiMNu9ORGkfHtP4/+dOnlUcWhd60roSxhbpKn4y/X
         d+h/8DoT+3W8vEijRefxV0MHnegVBQE9p05Q7Ousj744pK6W49e/WCc+YMpCQpfbReCK
         sa7jNfQHCFzVYek8N8cw6f+llaCVf8IP1v7Mnb0rLkTuwujl24Vo32VedxqN+cCP3vQu
         0PwCwnJqjx913V14bTcQZeEH0pQBqDLe8d/8CAWNDoAnFIw6r/wLay+QyywbtxDLQgpA
         bT/EBlnpIo7v55N+uzRwgSFD7nL9ymB6NmOgqxaviDr+Cl5eOXCvnestbABDoEv2eKFm
         pVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205457; x=1729810257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhk9joV6R0TOMDNjxCxV/zzdAgOxK1FiltkWvC0V3YQ=;
        b=oJkxZoXi7O3dFOm8wQtXJKzTm2nYJ2E5vHA4Sf8vsz102jjTNNJ1WZykpAk4cZ5Kbm
         CgmxLrJIC7mk0T3gOdRakcc9Lmf38drnVlqoQQ9Eh60St1C8ZytksKQIQb5rAwxkbvyu
         n8ndGh1RFdFZDB22ThZC1wRwdqg4hU5rvNKt8dc8L0dZbAyHfkIcbAsUtlfzdNnsmveV
         2hK4V3t/AE6bNFR1lmAwnRwu7FEFo9HcnYWPmzbhpon9kUNNUP7FCdMwAOjbahjLhrQR
         SvXLYg21rhEkH10ZgThwFNRgPdTRvDCStFKxyY1/qKyOsXBx5PEWeCv3DZ5Lf20qezwd
         uzSA==
X-Gm-Message-State: AOJu0YzMpBoVVM4juo0jziMQ80W6iGDIkesjbOJUy4xW0DqjDoPEBSQB
	Xd71b/cPoKYUgnocrMgQunFRDQFHxNk+luvX+AuA8Y8CNY5tpNS51z5LYjbdFRwqiYfiH1gdRaO
	8NYRYXf58vPEyvxxi4BPozniE/EBd/O6KvmggWma4W904Dm49SH++r7zZRmsG7odZWUPYfwiYb5
	Rp9fvjUpZrxYGAmuY5I+OuKjg=
X-Google-Smtp-Source: AGHT+IGgnwit9Rz9y7vLHfdk5WPlkaCRGUhWlhTHm1GJeu0LC3tuksbzm3j9SlTttSgmQ4In3cKremL9lw==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a17:902:ecc1:b0:20c:5d7c:6332 with SMTP id
 d9443c01a7336-20e59aa0f00mr12035ad.0.1729205455979; Thu, 17 Oct 2024 15:50:55
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:49:22 +0000
In-Reply-To: <20241017225031.2448426-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017225031.2448426-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017225031.2448426-5-jrife@google.com>
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Retire test_sock.c
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
2.47.0.rc1.288.g06298d1525-goog


