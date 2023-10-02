Return-Path: <bpf+bounces-11236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714A7B5DD7
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 01:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5860A28182D
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 23:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86820B1B;
	Mon,  2 Oct 2023 23:47:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16B20B10
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 23:47:15 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879EACC;
	Mon,  2 Oct 2023 16:47:14 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5859a7d6556so185881a12.0;
        Mon, 02 Oct 2023 16:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696290434; x=1696895234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wzzKUe/S8MKLxWxB+dTpANkK30HpVTpho7RkzNp9HU=;
        b=JGZXPKN5C88bONLmHTu2b+WahjPJe/spGq8m56Xh9fBqJ6dl6qJs/yjQx2I9bXvVg1
         TpRD8MfphdqbENu8Wdowr6LfPJxX33DN4Eduo7KOtECns27+DG4bSPozuCPV/ce6ICje
         jK2M2kkDuhXaYPiELQI6bpUFN8MpvbMT2Jr29d3/wQ2rMhGx8wCL1z/TQ+3RHnuKijyp
         /vaWt6to5pnIPkw3yzqdwcD8dZOhomdAfuv1fvjTS875WFI4ZWJ0n+TtVGRzl8BnC5cz
         tzPKCddwbvkSZq/+RCWYzXFoxMyGP/bRsU2LWjUjNwGuFlP544bfZSi6aMCJtH4xOC7p
         oBRA==
X-Gm-Message-State: AOJu0YzpASAx7My8RFcUqO8CfJh+GfOs9aNpeZXrvUrj2VSfvYUg9K0O
	wp0sLnOPOablTTVirlnJhAaZBhva55bTFeH8
X-Google-Smtp-Source: AGHT+IH58b+uEONYiSLGbLsu12iNGiHLzw9r8xy2AVog41EIuRQumQ29v3ltTMSt9EecNREs3Shx6A==
X-Received: by 2002:a05:6a20:9184:b0:153:8754:8a7e with SMTP id v4-20020a056a20918400b0015387548a7emr14828886pzd.3.1696290433610;
        Mon, 02 Oct 2023 16:47:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:d0e0])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001b5656b0bf9sm13876pll.286.2023.10.02.16.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:47:13 -0700 (PDT)
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
	kernel-team@meta.com,
	himadrispandya@gmail.com,
	julia.lawall@inria.fr
Subject: [PATCH bpf-next 2/2] bpf/selftests: Test pinning bpf timer to a core
Date: Mon,  2 Oct 2023 18:47:08 -0500
Message-ID: <20231002234708.331192-2-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002234708.331192-1-void@manifault.com>
References: <20231002234708.331192-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
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

Signed-off-by: David Vernet <void@manifault.com>
---
 .../testing/selftests/bpf/prog_tests/timer.c  |  4 +
 tools/testing/selftests/bpf/progs/timer.c     | 75 +++++++++++++++++++
 2 files changed, 79 insertions(+)

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
index 9a16d95213e1..0112b9c038b4 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -53,12 +53,28 @@ struct {
 	__type(value, struct elem);
 } abs_timer SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} soft_timer_pinned SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} abs_timer_pinned SEC(".maps");
+
 __u64 bss_data;
 __u64 abs_data;
 __u64 err;
 __u64 ok;
 __u64 callback_check = 52;
 __u64 callback2_check = 52;
+__u64 pinned_callback_check;
+__s32 pinned_cpu;
 
 #define ARRAY 1
 #define HTAB 2
@@ -329,3 +345,62 @@ int BPF_PROG2(test3, int, a)
 
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


