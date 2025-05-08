Return-Path: <bpf+bounces-57801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06168AB04C5
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163144E2C8B
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697328C027;
	Thu,  8 May 2025 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj9orTPP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A421B9FF
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736836; cv=none; b=FAZA1KvrCkXfxdcJ8Fskm3gwbyQkKRNkVlpbV8txgariuEw10uCCfU1AlAI6oRHKYeczUizxzgO5wWqGaTThRv8o20pFZ64xV2lPaGaUnekWIeLxnFUPHv7zbj90jWDBDxQqirOggon2pCW/i1kPM1KSGRsDaCMy7wmO4vJXQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736836; c=relaxed/simple;
	bh=eC4B5nCJ6ESCtQmTC296vBIOJEdeKMPKbmLOzkLiaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dKSaOP1zqncUfhcTwt36vkM/i0eAqqgLthvR0i2839ackhgU2VcWAuATtgeSwu9JFApVkwlPQZtKUqV76PL7mUMJZuStHjCoczaE8BZKVifQdbyVMmedG505j6PLXi7nExRHNHqDTB1Q+dq2Tn2mDBOqIdfqTFOCkwm96mGbGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj9orTPP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so1003278f8f.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746736832; x=1747341632; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sv9HPwpn4Z9qOn8jH6ZuE6pC6mqHJczutSAMZpCq9n0=;
        b=Tj9orTPPJBVRSG+Cx9En/xYw3nxbf+g7n9T+yoqS2E6MoWQDZ+0R9U0cyK9cyXA4uT
         U69Z0UI7hThE2PMoiqRu3DeAkxGpoRY7sUPNUfG8bS/jLjlNHRBFH9T5xhvRcGBcdKrg
         jsV3GMedzluVKaWEKR1YrX3LKjRZItmLVgmfV6j9/BgBzgW7SAWpeoLQr3JFPPf6hAPn
         GB1RECpyw81MnGq4iqNspnLv0ggBBv7RjZRplD/qMwcGJzrGkN9RHkLEv6oVuOGIEaPK
         yQWHN0dEnXdxDmW19ayjRe7BNN2coAnw8rQ/UkpgPl/88M6mW2x2IuT9spVukeLeUDxI
         OfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736832; x=1747341632;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv9HPwpn4Z9qOn8jH6ZuE6pC6mqHJczutSAMZpCq9n0=;
        b=vxXv9TVn/YtYa/ZcS7Ruf7HnzOzBEAqRau/orffRTlUn9OzEYjEY3MjuI7wvWOt8oF
         Ms9e9anyV1g/9NTYy7HU3ejFNVFOmiA920zqFt2gbAswA7JvOm6URe2RT7qrP6s5WPSy
         R1JEkPXaE//J3PcTROlM6ivjLj+gwKppRl245PfbqaF3iG0mWHzWOsKmy0Twm1uCmAey
         qlRQXCmU3HO65v/Jrt2eiidyLxRVwQoMaGgoQkeilTXfgmeDcwmoE1eYrRftiwIhcOpU
         3f3MsK2V7qqEXM4x+x4io0evLqsCndmzTIOnTsf5yq4vqIBmQd6xCc9GN7TcJTyP6Iku
         Kpmg==
X-Gm-Message-State: AOJu0YymZzyoOp28Qo2nUNto3C8fpM4jtQ0RtTrjflYkwd9p3f12+9wx
	BPCjrExTJMocEInYCmmjOd1Gx2f+4NAkvW28vDIjwNclUSIcMahrNPufzQ==
X-Gm-Gg: ASbGncu2gGjSKux0GxU7O1OChH4eTdy9R5y1Vf6X7VDpmw0RZw99Lc7nmWF9dwmHz9j
	53MgbTQop1p6GihMounfSJk+8e6C8Zq4T0sspMqGkhqTuMsVPuA8iD7gIcbGNILdBsT8B19FYdV
	41fV/oAbk0+mXXtp+aasCu14o5SfI7Z4O8ZdJd6iHOVxBr3BaNq3ijmtptO8+fljyKHqs5pPLhe
	sm4elaSDzH0qXLgFaUCxc0l8dec3trgXtq3sO6jBbiWEIT7GwlAZxSFjiXt1m2seX3I2VzZuk5S
	hD+SQrshj4LBmb45GIfYPaV/Kz9mejzVoIIPE+dZy7NpThwh5kbYjl50LbMRduPEscssrUtm8bO
	nQPeVIDl3X/JUEewnDjxHPBQ7twfVAx34aTQGFA==
X-Google-Smtp-Source: AGHT+IFFR07wB62hvTR0dGf7UQ+Z0z1nHNNql1McwnIG06Ggvgn312vZ/3wYtOZWCuoB1AdQTnbN0A==
X-Received: by 2002:a05:6000:2284:b0:3a1:f537:9064 with SMTP id ffacd0b85a97d-3a1f6443c25mr803273f8f.25.1746736831918;
        Thu, 08 May 2025 13:40:31 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00dd4887210ee31c89.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:dd48:8721:ee3:1c89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4d21esm979164f8f.99.2025.05.08.13.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:40:31 -0700 (PDT)
Date: Thu, 8 May 2025 22:40:29 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] bpf: Always WARN_ONCE on verifier bugs
Message-ID: <aB0WvXLMx5DIivc-@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Throughout the verifier's logic, there are multiple checks for
inconsistent states that should never happen and would indicate a
verifier bug. These bugs are typically logged in the verifier logs and
sometimes preceded by a WARN_ONCE.

This patch reworks these checks to consistently emit a verifier log AND
a warning. The consistent use of WARN_ONCE should help fuzzers (ex.
syzkaller) expose any situation where they are actually able to reach
one of those buggy verifier states.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 63 +++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 99aa2c890e7b..521acbba2fda 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -196,6 +196,12 @@ struct bpf_verifier_stack_elem {
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
+#define verifier_bug(env, fmt, args...)				\
+	do {							\
+		WARN_ONCE(1, "verifier bug: " fmt, ##args);	\
+		verbose(env, "verifier bug: " fmt, ##args);	\
+	} while (0)
+
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
 static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
@@ -1924,8 +1930,7 @@ static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
 
 	while (topmost && topmost->loop_entry) {
 		if (steps++ > st->dfs_depth) {
-			WARN_ONCE(true, "verifier bug: infinite loop in get_loop_entry\n");
-			verbose(env, "verifier bug: infinite loop in get_loop_entry()\n");
+			verifier_bug(env, "infinite loop in get_loop_entry\n");
 			return ERR_PTR(-EFAULT);
 		}
 		topmost = topmost->loop_entry;
@@ -3460,9 +3465,9 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 		if (writes && state->live & REG_LIVE_WRITTEN)
 			break;
 		if (parent->live & REG_LIVE_DONE) {
-			verbose(env, "verifier BUG type %s var_off %lld off %d\n",
-				reg_type_str(env, parent->type),
-				parent->var_off.value, parent->off);
+			verifier_bug(env, "type %s var_off %lld off %d\n",
+				     reg_type_str(env, parent->type),
+				     parent->var_off.value, parent->off);
 			return -EFAULT;
 		}
 		/* The first condition is more likely to be true than the
@@ -6562,13 +6567,13 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		next_insn = i + insn[i].imm + 1;
 		sidx = find_subprog(env, next_insn);
 		if (sidx < 0) {
-			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-				  next_insn);
+			verifier_bug(env, "No program starts at insn %d\n",
+				     next_insn);
 			return -EFAULT;
 		}
 		if (subprog[sidx].is_async_cb) {
 			if (subprog[sidx].has_tail_call) {
-				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
+				verifier_bug(env, "subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
 			/* async callbacks don't increase bpf prog stack size unless called directly */
@@ -6676,8 +6681,8 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 
 	subprog = find_subprog(env, start);
 	if (subprog < 0) {
-		WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-			  start);
+		verifier_bug(env, "No program starts at insn %d\n",
+			     start);
 		return -EFAULT;
 	}
 	return env->subprog_info[subprog].stack_depth;
@@ -7984,7 +7989,7 @@ static int check_stack_range_initialized(
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		if (state->allocated_stack <= slot) {
-			verbose(env, "verifier bug: allocated_stack too small\n");
+			verbose(env, "allocated_stack too small\n");
 			return -EFAULT;
 		}
 
@@ -8413,7 +8418,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 	if (meta->map_ptr) {
-		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
+		verifier_bug(env, "Two map pointers in a timer helper\n");
 		return -EFAULT;
 	}
 	meta->map_uid = reg->map_uid;
@@ -10285,8 +10290,8 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	}
 
 	if (state->frame[state->curframe + 1]) {
-		verbose(env, "verifier bug. Frame %d already allocated\n",
-			state->curframe + 1);
+		verifier_bug(env, "Frame %d already allocated\n",
+			     state->curframe + 1);
 		return -EFAULT;
 	}
 
@@ -10400,8 +10405,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (err)
 				return err;
 		} else {
-			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
-				i, arg->arg_type);
+			verifier_bug(env, "unrecognized arg#%d type %d\n",
+				     i, arg->arg_type);
 			return -EFAULT;
 		}
 	}
@@ -10464,13 +10469,13 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
-		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
-			func_id_name(insn->imm), insn->imm);
+		verifier_bug(env, "kfunc %s#%d not marked as callback-calling\n",
+			     func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
 	} else if (!bpf_pseudo_kfunc_call(insn) &&
 		   !is_callback_calling_function(insn->imm)) { /* helper */
-		verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
-			func_id_name(insn->imm), insn->imm);
+		verifier_bug(env, "helper %s#%d not marked as callback-calling\n",
+			     func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
 	}
 
@@ -10523,7 +10528,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	target_insn = *insn_idx + insn->imm + 1;
 	subprog = find_subprog(env, target_insn);
 	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n", target_insn);
+		verifier_bug(env, "No program starts at insn %d\n", target_insn);
 		return -EFAULT;
 	}
 
@@ -11124,7 +11129,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
 						  fmt_map_off);
 	if (err) {
-		verbose(env, "verifier bug\n");
+		verbose(env, "failed to retrieve map value address\n");
 		return -EFAULT;
 	}
 	fmt = (char *)(long)fmt_addr + fmt_map_off;
@@ -19689,8 +19694,8 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
-						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
+					if (unlikely(env->cur_state->loop_entry)) {
+						verifier_bug(env, "env->cur_state->loop_entry != NULL\n");
 						return -EFAULT;
 					}
 					do_print_state = true;
@@ -20750,8 +20755,8 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		if (bpf_pseudo_kfunc_call(&insn))
 			continue;
 
-		if (WARN_ON(load_reg == -1)) {
-			verbose(env, "verifier bug. zext_dst is set, but no reg is defined\n");
+		if (unlikely(load_reg == -1)) {
+			verifier_bug(env, "zext_dst is set, but no reg is defined\n");
 			return -EFAULT;
 		}
 
@@ -21071,8 +21076,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 */
 		subprog = find_subprog(env, i + insn->imm + 1);
 		if (subprog < 0) {
-			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-				  i + insn->imm + 1);
+			verifier_bug(env, "No program starts at insn %d\n",
+				     i + insn->imm + 1);
 			return -EFAULT;
 		}
 		/* temporarily remember subprog id inside insn instead of
@@ -22433,7 +22438,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		/* We need two slots in case timed may_goto is supported. */
 		if (stack_slots > slots) {
-			verbose(env, "verifier bug: stack_slots supports may_goto only\n");
+			verifier_bug(env, "stack_slots supports may_goto only\n");
 			return -EFAULT;
 		}
 
-- 
2.43.0


