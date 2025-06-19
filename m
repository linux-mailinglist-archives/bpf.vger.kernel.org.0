Return-Path: <bpf+bounces-61082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E4AE0846
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A1016D248
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030CE28B7E7;
	Thu, 19 Jun 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+frvmtt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCE263F4A
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341988; cv=none; b=lpqMbQPSTY5S0sUhFExpC30v4U666r1fTH8PmXfGtJV+R9HyWLSPl4N3IxR/uouKThkOU4zmwE9M1HfaeM9Oqjkwm5I3LQUCBFU4W3RFXWo+X3126fiwJbRYtKdUyrE/r1mGWNYrkzgN25HFhAaPmYiUsmdfyLVmKR2EGu80VeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341988; c=relaxed/simple;
	bh=mNbUYvZReUbPX24HxzYrXfLJ05cI+cpHUEK2EdjWNwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJE47JVZNgJDCskeWTNMVuioOe5DQhZz6VgrlQQAPYt4NJL+YCL4sBRsYw9pZD2b83J5RuSO9/CCypX/Phn/ec2x+7UgYF8RDiyM9oodGgLmTLYz57zqLsYBWdKqEaj9nARXy5iU8grqZCkuASSj97x6XaSshP67+yd6IHdZms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+frvmtt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750341986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rFJy2cGcGcOiZjoBdoVKK7T7Guml8LSC5Piayfcnbo=;
	b=Z+frvmtt/pVNM2pt6D0dn8AbouCeZfCVWUn0uaDIFcSgxb0364s1kLKAsBlWmOavQs7eTi
	m6hkT3XJhUUWOXNarBgU+YyXlvXm2H/rGnGbbpnxKbKBdrNd38RwxlmLzw3fdDbOyz3G+8
	LmLeXajvsp6HW/VSxlND86rSJffSjY8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-prla-sTlMFOhS4rQhKUc6A-1; Thu,
 19 Jun 2025 10:06:24 -0400
X-MC-Unique: prla-sTlMFOhS4rQhKUc6A-1
X-Mimecast-MFC-AGG-ID: prla-sTlMFOhS4rQhKUc6A_1750341982
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C77C1800283;
	Thu, 19 Jun 2025 14:06:22 +0000 (UTC)
Received: from fedora (unknown [10.45.226.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2F38F19560A3;
	Thu, 19 Jun 2025 14:06:17 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Thu, 19 Jun 2025 16:06:16 +0200
From: "Jerome Marchand" <jmarchan@redhat.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH v3 2/2] selftests/bpf: Convert test_sysctl to prog_tests
Date: Thu, 19 Jun 2025 16:06:03 +0200
Message-ID: <20250619140603.148942-3-jmarchan@redhat.com>
In-Reply-To: <20250619140603.148942-1-jmarchan@redhat.com>
References: <20250619140603.148942-1-jmarchan@redhat.com>
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
 tools/testing/selftests/bpf/Makefile          |  5 +--
 .../bpf/{ => prog_tests}/test_sysctl.c        | 37 ++++---------------
 3 files changed, 10 insertions(+), 33 deletions(-)
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
index bcdbd27f22f08..273dd41ca09e4 100644
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
@@ -1608,26 +1594,19 @@ static int run_tests(int cgfd)
 	return fails ? -1 : 0;
 }
 
-int main(int argc, char **argv)
+void test_sysctl(void)
 {
-	int cgfd = -1;
-	int err = 0;
+	int cgfd;
 
 	cgfd = cgroup_setup_and_join(CG_PATH);
-	if (cgfd < 0)
-		goto err;
+	if (!ASSERT_OK_FD(cgfd < 0, "create_cgroup"))
+		goto out;
 
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+	if (!ASSERT_OK(run_tests(cgfd), "run_tests"))
+		goto out;
 
-	if (run_tests(cgfd))
-		goto err;
-
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


