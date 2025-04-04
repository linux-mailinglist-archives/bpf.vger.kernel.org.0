Return-Path: <bpf+bounces-55293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A0A7B387
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72253A7C72
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DAE1FDA8A;
	Fri,  4 Apr 2025 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thfke2Yx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170C1FDA61;
	Fri,  4 Apr 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725181; cv=none; b=WCdMtNQziwestrNL6sxpSOVhbTXEFZUuH0ek8CxHDRnC6iU3qNbjOZaTWultX56BXqh6BFpjBnyh/FqEftzuCaHTEA1Oxb/vy9+yHMdyW+8jyPGp9x6CLugg3SVBo50F+vXukyokVor12BjoeoPONhl1et8Esv7sx+ZfQHUL7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725181; c=relaxed/simple;
	bh=BCtxT1d8UkfzjmAXTF1FOqDNIhSGxvXPswTXeXcqyuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyeT2CdPgVVgulo0AWBXmKukHnb0zUdBu33WA8O3WStCCUuNnUhAT3mn+ssfDv/zkF46kXHRt3S3zi785TPYgj9hkhsadX/FxP1DQmbam6h/qbX2YbtWubwJS0N2JZ7AuyveFkzhjkpwGaegLngr04Vbn7rYmpiBpCFI7E2UOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thfke2Yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D06C4CEE5;
	Fri,  4 Apr 2025 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725178;
	bh=BCtxT1d8UkfzjmAXTF1FOqDNIhSGxvXPswTXeXcqyuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Thfke2Yx/EJ0e64JZNwEng/i7oN2zWGeql7OZ2dI7fyivvaUF4pc0roy1Y18oJ1vC
	 i9rvizHHHJXGh7oPEBJRsOXVz2zNH5EAqE9/ONogSc4q97POf3qghxBgGEMQ9u0MEK
	 cGiAKBGaKidZ2YO9SfL3NGFva3ove1asrAvChyzfEyaW178fMoWN+6G9O2aswqsWNV
	 YAJQHBak7lo85uM3Rxw/KHORZlOJRfb/3T82ZIgIBsjjqT88TY1HHlGJykUBlzi23x
	 tVOcVwkJAuDpPAgxh3Es4RG4f6ulAslmc53J61gyarxnfPWvXPKBiip8+bnTHT2yJl
	 LVZsVLCmd68jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 17/20] bpf: Reject attaching fexit/fmod_ret to __noreturn functions
Date: Thu,  3 Apr 2025 20:05:37 -0400
Message-Id: <20250404000541.2688670-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000541.2688670-1-sashal@kernel.org>
References: <20250404000541.2688670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit cfe816d469dce9c0864062cf65dd7b3c42adc6f8 ]

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
Link: https://lore.kernel.org/r/20250318114447.75484-2-laoar.shao@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0cab0d0252fa..f21b3633fd720 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22221,6 +22221,33 @@ BTF_ID(func, __rcu_read_unlock)
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
@@ -22309,6 +22336,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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
2.39.5


