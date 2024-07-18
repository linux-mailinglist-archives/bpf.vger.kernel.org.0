Return-Path: <bpf+bounces-35018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0B1935267
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FF21F21E56
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A6145FF8;
	Thu, 18 Jul 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LENUttQd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F6145B28
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334258; cv=none; b=SaJbxnCwJUtub8nMc2vh5o4RLWT0+J3HZhgPXYPDMk+UaLOB+qWufzRBcfSLAxjIPVX23FN6i2XOLpJyYe572q+zvaI6DwHVmOn6KHqOryKnLO89SFkEj++TJuK1HNk7DJPxKZ+GMqRHw8w3SgKU1UCECEPPZPhZOR23dkdkCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334258; c=relaxed/simple;
	bh=Nt9pkytUnDfYXkbSy46niKVAAXk4Gi6Olx/OSLpDr2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4EXz4f0cNs7Baof48546pubRh89CNyRoJUvfrkbRSwFT9UAva4UUAt9pN4saAmQpSmH2am1VjI4TK4ajf63wewVS6hLvlqk3pus0V+CQB55Q+s7hQWCyoZdIaOexNsKKYtdmIsxN5PtK7ddCP2p0xjRyHEGpUAqsu/q6+YQfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LENUttQd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc6a017abdso6867285ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721334256; x=1721939056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWnGkYyMTIE+RA1vZAERxh1gaH2KhnVbGUQpHj3QHWw=;
        b=LENUttQdMGm9mqVDM/0iFKO5lDyvDWkqMmm51sJm6kzMdglEorY/6luchx0FNRGed5
         0YEoh21Xz0tyVxlVKpwkfNkmOr18oCPVeJb9GmVX7EX7kfcQlZruxk3JmhyCckN4EpLG
         vzMorkw5klRp4FGFDM0L9L3fp+XO9zt/2MR3k8nCC5AV6vNPBtiKvLMn80gfev7X6pnL
         DRfqeHXPUmqnsg2ppGeY8BwaaKNueN4Kr7GyuK/jtxnhVWa76wpwwJ0D9enDmu5Sf2D8
         Hfn8ygb6ByU3L0eBJGOiNqm8OCdZVjxdNGoSdb5xgDrpSioW7MoUYNbFjai2thBteqTU
         mq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334256; x=1721939056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWnGkYyMTIE+RA1vZAERxh1gaH2KhnVbGUQpHj3QHWw=;
        b=Lw7zjjWZBBmGKzCGadnOOMXvqIEc2vUnYlMgvFrTDcqFy0q/+WAnR2mecBVTwwzwPK
         siXv55NtCuZOaC7kKAQY2onx3Oy5tOrTW9F5Qwz0QxqSBgjBt70apaayeb9dUrqJixSv
         o6hXlI36ORfssx/Azzc3Vxd53oabdklLrKSmKOTF+WzyEHR1Xa/gfl92WXHa8Lsn8iRR
         cEmazfuC9IMGQnCeWAujQc8e/ZvDvcKXAGL0Eb/vi4XAZnA0iTHul/r1+1v8Kf4BdMUT
         vwqJaHCylqoZHYsXMNTbBR9TyqjcFeMyVf3mftNEs0T8kJnCpv7Qg66Xv6Ntm5GFdCNP
         rbjQ==
X-Gm-Message-State: AOJu0Yyo2WHJJ4CmUkBkvk8ZfYJMb/N6Lqw7Ppm/gt5iQgQkuIVLRkky
	fsDUfH5hqCOkhc9jVdZXlEtLsjUmWzHMV4VqhJ6aACVb/b1jPCsMo3VO6v7B
X-Google-Smtp-Source: AGHT+IGTFm5QI6sfch42j43aS8jvo1XlRbvqj8txH9h6usYPQvhUflV/pbeQ2EA+KNrg1CFA/HcJZQ==
X-Received: by 2002:a17:902:6507:b0:1fc:4f9b:6055 with SMTP id d9443c01a7336-1fc4f9b664amr40264825ad.1.1721334256119;
        Thu, 18 Jul 2024 13:24:16 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc505basm96888235ad.270.2024.07.18.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:24:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	sunhao.th@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next v3 4/4] selftests/bpf: update comments find_equal_scalars->sync_linked_regs
Date: Thu, 18 Jul 2024 13:23:56 -0700
Message-ID: <20240718202357.1746514-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718202357.1746514-1-eddyz87@gmail.com>
References: <20240718202357.1746514-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_equal_scalars() is renamed to sync_linked_regs(),
this commit updates existing references in the selftests comments.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 85e48069c9e6..9d288ec7a168 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -402,7 +402,7 @@ __naked void spill_32bit_of_64bit_fail(void)
 	*(u32*)(r10 - 8) = r1;				\
 	/* 32-bit fill r2 from stack. */		\
 	r2 = *(u32*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
@@ -441,7 +441,7 @@ __naked void spill_16bit_of_32bit_fail(void)
 	*(u16*)(r10 - 8) = r1;				\
 	/* 16-bit fill r2 from stack. */		\
 	r2 = *(u16*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
@@ -833,7 +833,7 @@ __naked void spill_64bit_of_64bit_ok(void)
 	*(u64*)(r10 - 8) = r0;				\
 	/* 64-bit fill r1 from stack - should preserve the ID. */\
 	r1 = *(u64*)(r10 - 8);				\
-	/* Compare r1 with another register to trigger find_equal_scalars.\
+	/* Compare r1 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners.					\
 	 */						\
@@ -866,7 +866,7 @@ __naked void spill_32bit_of_32bit_ok(void)
 	*(u32*)(r10 - 8) = r0;				\
 	/* 32-bit fill r1 from stack - should preserve the ID. */\
 	r1 = *(u32*)(r10 - 8);				\
-	/* Compare r1 with another register to trigger find_equal_scalars.\
+	/* Compare r1 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners.					\
 	 */						\
@@ -899,7 +899,7 @@ __naked void spill_16bit_of_16bit_ok(void)
 	*(u16*)(r10 - 8) = r0;				\
 	/* 16-bit fill r1 from stack - should preserve the ID. */\
 	r1 = *(u16*)(r10 - 8);				\
-	/* Compare r1 with another register to trigger find_equal_scalars.\
+	/* Compare r1 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners.					\
 	 */						\
@@ -932,7 +932,7 @@ __naked void spill_8bit_of_8bit_ok(void)
 	*(u8*)(r10 - 8) = r0;				\
 	/* 8-bit fill r1 from stack - should preserve the ID. */\
 	r1 = *(u8*)(r10 - 8);				\
-	/* Compare r1 with another register to trigger find_equal_scalars.\
+	/* Compare r1 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners.					\
 	 */						\
@@ -1029,7 +1029,7 @@ __naked void fill_32bit_after_spill_64bit_preserve_id(void)
 	"r1 = *(u32*)(r10 - 4);"
 #endif
 	"						\
-	/* Compare r1 with another register to trigger find_equal_scalars. */\
+	/* Compare r1 with another register to trigger sync_linked_regs. */\
 	r2 = 0;						\
 	if r1 != r2 goto l0_%=;				\
 	/* The result of this comparison is predefined. */\
@@ -1070,7 +1070,7 @@ __naked void fill_32bit_after_spill_64bit_clear_id(void)
 	"r2 = *(u32*)(r10 - 4);"
 #endif
 	"						\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on fill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
-- 
2.45.2


