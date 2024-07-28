Return-Path: <bpf+bounces-35815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A193E296
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 03:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94BF1F21BC3
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252E519069C;
	Sun, 28 Jul 2024 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCS0Jv2w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB1190679;
	Sun, 28 Jul 2024 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128052; cv=none; b=Nu49MDTh2gr6sCgA1W9IY2zN2qIM0+gokGpaAryHA0Sn4IMmGAlfkbiY6jYVOTG74Yvr8VfdXOCVI2GfB68zinc3btdKx9fyzQT26qnoyBdlxH8VSH3vz+wJ3lDL9fbi96jYzGJCaKTRsVsEVqXwmeiJ0jx1vkUP0WKMa2HxMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128052; c=relaxed/simple;
	bh=PJB5DSulsnttov7v0aZ/sNAYYlIEyXyL0rtY99Yp0sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0DHaUieki5bNjqZrR3GJbf6loT+vFHFT3t5vfetG+vr0vsXsgZ5YisJ8TT90e1Rx2DdV+gS6uOTCE33KkXH9FBu2MSzr3Jmbp9kHSK98bHANeTLbOHcMiNI58f2qAiOzF4t0pcVyEVnE6vnQ7gtocnXoQ5wzjAU3oTOQTX6YW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCS0Jv2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49C1C4AF09;
	Sun, 28 Jul 2024 00:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128052;
	bh=PJB5DSulsnttov7v0aZ/sNAYYlIEyXyL0rtY99Yp0sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCS0Jv2wOKuAZBFhBm76AmPvsqu03HEIn2CdOlcZb9SFZtgUexe0Wx3nMaoU1txen
	 AqmFTdPVmf3qU6MIbLdZ6RjsOCTvEb5TUSa1t2ocXbSWm7Pjt+T8CPIE9icKJD9XTz
	 2NU9IeDpL/5/MUhIg+WnSI5kPR8NWzcKMGq9x45AmHCxHInj5uC27EmvhR4O3grmd5
	 /0utaF77Wv/zoUwwXL01Uqns98PdPcY1oK8Fy41jELFhJIrI9O2sdoh73/E+1/JT0k
	 rkYlkNM+3/PVbp4gXtuSjZ5pdzna3sRIDoCKjtStnWh9K8b2yjtSThwM6HerF/XuJ/
	 MLxyki8RqQ7Zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Bobrowski <mattbobrowski@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 15/27] bpf: add missing check_func_arg_reg_off() to prevent out-of-bounds memory accesses
Date: Sat, 27 Jul 2024 20:52:58 -0400
Message-ID: <20240728005329.1723272-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Matt Bobrowski <mattbobrowski@google.com>

[ Upstream commit ec2b9a5e11e51fea1bb04c1e7e471952e887e874 ]

Currently, it's possible to pass in a modified CONST_PTR_TO_DYNPTR to
a global function as an argument. The adverse effects of this is that
BPF helpers can continue to make use of this modified
CONST_PTR_TO_DYNPTR from within the context of the global function,
which can unintentionally result in out-of-bounds memory accesses and
therefore compromise overall system stability i.e.

[  244.157771] BUG: KASAN: slab-out-of-bounds in bpf_dynptr_data+0x137/0x140
[  244.161345] Read of size 8 at addr ffff88810914be68 by task test_progs/302
[  244.167151] CPU: 0 PID: 302 Comm: test_progs Tainted: G O E 6.10.0-rc3-00131-g66b586715063 #533
[  244.174318] Call Trace:
[  244.175787]  <TASK>
[  244.177356]  dump_stack_lvl+0x66/0xa0
[  244.179531]  print_report+0xce/0x670
[  244.182314]  ? __virt_addr_valid+0x200/0x3e0
[  244.184908]  kasan_report+0xd7/0x110
[  244.187408]  ? bpf_dynptr_data+0x137/0x140
[  244.189714]  ? bpf_dynptr_data+0x137/0x140
[  244.192020]  bpf_dynptr_data+0x137/0x140
[  244.194264]  bpf_prog_b02a02fdd2bdc5fa_global_call_bpf_dynptr_data+0x22/0x26
[  244.198044]  bpf_prog_b0fe7b9d7dc3abde_callback_adjust_bpf_dynptr_reg_off+0x1f/0x23
[  244.202136]  bpf_user_ringbuf_drain+0x2c7/0x570
[  244.204744]  ? 0xffffffffc0009e58
[  244.206593]  ? __pfx_bpf_user_ringbuf_drain+0x10/0x10
[  244.209795]  bpf_prog_33ab33f6a804ba2d_user_ringbuf_callback_const_ptr_to_dynptr_reg_off+0x47/0x4b
[  244.215922]  bpf_trampoline_6442502480+0x43/0xe3
[  244.218691]  __x64_sys_prlimit64+0x9/0xf0
[  244.220912]  do_syscall_64+0xc1/0x1d0
[  244.223043]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  244.226458] RIP: 0033:0x7ffa3eb8f059
[  244.228582] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[  244.241307] RSP: 002b:00007ffa3e9c6eb8 EFLAGS: 00000206 ORIG_RAX: 000000000000012e
[  244.246474] RAX: ffffffffffffffda RBX: 00007ffa3e9c7cdc RCX: 00007ffa3eb8f059
[  244.250478] RDX: 00007ffa3eb162b4 RSI: 0000000000000000 RDI: 00007ffa3e9c7fb0
[  244.255396] RBP: 00007ffa3e9c6ed0 R08: 00007ffa3e9c76c0 R09: 0000000000000000
[  244.260195] R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffff80
[  244.264201] R13: 000000000000001c R14: 00007ffc5d6b4260 R15: 00007ffa3e1c7000
[  244.268303]  </TASK>

Add a check_func_arg_reg_off() to the path in which the BPF verifier
verifies the arguments of global function arguments, specifically
those which take an argument of type ARG_PTR_TO_DYNPTR |
MEM_RDONLY. Also, process_dynptr_func() doesn't appear to perform any
explicit and strict type matching on the supplied register type, so
let's also enforce that a register either type PTR_TO_STACK or
CONST_PTR_TO_DYNPTR is by the caller.

Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
Link: https://lore.kernel.org/r/20240625062857.92760-1-mattbobrowski@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 214a9fa8c6fb7..87e242f37f46e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7715,6 +7715,13 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	int err;
 
+	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
+		verbose(env,
+			"arg#%d expected pointer to stack or const struct bpf_dynptr\n",
+			regno);
+		return -EINVAL;
+	}
+
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
 	 */
@@ -9464,6 +9471,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 		} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
+			ret = check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_DYNPTR);
+			if (ret)
+				return ret;
+
 			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
 			if (ret)
 				return ret;
@@ -11957,12 +11968,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
 			int clone_ref_obj_id = 0;
 
-			if (reg->type != PTR_TO_STACK &&
-			    reg->type != CONST_PTR_TO_DYNPTR) {
-				verbose(env, "arg#%d expected pointer to stack or dynptr_ptr\n", i);
-				return -EINVAL;
-			}
-
 			if (reg->type == CONST_PTR_TO_DYNPTR)
 				dynptr_arg_type |= MEM_RDONLY;
 
-- 
2.43.0


