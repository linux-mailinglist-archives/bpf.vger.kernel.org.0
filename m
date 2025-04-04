Return-Path: <bpf+bounces-55297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF4AA7B3DA
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691A87A8824
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24231917D0;
	Fri,  4 Apr 2025 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt+AyTWX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638E204874;
	Fri,  4 Apr 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725215; cv=none; b=cLqfmg8DdjbVCCUqOoD32dF9RfoGOaohnlvRWurIw70geOBDW7f2G9MpN9JMyjaq38a66fj2vBqKmXCbABRPZHo3/9sji4eEgkD+YBOpbYj8qvx+vZRpLyEtoZmEwW8+iJfTbHp9Y0QpweN3/rI/Am1LaN5rrl15A5E9LTcBea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725215; c=relaxed/simple;
	bh=kOpVAW2eZnPzGD/yiLTqH1fpEPle2cVcYhRZhQyftlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/qHNrhvz35dXVOWS7iWBM55yTXpNhJURAj0y91EnmFmqTSk6ruBfYivqUIpv8l31A5slw3a9Bs5cgotGHtz9vM+AwkQgDU/X8qe441acgp7/jI2BFxl2W9K2jv4Z1ZHoPito//3aD9+vsIL6YUME/BB2QLllz5yuOeB4cB2syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt+AyTWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E00C4CEE3;
	Fri,  4 Apr 2025 00:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725214;
	bh=kOpVAW2eZnPzGD/yiLTqH1fpEPle2cVcYhRZhQyftlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dt+AyTWXHOcPY+cuP5OAxNGas6Croxg+UOq9yWkHYZb7fzj5/LoqV6VQFiuTCtt9g
	 +qa3Pek49V5iDPvkA9r1XV9kvtgP+4HRCLIA/D3VYFsB9Ovi1/mdoua6Xqs3gflinI
	 y165ut7mMxifrTfOyB2Uc2rSQ/sVf26eAvxxoXsNpPIfhKgTvL2cR5kzMlESQiUzrt
	 wuykMIzfHQKHmubc+sv8GuxhbfMAfT9ejVK3jt7lUFM1jgxiYs5WcCoGuJj+BlS97V
	 4OWe33kgkPg7UPR3Rvl/H6L0gCcnkt+me51oCbdRJ1MKUzgpPICYyU3Qx2zWtbH39S
	 Xq/Q/pitKzslw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/16] bpf: Reject attaching fexit/fmod_ret to __noreturn functions
Date: Thu,  3 Apr 2025 20:06:21 -0400
Message-Id: <20250404000624.2688940-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000624.2688940-1-sashal@kernel.org>
References: <20250404000624.2688940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index d6a4102312fad..e443506b0a65a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20106,6 +20106,33 @@ BTF_ID(func, __rcu_read_unlock)
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
@@ -20194,6 +20221,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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


