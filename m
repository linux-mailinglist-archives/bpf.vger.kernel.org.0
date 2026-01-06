Return-Path: <bpf+bounces-77985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB8ECF9AB5
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 18:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE90A3012650
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3BA34E761;
	Tue,  6 Jan 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m/zo5dFR"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454934E745;
	Tue,  6 Jan 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720079; cv=none; b=kpNUkMa0cw6scyGAEiVT4Q/3JshxALT63Pwwbk/RjdSaA5alKLUr2kammA84MdzneBb0WQzhr8HW5G7tuTXkd9sdURZnWt/vFK5rGbhn/pXWw0WbkRE8EQMUNs9v6QFoAv9vajzmNZwlCC5tGIYfOQYyYjIjPv7cwl+JQbJuJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720079; c=relaxed/simple;
	bh=2xF3Qg7R7k/WI3hP93EJEWfS637X1esGtX52brV56KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4rVA4ldzqbTeKu+/CGAq43APLHfrc20zwQLBWpfwIUHoJe0S9OaiysGbZ78+fiW9iM4BDxI9PymQXTj8f8FnAXrLJ0O/lnIpBq5ilzitCQKDRgY+xcsNc9GKTa04KxIc56ZBcry/AeWi8h3rvv8CiiuhPpL3Fj8aXbKcdxkkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m/zo5dFR; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767720075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysQ2azkxtQw0iBk6HAA7r3CcBjC7e+Y/6e3WSQkcWpk=;
	b=m/zo5dFRxqIm5r2AFE/gYklYwny46MC3ZvBuJTzSXABwL+jBBW9F+95l4fA2xiM7S6gC7i
	rriJBGWdGlcbB1aIKdW/7xjZJOvOYlVSmdz2t0wxPXEEftiPtBsw849wzG2wK/cXdhglFa
	NDc5HhuOpIRe9snrSg44YfqiDpWOHZA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [RESEND PATCH bpf-next v4 3/9] bpf: Refactor reporting log_true_size for prog_load
Date: Wed,  7 Jan 2026 01:20:12 +0800
Message-ID: <20260106172018.57757-4-leon.hwang@linux.dev>
In-Reply-To: <20260106172018.57757-1-leon.hwang@linux.dev>
References: <20260106172018.57757-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the next commit, it will be able to report logs via extended common
attributes, which will report 'log_true_size' via the extended common
attributes meanwhile.

Therefore, refactor the way of 'log_true_size' reporting in order to
report 'log_true_size' via the extended common attributes easily.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/syscall.c  | 21 +++++++++++++++++----
 kernel/bpf/verifier.c | 12 ++----------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a63e47d2109c..26fbc550e5aa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2868,7 +2868,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
 /* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
+int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8f464b847405..1739601fb7bd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2862,7 +2862,7 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -3080,7 +3080,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto free_prog_sec;
 
 	/* run eBPF verifier */
-	err = bpf_check(&prog, attr, uattr, uattr_size);
+	err = bpf_check(&prog, attr, uattr);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -6160,12 +6160,22 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
 	return ret;
 }
 
+static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
+{
+	if (size >= offsetofend(union bpf_attr, log_true_size) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
+				  &attr->log_true_size, sizeof(attr->log_true_size)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
 	struct bpf_common_attr common_attrs;
 	union bpf_attr attr;
-	int err;
+	int err, ret;
 
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
@@ -6215,7 +6225,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr, size);
+		attr.log_true_size = 0;
+		err = bpf_prog_load(&attr, uattr);
+		ret = copy_prog_load_log_true_size(&attr, uattr, size);
+		err = ret ? ret : err;
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9394b0de2ef0..ab5eacdde92c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25096,12 +25096,11 @@ static int compute_scc(struct bpf_verifier_env *env)
 	return err;
 }
 
-int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
 	int i, len, ret = -EINVAL, err;
-	u32 log_true_size;
 	bool is_priv;
 
 	BTF_TYPE_EMIT(enum bpf_features);
@@ -25300,17 +25299,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->prog->aux->verified_insns = env->insn_processed;
 
 	/* preserve original error even if log finalization is successful */
-	err = bpf_vlog_finalize(&env->log, &log_true_size);
+	err = bpf_vlog_finalize(&env->log, &attr->log_true_size);
 	if (err)
 		ret = err;
 
-	if (uattr_size >= offsetofend(union bpf_attr, log_true_size) &&
-	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
-				  &log_true_size, sizeof(log_true_size))) {
-		ret = -EFAULT;
-		goto err_release_maps;
-	}
-
 	if (ret)
 		goto err_release_maps;
 
-- 
2.52.0


