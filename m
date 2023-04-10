Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22C56DC7E5
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDJOcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDJOcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 10:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F05279;
        Mon, 10 Apr 2023 07:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BEB761126;
        Mon, 10 Apr 2023 14:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EFAC433EF;
        Mon, 10 Apr 2023 14:31:53 +0000 (UTC)
Date:   Mon, 10 Apr 2023 10:31:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <20230410103152.29c84333@gandalf.local.home>
In-Reply-To: <20230410101224.7e3b238c@gandalf.local.home>
References: <20230321020103.13494-1-laoar.shao@gmail.com>
        <20230321101711.625d0ccb@gandalf.local.home>
        <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
        <20230323083914.31f76c2b@gandalf.local.home>
        <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
        <20230323230105.57c40232@rorschach.local.home>
        <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
        <20230409075515.2504db78@rorschach.local.home>
        <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
        <20230409225414.2b66610f4145ade7b09339bb@kernel.org>
        <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
        <20230409220239.0fcf6738@rorschach.local.home>
        <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
        <20230410063046.391dd2bd@rorschach.local.home>
        <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
        <20230410101224.7e3b238c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 10 Apr 2023 10:12:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The disabling of preemption was just done because every place that used it
> happened to also disable preemption. So it was just a clean up, not a
> requirement. Although the documentation said it did disable preemption :-/
> 
>  See ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")
> 
> I think I can add a ftrace_test_recursion_try_aquire() and release() that
> is does the same thing without preemption. That way, we don't need to
> revert that patch, and use that instead.

This patch adds a:

   test_recursion_try_acquire() and test_recursion_release()

I called it "acquire" and "release" so that "lock" can imply preemption being
disabled, and this only protects against recursion (and I removed "ftrace"
in the name, as it is meant for non-ftrace uses, which I may give it a
different set of recursion bits).

Note, the reason to pass in ip, and parent_ip (_THIS_IP_ and _RET_IP_) is
for debugging purposes. They *should* be optimized out, as everything is
__always_inline or macros, and those are only used if
CONFIG_FTRACE_RECORD_RECURSION is enabled.

-- Steve


diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index d48cd92d2364..80de2ee7b4c3 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -150,9 +150,6 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 # define trace_warn_on_no_rcu(ip)	false
 #endif
 
-/*
- * Preemption is promised to be disabled when return bit >= 0.
- */
 static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
 							int start)
 {
@@ -182,18 +179,11 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	val |= 1 << bit;
 	current->trace_recursion = val;
 	barrier();
-
-	preempt_disable_notrace();
-
 	return bit;
 }
 
-/*
- * Preemption will be enabled (if it was previously enabled).
- */
 static __always_inline void trace_clear_recursion(int bit)
 {
-	preempt_enable_notrace();
 	barrier();
 	trace_recursion_clear(bit);
 }
@@ -205,12 +195,18 @@ static __always_inline void trace_clear_recursion(int bit)
  * tracing recursed in the same context (normal vs interrupt),
  *
  * Returns: -1 if a recursion happened.
- *           >= 0 if no recursion.
+ *           >= 0 if no recursion and preemption will be disabled.
  */
 static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
 							 unsigned long parent_ip)
 {
-	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+	int bit;
+
+	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+	if (unlikely(bit < 0))
+		return -1;
+	preempt_disable_notrace();
+	return bit;
 }
 
 /**
@@ -220,6 +216,33 @@ static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
  * This is used at the end of a ftrace callback.
  */
 static __always_inline void ftrace_test_recursion_unlock(int bit)
+{
+	preempt_enable_notrace();
+	trace_clear_recursion(bit);
+}
+
+/**
+ * test_recursion_try_acquire - tests for recursion in same context
+ *
+ * This will detect recursion of a function.
+ *
+ * Returns: -1 if a recursion happened.
+ *           >= 0 if no recursion
+ */
+static __always_inline int test_recursion_try_acquire(unsigned long ip,
+						      unsigned long parent_ip)
+{
+	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+}
+
+/**
+ * test_recursion_release - called after a success of test_recursion_try_acquire()
+ * @bit: The return of a successful test_recursion_try_acquire()
+ *
+ * This releases the recursion lock taken by a non-negative return call
+ * by test_recursion_try_acquire().
+ */
+static __always_inline void test_recursion_release(int bit)
 {
 	trace_clear_recursion(bit);
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0feea145bb29..ff8172ba48b0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7644,6 +7644,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
+	preempt_disable();
 	do_for_each_ftrace_op(op, ftrace_ops_list) {
 		/* Stub functions don't need to be called nor tested */
 		if (op->flags & FTRACE_OPS_FL_STUB)
@@ -7665,6 +7666,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		}
 	} while_for_each_ftrace_op(op);
 out:
+	preempt_enable();
 	trace_clear_recursion(bit);
 }
 
