Return-Path: <bpf+bounces-78673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 817D8D1755A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4205030057DC
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583F37FF4C;
	Tue, 13 Jan 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fF7hhCR9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0B192B75
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293595; cv=none; b=O99LDV6HjU+KDpBV/AmDpiGvPtu59UXQeG+6tZozR1DjP/8MmnSZo7zdpotJoAjd6KnlzuHM29SyL2Zu8hBxF5f7CzYrVv6LRC7UD54BMgxt/NmFFDRyMnXHLOaveZnIxDUDwb9B9eItq2RncdCwqmLC90AlXnPFYEq+RzMpmpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293595; c=relaxed/simple;
	bh=0Bj/UQwFA/9sJ1+Wt/ydZldy4sypVfyWunVem3ZJNPk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tDk8Ab6nRNLP/ZGz1s7M4eV8REtdkMtsPAs+0FlCumGBdEnuB1HBKqzBlE8YFV9LLj7PQrKkkcJsYohbAmoQ2m8UinFSEjFf2EhTEyRI2VvNWJs5+KZTrKOTyPKOER3mnC4lUhvC9d/U4edWltlB7S11/gveUHW+Hv6xa/7Zwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fF7hhCR9; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b841fc79f3eso732551866b.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 00:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768293593; x=1768898393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yw76fE362CdtUTRilAeI36uhCgPu5mppsQkieHhvjCY=;
        b=fF7hhCR93MB1FtplbGvRVwfmbVOxR5uWocV7QhGpaF9mwokWPtau09xhARjTi/1dcv
         sB04v63Fu1K4unCQ95IAJX8nYE0Oy0Sx7bj409QbciV4zkXsqiHI2UJZ8UVoTkYLjLit
         5nfmFPWEXA35VoqqA5bGt5OBnk7RV9EwvpQIya0GSrtmACi0Jmnm/IBpjwxJsI/AhcpC
         7ZhtJzfQXUdWtzyPB8ambmV5JcNCh/7nR59kE6w5W3Was2nVVRDKXHwwHK/iVtUs9XkL
         JTTzq2whSXmZqFeYlnLB/FAtbZmiIKR1D+YckSbwPJuxsDPQ/DOVcaY3uJNCTeL4VJZ4
         8o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293593; x=1768898393;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yw76fE362CdtUTRilAeI36uhCgPu5mppsQkieHhvjCY=;
        b=mBIqMldLrlp8K+za/102W8eIuj39FMvLLqJ13YEj7w2Qh7FmmeirI9JqfDLL/0zl1n
         Ju8MjWCXbqjSj2YI71H/NV90k17QpreddBQ8Ti91MreLnCbQzcgpzQG4Sn+/6/49geg2
         iKTbYPS5sBr2Liz8AGr0Xl4TDtybvGPF1AC3a5yMgWj7Vc40RgIM7ZrAfyox2SfoUIPS
         +Z/lX+6JcxuJvUeT6B0mrCgtiEuFYcIdTDWMSHnefNZ3+DItLwVb8tcvhrmL/FzZD6MI
         j4ZZk5JgPWu0vyZOWvZq3ZfPNxBeOn4w2tFZTQhDMWDgoblUr2cJJaEBlNeDqW8QwWWm
         KzTQ==
X-Gm-Message-State: AOJu0YxS+NuEchrIaIFOG1WjWGwz33qgil1phZm1ADcVEo65uR1e76wx
	omrzidpCFX/77zhadvWxkerZQpBriXj5hD4lCAYObr2LJ5KeFVFuB2vAWPybVPw4BChzRKrjE/+
	eyhC3K1W2f1Gf5N0+kd9OFenGY6OCb6Emwy4MIgYc+ykOoYk1A0eaIhMvrMq+mcXvTPfZhkb5FT
	s0B0A4ChzY+W94uJeX6kQw2vlANl5TPkeZczrAiXLyIk1D5vScqhKV869ktumhQrHouh7TWg==
X-Google-Smtp-Source: AGHT+IEs6AdU0LNJdo4Bthofb1VHEw25bdXgS3mpF/jaF9RNAnk4T1zp/oRFIAheLUIN0PpC4kobpnYGAaLuKhTYiyiw
X-Received: from edtq11.prod.google.com ([2002:aa7:cc0b:0:b0:64b:9458:71b4])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2689:b0:b7f:f862:df26 with SMTP id a640c23a62f3a-b8445194555mr1975754066b.14.1768293592713;
 Tue, 13 Jan 2026 00:39:52 -0800 (PST)
Date: Tue, 13 Jan 2026 08:39:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113083949.2502978-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next 1/3] bpf: return PTR_TO_BTF_ID | PTR_TRUSTED from BPF
 kfuncs by default
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Teach the BPF verifier to treat pointers to struct types returned from
BPF kfuncs as implicitly trusted (PTR_TO_BTF_ID | PTR_TRUSTED) by
default. Returning untrusted pointers to struct types from BPF kfuncs
should be considered an exception only, and certainly not the norm.

Update existing selftests to reflect the change in register type
printing (e.g. `ptr_` becoming `trusted_ptr_` in verifier error
messages).

Link: https://lore.kernel.org/bpf/aV4nbCaMfIoM0awM@google.com/
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/verifier.c                         | 46 ++++++++++++-------
 .../selftests/bpf/progs/map_kptr_fail.c       |  4 +-
 .../struct_ops_kptr_return_fail__wrong_type.c |  2 +-
 .../bpf/progs/verifier_global_ptr_args.c      |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..095bfd5c1716 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14216,26 +14216,38 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			if (is_kfunc_rcu_protected(&meta))
 				regs[BPF_REG_0].type |= MEM_RCU;
 		} else {
-			mark_reg_known_zero(env, regs, BPF_REG_0);
-			regs[BPF_REG_0].btf = desc_btf;
-			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
-			regs[BPF_REG_0].btf_id = ptr_type_id;
+			enum bpf_reg_type type = PTR_TO_BTF_ID;
 
 			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
-				regs[BPF_REG_0].type |= PTR_UNTRUSTED;
-			else if (is_kfunc_rcu_protected(&meta))
-				regs[BPF_REG_0].type |= MEM_RCU;
-
-			if (is_iter_next_kfunc(&meta)) {
-				struct bpf_reg_state *cur_iter;
-
-				cur_iter = get_iter_from_state(env->cur_state, &meta);
-
-				if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
-					regs[BPF_REG_0].type |= MEM_RCU;
-				else
-					regs[BPF_REG_0].type |= PTR_TRUSTED;
+				type |= PTR_UNTRUSTED;
+			else if (is_kfunc_rcu_protected(&meta) ||
+				 (is_iter_next_kfunc(&meta) &&
+				  (get_iter_from_state(env->cur_state, &meta)
+					   ->type & MEM_RCU))) {
+				/*
+				 * If the iterator's constructor (the _new
+				 * function e.g., bpf_iter_task_new) has been
+				 * annotated with BPF kfunc flag
+				 * KF_RCU_PROTECTED and was called within a RCU
+				 * read-side critical section, also propagate
+				 * the MEM_RCU flag to the pointer returned from
+				 * the iterator's next function (e.g.,
+				 * bpf_iter_task_next).
+				 */
+				type |= MEM_RCU;
+			} else {
+				/*
+				 * Any PTR_TO_BTF_ID that is returned from a BPF
+				 * kfunc should by default be treated as
+				 * implicitly trusted.
+				 */
+				type |= PTR_TRUSTED;
 			}
+
+			mark_reg_known_zero(env, regs, BPF_REG_0);
+			regs[BPF_REG_0].btf = desc_btf;
+			regs[BPF_REG_0].type = type;
+			regs[BPF_REG_0].btf_id = ptr_type_id;
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 4c0ff01f1a96..6443b320c732 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -272,7 +272,7 @@ int reject_untrusted_xchg(struct __sk_buff *ctx)
 
 SEC("?tc")
 __failure
-__msg("invalid kptr access, R2 type=ptr_prog_test_ref_kfunc expected=ptr_prog_test_member")
+__msg("invalid kptr access, R2 type=trusted_ptr_prog_test_ref_kfunc expected=ptr_prog_test_member")
 int reject_bad_type_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *ref_ptr;
@@ -291,7 +291,7 @@ int reject_bad_type_xchg(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("invalid kptr access, R2 type=ptr_prog_test_ref_kfunc")
+__failure __msg("invalid kptr access, R2 type=trusted_ptr_prog_test_ref_kfunc")
 int reject_member_of_ref_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *ref_ptr;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
index 6a2dd5367802..c8d217e89eea 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
@@ -12,7 +12,7 @@ void bpf_task_release(struct task_struct *p) __ksym;
  * reject programs returning a referenced kptr of the wrong type.
  */
 SEC("struct_ops/test_return_ref_kptr")
-__failure __msg("At program exit the register R0 is not a known value (ptr_or_null_)")
+__failure __msg("At program exit the register R0 is not a known value (trusted_ptr_or_null_)")
 struct task_struct *BPF_PROG(kptr_return_fail__wrong_type, int dummy,
 			     struct task_struct *task, struct cgroup *cgrp)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 1204fbc58178..e7dae0cf9c17 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -72,7 +72,7 @@ int trusted_task_arg_nonnull_fail1(void *ctx)
 
 SEC("?tp_btf/task_newtask")
 __failure __log_level(2)
-__msg("R1 type=ptr_or_null_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("R1 type=trusted_ptr_or_null_ expected=ptr_, trusted_ptr_, rcu_ptr_")
 __msg("Caller passes invalid args into func#1 ('subprog_trusted_task_nonnull')")
 int trusted_task_arg_nonnull_fail2(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index c8d640802cce..9ca83dce100d 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -220,7 +220,7 @@
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
-	.errstr = "variable ptr_ access var_off=(0x0; 0x7) disallowed",
+	.errstr = "variable trusted_ptr_ access var_off=(0x0; 0x7) disallowed",
 },
 {
 	"calls: invalid kfunc call: referenced arg needs refcounted PTR_TO_BTF_ID",
-- 
2.52.0.457.g6b5491de43-goog


