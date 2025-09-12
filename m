Return-Path: <bpf+bounces-68275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9CB55928
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEDCB632D5
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59A28B4FE;
	Fri, 12 Sep 2025 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hilwuCj6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F72765FB
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715945; cv=none; b=JWldzu/GSVucyEY7oq1ftKaAisvUrpvFN11YF8kHSRT4fVmaByUjBRqESrGd9ORQMZT+/VC89GcywmUpolpTWrcBzyuKNO5IhJkSshTumOga3bLwwqV4X1ydrUXP4esRdj+KXuAp+3pczBFYtGfk4IA4kxNzVdH3LYtSlKWNBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715945; c=relaxed/simple;
	bh=FwI+WCSKE5HG3xr7ZmyOW8sVTzLtmQY7Kswik4+arpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcRa4mQXuAgDvMY0EBMu8/3tXVdkxg9CWZjpQhhh8LVkR5dgh8PY00Qxf1fQm6JjdHylGlvXq61WDxQhzui6iPFBMIDc7eqZ+zX/vqsClXu3m+Aa029cJ5YV5XQSfaOKaE/rInuoDYPqj+7lSMdZwTAzF+8HhX2wjR6BJHXBD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hilwuCj6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8173e8effa1so158673785a.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715943; x=1758320743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfzMYXD5+OWWJnzTVfDJIl3IqMEPtzWckoBOmNSCMkc=;
        b=hilwuCj6OekogYgcOk+dC+aygGumnD/Qbr7A/nDGLXmDu67nL7xRBLv95L+LF2SNWU
         wwAYIPt7Sg6AltSw440TbihdWCEf+ffETpYpdW0IQnWc6LhD12eRWKOplSlro8KagHvr
         n3rYGFVrglB4Itz1dLlFK4Xuo1Yy2YOmydRazLwBQ0JDYeFsoNP6HfNEnS+tP7Wi7jsu
         bJStl+99e4Cml+Kq4K+DL7/HIRJRbrOhbo8V3nXfreNJNE7Bn2xS9o6HunET/1v5raDs
         3E9rIPblxvdfouo0kvXICYZ03mX47NF0qKDlKwF80qpJnptQ5pwRHhCAzo2A+0FtZlVk
         kM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715943; x=1758320743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfzMYXD5+OWWJnzTVfDJIl3IqMEPtzWckoBOmNSCMkc=;
        b=uFIivqS+gF5F/OFhY3HGwpKNPKG2ZXbUNS9Bendb4ATiiJhJYTvqfBTSFnyUPIFiIA
         zdGjP0FSkTvScUqRU9fzax7Bulfkm5j9ZP4g9PW/wI4ZuOfiSUmqJCjc+mk2dYFcKnEP
         YLj4hR3p8T208fhtudno7R9AxZQaqHBBPtdsZo0nQj624+difzjVg6khbeqLs4w1/R+h
         5fghDVApAj+yoHUYwZe+FDo/dpyswL8HKX7Th3ht4tZMSwyxq++xwKnQe5Litku00W8q
         W4nTeNXv7b4kLqenm79Q20v9C2FBXCrYeUCFA1SbuIVTjC/VT5lyLvMil7YeFLshgwlG
         LosQ==
X-Gm-Message-State: AOJu0YyQcOCcC/yzwTrRIJRM/NSf0KomyQlhi3C/V5Di+/5hc2dxdUks
	/qPSJVN0A5+Vn68ZathgZx6cvaVc91HbcpOTPqaCbUFtsKtP7aNoRbo+6bRJ+aHOTskGwA==
X-Gm-Gg: ASbGnct2zAJz9Tt9ZeupbVDifhs9YhZkZKIz+tUpKsdN16PavZYcfymfaHosFvC1jBM
	tibkO8xTb9w/8JYcLheWoRFsjIr5L1sthst/UkNMivxpb9tsW562B35++inFLmgFxLFiPkfouFp
	kTKTVNGT+F0lDsuiImtHX/vhIidN2s70Rea+PxKhFBtOhXJTBkfFYeVU91ovxtS5OyAlFt1WV2c
	tP31cDdsCrIwGbvyvrpxFYqNDNSLXWcqJzSai/36J8Qc7fILvpVg4A2VSkpgABbWuzb34alr7qY
	qWVETl0fM82nTFona8zoSTY6FFpIQbvpsPu0w2HpfRqICyQouChjNm48ScOe/K7ExWEAInkmY0b
	wfy1M+Ret42RCbCd5CahiJfzOZYNd2e4ri+7bqwqO2NWXRR1XiW18R4NMcV1upQO0HH10WmazTU
	5WXOhvjHH044u8wNYpyepqr8D3dDtVpiQ4Jso0n7MwrT8gIkiio7Oz0xzU72w=
X-Google-Smtp-Source: AGHT+IGg3Ohj0cka3NMv8jpZpR2hL/U0yANDpl3+efLMgDEhXvomkdNYbM7ZOzQEZbtjUgAv8a7kTA==
X-Received: by 2002:a05:620a:46ac:b0:815:5815:36a8 with SMTP id af79cd13be357-8240253dfd3mr549652485a.86.1757715943022;
        Fri, 12 Sep 2025 15:25:43 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974d635sm339136985a.25.2025.09.12.15.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:25:42 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	dwindsor@gmail.com
Subject: [PATCH 2/2] selftests/bpf: Add cred local storage tests
Date: Fri, 12 Sep 2025 18:25:39 -0400
Message-ID: <20250912222539.149952-3-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912222539.149952-1-dwindsor@gmail.com>
References: <20250912222539.149952-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test coverage for the new BPF_MAP_TYPE_CRED_STORAGE map type.
The test verifies that credential storage can be created, accessed,
and persists across credential lifecycle events.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 .../selftests/bpf/prog_tests/cred_storage.c   | 52 +++++++++++
 .../selftests/bpf/progs/cred_storage.c        | 87 +++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cred_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/cred_storage.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cred_storage.c b/tools/testing/selftests/bpf/prog_tests/cred_storage.c
new file mode 100644
index 000000000000..1a99f6453a0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cred_storage.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#include "cred_storage.skel.h"
+
+static void test_cred_lifecycle(void)
+{
+	struct cred_storage *skel;
+	pid_t child;
+	int status, err;
+
+	skel = cred_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		return;
+
+	err = cred_storage__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto cleanup;
+
+	skel->data->cred_storage_result = -1;
+
+	skel->bss->monitored_pid = getpid();
+
+	child = fork();
+	if (child == 0) {
+		/* forces cred_prepare with new credentials */
+		exit(0);
+	} else if (child > 0) {
+		waitpid(child, &status, 0);
+
+		/* give time for cred_free hook to run */
+		usleep(10000);
+
+		/* verify that the dummy value was stored and persisted */
+		ASSERT_EQ(skel->data->cred_storage_result, 0,
+			  "cred_storage_dummy_value");
+	} else {
+		ASSERT_TRUE(false, "fork failed");
+	}
+
+cleanup:
+	cred_storage__destroy(skel);
+}
+
+void test_cred_storage(void)
+{
+	if (test__start_subtest("lifecycle"))
+		test_cred_lifecycle();
+}
diff --git a/tools/testing/selftests/bpf/progs/cred_storage.c b/tools/testing/selftests/bpf/progs/cred_storage.c
new file mode 100644
index 000000000000..ae66d3b00d2e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cred_storage.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2025 David Windsor.
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define DUMMY_STORAGE_VALUE 0xdeadbeef
+
+extern struct bpf_local_storage_data *bpf_cred_storage_get(struct bpf_map *map,
+							   struct cred *cred,
+							   void *init, int init__sz, __u64 flags) __ksym;
+
+__u32 monitored_pid = 0;
+int cred_storage_result = -1;
+
+struct cred_storage {
+	__u32 value;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CRED_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct cred_storage);
+} cred_storage_map SEC(".maps");
+
+SEC("lsm/cred_prepare")
+int BPF_PROG(cred_prepare, struct cred *new, const struct cred *old, gfp_t gfp)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct cred_storage init_storage = {
+		.value = DUMMY_STORAGE_VALUE,
+	};
+	struct bpf_local_storage_data *sdata;
+	struct cred_storage *storage;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	sdata = bpf_cred_storage_get((struct bpf_map *)&cred_storage_map, new, &init_storage,
+				     sizeof(init_storage), BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!sdata)
+		return 0;
+
+	storage = (struct cred_storage *)sdata->data;
+	if (!storage)
+		return 0;
+
+	/* Verify the storage was initialized correctly */
+	if (storage->value == DUMMY_STORAGE_VALUE)
+		cred_storage_result = 0;
+
+	return 0;
+}
+
+SEC("lsm/cred_free")
+int BPF_PROG(cred_free, struct cred *cred)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct bpf_local_storage_data *sdata;
+	struct cred_storage *storage;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	/* Try to retrieve the storage that should have been created in prepare */
+	sdata = bpf_cred_storage_get((struct bpf_map *)&cred_storage_map, cred,
+				     NULL, 0, 0);
+	if (!sdata)
+		return 0;
+
+	storage = (struct cred_storage *)sdata->data;
+	if (!storage)
+		return 0;
+
+	/* Verify the dummy value is still there during free */
+	if (storage->value == DUMMY_STORAGE_VALUE)
+		cred_storage_result = 0;
+
+	return 0;
+}
-- 
2.43.0


