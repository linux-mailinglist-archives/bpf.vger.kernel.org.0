Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB550BB1E
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449124AbiDVPIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449095AbiDVPIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 11:08:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658EC13D6A;
        Fri, 22 Apr 2022 08:05:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q3so11456178plg.3;
        Fri, 22 Apr 2022 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5bMd3EZKPtSk/LlVpFY7y+BRjO9pioZ19YkfHn+mvI=;
        b=cWvPAy2H4RrFbwLp3MoR37HUHF0ToOPkpb/ehqduwdm0/MFd4WPOqhOdWiQ4KW9vhh
         D8vZAiAK1XqoI2LfS1jxxZnyTdSZ50OQ3m476zbGO9U4b1Bza9Xsm1CHJA/fKSJgVBx7
         oPxLN3BlND+EFE0H4dDbemMmkLw2VIUCVk9/qILGvoml+kzcJQAa5RU3epoSKVPcHs9c
         vgEuEySvPTnltAgjZ3X4FCZ43W05gXL3B33ZMMb/qpKnpCOY94uM2uUnWY1SL8tnemF9
         CKxe9BLFKOjl6bdZeqwhqtI4Cs3lKs9047AONq9V0bS0n0eoocbeCWJSb57Jn/gHY6dr
         ysnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=G5bMd3EZKPtSk/LlVpFY7y+BRjO9pioZ19YkfHn+mvI=;
        b=buTkOkEyBGzk/0sr6E/tQegbEv4Vi5E+NumJ/tDivFw+Wqh70UV0Dfg5iIUJx7kZ/s
         D+RkmHIW8yEsr6uFxtj4+bbS00rRT9RIvSnuqgAU61uk+g+eMjsNnjI0ZTgw1iH9i7uz
         +Tv0FZQoz2wZFa9+kwxnoH0Yj9CE3ZHnwhFWhzxMH1iW+jzGsW2X4OY3TSdTWfly58ob
         KT056XsX42KiCVC73HucGVthcwZIntD7UFxhS1XAYBBvTqUO0rW6q9rzBNGr4Q3HrZRU
         qhV7yhO8eQkit1HkK6mZ6SKkOvcka3qYPMNKEXkthjwX6EOQI7jeomOEdb5AC4xD6B+9
         I0ig==
X-Gm-Message-State: AOAM533mamD/RaKTvlH0bdbtdjyI7bePC1WgCOeXmGAsdb1mzHlZQui2
        OX+LFKIuK5ByWTJcxK8xj2M=
X-Google-Smtp-Source: ABdhPJwCH3cE03NTyvR7xld8SoaRA1GwJ5JAmoEibnefVHoufMwsuTVIh7PEaEDEGC5CDPGNwD8fJg==
X-Received: by 2002:a17:902:e842:b0:158:e15b:1d6e with SMTP id t2-20020a170902e84200b00158e15b1d6emr5168393plg.0.1650639916918;
        Fri, 22 Apr 2022 08:05:16 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:5deb:57fb:7322:f9d4])
        by smtp.gmail.com with ESMTPSA id s11-20020a6550cb000000b0039daee7ed0fsm2390279pgp.19.2022.04.22.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:05:16 -0700 (PDT)
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
Date:   Fri, 22 Apr 2022 08:05:07 -0700
Message-Id: <20220422150507.222488-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220422150507.222488-1-namhyung@kernel.org>
References: <20220422150507.222488-1-namhyung@kernel.org>
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

