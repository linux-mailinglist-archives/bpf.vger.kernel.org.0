Return-Path: <bpf+bounces-49472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCB3A1911A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A21888753
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6840212B26;
	Wed, 22 Jan 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYcKsw1A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B45212B07
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547505; cv=none; b=NfoqKZw6TMmhRQ1QCFjwAa+Sc65f/ufdfTE6PiuQjCRpRdmsf/LT+LL9VQ3lzYVXdTZPYsjK+pwpSZIMhbnWlH7dhiCq9CXAzbzI5xRx16SnMfdl4wPyEFGVQU043bIKeEx/pLT8ho8Vz1eJCVM0/izD/g05rDuNtt4rarJ0QGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547505; c=relaxed/simple;
	bh=FQ/lQu77KXi9PFSk4G0j0T9pJCUkHBi+terX+pGUIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fbo3MRX/VI51uWomQpm53obhtYxqabA1X0NIby9XuOE3oxAb/+v2TrzdwvCKqcAR/Ly08Mho6p4JWox8DhgRc0/LoSYF5HlT0v/cW8ZUMrfQ3Vuak4GVN5lzZ6j4hMT8KuaZ4avhG2Vm1hUiSwKYZOiI/RNS8tcYU9zG1D7ia6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYcKsw1A; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2162c0f6a39so14258975ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 04:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737547502; x=1738152302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEfktsTz8lBKgBrczz+acAgFgdtAgvpRqhJLsD4UUVo=;
        b=cYcKsw1ARfHGkEj/Bk3WRo5NkYdCBL/GRfYa+Y16f0xHVyDyAgfRx1vDgtDdHoygc0
         gls4OmRDWrbWpkCWrTSbuU+LCeQWzfbhUqe7k+a66qlj1bWJBQvFlJqUw0CUe6c/poDh
         DBPAWyAVY3CxKcg1ORj36PU+Oq2CRi8pPaBCHjQiZezGMpUw35dn7c+Vyygzsf5n9qGU
         nEaw7e7owXJmN4wBfy31+0A9jzciyp/XVZv6J1ULgKr/LsNFjOunEsEJGsPOIqRuD/J9
         4/Q0CNLbHriywwKSBPGb0gdfhFNdL2dXdyDza8/v1ds+0GJ311bRPBO0XhpBSYfksb9f
         0D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547502; x=1738152302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEfktsTz8lBKgBrczz+acAgFgdtAgvpRqhJLsD4UUVo=;
        b=cC+oCjEqTS6Xr2stPHiMMhDa5ENerB97vLSsk+pAh6h7KbgQyB7gf7R62w+pOjLpIr
         CNeUr6YUHWSLQLR5np7XDVwqgQ/3cOWK8T6gHWe44bAXpXmxnzllB2uhu47skEQCZYUd
         /omhSerif/7YIzoM3LJwutzpf1GIIIqCjh63aqKEvhdeTmCzeVCvSX6mYzBoFzTQNise
         ymHBCmZ4IdykVQPwZsvQHCnsUgl7tkALgt7s0wpcCJZeOA/127cnwBf+fDOWjkiD6jUP
         1yLxsvqymDKW9vag8rzb6aqHLT2NfSrm8gnNR91L1etOJZ/DdUxV4xYzP/8zH1k5EWP4
         fBAg==
X-Gm-Message-State: AOJu0Yxu4a+nzucHDg+5vYQldawahjUgh+cbsSmRhZgIRZDGOeffiDMj
	b++t4fxjXFxWwK2wUqCeMFXPJlD1d53lShQVJ1ycn2b1Hmljgy/KezG61g==
X-Gm-Gg: ASbGncsO+gqnSUEbnx1RBSrucQ7yGBDFBGYC2UIfrFcVG8NJySAQQmv/6rXr1Jer2xf
	/n3i35mVUJvKe9Dj2y7AnHVmAOH0PsdVKMlYKmmJ6wyj8BSWY51NC2Xg1YRIG7HHNPGwlqswN0f
	POrgOAAzed+R1SMxyvBfuOmUB0PtTKAzurAaPTU33S4ohBSd45WZb0jxSmMGq7MN6e1RiqtC+7w
	H+Jc30IQzWMg/cT7JjV7qrgxxKakHn8ZXNQB2dty7QU/zVK/GgG+jgi604EEDiK1w==
X-Google-Smtp-Source: AGHT+IGjlfBfl3sMDHube0HR6woo6cHj6KuMEXa6BWfzbmQVgpmC6JLj/j+Bs21ZMOBy140/O9Eaog==
X-Received: by 2002:a05:6a20:2453:b0:1e0:d3e9:1f8 with SMTP id adf61e73a8af0-1eb216294admr29387428637.10.1737547502512;
        Wed, 22 Jan 2025 04:05:02 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm11055732b3a.66.2025.01.22.04.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:05:01 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 2/7] selftests/bpf: test correct loop_entry update in copy_verifier_state
Date: Wed, 22 Jan 2025 04:04:37 -0800
Message-ID: <20250122120442.3536298-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122120442.3536298-1-eddyz87@gmail.com>
References: <20250122120442.3536298-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A somewhat cumbersome test case sensitive to correct copying of
bpf_verifier_state->loop_entry fields in
verifier.c:copy_verifier_state().
W/o the fix from a previous commit the program is accepted as safe.

     1:  /* poison block */
     2:  if (random() != 24) {       // assume false branch is placed first
     3:    i = iter_new();
     4:    while (iter_next(i));
     5:    iter_destroy(i);
     6:    return;
     7:  }
     8:
     9:  /* dfs_depth block */
    10:  for (i = 10; i > 0; i--);
    11:
    12:  /* main block */
    13:  i = iter_new();             // fp[-16]
    14:  b = -24;                    // r8
    15:  for (;;) {
    16:    if (iter_next(i))
    17:      break;
    18:    if (random() == 77) {     // assume false branch is placed first
    19:      *(u64 *)(r10 + b) = 7;  // this is not safe when b == -25
    20:      iter_destroy(i);
    21:      return;
    22:    }
    23:    if (random() == 42) {     // assume false branch is placed first
    24:      b = -25;
    25:    }
    26:  }
    27:  iter_destroy(i);

The goal of this example is to:
(a) poison env->cur_state->loop_entry with a state S,
    such that S->branches == 0;
(b) set state S as a loop_entry for all checkpoints in
    /* main block */, thus forcing NOT_EXACT states comparisons;
(c) exploit incorrect loop_entry set for checkpoint at line 18
    by first creating a checkpoint with b == -24 and then
    pruning the state with b == -25 using that checkpoint.

The /* poison block */ is responsible for goal (a).
It forces verifier to first validate some unrelated iterator based
loop, which leads to an update_loop_entry() call in is_state_visited(),
which places checkpoint created at line 4 as env->cur_state->loop_entry.
Starting from line 8, the branch count for that checkpoint is 0.

The /* dfs_depth block */ is responsible for goal (b).
It abuses the fact that update_loop_entry(cur, hdr) only updates
cur->loop_entry when hdr->dfs_depth <= cur->dfs_depth.
After line 12 every state has dfs_depth bigger then dfs_depth of
poisoned env->cur_state->loop_entry. Thus the above condition is never
true for lines 12-27.

The /* main block */ is responsible for goal (c).
Verification proceeds as follows:
- checkpoint {b=-24,i=active} created at line 16;
- jump 18->23 is verified first, jump to 19 pushed to stack;
- jump 23->26 is verified first, jump to 24 pushed to stack;
- checkpoint {b=-24,i=active} created at line 15;
- current state is pruned by checkpoint created at line 16,
  this sets branches count for checkpoint at line 15 to 0;
- jump to 24 is popped from stack;
- line 16 is reached in state {b=-25,i=active};
- this is pruned by a previous checkpoint {b=-24,i=active}:
  - checkpoint's loop_entry is poisoned and has branch count of 0,
    hence states are compared using NOT_EXACT rules;
  - b is not marked precise yet.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 116 ++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 190822b2f08b..007831dc8c46 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1174,6 +1174,122 @@ __naked int loop_state_deps2(void)
 	);
 }
 
+SEC("?raw_tp")
+__failure
+__msg("math between fp pointer and register with unbounded")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked int loop_state_deps3(void)
+{
+	/* This is equivalent to a C program below.
+	 *
+	 *   if (random() != 24) {       // assume false branch is placed first
+	 *     i = iter_new();           // fp[-8]
+	 *     while (iter_next(i));
+	 *     iter_destroy(i);
+	 *     return;
+	 *   }
+	 *
+	 *   for (i = 10; i > 0; i--);   // increase dfs_depth for child states
+	 *
+	 *   i = iter_new();             // fp[-8]
+	 *   b = -24;                    // r8
+	 *   for (;;) {                  // checkpoint (L)
+	 *     if (iter_next(i))         // checkpoint (N)
+	 *       break;
+	 *     if (random() == 77) {     // assume false branch is placed first
+	 *       *(u64 *)(r10 + b) = 7;  // this is not safe when b == -25
+	 *       iter_destroy(i);
+	 *       return;
+	 *     }
+	 *     if (random() == 42) {     // assume false branch is placed first
+	 *       b = -25;
+	 *     }
+	 *   }
+	 *   iter_destroy(i);
+	 *
+	 * In case of a buggy verifier first loop might poison
+	 * env->cur_state->loop_entry with a state having 0 branches
+	 * and small dfs_depth. This would trigger NOT_EXACT states
+	 * comparison for some states within second loop.
+	 * Specifically, checkpoint (L) might be problematic if:
+	 * - branch with '*(u64 *)(r10 + b) = 7' is not explored yet;
+	 * - checkpoint (L) is first reached in state {b=-24};
+	 * - traversal is pruned at checkpoint (N) setting checkpoint's (L)
+	 *   branch count to 0, thus making it eligible for use in pruning;
+	 * - checkpoint (L) is next reached in state {b=-25},
+	 *   this would cause NOT_EXACT comparison with a state {b=-24}
+	 *   while 'b' is not marked precise yet.
+	 */
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == 24 goto 2f;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 5;"
+		"call %[bpf_iter_num_new];"
+	"1:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 != 0 goto 1b;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+	"2:"
+		/* loop to increase dfs_depth */
+		"r0 = 10;"
+	"3:"
+		"r0 -= 1;"
+		"if r0 != 0 goto 3b;"
+		/* end of loop */
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r8 = -24;"
+	"main_loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto main_loop_end_%=;"
+		/* first if */
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == 77 goto unsafe_write_%=;"
+		/* second if */
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == 42 goto poison_r8_%=;"
+		/* iterate */
+		"goto main_loop_%=;"
+	"main_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+
+	"unsafe_write_%=:"
+		"r0 = r10;"
+		"r0 += r8;"
+		"r1 = 7;"
+		"*(u64 *)(r0 + 0) = r1;"
+		"goto main_loop_end_%=;"
+
+	"poison_r8_%=:"
+		"r8 = -25;"
+		"goto main_loop_%=;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_all
+	);
+}
+
 SEC("?raw_tp")
 __success
 __naked int triple_continue(void)
-- 
2.47.1


