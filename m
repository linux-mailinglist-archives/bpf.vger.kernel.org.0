Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6054D6599
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 17:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349920AbiCKQBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 11:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350115AbiCKQBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 11:01:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C01D0867;
        Fri, 11 Mar 2022 08:00:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88EF261A8A;
        Fri, 11 Mar 2022 16:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6750BC340E9;
        Fri, 11 Mar 2022 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647014433;
        bh=b3GT2pGwGMaAHvd/bc9+2LYV45iokc6EvhLSfZ9d33A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObKcrg2L9Mdz7uMbQ5OJ8+xuO8iT5zZ5PvaGj2Toe9cTT9gEuy5pYi+OYmgCTdqOc
         LJylU7KjgsUshkxUtGT8Mcd58CA6G86amHYV7qKZnhDVsmvvWQz3cIbCj619o+ERVb
         EEjaQsMKxmX9PXnbdy/GVHN3pkWLKbrYpciEXgJj5WhNrjev4Xdibhr3ygs2UfsUs0
         W4gTH68MP2ICDocDDrGZ89fPPiaV6OKxT/vLjDzJNgSgcHaF3Vz1ZezEQY8pGcqN26
         6RcuzdL0+lBpABmreGsTQW8ZmYqnwVDUoxMoz4ZObY/2LA2Y7WbxWIroWaQVMiFdQ2
         n6cXHq3ZFLozQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v11 09/12] fprobe: Add sample program for fprobe
Date:   Sat, 12 Mar 2022 01:00:26 +0900
Message-Id: <164701442659.268462.9726332062665437866.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164701432038.268462.3329725152949938527.stgit@devnote2>
References: <164701432038.268462.3329725152949938527.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a sample program for the fprobe. The sample_fprobe puts a fprobe on
kernel_clone() by default. This dump stack and some called address info
at the function entry and exit.

The sample_fprobe.ko gets 2 parameters.
- symbol: you can specify the comma separated symbols or wildcard symbol
  pattern (in this case you can not use comma)
- stackdump: a bool value to enable or disable stack dump in the fprobe
  handler.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v6:
  - Dump stack on the handler as explained in the comment.
  - Add "stackdump" option to enable/disable stackdump.
  - Support wildcard filter.
 Changes in v2:
  - Fix infinit loop for multiple symbols.
  - Fix memory leaks for copied string and entry array.
  - Update for new fprobe APIs.
  - Fix style issues.
---
 samples/Kconfig                 |    7 ++
 samples/Makefile                |    1 
 samples/fprobe/Makefile         |    3 +
 samples/fprobe/fprobe_example.c |  120 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 samples/fprobe/Makefile
 create mode 100644 samples/fprobe/fprobe_example.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 22cc921ae291..8415d60ea5f4 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -73,6 +73,13 @@ config SAMPLE_HW_BREAKPOINT
 	help
 	  This builds kernel hardware breakpoint example modules.
 
+config SAMPLE_FPROBE
+	tristate "Build fprobe examples -- loadable modules only"
+	depends on FPROBE && m
+	help
+	  This builds a fprobe example module. This module has an option 'symbol'.
+	  You can specify a probed symbol or symbols separated with ','.
+
 config SAMPLE_KFIFO
 	tristate "Build kfifo examples -- loadable modules only"
 	depends on m
diff --git a/samples/Makefile b/samples/Makefile
index 1ae4de99c983..6d662965be5b 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -33,3 +33,4 @@ subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
+obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
diff --git a/samples/fprobe/Makefile b/samples/fprobe/Makefile
new file mode 100644
index 000000000000..ecccbfa6e99b
--- /dev/null
+++ b/samples/fprobe/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SAMPLE_FPROBE) += fprobe_example.o
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
new file mode 100644
index 000000000000..24d3cf109140
--- /dev/null
+++ b/samples/fprobe/fprobe_example.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Here's a sample kernel module showing the use of fprobe to dump a
+ * stack trace and selected registers when kernel_clone() is called.
+ *
+ * For more information on theory of operation of kprobes, see
+ * Documentation/trace/kprobes.rst
+ *
+ * You will see the trace data in /var/log/messages and on the console
+ * whenever kernel_clone() is invoked to create a new process.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fprobe.h>
+#include <linux/sched/debug.h>
+#include <linux/slab.h>
+
+#define BACKTRACE_DEPTH 16
+#define MAX_SYMBOL_LEN 4096
+struct fprobe sample_probe;
+
+static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
+module_param_string(symbol, symbol, sizeof(symbol), 0644);
+static char nosymbol[MAX_SYMBOL_LEN] = "";
+module_param_string(nosymbol, nosymbol, sizeof(nosymbol), 0644);
+static bool stackdump = true;
+module_param(stackdump, bool, 0644);
+
+static void show_backtrace(void)
+{
+	unsigned long stacks[BACKTRACE_DEPTH];
+	unsigned int len;
+
+	len = stack_trace_save(stacks, BACKTRACE_DEPTH, 2);
+	stack_trace_print(stacks, len, 24);
+}
+
+static void sample_entry_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+{
+	pr_info("Enter <%pS> ip = 0x%p\n", (void *)ip, (void *)ip);
+	if (stackdump)
+		show_backtrace();
+}
+
+static void sample_exit_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+{
+	unsigned long rip = instruction_pointer(regs);
+
+	pr_info("Return from <%pS> ip = 0x%p to rip = 0x%p (%pS)\n",
+		(void *)ip, (void *)ip, (void *)rip, (void *)rip);
+	if (stackdump)
+		show_backtrace();
+}
+
+static int __init fprobe_init(void)
+{
+	char *p, *symbuf = NULL;
+	const char **syms;
+	int ret, count, i;
+
+	sample_probe.entry_handler = sample_entry_handler;
+	sample_probe.exit_handler = sample_exit_handler;
+
+	if (strchr(symbol, '*')) {
+		/* filter based fprobe */
+		ret = register_fprobe(&sample_probe, symbol,
+				      nosymbol[0] == '\0' ? NULL : nosymbol);
+		goto out;
+	} else if (!strchr(symbol, ',')) {
+		symbuf = symbol;
+		ret = register_fprobe_syms(&sample_probe, (const char **)&symbuf, 1);
+		goto out;
+	}
+
+	/* Comma separated symbols */
+	symbuf = kstrdup(symbol, GFP_KERNEL);
+	if (!symbuf)
+		return -ENOMEM;
+	p = symbuf;
+	count = 1;
+	while ((p = strchr(++p, ',')) != NULL)
+		count++;
+
+	pr_info("%d symbols found\n", count);
+
+	syms = kcalloc(count, sizeof(char *), GFP_KERNEL);
+	if (!syms) {
+		kfree(symbuf);
+		return -ENOMEM;
+	}
+
+	p = symbuf;
+	for (i = 0; i < count; i++)
+		syms[i] = strsep(&p, ",");
+
+	ret = register_fprobe_syms(&sample_probe, syms, count);
+	kfree(syms);
+	kfree(symbuf);
+out:
+	if (ret < 0)
+		pr_err("register_fprobe failed, returned %d\n", ret);
+	else
+		pr_info("Planted fprobe at %s\n", symbol);
+
+	return ret;
+}
+
+static void __exit fprobe_exit(void)
+{
+	unregister_fprobe(&sample_probe);
+
+	pr_info("fprobe at %s unregistered\n", symbol);
+}
+
+module_init(fprobe_init)
+module_exit(fprobe_exit)
+MODULE_LICENSE("GPL");

