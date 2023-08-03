Return-Path: <bpf+bounces-6832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9576E4FC
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652A928202E
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6315AD0;
	Thu,  3 Aug 2023 09:52:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887447E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 09:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426EDC433C7;
	Thu,  3 Aug 2023 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691056355;
	bh=ookkNN3B8lsJp1EqXWKSJsS/j/Pq2VF7dmcs4gpFRwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0N4j9trE4gAxCDOlZ7RSnM9MDn8z10HduUFzcbXeQXIZ48pIysOFHumMqtgXf7WX
	 Ct0aSu1IuKW5Ymdj71e7enQKfNhjLOaV87p5r2BZrorUOK+G86MaZ3LQR85WrFuvKM
	 wonHkk9SX/7qKAoH/bZBewYCEYj5WQcewJl48/Agt7JrEvr9CXj6HQdbaQNz8V7gDw
	 gYDYgtYTPgOWAKrUZtfCg+OgczIyEUJJU42kyI+E5HqXxaa8oCpS7RfZpSaD95Iz+k
	 1yJpvNCiP8BAlQaftr5+rTTNg+bV+yLasczcBd4feFSFdykf+W5Y3ywmLJawGljCLt
	 7H7eoe4XILbNw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv2 bpf-next 1/3] bpf: Add support for bpf_get_func_ip helper for uprobe program
Date: Thu,  3 Aug 2023 11:52:17 +0200
Message-ID: <20230803095219.1669065-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803095219.1669065-1-jolsa@kernel.org>
References: <20230803095219.1669065-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for bpf_get_func_ip helper for uprobe program to return
probed address for both uprobe and return uprobe.

We discussed this in [1] and agreed that uprobe can have special use
of bpf_get_func_ip helper that differs from kprobe.

The kprobe bpf_get_func_ip returns:
  - address of the function if probe is attach on function entry
    for both kprobe and return kprobe
  - 0 if the probe is not attach on function entry

The uprobe bpf_get_func_ip returns:
  - address of the probe for both uprobe and return uprobe

The reason for this semantic change is that kernel can't really tell
if the probe user space address is function entry.

The uprobe program is actually kprobe type program attached as uprobe.
One of the consequences of this design is that uprobes do not have its
own set of helpers, but share them with kprobes.

As we need different functionality for bpf_get_func_ip helper for uprobe,
I'm adding the bool value to the bpf_trace_run_ctx, so the helper can
detect that it's executed in uprobe context and call specific code.

The is_uprobe bool is set as true in bpf_prog_run_array_sleepable, which
is currently used only for executing bpf programs in uprobe.

Renaming bpf_prog_run_array_sleepable to bpf_prog_run_array_uprobe
to address that it's only used for uprobes and that it sets the
run_ctx.is_uprobe as suggested by Yafang Shao.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
[1] https://lore.kernel.org/bpf/CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  9 +++++++--
 include/uapi/linux/bpf.h       |  7 ++++++-
 kernel/trace/bpf_trace.c       | 21 ++++++++++++++++++++-
 kernel/trace/trace_probe.h     |  5 +++++
 kernel/trace/trace_uprobe.c    |  7 +------
 tools/include/uapi/linux/bpf.h |  7 ++++++-
 6 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index abe75063630b..db3fe5a61b05 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1819,6 +1819,7 @@ struct bpf_cg_run_ctx {
 struct bpf_trace_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	u64 bpf_cookie;
+	bool is_uprobe;
 };
 
 struct bpf_tramp_run_ctx {
@@ -1867,6 +1868,8 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
 	if (unlikely(!array))
 		return ret;
 
+	run_ctx.is_uprobe = false;
+
 	migrate_disable();
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
@@ -1891,8 +1894,8 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
  * rcu-protected dynamically sized maps.
  */
 static __always_inline u32
-bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
-			     const void *ctx, bpf_prog_run_fn run_prog)
+bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
+			  const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
@@ -1906,6 +1909,8 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
 	rcu_read_lock_trace();
 	migrate_disable();
 
+	run_ctx.is_uprobe = true;
+
 	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
 	if (unlikely(!array))
 		goto out;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 70da85200695..d21deb46f49f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5086,9 +5086,14 @@ union bpf_attr {
  * u64 bpf_get_func_ip(void *ctx)
  * 	Description
  * 		Get address of the traced function (for tracing and kprobe programs).
+ *
+ * 		When called for kprobe program attached as uprobe it returns
+ * 		probe address for both entry and return uprobe.
+ *
  * 	Return
- * 		Address of the traced function.
+ * 		Address of the traced function for kprobe.
  * 		0 for kprobes placed within the function (not at the entry).
+ * 		Address of the probe for uprobe and return uprobe.
  *
  * u64 bpf_get_attach_cookie(void *ctx)
  * 	Description
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 83bde2475ae5..d35f9750065a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1046,9 +1046,28 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
 #define get_entry_ip(fentry_ip) fentry_ip
 #endif
 
+#ifdef CONFIG_UPROBES
+static unsigned long bpf_get_func_ip_uprobe(struct pt_regs *regs)
+{
+	struct uprobe_dispatch_data *udd;
+
+	udd = (struct uprobe_dispatch_data *) current->utask->vaddr;
+	return udd->bp_addr;
+}
+#else
+#define bpf_get_func_ip_uprobe(regs) (u64) -EOPNOTSUPP
+#endif
+
 BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {
-	struct kprobe *kp = kprobe_running();
+	struct bpf_trace_run_ctx *run_ctx;
+	struct kprobe *kp;
+
+	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
+	if (run_ctx->is_uprobe)
+		return bpf_get_func_ip_uprobe(regs);
+
+	kp = kprobe_running();
 
 	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
 		return 0;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 01ea148723de..7dde806be91e 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -519,3 +519,8 @@ void __trace_probe_log_err(int offset, int err);
 
 #define trace_probe_log_err(offs, err)	\
 	__trace_probe_log_err(offs, TP_ERR_##err)
+
+struct uprobe_dispatch_data {
+	struct trace_uprobe	*tu;
+	unsigned long		bp_addr;
+};
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 555c223c3232..576b3bcb8ebd 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -88,11 +88,6 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-struct uprobe_dispatch_data {
-	struct trace_uprobe	*tu;
-	unsigned long		bp_addr;
-};
-
 static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
 				unsigned long func, struct pt_regs *regs);
@@ -1352,7 +1347,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	if (bpf_prog_array_valid(call)) {
 		u32 ret;
 
-		ret = bpf_prog_run_array_sleepable(call->prog_array, regs, bpf_prog_run);
+		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
 		if (!ret)
 			return;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70da85200695..d21deb46f49f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5086,9 +5086,14 @@ union bpf_attr {
  * u64 bpf_get_func_ip(void *ctx)
  * 	Description
  * 		Get address of the traced function (for tracing and kprobe programs).
+ *
+ * 		When called for kprobe program attached as uprobe it returns
+ * 		probe address for both entry and return uprobe.
+ *
  * 	Return
- * 		Address of the traced function.
+ * 		Address of the traced function for kprobe.
  * 		0 for kprobes placed within the function (not at the entry).
+ * 		Address of the probe for uprobe and return uprobe.
  *
  * u64 bpf_get_attach_cookie(void *ctx)
  * 	Description
-- 
2.41.0


