Return-Path: <bpf+bounces-23220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AC286EDCB
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780B41C22115
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098C79F9;
	Sat,  2 Mar 2024 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnOa8frp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090DA749F
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342386; cv=none; b=l1zsNjA9gr16mS0ilQj/BHwGYMo95JxvWx93z0V7U14zlh+1JasIMlVPXX3nN6eGX2LcE/8+rbJpTXRF8XqriCvOdLhH2fZ9YjUYN53MjZTvmZ8YOPGtMd6wSCRtoM8/i2EuqMNjMgZM8iAB1v2U8uUUfdacib7Tj++b9S0qW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342386; c=relaxed/simple;
	bh=ZHnJiSrs/nymoXm4ZKu7PUP0TfqOApRaIo2hHzhRC6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDJjPOwXBg2JQrBaLtCV4G/9s9s/zzf61bz4HMGkLUGVKaqBJPHvBoUHEpcNn3/+Ba1J4Y41LNAAn+mrwtnC4LWjL1F5ejI7qFeOYnBu+Desgfir9qnzlRqwErV3aJW2LGNyxf+JZTj0qxzUnrSM8DYNqYjpMDIulusCXt+eLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnOa8frp; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so29835611fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342383; x=1709947183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcgPQmlhhkA8T/cZTKDZ07IXVO71RfmlWQo5IBVKgLo=;
        b=VnOa8frpfwwlEvmhyPZCrCF3b8hW3K2jS2kDteFtdawGG4EwLxx9nWCMIoWKnT3W9C
         gidJInD+YT/PYXSDLy4uNXvgGHSiacOK3JELm+7clIKe+2O6rAXtZjentSikjOdOsClh
         FH9gl7yLmOm6GYMb3r7b5V7Tvg/MCYuvmjQQ8lmjYRI3p5ltOij25Hic7fgfxE2qJ/JB
         Bg2kv+Yk+fhdaUfUHZ3DJA+5R8D5M0D1LpeDD9T8hYiRNb3QKB5rvIDThAdAm51EErxR
         xpCNCEthrUYn6MwLLuv7VCVeAW4PPswR1fK02AwlC4QJRto0HgJg5CeUWwDUzPQMe2tu
         P0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342383; x=1709947183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcgPQmlhhkA8T/cZTKDZ07IXVO71RfmlWQo5IBVKgLo=;
        b=MIkkBhTRFonwWr6CrSU/Ee3IJUQlobEpRnMAm47/8kxLEY+NEbnPUjkneZz3AH5q/2
         5SOLwyyqr+eTUeWAq+irk0j7yifymxneiT1HQn5vfY+3RDHcLa0SqJVVNFOjS2vr0tUG
         wJUt4GPq+cGaCPXSiS1S40nucsbgwCQbWvpdPMxEwxCLK9tOG2jsyLJZuibHoEKzuhiZ
         gS/PJTIbc6Zbd+5te6s6m8YCiRWB/flRz9tFxfNz6RQKVwaumR4VLyFcSXniUnbAVPqx
         ykbd63dLz2ohb4ii+Xdz819LrWnlw0IjdHYgCvZLzQkpHfCPqjpg5Wxs/jGgAxST83E5
         8gRg==
X-Gm-Message-State: AOJu0YyFNiIQLdU0GGpWL5F/2ufi25euHsx0GKRu3SHSuqnIH++lxNIT
	Kotgmw/LP5uwQwobCeoHUa6PD8GfVx6V1l5a0gGzJ3TfZkIM1EeQKQk9+VZI
X-Google-Smtp-Source: AGHT+IFutDRrzYRIDRirLbLKnddTPf90gp4uIQFaED+vlOLtY2CrLN/ohqwm/JbWkoyPm7njsQfdSA==
X-Received: by 2002:a2e:9cd4:0:b0:2d2:d0ba:2589 with SMTP id g20-20020a2e9cd4000000b002d2d0ba2589mr2493579ljj.21.1709342382860;
        Fri, 01 Mar 2024 17:19:42 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:42 -0800 (PST)
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
Subject: [PATCH bpf-next v2 07/15] selftests/bpf: test autocreate behavior for struct_ops maps
Date: Sat,  2 Mar 2024 03:19:12 +0200
Message-ID: <20240302011920.15302-8-eddyz87@gmail.com>
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

Check that bpf_map__set_autocreate() can be used to disable automatic
creation for struct_ops maps.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/struct_ops_autocreate.c    | 77 +++++++++++++++++++
 .../bpf/progs/struct_ops_autocreate.c         | 42 ++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
new file mode 100644
index 000000000000..c67d0b32b9dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_autocreate.skel.h"
+
+static void cant_load_full_object(void)
+{
+	struct struct_ops_autocreate *skel;
+	char *log;
+	int err;
+
+	skel = struct_ops_autocreate__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open"))
+		return;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+	/* The testmod_2 map BTF type (struct bpf_testmod_ops___v2) doesn't
+	 * match the BTF of the actual struct bpf_testmod_ops defined in the
+	 * kernel, so we should fail to load it if we don't disable autocreate
+	 * for that map.
+	 */
+	err = struct_ops_autocreate__load(skel);
+	log = stop_libbpf_log_capture();
+	if (!ASSERT_ERR(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+	ASSERT_HAS_SUBSTR(log, "libbpf: struct_ops init_kern", "init_kern message");
+	ASSERT_EQ(err, -ENOTSUP, "errno should be ENOTSUP");
+
+cleanup:
+	free(log);
+	struct_ops_autocreate__destroy(skel);
+}
+
+static void can_load_partial_object(void)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
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
+void test_struct_ops_autocreate(void)
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


