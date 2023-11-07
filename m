Return-Path: <bpf+bounces-14394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE28C7E3BDD
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C60E1C20CE2
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B582E41D;
	Tue,  7 Nov 2023 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRGRrAWo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74832E419
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 12:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91E3C433CB;
	Tue,  7 Nov 2023 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359023;
	bh=bsTGK/XTIQXjG/uDZa8YCkbhO2DSeF2xqn7ZDUhAruE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRGRrAWoi0q6tbQDfzTkv1lUeytPRuq55sv2BW+1LrR1892T3EEEdoJA4E2EkgJhr
	 oTz8lON5vWKAqJ7EwlbRI8RZlOi6Q6SNgKCilKp3UKBRYeD2eCyy0Ux+IjaeZ/UeoS
	 BrEPKlH0WP16zvlsAVFUXzPBNLG7AQRKXda074xLphBwh8aetRcdT3SBdl9/jOHFYn
	 BtkGhrEE7Hh4y0ZB/mwnK6LTve+BBm0Y4v02zgvAVrdTb7fK5/s8tI+9Ft8fHAqc0+
	 aqxWeD102B1SuHB13U3Ye1kZoJ2URG9TOrQMjTtTKc3YQsT1STGRkowb4Xlq5sEWNV
	 9LmMS99hvl+HQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 21/30] bpf: Ensure proper register state printing for cond jumps
Date: Tue,  7 Nov 2023 07:08:36 -0500
Message-ID: <20231107120922.3757126-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 1a8a315f008a58f54fecb012b928aa6a494435b3 ]

Verifier emits relevant register state involved in any given instruction
next to it after `;` to the right, if possible. Or, worst case, on the
separate line repeating instruction index.

E.g., a nice and simple case would be:

  2: (d5) if r0 s<= 0x0 goto pc+1       ; R0_w=0

But if there is some intervening extra output (e.g., precision
backtracking log) involved, we are supposed to see the state after the
precision backtrack log:

  4: (75) if r0 s>= 0x0 goto pc+1
  mark_precise: frame0: last_idx 4 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r0 stack= before 2: (d5) if r0 s<= 0x0 goto pc+1
  mark_precise: frame0: regs=r0 stack= before 1: (b7) r0 = 0
  6: R0_w=0

First off, note that in `6: R0_w=0` instruction index corresponds to the
next instruction, not to the conditional jump instruction itself, which
is wrong and we'll get to that.

But besides that, the above is a happy case that does work today. Yet,
if it so happens that precision backtracking had to traverse some of the
parent states, this `6: R0_w=0` state output would be missing.

This is due to a quirk of print_verifier_state() routine, which performs
mark_verifier_state_clean(env) at the end. This marks all registers as
"non-scratched", which means that subsequent logic to print *relevant*
registers (that is, "scratched ones") fails and doesn't see anything
relevant to print and skips the output altogether.

print_verifier_state() is used both to print instruction context, but
also to print an **entire** verifier state indiscriminately, e.g.,
during precision backtracking (and in a few other situations, like
during entering or exiting subprogram).  Which means if we have to print
entire parent state before getting to printing instruction context
state, instruction context is marked as clean and is omitted.

Long story short, this is definitely not intentional. So we fix this
behavior in this patch by teaching print_verifier_state() to clear
scratch state only if it was used to print instruction state, not the
parent/callback state. This is determined by print_all option, so if
it's not set, we don't clear scratch state. This fixes missing
instruction state for these cases.

As for the mismatched instruction index, we fix that by making sure we
call print_insn_state() early inside check_cond_jmp_op() before we
adjusted insn_idx based on jump branch taken logic. And with that we get
desired correct information:

  9: (16) if w4 == 0x1 goto pc+9
  mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1
  mark_precise: frame0: parent state regs=r4 stack=: R2_w=1944 R4_rw=P1 R10=fp0
  mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9
  mark_precise: frame0: regs=r4 stack= before 8: (66) if w4 s> 0x3 goto pc+5
  mark_precise: frame0: regs=r4 stack= before 7: (b7) r4 = 1
  9: R4=1

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20231011223728.3188086-6-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 104681258d24f..c9587886ddc03 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1513,7 +1513,8 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
 	verbose(env, "\n");
-	mark_verifier_state_clean(env);
+	if (!print_all)
+		mark_verifier_state_clean(env);
 }
 
 static inline u32 vlog_alignment(u32 pos)
@@ -13911,6 +13912,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
 					       *insn_idx))
 			return -EFAULT;
+		if (env->log.level & BPF_LOG_LEVEL)
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
 		*insn_idx += insn->off;
 		return 0;
 	} else if (pred == 0) {
@@ -13923,6 +13926,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 					       *insn_idx + insn->off + 1,
 					       *insn_idx))
 			return -EFAULT;
+		if (env->log.level & BPF_LOG_LEVEL)
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
 		return 0;
 	}
 
-- 
2.42.0


