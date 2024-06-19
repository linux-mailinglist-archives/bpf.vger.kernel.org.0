Return-Path: <bpf+bounces-32504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382C790E57D
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8D61C21397
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D487A158;
	Wed, 19 Jun 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQ2XMnqB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00B79950
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785793; cv=none; b=oGrLIv5jqUhtJZApIsqSeqrImcq7n0SEaDZDG3RCDJY1r5zbBXk/5LbGrwTsDeSvXgNK8NznXO4AGPVE4+GaCCo1inhtg9KDLk1R3whLgoOYTLcLICLi8ptvEXyhZXlOOjFn3Kyu0bBn6z06u9/XBzQ5nwkpxEx7xTo3z5OnQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785793; c=relaxed/simple;
	bh=i46BzF+RWGhw0a5CXoRiwLvvE3Fi9V4JEwDejlhLAB8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gIGcXY+5QZLH24KCYee+5YsVxnVFinJOVWI0JXNpBHfFqlhvQnW5QQXinD5H4X6TuqDsVmhOG7t7SlzEDENjaIglRPYTbQ+qGfPpi3r/HBy+7z0Bwp4KRRSuVnYtmKOowB4JOk4Rv8EFT8B18KyRaqF5vZMpqAlrPk7xxEBx2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQ2XMnqB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f9fc2cbf6so132518437b3.2
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718785791; x=1719390591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KA6oFBdoZPO9pn5vxy+8A0XND8kaCGiAHjFD6Wnmak8=;
        b=WQ2XMnqB2KTv94LOEtGx5K16WmsaXxb3DBrxmaMJY0IwupR0n7z/8MXPYlu1zRgoFE
         S+7XRLsTSO09HKna9ur9wXIpKOg9qlu/CmM/0sRkUC7RHupIppHTOJw4TmkWtVxyNC1n
         OkSFd2rVEw7BqKZP79v2jeBKul5/BFn8UXGQ6ElZNz/qxG+SUgt6lqlMNHRu4ojpOY6j
         0y7lpsiyIK4eT6COdmbSfftcmCleTtRAqbTIDjsT4E2U4H1KjqVaEU3bNbcyVuKsXuuP
         sBv7cU2bV+bkpX8rn7iMpDgcTzh9WmUqg7XoT0JLQofHV6HsfhuoifD4foHnVoD8YI96
         GXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785791; x=1719390591;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KA6oFBdoZPO9pn5vxy+8A0XND8kaCGiAHjFD6Wnmak8=;
        b=sTwRXC2PWyI5qz9BI4J0y0fg0dGvz1AMrObnqmukqxyVnGC3vTgu5ldFPlQjeyw77X
         G1RPIstqpidfYFMJqNe6S7Sn4lG+zUNyo/lBm+S5XvKgptqvWtI1aQUWKlB6M4EQUeHS
         pc34w0O8xhUzNqKwf6qXKTgZ2yh6H2vv6dY2BFtrdzIAvefxh7qSxWu7tIm8YBmxm0ht
         +xAavFMKyGe8cdX0v7t+b4mGJ1o7GDhlOQRhrAOxpfxyvpw6mSFOW3bvtd0fXyfKZcwP
         spgMJ8ssicWa6IEi0RtE71lxcU/YNfY+a8raOR4tkHd1P86hBa+kwu9DnDHOZz8ndwzE
         wJOQ==
X-Gm-Message-State: AOJu0Yx1b6sxGBPevOrMgiJyFo9gkEHhHfz2BW886AidP6iqVuKtqwTd
	VlUuuva04iO+Qd0i5EBmCI/3ORqIOdskxacC4GpnLqkhUB3G+307zreJtxTuLvnbzPuA2btrTRZ
	CM6ywsDl7AXm3xW5XgWZUiKguBsPiH4UPJvuTipRtjYhUvoob96oPRMJ0Q99AAXVpWGUP+WMAAE
	/TTGbIz0YmTazkdZ6y9X+v0yIv6+GtagDygEl8DKgh8MHLWJbpPwKJdsrD/EHFUjLjLg==
X-Google-Smtp-Source: AGHT+IFbJ90PqE/G/Jnj13beWpYQVpTpKuFHmhDeWu+NfpqhDbdlXac5wk8Kkv/tlmZhM4nlWE9FRfe4n+i30FFF9FS6
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a81:4c49:0:b0:62c:f976:a763 with
 SMTP id 00721157ae682-63a8d82cbdamr4451347b3.1.1718785791173; Wed, 19 Jun
 2024 01:29:51 -0700 (PDT)
Date: Wed, 19 Jun 2024 08:29:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240619082946.2389067-1-mattbobrowski@google.com>
Subject: [PATCH bpf] bpf: add missing check_func_arg_reg_off() to prevent
 out-of-bounds memory accesses
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, 
	Matt Bobrowski <mattbobrowski@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
CONST_PTR_TO_DYNPTR is by the caller. Lastly, we also add a new
negative test which catches this regression.

Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/verifier.c                         | 27 ++++++++++++-------
 .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 22 +++++++++++++++
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e0a398a97d32..6dd0a0b7db8e 100644
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
@@ -9464,7 +9471,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 		} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
-			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
+			ret = check_func_arg_reg_off(env, reg, regno,
+						     ARG_PTR_TO_DYNPTR);
+			if (ret)
+				return ret;
+
+			ret = process_dynptr_func(env, regno, -1, arg->arg_type,
+						  0);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -11954,14 +11967,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -11990,7 +11997,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 			}
 
-			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
+			ret = process_dynptr_func(env, regno, insn_idx,
+						  dynptr_arg_type,
+						  clone_ref_obj_id);
 			if (ret < 0)
 				return ret;
 
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index 2dde8e3fe4c9..e68667aec6a6 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -45,7 +45,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
 }
 
 SEC("?lsm.s/bpf")
-__failure __msg("arg#0 expected pointer to stack or dynptr_ptr")
+__failure __msg("arg#1 expected pointer to stack or const struct bpf_dynptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
 {
 	unsigned long val = 0;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 11ab25c42c36..54de0389f878 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -221,3 +221,25 @@ int user_ringbuf_callback_reinit_dynptr_ringbuf(void *ctx)
 	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_ringbuf, NULL, 0);
 	return 0;
 }
+
+__noinline long global_call_bpf_dynptr_data(struct bpf_dynptr *dynptr)
+{
+	bpf_dynptr_data(dynptr, 0xA, 0xA);
+	return 0;
+}
+
+static long callback_adjust_bpf_dynptr_reg_off(struct bpf_dynptr *dynptr,
+					       void *ctx)
+{
+	global_call_bpf_dynptr_data(dynptr += 1024);
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("dereference of modified dynptr_ptr ptr R1 off=16384 disallowed")
+int user_ringbuf_callback_const_ptr_to_dynptr_reg_off(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf,
+			       callback_adjust_bpf_dynptr_reg_off, NULL, 0);
+	return 0;
+}
-- 
2.45.2.627.g7a2c4fd464-goog


