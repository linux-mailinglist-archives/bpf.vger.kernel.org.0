Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC07852C693
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 00:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiERWru (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiERWrk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 18:47:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6105C149159;
        Wed, 18 May 2022 15:47:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso3472815pjb.3;
        Wed, 18 May 2022 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a//VlMypHjw3Cd3kRCT2B/bQ9DLIRsRYt3Pyz9Ujkpg=;
        b=YBYFZ/HvKpKBW/+JVtbbfEKcS2R2W4ZNR0VeUUy7ohJ4KL2IYUcVQdb9Bgu0b3f/z8
         jHamO32CcL0CgE2Vx22F9uiRtbXH+IzcVodBigYZrX4og4YUlgTh/S2a00Aa3HMFj2IR
         bRILlt23gobg6JnYzZyJOsiAUD02Pq9d2n81Qg5RUr2hoHUFngb87OYuT8Mxv6EjR52w
         WpTsNg3wVO05oW3LH7ajZW4C4aIujPMMRd3sI3e4AYRkJVshFViQi+4SrevFCtWmhiID
         hdYr5gCJ6HnTzd5ffQTZ6uYwyD58c+d2LwGPpaErP0Y2QVPkpK6PyCCVnqbU/h5QnjNS
         Yf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=a//VlMypHjw3Cd3kRCT2B/bQ9DLIRsRYt3Pyz9Ujkpg=;
        b=GES2ewEMbMXCr5DQIyBWli193uxRZ6/JjMEgL9HItM1vbeyPMSxXbpeKeu8Xe5jf84
         QGZo4nO58sfD0r4tnl270YL8NLxSBNo0IGTZ4QjUN2WALEaD499NioPaiouGGJ4UNDsU
         x7ZULF8FKgpXj3b75TuSBMjxDTmC144SArqXQQIk+uDpea0QYHpCQwsFJ58RF6k7Iy7b
         ARJZDJh4kTeZz6uzkkIP45cDbkCP3odQaeWkufqPTdUqgUqPj6jd46kI/j/37/lji3f3
         zZysp3mbgnMGQEciLZAXbFmZY6ILlD0ILQtP8w5ttHqXNyuRezwfpeZjuELl3DaS1LYX
         MFEA==
X-Gm-Message-State: AOAM532gqVsiekPCdh43TXipguqNSJ/zBhTHmgo5vf7lgZ1NarWtdBot
        tvc1DV+FosYdcsrUWSUQe/g=
X-Google-Smtp-Source: ABdhPJxavr7kpoXACNuQHWfwF2pWztidKf2V9Ygml/ydeRNTl4FO2a+wJrFpk9GfDkDz9G/qTU9T8w==
X-Received: by 2002:a17:903:230b:b0:15e:bc9c:18c7 with SMTP id d11-20020a170903230b00b0015ebc9c18c7mr1803429plh.29.1652914052889;
        Wed, 18 May 2022 15:47:32 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:a718:cbfe:31cb:3a04])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b0015e8d4eb2besm2214100plr.264.2022.05.18.15.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:47:32 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 4/6] perf record: Handle argument change in sched_switch
Date:   Wed, 18 May 2022 15:47:23 -0700
Message-Id: <20220518224725.742882-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220518224725.742882-1-namhyung@kernel.org>
References: <20220518224725.742882-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recently sched_switch tracepoint added a new argument for prev_state,
but it's hard to handle the change in a BPF program.  Instead, we can
check the function prototype in BTF before loading the program.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c          | 28 +++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 35 ++++++++++++++++++--------
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index b5e2d038da50..874856c55101 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -89,6 +89,33 @@ static void off_cpu_finish(void *arg __maybe_unused)
 	off_cpu_bpf__destroy(skel);
 }
 
+/* v5.18 kernel added prev_state arg, so it needs to check the signature */
+static void check_sched_switch_args(void)
+{
+	const struct btf *btf = bpf_object__btf(skel->obj);
+	const struct btf_type *t1, *t2, *t3;
+	u32 type_id;
+
+	type_id = btf__find_by_name_kind(btf, "bpf_trace_sched_switch",
+					 BTF_KIND_TYPEDEF);
+	if ((s32)type_id < 0)
+		return;
+
+	t1 = btf__type_by_id(btf, type_id);
+	if (t1 == NULL)
+		return;
+
+	t2 = btf__type_by_id(btf, t1->type);
+	if (t2 == NULL || !btf_is_ptr(t2))
+		return;
+
+	t3 = btf__type_by_id(btf, t2->type);
+	if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 4) {
+		/* new format: pass prev_state as 4th arg */
+		skel->rodata->has_prev_state = true;
+	}
+}
+
 int off_cpu_prepare(struct evlist *evlist, struct target *target)
 {
 	int err, fd, i;
@@ -117,6 +144,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target)
 	}
 
 	set_max_rlimit();
+	check_sched_switch_args();
 
 	err = off_cpu_bpf__load(skel);
 	if (err) {
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 78cdcc8ff863..986d7db6e75d 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -72,6 +72,8 @@ int enabled = 0;
 int has_cpu = 0;
 int has_task = 0;
 
+const volatile bool has_prev_state = false;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
@@ -121,22 +123,13 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
-SEC("tp_btf/sched_switch")
-int on_switch(u64 *ctx)
+static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
+			struct task_struct *next, int state)
 {
 	__u64 ts;
-	int state;
 	__u32 stack_id;
-	struct task_struct *prev, *next;
 	struct tstamp_data *pelem;
 
-	if (!enabled)
-		return 0;
-
-	prev = (struct task_struct *)ctx[1];
-	next = (struct task_struct *)ctx[2];
-	state = get_task_state(prev);
-
 	ts = bpf_ktime_get_ns();
 
 	if (!can_record(prev, state))
@@ -180,4 +173,24 @@ int on_switch(u64 *ctx)
 	return 0;
 }
 
+SEC("tp_btf/sched_switch")
+int on_switch(u64 *ctx)
+{
+	struct task_struct *prev, *next;
+	int prev_state;
+
+	if (!enabled)
+		return 0;
+
+	prev = (struct task_struct *)ctx[1];
+	next = (struct task_struct *)ctx[2];
+
+	if (has_prev_state)
+		prev_state = (int)ctx[3];
+	else
+		prev_state = get_task_state(prev);
+
+	return off_cpu_stat(ctx, prev, next, prev_state);
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.36.1.124.g0e6072fb45-goog

