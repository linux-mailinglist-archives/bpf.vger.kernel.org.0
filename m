Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34563FF8C
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 05:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiLBEqK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 23:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiLBEqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 23:46:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA8D679E;
        Thu,  1 Dec 2022 20:46:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 070DFB820A9;
        Fri,  2 Dec 2022 04:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C05CC433D7;
        Fri,  2 Dec 2022 04:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669956364;
        bh=UiL3Tb7gm2PApOES13tLz7BW0HNCgZohBDZDdYDnv8U=;
        h=From:To:Cc:Subject:Date:From;
        b=mn+IoppK2cJtLbsEBVYor4VjYEz8274Q3NzRMoaK75dOsjyxAIMQgU+70Nd8qHqsY
         +EnNTsSDLBYJAfaBPo2X7MfvhxeJF0dEsKTUymSFMtLBfTqGSxXEfNG9Pb2WAyc5kV
         N6Y8fA2M5HwoSv2ps/kwe1W7SMyANeC5nGk/FLsygm0/bnOFTFCYf56Eg8d78p6RvG
         4SIIHtdfZ5H2BJNjtp8rScqGhQQ6kdgZg95UjrsMSCvqedboTIOcEA6j0c9iSLpyqW
         6fhMgAVrqKlSp8XD2jmyglAEOER0pp9DVsXb05VTbUTrivOggCpzD1GRtFYlYuY2d2
         j01YCVtLo/5EA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bpf@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: [PATCH] panic: Taint kernel if fault injection has been used
Date:   Fri,  2 Dec 2022 13:45:59 +0900
Message-Id: <166995635931.455067.17768077948832448089.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the function error injection framework in the fault injection
subsystem can change the function code flow forcibly, it may cause
unexpected behavior (and that is the purpose of this feature) even
if it is applied to the ALLOW_ERROR_INJECTION functions.
So this feature must be used only for debugging or testing purpose.

To identify this in the kernel oops message, add a new taint flag
for the fault injection. This taint flag will be set by either
function error injection is used or the BPF use the kprobe_override
on error injectable functions (identified by ALLOW_ERROR_INJECTION).

Link: https://lore.kernel.org/all/20221121104403.1545f9b5@gandalf.local.home/T/#u

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/admin-guide/tainted-kernels.rst |    5 +++++
 include/linux/panic.h                         |    3 ++-
 kernel/fail_function.c                        |    2 ++
 kernel/panic.c                                |    1 +
 kernel/trace/bpf_trace.c                      |    2 ++
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 92a8a07f5c43..63d7cd4f6250 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -101,6 +101,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
  18  _/N  262144  an in-kernel test has been run
+ 19  _/J  524288  a function-level error has been injected
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
@@ -182,3 +183,7 @@ More detailed explanation for tainting
      produce extremely unusual kernel structure layouts (even performance
      pathological ones), which is important to know when debugging. Set at
      build time.
+
+ 19) ``J`` if a function-level error has been injected and the code path was
+     forcibly changed by either function error injection framework or BPF's
+     function override feature.
diff --git a/include/linux/panic.h b/include/linux/panic.h
index c7759b3f2045..2b03a02d86be 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -69,7 +69,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
-#define TAINT_FLAGS_COUNT		19
+#define TAINT_FAULT_INJECTED		19
+#define TAINT_FLAGS_COUNT		20
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index a7ccd2930c5f..80a743f14a2c 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -9,6 +9,7 @@
 #include <linux/kprobes.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/panic.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -298,6 +299,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 		fei_attr_free(attr);
 		goto out;
 	}
+	add_taint(TAINT_FAULT_INJECTED, LOCKDEP_NOW_UNRELIABLE);
 	fei_debugfs_add_attr(attr);
 	list_add_tail(&attr->list, &fei_attr_list);
 	ret = count;
diff --git a/kernel/panic.c b/kernel/panic.c
index da323209f583..e396a5fd9bb6 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -426,6 +426,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
 	[ TAINT_TEST ]			= { 'N', ' ', true },
+	[ TAINT_FAULT_INJECTED ]	= { 'J', ' ', false },
 };
 
 /**
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1ed08967fb97..de0614d9796c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2137,6 +2137,8 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 		goto unlock;
 
 	/* set the new array to event->tp_event and set event->prog */
+	if (prog->kprobe_override)
+		add_taint(TAINT_FAULT_INJECTED, LOCKDEP_NOW_UNRELIABLE);
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
 	rcu_assign_pointer(event->tp_event->prog_array, new_array);

