Return-Path: <bpf+bounces-27405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C79A8ACC9D
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B25285E41
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F251474A7;
	Mon, 22 Apr 2024 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7ReAvsz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F213E40D
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787999; cv=none; b=SngtZdPjE813ncw4dqtbI6YqEs11tpcThlZtpM7h9PtJuiPo4jT/5JBhU72sS/VQA+xFHNDDgGxsxVRuPCER9T2OOudDgNiTBZk0w/a3PiIroC4RzXblUMm7cf888U6zfiLiyj/wnz8W56AuG33sNrZgsQUROV4v+qmuX3EB+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787999; c=relaxed/simple;
	bh=26X+E92XZzxNQo7qRN0ZfqMhXGef8gCAOXzlwjOoTsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2+DAubwP7pnJNX9rYr7/uiuwSV2ru8fHFfHrr5B3dCoJ0NTVz+XwHb9XNZucS7fiiTPOHwwco0SP+bIgnBFGlEf2llAXaMyV9/VeAZCEV4SQWy53FwYmHLI3ZIh42Y+6BXBk8xHZc7BslLVrGBr/VnMJZj3M/dIInUHpH/oH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7ReAvsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F248C113CC;
	Mon, 22 Apr 2024 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713787999;
	bh=26X+E92XZzxNQo7qRN0ZfqMhXGef8gCAOXzlwjOoTsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7ReAvszhgNxY1kmg+Ky4og3dv10yLlf0dA+Z7k52nZwI1mJxSxuM8mkWouIOx2Dv
	 wm3vu5s7jw08N54UtOl2NG/4WyHKqjaRyHY/EMytHiPMCmZbhj7oyklIcDKRWCYA60
	 2tSLiG9MUp7pqHRfJpFHhPHiTKHMmKU+Zvn3kJW+iKka+tZq5V0HpeYZjPH8MduBB8
	 n3d5qdczBrwxaqrwc09mXNYTZM4PepMAkx9kEHd12on2RJStHQpGy2O0fZM27hqTiI
	 u7ZHvO4bLDcf4SsgGCgHxhfU/htsv5EeBkbjSAIpokphskn94H7u9grVJ6nJizVaoo
	 g2FQ8kRgp651A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH bpf-next 3/7] bpf: Add support for kprobe multi session cookie
Date: Mon, 22 Apr 2024 14:12:37 +0200
Message-ID: <20240422121241.1307168-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422121241.1307168-1-jolsa@kernel.org>
References: <20240422121241.1307168-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for cookie within the session of kprobe multi
entry and return program.

The session cookie is u64 value and can be retrieved be new
kfunc bpf_session_cookie, which returns pointer to the cookie
value. The bpf program can use the pointer to store (on entry)
and load (on return) the value.

The cookie value is implemented via fprobe feature that allows
to share values between entry and return ftrace fprobe callbacks.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c    |  7 +++++++
 kernel/trace/bpf_trace.c | 19 ++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68cfd6fc6ad4..baaca451aebc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10987,6 +10987,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_session_cookie,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11013,6 +11014,7 @@ BTF_ID(func, bpf_throw)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+BTF_ID(func, bpf_session_cookie)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11043,6 +11045,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_session_cookie)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -12409,6 +12412,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				 * because packet slices are not refcounted (see
 				 * dynptr_type_refcounted)
 				 */
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
+				mark_reg_known_zero(env, regs, BPF_REG_0);
+				regs[BPF_REG_0].type = PTR_TO_MEM;
+				regs[BPF_REG_0].mem_size = sizeof(u64);
 			} else {
 				verbose(env, "kernel function %s unhandled dynamic return type\n",
 					meta.func_name);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d82402316d84..a6863c1905ca 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2599,6 +2599,7 @@ fs_initcall(bpf_event_init);
 struct bpf_session_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	bool is_return;
+	void *data;
 };
 
 #ifdef CONFIG_FPROBE
@@ -2819,11 +2820,12 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 			   unsigned long entry_ip, struct pt_regs *regs,
-			   bool is_return)
+			   bool is_return, void *data)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
 		.session_ctx = {
 			.is_return = is_return,
+			.data = data,
 		},
 		.link = link,
 		.entry_ip = entry_ip,
@@ -2859,7 +2861,7 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 	int err;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false);
+	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false, data);
 	return is_kprobe_multi_session(link->link.prog) ? err : 0;
 }
 
@@ -2871,7 +2873,7 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 	struct bpf_kprobe_multi_link *link;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true, data);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
@@ -3089,6 +3091,8 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		link->fp.entry_handler = kprobe_multi_link_handler;
 	if ((flags & BPF_F_KPROBE_MULTI_RETURN) || is_kprobe_multi_session(prog))
 		link->fp.exit_handler = kprobe_multi_link_exit_handler;
+	if (is_kprobe_multi_session(prog))
+		link->fp.entry_data_size = sizeof(u64);
 
 	link->addrs = addrs;
 	link->cookies = cookies;
@@ -3526,10 +3530,19 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	return session_ctx->is_return;
 }
 
+__bpf_kfunc __u64 *bpf_session_cookie(void)
+{
+	struct bpf_session_run_ctx *session_ctx;
+
+	session_ctx = container_of(current->bpf_ctx, struct bpf_session_run_ctx, run_ctx);
+	return session_ctx->data;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_session_is_return)
+BTF_ID_FLAGS(func, bpf_session_cookie)
 BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
 
 static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0


