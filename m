Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C638636058
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 14:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiKWNsU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 08:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbiKWNrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 08:47:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C184733D;
        Wed, 23 Nov 2022 05:37:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54F1CB81F31;
        Wed, 23 Nov 2022 13:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592C5C433D7;
        Wed, 23 Nov 2022 13:37:15 +0000 (UTC)
Date:   Wed, 23 Nov 2022 08:37:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhiramat@kernel.org>, <yujie.liu@intel.com>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Optimize event type allocation with IDA
Message-ID: <20221123083713.5e43d831@gandalf.local.home>
In-Reply-To: <20221123080133.1128186-1-zhengyejian1@huawei.com>
References: <20221122223258.10faaf4e@rorschach.local.home>
        <20221123080133.1128186-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 23 Nov 2022 16:01:33 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> But instead of clear tracing buffers, would it be better to just mark
> that record invalid if we had a way of knowing that the format had changed?

We'd have to scan all ring buffers for the records. The only way to know
what a binary blob in the ring buffer represents is this type.

But, I do the same for modules. And by hooking into that infrastructure, I
can do the above commands again with the IDA patch included, and it works
fine. If any dynamic event was enabled and then removed, it will reset the
corresponding buffer where it was enabled in. This is needed regardless of
your patch because once we get over 65536 types, the behavior of the type
assignment is the same as the IDA logic. The IDA code didn't trigger a bug,
it revealed an existing one.

Care to test with the below patch added. I'll add this first (breaking it
up a little) and then apply your patch.

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a47fed2f473..93a75a97118f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2180,10 +2180,12 @@ void tracing_reset_online_cpus(struct array_buffer *buf)
 }
 
 /* Must have trace_types_lock held */
-void tracing_reset_all_online_cpus(void)
+void tracing_reset_all_online_cpus_unlocked(void)
 {
 	struct trace_array *tr;
 
+	lockdep_assert_held(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (!tr->clear_trace)
 			continue;
@@ -2195,6 +2197,13 @@ void tracing_reset_all_online_cpus(void)
 	}
 }
 
+void tracing_reset_all_online_cpus(void)
+{
+	mutex_lock(&trace_types_lock);
+	tracing_reset_all_online_cpus_unlocked();
+	mutex_unlock(&trace_types_lock);
+}
+
 /*
  * The tgid_map array maps from pid to tgid; i.e. the value stored at index i
  * is the tgid last observed corresponding to pid=i.
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d9b470a0adf2..48643f07bc01 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -580,6 +580,7 @@ int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct array_buffer *buf);
 void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
+void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 154996684fb5..4376887e0d8a 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -118,6 +118,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		if (ret)
 			break;
 	}
+	tracing_reset_all_online_cpus();
 	mutex_unlock(&event_mutex);
 out:
 	argv_free(argv);
@@ -214,6 +215,7 @@ int dyn_events_release_all(struct dyn_event_operations *type)
 			break;
 	}
 out:
+	tracing_reset_all_online_cpus();
 	mutex_unlock(&event_mutex);
 
 	return ret;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7372fffb8109..3bfaf560ecc4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2947,7 +2947,10 @@ static int probe_remove_event_call(struct trace_event_call *call)
 		 * TRACE_REG_UNREGISTER.
 		 */
 		if (file->flags & EVENT_FILE_FL_ENABLED)
-			return -EBUSY;
+			goto busy;
+
+		if (file->flags & EVENT_FILE_FL_WAS_ENABLED)
+			tr->clear_trace = true;
 		/*
 		 * The do_for_each_event_file_safe() is
 		 * a double loop. After finding the call for this
@@ -2960,6 +2963,12 @@ static int probe_remove_event_call(struct trace_event_call *call)
 	__trace_remove_event_call(call);
 
 	return 0;
+ busy:
+	/* No need to clear the trace now */
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		tr->clear_trace = false;
+	}
+	return -EBUSY;
 }
 
 /* Remove an event_call */
@@ -3039,7 +3048,7 @@ static void trace_module_remove_events(struct module *mod)
 	 * over from this module may be passed to the new module events and
 	 * unexpected results may occur.
 	 */
-	tracing_reset_all_online_cpus();
+	tracing_reset_all_online_cpus_unlocked();
 }
 
 static int trace_module_notify(struct notifier_block *self,
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 29fbfb27c2b2..c3b582d19b62 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1425,7 +1425,6 @@ int synth_event_delete(const char *event_name)
 	mutex_unlock(&event_mutex);
 
 	if (mod) {
-		mutex_lock(&trace_types_lock);
 		/*
 		 * It is safest to reset the ring buffer if the module
 		 * being unloaded registered any events that were
@@ -1437,7 +1436,6 @@ int synth_event_delete(const char *event_name)
 		 * occur.
 		 */
 		tracing_reset_all_online_cpus();
-		mutex_unlock(&trace_types_lock);
 	}
 
 	return ret;
