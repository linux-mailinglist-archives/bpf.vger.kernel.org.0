Return-Path: <bpf+bounces-28250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D028B7440
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F641F22B7A
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154BD12C805;
	Tue, 30 Apr 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkthtMTG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CCD12CD8A
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476537; cv=none; b=EKapUlf14wTppkpEcsxOvvQtSNlacBh8jVwj3Tl+dEgZW/FIks1NZmsGiarEuAmJKbiy9ppeRl283j3Wk3mB/rUNX6mHssHaoemgPAUZRMr4IVTAQu1+5dSVllb9hdsleZPwdG9ORW0WvNb5nGa7TeS0WPm2jRtc5br/LxDCbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476537; c=relaxed/simple;
	bh=Kp3aix91QWmA0xr/tufMQCHmbd/eViIrSd54RiX1pxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8zZtkzKe3LRNS4ciC2FonpouHCNLHYIKH6EtwEo3M5O98ls2lTV6QGlrdXlstGoS6Fi5Dw4kSetyN7RDb8/zrx0aS9b8mxlrHij0UNc7OfydpfA98V9GFktBAzoHW0fUD6updbYGbgf/RiTrnLGfdA8j/uLy+vSAqaCgQsWYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkthtMTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A60C2BBFC;
	Tue, 30 Apr 2024 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476537;
	bh=Kp3aix91QWmA0xr/tufMQCHmbd/eViIrSd54RiX1pxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkthtMTGdwBh+zHymrT1yZGfppsS+3AasjK1J7BW1bEOWOp8cfB1/IawQV7h8Yh/2
	 VTXCB9T4BaM1te66VRgOgIu8qS2ifAetzmQJTtew/6ylQt9s1bzg3sbcXB9b32qedo
	 rrWDUBgwgE/7S5j88JRb/u3gTcqCeGiJ3N95KJBaRCe/jQcEwr8tVZumk55AjisSnS
	 yme/Tmj0VR9iAqeQOFkuMdoevr7AF/NZejXwiFZQv3Cbvg3705rR3TB9fEL2hYW8Lc
	 oKBRRTFp6j0UJwyH6dMe5aqbTuArp6XFkYuA9s1yTHrHp/jgvErWfvWKdSY9So87/H
	 6TKw+OkMSHPOw==
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
Subject: [PATCHv2 bpf-next 2/7] bpf: Add support for kprobe session context
Date: Tue, 30 Apr 2024 13:28:25 +0200
Message-ID: <20240430112830.1184228-3-jolsa@kernel.org>
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

Adding struct bpf_session_run_ctx object to hold session related
data, which is atm is_return bool and data pointer coming in
following changes.

Placing bpf_session_run_ctx layer in between bpf_run_ctx and
bpf_kprobe_multi_run_ctx so the session data can be retrieved
regardless of if it's kprobe_multi or uprobe_multi link, which
support is coming in future. This way both kprobe_multi and
uprobe_multi can use same kfuncs to access the session data.

Adding bpf_session_is_return kfunc that returns true if the
bpf program is executed from the exit probe of the kprobe multi
link attached in wrapper mode. It returns false otherwise.

Adding new kprobe hook for kprobe program type.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c         |  3 ++
 kernel/trace/bpf_trace.c | 67 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8291fbfd27b1..821063660d9f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -218,6 +218,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
+	BTF_KFUNC_HOOK_KPROBE,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -8157,6 +8158,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_LWT;
 	case BPF_PROG_TYPE_NETFILTER:
 		return BTF_KFUNC_HOOK_NETFILTER;
+	case BPF_PROG_TYPE_KPROBE:
+		return BTF_KFUNC_HOOK_KPROBE;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 06a9671834b6..3e88212bbf84 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2596,6 +2596,11 @@ static int __init bpf_event_init(void)
 fs_initcall(bpf_event_init);
 #endif /* CONFIG_MODULES */
 
+struct bpf_session_run_ctx {
+	struct bpf_run_ctx run_ctx;
+	bool is_return;
+};
+
 #ifdef CONFIG_FPROBE
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
@@ -2609,7 +2614,7 @@ struct bpf_kprobe_multi_link {
 };
 
 struct bpf_kprobe_multi_run_ctx {
-	struct bpf_run_ctx run_ctx;
+	struct bpf_session_run_ctx session_ctx;
 	struct bpf_kprobe_multi_link *link;
 	unsigned long entry_ip;
 };
@@ -2788,7 +2793,8 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
 
 	if (WARN_ON_ONCE(!ctx))
 		return 0;
-	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
 	link = run_ctx->link;
 	if (!link->cookies)
 		return 0;
@@ -2805,15 +2811,20 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 {
 	struct bpf_kprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
 	return run_ctx->entry_ip;
 }
 
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
-			   unsigned long entry_ip, struct pt_regs *regs)
+			   unsigned long entry_ip, struct pt_regs *regs,
+			   bool is_return)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
+		.session_ctx = {
+			.is_return = is_return,
+		},
 		.link = link,
 		.entry_ip = entry_ip,
 	};
@@ -2828,7 +2839,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	migrate_disable();
 	rcu_read_lock();
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
@@ -2848,7 +2859,7 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 	int err;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false);
 	return is_kprobe_session(link->link.prog) ? err : 0;
 }
 
@@ -2860,7 +2871,7 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 	struct bpf_kprobe_multi_link *link;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
@@ -3503,3 +3514,45 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 	return 0;
 }
 #endif /* CONFIG_UPROBES */
+
+#ifdef CONFIG_FPROBE
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_session_is_return(void)
+{
+	struct bpf_session_run_ctx *session_ctx;
+
+	session_ctx = container_of(current->bpf_ctx, struct bpf_session_run_ctx, run_ctx);
+	return session_ctx->is_return;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_session_is_return)
+BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
+
+static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	if (!is_kprobe_session(prog))
+		return -EACCES;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &kprobe_multi_kfunc_set_ids,
+	.filter = bpf_kprobe_multi_filter,
+};
+
+static int __init bpf_kprobe_multi_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+}
+
+late_initcall(bpf_kprobe_multi_kfuncs_init);
+#endif
-- 
2.44.0


