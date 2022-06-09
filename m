Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853B75454FB
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiFITax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 15:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFITaw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 15:30:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507624FC48;
        Thu,  9 Jun 2022 12:30:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q15so25694245wrc.11;
        Thu, 09 Jun 2022 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzR5jRpRXQZcGn409L4lYEhScWSi5XMrFvgTPUe9C24=;
        b=iRsgDU+pSNYbsXFbM+nepB4iaycWhvjMctuerqCNGSOTERudA3GLSsR7er19srR2aN
         ZLpgEBSAA+cTAUDBpNrxM9gFcv5T7PhY8iGPKOiF0uN3+LCnM3O83em3inJMnRMfIajI
         c2gZ0tzqlsoUhmGbv8OhmBvhaiTYpjxrIHUnpQyTEgoA/tRPo/+ApQpTZ2MSQO+dQXoC
         MlOcvH/6dfIw+NlycemSg6xwHskhcHW4xF9oiiAuBTy6cFXcfC6TbdLXrWQMTdzSMyUl
         PZ1Zn7aNp2x+xy4ZhTSwz0fP5rV72wY8n2yJlXyKTLwMDDT1hObsKu5MdDoZZUUBI6JA
         Mowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzR5jRpRXQZcGn409L4lYEhScWSi5XMrFvgTPUe9C24=;
        b=0q99uO2ji3VGQUChwTBE/8H9umo706idaKhJ5kKoLMHxI4od4D+eY5dwjo+YZE3Ukf
         sZFp3+euW3wFBeJ1gcd8HyC1rV3ZzTt20RtUpPa6KrFPj3moDbkFWlA7RY1GtabRVGLt
         GYfUOn987/fuE99XXGbCsJFUJGiGzpkK3ZRRxIiVQtyWBlGdf8MOubaHxUGLYxwE+1ow
         d+RjqQhww3yG3PTBKe3h7//1lwkFY9HZXbZYF9iPw5QFmSiEhzm4KQQsY3w315JTD9Ja
         gU5hycCMhr8lqSHUe1+g4ckzbUjlvQU0qxTqcpAL29tsi8+VhPgYjAtNJsmkJnaJQA9s
         UjjQ==
X-Gm-Message-State: AOAM531qgY3hxaKU9Bz3D7rbYQsHSjXavzZw43Ea4yOtPp+0XfXfBh6l
        6+qAwEUFFMvBDU4aLVkwENDP27dyQKvM8Q==
X-Google-Smtp-Source: ABdhPJy+D65/gGG91x9FifFZSsWzOEHrBoQ5R+lb7Go3HvfXzVg4Y7O26+a7YvSnKVOMeupOsouqzA==
X-Received: by 2002:a05:6000:2cb:b0:210:33e9:2ec7 with SMTP id o11-20020a05600002cb00b0021033e92ec7mr38028965wry.317.1654803049619;
        Thu, 09 Jun 2022 12:30:49 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d6e0c000000b0020ff877cfbdsm25039578wrz.87.2022.06.09.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:30:49 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH] perf/kprobe: maxactive for fd-based kprobe
Date:   Thu,  9 Jun 2022 21:29:36 +0200
Message-Id: <20220609192936.23985-1-9erthalion6@gmail.com>
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

[1]: https://github.com/iovisor/bpftrace/issues/835
[2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
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
index 23bb19716ad3..f0e936b3dfc4 100644
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
+ * Statically Defined Tracepoints (USDT). Currently, we use 40 bit for the
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

