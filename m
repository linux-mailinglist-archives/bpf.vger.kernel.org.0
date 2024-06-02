Return-Path: <bpf+bounces-31145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5568D7551
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307081C21098
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9973B2A2;
	Sun,  2 Jun 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpouTQiG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7433B1AC
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331123; cv=none; b=IFW0Cwg4szBu15h4Ljh+GBa2XRQ4FyaasT3kFunKOAuatq9EmCcQMNIhqW+iILQd1IZk5mtLrlYGS72HRYCXLIPSrb42CFcdvOvdGP1Y0sHWMpn15M7po08VV9/8RKuyYaN0MFeGyNi1gOWzinkoWKgEAvGYSHzFAMkxYyvVMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331123; c=relaxed/simple;
	bh=/viBrLTzTh460412xUuXQfBIfNOtMPxRMbyWkKqiUME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LomsEVFNo0NTs5qGNWzJy/5fB6+Lixz6rbLEZkVyy6hTDgcf0VXr4L/3APY7jEOpAroLf854q3PQVgUH3J1wnIgi4ClYmyEi1u3zkUhG6Z1EAJiCRFL3toBKTKNOcsavkLqOmm6lLOo5pAz9Cuzw2uBFu3cis/CFnM9TMUcrV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpouTQiG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7024791a950so1308893b3a.0
        for <bpf@vger.kernel.org>; Sun, 02 Jun 2024 05:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717331120; x=1717935920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj/4lZtklNs69HktwAk7FvEtlxhu4qvh1cteuOyN0NE=;
        b=JpouTQiGHMxerOQaSekP5JzEC0DlrRJAxhgSOXzctGnG1zWcMnAZ3MzJtalvnK3pxY
         Bg4a9P8l+h+4gsNslWB8VVP/2Ay5Pwlu0XBleVRPQcvbNGgpUspxPqlUg6ACXPsRZmfI
         8a1MaViY9frhpR3yqMCE4oBujzYA1Sqj3UHcsCiaqgF7Nbtt9i21BboxoKSRBgP67e6P
         x+zNh2AsqIvFDm1PRo9/tEB5T1/WIlNOCE7YTqJDURjRRI/DvDZSmkZJDBNc0KiRDxBi
         7k4HNRYOdFzkA2pIop+x0bbjEOmAJIaXX8+dqNYCMwoEixItDkS1hzABZ7pVylMBirSo
         WD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717331120; x=1717935920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj/4lZtklNs69HktwAk7FvEtlxhu4qvh1cteuOyN0NE=;
        b=Lpn8At6vXp8c0nKBIbDkB3dFFWk0OwZRQeyVwGI8eIcs3bxyQawx/Y3MpxNTxR3jQX
         BM+3ZaRxQFxC8yZrs4+Hgnf+Bh89diZNsRqzg6vQXfxVeZbJrN9AUYW8gMjMSemD1gxj
         uUM90R26TuDJ2us1AbBXa9SC2kVVAn4vYQPTQgChHuZTSjKXdJNEAoLhsgzkCsQzbXUL
         CAo/oIkm8qtejuM10Qp/DeKNP+3RSj+/kfz2mRrUezKBySzdWjFC0oIPIgGnI3DeyzRa
         RJig/NGqFucbmriXNbVHiOimj4Z+UBbLQT8f7DR15Bk2lyIjNIiKH7JoGlgzXl8U47Is
         1gUw==
X-Gm-Message-State: AOJu0YwUB6ooAFys4jQ5+ltL6DjBBjt+CEwdZwTAfkWFYVdm+zQipzGi
	z6LyIgCdb0W8fTKEyTTOvkoQf2mK5nh1Pa4dLgNWhXHNYmrH76LKSAH+Lg==
X-Google-Smtp-Source: AGHT+IHFwQHRpiN96pj19oOWP357zL/N9pCXzUGJwr9yUBO3G9xNfErjhbv8ZfFmJPhc6uBT27WwzQ==
X-Received: by 2002:a05:6a21:789c:b0:1b0:20e9:d215 with SMTP id adf61e73a8af0-1b26f16ec7bmr10443130637.14.1717331119825;
        Sun, 02 Jun 2024 05:25:19 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423dc0ebsm3965332b3a.68.2024.06.02.05.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 05:25:19 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	hffilwlqm@gmail.com
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add testcase for updating attached freplace prog to PROG_ARRAY map
Date: Sun,  2 Jun 2024 20:24:21 +0800
Message-ID: <20240602122421.50892-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240602122421.50892-1-hffilwlqm@gmail.com>
References: <20240602122421.50892-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to confirm the issue, panic when update attached freplace
prog to PROG_ARRAY map, has been fixed.

cd tools/testing/selftests/bpf; ./test_progs -t tailcall
324/18  tailcalls/tailcall_freplace:OK
324     tailcalls:OK
Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 82 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_freplace.c   | 34 ++++++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 21 +++++
 3 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 59993fc9c0d7e..d0c6f0d2a4233 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -3,6 +3,8 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "tailcall_poke.skel.h"
+#include "tailcall_freplace.skel.h"
+#include "tc_bpf2bpf.skel.h"
 
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
@@ -1187,6 +1189,84 @@ static void test_tailcall_poke(void)
 	tailcall_poke__destroy(call);
 }
 
+static void test_tailcall_freplace(void)
+{
+	struct tailcall_freplace *skel = NULL;
+	struct tc_bpf2bpf *tgt_skel = NULL;
+	struct bpf_link *freplace = NULL;
+	struct bpf_map *data_map;
+	int prog_fd, data_fd;
+	char buff[128] = {};
+	__u32 key = 0;
+	int err, val;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	skel = tailcall_freplace__open();
+	if (!ASSERT_OK_PTR(skel, "open skel"))
+		goto out;
+
+	tgt_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tgt_skel, "open tgt_skel"))
+		goto out;
+
+	err = bpf_program__set_attach_target(skel->progs.entry,
+					     bpf_program__fd(tgt_skel->progs.entry),
+					     "subprog");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_freplace__load(skel);
+	if (!ASSERT_OK(err, "load skel"))
+		goto out;
+
+	freplace = bpf_program__attach_freplace(skel->progs.entry,
+						bpf_program__fd(tgt_skel->progs.entry),
+						"subprog");
+	if (!ASSERT_OK_PTR(freplace, "attatch_freplace"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.entry);
+	if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
+		goto out;
+
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.jmp_table), &key,
+				  &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tgt_skel->progs.entry);
+	if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 1, "test_run retval");
+
+	data_map = bpf_object__find_map_by_name(skel->obj, ".bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find .bss map"))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_GE(data_fd, 0, ".bss map_fd"))
+		goto out;
+
+	key = 0;
+	err = bpf_map_lookup_elem(data_fd, &key, &val);
+	ASSERT_OK(err, "tailcall count");
+	ASSERT_EQ(val, 34, "tailcall count");
+
+out:
+	bpf_link__destroy(freplace);
+	tc_bpf2bpf__destroy(tgt_skel);
+	tailcall_freplace__destroy(skel);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1223,4 +1303,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_fentry_entry();
 	if (test__start_subtest("tailcall_poke"))
 		test_tailcall_poke();
+	if (test__start_subtest("tailcall_freplace"))
+		test_tailcall_freplace();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace.c b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
new file mode 100644
index 0000000000000..fe25343e9d2fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int count = 0;
+
+__noinline int
+subprog(struct __sk_buff *skb)
+{
+	volatile int ret = 1;
+
+	count++;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+
+	return ret;
+}
+
+SEC("freplace")
+int entry(struct __sk_buff *skb)
+{
+	return subprog(skb);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
new file mode 100644
index 0000000000000..54abda6c3246e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+__noinline int
+subprog(struct __sk_buff *skb)
+{
+	volatile int ret = 1;
+
+	return ret;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	return subprog(skb);
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.44.0


