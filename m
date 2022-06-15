Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4589554D21F
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350413AbiFOT4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 15:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244636AbiFOT43 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 15:56:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA90B3120C;
        Wed, 15 Jun 2022 12:56:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g25so25295200ejh.9;
        Wed, 15 Jun 2022 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JgoFL4N11tKPxvfrZ6KdStmgDUzIx9PNIPdsLuwRcFE=;
        b=UabLVDRZ5eTMdG+ioXHln36v0O1SSBKV7JTF6MrXvqJCjsm844Xyas9PQxi+srfWWm
         tE3/AGwc+mHYUdBb3ScOmPxOEITAO91+Tc7MegtOHR7O26v5WBMyjQfyYe52+1c/55CK
         3n17QmHqSGee9bnC9GotCMw5U+kpzOpAHTa2VCul4qSy+85N4KUUAeF56lBErftk5TlJ
         Ixccl0rbuOdDPiK2V1+rFZ0l+lh/RC6yAjSHrloWoRn4eYeN/LIW4J2ViL0PKyjl3o0Q
         tlUJx9VdLndmwYPxKImam2PqJExphq/T3/XqVk5lVUxQuMxMLZ6QcTw6Arn6npQQUZCg
         7vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JgoFL4N11tKPxvfrZ6KdStmgDUzIx9PNIPdsLuwRcFE=;
        b=EWAUkorEnJgO+Ex+7iNHzIer4Wm2r43pagwmb4zdmqkgjCJvSkajCGH2kd/z/XuRI7
         n8xxoUiT+PRBZ1pfwqzZygeuhKdkvTI8tZbUrGe/Z8kfLrNwFOQRZcp/SJCTZb6SE38P
         SjolvMX0LGskxWhZuALNyMYushcydFU8R7+xbyly4MB65pddjf3i6EzPQe14a6u23IZh
         Y726O4dHx91GMCsGqBoHIH9TsAkVLZCJJC49DDeAnrpNBzBOPxMDFCeIILIDj8y8f8BW
         Way3mJf/iuxFtucP4aVSzySun0eES0NuqJt8aSkKMw+ab4ici+B54ohAGnZaWHRPmOHP
         hLhA==
X-Gm-Message-State: AJIora9JsqNsrJip5VZGf1ELvuvKn1kUVJ8PlW8nYPFjsF93mQqjG6ma
        WJ5GVmfoATRpuUfV+BQzY3zj1ja8XxTc7A==
X-Google-Smtp-Source: AGRyM1t9U2DOSB08UgKHymSOcV2rldlMwiWXzjlTmv9QNbh23vEgPeBwk9wMoC8iBrI1+l20nwi87g==
X-Received: by 2002:a17:907:3e0d:b0:711:dbff:b830 with SMTP id hp13-20020a1709073e0d00b00711dbffb830mr1333481ejc.601.1655322986118;
        Wed, 15 Jun 2022 12:56:26 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id vp23-20020a17090712d700b006f3ef214e72sm6620416ejb.216.2022.06.15.12.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 12:56:25 -0700 (PDT)
From:   Song Liu <9erthalion6@gmail.com>
X-Google-Original-From: Song Liu <songliubraving@fb.com>
To:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com, mhiramat@kernel.org, alexei.starovoitov@gmail.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH v2 1/1] perf/kprobe: maxactive for fd-based kprobe
Date:   Wed, 15 Jun 2022 21:55:01 +0200
Message-Id: <20220615195501.15597-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.32.0
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

Enable specifying maxactive for fd based kretprobe. This will be useful
for tracing tools like bcc and bpftrace (see for example discussion [1]).
Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.

The original patch [2] seems to be fallen through the cracks and wasn't
applied. I've merely rebased the work done by Song Liu and verififed it
still works.

Note that changes in rethook implementation may render maxactive
obsolete.

[1]: https://github.com/iovisor/bpftrace/issues/835
[2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v2:
    - Fix comment about number bits for the offset

 include/linux/trace_events.h    |  3 ++-
 kernel/events/core.c            | 20 ++++++++++++++++----
 kernel/trace/trace_event_perf.c |  5 +++--
 kernel/trace/trace_kprobe.c     |  4 ++--
 kernel/trace/trace_probe.h      |  2 +-
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6e95a9f07a5..7ca453a73252 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -850,7 +850,8 @@ extern void perf_trace_destroy(struct perf_event *event);
 extern int  perf_trace_add(struct perf_event *event, int flags);
 extern void perf_trace_del(struct perf_event *event, int flags);
 #ifdef CONFIG_KPROBE_EVENTS
-extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe);
+extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe,
+			     int max_active);
 extern void perf_kprobe_destroy(struct perf_event *event);
 extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **symbol,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 23bb19716ad3..e8127f9b4df5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9809,24 +9809,34 @@ static struct pmu perf_tracepoint = {
  * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
  *                               if not set, create kprobe/uprobe
  *
- * The following values specify a reference counter (or semaphore in the
- * terminology of tools like dtrace, systemtap, etc.) Userspace Statically
- * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
+ * PERF_UPROBE_REF_CTR_OFFSET_* specify a reference counter (or semaphore
+ * in the terminology of tools like dtrace, systemtap, etc.) Userspace
+ * Statically Defined Tracepoints (USDT). Currently, we use 32 bit for the
+ * offset.
  *
  * PERF_UPROBE_REF_CTR_OFFSET_BITS	# of bits in config as th offset
  * PERF_UPROBE_REF_CTR_OFFSET_SHIFT	# of bits to shift left
+ *
+ * PERF_KPROBE_MAX_ACTIVE_* defines max_active for kretprobe.
+ * KRETPROBE_MAXACTIVE_MAX is 4096. We allow 4095 here to save a bit.
  */
 enum perf_probe_config {
 	PERF_PROBE_CONFIG_IS_RETPROBE = 1U << 0,  /* [k,u]retprobe */
 	PERF_UPROBE_REF_CTR_OFFSET_BITS = 32,
 	PERF_UPROBE_REF_CTR_OFFSET_SHIFT = 64 - PERF_UPROBE_REF_CTR_OFFSET_BITS,
+	PERF_KPROBE_MAX_ACTIVE_BITS = 12,
+	PERF_KPROBE_MAX_ACTIVE_SHIFT = 64 - PERF_KPROBE_MAX_ACTIVE_BITS,
 };
 
 PMU_FORMAT_ATTR(retprobe, "config:0");
 #endif
 
 #ifdef CONFIG_KPROBE_EVENTS
+/* KRETPROBE_MAXACTIVE_MAX is 4096, only allow 4095 here to save a bit */
+PMU_FORMAT_ATTR(max_active, "config:52-63");
+
 static struct attribute *kprobe_attrs[] = {
+	&format_attr_max_active.attr,
 	&format_attr_retprobe.attr,
 	NULL,
 };
@@ -9857,6 +9867,7 @@ static int perf_kprobe_event_init(struct perf_event *event)
 {
 	int err;
 	bool is_retprobe;
+	int max_active;
 
 	if (event->attr.type != perf_kprobe.type)
 		return -ENOENT;
@@ -9871,7 +9882,8 @@ static int perf_kprobe_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 
 	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
-	err = perf_kprobe_init(event, is_retprobe);
+	max_active = event->attr.config >> PERF_KPROBE_MAX_ACTIVE_SHIFT;
+	err = perf_kprobe_init(event, is_retprobe, max_active);
 	if (err)
 		return err;
 
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a114549720d6..129000327809 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -245,7 +245,8 @@ void perf_trace_destroy(struct perf_event *p_event)
 }
 
 #ifdef CONFIG_KPROBE_EVENTS
-int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
+int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe,
+					 int max_active)
 {
 	int ret;
 	char *func = NULL;
@@ -271,7 +272,7 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
 
 	tp_event = create_local_trace_kprobe(
 		func, (void *)(unsigned long)(p_event->attr.kprobe_addr),
-		p_event->attr.probe_offset, is_retprobe);
+		p_event->attr.probe_offset, is_retprobe, max_active);
 	if (IS_ERR(tp_event)) {
 		ret = PTR_ERR(tp_event);
 		goto out;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 47cebef78532..3ad30cfce9c3 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1784,7 +1784,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
 /* create a trace_kprobe, but don't add it to global lists */
 struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
-			  bool is_return)
+			  bool is_return, int max_active)
 {
 	enum probe_print_type ptype;
 	struct trace_kprobe *tk;
@@ -1799,7 +1799,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	event = func ? func : "DUMMY_EVENT";
 
 	tk = alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event, (void *)addr, func,
-				offs, 0 /* maxactive */, 0 /* nargs */,
+				offs, max_active, 0 /* nargs */,
 				is_return);
 
 	if (IS_ERR(tk)) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 92cc149af0fd..26fe21980793 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -376,7 +376,7 @@ extern int traceprobe_set_print_fmt(struct trace_probe *tp, enum probe_print_typ
 #ifdef CONFIG_PERF_EVENTS
 extern struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
-			  bool is_return);
+			  bool is_return, int max_active);
 extern void destroy_local_trace_kprobe(struct trace_event_call *event_call);
 
 extern struct trace_event_call *
-- 
2.32.0

