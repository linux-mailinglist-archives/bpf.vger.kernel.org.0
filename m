Return-Path: <bpf+bounces-54298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AADA672EF
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3F11898215
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0F205E1A;
	Tue, 18 Mar 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acp8AlWl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3E20B21D
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298307; cv=none; b=u62Ia+jXswioRJqE6USbrEKjBga5B5FYZ/xtIJBn6dVCNnP+M3vThldTl5exDRIrbNStHVtsDsZX4d35mn2VpYr4SpG1pd7p9bLuxLMNZl6Uqe3q71pE6PM1EhVnGwTssrRhxuxd1ZEAQbxhqZGWS0PS5pdwhr++1Qg7uWkyuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298307; c=relaxed/simple;
	bh=2jYUWSW3GkWeakv2eOCsYiyoYkYLd729wzFjeqwImXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZaDcNLTq4hdmlQpZ/fpsQyweIHGO6GurTCeg3R35/xq5ADewYRtIpS6dvIQqFfGTuGtEH/doWAEuiE66Qxom5rXYPha/G/nihjg6SXA+59SFcs6FLcLSvMewmZoA9KARXEQizICxoAqxKhiARaNTU3sSpWKHXrNlF85Yma778Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acp8AlWl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225b5448519so101933505ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742298301; x=1742903101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oum4Jcuw4YbD2Sx/DsBjjiv57OnkNyHS5WE5JfKpl38=;
        b=acp8AlWlJtpwvK5P1NazfizXtSb33GSaMZ14NnbjLlH5bk/TbGsVwoPQ666P2hGxc7
         DWzueHadRnEfHyTckObvv5fkDySQEHwX6TEJwKQaSVMTBxZM7+LqHaFaYDiJ/FcqAl18
         MuJYD/JTDrzUaLP8IaU7Us8/dKe4wrau2wvt08ohcMQiMb23/jEr4Ap42OjMHeCTXI53
         AAV7BE5aXKznnvLnqC5qMdM6Ye9cIVoEBO7znBM8YKftSg3YrM9nKQ0sgHQd519N4n21
         LsIK+TlxqnCL92ueIrVPhkhU1ps7dce+ftHBBU+b9ONbIWzY8WdUbkRZRAm4jK2W17N3
         S/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742298301; x=1742903101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oum4Jcuw4YbD2Sx/DsBjjiv57OnkNyHS5WE5JfKpl38=;
        b=usHbh+EEkR6RD+BNJBpVaObybsEAvA57iJUEASvmdlTdJ6WSEYKNHcg9eXZ615N+Dy
         eFsgI0dn4WNhNIm9b1vdA0bJVLM4ExDGi+/dZOmet1VdFAPKaAYJS+L8kHS/bEDQefrc
         a/1Yc6RmYm+cOCE4q7nkmXWRMzFcfQ+RLdrhEf5KYe4Xj49BLb6++SeA+Y2tYomLjxyg
         GHwbS4YnOrEicyfJrJPYp0XI6+UjyVViiJgGPi9ccgA3uWQnqNZuOKUqLu0ADE6Kib5U
         fu4KEUkWxrwp5aYY6bo5CdmgdrHdZOYerQuskX5O8uaSgRmUbzfCg+1Kz6kdxUK1PU4b
         JSpA==
X-Gm-Message-State: AOJu0Yx+JYanlKflpDQdEfS4UC+wl/PRKSuddIXfy+MF0usORbBeO0jt
	ry9r73xuxR6BsaXW40T+nGtILps+4+xhbuyHsy7t9mEVb5ffss28
X-Gm-Gg: ASbGncvyLc5H/RyqHmk6SEYVsIXTf8SVeSBJjaB/F82r4i8iRGguPNj8VQew9sD+Mz7
	rOomShkoPMLIe0f2q1MM+sOBIKKapdB/FRLYEuWP0cb7cjMb6ZHfIkQ0fkJEArbh19dW/BcrZi9
	SSlsCqwM8QGmZ78yip+dvOmHQUY6Kfwp37xyU6Meb13QqFcSchHBxfT4qSkAuqJEQbe5wIIAjgn
	7hJbnIS6QegzKnZy+3BtJ5UFW+53nbkKSlNIdXVdvwuElb77ReDimxvdM5yg7ZAUYG6XywN4xZ6
	yRaHy35AvS8HaAF/h4h7G+iFHoCNpd5hNz2dd//m+Ep4INugIwu+FSVa+1HCVw99t+ZllZZKCg=
	=
X-Google-Smtp-Source: AGHT+IFA1GRH6alD0mjrnIaK8csjxTF6TxJNxlYKoMcd6PXnmRyYYm5sbp0AaRsLROdY9Hl3l0cECg==
X-Received: by 2002:a17:90b:1b0c:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-301a5b32778mr2743057a91.21.1742298300942;
        Tue, 18 Mar 2025 04:45:00 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015353462asm7918551a91.27.2025.03.18.04.44.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 04:45:00 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v5 1/2] bpf: Reject attaching fexit/fmod_ret to __noreturn functions
Date: Tue, 18 Mar 2025 19:44:46 +0800
Message-Id: <20250318114447.75484-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250318114447.75484-1-laoar.shao@gmail.com>
References: <20250318114447.75484-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we attach fexit/fmod_ret to __noreturn functions, it will cause an
issue that the bpf trampoline image will be left over even if the bpf
link has been destroyed. Take attaching do_exit() with fexit for example.
The fexit works as follows,

  bpf_trampoline
  + __bpf_tramp_enter
    + percpu_ref_get(&tr->pcref);

  + call do_exit()

  + __bpf_tramp_exit
    + percpu_ref_put(&tr->pcref);

Since do_exit() never returns, the refcnt of the trampoline image is
never decremented, preventing it from being freed. That can be verified
with as follows,

  $ bpftool link show                                   <<<< nothing output
  $ grep "bpf_trampoline_[0-9]" /proc/kallsyms
  ffffffffc04cb000 t bpf_trampoline_6442526459    [bpf] <<<< leftover

In this patch, all functions annotated with __noreturn are rejected, except
for the following cases:
- Functions that result in a system reboot, such as panic,
  machine_real_restart and rust_begin_unwind
- Functions that are never executed by tasks, such as rest_init and
  cpu_startup_entry
- Functions implemented in assembly, such as rewind_stack_and_make_dead and
  xen_cpu_bringup_again, lack an associated BTF ID.

With this change, attaching fexit probes to functions like do_exit() will
be rejected.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
Attaching fexit/fmod_ret to __noreturn functions is rejected.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3303a3605ee8..19ece8893d38 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23215,6 +23215,33 @@ BTF_ID(func, __rcu_read_unlock)
 #endif
 BTF_SET_END(btf_id_deny)
 
+/* fexit and fmod_ret can't be used to attach to __noreturn functions.
+ * Currently, we must manually list all __noreturn functions here. Once a more
+ * robust solution is implemented, this workaround can be removed.
+ */
+BTF_SET_START(noreturn_deny)
+#ifdef CONFIG_IA32_EMULATION
+BTF_ID(func, __ia32_sys_exit)
+BTF_ID(func, __ia32_sys_exit_group)
+#endif
+#ifdef CONFIG_KUNIT
+BTF_ID(func, __kunit_abort)
+BTF_ID(func, kunit_try_catch_throw)
+#endif
+#ifdef CONFIG_MODULES
+BTF_ID(func, __module_put_and_kthread_exit)
+#endif
+#ifdef CONFIG_X86_64
+BTF_ID(func, __x64_sys_exit)
+BTF_ID(func, __x64_sys_exit_group)
+#endif
+BTF_ID(func, do_exit)
+BTF_ID(func, do_group_exit)
+BTF_ID(func, kthread_complete_and_exit)
+BTF_ID(func, kthread_exit)
+BTF_ID(func, make_task_dead)
+BTF_SET_END(noreturn_deny)
+
 static bool can_be_sleepable(struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING) {
@@ -23301,6 +23328,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
 		return -EINVAL;
+	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
+		   btf_id_set_contains(&noreturn_deny, btf_id)) {
+		verbose(env, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
+		return -EINVAL;
 	}
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
-- 
2.43.5


