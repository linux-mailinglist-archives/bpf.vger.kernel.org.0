Return-Path: <bpf+bounces-75899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02BC9C5CD
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35C5C4E3779
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297282C0F92;
	Tue,  2 Dec 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc4+gSMc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065FF284B3B
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695780; cv=none; b=UuLWAFTXREJED/NMUUqY9K9KHRhwhR8FWLDu7xHsKRfnRT0VCZcq7NgFAOXyswxg0McDRi+csLM74EyuSPxO7TgJS1Lo0SqMmZsTkoRQIR5m3hzdYAITT4NqdzcrK0YM0j5A3x7x3hufxclLE+iztoEPdXj/45O1nKSX3462dQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695780; c=relaxed/simple;
	bh=VPehTofaHvh3cXTP9lnZWP5l8y+SuaYG4kHiLDWATKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHUCriYraqBwE6mK+8WeggMwGKItlZn2+O6w9spygm63UAFZ2hl/k2XbgxENh02CZinIGJ+IdCascQHf259PyYhoIR0mzjIDp1+lRYro5fwJQHG7w+nh7m+s164fCPhqYm4wcSH3vQlcKrru+N0Oq43Z0V61D4wFk6R1UcUSQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc4+gSMc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297d4a56f97so83061365ad.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764695778; x=1765300578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+OVhB+VrD5Ironu4bY8K77UjFHID6B323MrlMlQqfU=;
        b=Xc4+gSMcg+UfmSz9x7Fr/OLzAoiXBrdqCmARA9+FJjRYqezHnspZwn89kiZaOYkpcX
         uxGk3fzLQz52OCeKkGb3jrOL/1YVVprDL5jTmD3jv27hACXU5AZnFeDXIJBtc8PVkdL9
         LECubVWrAnmgTucG9vAmHlgFkYGB3YV+g4UdUrcF+hTyedOpJ7/zWSMQr022d2XnF91C
         m0BnQgQ5sxcyrqJ6BasTuTOUhx2jPF7s5fpqXmVKjHedfobpdW2z2T7wejyLDq0W68+A
         KPF1OBvUsdYdtfsF/9nVJ+mRwMGuIf1JvV8KtMIYeYgoUdkemE/vBBXieTu8vPcdvpQT
         GTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695778; x=1765300578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+OVhB+VrD5Ironu4bY8K77UjFHID6B323MrlMlQqfU=;
        b=IJ+AOlLNwVC4ZrNlPCmMwl4IYNlUIDbrBCpkJauS4Y8oMJZOiPwyNED4C2byM6jlFC
         rcz+3kJhOyJK2fWSZHvUZVJk7TeCr5aDHhdFt/WJ/SUjspdwdtL3bnI1SzyHhiqVeL+4
         wcA8en1YoJflR5U8dX4ayP4QIjPYxfA/L/hnS0QcjvQghIYK8Q9ymLjOflvNssnpVo4X
         diGzg5hStwIw67zT1sn6B7CzviO1BnQczNjo+wE9HYwCgMb/p7N8NS5/1garok9O3Gvi
         PB6kHoXKMciX9UhKMmsXzwiIQuIgLsH3Uk4REzscMDF17G0rvrLVEkimXSj7+qeOAldH
         wV8w==
X-Gm-Message-State: AOJu0YxpmJ0+V7ARWjxEYRyBbe7mA/ax4g++Pg5s1VZapztUWB8T+gi+
	3zN8XsWOBAK3tioKEtNPjB6FRlUEUuTOJiiwkhIrai1EBgzF3tRwAKfWvOkrww==
X-Gm-Gg: ASbGncumL+RUG3jTkixrCeBF7vYvrftStv4+HGcrCEC9Yj+GNZ5IE+R5QG9RW/EFYX8
	SmuFf2xjA+Qe2kI0wD8sGrcDwqSqYgGLruooNai2+nzIgjDpl1FC8hZgLbRBSQUu5cxvC4E9imB
	UfseoDQ7jt1uYCHRsaVLdkJ+Jn4ioXQbbj7dimI3zU9oJWRj8QC7wSiVIT55svC8fWMmh0zBArl
	GlQMVj3YDOWUBHISBd8mAxMEIIejsN6O8a5OHqPLtwzzBc4OJf6KdTlNS1bmjXa+eZPbEI9uqQv
	vbB7/vHQd+dAOPqu3sgH4+G43Mcj2iei/bjVqlNAgGkvNFZ1DfUkHrfwGT5IDItfKGX++TYGE1D
	0OapuUFfnhUMwe91JEonDbw8IBJMqH/SHNsruO65EFvp8ByvmJd+V8umR8vepHd/Uk3iMb+VBz+
	03MAfH4wKEo5RZVQ==
X-Google-Smtp-Source: AGHT+IFE0J86I8Uf7GW7nljnJGlohIYU2DJ9ovT7oeAFi49/q/FcGY1zsyQheeSrcZUxPYfHiHVXRQ==
X-Received: by 2002:a17:903:40d1:b0:296:3f23:b909 with SMTP id d9443c01a7336-29d65dd39b0mr199355ad.39.1764695778003;
        Tue, 02 Dec 2025 09:16:18 -0800 (PST)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb2765esm160661545ad.65.2025.12.02.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:16:17 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test using cgroup storage in a tail call callee program
Date: Tue,  2 Dec 2025 09:16:15 -0800
Message-ID: <20251202171615.1027536-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251202171615.1027536-1-ameryhung@gmail.com>
References: <20251202171615.1027536-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that a BPF program that uses cgroup storage cannot be added to
a program array map.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 50 +++++++++++++++++++
 .../bpf/progs/tailcall_cgrp_storage.c         | 39 +++++++++++++++
 .../bpf/progs/tailcall_cgrp_storage_owner.c   | 33 ++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 0ab36503c3b2..41090a413b09 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -8,6 +8,8 @@
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
+#include "tailcall_cgrp_storage_owner.skel.h"
+#include "tailcall_cgrp_storage.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1648,6 +1650,52 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	tc_bpf2bpf__destroy(tc_skel);
 }
 
+/*
+ * test_tail_call_cgrp_storage makes sure that callee programs cannot
+ * use cgroup storage
+ */
+static void test_tailcall_cgrp_storage(void)
+{
+	int err, prog_fd, prog_array_fd, storage_map_fd, key = 0;
+	struct tailcall_cgrp_storage_owner *owner_skel;
+	struct tailcall_cgrp_storage *skel;
+
+	/*
+	 * The first program loaded tailcalling into prog_array map becomes the
+	 * owner. This is needed to allow prog map compatibility check to pass
+	 * later during map_update.
+	 */
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "tailcall_cgrp_storage_owner__open"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+	storage_map_fd = bpf_map__fd(owner_skel->maps.storage_map);
+
+	skel = tailcall_cgrp_storage__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open")) {
+		tailcall_cgrp_storage_owner__destroy(owner_skel);
+		return;
+	}
+
+	err = bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
+	ASSERT_OK(err, "bpf_map__reuse_fd(prog_array)");
+
+	err = bpf_map__reuse_fd(skel->maps.storage_map, storage_map_fd);
+	ASSERT_OK(err, "bpf_map__reuse_fd(storage_map)");
+
+	err = bpf_object__load(skel->obj);
+	ASSERT_OK(err, "bpf_object__load");
+
+	prog_fd = bpf_program__fd(skel->progs.callee_prog);
+	prog_array_fd = bpf_map__fd(skel->maps.prog_array);
+
+	err = bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "bpf_map_update_elem");
+
+	tailcall_cgrp_storage__destroy(skel);
+}
+
 static void test_tailcall_failure()
 {
 	RUN_TESTS(tailcall_fail);
@@ -1705,6 +1753,8 @@ void test_tailcalls(void)
 		test_tailcall_freplace();
 	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
 		test_tailcall_bpf2bpf_freplace();
+	if (test__start_subtest("tailcall_cgrp_storage"))
+		test_tailcall_cgrp_storage();
 	if (test__start_subtest("tailcall_failure"))
 		test_tailcall_failure();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
new file mode 100644
index 000000000000..e4f277d2c4fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int caller_prog(struct __sk_buff *skb)
+{
+	bpf_tail_call(skb, &prog_array, 0);
+
+	return 1;
+}
+
+SEC("cgroup_skb/egress")
+int callee_prog(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
new file mode 100644
index 000000000000..6ac195b800cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int prog_array_owner(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	bpf_tail_call(skb, &prog_array, 0);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3


