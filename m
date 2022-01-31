Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E5C4A3D1F
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 06:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357732AbiAaFDB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 00:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357744AbiAaFCn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 00:02:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C9C061714;
        Sun, 30 Jan 2022 21:02:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C748B82996;
        Mon, 31 Jan 2022 05:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C21C340E8;
        Mon, 31 Jan 2022 05:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643605334;
        bh=uT6ZPcB2j337Im93b4k6DOtcrtN7D6MyuN6ZnTAQx7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BulBOrCF7XoPOTgNOZQRUKgeKGp2fr6bhVXPI0n5t4ZH+m9zxbU7jJGj20HFI7PPv
         FMw4Gid64kipFjMFtnszNfEHAaRkjqxm2uaMMDyAOlE1ZY1bKBWBNW1knHlE95D2xw
         xPLUT/UQEiMkJgLvYx+SEVfT/uGl22Br9Tf6aYWznQr8wvqEvzeU/ETC7ZJl+LmrPj
         5mipK2azznmGF+gEXjWTTewO56+tYZ88oGLhHVdZiwfpZIlal53R2vKja/Oa63x5ly
         rGudVBwPgU/armadZgJt6PKeQ69rxpXJnVcWLdockjrYsqME+TwkYjvqQyu3t3t7us
         c6+r5xrN1Ql+A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <ast@kernel.org>
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
Subject: [PATCH v7 09/10] fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe
Date:   Mon, 31 Jan 2022 14:02:09 +0900
Message-Id: <164360532920.65877.12281577388256600302.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164360522462.65877.1891020292202285106.stgit@devnote2>
References: <164360522462.65877.1891020292202285106.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce FPROBE_FL_KPROBE_SHARED flag for sharing fprobe callback with
kprobes safely from the viewpoint of recursion.

Since the recursion safety of the fprobe (and ftrace) is a bit different
from the kprobes, this may cause an issue if user wants to run the same
code from the fprobe and the kprobes.

The kprobes has per-cpu 'current_kprobe' variable which protects the
kprobe handler from recursion in any case. On the other hand, the fprobe
uses only ftrace_test_recursion_trylock(), which will allow interrupt
context calls another (or same) fprobe during the fprobe user handler is
running.

This is not a matter in cases if the common callback shared among the
kprobes and the fprobe has its own recursion detection, or it can handle
the recursion in the different contexts (normal/interrupt/NMI.)
But if it relies on the 'current_kprobe' recursion lock, it has to check
kprobe_running() and use kprobe_busy_*() APIs.

Fprobe has FPROBE_FL_KPROBE_SHARED flag to do this. If your common callback
code will be shared with kprobes, please set FPROBE_FL_KPROBE_SHARED
*before* registering the fprobe, like;

 fprobe.flags = FPROBE_FL_KPROBE_SHARED;

 register_fprobe(&fprobe, "func*", NULL);

This will protect your common callback from the nested call.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/fprobe.h  |   12 ++++++++++++
 include/linux/kprobes.h |    3 +++
 kernel/trace/fprobe.c   |   19 ++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index acfdcc37acf6..94b9386d7267 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -26,13 +26,25 @@ struct fprobe {
 	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
 };
 
+/* This fprobe is soft-disabled. */
 #define FPROBE_FL_DISABLED	1
 
+/*
+ * This fprobe handler will be shared with kprobes.
+ * This flag must be set before registering.
+ */
+#define FPROBE_FL_KPROBE_SHARED	2
+
 static inline bool fprobe_disabled(struct fprobe *fp)
 {
 	return (fp) ? fp->flags & FPROBE_FL_DISABLED : false;
 }
 
+static inline bool fprobe_shared_with_kprobes(struct fprobe *fp)
+{
+	return (fp) ? fp->flags & FPROBE_FL_KPROBE_SHARED : false;
+}
+
 #ifdef CONFIG_FPROBE
 int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter);
 int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8c8f7a4d93af..efe4fc364f6a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -433,6 +433,9 @@ static inline struct kprobe *kprobe_running(void)
 {
 	return NULL;
 }
+#define kprobe_busy_begin()	do {} while (0)
+#define kprobe_busy_end()	do {} while (0)
+
 static inline int register_kprobe(struct kprobe *p)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index d733c0d9cb09..4881b98f35ab 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -56,6 +56,20 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 }
 NOKPROBE_SYMBOL(fprobe_handler);
 
+static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
+				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe *fp = container_of(ops, struct fprobe, ops);
+
+	if (unlikely(kprobe_running())) {
+		fp->nmissed++;
+		return;
+	}
+	kprobe_busy_begin();
+	fprobe_handler(ip, parent_ip, ops, fregs);
+	kprobe_busy_end();
+}
+
 static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 				struct pt_regs *regs)
 {
@@ -109,7 +123,10 @@ static unsigned long *get_ftrace_locations(const char **syms, int num)
 static void fprobe_init(struct fprobe *fp)
 {
 	fp->nmissed = 0;
-	fp->ops.func = fprobe_handler;
+	if (fprobe_shared_with_kprobes(fp))
+		fp->ops.func = fprobe_kprobe_handler;
+	else
+		fp->ops.func = fprobe_handler;
 	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
 }
 

