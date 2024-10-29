Return-Path: <bpf+bounces-43397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC79B50D0
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD4C1C20A1C
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E244E207205;
	Tue, 29 Oct 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d90qOdyG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18417204032
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222839; cv=none; b=ZaSBXlCtvHmxKk9ie6HX+7P0BXaxCF89QprG++7RFT5N0y03SAMzXDyuH6KZh5+ZNlCcat0IWtkb49cckqITeVe0WM1I+vHV1foayvnhXY2ymMDct5gbtHrQ+ruirpAoNOjOPd/i4BMyszKBTLswFLRRBHRPyMQpLg6QYqx3cfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222839; c=relaxed/simple;
	bh=PvhO2U3Zswylf68/BwkrhjleRx3mZZMzS7tstJ8QH0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdpUzPS5OgGnuxjECrwJHHGRjGy2obCSHR9AitZKPYNuFhJpK25p79+AFs93iubNY+EtXJutLsrHYK1lEvxBYcxyc0yy/dzI5dR3kM3zOAmcnX7f85wqI3RI1XPkUIggbebqY9PXtSbRoYXVI85uvvmibrN2x+LTI5ECzKUEYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d90qOdyG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b5affde14so42051525ad.3
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730222836; x=1730827636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYiwa03g1FQp2+y6EJrqhxVQdbVRyPjN6Z6mKxEsJOY=;
        b=d90qOdyGVhYZyyBgzTdn2frpcLG3nQaQTtJUnUaOrcqMYtMINuR5Pp/VWf6MgUOJH3
         JvPdngW61WmOMrSCv46gZ8/qW/gd30MM+QYOlW/Yx4pRVHalLWkCqM8rG21cp25MA9HP
         wbxWJMeUZx1MUTxBVbY64bNwHiL9AYN5g6TxaNIhEHePwSq8u5g6X2FwrFOj8MHYhruP
         AON7a1xHiPKNoEIgpKq0H0qlVPehNLE+hGxspLTnG02RhuSTXDujqqpdECsdlJWjIQqq
         VIuF8RnfmCwpfCEoIOC3ZwrAlxUR5vcVOVA/jEXM50OD8La0evLsv1vEr8vobtGRpICQ
         Nyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730222836; x=1730827636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYiwa03g1FQp2+y6EJrqhxVQdbVRyPjN6Z6mKxEsJOY=;
        b=gS+0fSb/9cKE8ulbXa/+aiHbw8oCmK3gVNd7C+iXCwBBOPgk1RrBBSHbfdNqT2/yD3
         retyMQ9JxTMDiPDhYmey0Z53M49W98p4RwAp+JrINIGbUPzEca6svHV5TpYYw4knlggR
         MLcZewR22iaRD+62uT170BJ18gGUemh/Uqq1Kq0XJQNil91aVVAMjOnpDUZR3gtTa6FD
         Prk2fKNGnTLgicak0SKDdTs6M7+/GNqEF7ZAkzF/ss4wh37qiRLII3zq4hoEWE8tBEzB
         7YN0w8B/WoXpM7IbFV4ZJtZCAyuB4TB46sqnHNN46VwNkqKrnTty0H2cJ6H0N2ZwVoox
         4CXw==
X-Gm-Message-State: AOJu0YzwkOGa6bwevVxvKlz7MaONo/Mrr3qkN5llXHRaQHwyCzOxAkoB
	oOsS+C+yzN2qEyO57VlyJkHN5vdtUvdtmUsw0SnH0yFkzUAruUbJEwqF8g==
X-Google-Smtp-Source: AGHT+IGycLKymac4OyRURUaYq7JPbSsTXBFqZGt80sqiuh55OS80f/ZQXz7UAxLagoA3LmDR+DNO3w==
X-Received: by 2002:a17:903:1205:b0:20c:7509:d948 with SMTP id d9443c01a7336-210c68973aamr154798075ad.17.1730222835781;
        Tue, 29 Oct 2024 10:27:15 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc868c043sm7855855a12.38.2024.10.29.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:27:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
Subject: [PATCH bpf v2 1/2] bpf: force checkpoint when jmp history is too long
Date: Tue, 29 Oct 2024 10:26:40 -0700
Message-ID: <20241029172641.1042523-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A specifically crafted program might trick verifier into growing very
long jump history within a single bpf_verifier_state instance.
Very long jump history makes mark_chain_precision() unreasonably slow,
especially in case if verifier processes a loop.

Mitigate this by forcing new state in is_state_visited() in case if
current state's jump history is too long.

Use same constant as in `skip_inf_loop_check`, but multiply it by
arbitrarily chosen value 2 to account for jump history containing not
only information about jumps, but also information about stack access.

For an example of problematic program consider the code below,
w/o this patch the example is processed by verifier for ~15 minutes,
before failing to allocate big-enough chunk for jmp_history.

    0: r7 = *(u16 *)(r1 +0);"
    1: r7 += 0x1ab064b9;"
    2: if r7 & 0x702000 goto 1b;
    3: r7 &= 0x1ee60e;"
    4: r7 += r1;"
    5: if r7 s> 0x37d2 goto +0;"
    6: r0 = 0;"
    7: exit;"

Perf profiling shows that most of the time is spent in
mark_chain_precision() ~95%.

The easiest way to explain why this program causes problems is to
apply the following patch:

    diff --git a/include/linux/bpf.h b/include/linux/bpf.h
    index 0c216e71cec7..4b4823961abe 100644
    \--- a/include/linux/bpf.h
    \+++ b/include/linux/bpf.h
    \@@ -1926,7 +1926,7 @@ struct bpf_array {
            };
     };

    -#define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
    +#define BPF_COMPLEXITY_LIMIT_INSNS      256 /* yes. 1M insns */
     #define MAX_TAIL_CALL_CNT 33

     /* Maximum number of loops for bpf_loop and bpf_iter_num.
    diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
    index f514247ba8ba..75e88be3bb3e 100644
    \--- a/kernel/bpf/verifier.c
    \+++ b/kernel/bpf/verifier.c
    \@@ -18024,8 +18024,13 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
     skip_inf_loop_check:
                            if (!force_new_state &&
                                env->jmps_processed - env->prev_jmps_processed < 20 &&
    -                           env->insn_processed - env->prev_insn_processed < 100)
    +                           env->insn_processed - env->prev_insn_processed < 100) {
    +                               verbose(env, "is_state_visited: suppressing checkpoint at %d, %d jmps processed, cur->jmp_history_cnt is %d\n",
    +                                       env->insn_idx,
    +                                       env->jmps_processed - env->prev_jmps_processed,
    +                                       cur->jmp_history_cnt);
                                    add_new_state = false;
    +                       }
                            goto miss;
                    }
                    /* If sl->state is a part of a loop and this loop's entry is a part of
    \@@ -18142,6 +18147,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
            if (!add_new_state)
                    return 0;

    +       verbose(env, "is_state_visited: new checkpoint at %d, resetting env->jmps_processed\n",
    +               env->insn_idx);
    +
            /* There were no equivalent states, remember the current one.
             * Technically the current state is not proven to be safe yet,
             * but it will either reach outer most bpf_exit (which means it's safe)

And observe verification log:

    ...
    is_state_visited: new checkpoint at 5, resetting env->jmps_processed
    5: R1=ctx() R7=ctx(...)
    5: (65) if r7 s> 0x37d2 goto pc+0     ; R7=ctx(...)
    6: (b7) r0 = 0                        ; R0_w=0
    7: (95) exit

    from 5 to 6: R1=ctx() R7=ctx(...) R10=fp0
    6: R1=ctx() R7=ctx(...) R10=fp0
    6: (b7) r0 = 0                        ; R0_w=0
    7: (95) exit
    is_state_visited: suppressing checkpoint at 1, 3 jmps processed, cur->jmp_history_cnt is 74

    from 2 to 1: R1=ctx() R7_w=scalar(...) R10=fp0
    1: R1=ctx() R7_w=scalar(...) R10=fp0
    1: (07) r7 += 447767737
    is_state_visited: suppressing checkpoint at 2, 3 jmps processed, cur->jmp_history_cnt is 75
    2: R7_w=scalar(...)
    2: (45) if r7 & 0x702000 goto pc-2
    ... mark_precise 152 steps for r7 ...
    2: R7_w=scalar(...)
    is_state_visited: suppressing checkpoint at 1, 4 jmps processed, cur->jmp_history_cnt is 75
    1: (07) r7 += 447767737
    is_state_visited: suppressing checkpoint at 2, 4 jmps processed, cur->jmp_history_cnt is 76
    2: R7_w=scalar(...)
    2: (45) if r7 & 0x702000 goto pc-2
    ...
    BPF program is too large. Processed 257 insn

The log output shows that checkpoint at label (1) is never created,
because it is suppressed by `skip_inf_loop_check` logic:
a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
   onto stack and proceeds to (3);
b. At (5) checkpoint is created, and this resets
   env->{jmps,insns}_processed.
c. Verification proceeds and reaches `exit`;
d. State saved at step (a) is popped from stack and is_state_visited()
   considers if checkpoint needs to be added, but because
   env->{jmps,insns}_processed had been just reset at step (b)
   the `skip_inf_loop_check` logic forces `add_new_state` to false.
e. Verifier proceeds with current state, which slowly accumulates
   more and more entries in the jump history.

The accumulation of entries in the jump history is a problem because
of two factors:
- it eventually exhausts memory available for kmalloc() allocation;
- mark_chain_precision() traverses the jump history of a state,
  meaning that if `r7` is marked precise, verifier would iterate
  ever growing jump history until parent state boundary is reached.

(note: the log also shows a REG INVARIANTS VIOLATION warning
       upon jset processing, but that's another bug to fix).

With this patch applied, the example above is rejected by verifier
under 1s of time, reaching 1M instructions limit.

The program is a simplified reproducer from syzbot report.
Previous discussion could be found at [1].
The patch does not cause any changes in verification performance,
when tested on selftests from veristat.cfg and cilium programs taken
from [2].

[1] https://lore.kernel.org/bpf/20241009021254.2805446-1-eddyz87@gmail.com/
[2] https://github.com/anakryiko/cilium

Changelog:
- v1 -> v2:
  - moved patch to bpf tree;
  - moved force_new_state variable initialization after declaration and
    shortened the comment.
v1: https://lore.kernel.org/bpf/20241018020307.1766906-1-eddyz87@gmail.com/

Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.com/
Fixes: 2589726d12a1 ("bpf: introduce bounded loops")
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 587a6c76e564..ca8d7b054163 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17886,10 +17886,14 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *sl, **pprev;
 	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
 	int i, j, n, err, states_cnt = 0;
-	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
-	bool add_new_state = force_new_state;
+	bool force_new_state;
+	bool add_new_state;
 	bool force_exact;
 
+	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
+			  /* Avoid accumulating infinitely long jmp history */
+			  cur->jmp_history_cnt > 40;
+
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
 	 * Do not add new state for future pruning if the verifier hasn't seen
@@ -17898,6 +17902,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * In tests that amounts to up to 50% reduction into total verifier
 	 * memory consumption and 20% verifier time speedup.
 	 */
+	add_new_state = force_new_state;
 	if (env->jmps_processed - env->prev_jmps_processed >= 2 &&
 	    env->insn_processed - env->prev_insn_processed >= 8)
 		add_new_state = true;
-- 
2.47.0


