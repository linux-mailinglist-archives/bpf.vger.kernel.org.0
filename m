Return-Path: <bpf+bounces-53874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99AFA5D4AA
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 04:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6642178B76
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 03:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB03E19CCFA;
	Wed, 12 Mar 2025 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjlp8zkN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025F19938D
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741749248; cv=none; b=s8TnjgArnFxsxN4CwlY+QnFLqgDLbx5zkIrkgEwz1Ek95lIW3eru7G1F4mGUgpVfz/ojIe/X05fda827433INKfKG/Okqz5ijmgvOKdUWANarSnFJcPcZXWiDIg6NlDL9PRf/YYw1dbDWuDGY6+kjj9gxl4jGP6aX5rLxzXleFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741749248; c=relaxed/simple;
	bh=Dqyxfw3RYzt3IwQD0BDLwlJossxxCChPjHU7TGhd51w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxfrrW1rEt1A5zp7JwOmb0TVzINOJuuBCV984nhGHr1IRa8J1LvGky/s4T9dczzltyz/LvyDSf7ch1/4cwSGp8WyvrcBHm0RmB7y5LevgaAfUnnriqT73pY29yshAC3D3rgJSAqd7yQsvK5oUjfqLbO7aFx6uaTWBL6bXziGIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjlp8zkN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225477548e1so69599745ad.0
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741749245; x=1742354045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDED2Fsi3BUnRinyGfiW7Uq8OzW0WzAcDT4aI0KOiBk=;
        b=Gjlp8zkNxuXjaEcF+lOQTq3l1M/1tbYdkWsU/dxxAZnhmKL/hZC+6TQyXC86I8nPhl
         7M1uby96Hul2Gko6IZQPUuvPuUkNkCG2VxEv5xhosf9CPHj14MF+BdvpfH06Rl3ACd5S
         bEKXGyUGsNfaE7ShU8rQfireN+2zdysiOJ1WPg+qfXdZB9YgfcbMhEOu85h55O9SNd2+
         UQQabCuDvnJ0ZRIG+5FI9Ap87ZI20EcVVD0OG9duvjZerNEGhQJXtOBpAyFa1bgcLMgI
         wUmbEUiPDf8rIBCqz7ROfxEPwdlwvEnH0NGM+E4UtacDAMZQMjXMMlMuDiMY4DycrJFE
         PvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741749245; x=1742354045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDED2Fsi3BUnRinyGfiW7Uq8OzW0WzAcDT4aI0KOiBk=;
        b=vdNIuE10qFUGJYmw1OuHNNGyDRgblVMJaNxkQ6pfN5a0lDCUX68BmGNL/jbqICV3mE
         8IfEiKeI6J5tKbuCtODJy5bVWiwDlds22x8IMYIpFrdoOYCtvt1SA0J5eawB/hTmLyBw
         UVpY/ULDm01G526xXS5XCs6AT5dsRrxdWophUuenzCU1XiVsU1m7kTlcYEUr46aC2n78
         NOMasPWDFpVqCSeUaAuyqH/OHvI/KExN8yH8e8t4XjmxTqWbNCmgQiPc5CatQLXzyOQA
         4ziryHqWIEkzYKVVncE62UP1gbWM1nhJNnnIpxXEkphRiGl9QrSCZ2s6CyYxtrnBGYS7
         aVwA==
X-Gm-Message-State: AOJu0Yyeztc1M/hzP6it5yQvhGQu6KQguYipOg2+6sVd0s+J6AXq4hgb
	aQTFvt56wQ1ysX6dcyJz3jzHrfgS/amMyr/o1XMTde10d4MxFwzOVKDVYw==
X-Gm-Gg: ASbGncvTj6pjwPx6h8a7GlM+QmSB974+3SxlTcsA+ze3lIDiBP2Pvtko+vwaJp28e0+
	RxEMYqItplN8GsYzcpDxv6W9ngrVNZwEQxv8/Zh5qimNOw+cLwmbXYRAX0BbOT7YNifnGU0StZ5
	Z3kZGCy/e620moBvCjzF/+/TfvgolX+oqOK8fr0fCDiVB9XWNZcdhLAEziZjM3ON8VW2JubXonn
	A8NmchrgabTB6QvNiahOlg5RclktxBEevDwD/uTtrJgv8mMPM+tDxEGseQ27wkx8ANk1pxi906J
	DieqVH4Nonc4ggLM5zlI6akNyc7J2ZDg25Mo+qWJ
X-Google-Smtp-Source: AGHT+IHp8f7gtqWHozvYsJmfM/+amBL34gf020bs8AdTrRIkyrQOywoj70AuZ9VulOkAb5TlANQ5Qg==
X-Received: by 2002:a17:902:f648:b0:220:d601:a704 with SMTP id d9443c01a7336-22428a967a4mr279115865ad.18.1741749244899;
        Tue, 11 Mar 2025 20:14:04 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a8209esm105925075ad.129.2025.03.11.20.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 20:14:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: states with loop entry have incomplete read/precision marks
Date: Tue, 11 Mar 2025 20:13:43 -0700
Message-ID: <20250312031344.3735498-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppose the verifier state exploration graph looks as follows:

    .-> A --.    Suppose:
    |   |   |    - state A is at iterator 'next';
    |   v   v    - path A -> B -> A is verified first;
    '-- B   C    - path A -> C is verified next;
                 - B does not impose a read mark for register R1;
                 - C imposes a read mark for register R1;

Under such conditions:
- when B is explored and A is identified as its loop entry, the read
  marks are copied from A to B by propagate_liveness(), but these
  marks do not include R1;
- when C is explored, the read mark for R1 is propagated to A,
  but not to B.
- at this point, state A has its branch count at zero, but state
  B has incomplete read marks.

The same logic applies to precision marks.
This means that states with a loop entry can have incomplete read and
precision marks, regardless of whether the loop entry itself has
branches.

The current verification logic does not account for this. An example
of an unsafe program accepted by the verifier is the selftest included
in the next patch.

Fix this by removing bpf_verifier_state->branches checks for loop
entries in clean_live_states() and is_state_visited().

Verification performance impact for selftests and sched_ext:

========= selftests: master vs patch =========

File                                Program            States (A)  States (B)  States (DIFF)
----------------------------------  -----------------  ----------  ----------  -------------
iters.bpf.o                         clean_live_states          66          67    +1 (+1.52%)
verifier_iterating_callbacks.bpf.o  cond_break2                10          13   +3 (+30.00%)

Total progs: 3579
Old success: 2061
New success: 2061
States diff min:    0.00%
States diff max:   30.00%
   0 .. 5    %: 3578
  30 .. 35   %: 1

========= sched_ext: master vs patch =========

File            Program           States (A)  States (B)  States (DIFF)
--------------  ----------------  ----------  ----------  -------------
bpf.bpf.o       layered_dispatch         501         516   +15 (+2.99%)
bpf.bpf.o       layered_dump             237         252   +15 (+6.33%)
bpf.bpf.o       layered_init             423         432    +9 (+2.13%)
bpf.bpf.o       p2dq_init                142         144    +2 (+1.41%)
scx_pair.bpf.o  pair_dispatch            111         138  +27 (+24.32%)
scx_qmap.bpf.o  qmap_dump                 22          30   +8 (+36.36%)
scx_qmap.bpf.o  qmap_init                654         656    +2 (+0.31%)

Total progs: 216
Old success: 186
New success: 186
States diff min:    0.00%
States diff max:   36.36%
   0 .. 5    %: 213
   5 .. 15   %: 1
  20 .. 30   %: 1
  35 .. 40   %: 1

Fixes: 2a0992829ea3 ("bpf: correct loop detection for iterators convergence")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3303a3605ee8..6c18628fa9d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18111,7 +18111,7 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 		if (sl->state.branches)
 			continue;
 		loop_entry = get_loop_entry(env, &sl->state);
-		if (!IS_ERR_OR_NULL(loop_entry) && loop_entry->branches)
+		if (!IS_ERR_OR_NULL(loop_entry))
 			continue;
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
@@ -18816,7 +18816,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
 	int i, j, n, err, states_cnt = 0;
-	bool force_new_state, add_new_state, force_exact;
+	bool force_new_state, add_new_state;
 	struct list_head *pos, *tmp, *head;
 
 	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
@@ -18996,9 +18996,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		loop_entry = get_loop_entry(env, &sl->state);
 		if (IS_ERR(loop_entry))
 			return PTR_ERR(loop_entry);
-		force_exact = loop_entry && loop_entry->branches > 0;
-		if (states_equal(env, &sl->state, cur, force_exact ? RANGE_WITHIN : NOT_EXACT)) {
-			if (force_exact)
+		if (states_equal(env, &sl->state, cur, loop_entry ? RANGE_WITHIN : NOT_EXACT)) {
+			if (loop_entry)
 				update_loop_entry(env, cur, loop_entry);
 hit:
 			sl->hit_cnt++;
-- 
2.48.1


