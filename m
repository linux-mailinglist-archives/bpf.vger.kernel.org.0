Return-Path: <bpf+bounces-11731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1E7BE60F
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7210D1C20A54
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF79438BB2;
	Mon,  9 Oct 2023 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017135887
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:14:25 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112CDB;
	Mon,  9 Oct 2023 09:14:23 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-352a3a95271so18231295ab.0;
        Mon, 09 Oct 2023 09:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868062; x=1697472862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn/6KVXbliEOh9rFCg0BPlbCxwqo18KGwCNTlkH9z2s=;
        b=ayXOAaNREBHp/zziISJHyEOiUq944jCcZYLXpCblWqKsEyUwScwxcL3XizWB85YfxQ
         HduAgQV1IzaIe/o73NHwWnPELg5lU46glo7yYqXlzK6Xf0PxsuLdrxPai9NtFdVhehPb
         VMCpCtGlKRZSAIIrhNn48F57lE8BIrGrBOGZWa/a2GHyUmRHoQQBUpxoh8iTFcKff/in
         bYP4+9a4muWwCbU9Ufm3v7ZxbEmwyLoyicFUWfI93Brvkx/Ar7Ye8JEGtguxb/NKTc73
         Qqz/b8D5etdi0qMwwF3IzvjOF6OHnMmbt/c3qyBlzW35FWJHCrc4YUpFyDnKORzJxbZf
         0HJw==
X-Gm-Message-State: AOJu0YxA+M+Fq/zNqkCnRChYw9ess8h/6NeOG2axpV1bldrdo1xb9Ih0
	Lk1mWpNSzZsuz4lhs/uG1AI5m41qZ4r6LD0G
X-Google-Smtp-Source: AGHT+IFwy8aDUIVX5U7FdjzcvhTMzgvv/VgiEcL550rclKOOP1rK8SASnDN56t9rY9oCbs/egGYSAw==
X-Received: by 2002:a92:c262:0:b0:34c:cf1f:2a4a with SMTP id h2-20020a92c262000000b0034ccf1f2a4amr19831982ild.4.1696868062029;
        Mon, 09 Oct 2023 09:14:22 -0700 (PDT)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id q2-20020a056e02078200b0035163fb9f9fsm2999771ils.43.2023.10.09.09.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:14:21 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] bpf/selftests: Add testcase for async callback return value failure
Date: Mon,  9 Oct 2023 11:14:14 -0500
Message-ID: <20231009161414.235829-2-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009161414.235829-1-void@manifault.com>
References: <20231009161414.235829-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A previous commit updated the verifier to print an accurate failure
message for when someone specifies a nonzero return value from an async
callback. This adds a testcase for validating that the verifier emits
the correct message in such a case.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../testing/selftests/bpf/prog_tests/timer.c  |  6 ++-
 .../selftests/bpf/progs/timer_failure.c       | 47 +++++++++++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/timer_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index d8bc838445ec..760ad96b4be0 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <test_progs.h>
 #include "timer.skel.h"
+#include "timer_failure.skel.h"
 
 static int timer(struct timer *timer_skel)
 {
@@ -53,10 +54,11 @@ void serial_test_timer(void)
 
 	timer_skel = timer__open_and_load();
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
-		goto cleanup;
+		return;
 
 	err = timer(timer_skel);
 	ASSERT_OK(err, "timer");
-cleanup:
 	timer__destroy(timer_skel);
+
+	RUN_TESTS(timer_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/testing/selftests/bpf/progs/timer_failure.c
new file mode 100644
index 000000000000..226d33b5a05c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <time.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timer_map SEC(".maps");
+
+static int timer_cb_ret1(void *map, int *key, struct bpf_timer *timer)
+{
+	if (bpf_get_smp_processor_id() % 2)
+		return 1;
+	else
+		return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("should have been in (0x0; 0x0)")
+int BPF_PROG2(test_ret_1, int, a)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer_map, CLOCK_BOOTTIME);
+		bpf_timer_set_callback(timer, timer_cb_ret1);
+		bpf_timer_start(timer, 1000, 0);
+	}
+
+	return 0;
+}
-- 
2.41.0


