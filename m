Return-Path: <bpf+bounces-51649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D8A36D8E
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896D37A4441
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD71A5BB8;
	Sat, 15 Feb 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk90MTKB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2E1A2388
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617473; cv=none; b=h5P85IxLnAAI9kyyxjLbW94uJN3j6PM1mhlDFMLkQ/6Nug62cXNV61eFQILF06AwAwOgk11l3eX3t4LNFdlSCD0rE7tYBQ8hnxpgJZhfOCDqGq1jFxxf7oYITcFkPUq9z3GZFAnaPHkTUt063z32tS1sqMzD21Ctr3+CtXiZ4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617473; c=relaxed/simple;
	bh=wGgISqWd8P9mdDG2yI3hvKfXyLCQ3oDwMXj4bjXEjIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTbw1ikEecJhf1TAobXztWWCqVOeB3D9fICT2A2HC7yLCXlmDs7E3Wx9RWI6HwMkCyyjkymAMEEAApm1T1rUzY2LaKSZNg+UhkZw8m3JvlJGCW5Dwy4/eV27QMb++/zdUZOUJw2PUpeh/Txuh8TNh03BdmiA0xzticjScgOyqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk90MTKB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220ecbdb4c2so45342425ad.3
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617470; x=1740222270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GOCH4mEvoqZ0DCMEaS+DNrb1EkjOaHoe0Dctn/XG64=;
        b=Pk90MTKBkWNZcSNHOY1EpM6CUkTi9nUpi4+rM7FxHMlehCL9xswAOPiXa3NhijQW81
         06xn5kSXd7DAkV1GMVkSKvADfvO+AejusC/XXGzu/9VkarcHarP5MSQ0Z87/zMHO17+s
         YeVzWfkRdLjJT75Ve5ItBEeiB2oG4Zawq2b5G60w8UE5Uz+F8qI7YPbqRtZ6mV2+qANg
         Vw1A180d06fDdEb0Tjh79MRP29vp5bXBpR9U4RIDS5+/wdvXddcFb5/BCbRoSsGPrVpd
         DcKwH2OZmDrtlYdQj2ynt7qbZqrj/+SHyKAo7ElIILTsglGe32LQr6sih0YJGsqBkStW
         76tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617470; x=1740222270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GOCH4mEvoqZ0DCMEaS+DNrb1EkjOaHoe0Dctn/XG64=;
        b=TeBTL3dhWPafwp8t1rQ1LidglVkmT6nldPs5V4M3pKLKhAldKN0j7WGrJy7kIppkjl
         7JquyzPLSQ4V1LqlEuxH4cwcDXQQLtEXrbGYNpFQl7b3sj5r1jYYA6ajk6f79BhO8gwA
         hDmGStCVcPwnaVgvHKtrLZRsxpDHXTkpIeMBK+63N2bEp5OCnlkTeQx+MZ6jKvIEWprO
         X+r662DN858T7E2nPia1+LeKwsM2QIRvFyw9VFkpkNFn+SQpOWpSQsORSfWnoZxbYht/
         LT+nf/vyAEVs0rBCr5N1tawwqDHXLmynhNP9zRy+EYEvNqAzq3JlMwUf5jopBPlPyuNP
         inYw==
X-Gm-Message-State: AOJu0YxWowWUDAnf0ktK0lxZjAZcIxA9kY8OHwgRZZsbfkU+ofHV8iL8
	TWu6A/ElRolMF38EegBt2pW6o5CZqRQMZySU2VUHsKXNuSpdFY3D9/cnVw==
X-Gm-Gg: ASbGncvhWiHlDSNzkDsYEPOjHA1L+Joo2C72EGPFTH8M7M8/QnFo3hX3ckSgN3C5viN
	QbVliuwdlqLVtdBGdxO1KxAuMFcImiexh6cjo8rYB9hryX6Zm0Px3R0Rz3jbBm1B1m1gJMV6b+p
	2d+QN3cuS1dsYc6JOAnhP4Jiq632o//CUMGgnXlOWEO11osPZR17tbpKH5XTgbr+QFXH9Oxv1yt
	a9NVQ6rX5LB9nvPAXTOvugFxTgdcqpkGQIoPCZbExsIJ7mOJai38jGdtwdO87VnRaAAS8rIRGkB
	Hq6+wbAqkgw=
X-Google-Smtp-Source: AGHT+IGKADK8Dy6y0EMN7F0y6nPNzFx33FOvHf1madq5xIKdxOgXpLB5fMvn8I57zpGzIhvI+3qI6w==
X-Received: by 2002:a05:6a20:a125:b0:1db:dfc0:d342 with SMTP id adf61e73a8af0-1ee8cb0e82cmr5938379637.7.1739617470482;
        Sat, 15 Feb 2025 03:04:30 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:29 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	patsomaru@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 02/10] selftests/bpf: test correct loop_entry update in copy_verifier_state
Date: Sat, 15 Feb 2025 03:03:53 -0800
Message-ID: <20250215110411.3236773-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215110411.3236773-1-eddyz87@gmail.com>
References: <20250215110411.3236773-1-eddyz87@gmail.com>
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
2.48.1


