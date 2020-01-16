Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEA13DDE9
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 15:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAPOqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 09:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAPOqN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:46:13 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DD12072B;
        Thu, 16 Jan 2020 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185972;
        bh=WKp9TaCHvXe+OIL/Jsjsxj34PxTjaSn/9cbxee71PeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxRG/xiqmSkx8p5oddGIFI69vxRorwuvf2EYOufZQWwsNqhS7GOQFnOxoS06NEn2I
         WvcVE9WjPh6zFFGsOGbr6PdFJBRA/yHon9P3yWGDjp/qCshy+IZ2AatSxK2nFMOZ4f
         wiG5bYP2I296arGgxPbA1Q4Yni8AJoCvlwiJtbGQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 11/13] kprobes: Add asynchronous unregistration APIs
Date:   Thu, 16 Jan 2020 23:46:07 +0900
Message-Id: <157918596704.29301.4085897993817952679.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157918584866.29301.6941815715391411338.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add asynchronous unregistration APIs for kprobes and kretprobes.
These APIs can accelerate the unregistration process of multiple
probes because user do not need to wait for RCU sync.

However, caller must take care of following notes.

- If you wants to synchronize unregistration (for example, making
  sure all handlers are running out), you have to use
  synchronize_rcu() once at last.

- If you need to free objects which related to the kprobes, you
  can pass a callback, but that callback must call
  kprobe_free_callback() or kretprobe_free_callback() at first.

Since it is easy to shoot your foot, at this moment I don't
export these APIs to modules.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    9 ++++++++
 kernel/kprobes.c        |   56 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1cd53b7b8409..f892c3a11dac 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -98,6 +98,9 @@ struct kprobe {
 	 * Protected by kprobe_mutex after this kprobe is registered.
 	 */
 	u32 flags;
+
+	/* For asynchronous unregistration callback */
+	struct rcu_head rcu;
 };
 
 /* Kprobe status flags */
@@ -364,6 +367,12 @@ void unregister_kretprobe(struct kretprobe *rp);
 int register_kretprobes(struct kretprobe **rps, int num);
 void unregister_kretprobes(struct kretprobe **rps, int num);
 
+/* Async unregister APIs (Do not wait for rcu sync) */
+void kprobe_free_callback(struct rcu_head *head);
+void kretprobe_free_callback(struct rcu_head *head);
+void unregister_kprobe_async(struct kprobe *kp, rcu_callback_t free_cb);
+void unregister_kretprobe_async(struct kretprobe *kp, rcu_callback_t free_cb);
+
 void kprobe_flush_task(struct task_struct *tk);
 void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5c12eb7fa8e1..ab57c22b64f9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1887,6 +1887,31 @@ void unregister_kprobes(struct kprobe **kps, int num)
 }
 EXPORT_SYMBOL_GPL(unregister_kprobes);
 
+void kprobe_free_callback(struct rcu_head *head)
+{
+	struct kprobe *kp = container_of(head, struct kprobe, rcu);
+
+	__unregister_kprobe_bottom(kp);
+}
+
+/*
+ * If you call this function, you must call kprobe_free_callback() at first
+ * in your free_cb(), or set free_cb = NULL.
+ */
+void unregister_kprobe_async(struct kprobe *kp, rcu_callback_t free_cb)
+{
+	mutex_lock(&kprobe_mutex);
+	if (__unregister_kprobe_top(kp) < 0)
+		kp->addr = NULL;
+	mutex_unlock(&kprobe_mutex);
+
+	if (!kp->addr)
+		return;
+	if (!free_cb)
+		free_cb = kprobe_free_callback;
+	call_rcu(&kp->rcu, free_cb);
+}
+
 int __weak kprobe_exceptions_notify(struct notifier_block *self,
 					unsigned long val, void *data)
 {
@@ -2080,6 +2105,29 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 }
 EXPORT_SYMBOL_GPL(unregister_kretprobes);
 
+void kretprobe_free_callback(struct rcu_head *head)
+{
+	struct kprobe *kp = container_of(head, struct kprobe, rcu);
+	struct kretprobe *rp = container_of(kp, struct kretprobe, kp);
+
+	__unregister_kprobe_bottom(kp);
+	cleanup_rp_inst(rp);
+}
+
+void unregister_kretprobe_async(struct kretprobe *rp, rcu_callback_t free_cb)
+{
+	mutex_lock(&kprobe_mutex);
+	if (__unregister_kprobe_top(&rp->kp) < 0)
+		rp->kp.addr = NULL;
+	mutex_unlock(&kprobe_mutex);
+
+	if (!rp->kp.addr)
+		return;
+	if (!free_cb)
+		free_cb = kretprobe_free_callback;
+	call_rcu(&rp->kp.rcu, free_cb);
+}
+
 #else /* CONFIG_KRETPROBES */
 int register_kretprobe(struct kretprobe *rp)
 {
@@ -2109,6 +2157,14 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
 
+void kretprobe_free_callback(struct rcu_head *head)
+{
+}
+
+void unregister_kretprobe_async(struct kretprobe *rp, rcu_callback_t free_cb)
+{
+}
+
 #endif /* CONFIG_KRETPROBES */
 
 /* Set the kprobe gone and remove its instruction buffer. */

