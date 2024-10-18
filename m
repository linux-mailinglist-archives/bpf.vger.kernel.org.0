Return-Path: <bpf+bounces-42355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA939A3261
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 04:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30A4282C60
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 02:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266C8126C0F;
	Fri, 18 Oct 2024 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFhY/NeF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763F77102
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217019; cv=none; b=psB6s4oIlwSYVd8IO4tvD+xDgJNOWwRfcHfYvVDBXE/sDxe8RsaaKUI9YyNpCCtNplbLe0fHpZWb2/oNUmDZY3iiGyJTptjSg1oVaRo3JYV3ZftmE0vaUxs9Ddrp1O2HR5MtNGKLvNAzosn25Rxs11MKz84U7xYrG7rACS5xPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217019; c=relaxed/simple;
	bh=9ZKr7571ou1ALsL1SkO1LyXU+FSr2HZ0/pQWGz73Rak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzQBYrR42+3B9S+Dx9UGYXmjHQbqr2TBcx3mh3ACeaZHf9R9fscL0DC0tFPLe6ODdCX/0x4jPULSIaInvyd0D0k94VnWifA4LHb2dJCIxDbFLh6NbSZ/Zb4O87y1dgAcWJtSUTfLp8TX5IvQLeg1e7VZZFizDAL+dhnbXcTYKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFhY/NeF; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d431b0ae2so1510597e0c.1
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729217016; x=1729821816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qadj/PoxGY9jPkk3rNveWX3RfIa4v+WszePvR5KBCSw=;
        b=UFhY/NeFJ3j3qGvDiK9kZNAeWEOtx/KLHQgzh06veauzZJog52kWOj97Wwd2R+9WXk
         NTqLum7NZc3etKDDC/snAsn6qDwYD9guU41tJhG9Rm2fQYUTwu364+AZ8y1WC+NnQi+p
         bKl14tn16js2SsS6y+Ss3J79OSrq5fHmS6JMn1wlCUsmbhM1qF4bfjimK5khNUcD7g46
         HdKpckz3O0oaZ7HwE+3RiCRahlNGvxQuZIYEBh0X9AzfSmlMsWDwczJdL3mPn/YHSWcY
         kjKIwe8QGvs5q2694/MFlKOQnNtffY1kXIufpICHqBAYeb2QkthlcvlkKyPnjMnbebHp
         PnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729217016; x=1729821816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qadj/PoxGY9jPkk3rNveWX3RfIa4v+WszePvR5KBCSw=;
        b=wkurSlPuDNhLDJT985HATTe8cKxOLNsqsr1VkElhHOCwnM6O1cUaepU0e3Yx+FEBgS
         dosCgDMAzRtytA9KKfPq9ffjuzITv4C+EIKGXwFdjJgt8/iNd/PPiEJGHvU54YIaLJiI
         tdDz6zE4oyrZq2DBHLgn5Z/BubI8LOdZYgdb8O/AVidDTA5N6lVfFrm7dP7OoWv5+3lS
         Lqxv1aUSRsRhpBUQ9cHBvm8kl9OivQWaw2Ief70SSaqeVvrwL5dbdz5d+5GD1LxCNa+K
         dQoEQeZZhc3H0uFPr+ucl0TVCia3w+bsVIhN+4sNRjWQpCCug411+9+vndPai4BPfVlm
         Szbw==
X-Gm-Message-State: AOJu0YxXmlPqW/61vCHb675qMeMBC0rgBakP9meJ9xlZ1PgWaCrPH9aM
	kKZsm3ILf4zlk3tcJGkneM7WAbEyHtlEKYcPG+jF9wCflKWxQRdrArwb9w==
X-Google-Smtp-Source: AGHT+IHClEgOjdEDFnkni3lBrfkoFkl2cNd4pWlmbhpEgSG5N3yb+TJvcbvq2+hVAfIaeVyIVE1hmQ==
X-Received: by 2002:a17:903:185:b0:20b:831f:e8f7 with SMTP id d9443c01a7336-20d474225f4mr83025235ad.11.1729217001065;
        Thu, 17 Oct 2024 19:03:21 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a915348sm2781285ad.283.2024.10.17.19.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:03:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history is too long
Date: Thu, 17 Oct 2024 19:03:06 -0700
Message-ID: <20241018020307.1766906-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.2
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

The program is a simplified reproducer from syzbot report [1].
Previous discussion could be found at [2].
The patch does not cause any changes in verification performance,
when tested on selftests from veristat.cfg and cilium programs taken
from [3].

[1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.com/
[2] https://lore.kernel.org/bpf/20241009021254.2805446-1-eddyz87@gmail.com/
[3] https://github.com/anakryiko/cilium

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f514247ba8ba..f64c831a9278 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17873,13 +17873,23 @@ static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf
 	return false;
 }
 
+#define MAX_JMPS_PER_STATE 20
+
 static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl, **pprev;
 	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
 	int i, j, n, err, states_cnt = 0;
-	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
+	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
+			       /* - Long jmp history hinders mark_chain_precision performance,
+				*   so force new state if jmp history of current state exceeds
+				*   a threshold.
+				* - Jmp history records not only jumps, but also stack access,
+				*   so keep this constant 2x times the limit imposed on
+				*   env->jmps_processed for loop cases (see skip_inf_loop_check).
+				*/
+			       cur->jmp_history_cnt > MAX_JMPS_PER_STATE * 2;
 	bool add_new_state = force_new_state;
 	bool force_exact;
 
@@ -18023,7 +18033,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 */
 skip_inf_loop_check:
 			if (!force_new_state &&
-			    env->jmps_processed - env->prev_jmps_processed < 20 &&
+			    env->jmps_processed - env->prev_jmps_processed < MAX_JMPS_PER_STATE &&
 			    env->insn_processed - env->prev_insn_processed < 100)
 				add_new_state = false;
 			goto miss;
-- 
2.46.2


