Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126DD4F0B14
	for <lists+bpf@lfdr.de>; Sun,  3 Apr 2022 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiDCQKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiDCQKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 12:10:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF039836
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 09:08:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bh17so15291232ejb.8
        for <bpf@vger.kernel.org>; Sun, 03 Apr 2022 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aw9Z8syibvVPGLl55rs0k1Ml1FM/2mk1tEZsyZQf12Y=;
        b=HPLRqzYQp9dur0uHs22n4Q32ucFcBdBHJvR7Pfr5ykE2SMpgaOfU2CMQPrXbxanWxv
         UjLiHcRo2JC9wAwu2MxIpuaLTG/1gVfeAnX4FGZc5yGGLMhFsfocev1UGurAX1jw4bof
         jTmR4Blpi7j1dqPaBedVV2jtTiY8bIFC9onHqQ1k0xEM9QWKEUEJB1JPYAd9+3ZhXLGG
         KEGyFvVXYxvKEZqUt6PgDO6toiP/4eO36sk8b18t2vVYllpW5u672wrrw16Tq7lSNpms
         Mk8O2b1c0AnpJ9kP4XBLX55xPHdbkhIUlMPe9EajyfUy08UQz40dbrWdXCaNRrGlP1fj
         Zpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aw9Z8syibvVPGLl55rs0k1Ml1FM/2mk1tEZsyZQf12Y=;
        b=UK+Yr9RXECPyKSbrYQxbL9R2tx+i4O8UrCH9rpN752YHjQE/VCbwHW3yn0DhR5E6k/
         UX+ipLWApx9KtHwbxoW4ymns84YcSR9W9S2z9hyidgqjBpxXQkRRd3KCKxgmYjFJcXQ/
         NnXpNsRLgRc8a7OLxCz0T2Wu8KmrUSMROIjHYcH7dowbvEsHsaakr0zP0fPFgvX6qvr9
         zkFhyUw9pApLpTesYggRCMjxXLHRKSyZ7qYvaTQTT+84aZYlDjV2d7GGtfu2pCHuI+bx
         dRJ/E860UctU0uUydHSLzqB68z6TE/DW6YAwo9QkkToHJO/+nlw6WebD9T3PDOj0L978
         bsnA==
X-Gm-Message-State: AOAM530nXuKiDpJ7qSDx96j5BaYREyApJT0L0ckql4V3BmQ0jrNXsvyZ
        0Xodcyyvk8nYaaH22FTWcaCEaFRahG9zBw==
X-Google-Smtp-Source: ABdhPJxiBkUQfgL+M/Tdeyp2luNqcDkuMQwXABcm0xHNXLYQQoEdjWfZI2Y7GXJhqeyqMu+AH8zM2w==
X-Received: by 2002:a17:907:1b27:b0:6d9:ceb6:7967 with SMTP id mp39-20020a1709071b2700b006d9ceb67967mr7911250ejc.186.1649002092992;
        Sun, 03 Apr 2022 09:08:12 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-030-091.094.222.pools.vodafone-ip.de. [94.222.30.91])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm3332053ejl.185.2022.04.03.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:08:12 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, yhs@fb.com,
        songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH bpf-next 1/2] bpf: tracing: Introduce prio field for bpf_prog
Date:   Sun,  3 Apr 2022 18:07:17 +0200
Message-Id: <20220403160718.13730-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403160718.13730-1-9erthalion6@gmail.com>
References: <20220403160718.13730-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add prio field into bpf_prog_array_item. The field signals what is the
priority of the item in the array. Use it in bpf_prog_array_copy to
place the new item in the array according to the priority. The change
doesn't cover bpf_prog_array_update_at yet.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 drivers/media/rc/bpf-lirc.c    |  4 ++--
 include/linux/bpf.h            |  3 ++-
 include/linux/trace_events.h   |  7 ++++---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/core.c              | 19 +++++++++++++++++--
 kernel/bpf/syscall.c           |  2 +-
 kernel/events/core.c           |  8 ++++----
 kernel/trace/bpf_trace.c       |  8 +++++---
 tools/include/uapi/linux/bpf.h |  1 +
 9 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 3eff08d7b8e5..b240149bd004 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -160,7 +160,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
+	ret = bpf_prog_array_copy(old_array, NULL, prog, 0, 0, &new_array);
 	if (ret < 0)
 		goto unlock;
 
@@ -193,7 +193,7 @@ static int lirc_bpf_detach(struct rc_dev *rcdev, struct bpf_prog *prog)
 	}
 
 	old_array = lirc_rcu_dereference(raw->progs);
-	ret = bpf_prog_array_copy(old_array, prog, NULL, 0, &new_array);
+	ret = bpf_prog_array_copy(old_array, prog, NULL, 0, 0, &new_array);
 	/*
 	 * Do not use bpf_prog_array_delete_safe() as we would end up
 	 * with a dummy entry in the array, and the we would free the
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..f00ac9e5bfa2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1235,6 +1235,7 @@ struct bpf_prog_array_item {
 	union {
 		struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 		u64 bpf_cookie;
+		u32 prio;
 	};
 };
 
@@ -1274,7 +1275,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array *array,
 int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
-			u64 bpf_cookie,
+			u64 bpf_cookie, u32 prio,
 			struct bpf_prog_array **new_array);
 
 struct bpf_run_ctx {};
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6e95a9f07a5..06996f85def8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -736,7 +736,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
 
 #ifdef CONFIG_BPF_EVENTS
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
-int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
+int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie, u32 prio);
 void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
@@ -754,7 +754,7 @@ static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *c
 }
 
 static inline int
-perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie)
+perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie, u32 prio)
 {
 	return -EOPNOTSUPP;
 }
@@ -871,7 +871,8 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
 void perf_trace_buf_update(void *record, u16 type);
 void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
+int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
+			u64 bpf_cookie, u32 prio);
 void perf_event_free_bpf_prog(struct perf_event *event);
 
 void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d14b10b85e51..10054c034518 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1481,6 +1481,7 @@ union bpf_attr {
 				 * accessible through bpf_get_attach_cookie() BPF helper
 				 */
 				__u64		bpf_cookie;
+				__u32		prio;
 			} perf_event;
 			struct {
 				__u32		flags;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 13e9dbeeedf3..8a89cc69c74b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2405,13 +2405,14 @@ int bpf_prog_array_update_at(struct bpf_prog_array *array, int index,
 int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
-			u64 bpf_cookie,
+			u64 bpf_cookie, u32 prio,
 			struct bpf_prog_array **new_array)
 {
 	int new_prog_cnt, carry_prog_cnt = 0;
 	struct bpf_prog_array_item *existing, *new;
 	struct bpf_prog_array *array;
 	bool found_exclude = false;
+	bool found_less_prio = false;
 
 	/* Figure out how many existing progs we need to carry over to
 	 * the new array.
@@ -2458,16 +2459,30 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			    existing->prog == &dummy_bpf_prog.prog)
 				continue;
 
+			if (include_prog && existing->prio <= prio) {
+				found_less_prio = true;
+
+				new->prog = include_prog;
+				new->prio = prio;
+				new->bpf_cookie = bpf_cookie;
+
+				new++;
+			}
+
 			new->prog = existing->prog;
 			new->bpf_cookie = existing->bpf_cookie;
+			new->prio = existing->prio;
 			new++;
 		}
 	}
-	if (include_prog) {
+
+	if (include_prog && !found_less_prio) {
 		new->prog = include_prog;
 		new->bpf_cookie = bpf_cookie;
+		new->prio = prio;
 		new++;
 	}
+
 	new->prog = NULL;
 	*new_array = array;
 	return 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cdaa1152436a..72fb3d2c30a4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3009,7 +3009,7 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 	}
 
 	event = perf_file->private_data;
-	err = perf_event_set_bpf_prog(event, prog, attr->link_create.perf_event.bpf_cookie);
+	err = perf_event_set_bpf_prog(event, prog, attr->link_create.perf_event.bpf_cookie, 0);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_file;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index cfde994ce61c..283464c870f2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5753,7 +5753,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 
-		err = perf_event_set_bpf_prog(event, prog, 0);
+		err = perf_event_set_bpf_prog(event, prog, 0, 0);
 		if (err) {
 			bpf_prog_put(prog);
 			return err;
@@ -10172,7 +10172,7 @@ static inline bool perf_event_is_tracing(struct perf_event *event)
 }
 
 int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
-			    u64 bpf_cookie)
+			    u64 bpf_cookie, u32 prio)
 {
 	bool is_kprobe, is_tracepoint, is_syscall_tp;
 
@@ -10203,7 +10203,7 @@ int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
 			return -EACCES;
 	}
 
-	return perf_event_attach_bpf_prog(event, prog, bpf_cookie);
+	return perf_event_attach_bpf_prog(event, prog, bpf_cookie, prio);
 }
 
 void perf_event_free_bpf_prog(struct perf_event *event)
@@ -10226,7 +10226,7 @@ static void perf_event_free_filter(struct perf_event *event)
 }
 
 int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
-			    u64 bpf_cookie)
+			    u64 bpf_cookie, u32 prio)
 {
 	return -ENOENT;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 836f021cb609..be3b282f2909 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1877,7 +1877,7 @@ static DEFINE_MUTEX(bpf_event_mutex);
 
 int perf_event_attach_bpf_prog(struct perf_event *event,
 			       struct bpf_prog *prog,
-			       u64 bpf_cookie)
+			       u64 bpf_cookie, u32 prio)
 {
 	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
@@ -1904,7 +1904,9 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 		goto unlock;
 	}
 
-	ret = bpf_prog_array_copy(old_array, NULL, prog, bpf_cookie, &new_array);
+	ret = bpf_prog_array_copy(old_array, NULL, prog, bpf_cookie,
+										prio, &new_array);
+
 	if (ret < 0)
 		goto unlock;
 
@@ -1931,7 +1933,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		goto unlock;
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
-	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
+	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, 0, &new_array);
 	if (ret == -ENOENT)
 		goto unlock;
 	if (ret < 0) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d14b10b85e51..10054c034518 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1481,6 +1481,7 @@ union bpf_attr {
 				 * accessible through bpf_get_attach_cookie() BPF helper
 				 */
 				__u64		bpf_cookie;
+				__u32		prio;
 			} perf_event;
 			struct {
 				__u32		flags;
-- 
2.32.0

