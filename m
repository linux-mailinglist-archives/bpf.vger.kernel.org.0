Return-Path: <bpf+bounces-47985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE0A02EC1
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014133A43A4
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5601DED72;
	Mon,  6 Jan 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bMXxqobD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B34207A
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183852; cv=none; b=BZZfyvgJ8Syiu2RY1us9lM9P3FpncvuXSbYcrySXcsNiya5vr4MGyZSaiWPuVUUny+3LcBlOb3kHNAwqaG+4NBGFLchna4zk2I93z/ndO3TeLMvyvMgMO0PW5y6lZ8yfPYl7I8inhtOCrv340vPqLzK0qykrq/RtcV9vHsmNak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183852; c=relaxed/simple;
	bh=NfRkvqhlZZ0LDhCHqiTqJDYVEus/XyLrZ94BR8u3ncw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+zseI+XANDj127najd33rrjmjkFb8ROEPPk1JOIzL8AabZS3FWOEVHHOanDnSO2LcEQCp9wInx7WBvS3F/nEYkEisEFI99FViZ7b0OWznMcaD1j7IkWhA9OTTdA9oO3cRFn/CmPoci4a2TQ2Us+Wx/9w+dgcLN107LenB1xG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bMXxqobD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436202dd730so104950555e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736183849; x=1736788649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9nBDJIdmm73Lybn7eqRs2pY0/iS81cuoGZw7wXghN8=;
        b=bMXxqobDr8v0e3dAbx1L7MPmy3o/TENqZ/+n+bGdrFNA3k7+OuQf3+U+oimQ/GP5H4
         LmuJlDnO5REsMosNrRTjw1Z3djnjzB3sNM/Qze1tN9kGvDLdZvBznySXSnAKb2wGPqHp
         nSkxl/ZhHo0hunywXyNUaEuViOvDZRjzuWGJP+cJCUxnppvHr5W9ixZzJ6HHD7TeGRbm
         8sMUTlwNbOH3fBbSYpWANVrZXwU/0h8kyN2qOQD5x3s4teZoVVbNtwsDvBphQaoJRoUL
         LQbFNHECvzDyUR2JD0Aeqd8nJbqP2YzUU5Vk3gHwYCCLTkaD6r8REBk0stc9gd5MyERI
         On3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736183849; x=1736788649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9nBDJIdmm73Lybn7eqRs2pY0/iS81cuoGZw7wXghN8=;
        b=JuxYAbh3oKM+2Kq3qIMR3cq3/cKcck4HnGXl5MQHWBewhmFUIE4mXqB8Nwm7c2CphE
         /ChVLdwv1qbV3FPvMl5AnVRoet5ZGXuVJdyN5y8fU2oIOB2+Oje+j0tkws9NNceb9G2u
         PQcQSi3sqPHSWiAyDokaCJNH6NTVIUVgaadqXSmzsKMLrHk0m+wLaMyTXlfScRaMqKkv
         mz7eBWmuEkXiknRKA/EwTUyjnLGsyLnqIwBwtFKwcuejNcRDKjoSoTsWgM8CpYxDEP2z
         mrrPNEX3X7/sfthfYqmRPJhABoYhOAxfVPTnWVgaokBp3xjitsJ3TFVc2LuPqUuFJ2YQ
         F/pw==
X-Gm-Message-State: AOJu0YxnskGJlJaT9d9GZrkEKd911GO7Yywj0nTmh/P30Bfa0uUalX1x
	tlYMh8k3ZKQlKaShlZmjMfwOGb/wbjrRiJi7JMvQARJGuuzclH8WoDnLHUMEellrYDiVg2WWNRx
	2E6kKmg==
X-Gm-Gg: ASbGncvfY34aFf9NgCO2TM0eoIETKDgIWadGCHcrmv6l0o8LR1BVbH6YE/vRA9YuN1n
	uQZ4OnRWcqS8nxGVwhc6c6GF1krCeX0DMk30GarN3FAsrYzhKoAgHN3guTuRJG504v7SL6qHAoE
	ETCvi9cIjxiQZSOLuuS/xFge9BnN0DpMYLakgjVOiVVWSEk2WB4FIax5DYG3g5nJkim/aaZI4rA
	xCS0Rj8JZFJNtdB6cvt6lqrAJ4rUTr2LnC1Uw==
X-Google-Smtp-Source: AGHT+IEnHOjmbZyYEzn/yXR4NqBypSkcbr6FuIZCOatnFlbT/pBRbhUV3V7exLey0nM0MOuWGyf2xA==
X-Received: by 2002:a05:600c:45cd:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-4366864619dmr543198575e9.15.1736183848447;
        Mon, 06 Jan 2025 09:17:28 -0800 (PST)
Received: from bobby.. ([2a09:bac1:27c0:58::241:2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828bd3sm47658263f8f.10.2025.01.06.09.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:17:28 -0800 (PST)
From: Arthur Fabre <afabre@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	kernel-team@cloudflare.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH bpf v3 1/2] bpf: Account for early exit of bpf_tail_call() and LD_ABS
Date: Mon,  6 Jan 2025 18:15:24 +0100
Message-ID: <20250106171709.2832649-2-afabre@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106171709.2832649-1-afabre@cloudflare.com>
References: <20250106171709.2832649-1-afabre@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_tail_call(), LD_ABS, and LD_IND can cause the current function to
return abnormally:
- On success, bpf_tail_call() will jump to the tail_called program, and
  that program will return directly to the outer caller.
- On failure, LD_ABS or LD_IND return directly to the outer caller.

But the verifier doesn't account for these abnormal exits, so it assumes
the instructions following a bpf_tail_call() or LD_ABS are always
executed, and updates bounds info accordingly.

Before BPF to BPF calls that was ok: the whole BPF program would
terminate anyways, so it didn't matter that the verifier state didn't
match reality.

But if these instructions are used in a function call, the verifier will
propagate some of this incorrect bounds info to the caller. There are at
least two kinds of this:
- The callee's return value in the caller.
- References to the caller's stack passed into the caller.

For example, loading:

    #include <linux/bpf.h>
    #include <bpf/bpf_helpers.h>

    struct {
            __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
            __uint(max_entries, 1);
            __uint(key_size, sizeof(__u32));
            __uint(value_size, sizeof(__u32));
    } tail_call_map SEC(".maps");

    static __attribute__((noinline)) int callee(struct xdp_md *ctx)
    {
            bpf_tail_call(ctx, &tail_call_map, 0);

            int ret;
            asm volatile("%0 = 23" : "=r"(ret));
            return ret;
    }

    static SEC("xdp") int caller(struct xdp_md *ctx)
    {
            int res = callee(ctx);
            if (res == 23) {
                    return XDP_PASS;
            }
            return XDP_DROP;
    }

The verifier logs:

    func#0 @0
    func#1 @6
    0: R1=ctx() R10=fp0
    ; int res = callee(ctx); @ test.c:24
    0: (85) call pc+5
    caller:
     R10=fp0
    callee:
     frame1: R1=ctx() R10=fp0
    6: frame1: R1=ctx() R10=fp0
    ; bpf_tail_call(ctx, &tail_call_map, 0); @ test.c:15
    6: (18) r2 = 0xffff8a9c82a75800       ; frame1: R2_w=map_ptr(map=tail_call_map,ks=4,vs=4)
    8: (b4) w3 = 0                        ; frame1: R3_w=0
    9: (85) call bpf_tail_call#12
    10: frame1:
    ; asm volatile("%0 = 23" : "=r"(ret)); @ test.c:18
    10: (b7) r0 = 23                      ; frame1: R0_w=23
    ; return ret; @ test.c:19
    11: (95) exit
    returning from callee:
     frame1: R0_w=23 R10=fp0
    to caller at 1:
     R0_w=23 R10=fp0

    from 11 to 1: R0_w=23 R10=fp0
    ; int res = callee(ctx); @ test.c:24
    1: (bc) w1 = w0                       ; R0_w=23 R1_w=23
    2: (b4) w0 = 2                        ; R0=2
    ;  @ test.c:0
    3: (16) if w1 == 0x17 goto pc+1
    3: R1=23
    ; } @ test.c:29
    5: (95) exit
    processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1

And tracks R0_w=23 from the callee through to the caller.
This lets it completely prune the res != 23 branch, skipping over
instruction 4.

But this isn't sound: the bpf_tail_call() could make the callee return
before r0 = 23.

Aside from pruning incorrect branches, this can also be used to read and
write arbitrary memory by using r0 as a index.

Make the verifier track instructions that can return abnormally as a
branch that either exits, or falls through to the remaining
instructions.

This naturally checks for resource leaks, so we can remove the explicit
checks for tail_calls and LD_ABS.

Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
Cc: stable@vger.kernel.org
---
 kernel/bpf/verifier.c | 84 +++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77f56674aaa9..a0853e9866d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10488,13 +10488,20 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	return 0;
 }
 
-static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
+enum bpf_exit {
+	BPF_EXIT_INSN,
+	BPF_EXIT_EXCEPTION,
+	BPF_EXIT_TAIL_CALL,
+	BPF_EXIT_LD_ABS,
+};
+
+static int check_reference_leak(struct bpf_verifier_env *env, enum bpf_exit exit)
 {
 	struct bpf_func_state *state = cur_func(env);
 	bool refs_lingering = false;
 	int i;
 
-	if (!exception_exit && state->frameno)
+	if (exit != BPF_EXIT_EXCEPTION && state->frameno)
 		return 0;
 
 	for (i = 0; i < state->acquired_refs; i++) {
@@ -10507,16 +10514,32 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 	return refs_lingering ? -EINVAL : 0;
 }
 
-static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit, bool check_lock, const char *prefix)
+static int check_resource_leak(struct bpf_verifier_env *env, enum bpf_exit exit, bool check_lock)
 {
 	int err;
+	const char *prefix;
+
+	switch (exit) {
+	case BPF_EXIT_INSN:
+		prefix = "BPF_EXIT instruction";
+		break;
+	case BPF_EXIT_EXCEPTION:
+		prefix = "bpf_throw";
+		break;
+	case BPF_EXIT_TAIL_CALL:
+		prefix = "tail_call";
+		break;
+	case BPF_EXIT_LD_ABS:
+		prefix = "BPF_LD_[ABS|IND]";
+		break;
+	}
 
 	if (check_lock && cur_func(env)->active_locks) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
 		return -EINVAL;
 	}
 
-	err = check_reference_leak(env, exception_exit);
+	err = check_reference_leak(env, exit);
 	if (err) {
 		verbose(env, "%s would lead to reference leak\n", prefix);
 		return err;
@@ -10802,11 +10825,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	switch (func_id) {
-	case BPF_FUNC_tail_call:
-		err = check_resource_leak(env, false, true, "tail_call");
-		if (err)
-			return err;
-		break;
 	case BPF_FUNC_get_local_storage:
 		/* check that flags argument in get_local_storage(map, flags) is 0,
 		 * this is required because get_local_storage() can't return an error.
@@ -15963,14 +15981,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	if (err)
 		return err;
 
-	/* Disallow usage of BPF_LD_[ABS|IND] with reference tracking, as
-	 * gen_ld_abs() may terminate the program at runtime, leading to
-	 * reference leak.
-	 */
-	err = check_resource_leak(env, false, true, "BPF_LD_[ABS|IND]");
-	if (err)
-		return err;
-
 	if (regs[ctx_reg].type != PTR_TO_CTX) {
 		verbose(env,
 			"at the time of BPF_LD_ABS|IND R6 != pointer to skb\n");
@@ -18540,7 +18550,7 @@ static int do_check(struct bpf_verifier_env *env)
 	int prev_insn_idx = -1;
 
 	for (;;) {
-		bool exception_exit = false;
+		enum bpf_exit exit;
 		struct bpf_insn *insn;
 		u8 class;
 		int err;
@@ -18760,7 +18770,7 @@ static int do_check(struct bpf_verifier_env *env)
 				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 					err = check_kfunc_call(env, insn, &env->insn_idx);
 					if (!err && is_bpf_throw_kfunc(insn)) {
-						exception_exit = true;
+						exit = BPF_EXIT_EXCEPTION;
 						goto process_bpf_exit_full;
 					}
 				} else {
@@ -18770,6 +18780,21 @@ static int do_check(struct bpf_verifier_env *env)
 					return err;
 
 				mark_reg_scratched(env, BPF_REG_0);
+
+				if (insn->src_reg == 0 && insn->imm == BPF_FUNC_tail_call) {
+					/* Explore both cases: tail_call fails and we fallthrough,
+					 * or it succeeds and we exit the current function.
+					 */
+					if (!push_stack(env, env->insn_idx + 1, env->insn_idx, false))
+						return -ENOMEM;
+					/* bpf_tail_call() doesn't set r0 on failure / in the fallthrough case.
+					 * But it does on success, so we have to mark it after queueing the
+					 * fallthrough case, but before prepare_func_exit().
+					 */
+					__mark_reg_unknown(env, &state->frame[state->curframe]->regs[BPF_REG_0]);
+					exit = BPF_EXIT_TAIL_CALL;
+					goto process_bpf_exit_full;
+				}
 			} else if (opcode == BPF_JA) {
 				if (BPF_SRC(insn->code) != BPF_K ||
 				    insn->src_reg != BPF_REG_0 ||
@@ -18795,6 +18820,8 @@ static int do_check(struct bpf_verifier_env *env)
 					verbose(env, "BPF_EXIT uses reserved fields\n");
 					return -EINVAL;
 				}
+				exit = BPF_EXIT_INSN;
+
 process_bpf_exit_full:
 				/* We must do check_reference_leak here before
 				 * prepare_func_exit to handle the case when
@@ -18802,8 +18829,7 @@ static int do_check(struct bpf_verifier_env *env)
 				 * function, for which reference_state must
 				 * match caller reference state when it exits.
 				 */
-				err = check_resource_leak(env, exception_exit, !env->cur_state->curframe,
-							  "BPF_EXIT instruction");
+				err = check_resource_leak(env, exit, !env->cur_state->curframe);
 				if (err)
 					return err;
 
@@ -18817,7 +18843,7 @@ static int do_check(struct bpf_verifier_env *env)
 				 * exits. We also skip return code checks as
 				 * they are not needed for exceptional exits.
 				 */
-				if (exception_exit)
+				if (exit == BPF_EXIT_EXCEPTION)
 					goto process_bpf_exit;
 
 				if (state->curframe) {
@@ -18829,6 +18855,12 @@ static int do_check(struct bpf_verifier_env *env)
 					continue;
 				}
 
+				/* BPF_EXIT instruction is the only one that doesn't intrinsically
+				 * set R0.
+				 */
+				if (exit != BPF_EXIT_INSN)
+					goto process_bpf_exit;
+
 				err = check_return_code(env, BPF_REG_0, "R0");
 				if (err)
 					return err;
@@ -18857,7 +18889,13 @@ static int do_check(struct bpf_verifier_env *env)
 				err = check_ld_abs(env, insn);
 				if (err)
 					return err;
-
+				/* Explore both cases: LD_ABS|IND succeeds and we fallthrough,
+				 * or it fails and we exit the current function.
+				 */
+				if (!push_stack(env, env->insn_idx + 1, env->insn_idx, false))
+					return -ENOMEM;
+				exit = BPF_EXIT_LD_ABS;
+				goto process_bpf_exit_full;
 			} else if (mode == BPF_IMM) {
 				err = check_ld_imm(env, insn);
 				if (err)
-- 
2.43.0


