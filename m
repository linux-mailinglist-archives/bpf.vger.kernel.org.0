Return-Path: <bpf+bounces-46489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2F9EA71A
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D506188AEA1
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20E226191;
	Tue, 10 Dec 2024 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA91Gccm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AD22617A
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803882; cv=none; b=Gz5VsCeVsUSwIxpMJVRb8YE0xACeXpR3H4SBSVofS3r/6hCOCj5fbpuLcQfHUheakRmlyiouB+OlS5m7DoXGtEQrZB3PW/1xYA4OIJVzZOgLxW38RBK5MFThiXn59Ceij2/4Qvy5XZ/k5oobmBm/9umisLt4hqdA82NHSfe+asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803882; c=relaxed/simple;
	bh=E9rK5VVgu1vb5HOv5GNksct/4EVn1xjQhk0AlLIH0XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctaCsUnoF32BmLpp4c6wMUi+pKYsa9Defw1x1Dd0L0IOtcZeSvTG+wzBEpHHXYvHA89BCzARtYSqLKG0OeWl6/EZBnN1UGRu/awUuRi/hENof+iuI3MDT4Unxp73FCFirxJvU00hUZBHWnDHkhK5l5JEIaL+UI2IXN49yuUINQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA91Gccm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21649a7bcdcso17892175ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803879; x=1734408679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4A/mi4KeRBODXu6ZbToqrKIC6qUwYXkLsbt0ypD+mc=;
        b=fA91GccmNZi0Q7MHEILq9sTxIZwEzVR9KEh4lRnjYRJDXOjU8aYhi8ylkqUtGKpfKe
         DanqxkRl8L3bX2LHAD1YQa7Ihbyl/0Ye1WHNwKrCpVXXFH33qU6nCK8vbEg20sEnANCb
         W+OCkUTrq6qt0byyN39cD6Y/cAMwSE4aziZfu3CxhiiEviYTlM8zvJ5hbSwZt35ReQfI
         YVHpemQgLDANgPP1ewNufwxtbZv80S3aQu+m0qqY5K5paZ1gILZspAspSbb8Jcf7zbZ2
         Yj5/mrKs6rr82grucyhyyjYAhtp+xDKrSzS0adrRwYPpyLr9EeSN21AgDnrCLLueCSQn
         OJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803879; x=1734408679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4A/mi4KeRBODXu6ZbToqrKIC6qUwYXkLsbt0ypD+mc=;
        b=XqwBVcElaumD7BC+4LHisftFKnZi7epBrpy3Sv6KRIjA6N0SuStAw7hp9L2Xhf7iJZ
         BysKFh3GL/tbvOqqkM8wpu6icf/vbWBxP0UGo3jcWgNauJPol5CPr538L+tQQ7pY8NNZ
         2aeGoxHw+ttihd8ZU5qdb6d/yasbhk3W0dmFntIyq0t4QHcDN7161sMYubUVeAKajzan
         6BsZqzVk4nhiiSK0Q+9HjwV/GtEQAcZ4F3Dxhp4Cu5uFImdGJbGQntLhhsGUR3SvUhYB
         IVIpRRsxRMuwjVONHYbdjFHqgvw/5u9uFn32J9yHK9oUQ+le7CWVKVwGssJmnOmQciFF
         LRjw==
X-Gm-Message-State: AOJu0YxwXtZeZnOnehIvaE2oeu4+xB4RaKjzYyIuo++kZxRFmExZwhhV
	3cR6+pW8RqpCdb88LieEwHrISw26hi0TEr2cVOOOXB1eW4ts3b0J+oew4A==
X-Gm-Gg: ASbGncsX2Ad+qR7OSYz53U5eWdNrnTxS3IWYwYdiT6qJHSqNy/Ilc0N538JoO+n4X5Z
	0z9ClHrpdWX7lRM/yew7bcR4T4IjI0rFnGzh78EzODMQEiUpmGoC2uirgSFSXVoSyfXxW/iWGTs
	LfqMcB9kuSYy2/g5qg3n7RbrcCxDWxvDtd1z5fXOyNUSezawYveeGnJwkwN0Whe7wT0NZW33pDT
	XXA2mIv5MDvX/bFr2XKTy6Pu+cs0ssIrkVpDAGnAOKLOh5IJw==
X-Google-Smtp-Source: AGHT+IHXDw86qbq4Tq5IJbHxhUSu3P8sUMyTVcx4Gz24ob0VHADtt/a9ZL+jQ6zkNtXy1l6Fw/M+Bg==
X-Received: by 2002:a17:902:ec92:b0:215:a172:5fb9 with SMTP id d9443c01a7336-2166a05562cmr45498535ad.48.1733803879162;
        Mon, 09 Dec 2024 20:11:19 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:18 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 6/8] selftests/bpf: freplace tests for tracking of changes_packet_data
Date: Mon,  9 Dec 2024 20:10:58 -0800
Message-ID: <20241210041100.1898468-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Try different combinations of global functions replacement:
- replace function that changes packet data with one that doesn't;
- replace function that changes packet data with one that does;
- replace function that doesn't change packet data with one that does;
- replace function that doesn't change packet data with one that doesn't;

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/changes_pkt_data.c         | 76 +++++++++++++++++++
 .../selftests/bpf/progs/changes_pkt_data.c    | 26 +++++++
 .../bpf/progs/changes_pkt_data_freplace.c     | 18 +++++
 3 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c

diff --git a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
new file mode 100644
index 000000000000..c0c7202f6c5c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bpf/libbpf.h"
+#include "changes_pkt_data_freplace.skel.h"
+#include "changes_pkt_data.skel.h"
+#include <test_progs.h>
+
+static void print_verifier_log(const char *log)
+{
+	if (env.verbosity >= VERBOSE_VERY)
+		fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log);
+}
+
+static void test_aux(const char *main_prog_name, const char *freplace_prog_name, bool expect_load)
+{
+	struct changes_pkt_data_freplace *freplace = NULL;
+	struct bpf_program *freplace_prog = NULL;
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct changes_pkt_data *main = NULL;
+	char log[16*1024];
+	int err;
+
+	opts.kernel_log_buf = log;
+	opts.kernel_log_size = sizeof(log);
+	if (env.verbosity >= VERBOSE_SUPER)
+		opts.kernel_log_level = 1 | 2 | 4;
+	main = changes_pkt_data__open_opts(&opts);
+	if (!ASSERT_OK_PTR(main, "changes_pkt_data__open"))
+		goto out;
+	err = changes_pkt_data__load(main);
+	print_verifier_log(log);
+	if (!ASSERT_OK(err, "changes_pkt_data__load"))
+		goto out;
+	freplace = changes_pkt_data_freplace__open_opts(&opts);
+	if (!ASSERT_OK_PTR(freplace, "changes_pkt_data_freplace__open"))
+		goto out;
+	freplace_prog = bpf_object__find_program_by_name(freplace->obj, freplace_prog_name);
+	if (!ASSERT_OK_PTR(freplace_prog, "freplace_prog"))
+		goto out;
+	bpf_program__set_autoload(freplace_prog, true);
+	bpf_program__set_autoattach(freplace_prog, true);
+	bpf_program__set_attach_target(freplace_prog,
+				       bpf_program__fd(main->progs.dummy),
+				       main_prog_name);
+	err = changes_pkt_data_freplace__load(freplace);
+	print_verifier_log(log);
+	if (expect_load) {
+		ASSERT_OK(err, "changes_pkt_data_freplace__load");
+	} else {
+		ASSERT_ERR(err, "changes_pkt_data_freplace__load");
+		ASSERT_HAS_SUBSTR(log, "Extension program changes packet data", "error log");
+	}
+
+out:
+	changes_pkt_data_freplace__destroy(freplace);
+	changes_pkt_data__destroy(main);
+}
+
+/* There are two global subprograms in both changes_pkt_data.skel.h:
+ * - one changes packet data;
+ * - another does not.
+ * It is ok to freplace subprograms that change packet data with those
+ * that either do or do not. It is only ok to freplace subprograms
+ * that do not change packet data with those that do not as well.
+ * The below tests check outcomes for each combination of such freplace.
+ */
+void test_changes_pkt_data_freplace(void)
+{
+	if (test__start_subtest("changes_with_changes"))
+		test_aux("changes_pkt_data", "changes_pkt_data", true);
+	if (test__start_subtest("changes_with_doesnt_change"))
+		test_aux("changes_pkt_data", "does_not_change_pkt_data", true);
+	if (test__start_subtest("doesnt_change_with_changes"))
+		test_aux("does_not_change_pkt_data", "changes_pkt_data", false);
+	if (test__start_subtest("doesnt_change_with_doesnt_change"))
+		test_aux("does_not_change_pkt_data", "does_not_change_pkt_data", true);
+}
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data.c b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
new file mode 100644
index 000000000000..f87da8e9d6b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+__noinline
+long changes_pkt_data(struct __sk_buff *sk, __u32 len)
+{
+	return bpf_skb_pull_data(sk, len);
+}
+
+__noinline __weak
+long does_not_change_pkt_data(struct __sk_buff *sk, __u32 len)
+{
+	return 0;
+}
+
+SEC("tc")
+int dummy(struct __sk_buff *sk)
+{
+	changes_pkt_data(sk, 0);
+	does_not_change_pkt_data(sk, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c b/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
new file mode 100644
index 000000000000..0e525beb8603
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("?freplace")
+long changes_pkt_data(struct __sk_buff *sk, __u32 len)
+{
+	return bpf_skb_pull_data(sk, len);
+}
+
+SEC("?freplace")
+long does_not_change_pkt_data(struct __sk_buff *sk, __u32 len)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.0


