Return-Path: <bpf+bounces-33513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870291E589
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C311228202A
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE3516DC12;
	Mon,  1 Jul 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivZ5Ux0k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B513C908;
	Mon,  1 Jul 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852116; cv=none; b=Md/XE0AwWOdfG9S1PixI7rO/kp0T+cf4AnRp7USqxxFH7PkZ9z71L0/CmibrLA29dfzd5MQkDds7CCQVbek326r777vkKSFGMU3xAD5Fc15sTTF1Sj/msGvNgRksM70jWxiJ6KQEZn5ObQgKhzYmKxmZBr8CJwdVKv8gSAKh/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852116; c=relaxed/simple;
	bh=G9fVFVrKFD3pg+QHBhgYcKehwzlHOCotsn5gtTrtcLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDHTj4Pnp1zL7m+WJl6SPqRyEs8XogxZUb62Y/T8Wpznj1DDKxMmVXTO3hvTk2DNw3Rn2PIfPNnHZeTRHVXQmB/Q7TeQoAVyaEcob3Ri4oB5Ry1T5ht2k67MAAK5qc22yEMVE/im+4NUxYxDYUILKoleSONjuOgQqghl8A+Y+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivZ5Ux0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D945CC116B1;
	Mon,  1 Jul 2024 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852115;
	bh=G9fVFVrKFD3pg+QHBhgYcKehwzlHOCotsn5gtTrtcLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivZ5Ux0kwKmBtwiqN40b/laao07kTF26cch0DJuzj9xNBjpWhXGOKNQ5mQtnwEe/t
	 yYleRehdOw1QMV2xKOwpoMik6NPaFZYykTKApWNKMdrfUIbTf5G4rpsV9jR+lmjRQv
	 F4ACGYQVpb8Lcws+wISSPDXNLFShPLloPgMCuzKZbVV/V3In8TqFimpXp5nlPrSWGo
	 lxHDgRcT7SH53mFW71wAcATvixVHRzKkU215DnHrOG2DsMMVFiB3Tl7CxGHmDGi8n+
	 ryRTkb0t+5rnMX15xOEu28TVn1N/fz6/+WQQUC8ZgZltZQkejUrqtKjIFKq/LJHnb7
	 s12kVCYhG1yPg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Date: Mon,  1 Jul 2024 18:41:07 +0200
Message-ID: <20240701164115.723677-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701164115.723677-1-jolsa@kernel.org>
References: <20240701164115.723677-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for uprobe consumer to be defined as session and have
new behaviour for consumer's 'handler' and 'ret_handler' callbacks.

The session means that 'handler' and 'ret_handler' callbacks are
connected in a way that allows to:

  - control execution of 'ret_handler' from 'handler' callback
  - share data between 'handler' and 'ret_handler' callbacks

The session is enabled by setting new 'session' bool field to true
in uprobe_consumer object.

We keep count of session consumers for uprobe and allocate session_consumer
object for each in return_instance object. This allows us to store
return values of 'handler' callbacks and data pointers of shared
data between both handlers.

The session concept fits to our common use case where we do filtering
on entry uprobe and based on the result we decide to run the return
uprobe (or not).

It's also convenient to share the data between session callbacks.

The control of 'ret_handler' callback execution is done via return
value of the 'handler' callback. If it's 0 we install and execute
return uprobe, if it's 1 we do not.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h     |  16 ++++-
 kernel/events/uprobes.c     | 129 +++++++++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c    |   6 +-
 kernel/trace/trace_uprobe.c |  12 ++--
 4 files changed, 144 insertions(+), 19 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..903a860a8d01 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -34,15 +34,18 @@ enum uprobe_filter_ctx {
 };
 
 struct uprobe_consumer {
-	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
+	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
-				struct pt_regs *regs);
+				struct pt_regs *regs, __u64 *data);
 	bool (*filter)(struct uprobe_consumer *self,
 				enum uprobe_filter_ctx ctx,
 				struct mm_struct *mm);
 
 	struct uprobe_consumer *next;
+
+	bool			session;	/* marks uprobe session consumer */
+	unsigned int		session_id;	/* set when uprobe_consumer is registered */
 };
 
 #ifdef CONFIG_UPROBES
@@ -80,6 +83,12 @@ struct uprobe_task {
 	unsigned int			depth;
 };
 
+struct session_consumer {
+	__u64		cookie;
+	unsigned int	id;
+	int		rc;
+};
+
 struct return_instance {
 	struct uprobe		*uprobe;
 	unsigned long		func;
@@ -88,6 +97,9 @@ struct return_instance {
 	bool			chained;	/* true, if instance is nested */
 
 	struct return_instance	*next;		/* keep as stack */
+
+	int			sessions_cnt;
+	struct session_consumer	sessions[];
 };
 
 enum rp_check {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..4da410460f2a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -63,6 +63,8 @@ struct uprobe {
 	loff_t			ref_ctr_offset;
 	unsigned long		flags;
 
+	unsigned int		sessions_cnt;
+
 	/*
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
@@ -750,11 +752,30 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	return uprobe;
 }
 
+static void
+uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consumer *uc)
+{
+	static unsigned int session_id;
+
+	if (uc->session) {
+		uprobe->sessions_cnt++;
+		uc->session_id = ++session_id ?: ++session_id;
+	}
+}
+
+static void
+uprobe_consumer_unaccount(struct uprobe *uprobe, struct uprobe_consumer *uc)
+{
+	if (uc->session)
+		uprobe->sessions_cnt--;
+}
+
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
 	uc->next = uprobe->consumers;
 	uprobe->consumers = uc;
+	uprobe_consumer_account(uprobe, uc);
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -773,6 +794,7 @@ static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
 		if (*con == uc) {
 			*con = uc->next;
 			ret = true;
+			uprobe_consumer_unaccount(uprobe, uc);
 			break;
 		}
 	}
@@ -1744,6 +1766,23 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
+static size_t ri_size(int sessions_cnt)
+{
+	struct return_instance *ri __maybe_unused;
+
+	return sizeof(*ri) + sessions_cnt * sizeof(ri->sessions[0]);
+}
+
+static struct return_instance *alloc_return_instance(int sessions_cnt)
+{
+	struct return_instance *ri;
+
+	ri = kzalloc(ri_size(sessions_cnt), GFP_KERNEL);
+	if (ri)
+		ri->sessions_cnt = sessions_cnt;
+	return ri;
+}
+
 static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 {
 	struct uprobe_task *n_utask;
@@ -1756,11 +1795,11 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
-		n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
+		n = alloc_return_instance(o->sessions_cnt);
 		if (!n)
 			return -ENOMEM;
 
-		*n = *o;
+		memcpy(n, o, ri_size(o->sessions_cnt));
 		get_uprobe(n->uprobe);
 		n->next = NULL;
 
@@ -1853,9 +1892,9 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 	utask->return_instances = ri;
 }
 
-static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
+static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
+			      struct return_instance *ri)
 {
-	struct return_instance *ri;
 	struct uprobe_task *utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
 	bool chained;
@@ -1874,9 +1913,11 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		return;
 	}
 
-	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
-	if (!ri)
-		return;
+	if (!ri) {
+		ri = alloc_return_instance(0);
+		if (!ri)
+			return;
+	}
 
 	trampoline_vaddr = get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
@@ -2065,35 +2106,85 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
 	return uprobe;
 }
 
+static struct session_consumer *
+session_consumer_next(struct return_instance *ri, struct session_consumer *sc,
+		      int session_id)
+{
+	struct session_consumer *next;
+
+	next = sc ? sc + 1 : &ri->sessions[0];
+	next->id = session_id;
+	return next;
+}
+
+static struct session_consumer *
+session_consumer_find(struct return_instance *ri, int *iter, int session_id)
+{
+	struct session_consumer *sc;
+	int idx = *iter;
+
+	for (sc = &ri->sessions[idx]; idx < ri->sessions_cnt; idx++, sc++) {
+		if (sc->id == session_id) {
+			*iter = idx + 1;
+			return sc;
+		}
+	}
+	return NULL;
+}
+
 static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
+	struct session_consumer *sc = NULL;
+	struct return_instance *ri = NULL;
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
 	down_read(&uprobe->register_rwsem);
+	if (uprobe->sessions_cnt) {
+		ri = alloc_return_instance(uprobe->sessions_cnt);
+		if (!ri)
+			goto out;
+	}
+
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
+		__u64 *cookie = NULL;
 		int rc = 0;
 
+		if (uc->session) {
+			sc = session_consumer_next(ri, sc, uc->session_id);
+			cookie = &sc->cookie;
+		}
+
 		if (uc->handler) {
-			rc = uc->handler(uc, regs);
+			rc = uc->handler(uc, regs, cookie);
 			WARN(rc & ~UPROBE_HANDLER_MASK,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
 
-		if (uc->ret_handler)
+		if (uc->session) {
+			sc->rc = rc;
+			need_prep |= !rc;
+		} else if (uc->ret_handler) {
 			need_prep = true;
+		}
 
 		remove &= rc;
 	}
 
+	/* no removal if there's at least one session consumer */
+	remove &= !uprobe->sessions_cnt;
+
 	if (need_prep && !remove)
-		prepare_uretprobe(uprobe, regs); /* put bp at return */
+		prepare_uretprobe(uprobe, regs, ri); /* put bp at return */
+	else
+		kfree(ri);
 
 	if (remove && uprobe->consumers) {
 		WARN_ON(!uprobe_is_active(uprobe));
 		unapply_uprobe(uprobe, current->mm);
 	}
+ out:
 	up_read(&uprobe->register_rwsem);
 }
 
@@ -2101,12 +2192,28 @@ static void
 handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
+	struct session_consumer *sc;
 	struct uprobe_consumer *uc;
+	int session_iter = 0;
 
 	down_read(&uprobe->register_rwsem);
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
+		__u64 *cookie = NULL;
+
+		if (uc->session) {
+			/*
+			 * Consumers could be added and removed, but they will not
+			 * change position, so we can iterate sessions just once
+			 * and keep the last found session as base for next search.
+			 */
+			sc = session_consumer_find(ri, &session_iter, uc->session_id);
+			if (!sc || sc->rc)
+				continue;
+			cookie = &sc->cookie;
+		}
+
 		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs);
+			uc->ret_handler(uc, ri->func, regs, cookie);
 	}
 	up_read(&uprobe->register_rwsem);
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..02d052639dfe 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3332,7 +3332,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, enum uprobe_filter_ctx ctx
 }
 
 static int
-uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
+uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
+			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
@@ -3341,7 +3342,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int
-uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
+uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs,
+			      __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c98e3b3386ba..7068c279a244 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -88,9 +88,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data);
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs);
+				unsigned long func, struct pt_regs *regs,
+				__u64 *data);
 
 #ifdef CONFIG_STACK_GROWSUP
 static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
@@ -1504,7 +1506,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 	}
 }
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
@@ -1534,7 +1537,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs)
+				unsigned long func, struct pt_regs *regs,
+				__u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
-- 
2.45.2


