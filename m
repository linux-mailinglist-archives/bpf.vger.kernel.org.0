Return-Path: <bpf+bounces-75849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B000FC99A40
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 01:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797DF3A529F
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 00:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1E1A23A6;
	Tue,  2 Dec 2025 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEZefHdH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722702D7BF
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764634706; cv=none; b=SQ3DvQ194ZTYYA8AzCJf6atSJ9eLbZonX5AUBj5kD1LRA1jPBD6j+0VJY0e/lj30UE9NQmnwBanOpwy31GJOwxh2SdcGsBjaSmQuW6d0C3NkGdm9qwjnFMBR0zPHy3N84xg3lfiYV+GHC6SMPYBXr765QLgXjSHz+48ZTF6zoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764634706; c=relaxed/simple;
	bh=IfxuWkvZuk3RGa8pqR/8pAigx8+U71g9ijP04d+nFsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpQltaEnZp1N8hakM4r6wN4hLCovshefMvJVABMV2n3ckqDOZUaPKBL+DicMslBEfcp9+SaiJg+t6oea3MFbd9ZGDd4cQyWVIbriMow1a97z9FJ/OZcCpycpa0/g+8Ov55ikcxHd/mPMUewaEdGxq9/mewDm0RIUw44OToyTDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEZefHdH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3436a97f092so6122295a91.3
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 16:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764634704; x=1765239504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5a77YdObPhvI34u34Kx7tjX/nuVcVkZSH0wzDY9aBQ=;
        b=UEZefHdHmVsNUkkZukYplaCEvrsBrZ+Gfy+8lfccwhUmPDtWtYdT4sLkPn6KI2jhFO
         Kz+F9fLOXpiv+pNMNlA64pFrAFc+d/DeFCO/8fz/u5FZh4MT7rV6b5w/OsH+OthBtiwV
         b6odqJObY2uTx3W4q/NEsmRCFSHtQVSj33FVj+JsfA0qqpQS+SJANSCsshhuUdm5FHgv
         r8dS+HT5c5N1xxmiOtV1q92IbXcnuUyMdWC95Bl3vnAKbmrD0PrrKzG25c5pesxypB4k
         17xv+WPT47A53hMAQbe18y8NxxcjI9pQtNB3pZ6Wx5iqgOPeBGScQzwuuXB9cKQMwlbi
         Rxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764634704; x=1765239504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5a77YdObPhvI34u34Kx7tjX/nuVcVkZSH0wzDY9aBQ=;
        b=Hbyr28J/Zkz+9rpgiGY3ta3ZgvOKFSl8G++Rc0D/ZmswhNBTbbsC4Ok/M7pWQlvSHs
         HfQQuQvpBHhYaGL8jsaOPDC4/caJbJdP3As16oTtqxhaYrfD18sMuqvN1t3Ouecc1ugG
         nrGY98KgQMeyFak5b2sFaV1eaUlO4kOD85noiIQrwoRAvCbiTAnzPBunyi4Nqh5hPcn4
         C1fLkmo5FDKnaJ62gQptiLp/LlHkTuBq++sX7xoNtBL0UP98bscXdC4uyA40WAoNty9p
         3lhz56PyUgH+zW8uDGcXcKiynJRuBo050IXTPmaxPP3zf7RypZQpjGO6dZxQ2ccnHocu
         Be6w==
X-Gm-Message-State: AOJu0Yx0E3yfjv7r4S0h1R+AIQxeQ5MAJLfoT6LYv/eCvdNPt68aYu//
	rrquVhPFSX+Je/9SCHnzo1ng+uEdZ5eYr9qrIT+Tj46S784AR7kHQ3ob7ZNhrw==
X-Gm-Gg: ASbGncuNryxw1FCe9CcbJCADWaOZe+k4jFNCn/zaS5gHNPfquBzbHGNj8rvXfwxtZh7
	xTr5nDKscsLx2qg19GIV4K7T7kzfP3XVpYUNBLCDRnw+DuNigR8UiRIz198BmVbvWWa7JbzKcQ6
	IRU7Dcr1MBeQrMAWmarXew7Pi/AnQVz1epnwkuoMYU/0uv211VWx0l6UsLZpCYoWkxvRG4PE8tA
	eCOfyMA+wAXY9Z1pZ7KXDu0T1kFP8Mx7wxm8vuDEOve77iQY9bu6gs2WlOXQjFhJhdbHPzavvbm
	3JjBCRrWJEn+9gnzkcfmD9mcJn5RvWkag+HYz34HZ7Lmz3+0+CGBYw+r2cdmoXRau4Uq7tfOFzH
	x0cXkAZ2i94JnH1+K498uqQbHBNYGBnrGmcEMkuCF8dL+YgjZmDpYdYHi7cHYH/gmdX6Mbb5J+M
	2NVjXWBCdX8qw6mQ==
X-Google-Smtp-Source: AGHT+IG/2Rv2X51nm+OJ95M9tydNLUah7HvccQZUN5u0ySH0CDblKW+QH6Jy5/A5MvmFIi+FVZTesw==
X-Received: by 2002:a17:90b:1344:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-3475ebd2dc5mr29079372a91.3.1764634704511;
        Mon, 01 Dec 2025 16:18:24 -0800 (PST)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4f5f3416bsm8253516a12.0.2025.12.01.16.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 16:18:24 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in a tail call callee program
Date: Mon,  1 Dec 2025 16:18:22 -0800
Message-ID: <20251202001822.2769330-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251202001822.2769330-1-ameryhung@gmail.com>
References: <20251202001822.2769330-1-ameryhung@gmail.com>
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
 .../selftests/bpf/prog_tests/tailcalls.c      | 25 ++++++++++++
 .../bpf/progs/tailcall_cgrp_storage.c         | 39 +++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 0ab36503c3b2..e4a5287f10b1 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -8,6 +8,7 @@
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
+#include "tailcall_cgrp_storage.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1648,6 +1649,28 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	tc_bpf2bpf__destroy(tc_skel);
 }
 
+/*
+ * test_tail_call_cgrp_storage makes sure that callee programs cannot
+ * use cgroup storage
+ */
+static void test_tailcall_cgrp_storage(void)
+{
+	int err, prog_fd, prog_array_fd, key = 0;
+	struct tailcall_cgrp_storage *skel;
+
+	skel = tailcall_cgrp_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open_and_load"))
+		return;
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
@@ -1705,6 +1728,8 @@ void test_tailcalls(void)
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
-- 
2.47.3


