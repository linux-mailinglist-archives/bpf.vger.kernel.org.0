Return-Path: <bpf+bounces-33023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B3915EE8
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B60283B15
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 06:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13646145FEC;
	Tue, 25 Jun 2024 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp+18722"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AB2BCF6
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296956; cv=none; b=sbDWVO5xB5OmtdX34BSmtQco5f5rgF4bqDTn98n5L7GbvRC+dW6svxJB/obYzOqW4jlnWzoFwRf3bsVTe/MDimcTc7mPl2rMYhK61ipD3kjJh9iNb7UkTp2g0MJ9SP0Oq0hPFUCaBb7/2Y2aP1+IHio+lRPxaUGHDjprJVn7a80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296956; c=relaxed/simple;
	bh=8jQdtstZAoSdae9W9GGS7U6RzVtRSHUIySdBFDQ6sUc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ng2XRl2e8C7vEkFIgYCPRztaNRrfzZGW2n491OXcsJDjDFMcLb0ixrjRrugAMOm6ULZbLkjp79lHDDu0dxqLMJ+KA317iUhhqbil+ED4rXHpgKbmbpVoI+FU5rkjQspyt6fy7u7cQlEB9RHJD1jS9qzzRVfBy1SJu1PsVLZuL8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp+18722; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a7251e7f53fso99214966b.1
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719296953; x=1719901753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1k/5TsJ2C8J3ikg2sDCKgUhDwwGoo1ggX5R3Uox439o=;
        b=Zp+18722DQ4FTg31AiS4P1VXS4rqMznTDF4bZTeyWk4vxeKZjlFLl/X1EehrOM6Kvt
         qwEuUghus38whU9JsBu50YxD3c8TsNBSuZGOq1Cf9R0L2IFH7HipnXzwLVhoWLTB7H/0
         ebu69f/1AGcsjHn0jLuPdDcnt+XN0rgM7w2o18Q6CirS2XVluTFE2xoJN+Eie2CThbsp
         DuLXdYNfSVFOWVjxx0THmQU/JkwYaCtujEESgWGUmnfSEtH44UBkOFYUseo2GlLuvLXo
         tY81vtKJLjItFZfTc6w1JAZurbA7A87etc1/okpebA9EB8fATXwYlt9q8Qp03Lps7B7a
         2i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719296953; x=1719901753;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1k/5TsJ2C8J3ikg2sDCKgUhDwwGoo1ggX5R3Uox439o=;
        b=ThmBUrHNMMW2rQnCoXj/Qhy8SedraGKPruSyXfNcBzUvwvrcdVf8n2JE+RVpnr1XZp
         3IC6vig9xCibc/TGvZO7RJnFC4aoQchurxpy32DGI24A2Jhp94Yx2QCfD3+fQZGoSU+1
         IgIFjVERyZn3TKsR3Cvbfi11Er/fqT++Ng+CzI3/1PoJB0+vZDRPc6FE+YHvesKHVlmO
         OUVzwKxwC8RAeIrRoYlHEcxdB8SLMSmUf+jEYAyCeqg263DoXf8hYz7qF/IcYYZE6Gq4
         +hnpE/7MP/KHn87fg5v9Mmar5VVdTLzoYsGgO/ZDjOo7cqX1SXUV3A04iCtYqfpqbm0h
         HtNw==
X-Gm-Message-State: AOJu0YzcFk8W/nkaCXIY0jkwGglMqIavJyYyAvbdK0DV/4/TtvicSPjm
	P7Er77Mys5EaYg4I9jvkXUlLwqK5PDZEpYnOJxKa6don1XtnKET5q0tEBHnLe6aN8JQCMaX00iF
	8xRkCC8HBjUI1eQyKeXSZCNKh2MyZE0FFRbkf5O8Y3BjN3MYJFNREaG7DRITzz+yT3ACaZYZeaC
	NQpSjU7yj/iwLI7CsK+Bndl6yKlzwcBK4IlPTo+/sruysH9B/DXvDGcv8oYZ14CuboFg==
X-Google-Smtp-Source: AGHT+IE/4T8GlF3m6i9cYj1LnsCQWUGt5u/aNfvYMBcaWUjXT9A0pgdBI+cRE2OKk86Y3t1iudBV96lsDq4ZDFHWDT3i
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:c0c7:b0:a6f:b687:1f05 with
 SMTP id a640c23a62f3a-a7245cdc52fmr468966b.8.1719296953190; Mon, 24 Jun 2024
 23:29:13 -0700 (PDT)
Date: Tue, 25 Jun 2024 06:28:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625062857.92760-1-mattbobrowski@google.com>
Subject: [PATCH v2 bpf 1/2] bpf: add missing check_func_arg_reg_off() to
 prevent out-of-bounds memory accesses
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, 
	eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

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
---
 kernel/bpf/verifier.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 214a9fa8c6fb..fe12463511f6 100644
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
@@ -11954,14 +11965,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
 		{
-			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
 			int clone_ref_obj_id = 0;
-
-			if (reg->type != PTR_TO_STACK &&
-			    reg->type != CONST_PTR_TO_DYNPTR) {
-				verbose(env, "arg#%d expected pointer to stack or dynptr_ptr\n", i);
-				return -EINVAL;
-			}
+			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
 
 			if (reg->type == CONST_PTR_TO_DYNPTR)
 				dynptr_arg_type |= MEM_RDONLY;
-- 
2.45.2.741.gdbec12cfda-goog


