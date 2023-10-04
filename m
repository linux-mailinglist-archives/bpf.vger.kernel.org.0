Return-Path: <bpf+bounces-11387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F57B84EB
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 75C4F281D75
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722B51C288;
	Wed,  4 Oct 2023 16:23:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2D1BDF8
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 16:23:48 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3440DD;
	Wed,  4 Oct 2023 09:23:46 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c7373cff01so8926395ad.1;
        Wed, 04 Oct 2023 09:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436626; x=1697041426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UKCTZgVGrulhdraSlhbTYsV8kK+VRjs1vrD9smtWEA=;
        b=vB4N66mRirLGv6dgREwAcY6L71WzNJnvhxE6Jz57vRoALBx/fzUVp9Hz2MDVSUQxqw
         cpoCzFJirVtISjBgO52aYvYwX5pnXu1oh12pLW4GdeXomdms45zuxZbmnHE41FhMBYF6
         lI2yO3zSJ5p+KhMGuVwAWiKcZH8vQd4PKRijdc8OtGjPxp79m+Dc/XTE9xBa0MG//4+w
         HVU0lczWnMJW4Ko4SjTTx0VTe9OLyYjEtDhGIivYeYR2wxSg2+X6neobKapmaJBcjGf0
         kOpGDNNz5QupjvFjQJMnSKrBO0SyirikOO2Rvb17kpUhIG0RE8am6e7+OcKgAkmsj3lD
         fSfw==
X-Gm-Message-State: AOJu0Yw04MObEZk4vHpZ2J4hHk8MhmBRbtQYKombSV0imbVPdWFU4u9s
	jnZyQZ+P0qOinGkNEZ82qdvypVYx7A1Zdd47
X-Google-Smtp-Source: AGHT+IHLkAp3b7hL+a5kiRgY1gHscZbfyh1JA/QtpnIHly2yIEfLAmOfZvi/YhdtSRjRTEFDX6mdoQ==
X-Received: by 2002:a17:903:493:b0:1c0:bcbc:d66 with SMTP id jj19-20020a170903049300b001c0bcbc0d66mr133903plb.7.1696436626160;
        Wed, 04 Oct 2023 09:23:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:3ce7])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b001c55e13bf39sm3904422plg.275.2023.10.04.09.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:23:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] bpf/selftests: Test pinning bpf timer to a core
Date: Wed,  4 Oct 2023 11:23:39 -0500
Message-ID: <20231004162339.200702-3-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004162339.200702-1-void@manifault.com>
References: <20231004162339.200702-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that we support pinning a BPF timer to the current core, we should
test it with some selftests. This patch adds two new testcases to the
timer suite, which verifies that a BPF timer both with and without
BPF_F_TIMER_ABS, can be pinned to the calling core with
BPF_F_TIMER_CPU_PIN.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 .../testing/selftests/bpf/prog_tests/timer.c  |  4 ++
 tools/testing/selftests/bpf/progs/timer.c     | 63 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 290c21dbe65a..d8bc838445ec 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -14,6 +14,7 @@ static int timer(struct timer *timer_skel)
 
 	ASSERT_EQ(timer_skel->data->callback_check, 52, "callback_check1");
 	ASSERT_EQ(timer_skel->data->callback2_check, 52, "callback2_check1");
+	ASSERT_EQ(timer_skel->bss->pinned_callback_check, 0, "pinned_callback_check1");
 
 	prog_fd = bpf_program__fd(timer_skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
@@ -32,6 +33,9 @@ static int timer(struct timer *timer_skel)
 	/* check that timer_cb3() was executed twice */
 	ASSERT_EQ(timer_skel->bss->abs_data, 12, "abs_data");
 
+	/* check that timer_cb_pinned() was executed twice */
+	ASSERT_EQ(timer_skel->bss->pinned_callback_check, 2, "pinned_callback_check");
+
 	/* check that there were no errors in timer execution */
 	ASSERT_EQ(timer_skel->bss->err, 0, "err");
 
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index 9a16d95213e1..8b946c8188c6 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -51,7 +51,7 @@ struct {
 	__uint(max_entries, 1);
 	__type(key, int);
 	__type(value, struct elem);
-} abs_timer SEC(".maps");
+} abs_timer SEC(".maps"), soft_timer_pinned SEC(".maps"), abs_timer_pinned SEC(".maps");
 
 __u64 bss_data;
 __u64 abs_data;
@@ -59,6 +59,8 @@ __u64 err;
 __u64 ok;
 __u64 callback_check = 52;
 __u64 callback2_check = 52;
+__u64 pinned_callback_check;
+__s32 pinned_cpu;
 
 #define ARRAY 1
 #define HTAB 2
@@ -329,3 +331,62 @@ int BPF_PROG2(test3, int, a)
 
 	return 0;
 }
+
+/* callback for pinned timer */
+static int timer_cb_pinned(void *map, int *key, struct bpf_timer *timer)
+{
+	__s32 cpu = bpf_get_smp_processor_id();
+
+	if (cpu != pinned_cpu)
+		err |= 16384;
+
+	pinned_callback_check++;
+	return 0;
+}
+
+static void test_pinned_timer(bool soft)
+{
+	int key = 0;
+	void *map;
+	struct bpf_timer *timer;
+	__u64 flags = BPF_F_TIMER_CPU_PIN;
+	__u64 start_time;
+
+	if (soft) {
+		map = &soft_timer_pinned;
+		start_time = 0;
+	} else {
+		map = &abs_timer_pinned;
+		start_time = bpf_ktime_get_boot_ns();
+		flags |= BPF_F_TIMER_ABS;
+	}
+
+	timer = bpf_map_lookup_elem(map, &key);
+	if (timer) {
+		if (bpf_timer_init(timer, map, CLOCK_BOOTTIME) != 0)
+			err |= 4096;
+		bpf_timer_set_callback(timer, timer_cb_pinned);
+		pinned_cpu = bpf_get_smp_processor_id();
+		bpf_timer_start(timer, start_time + 1000, flags);
+	} else {
+		err |= 8192;
+	}
+}
+
+SEC("fentry/bpf_fentry_test4")
+int BPF_PROG2(test4, int, a)
+{
+	bpf_printk("test4");
+	test_pinned_timer(true);
+
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test5")
+int BPF_PROG2(test5, int, a)
+{
+	bpf_printk("test5");
+	test_pinned_timer(false);
+
+	return 0;
+}
-- 
2.41.0


