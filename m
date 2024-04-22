Return-Path: <bpf+bounces-27404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBAA8ACC9C
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908AEB2509B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C951474CD;
	Mon, 22 Apr 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt2WEHT7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E441474B9
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787988; cv=none; b=WXUjLbOmdfJ6HfxqBmRvgEEJFlwjZQ44rRPP8d/LrAs4aXwixNWAQRdCa52MKAEA3jIiJa8L1eYoooIiY5wYDwgA8mR1ePvuvb9JiL6gj67CUwu2QgNNZpZLHK4MKvEBd9eU3ie/3oX3ZjSBr0ysuNo1WLkrh2MZl5EUTpbaKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787988; c=relaxed/simple;
	bh=mMybWZI6iqFYyxlnMY65Nb1g0t6LkKsjrkNP6OHTqYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ki6Ag1AJ4ix9LqqcYJ7LLm/HcexgQvOumEr9vgr3GfY/LdPPA4FayLs9OedqUSLezr1DHl84oR9OmLMKUyYLCrF+eptWmm3FksL1WfthZXoqD/bykNweDrcIBKlNi/fMSvZ89thUty8oAgceQT3SMh17isMFeFwMNqs5n2/vhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt2WEHT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA70C32782;
	Mon, 22 Apr 2024 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713787988;
	bh=mMybWZI6iqFYyxlnMY65Nb1g0t6LkKsjrkNP6OHTqYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nt2WEHT7Ym3s6LJF8FdE4LgIo7JhtAqZUmC2RYbsNu2BhUTrq4Dw4+M28PLvTyBqF
	 HMgjR2TRjz1bFWtfsHpNCNQlZVOqiQ66XjoMKRawr5L35wTZL3hjZKJ3hb+98evMUj
	 VFSpQGQvZkuysTje3/WS7f61KTxuLnLFrY/7bMMxUGx0IwWBMXbZ0uZ3TcKNFJyk9e
	 7iNdI1tSrjsaqenPQtpVU7kG2RW4oic4oepaZFt2xbHGnWkA1gXoaTGhTWJc9nNa96
	 jI84+aIIgrvYWUmMtzJW4VgDcE4sdUuEoDNOgFgtmmwQetoY9E01esJXw73PyU4Azw
	 6OgiLlQffps3g==
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
Subject: [PATCH bpf-next 2/7] bpf: Add support for kprobe multi session context
Date: Mon, 22 Apr 2024 14:12:36 +0200
Message-ID: <20240422121241.1307168-3-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c         |  3 ++
 kernel/trace/bpf_trace.c | 67 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6d46cee47ae3..7431230b1e3a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -218,6 +218,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
+	BTF_KFUNC_HOOK_KPROBE,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -8140,6 +8141,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_LWT;
 	case BPF_PROG_TYPE_NETFILTER:
 		return BTF_KFUNC_HOOK_NETFILTER;
+	case BPF_PROG_TYPE_KPROBE:
+		return BTF_KFUNC_HOOK_KPROBE;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3b15a40f425f..d82402316d84 100644
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
 	return is_kprobe_multi_session(link->link.prog) ? err : 0;
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
+	if (!is_kprobe_multi_session(prog))
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


