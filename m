Return-Path: <bpf+bounces-28251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB98B7447
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7B51F22627
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2421E12D755;
	Tue, 30 Apr 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQf42P7E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D812C805
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476547; cv=none; b=RmDSESHKzJt7VZGJsq/v5i+a2WVQDcFcbVuVrAAUUVyibQg/Yg2AguSu+WCbfS4dNUtJX2EqEtOTJHYs9540M2HIzJRBwcwdhDRPBPbXBmmmEutgaCpS0pS0B/gg80u92GG78AH6ozUFZSSLUSEjh3XcwJ/PUue4kD3DcH+0rc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476547; c=relaxed/simple;
	bh=2C1UbthTuRoUihs7uBCdfFEUvX1vLUDpSIaop8g5KBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeztVhbjEgfmEiTXEmnLovT8JTajn7+E7/NQIH+Nl+2J0ig4tl4m+6CoOEpT+4SUmk5iDUo4LZwdYjseCc9CF0t43mgCiaEL2KeeBSqE61GiDCv3kQRgbZZUVewaLF5WNE76soB8cnBeTueri3zlNGNormyaujGc7Yn5WH/7pOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQf42P7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756D6C4AF1A;
	Tue, 30 Apr 2024 11:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476547;
	bh=2C1UbthTuRoUihs7uBCdfFEUvX1vLUDpSIaop8g5KBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQf42P7ELub/80I7eChtGpAnFHVFq8ZRd36v9jgqWfD8Z2xLHwsSTdCAuiORrfgvh
	 WIf5y7Rm1fTwGKHap0VR+kTfx2SDkBziY0UGmlgvJBVvkFReZdMDCA55EUuXAhJdqO
	 Sa1c8BmI0H+uO3z3Em4WSBdk22/wra0y3fYJiUfTZwSyXrn3ZNEByjWsdyAkjTzlV5
	 1BftqgnjFsdBjAYwpQ3lXLhP6VaExI443BmNtFY5wyNqo/2tS6qsV+ZopXv+UQeEX8
	 cJcL9ji3j591//4jqPhfTEGbhquUal+X7OSZqLpG5PsAVFslzUBRaO6hao28kqb9Tm
	 kU3EUOYn9UNPA==
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
Subject: [PATCHv2 bpf-next 3/7] bpf: Add support for kprobe session cookie
Date: Tue, 30 Apr 2024 13:28:26 +0200
Message-ID: <20240430112830.1184228-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430112830.1184228-1-jolsa@kernel.org>
References: <20240430112830.1184228-1-jolsa@kernel.org>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c    |  7 +++++++
 kernel/trace/bpf_trace.c | 19 ++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d42db05315e..7360f04f9ec7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11063,6 +11063,7 @@ enum special_kfunc_type {
 	KF_bpf_preempt_disable,
 	KF_bpf_preempt_enable,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_session_cookie,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11123,6 +11124,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_session_cookie)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -12294,6 +12296,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
+		meta.r0_size = sizeof(u64);
+		meta.r0_rdonly = false;
+	}
+
 	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_timer_callback_state);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3e88212bbf84..f5154c051d2c 100644
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
 	return is_kprobe_session(link->link.prog) ? err : 0;
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
 	if ((flags & BPF_F_KPROBE_MULTI_RETURN) || is_kprobe_session(prog))
 		link->fp.exit_handler = kprobe_multi_link_exit_handler;
+	if (is_kprobe_session(prog))
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


