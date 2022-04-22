Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E29F50AF95
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 07:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiDVFjz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 01:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444173AbiDVFhC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 01:37:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617384F445;
        Thu, 21 Apr 2022 22:34:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t12so8501183pll.7;
        Thu, 21 Apr 2022 22:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5bMd3EZKPtSk/LlVpFY7y+BRjO9pioZ19YkfHn+mvI=;
        b=WBLAbPZKUQi9ZgV2hCFU/S/aOyaHcoxwMWeYgoL9BLhrNE2qGrPb69TGpB8BP3Le5Z
         CT8/HKaERwuz/5nNo59SY2TOpDTeA6J/Gpbx2Lc2EWLXzoduGLEHQp5QIFWtwqswioBC
         lNuwJvBoypAl08VAkDhJ8mBLF/+RHoKZBpgxRTFvcqs73F2Kt+QsNb40FuhNsOTDEbVg
         kO7O7MBTYtWtlXwIzuDBvY3z7OTS/0JCXPmPvBMYcRQPsXPMZs1yHV0rxA+XNlCdBLsA
         2+4F1Wz7dbvbkV9OkiNzgJQW+h8WKYOTV8l/SO+1IbvAXdJooMcS8qj6drdi70EM9zmp
         RDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=G5bMd3EZKPtSk/LlVpFY7y+BRjO9pioZ19YkfHn+mvI=;
        b=4DIcfVHR4AL3m7i3WcuZvQjMZ3MemqPX/XEFWZ4uTRaXaIDW/csMlmSU2oGhqt00yJ
         Mnd9Hil0u4Vg3dzBkVL8AeDQfmZ9GeokZZiu/rUe7CWb/Dj7pr0t1QoVbCHIw5BRr4ht
         wN6v8PS2DTipz2eZc/t5IzWdrxujamdHMo84aS5nYBVEX9PuCZ+7wwefZdiNATH9FLeb
         Iu0OvskF8F88fPAk9P0X20Xc8skX2xNDdmLAJMiu3STeHzP2sMMk76Was9i1ldDimR+5
         S4idhJa+xGhS+I+P3fIk0/Pd88CEmvuja09TzCoH6FicBvIqUoBn08k8wMCV8jj9G7Nv
         Qevg==
X-Gm-Message-State: AOAM532dc5tjIb6zyn/d2kEgH48ik27yImU8lV30Ed4+UaQV0D7fJFc2
        wQHGTA1vrGS1Zbom5r1H4NM=
X-Google-Smtp-Source: ABdhPJwLc4FzlEoCuD5URWbioHefbgZfrShmSLUhNUgKFAik7IRzv1TbY3Yjd5ryQ4rB6Oo4zgnUFQ==
X-Received: by 2002:a17:90b:4b05:b0:1d2:3d1e:fbfb with SMTP id lx5-20020a17090b4b0500b001d23d1efbfbmr14430682pjb.33.1650605649848;
        Thu, 21 Apr 2022 22:34:09 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:32e3:a023:46c1:80cd])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm886519pgc.50.2022.04.21.22.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:34:09 -0700 (PDT)
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
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 4/4] perf record: Handle argument change in sched_switch
Date:   Thu, 21 Apr 2022 22:34:01 -0700
Message-Id: <20220422053401.208207-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220422053401.208207-1-namhyung@kernel.org>
References: <20220422053401.208207-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recently sched_switch tracepoint added a new argument for prev_state,
but it's hard to handle the change in a BPF program.  Instead, we can
check the function prototype in BTF before loading the program.

Thus I make two copies of the tracepoint handler and select one based
on the BTF info.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c          | 32 +++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 55 ++++++++++++++++++++------
 2 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 89f36229041d..38aeb13d3d25 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -86,6 +86,37 @@ static void off_cpu_finish(void *arg __maybe_unused)
 	off_cpu_bpf__destroy(skel);
 }
 
+/* recent kernel added prev_state arg, so it needs to call the proper function */
+static void check_sched_switch_args(void)
+{
+	const struct btf *btf = bpf_object__btf(skel->obj);
+	const struct btf_type *t1, *t2, *t3;
+	u32 type_id;
+
+	type_id = btf__find_by_name_kind(btf, "bpf_trace_sched_switch",
+					 BTF_KIND_TYPEDEF);
+	if ((s32)type_id < 0)
+		goto old_format;
+
+	t1 = btf__type_by_id(btf, type_id);
+	if (t1 == NULL)
+		goto old_format;
+
+	t2 = btf__type_by_id(btf, t1->type);
+	if (t2 == NULL || !btf_is_ptr(t2))
+		goto old_format;
+
+	t3 = btf__type_by_id(btf, t2->type);
+	if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 4) {
+		/* new format: disable old functions */
+		bpf_program__set_autoload(skel->progs.on_switch3, false);
+		return;
+	}
+
+old_format:
+	bpf_program__set_autoload(skel->progs.on_switch4, false);
+}
+
 int off_cpu_prepare(struct evlist *evlist, struct target *target)
 {
 	int err, fd, i;
@@ -114,6 +145,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target)
 	}
 
 	set_max_rlimit();
+	check_sched_switch_args();
 
 	err = off_cpu_bpf__load(skel);
 	if (err) {
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 27425fe361e2..e11e198af86f 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -121,22 +121,13 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
-SEC("tp_btf/sched_switch")
-int on_switch(u64 *ctx)
+static int on_switch(u64 *ctx, struct task_struct *prev,
+		     struct task_struct *next, int state)
 {
 	__u64 ts;
-	int state;
 	__u32 pid, stack_id;
-	struct task_struct *prev, *next;
 	struct tstamp_data elem, *pelem;
 
-	if (!enabled)
-		return 0;
-
-	prev = (struct task_struct *)ctx[1];
-	next = (struct task_struct *)ctx[2];
-	state = get_task_state(prev);
-
 	ts = bpf_ktime_get_ns();
 
 	if (!can_record(prev, state))
@@ -178,4 +169,46 @@ int on_switch(u64 *ctx)
 	return 0;
 }
 
+SEC("tp_btf/sched_switch")
+int on_switch3(u64 *ctx)
+{
+	struct task_struct *prev, *next;
+	int state;
+
+	if (!enabled)
+		return 0;
+
+	/*
+	 * TP_PROTO(bool preempt, struct task_struct *prev,
+	 *          struct task_struct *next)
+	 */
+	prev = (struct task_struct *)ctx[1];
+	next = (struct task_struct *)ctx[2];
+
+	state = get_task_state(prev);
+
+	return on_switch(ctx, prev, next, state);
+}
+
+SEC("tp_btf/sched_switch")
+int on_switch4(u64 *ctx)
+{
+	struct task_struct *prev, *next;
+	int prev_state;
+
+	if (!enabled)
+		return 0;
+
+	/*
+	 * TP_PROTO(bool preempt, int prev_state,
+	 *          struct task_struct *prev,
+	 *          struct task_struct *next)
+	 */
+	prev = (struct task_struct *)ctx[2];
+	next = (struct task_struct *)ctx[3];
+	prev_state = (int)ctx[1];
+
+	return on_switch(ctx, prev, next, prev_state);
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

