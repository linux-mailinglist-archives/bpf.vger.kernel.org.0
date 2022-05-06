Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC051E008
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 22:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442329AbiEFUU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 16:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442323AbiEFUUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 16:20:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D5E66AF5;
        Fri,  6 May 2022 13:16:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so8478067plg.5;
        Fri, 06 May 2022 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UL1WLDXYE0brFxgOgvbV8Z/RLTmnEOAPi1HjOcqSL8o=;
        b=DLINA9OgGy48buUfPlG851ZNEGGIaRvTtNPRBHOQHqecOEzw0DgbIjTuMyL9E/wz+i
         EYfh20blipGa84p+7u3kJyXDoO6xEslREWWAfBEsMN2TEtQjHAsRag+Rc9IoNeHZlzCB
         Oo+U0eVg4c7vY3+ePu+yCh15nXwoFOwSd+UQCUajocTlnlbBFU4gV37oyi3Qd8jVkqFC
         4avz7xI8XIjzg6gQnTJ7sMjCSOqT3/SGlLHjN9fhyVg/E5HOyFFk+gfSNiuZeq6U5S8f
         ATut0nwQlnCRsnUujSjSiiJU+ho7VTffR58HQDVZ2EswcxlSp7iRabIAEfUHza8HYq4Q
         KWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UL1WLDXYE0brFxgOgvbV8Z/RLTmnEOAPi1HjOcqSL8o=;
        b=qNTKO9oXIVkD7pRnckxZRmvPZ2wWGgtt9mRpRP/on1EWv+nsToXoz0J45SCvmfp94C
         T1yhfepvUjH7US36fs6wfitEiCSwa9gi9jLJI/vDiCYX7vbkPuvaohfLaKd3IgvQakzX
         yOyioXj2sJOdipUiscMD+Pi2vVAXhCKxSoadoimShmr99NYq0DShWaoLmVdvBtDs7GEr
         emjWx8o9QD39sIEKT5bLhex1zKBygrfLqTvdjwC/TWfvyfvMmc5dz/xeV19dIfsdYXD2
         ufibo7q38Wm+40O+ZKA5JitXMU5NKhvm6w/BTmcKOlAeaERekEqDfa0QsDrMoOvTSjIs
         X3vw==
X-Gm-Message-State: AOAM5323Q1OozdiepKtdeoGBmp/2rr+ZjyO36syA1UOsl7b8+VKw1O/1
        ZhsmsN5Pu6BKSAxBvSQVf3E=
X-Google-Smtp-Source: ABdhPJxuPyLsjn+yEyNjyCJYB1NCIlQuoR5+JdQ95exFGCAh2nBokrDM/3FGYnbnZ/k/6vcPgac2YA==
X-Received: by 2002:a17:90b:1b01:b0:1dc:46ed:90de with SMTP id nu1-20020a17090b1b0100b001dc46ed90demr14414040pjb.107.1651868196233;
        Fri, 06 May 2022 13:16:36 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:a5d1:d7b7:dd61:c87b])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db8200b0015e8d4eb268sm2160156pld.178.2022.05.06.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:16:35 -0700 (PDT)
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
Subject: [PATCH 4/4] perf record: Handle argument change in sched_switch
Date:   Fri,  6 May 2022 13:16:27 -0700
Message-Id: <20220506201627.85598-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220506201627.85598-1-namhyung@kernel.org>
References: <20220506201627.85598-1-namhyung@kernel.org>
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

Thus I make two copies of the tracepoint handler and select one based
on the BTF info.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c          | 28 +++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 48 ++++++++++++++++++++------
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 89f36229041d..31343db68ed3 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -86,6 +86,33 @@ static void off_cpu_finish(void *arg __maybe_unused)
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
+		/* new format: pass prev_state as 2nd arg */
+		skel->rodata->has_prev_state = true;
+	}
+}
+
 int off_cpu_prepare(struct evlist *evlist, struct target *target)
 {
 	int err, fd, i;
@@ -114,6 +141,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target)
 	}
 
 	set_max_rlimit();
+	check_sched_switch_args();
 
 	err = off_cpu_bpf__load(skel);
 	if (err) {
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index c35106b9e20b..98eaba95924f 100644
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
@@ -180,4 +173,37 @@ int on_switch(u64 *ctx)
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
+	/*
+	 * For v5.18+:
+	 *   TP_PROTO(bool preempt, int prev_state,
+	 *            struct task_struct *prev,
+	 *            struct task_struct *next)
+	 *
+	 * On older kernels:
+	 *   TP_PROTO(bool preempt, struct task_struct *prev,
+	 *            struct task_struct *next)
+	 */
+	if (has_prev_state) {
+		prev = (struct task_struct *)ctx[2];
+		next = (struct task_struct *)ctx[3];
+		prev_state = (int)ctx[1];
+	} else {
+		prev = (struct task_struct *)ctx[1];
+		next = (struct task_struct *)ctx[2];
+
+		prev_state = get_task_state(prev);
+	}
+
+	return off_cpu_stat(ctx, prev, next, prev_state);
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.36.0.512.ge40c2bad7a-goog

