Return-Path: <bpf+bounces-22793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC79686A107
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA90CB22C1A
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435F14EFE6;
	Tue, 27 Feb 2024 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1W1fAG6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51076134B1
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066799; cv=none; b=Oo1TJAiCdP5P0X/UvZf38qbeQidYSI3eoq4NLIwhclPckDh8SNhQhM49AJGYpLG6jtU+n4aGIv/FOBhWYAqw8Pvnco3ohKlkVkVUw8Y+yNU1d16eZPQENs3KpuPMSzxg37TNGQ2riRaoiv5ASUt65qO36Gdc4WQ491o1ABVR5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066799; c=relaxed/simple;
	bh=yx2T0eErEpHQT0ydcArJMHUqBSR4JhQLrDsYp6okSMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7NhmddIxC/FlAZrTkhyHT6tBGsG4CVUM1hvboIjKfNVDPSKNfV6EO55wXe1AsggmFjlc1ME9PHuJZSUMnu3NWLRzzaZS1btXdcldm/MAwBxRCyItK4nrvlDZ63qJX6r7UKeo8Mqhb2uIAmNBVtzC5AZnX+YMXmlqNcyq0jY3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1W1fAG6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3122b70439so594169666b.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066795; x=1709671595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NufEqf5XNfMeRf8MUUisjrX5VArk6s8sDiv8AT6NiWY=;
        b=k1W1fAG6KTzc/3BWnE0NkpgnCZg1aANPkJOgLIZdzucH+Gi1XjPwaZB6tnXqa2OSDP
         aWdrIiNNwnU5nMMqc8BpH548AJ5s/qKBAWzP67nG2JBY845Q7mgBNeramT2o1E8Zz0Yg
         bqdgKoMY8oL04LIz8Z3mcyFGBIOfORpDMaju8rFHmptYrkkz1p8Kzjv1GSgmSu6mzO9a
         OMHuAZWoS1CsCfKp8M/5xntn9N+CbZ0UnLbrtTzar4m+ODNhAhJj6jXTY4+LmohF4Uof
         rW473dmqZK9CvhGf5DbaaoQK5zHru2MoQpog4l5rWIY4rwWGJNqt7maJGDHODtmjxo+a
         IhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066795; x=1709671595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NufEqf5XNfMeRf8MUUisjrX5VArk6s8sDiv8AT6NiWY=;
        b=IdqYNdRQwOZl1S7PoSp1USweO6egGTrtnfTbOzIaXNQtiKhgyOiN0+s9Nh7srpsrTh
         5M9hNku1MDf6kz2mQKuQYUX03vXFphrHfWT6lMebbj27sg1Qy1BTkxvP+QJaNEUbGewJ
         OteQYyOhxdgKdJ1z9IQYxbZY9aW8nlXReYuBw2R8ptcpejXePdgX3ChtJgQw6oy1FCNr
         5xX+ev1k/ldA3w29SVWjzA+jSUqnnagVhPVA8FUuOlbLhVYc1QuukolZkbptcOr1d2Sj
         OzTGM8iG6mDcRKdlbdvFnIUednm14erTPYIQVaXwY8absPcaFNlrShsNT6uiyohAp08V
         WgPQ==
X-Gm-Message-State: AOJu0YwHcLGqXchPccQgzB9J1Tl92WSikFwzkWH9T1fmronThZ4bazy5
	csdY71OovMzxdIjxf4SE43XqXIoDrDh+R6b1Nroaecrw8qPF3aPJrprDU33ZL4I=
X-Google-Smtp-Source: AGHT+IET1gJuQtkMad8eJRx9sb6cLMFuB5wTuM2pGqUdXatVwnytzBV94OHnkHc1AWPDWfFm1ck1yQ==
X-Received: by 2002:a17:906:48d9:b0:a43:3107:df92 with SMTP id d25-20020a17090648d900b00a433107df92mr5323454ejt.36.1709066795292;
        Tue, 27 Feb 2024 12:46:35 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:34 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior for struct_ops maps
Date: Tue, 27 Feb 2024 22:45:54 +0200
Message-ID: <20240227204556.17524-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227204556.17524-1-eddyz87@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that bpf_map__set_autocreate() can be used to disable automatic
creation for struct_ops maps.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/struct_ops_autocreate.c    | 79 +++++++++++++++++++
 .../bpf/progs/struct_ops_autocreate.c         | 42 ++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
new file mode 100644
index 000000000000..b21b10f94fc2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_autocreate.skel.h"
+
+#define EXPECTED_MSG "libbpf: struct_ops init_kern"
+
+static libbpf_print_fn_t old_print_cb;
+static bool msg_found;
+
+static int print_cb(enum libbpf_print_level level, const char *fmt, va_list args)
+{
+	old_print_cb(level, fmt, args);
+	if (level == LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strlen(EXPECTED_MSG)) == 0)
+		msg_found = true;
+
+	return 0;
+}
+
+static void cant_load_full_object(void)
+{
+	struct struct_ops_autocreate *skel;
+	int err;
+
+	old_print_cb = libbpf_set_print(print_cb);
+	skel = struct_ops_autocreate__open_and_load();
+	err = errno;
+	libbpf_set_print(old_print_cb);
+	if (!ASSERT_NULL(skel, "struct_ops_autocreate__open_and_load"))
+		return;
+
+	ASSERT_EQ(err, ENOTSUP, "errno should be ENOTSUP");
+	ASSERT_TRUE(msg_found, "expected message");
+
+	struct_ops_autocreate__destroy(skel);
+}
+
+static void can_load_partial_object(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct struct_ops_autocreate *skel;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = struct_ops_autocreate__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
+		return;
+
+	err = bpf_program__set_autoload(skel->progs.test_2, false);
+	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
+		goto cleanup;
+
+	err = bpf_map__set_autocreate(skel->maps.testmod_2, false);
+	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
+		goto cleanup;
+
+	err = struct_ops_autocreate__load(skel);
+	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto cleanup;
+
+	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
+	ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	struct_ops_autocreate__destroy(skel);
+}
+
+void serial_test_struct_ops_autocreate(void)
+{
+	if (test__start_subtest("cant_load_full_object"))
+		cant_load_full_object();
+	if (test__start_subtest("can_load_partial_object"))
+		can_load_partial_object();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
new file mode 100644
index 000000000000..294d48bb8e3c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int test_1_result = 0;
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	test_1_result = 42;
+	return 0;
+}
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_2)
+{
+	return 0;
+}
+
+struct bpf_testmod_ops___v1 {
+	int (*test_1)(void);
+};
+
+struct bpf_testmod_ops___v2 {
+	int (*test_1)(void);
+	int (*does_not_exist)(void);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___v1 testmod_1 = {
+	.test_1 = (void *)test_1
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___v2 testmod_2 = {
+	.test_1 = (void *)test_1,
+	.does_not_exist = (void *)test_2
+};
-- 
2.43.0


