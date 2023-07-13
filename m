Return-Path: <bpf+bounces-4899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7C751657
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FC0281B69
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD5EBC;
	Thu, 13 Jul 2023 02:32:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F47C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:32:55 +0000 (UTC)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3847E172C
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1b89114266dso2295375ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215572; x=1691807572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OK5DwAJDi0WeJ1STGjJlEFL99F9NpE9t2dxL/AuL2A=;
        b=qqBbwS4w7uhtA9joWYu2IS7fhSuPb/D0BqvOn/sQM9TsjcXqWH30TVOi3su+AjnIDy
         oTwA27j45vlWTdVxvZbhNzoJfI2HpxxRAABJMYF6K/HyWB7RLA3T19+6IywU5V1roW2n
         Ulas9mYMR4BD0/sCx+wPp6swoBihzbejBx/zmbJFQIQzbZiNN53cBx/o1gopAXwkUXsE
         Iiw8wqoOEpcIVtr7kur598rmTVMJZDLH3E2KLOrXDsPTI4dPzeRipOhxaqPgBpc94i/k
         oj4zOqk8gm1XvoCJpX9jxe0sqalSssIYQwNFC+Vb5c3c7rlCH7LL07wLURXPKQ1KiiLI
         gJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215572; x=1691807572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OK5DwAJDi0WeJ1STGjJlEFL99F9NpE9t2dxL/AuL2A=;
        b=bAmOHt7Amf+WEd9/Mo7sJoIK33Ot5ndt8/J+W+5DQ8DYBsE96h1jfd2wZbSHtz8wzl
         BWPVkciqiggszYLPeVlBKXt2l+jw5PXlI8C+ylABoauouhEo4r4vNeSDndFYiSizJVX6
         Ruf5elhn3gS1pN8NE1oYDTDgpCFLxQLB1SyefMZTkNix3E7cB+N5oMy69L2agl8HvPAe
         gaT5J2HSNxoP48LfKGcO/NqAP7ArLbafBvWKX5MKYMqwt/kZOS2U/3jfGBIYJ4Ub2mQG
         SyhAaZp1XOvhlxBXrRvg5n5C/HNMUcxDu8xhh2M7fz+E0aRygdK3pvaQmysx9gEDIacn
         RhAA==
X-Gm-Message-State: ABy/qLY3WPvwvI8pW3xEtYK/HWoklZWGlHugzkHmfguRlLixrnxlAP1c
	vude9XaCicT/Nn60lpbYMgEiX8/x8RBDlw==
X-Google-Smtp-Source: APBJJlEUr+RZoQS5FNs9e17ZJ9ggxUUx22DnkBISbKd6XQsgA2KdON4Vqr66BGCktqhyeaQcBUVsYg==
X-Received: by 2002:a17:903:2345:b0:1b5:5fd2:4d6e with SMTP id c5-20020a170903234500b001b55fd24d6emr413704plh.58.1689215571882;
        Wed, 12 Jul 2023 19:32:51 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902848100b001b89b7e208fsm4673469plo.88.2023.07.12.19.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:32:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 04/10] bpf: Add support for inserting new subprogs
Date: Thu, 13 Jul 2023 08:02:26 +0530
Message-Id: <20230713023232.1411523-5-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8621; i=memxor@gmail.com; h=from:subject; bh=cVIqR22tKoTIF4sEUogLkHcJYgzg898L8XXJ1zEC0No=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HHpXDNFJvOLbPA/wALcXYCdUo/M0CedDKaY ZRKcmlBeC2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hxwAKCRBM4MiGSL8R yiPcEACt+YxNt6fdUecRYwjFtJveAOr2J0ity46SA/N5OxOtNaZO3C9VqOitA0CRpizExJmcZMk D7c4ymy9luEi+nIyWiU4CdBPrg2rw2gCrnOIUewYE2qf+r4oBc3WFzPbkMOQ9SoqgrDW3LN3vAS 5S3iSMXZCr8RAToBTgSZzjd+kN73i0sQTQorIJYffV3vwpwGhZ9A642KEkeLq2p51QcVIS8nj6Z 4RycqwLKoB5e85zBzQTF+LZdXeBo5DzS9fdduDaQMUn8HYrlbTE8Ay80ZixODfFSTc387qcY4Y3 tOk3XZheDrZuqYDGY6ZGdK7V/rmT1qpsUuMNID0/PRrdMYe5fn71JH5bqWeNEb5BkwyFpqlj+AC kywUJPZsy+n/whzKPx48gW/CDa8I3qVnMrk0SSZdp3LOhgBinmb+Ywu0+Fv6osb+qbljdQy99x7 fdj/BT3Yuv+IeJBWR0mil54zfb3GhVwUJtF8u+3/3IsRmcBVuY7TIxRp/kNI/pGxm4Tbe/n8b/E u7bSZ3WiCeFORrd33jg/KkqnQ97zcC7HuhgiVIJOcNJV6qDPdvlRgDF61mk9aIw2yXKVw8AJkOr hh+PPjT5MikIAxAO1vQRmx86L3j9FA1QGkq39BosM+yDHb9nToz/JS5xcKDl+dgHP3rUZ4RJ1X6 fD8BcqyEWZXExSw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce support in the verifier for generating a subprogram and
include it as part of a BPF program dynamically after the do_check
phase is complete. The appropriate place of invocation would be
do_misc_fixups.

Since they are always appended to the end of the instruction sequence of
the program, it becomes relatively inexpensive to do the related
adjustments to the subprog_info of the program. Only the fake exit
subprogram is shifted forward by 1, making room for our invented subprog.

This is useful to insert a new subprogram and obtain its function
pointer. The next patch will use this functionality to insert a default
exception callback which will be invoked after unwinding the stack.

Note that these invented subprograms are invisible to userspace, and
never reported in BPF_OBJ_GET_INFO_BY_ID etc. For now, only a single
invented program is supported, but more can be easily supported in the
future.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  4 +++-
 kernel/bpf/core.c            |  4 ++--
 kernel/bpf/syscall.c         | 19 ++++++++++++++++++-
 kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++++++++-
 5 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 360433f14496..70f212dddfbf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1385,6 +1385,7 @@ struct bpf_prog_aux {
 	bool sleepable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
+	bool invented_prog;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d2..360aa304ec09 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -540,6 +540,7 @@ struct bpf_subprog_info {
 	bool has_tail_call;
 	bool tail_call_reachable;
 	bool has_ld_abs;
+	bool invented_prog;
 	bool is_async_cb;
 };
 
@@ -594,10 +595,11 @@ struct bpf_verifier_env {
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
 	bool seen_direct_write;
+	bool invented_prog;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
-	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
+	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	union {
 		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc85240a0134..5c484b2bc3d6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -211,7 +211,7 @@ void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
 	const struct bpf_line_info *linfo;
 	void **jited_linfo;
 
-	if (!prog->aux->jited_linfo)
+	if (!prog->aux->jited_linfo || prog->aux->invented_prog)
 		/* Userspace did not provide linfo */
 		return;
 
@@ -579,7 +579,7 @@ bpf_prog_ksym_set_name(struct bpf_prog *prog)
 	sym  = bin2hex(sym, prog->tag, sizeof(prog->tag));
 
 	/* prog->aux->name will be ignored if full btf name is available */
-	if (prog->aux->func_info_cnt) {
+	if (prog->aux->func_info_cnt && !prog->aux->invented_prog) {
 		type = btf_type_by_id(prog->aux->btf,
 				      prog->aux->func_info[prog->aux->func_idx].type_id);
 		func_name = btf_name_by_offset(prog->aux->btf, type->name_off);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ee8cb1a174aa..769550287bed 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4291,8 +4291,11 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		u32 i;
 
 		info.jited_prog_len = 0;
-		for (i = 0; i < prog->aux->func_cnt; i++)
+		for (i = 0; i < prog->aux->func_cnt; i++) {
+			if (prog->aux->func[i]->aux->invented_prog)
+				break;
 			info.jited_prog_len += prog->aux->func[i]->jited_len;
+		}
 	} else {
 		info.jited_prog_len = prog->jited_len;
 	}
@@ -4311,6 +4314,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 
 				free = ulen;
 				for (i = 0; i < prog->aux->func_cnt; i++) {
+					if (prog->aux->func[i]->aux->invented_prog)
+						break;
 					len = prog->aux->func[i]->jited_len;
 					len = min_t(u32, len, free);
 					img = (u8 *) prog->aux->func[i]->bpf_func;
@@ -4332,6 +4337,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 
 	ulen = info.nr_jited_ksyms;
 	info.nr_jited_ksyms = prog->aux->func_cnt ? : 1;
+	if (prog->aux->func_cnt && prog->aux->func[prog->aux->func_cnt - 1]->aux->invented_prog)
+		info.nr_jited_ksyms--;
 	if (ulen) {
 		if (bpf_dump_raw_ok(file->f_cred)) {
 			unsigned long ksym_addr;
@@ -4345,6 +4352,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 			user_ksyms = u64_to_user_ptr(info.jited_ksyms);
 			if (prog->aux->func_cnt) {
 				for (i = 0; i < ulen; i++) {
+					if (prog->aux->func[i]->aux->invented_prog)
+						break;
 					ksym_addr = (unsigned long)
 						prog->aux->func[i]->bpf_func;
 					if (put_user((u64) ksym_addr,
@@ -4363,6 +4372,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 
 	ulen = info.nr_jited_func_lens;
 	info.nr_jited_func_lens = prog->aux->func_cnt ? : 1;
+	if (prog->aux->func_cnt && prog->aux->func[prog->aux->func_cnt - 1]->aux->invented_prog)
+		info.nr_jited_func_lens--;
 	if (ulen) {
 		if (bpf_dump_raw_ok(file->f_cred)) {
 			u32 __user *user_lens;
@@ -4373,6 +4384,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 			user_lens = u64_to_user_ptr(info.jited_func_lens);
 			if (prog->aux->func_cnt) {
 				for (i = 0; i < ulen; i++) {
+					if (prog->aux->func[i]->aux->invented_prog)
+						break;
 					func_len =
 						prog->aux->func[i]->jited_len;
 					if (put_user(func_len, &user_lens[i]))
@@ -4443,6 +4456,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 
 	ulen = info.nr_prog_tags;
 	info.nr_prog_tags = prog->aux->func_cnt ? : 1;
+	if (prog->aux->func_cnt && prog->aux->func[prog->aux->func_cnt - 1]->aux->invented_prog)
+		info.nr_prog_tags--;
 	if (ulen) {
 		__u8 __user (*user_prog_tags)[BPF_TAG_SIZE];
 		u32 i;
@@ -4451,6 +4466,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		ulen = min_t(u32, info.nr_prog_tags, ulen);
 		if (prog->aux->func_cnt) {
 			for (i = 0; i < ulen; i++) {
+				if (prog->aux->func[i]->aux->invented_prog)
+					break;
 				if (copy_to_user(user_prog_tags[i],
 						 prog->aux->func[i]->tag,
 						 BPF_TAG_SIZE))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d432df5df06..8ce72a7b4758 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14891,8 +14891,11 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
 	if (!aux->func_info)
 		return;
 
-	for (i = 0; i < env->subprog_cnt; i++)
+	for (i = 0; i < env->subprog_cnt; i++) {
+		if (env->subprog_info[i].invented_prog)
+			break;
 		aux->func_info[i].insn_off = env->subprog_info[i].start;
+	}
 }
 
 #define MIN_BPF_LINEINFO_SIZE	offsetofend(struct bpf_line_info, line_col)
@@ -17778,6 +17781,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
+		func[i]->aux->invented_prog = env->subprog_info[i].invented_prog;
 		func[i] = bpf_int_jit_compile(func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
@@ -18071,6 +18075,29 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+/* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
+static int invent_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
+{
+	struct bpf_subprog_info *info = env->subprog_info;
+	int cnt = env->subprog_cnt;
+	struct bpf_prog *prog;
+
+	if (env->invented_prog) {
+		verbose(env, "verifier internal error: only one invented prog supported\n");
+		return -EFAULT;
+	}
+	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
+	if (!prog)
+		return -ENOMEM;
+	env->prog = prog;
+	info[cnt + 1].start = info[cnt].start;
+	info[cnt].start = prog->len - len + 1;
+	info[cnt].invented_prog = true;
+	env->subprog_cnt++;
+	env->invented_prog = true;
+	return 0;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
-- 
2.40.1


