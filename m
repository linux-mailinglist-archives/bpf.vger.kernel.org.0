Return-Path: <bpf+bounces-53875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43482A5D4AB
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 04:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C35178C00
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC22F24;
	Wed, 12 Mar 2025 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHEYumef"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A1198E8C
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741749249; cv=none; b=hjLzK20lu+vktH2TNc/u6iCDj7BHTXbgIJsWAB1cfTQ0aYEal4kWcMnJ4UiVegh9aoYwkIUyVN6F7nTMv3Pr+Wkm7/vpaW/mHm3aXUj5cIxaNALzmfuTcggKUTTddpVr0R04ccixKHw7jPBl5PL6ZQgLGstf8avoCQSfsngrnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741749249; c=relaxed/simple;
	bh=O/Uh9Gy2/VGaXjZDBOgxjjlvUz2Qq+Boe6rN1lQoQ78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBStOpM7mWKs3HUkaqWvdkQ3uXhbojdJ7IuWlLrdZgxh1HlVIEC5aF4psvy/uW2GONN+487UOiKMq80QXRJGaDDzm2e1fdEAlWD063Fba1vccPoCFuC6DyIdObTLxEbBDSTKckEAlrRnCTqbiF4tBHDUoJUCM/IsV9Xsl5r0XHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHEYumef; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22403cbb47fso120313975ad.0
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 20:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741749246; x=1742354046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TekBw0GJlYtIZOWK1vHwYMscRmXHGzG8jXqpio+DjU=;
        b=UHEYumefR6Nib5tEazViTRLmlzrx3+Q2L1OZM72JKi4EEsnp7p05T2PoGaxs0XaMiv
         oJ1mVKvkVZTkPK/9mS2VfMSSl9kqA75KIgk551ShHndBfiutPMVKQcBGK94hy3xGr5Hp
         PCTN5j56zRrqLZEw1CSJk9UjowPkltIv0Nn6+OiKl9sp9ZKAOzPgLxtAl+jdhsBwiGvJ
         BPlonqozro+yP40jAJNs5Qa3K5Ull7av2j8EA3wxIMmikU5yiMmVOLJnyzhpX0cLpEGk
         AHPF3+L5woWeTmdA1Ca7mbo/g70uCgzxJeSi8ZKKOaL7gRd4WOBzh7Iij5fmdzGJeGzE
         qfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741749246; x=1742354046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TekBw0GJlYtIZOWK1vHwYMscRmXHGzG8jXqpio+DjU=;
        b=VNVwOSH1pM8iXqeK1f10JDCYzVD7z3/cxensNVZ0a1+vo+zGRLBzTp78hsGUvzXbGS
         KmjeZPeNKiN8RU1t06MZ4hBkArrs2LpkXPhCYcJA+ior2xWoW4BsI8INW2XGMfL+Wmjy
         B/P+p/y+iuOQwR027kuYtZ3dSnH8wHZchyyHnsQn0jNWz9skZuEva1YvqM8+QfmCPplM
         TgjM5Zx1Bw0xudOvuWRSxoZ7HI+ybgGuTEBQSLiA/MVLoYpK8/aACEFtSff2URbNJPqI
         fJbFuhDW+47fqkv9yCgzYYw41JNsqVyQKmcbJPHimCXjrOvpLRK5FlhJYIfAwnPlKr27
         LFog==
X-Gm-Message-State: AOJu0YwiRZ5c7KoGyM8Uq9RSlQK6GRpEYYNBARM/k1aX6LzLkIrMws95
	JicbbDLI8zHK9Mlp32biqD2Dbj3JcH5fnssMiivo/iJCPMkbzFlbBO6YuQ==
X-Gm-Gg: ASbGnctKSOQeMa1UTroqC9tmAanuLq1yMPa3MNyJS6utOFne9ivcaVkbl1rKHULHz6M
	FBQlJp/mM70Y9Orf6JQqPI7R3pczSHnKBvtLhRwm6D4RaTTSrLJ9ekfhTmRRK/ZPaX1glMvMxVw
	uQkX7G2Eae6E5zps/qqvjNpS/TL7aMp2nKp2tWj0S8XuFwj6mRCg7IdvbIYrP5kE/A2T2JN+TjF
	XZ7MZ4ktVBU44iKVoCsrkkw9T3NDfveRXmT12l5EOtURaj2mszV2HCE+pYfd/GuCca3lhaOAOwR
	hiqU1fw6I6IZG9ZdFk/kdhYBwz8m0b6umAhRuR/+
X-Google-Smtp-Source: AGHT+IG7VvWo39AgubC4YBaWilnjNKMaaVEoI3VNW1Ad588GNF9QE9ReAN5kiOtwQLPU11Oc5UdStQ==
X-Received: by 2002:a17:902:e750:b0:223:4bd6:3863 with SMTP id d9443c01a7336-2242887eda6mr306632075ad.10.1741749245729;
        Tue, 11 Mar 2025 20:14:05 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a8209esm105925075ad.129.2025.03.11.20.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 20:14:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: test case with missing read/precision mark
Date: Tue, 11 Mar 2025 20:13:44 -0700
Message-ID: <20250312031344.3735498-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312031344.3735498-1-eddyz87@gmail.com>
References: <20250312031344.3735498-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case is equivalent of the following C program:

   1: r8 = bpf_get_prandom_u32();
   2: r6 = -32;
   3: bpf_iter_num_new(&fp[-8], 0, 10);
   4: if (unlikely(bpf_get_prandom_u32()))
   5:   r6 = -31;
   6: for (;;) {
   7:   if (!bpf_iter_num_next(&fp[-8]))
   8:     break;
   9:   if (unlikely(bpf_get_prandom_u32()))
  10:     *(u64 *)(fp + r6) = 7;
  11: }
  12: bpf_iter_num_destroy(&fp[-8]);
  13: return 0;

W/o a fix that instructs verifier to ignore branches count for loop
entries verification proceeds as follows:
- 1-4, state is {r6=-32,fp-8=active};
- 6, checkpoint A is created with {r6=-32,fp-8=active};
- 7, checkpoint B is created with {r6=-32,fp-8=active},
     push state {r6=-32,fp-8=active} from 7 to 9;
- 8,12,13, {r6=-32,fp-8=drained}, exit;
- pop state with {r6=-32,fp-8=active} from 7 to 9;
- 9, push state {r6=-32,fp-8=active} from 9 to 10;
- 6, checkpoint C is created with {r6=-32,fp-8=active};
- 7, checkpoint A is hit, no precision or propagated for r6 to C;
- pop state {r6=-32,fp-8=active} from 9 to 10;
- 10, state is {r6=-31,fp-8=active}, r6 is marked as read and precise,
      these marks are propagated to checkpoints A and B (but not C, as
      it is not the parent of current state;
- 6, {r6=-31,fp-8=active} checkpoint C is hit, because r6 is not
     marked precise for this checkpoint;
- the program is accepted, despite a possibility of unaligned u64
  stack access at offset -31.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 65 +++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 427b72954b87..ffb574321404 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1651,4 +1651,69 @@ int clean_live_states(const void *ctx)
 	return 0;
 }
 
+SEC("?raw_tp")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("misaligned stack access off 0+-31+0 size 8")
+__naked int absent_mark_in_the_middle_state(void)
+{
+	/* This is equivalent to C program below.
+	 *
+	 * r8 = bpf_get_prandom_u32();
+	 * r6 = -32;
+	 * bpf_iter_num_new(&fp[-8], 0, 10);
+	 * if (unlikely(bpf_get_prandom_u32()))
+	 *   r6 = -31;
+	 * while (bpf_iter_num_next(&fp[-8])) {
+	 *   if (unlikely(bpf_get_prandom_u32()))
+	 *     *(fp + r6) = 7;
+	 * }
+	 * bpf_iter_num_destroy(&fp[-8])
+	 * return 0
+	 */
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r8 = r0;"
+		"r7 = 0;"
+		"r6 = -32;"
+		"r0 = 0;"
+		"*(u64 *)(r10 - 16) = r0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto change_r6_%=;"
+	"loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto loop_end_%=;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto use_r6_%=;"
+		"goto loop_%=;"
+	"loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+	"use_r6_%=:"
+		"r0 = r10;"
+		"r0 += r6;"
+		"r1 = 7;"
+		"*(u64 *)(r0 + 0) = r1;"
+		"goto loop_%=;"
+	"change_r6_%=:"
+		"r6 = -31;"
+		"goto loop_%=;"
+		:
+		: __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.48.1


