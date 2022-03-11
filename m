Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320944D659A
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 17:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiCKQBi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 11:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350060AbiCKQB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 11:01:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C41CC7E8;
        Fri, 11 Mar 2022 08:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04DDD61A3F;
        Fri, 11 Mar 2022 16:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D26C340E9;
        Fri, 11 Mar 2022 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647014421;
        bh=4np2dBOfdrhAvWSD0KrpvtH6KlUzllFx8wV9gxXS/ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFcoNf2njeubjzm300YQUmmgVvjDepSczzXF+HxHB6Nyc28OJ/2rQ1sz3OQTk/x8W
         fNVSGhtZ6QlR30JggiaoY5GKyOjajzQdjetp+tzTK6sMwZm3WPxL/P5QvF0wLP95k+
         DlwRHLpouDtLnv9RjhNFM0jjIoE8PGXL/uxKnx44vxJvwgiORlUUHX1PNTbdG6golK
         vF6A1f+Z80fRkfelrY2KoOiQ8rawjkPR34jgbRh/0/tMsl7/Ibo71yqYlTtBGwaWMU
         j5+fEhXWk/lHoKZA5/iWR+kh+F+3IALsGX+5xCyBoIDZv5wwJQ33ligX2K/gd4J/O8
         1EZOfIrTW0jDA==
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
Subject: [PATCH v11 08/12] fprobe: Add exit_handler support
Date:   Sat, 12 Mar 2022 01:00:14 +0900
Message-Id: <164701441458.268462.2353527776345498732.stgit@devnote2>
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

Add exit_handler to fprobe. fprobe + rethook allows us to hook the kernel
function return. The rethook will be enabled only if the
fprobe::exit_handler is set.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v10:
  - Call rethook_hook() with mcount context flag.
 Changes in v7:
  - Fix unregister_fprobe() to ensure the rethook handlers are
    finished when it returns.
  - Update Kconfig help.
 Changes in v6:
  - Update according to the fprobe update.
 Changes in v5:
  - Add dependency for HAVE_RETHOOK.
 Changes in v4:
  - Check fprobe is disabled in the exit handler.
 Changes in v3:
  - Make sure to clear rethook->data before free.
  - Handler checks the data is not NULL.
  - Free rethook only if the rethook is using.
---
 include/linux/fprobe.h |    6 ++
 kernel/trace/Kconfig   |    9 ++--
 kernel/trace/fprobe.c  |  116 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 122 insertions(+), 9 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 2ba099aff041..8eefec2b485e 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -5,13 +5,16 @@
 
 #include <linux/compiler.h>
 #include <linux/ftrace.h>
+#include <linux/rethook.h>
 
 /**
  * struct fprobe - ftrace based probe.
  * @ops: The ftrace_ops.
  * @nmissed: The counter for missing events.
  * @flags: The status flag.
+ * @rethook: The rethook data structure. (internal data)
  * @entry_handler: The callback function for function entry.
+ * @exit_handler: The callback function for function exit.
  */
 struct fprobe {
 #ifdef CONFIG_FUNCTION_TRACER
@@ -25,7 +28,10 @@ struct fprobe {
 #endif
 	unsigned long		nmissed;
 	unsigned int		flags;
+	struct rethook		*rethook;
+
 	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
+	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
 };
 
 #define FPROBE_FL_DISABLED	1
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e75504e42ab8..99dd4ca63d68 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -251,11 +251,14 @@ config FPROBE
 	bool "Kernel Function Probe (fprobe)"
 	depends on FUNCTION_TRACER
 	depends on DYNAMIC_FTRACE_WITH_REGS
+	depends on HAVE_RETHOOK
+	select RETHOOK
 	default n
 	help
-	  This option enables kernel function probe (fprobe) based on ftrace,
-	  which is similar to kprobes, but probes only for kernel function
-	  entries and it can probe multiple functions by one fprobe.
+	  This option enables kernel function probe (fprobe) based on ftrace.
+	  The fprobe is similar to kprobes, but probes only for kernel function
+	  entries and exits. This also can probe multiple functions by one
+	  fprobe.
 
 	  If unsure, say N.
 
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 7e8ceee339a0..38073632bfe4 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -8,12 +8,22 @@
 #include <linux/fprobe.h>
 #include <linux/kallsyms.h>
 #include <linux/kprobes.h>
+#include <linux/rethook.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
+#include "trace.h"
+
+struct fprobe_rethook_node {
+	struct rethook_node node;
+	unsigned long entry_ip;
+};
+
 static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
+	struct fprobe_rethook_node *fpr;
+	struct rethook_node *rh;
 	struct fprobe *fp;
 	int bit;
 
@@ -30,10 +40,37 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	if (fp->entry_handler)
 		fp->entry_handler(fp, ip, ftrace_get_regs(fregs));
 
+	if (fp->exit_handler) {
+		rh = rethook_try_get(fp->rethook);
+		if (!rh) {
+			fp->nmissed++;
+			goto out;
+		}
+		fpr = container_of(rh, struct fprobe_rethook_node, node);
+		fpr->entry_ip = ip;
+		rethook_hook(rh, ftrace_get_regs(fregs), true);
+	}
+
+out:
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(fprobe_handler);
 
+static void fprobe_exit_handler(struct rethook_node *rh, void *data,
+				struct pt_regs *regs)
+{
+	struct fprobe *fp = (struct fprobe *)data;
+	struct fprobe_rethook_node *fpr;
+
+	if (!fp || fprobe_disabled(fp))
+		return;
+
+	fpr = container_of(rh, struct fprobe_rethook_node, node);
+
+	fp->exit_handler(fp, fpr->entry_ip, regs);
+}
+NOKPROBE_SYMBOL(fprobe_exit_handler);
+
 /* Convert ftrace location address from symbols */
 static unsigned long *get_ftrace_locations(const char **syms, int num)
 {
@@ -77,6 +114,48 @@ static void fprobe_init(struct fprobe *fp)
 	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
 }
 
+static int fprobe_init_rethook(struct fprobe *fp, int num)
+{
+	int i, size;
+
+	if (num < 0)
+		return -EINVAL;
+
+	if (!fp->exit_handler) {
+		fp->rethook = NULL;
+		return 0;
+	}
+
+	/* Initialize rethook if needed */
+	size = num * num_possible_cpus() * 2;
+	if (size < 0)
+		return -E2BIG;
+
+	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
+	for (i = 0; i < size; i++) {
+		struct rethook_node *node;
+
+		node = kzalloc(sizeof(struct fprobe_rethook_node), GFP_KERNEL);
+		if (!node) {
+			rethook_free(fp->rethook);
+			fp->rethook = NULL;
+			return -ENOMEM;
+		}
+		rethook_add_node(fp->rethook, node);
+	}
+	return 0;
+}
+
+static void fprobe_fail_cleanup(struct fprobe *fp)
+{
+	if (fp->rethook) {
+		/* Don't need to cleanup rethook->handler because this is not used. */
+		rethook_free(fp->rethook);
+		fp->rethook = NULL;
+	}
+	ftrace_free_filter(&fp->ops);
+}
+
 /**
  * register_fprobe() - Register fprobe to ftrace by pattern.
  * @fp: A fprobe data structure to be registered.
@@ -90,6 +169,7 @@ static void fprobe_init(struct fprobe *fp)
  */
 int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
 {
+	struct ftrace_hash *hash;
 	unsigned char *str;
 	int ret, len;
 
@@ -114,10 +194,21 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 			goto out;
 	}
 
-	ret = register_ftrace_function(&fp->ops);
+	/* TODO:
+	 * correctly calculate the total number of filtered symbols
+	 * from both filter and notfilter.
+	 */
+	hash = fp->ops.local_hash.filter_hash;
+	if (WARN_ON_ONCE(!hash))
+		goto out;
+
+	ret = fprobe_init_rethook(fp, (int)hash->count);
+	if (!ret)
+		ret = register_ftrace_function(&fp->ops);
+
 out:
 	if (ret)
-		ftrace_free_filter(&fp->ops);
+		fprobe_fail_cleanup(fp);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_fprobe);
@@ -145,12 +236,15 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	fprobe_init(fp);
 
 	ret = ftrace_set_filter_ips(&fp->ops, addrs, num, 0, 0);
+	if (ret)
+		return ret;
+
+	ret = fprobe_init_rethook(fp, num);
 	if (!ret)
 		ret = register_ftrace_function(&fp->ops);
 
 	if (ret)
-		ftrace_free_filter(&fp->ops);
-
+		fprobe_fail_cleanup(fp);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_fprobe_ips);
@@ -201,10 +295,20 @@ int unregister_fprobe(struct fprobe *fp)
 	if (!fp || fp->ops.func != fprobe_handler)
 		return -EINVAL;
 
+	/*
+	 * rethook_free() starts disabling the rethook, but the rethook handlers
+	 * may be running on other processors at this point. To make sure that all
+	 * current running handlers are finished, call unregister_ftrace_function()
+	 * after this.
+	 */
+	if (fp->rethook)
+		rethook_free(fp->rethook);
+
 	ret = unregister_ftrace_function(&fp->ops);
+	if (ret < 0)
+		return ret;
 
-	if (!ret)
-		ftrace_free_filter(&fp->ops);
+	ftrace_free_filter(&fp->ops);
 
 	return ret;
 }

