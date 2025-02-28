Return-Path: <bpf+bounces-52879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1BAA49EC5
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3A7AA3D8
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5B274242;
	Fri, 28 Feb 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2Ap1TPm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E727291F
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760146; cv=none; b=LvL9cItAOhvEYHIRX828Y6dh7fWOVDEV2pYUP8mFcLCRLKOfsNBtU+ACw+pbxdkXkO38knJ6Znvg/TEWbllfu+AckAK/t5ZOh17mYLpD3IigTGHY/m81+tIohEGB6kyw5MpF+KwPMuWj2A+d5DaU3Ugssr16M++cs6jaljX6zyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760146; c=relaxed/simple;
	bh=TsPl7cBUMKFlkTxgPp6Ox+3X35CUnWdqofM9x22/D1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iN0cKTmdQZtktH2Qoxyv23tzrx0gHssnNPL5iMGfss79QY2q1WIOsxAggtf0/oumPkolMkHMtOJxld8UhpL6Pj9KPoUSeEtATQSpT8Mrk/ssQJ5Xns3huL+jXRACz9LGp0pJozQOPRwrSVL7zHXu+6ryacyaixh/RfVD+Pd4U1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2Ap1TPm; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43b5859d1f1so14759335e9.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740760142; x=1741364942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HzgkemgUagp18Wcv/m4R4SWM5ikppz6yO4v4M0kr70=;
        b=c2Ap1TPmc48LzY3Lck8L06YTy4E+4SLd8lzGhpvnxgnJiIg17gwGdm8qOb4jtKohUX
         ia8OLpzrLQX4cygKzD+n1MaI/W00QNRsua9DBHOUat5fJ9k8vcjIMwF5zCbhv8hyr/rH
         a//gYWLQMrqvSuaEFjXR/Ks7hhxxdpFwH1f9bSWp6DcjDBjPSclVRYWmYGJiRZwBQZPG
         iGz1/iXF15sxvBNeqS6kcdlAstsKk3gxKeYnm5oOwj3JdiNlUhED5TbP/Kbz5PBcW4nh
         zFfxSqVhP89OSJw7Kg18L5WN3Bpw1qw1zbc0odnGgT7ZUzaSyakiorRdWzFKeRf4GF9F
         sMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760142; x=1741364942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HzgkemgUagp18Wcv/m4R4SWM5ikppz6yO4v4M0kr70=;
        b=mxOc9sRs/8bXC3s/SkAIpjjKzJskFDtVqo14aIyuodEfsWBwKFnpdOu2W2gkJRSpKv
         7Bg2j04VW2dPb0EM0dnMB+dr9P+QcyHulTgeuo6cGoeM99ZF3zbVtxcNYyi6t9A7EJ1v
         qQ0ytLGRAW3V3qxhJPP6nlzk5lkhDZ51WMzdtMHjCAo1/Q+MdTlLtS/iq1HBFCgmc6O2
         /Qqmle1HRcNVBpCIqvrM9lBM2gzN4DQYLv7gPQ/DwY5qGlr6Ie72DzHunW2Vwq6epKvx
         wLHog8SIQOICVEeUkiH+eNjW+lOFKPNp8IrAAD2n1SxxCHjPlIFLww75t5sNNJxqUYgC
         3b0Q==
X-Gm-Message-State: AOJu0Yz02JcLsVWinSMSgOSLpeSK1bpw11BzkjArCdG4hja7eZxKR/d0
	OUOEPcN9nlvFgNVNzTiFG6BFRe7Gmc4jchbCvf6I6OSL9S0DarpYctSmfRcpy4U=
X-Gm-Gg: ASbGncub2jitGnsGdAGeA+R7P+htIygGDjFl3pn8LYXsylxmLPNTPm94+yPb3/Bu8eY
	8HOVSzHA2+oHnnVxyoPY5YGoV7eLuOEB60Fa34JmL5Fu5tMRB/mH5CA7b6d2VPUwn1puOdDgPjS
	TfEjdzFJwSXKVoCie3jprT4zO7SHJJQp9jp/lX1v3NXwQSZnrxlA+9VJ9be6RZyvAyOnmGVNK+5
	KIJZbeV+JwtyF/+wXufC+mhbsCGqwW99nLRShEHTqyjX8B5aORUvSpgtpKTfAZjd3O5+NVikbnd
	pU+x2JkKbdJHg7Cr
X-Google-Smtp-Source: AGHT+IFJ3lGK1N9LKbbpcX9Pk/2dRTUTvv+6pW0EXC5b6Mhi2jAHKF+A5gDducxnTXW38A9zCZlTEA==
X-Received: by 2002:a5d:5f84:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390ec7c6a3bmr3799611f8f.3.1740760141663;
        Fri, 28 Feb 2025 08:29:01 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dbe7sm5713537f8f.93.2025.02.28.08.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:29:00 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Summarize sleepable global subprogs
Date: Fri, 28 Feb 2025 08:28:57 -0800
Message-ID: <20250228162858.1073529-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250228162858.1073529-1-memxor@gmail.com>
References: <20250228162858.1073529-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5782; h=from:subject; bh=TsPl7cBUMKFlkTxgPp6Ox+3X35CUnWdqofM9x22/D1c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwePuLGsi5hIF1OuTZcaWssouYwPV5EjVti04VR6w 3SkPWnKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8Hj7gAKCRBM4MiGSL8RyuznD/ 0ZGZU3B4Ha/bBkoj5WQxDocZvW7HsdUtSga1wqTC1c3TdNicQdeuZq91giVB/TMcKLz+qygT7G2EqJ aDaHVRLQufCMRnBR1iiNzotTXw6TD67AJEXg91uBGyj1yHIqVSR1uvvllwEgSriSVNgJnbY0NMAGtl CELUWZM335/SVbE9lFIizC1XTotVoV13GeI+8dnCh3T4OFRpxCCz5QvtBOtwyGETlWNQdrszibxGFR tCMQkq2S/do8Jdnc3N8CDEO5QnO+ajoXAG5R4zadr7GrTlcF0HDlscrRMGx4Fgaf1JLNvyth6v3iv6 OlNcXXfX7G2N++n6nHDFuWWM/canbLZ0eY2WLkzMtDgc6RVEnlD22TAqYKZERUG7vblqincstGjn5J mxGX0sN5GSpip9xMOO2ik+lXT/LkPme1tjEtR3N78cRSVIZlPIq9A33Dqf7w3y2EcKK4KhRdnfWbwQ AgP2paks8UHIq65oxb0qBsLlFmgjTwIZ3Ogtl2s9MtF/Ykre+D7+4zZbMhXGYUFdRfqji4wI2nLFvV Qbx2UO5qpFUJ277S+HcNn8ykqxHFWt89HHmwME5aY3/ckkBBGpmwxWB48HgFvsn3iunIwDdDAus+f7 xLWN9sR+EY/yGOQcgyKoPEKG5bFQDjeH3vd8cN34QMJ+J2sPnjTxRN1QmIdQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The verifier currently does not permit global subprog calls when a lock
is held, preemption is disabled, or when IRQs are disabled. This is
because we don't know whether the global subprog calls sleepable
functions or not.

In case of locks, there's an additional reason: functions called by the
global subprog may hold additional locks etc. The verifier won't know
while verifying the global subprog whether it was called in context
where a spin lock is already held by the program.

Perform summarization of the sleepable nature of a global subprog just
like changes_pkt_data and then allow calls to global subprogs for
non-sleepable ones from atomic context.

While making this change, I noticed that RCU read sections had no
protection against sleepable global subprog calls, include it in the
checks and fix this while we're at it.

Care needs to be taken to not allow global subprog calls when regular
bpf_spin_lock is held. When resilient spin locks is held, we want to
potentially have this check relaxed, but not for now.

Tests are included in the next patch to handle all special conditions.

Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 50 ++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bbd013c38ff9..1b3cfa6cb720 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -667,6 +667,7 @@ struct bpf_subprog_info {
 	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
+	bool sleepable: 1;
 
 	enum priv_stack_mode priv_stack_mode;
 	u8 arg_cnt;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dcd0da4e62fc..e3560d19d513 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10317,23 +10317,18 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (subprog_is_global(env, subprog)) {
 		const char *sub_name = subprog_name(env, subprog);
 
-		/* Only global subprogs cannot be called with a lock held. */
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
 			return -EINVAL;
 		}
 
-		/* Only global subprogs cannot be called with preemption disabled. */
-		if (env->cur_state->active_preempt_locks) {
-			verbose(env, "global function calls are not allowed with preemption disabled,\n"
-				     "use static function instead\n");
-			return -EINVAL;
-		}
-
-		if (env->cur_state->active_irq_id) {
-			verbose(env, "global function calls are not allowed with IRQs disabled,\n"
-				     "use static function instead\n");
+		if (env->subprog_info[subprog].sleepable &&
+		    (env->cur_state->active_rcu_lock || env->cur_state->active_preempt_locks ||
+		     env->cur_state->active_irq_id || !in_sleepable(env))) {
+			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
+				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
+				     "a non-sleepable BPF program context\n");
 			return -EINVAL;
 		}
 
@@ -16703,6 +16698,14 @@ static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
 	subprog->changes_pkt_data = true;
 }
 
+static void mark_subprog_sleepable(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog = find_containing_subprog(env, off);
+	subprog->sleepable = true;
+}
+
 /* 't' is an index of a call-site.
  * 'w' is a callee entry point.
  * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
@@ -16716,6 +16719,7 @@ static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 	caller = find_containing_subprog(env, t);
 	callee = find_containing_subprog(env, w);
 	caller->changes_pkt_data |= callee->changes_pkt_data;
+	caller->sleepable |= callee->sleepable;
 }
 
 /* non-recursive DFS pseudo code
@@ -17183,9 +17187,20 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			mark_prune_point(env, t);
 			mark_jmp_point(env, t);
 		}
-		if (bpf_helper_call(insn) && bpf_helper_changes_pkt_data(insn->imm))
-			mark_subprog_changes_pkt_data(env, t);
-		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+		if (bpf_helper_call(insn)) {
+			const struct bpf_func_proto *fp;
+
+			ret = get_helper_proto(env, insn->imm, &fp);
+			/* If called in a non-sleepable context program will be
+			 * rejected anyway, so we should end up with precise
+			 * sleepable marks on subprogs, except for dead code
+			 * elimination.
+			 */
+			if (ret == 0 && fp->might_sleep)
+				mark_subprog_sleepable(env, t);
+			if (bpf_helper_changes_pkt_data(insn->imm))
+				mark_subprog_changes_pkt_data(env, t);
+		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
 			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
@@ -17204,6 +17219,13 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				 */
 				mark_force_checkpoint(env, t);
 			}
+			/* Same as helpers, if called in a non-sleepable context
+			 * program will be rejected anyway, so we should end up
+			 * with precise sleepable marks on subprogs, except for
+			 * dead code elimination.
+			 */
+			if (ret == 0 && is_kfunc_sleepable(&meta))
+				mark_subprog_sleepable(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
-- 
2.43.5


