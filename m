Return-Path: <bpf+bounces-23219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE7786EDCC
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7AE4B23855
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603079EA;
	Sat,  2 Mar 2024 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgCAYCSa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70217489
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342385; cv=none; b=NuPluXKUzFhM9/jrpAYb/vxchZEtlc0XJeH436EBCQgiq2l2owRFSvU7eyBV6d3QeZ/Pa1bA0YFIsCG4YW67BXwpBeExLEVz3I5ZKt3xr1W3uvDTIGZHh+21IguB+ue3+JSdoXUfUPfsB2I1xJDmRDVvC95ztmaYnUVEB51UacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342385; c=relaxed/simple;
	bh=T9Tg69UkPoHBYpyj0IQGWeVNmt0BhhIt5JaJNfhMswQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=levpQub81oSD6NUHoqcihRc55X4mhxMOufCXBwY1b6w0b90bIFVmOUkGieSJDOn779f01abi8aSpItXzcETgljLrRVuzXPiAO2CQVeLzt2bU9PW5ZJkuq9P0AQfXZNSMCmXY5ArPRu/UcjHE1IUkk12M28I/Zgtwz/bWdfcva90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgCAYCSa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d33986dbc0so14929251fa.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342381; x=1709947181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HloUQLeyf3X91OgKXgvzmZERUb4RBb98Jjf4ea1gRCQ=;
        b=dgCAYCSaI4CifMDfbzGYlva4F/TFYHpQfFsj4QbJAa6rceGWHLQM8gwSTUwgzewaKf
         LeX7YVtfIMv8EpEbI+IVb2r1TLO1D884gAehxnWlhzo8Tri2strB/K4Kpcd2BnaIMd1A
         cNStKkR79hTpvvZmN8Ws9Emv4+p1mo2h33aq8vcUYMXQXUIVfkklNGYK0hy8MsjDDNSZ
         1mPQfMwlQe6b6g4Z6T31uWB7LUb+f0AZRDiKhFwWuNqpwOImwq+bY85LzYy96il6oIp9
         eGzt5fa8njlqjCWcJA3dirHOG+wrEoywDjktOGNrJEV54FF37OYxnF+Mq54sJHfZS+Ty
         /4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342381; x=1709947181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HloUQLeyf3X91OgKXgvzmZERUb4RBb98Jjf4ea1gRCQ=;
        b=WzdWXvACcKu/tR7O+1lNUCg/nyKo1LHPGUZPx2tiPoxhW5ZMG7Pd9Z+ccEBSI2tw0V
         QwJe897AYhTI4om8tNbpPdjBIsEuT+pF/qH9Wn4RaZnCve6edh5qg4gIyt/c4nnvofAL
         kRgHvuZd1nf1ZP4tCTzOoKZ2CIhDTvUQVMjrHurDK8GGlFECQSYMKSv4d+aWuaVAUxdW
         6WFQAHlRD/D0UcFXcfpedlhCiK9u0IOu60Xg0se73grSU1a42yVHcw0lASUGW7mLHTMI
         kjfsUUmDYwgZgCtIwTkAdPTuIjrDay1UhglGBpFwgQRziliPW1sDpvHukwpJEtIOqrzm
         svzA==
X-Gm-Message-State: AOJu0Yyyolq/c6miUhQN46JcGhudRq+xG0J95WoCumuR+sUOgSZ9KCW0
	jt/rHebpzYwhsaQonq4busXmEMitzub62L5t6Mo9kNkULbYI9LPQpSiDveOa
X-Google-Smtp-Source: AGHT+IGMmQqnz0jtNPyMIDrVpZe7oVjFnPrHqk3/tlH50EFDiNArZAyReIDQS9v0/imAch/8Rsu5+Q==
X-Received: by 2002:a2e:a9a8:0:b0:2d3:72e8:1a66 with SMTP id x40-20020a2ea9a8000000b002d372e81a66mr5343ljq.23.1709342381617;
        Fri, 01 Mar 2024 17:19:41 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:41 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 06/15] selftests/bpf: bad_struct_ops test
Date: Sat,  2 Mar 2024 03:19:11 +0200
Message-ID: <20240302011920.15302-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When loading struct_ops programs kernel requires BTF id of the
struct_ops type and member index for attachment point inside that
type. This makes it not possible to have same BPF program used in
struct_ops maps that have different struct_ops type.
Check if libbpf rejects such BPF objects files.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 +++
 .../selftests/bpf/prog_tests/bad_struct_ops.c | 35 +++++++++++++++++++
 .../selftests/bpf/progs/bad_struct_ops.c      | 25 +++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index b9ff88e3d463..2de7e80dbb4b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -610,6 +610,29 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.owner = THIS_MODULE,
 };
 
+static int bpf_dummy_reg2(void *kdata)
+{
+	struct bpf_testmod_ops2 *ops = kdata;
+
+	ops->test_1();
+	return 0;
+}
+
+static struct bpf_testmod_ops2 __bpf_testmod_ops2 = {
+	.test_1 = bpf_testmod_test_1,
+};
+
+struct bpf_struct_ops bpf_testmod_ops2 = {
+	.verifier_ops = &bpf_testmod_verifier_ops,
+	.init = bpf_testmod_ops_init,
+	.init_member = bpf_testmod_ops_init_member,
+	.reg = bpf_dummy_reg2,
+	.unreg = bpf_dummy_unreg,
+	.cfi_stubs = &__bpf_testmod_ops2,
+	.name = "bpf_testmod_ops2",
+	.owner = THIS_MODULE,
+};
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -621,6 +644,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
+	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 971458acfac3..c51c4eae9ed5 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -45,4 +45,8 @@ struct bpf_testmod_ops {
 	int data;
 };
 
+struct bpf_testmod_ops2 {
+	int (*test_1)(void);
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
new file mode 100644
index 000000000000..9f5dbefa0dd9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "bad_struct_ops.skel.h"
+
+static void invalid_prog_reuse(void)
+{
+	struct bad_struct_ops *skel;
+	char *log = NULL;
+	int err;
+
+	skel = bad_struct_ops__open();
+	if (!ASSERT_OK_PTR(skel, "bad_struct_ops__open"))
+		return;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+
+	err = bad_struct_ops__load(skel);
+	log = stop_libbpf_log_capture();
+	ASSERT_ERR(err, "bad_struct_ops__load should fail");
+	ASSERT_HAS_SUBSTR(log,
+		"struct_ops init_kern testmod_2 func ptr test_1: invalid reuse of prog test_1",
+		"expected init_kern message");
+
+cleanup:
+	free(log);
+	bad_struct_ops__destroy(skel);
+}
+
+void test_bad_struct_ops(void)
+{
+	if (test__start_subtest("invalid_prog_reuse"))
+		invalid_prog_reuse();
+}
diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops.c b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
new file mode 100644
index 000000000000..b7e175cd0af0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1) { return 0; }
+
+SEC("struct_ops/test_2")
+int BPF_PROG(test_2) { return 0; }
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops2 testmod_2 = {
+	.test_1 = (void *)test_1
+};
-- 
2.43.0


