Return-Path: <bpf+bounces-23222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E782386EDCE
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6025D1F23F5B
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD3A92A;
	Sat,  2 Mar 2024 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHTZ5TZV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539F6FCB
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342389; cv=none; b=kKz/GrULIYJ6WM1JMwlSkykskR5JH040AOqq6vy3nk2ZTHZPhKxVKTmfF2z4e+WQbXq/cayRRrX1djyzglKFWqhTW7ssj9VuB+nnb2lovG+p2Ni0nHHJvjYSqduH1q4229htGDl+VRZC/7VSKyApwUoob5Yr5Kne+Cdb7SDj9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342389; c=relaxed/simple;
	bh=Zstjkfo3bBrEk6tk8nr74zGWRnaol7vk00gw0zqL1lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV+/H/0N6QPyRavsX860FF3mxIDnZXF2bf8TPgqAqtHzAFRTE5rsQbMK1uZjdO6wu2ITb57gXAcTgPrHim/QyPvpzldw6JNcHHUYQZTQWqZufXUQsvB8TcipONdzMd+KgQOxBRQlHL5zj86o7eOZggixP3zYRjlS5DKedka+6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHTZ5TZV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d2628e81b8so36043931fa.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342385; x=1709947185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8A22T63G5iQ7IQHgXyef1fcl9DNwEtXo9q+rag5wGk=;
        b=mHTZ5TZV2a9uB85c58i9fPbBdWlC/W0H4/fufZmdtkLJRXy2no0ekHy+uCGrxs6RDD
         PPZqeoUfV7NnscN7CNojy+9uAS8vwSNElq7dHFdmx+FFJJRCiSfpWcjy0vNb8ar4kc1R
         123VHPNJeROBvyt8bsHUIKU4XINIneTv+nC2Mt9VDiQI72BAjyoGydUPIXeOWy1ZuXLn
         BcEcFCfBAo+SiWSlnrgKvkDVv4lTCp9tDEicoBpSo5qpsIAYxxIh6AV4j72m3ifzi9kg
         LlZK1uSP+UWMJsNelAQBvhwJFQJmXmodPV8unWgFvVx8b9G1Clq0CxRBfCCgAUvKDTnC
         vNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342385; x=1709947185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8A22T63G5iQ7IQHgXyef1fcl9DNwEtXo9q+rag5wGk=;
        b=evez3sO3ifIut/XrhiLfdvfLv7TrWT9TMkrHvRBfN/V1q/4l0KRCAX59+KgP6modAN
         hdcOpju1DSZ11S/5YzQjvR4yXrM/IgFPsTcRLVg+fP5vqE3WWnCtZVNUegqIy5h6tYwB
         exWicKRpC74Wf280UHqik/rRYCsnsnRaBwy+HOVWYP9dcLBBgi/vtSAPr2fFkOa0Gn4L
         itKsMYhNP+Ti5Do1u2SYyBCzvCS9A9SZCrxsw7ZapYez5tRg3N2AN+8ORJ7jYBFZWKym
         q8DW3TkMi5GCl8Ehnc0hfB7ZXmvYjq4ByEhTHlaIxhMCb9TPui2fGZIQz3OzDDXVl3UE
         06Ig==
X-Gm-Message-State: AOJu0YxUhZYkhHofdHALiCOaX6BKPOXFAjxnvdox2Kl81CzQ9IIu3ULW
	e1DQLbrl3r/fBqzAaQ2v7SppwClRJOcBwxvu4aZdMhnUeWhidnysPnnbiS3U
X-Google-Smtp-Source: AGHT+IEX/Hhfw82vdEDH1SRoXUzZ/MaOGNRfiemh5ROE0UKQnHJCdO/Ue5h+/+6+2BDwhI0HsNkJIw==
X-Received: by 2002:a2e:9bd1:0:b0:2d2:e970:f992 with SMTP id w17-20020a2e9bd1000000b002d2e970f992mr1411737ljj.21.1709342385157;
        Fri, 01 Mar 2024 17:19:45 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:44 -0800 (PST)
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
Subject: [PATCH bpf-next v2 09/15] selftests/bpf: verify struct_ops autoload/autocreate sync
Date: Sat,  2 Mar 2024 03:19:14 +0200
Message-ID: <20240302011920.15302-10-eddyz87@gmail.com>
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

Check that autocreate flag set to false for struct_ops map causes
autoload flag set to false for corresponding program.

Check that struct_ops program not referenced from any map fails to load.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/bad_struct_ops.c | 32 +++++++++++++++++++
 .../bpf/prog_tests/struct_ops_autocreate.c    | 11 ++++---
 .../selftests/bpf/progs/bad_struct_ops2.c     | 14 ++++++++
 3 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
index 9f5dbefa0dd9..6a707213e46b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "bad_struct_ops.skel.h"
+#include "bad_struct_ops2.skel.h"
 
 static void invalid_prog_reuse(void)
 {
@@ -28,8 +29,39 @@ static void invalid_prog_reuse(void)
 	bad_struct_ops__destroy(skel);
 }
 
+static void unused_program(void)
+{
+	struct bad_struct_ops2 *skel;
+	char *log = NULL;
+	int err;
+
+	skel = bad_struct_ops2__open();
+	if (!ASSERT_OK_PTR(skel, "bad_struct_ops2__open"))
+		return;
+
+	/* struct_ops programs not referenced from any maps are open
+	 * with autoload set to true.
+	 */
+	ASSERT_TRUE(bpf_program__autoload(skel->progs.foo), "foo autoload == true");
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+
+	err = bad_struct_ops2__load(skel);
+	ASSERT_ERR(err, "bad_struct_ops2__load should fail");
+	log = stop_libbpf_log_capture();
+	ASSERT_HAS_SUBSTR(log, "prog 'foo': failed to load",
+			  "message about 'foo' failing to load");
+
+cleanup:
+	free(log);
+	bad_struct_ops2__destroy(skel);
+}
+
 void test_bad_struct_ops(void)
 {
 	if (test__start_subtest("invalid_prog_reuse"))
 		invalid_prog_reuse();
+	if (test__start_subtest("unused_program"))
+		unused_program();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
index c67d0b32b9dc..765b0ec6383a 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -35,18 +35,19 @@ static void cant_load_full_object(void)
 
 static void can_load_partial_object(void)
 {
-	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct struct_ops_autocreate *skel;
 	struct bpf_link *link = NULL;
 	int err;
 
-	skel = struct_ops_autocreate__open_opts(&opts);
+	skel = struct_ops_autocreate__open();
 	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
 		return;
 
-	err = bpf_program__set_autoload(skel->progs.test_2, false);
-	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
-		goto cleanup;
+	/* struct_ops programs referenced from maps are open with
+	 * autoload set to false.
+	 */
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.test_1), "test_1 autoload == false");
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.test_2), "test_2 autoload == false");
 
 	err = bpf_map__set_autocreate(skel->maps.testmod_2, false);
 	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops2.c b/tools/testing/selftests/bpf/progs/bad_struct_ops2.c
new file mode 100644
index 000000000000..64a95f6be86d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bad_struct_ops2.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* This is an unused struct_ops program, it lacks corresponding
+ * struct_ops map, which provides attachment information.
+ * W/o additional configuration attempt to load such
+ * BPF object file would fail.
+ */
+SEC("struct_ops/foo")
+void foo(void) {}
-- 
2.43.0


