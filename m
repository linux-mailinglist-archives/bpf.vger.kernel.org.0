Return-Path: <bpf+bounces-60140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3BAD31BF
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A6A1886FB8
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D11D28B7D7;
	Tue, 10 Jun 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqxvV+Bn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D028B3FF
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547195; cv=none; b=LmIJ6PA1lcIDoTYu1+ef32VFeQQ1sH1C0ebjEbnZsMtWmReq+efH0kWcEWnQqirTz8TIzcMsu4WzZJZkLwsah2YcJPMsCfMqYs7M73Sc0rk1Ln2Lw3QoX+h7SwxRMF/oCa0CjcSqN/H5HoQhNApvApAttaS4iH6nTtoekNUYy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547195; c=relaxed/simple;
	bh=m3QPIf1lS1FLCWqYBfYXmXH8UzK5MkjHUdqx0zJoLdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpyCyPPqc/73slVnf3iho1x4TNY83A8vUKJdeWO+VVAeYmFPVXOpW51NxgTkDBWvNmDKNkLSQgjRZFijrqAjoNEDgfBelO/0NjrWI2qLOSwiqOchxACJrQ2IfQTE2DhZCgHY/DY6qyhXOUeQ53ZsRX1Ytq1wC4A+5w5YpTKp6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqxvV+Bn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749547192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YfGEaES37tUIdfNDtsElA5nBwIdrKb6uYDOTFUqS6Y=;
	b=MqxvV+BnyhF4ILaQDHQA4ErtWlKSG9GrOABCMDjW9oNeTYaC1nt1qdBiuD8ONbiq+gsil4
	nU+f8RWHeoJQX68atlR03oyWxzIp5k3hMNxEtVoGT74X29UgCwHRXKPjilFNMdHUHO84WC
	O8P/gTnFLIw0r2vtxnXa7N/1kPDw30g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-z6xL1PvxMzaAe3irMX5X7g-1; Tue,
 10 Jun 2025 05:19:49 -0400
X-MC-Unique: z6xL1PvxMzaAe3irMX5X7g-1
X-Mimecast-MFC-AGG-ID: z6xL1PvxMzaAe3irMX5X7g_1749547188
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC4C11800287;
	Tue, 10 Jun 2025 09:19:47 +0000 (UTC)
Received: from fedora (unknown [10.45.225.84])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7FC8E195608D;
	Tue, 10 Jun 2025 09:19:44 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Tue, 10 Jun 2025 11:19:43 +0200
From: "Jerome Marchand" <jmarchan@redhat.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH v2 2/2] selftests/bpf: Convert test_sysctl to prog_tests
Date: Tue, 10 Jun 2025 11:19:33 +0200
Message-ID: <20250610091933.717824-3-jmarchan@redhat.com>
In-Reply-To: <20250610091933.717824-1-jmarchan@redhat.com>
References: <20250527165412.533335-1-jmarchan@redhat.com>
 <20250610091933.717824-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Convert test_sysctl test to prog_tests with minimal change to the
tests themselves.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 tools/testing/selftests/bpf/.gitignore        |  1 -
 tools/testing/selftests/bpf/Makefile          |  5 ++-
 .../bpf/{ => prog_tests}/test_sysctl.c        | 32 ++++---------------
 3 files changed, 9 insertions(+), 29 deletions(-)
 rename tools/testing/selftests/bpf/{ => prog_tests}/test_sysctl.c (98%)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index e2a2c46c008b1..3d8378972d26c 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -21,7 +21,6 @@ test_lirc_mode2_user
 flow_dissector_load
 test_tcpnotify_user
 test_libbpf
-test_sysctl
 xdping
 test_cpp
 *.d
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 66bb50356be08..53dc08d905bd1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -70,7 +70,7 @@ endif
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
 	test_sockmap \
-	test_tcpnotify_user test_sysctl \
+	test_tcpnotify_user \
 	test_progs-no_alu32
 TEST_INST_SUBDIRS := no_alu32
 
@@ -215,7 +215,7 @@ ifeq ($(VMLINUX_BTF),)
 $(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
 endif
 
-# Define simple and short `make test_progs`, `make test_sysctl`, etc targets
+# Define simple and short `make test_progs`, `make test_maps`, etc targets
 # to build individual tests.
 # NOTE: Semicolon at the end is critical to override lib.mk's default static
 # rule for binaries.
@@ -324,7 +324,6 @@ NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
-$(OUTPUT)/test_sysctl: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
 $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
 $(OUTPUT)/xdping: $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
similarity index 98%
rename from tools/testing/selftests/bpf/test_sysctl.c
rename to tools/testing/selftests/bpf/prog_tests/test_sysctl.c
index bcdbd27f22f08..049671361f8fa 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
@@ -1,22 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 
-#include <fcntl.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include <linux/filter.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include <bpf/bpf_endian.h>
-#include "bpf_util.h"
+#include "test_progs.h"
 #include "cgroup_helpers.h"
-#include "testing_helpers.h"
 
 #define CG_PATH			"/foo"
 #define MAX_INSNS		512
@@ -1608,26 +1594,22 @@ static int run_tests(int cgfd)
 	return fails ? -1 : 0;
 }
 
-int main(int argc, char **argv)
+void test_sysctl(void)
 {
 	int cgfd = -1;
-	int err = 0;
 
 	cgfd = cgroup_setup_and_join(CG_PATH);
-	if (cgfd < 0)
-		goto err;
+	if (CHECK_FAIL(cgfd < 0))
+		goto out;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 
-	if (run_tests(cgfd))
-		goto err;
+	if (CHECK_FAIL(run_tests(cgfd)))
+		goto out;
 
-	goto out;
-err:
-	err = -1;
 out:
 	close(cgfd);
 	cleanup_cgroup_environment();
-	return err;
+	return;
 }
-- 
2.49.0


