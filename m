Return-Path: <bpf+bounces-67324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB1B4286F
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A083B7A70
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5BA352FCA;
	Wed,  3 Sep 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpko1JoG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651D352070;
	Wed,  3 Sep 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922333; cv=none; b=myVcFZBKVjvis7hyGZvitAQfPvoP+ER+WyKTB5dm+jJFgjzbYO1uMUWoDm+i0rjUTkyx1AlZfQni1zEGxs6WPe3emVfLb3MA2qZU1syuZRyRDmxwUbNRs+Q970BfQoKjw8QD5VK5jXLLguMyFwA6iXCQq2biLVU4vLYYH8i4TkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922333; c=relaxed/simple;
	bh=UAX1cLpaImr1uy1YbnrgbQgI0OtkJI1dLQtU22RnnmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN9HfhzSFz3jpQEm/M8Wc05X9XV0A5R7Kcug5z5M36Yf6t/PDwrgOWL2haxU2MxTA53vgvY4VN+jadNkx/wkOPdaPW/2UXe9nFCxlW+YbpytZhhfEd18iDIM06iBCJlMFT7q5RnVTZDH0jVoHmY0msiz69ygsyYrlinPIMiSulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpko1JoG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-722e079fa1aso977146d6.3;
        Wed, 03 Sep 2025 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756922330; x=1757527130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioh66qKVDtuMqcRVUHX1/ejUzhAKwFsew10JUTDXeI0=;
        b=hpko1JoGwcvxkY9H8mkCBW5ZvFoTxoEbJvsIVivx/TL360w72Hgsj0WCA0W/RfQnml
         G6By6pplXw6AKgC+rbNryEbV1WP5Cz5DgRMWp3jw7b5g9JsmP4N9SIE0q6SSKTQRQ4ab
         gjJ/Kp7uIl2scxXcQwlk9uUuBkg3CPUu9vpEniFUKdVIUS9OBfE0rned68JqnBFxXP+H
         CK/NURyh2LJPZU6Ov8gU7UWnGOegrLuWuzrBIYuPTrO4n3G7qY9cgSo5nSZf0NEPzjmq
         pmn31xSMMlk1/KTJkLe7+0LSZqjF2Btirw/Cy6vrlt77zAdvXC+XIQZjhUoEymVcYrzZ
         UqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756922330; x=1757527130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioh66qKVDtuMqcRVUHX1/ejUzhAKwFsew10JUTDXeI0=;
        b=eV8VQeih/sNgojh5AjZsYLuk0h0tB2rhb6o/IF4zSbUM+PwU8w09VA7DJ8tfu+hz9n
         gBfzDsmmYePaoMIveFNCPcsZgzt4mNFd/93Piuk3gOOmllaouQxukXSQNbmql33kRdtT
         UBtfmmopkAK5PGWDRFMNG7r9zNsziaZcDvSoEriDYx4wIFta/uNzsWtNDyywoP+JeplV
         w18HBnWDmyQLwT52j1FO7UKFt1ep8t0xv/UgdnDg8qjKVETwYE0wYBl0FYp0vWI9lCsz
         pXDKtC66BouXXFoSE5a3mbqQF3P1Gpg/AQmsYt+VmObn4F9atIESTZD2sNogwJMG98Pf
         BYKg==
X-Gm-Message-State: AOJu0YxOxUB4SUBddmmBEdjk2KlrPjizOyan+glOLz1Y8XZGxh77gtL0
	U5xroeTteD+uNtJ4mmwpAr1au8GGdWP8N9eaTZTuKYAGg11G1imqLcztznGLE55bH20=
X-Gm-Gg: ASbGnctJrHXYH9t8bM6U+vADhTqLA9io+r8l+E6uxwszg+sIcoH0aeYB0ZLuRGUfky9
	4ysmTmjx8L20PVae8efkP9iLJHPrtLDHHUYDpni+o43NVhrX5nvpbfvEL2STh9nAy34pr0aqLbI
	jJEfB2FQv/8x18wUnr3/+tT/8DjxajTBlcw28e1hKOzLOE/iemPk1CzAx9QNHUTZf+c+p25lY8Q
	TYN2DUCfVDdyh9cwn7SSoVPaOHpDnqZAVedhl5rI2YUZPPOz23Y55Q5hAKY+/zs4AH6OFxo243w
	Rge/tF3oz5tPn/6EAjf0tvfuXotWMiQhHur6TvNF61oxK3Xq4aFezLRPalIpa2wuzz14fsCavK0
	uZmO+tLmztKZgCEJMWzryZivgcq1D7Yn442a1lvsgIpyKAlW8T7lLllZUVo0nHQy1pk00/yF9kL
	2gOt+XhDTDa9znqT72
X-Google-Smtp-Source: AGHT+IEUrKHDZassl3qYGyQQUwzgxnLDBbvZg/N2L8dUUSy//BC2dcp5e4uJGTck6b1pUjUoNpxH/Q==
X-Received: by 2002:ad4:5c6e:0:b0:70d:6df4:1afe with SMTP id 6a1803df08f44-70fac9455c1mr221912296d6.60.1756922330296;
        Wed, 03 Sep 2025 10:58:50 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4665fdasm31955546d6.40.2025.09.03.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:58:50 -0700 (PDT)
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
Date: Wed,  3 Sep 2025 13:58:41 -0400
Message-ID: <20250903175841.232537-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903175841.232537-1-dwindsor@gmail.com>
References: <20250903175841.232537-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


