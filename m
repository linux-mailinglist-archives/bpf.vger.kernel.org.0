Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A66688CF7
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 03:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBCCNd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 21:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjBCCNb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 21:13:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C70C21290;
        Thu,  2 Feb 2023 18:13:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so6918907pjq.1;
        Thu, 02 Feb 2023 18:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVb6/wY5BO86ABIxc8pLAp0Fww2Vgk9VT30AEyLAIxo=;
        b=KwzAhqGoIxk/QgLhdRBq68ZGuM3GsY8mmRu3zZkE72wvSJgiW7HVIR5DLr5bsVNXgS
         l3/v0/PUF7kihPB+DkLf0oKJRwoBOxI4Fqmfkjre1f59fjOjkn6QnDbCxWXnulFYa53t
         IOHkq0NU4tX7T0pZFPih49XcawI0iwRtRsmSugKjBE6eH3kHINggzOOevDM41o9p5pbX
         FCSHWoFW9AcwrFJbZBHonkbmIhRZexqklRx5BJpdc99pHimcQBpcUUD7Z9P3j+nv9c/V
         bc7ToLj1fzUA0kHMOcVaVxiK1oW+WV1yINawg3USoBG/2/Ud7geReHVJEtzRO4o9sIa0
         xsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVb6/wY5BO86ABIxc8pLAp0Fww2Vgk9VT30AEyLAIxo=;
        b=oNrYOPLqZJ2ZeMHkGae1XtXR57AK8rQ6TAT+MWFufxaWkwT18MOvsV5Mveervdx6pi
         4rk2H4MmaOwC+nYDiIrZUH1dIekdXt2DzWPR5CWTMDZ0HD6f2uKsJ8Q41O6eG5oqQtcU
         JNwyv8Ael6X1Mk0jI385OaV2S0RD8TO8GrW88uUsqIBEImD/uJVkxrTqP73gNenzIng5
         IxQObkhYUEF+33q8yJ1I09Y+R9iMyJXY2rd2HqXUhrAsnDptOcskc5PrTqJr+PqGL/qa
         tmakfJtjUX2zRlEPDQCNQFmGxaruXajxoDNN8PCZdkIAOEj7r9YM+Zc72vYbBEkFtx1o
         S6Yg==
X-Gm-Message-State: AO0yUKW1D2jHHfDeUsvs/o4PUXTzChr4brMLRATZnMIl0vOgv4W7Wk4L
        C4Lq1cBtb+gvGR0U0vlGtZI=
X-Google-Smtp-Source: AK7set88io4RaJ+ART294KADHQ1jZPyoQw5F4pi8wHbnaAmniBA3Wutkwcm+bacj58AeC1s9Y4DhXQ==
X-Received: by 2002:a17:90b:38cc:b0:22c:61c:2d5b with SMTP id nn12-20020a17090b38cc00b0022c061c2d5bmr8857231pjb.20.1675390409931;
        Thu, 02 Feb 2023 18:13:29 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:6755:96ed:3f18:dac4])
        by smtp.gmail.com with ESMTPSA id fs23-20020a17090af29700b0022c942b8683sm497249pjb.56.2023.02.02.18.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 18:13:29 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, irogers@google.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, song@kernel.org,
        haoluo@google.com, bpf@vger.kernel.org, juri.lelli@redhat.com
Subject: [PATCH v2 1/3] perf lock contention: Factor out lock_contention_get_name()
Date:   Thu,  2 Feb 2023 18:13:22 -0800
Message-Id: <20230203021324.143540-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230203021324.143540-1-namhyung@kernel.org>
References: <20230203021324.143540-1-namhyung@kernel.org>
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

The lock_contention_get_name() returns a name for the lock stat entry
based on the current aggregation mode.  As it's called sequentially in a
single thread, it can return the address of a static buffer for symbol
and offset of the caller.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c | 115 +++++++++++++++-----------
 1 file changed, 65 insertions(+), 50 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 4902ac331f41..286e52ba9f91 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -163,9 +163,70 @@ int lock_contention_stop(void)
 	return 0;
 }
 
+static const char *lock_contention_get_name(struct lock_contention *con,
+					    struct contention_key *key,
+					    u64 *stack_trace)
+{
+	int idx = 0;
+	u64 addr;
+	const char *name = "";
+	static char name_buf[KSYM_NAME_LEN];
+	struct symbol *sym;
+	struct map *kmap;
+	struct machine *machine = con->machine;
+
+	if (con->aggr_mode == LOCK_AGGR_TASK) {
+		struct contention_task_data task;
+		int pid = key->aggr_key;
+		int task_fd = bpf_map__fd(skel->maps.task_data);
+
+		/* do not update idle comm which contains CPU number */
+		if (pid) {
+			struct thread *t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
+
+			if (t == NULL)
+				return name;
+			if (!bpf_map_lookup_elem(task_fd, &pid, &task) &&
+			    thread__set_comm(t, task.comm, /*timestamp=*/0))
+				name = task.comm;
+		}
+		return name;
+	}
+
+	if (con->aggr_mode == LOCK_AGGR_ADDR) {
+		sym = machine__find_kernel_symbol(machine, key->aggr_key, &kmap);
+		if (sym)
+			name = sym->name;
+		return name;
+	}
+
+	/* LOCK_AGGR_CALLER: skip lock internal functions */
+	while (machine__is_lock_function(machine, stack_trace[idx]) &&
+	       idx < con->max_stack - 1)
+		idx++;
+
+	addr = stack_trace[idx];
+	sym = machine__find_kernel_symbol(machine, addr, &kmap);
+
+	if (sym) {
+		unsigned long offset;
+
+		offset = kmap->map_ip(kmap, addr) - sym->start;
+
+		if (offset == 0)
+			return sym->name;
+
+		snprintf(name_buf, sizeof(name_buf), "%s+%#lx", sym->name, offset);
+	} else {
+		snprintf(name_buf, sizeof(name_buf), "%#lx", (unsigned long)addr);
+	}
+
+	return name_buf;
+}
+
 int lock_contention_read(struct lock_contention *con)
 {
-	int fd, stack, task_fd, err = 0;
+	int fd, stack, err = 0;
 	struct contention_key *prev_key, key;
 	struct contention_data data = {};
 	struct lock_stat *st = NULL;
@@ -175,7 +236,6 @@ int lock_contention_read(struct lock_contention *con)
 
 	fd = bpf_map__fd(skel->maps.lock_stat);
 	stack = bpf_map__fd(skel->maps.stacks);
-	task_fd = bpf_map__fd(skel->maps.task_data);
 
 	con->lost = skel->bss->lost;
 
@@ -195,9 +255,6 @@ int lock_contention_read(struct lock_contention *con)
 
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
-		struct map *kmap;
-		struct symbol *sym;
-		int idx = 0;
 		s32 stack_id;
 
 		/* to handle errors in the loop body */
@@ -219,61 +276,19 @@ int lock_contention_read(struct lock_contention *con)
 		st->flags = data.flags;
 		st->addr = key.aggr_key;
 
-		if (con->aggr_mode == LOCK_AGGR_TASK) {
-			struct contention_task_data task;
-			struct thread *t;
-			int pid = key.aggr_key;
-
-			/* do not update idle comm which contains CPU number */
-			if (st->addr) {
-				bpf_map_lookup_elem(task_fd, &pid, &task);
-				t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
-				thread__set_comm(t, task.comm, /*timestamp=*/0);
-			}
-			goto next;
-		}
-
-		if (con->aggr_mode == LOCK_AGGR_ADDR) {
-			sym = machine__find_kernel_symbol(machine, st->addr, &kmap);
-			if (sym)
-				st->name = strdup(sym->name);
-			goto next;
-		}
-
 		stack_id = key.aggr_key;
 		bpf_map_lookup_elem(stack, &stack_id, stack_trace);
 
-		/* skip lock internal functions */
-		while (machine__is_lock_function(machine, stack_trace[idx]) &&
-		       idx < con->max_stack - 1)
-			idx++;
-
-		st->addr = stack_trace[idx];
-		sym = machine__find_kernel_symbol(machine, st->addr, &kmap);
-
-		if (sym) {
-			unsigned long offset;
-			int ret = 0;
-
-			offset = kmap->map_ip(kmap, st->addr) - sym->start;
-
-			if (offset)
-				ret = asprintf(&st->name, "%s+%#lx", sym->name, offset);
-			else
-				st->name = strdup(sym->name);
-
-			if (ret < 0 || st->name == NULL)
-				break;
-		} else if (asprintf(&st->name, "%#lx", (unsigned long)st->addr) < 0) {
+		st->name = strdup(lock_contention_get_name(con, &key, stack_trace));
+		if (st->name == NULL)
 			break;
-		}
 
 		if (con->save_callstack) {
 			st->callstack = memdup(stack_trace, stack_size);
 			if (st->callstack == NULL)
 				break;
 		}
-next:
+
 		hlist_add_head(&st->hash_entry, con->result);
 		prev_key = &key;
 
-- 
2.39.1.519.gcb327c4b5f-goog

