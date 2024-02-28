Return-Path: <bpf+bounces-22851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839886AAD6
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 10:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0331C25CF2
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24062E644;
	Wed, 28 Feb 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5DsIur1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A1932C8C
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110992; cv=none; b=MF91gZqECHTk5pSB9FeVeALob9wK0UZr48u89PS3lRyyy/T2i9jJyz03++ZW51dSV8Jstu71VQHpv8vadgYDiZXPj9QTvkMWXB5OyjBG0WH/G+E8dDj6DhRC6EQPmK1oNCvwyAADGQnxzd0jMipg/rLplGPtEz1ZWIAB0GA3GbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110992; c=relaxed/simple;
	bh=kXtX4/U3rFoP4fUmPeIOonOz276DpiqbumpEQbZkpUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QanB4mesP7X4EYeyNlJa3J7NGk78FVVwT1yYyGLpGnLRcs/20mwDMuRusgKD33lrSQjAfokS0qtCyoJLVTb7ZyRnAGWOHj2DRB71BaA5ArpaB/mDtO5Fw8nkZypQmiP7g+AAIO4xWgM+9WQPtX1JpJPuYBftQc2rTn8ZcHFdVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5DsIur1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC12EC433C7;
	Wed, 28 Feb 2024 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110991;
	bh=kXtX4/U3rFoP4fUmPeIOonOz276DpiqbumpEQbZkpUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5DsIur1VGy22hJ2ZLDP7dh5IxXPjXJfL/Ywthvm7ZZnU43idDRPKGZQCFOkNi5zh
	 I0nC+9sM14hWFzUx0lSttzDddpa7qQOoxuTax9GxvcUv9F9pE3e4TegBc1Ie549L10
	 lgKJPAUCiPZjJzCXpISFoSL1rgHtGKbvUCkOBdiASAU8HTUBtapoUtY+p5392Lun0C
	 kofneqxEG1KYriCQiOEDPbR9Zmt9tifCJ2Ov0zeqDvyTwgNEafnNYb2AMqrzA9DyhY
	 3ZS0n3rfMytW6ogoq9W5NoXPLvFRO+DTUfbwrMVdvGYnQuqwfMAIZ2FAkQKWE2WtXh
	 ZZpfn6RxFcHRw==
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH RFCv2 bpf-next 2/4] bpf: Add bpf_kprobe_multi_is_return kfunc
Date: Wed, 28 Feb 2024 10:02:40 +0100
Message-ID: <20240228090242.4040210-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228090242.4040210-1-jolsa@kernel.org>
References: <20240228090242.4040210-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpf_kprobe_multi_is_return kfunc that returns true if the
bpf program is executed from the exit probe of the kprobe multi
link attached in wrapper mode. It returns false otherwise.

Adding new kprobe hook for kprobe program type.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c         |  3 +++
 kernel/trace/bpf_trace.c | 49 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6ff0bd1a91d5..5ab55720e881 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -218,6 +218,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
+	BTF_KFUNC_HOOK_KPROBE,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -8112,6 +8113,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_LWT;
 	case BPF_PROG_TYPE_NETFILTER:
 		return BTF_KFUNC_HOOK_NETFILTER;
+	case BPF_PROG_TYPE_KPROBE:
+		return BTF_KFUNC_HOOK_KPROBE;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 726a8c71f0da..cb801c94b8fa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2594,6 +2594,7 @@ struct bpf_kprobe_multi_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	struct bpf_kprobe_multi_link *link;
 	unsigned long entry_ip;
+	bool is_return;
 };
 
 struct user_syms {
@@ -2793,11 +2794,13 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
-			   unsigned long entry_ip, struct pt_regs *regs)
+			   unsigned long entry_ip, struct pt_regs *regs,
+			   bool is_return)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
 		.link = link,
 		.entry_ip = entry_ip,
+		.is_return = is_return,
 	};
 	struct bpf_run_ctx *old_run_ctx;
 	int err;
@@ -2830,7 +2833,7 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 	int err;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false);
 	return link->is_wrapper ? err : 0;
 }
 
@@ -2842,7 +2845,7 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 	struct bpf_kprobe_multi_link *link;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
@@ -3111,6 +3114,46 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_kprobe_multi_is_return(void)
+{
+	struct bpf_kprobe_multi_run_ctx *run_ctx;
+
+	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx, run_ctx);
+	return run_ctx->is_return;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_kprobe_multi_is_return)
+BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
+
+static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI)
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
 #else /* !CONFIG_FPROBE */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
-- 
2.43.2


