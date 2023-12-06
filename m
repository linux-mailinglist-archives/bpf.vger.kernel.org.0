Return-Path: <bpf+bounces-16898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F208075E7
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E11B20E42
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F24349F6C;
	Wed,  6 Dec 2023 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHqO+nln"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F4C9
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:58:54 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67abd1879c0so94636d6.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881932; x=1702486732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzyvyDf0ksVmv0SY+k418p2u/uDCxEL3YpuEDFTHZl0=;
        b=SHqO+nlnxjP0N9m8J9w3kfrAImjGK35nlya3cW5eyejVijqx1uV8OVcf+bBuqBCW2G
         Rv07gFmjiPtlM9+2hlRTuq/ow7NRYJ06Fadx6M04aDQrO+O9ppaNQNvXDRNBJz116IW3
         I8R3yyGMVlyto/PrAouphkFeQCG6QzdC+fUWkq5etxvb1eBZVeFG6Mho6o22Yh9nMqOO
         QGU06XWuadoripfzKR1O0+Tq3RMblcBy1Kl6mFUKDynpouOkMHV2q5oDdO+gjj2IYpOU
         fAYPbUkTeLi3s7d27yEaF9Z+6yT3F1zN6cIyHVP0wnmkq3q3GTCOSJf3ZO8tEmDdd0Xv
         GWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881932; x=1702486732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzyvyDf0ksVmv0SY+k418p2u/uDCxEL3YpuEDFTHZl0=;
        b=ewCu2MQaC+5pyTTwG+R6I3mj3gk1cH9+o23/TVHTKpPEq9IFCksl6dLiooa3qpMyb4
         Qrc4UfNOaVadzcilNrczgjsNM22Y97S6FBtE7Lf93xnsSpbakmBX+QRODAZShyWKnMAp
         DLZ4PFjwd+jPfsQuk2IEwctNS8zEO63+f8H+t+i96+vAvYGZkht1gwVqtlOZ5HQR3LTJ
         a1Ef5iBOVRF95I3dT+fRVuAU59NO+ePo/0GuLS5qx4LJ21JxbZ6BnH7sVsKuWBI5fzyK
         wHhHIJCfkIUi5y41B2CBjCmeuz913P339FDS2FbcxvS+Zq06wEeXwPPu0j+k4lTARHmQ
         tH0Q==
X-Gm-Message-State: AOJu0YxJFl6XdzQ+33Je5rJXEHs3sCUg4EkBI8eUfXzMx2IK0Iivay/c
	yaYC5T/Fr8nmdMVXkK0p9Tpk4ZTRefM=
X-Google-Smtp-Source: AGHT+IHDEw+ystozyIU6z3FWYhKxznGl1amtkJkfU83K7E7M5pZMV1qZ24T6/aMOXGoQ2y4FOpN0fA==
X-Received: by 2002:ad4:4eae:0:b0:67a:c40f:fc1b with SMTP id ed14-20020ad44eae000000b0067ac40ffc1bmr1339739qvb.96.1701881932415;
        Wed, 06 Dec 2023 08:58:52 -0800 (PST)
Received: from andrei-desktop.taildd130.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id h17-20020a0cf8d1000000b0067a3991d002sm118372qvo.30.2023.12.06.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:58:52 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	sunhao.th@gmail.com,
	eddyz87@gmail.com
Cc: Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v4 2/2] bpf: guard stack limits against 32bit overflow
Date: Wed,  6 Dec 2023 11:58:02 -0500
Message-Id: <20231206165802.380626-3-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206165802.380626-1-andreimatei1@gmail.com>
References: <20231206165802.380626-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch promotes the arithmetic around checking stack bounds to be
done in the 64-bit domain, instead of the current 32bit. The arithmetic
implies adding together a 64-bit register with a int offset. The
register was checked to be below 1<<29 when it was variable, but not
when it was fixed. The offset either comes from an instruction (in which
case it is 16 bit), from another register (in which case the caller
checked it to be below 1<<29 [1]), or from the size of an argument to a
kfunc (in which case it can be a u32 [2]). Between the register being
inconsistently checked to be below 1<<29, and the offset being up to an
u32, it appears that we were open to overflowing the `int`s which were
currently used for arithmetic.

[1] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb10235fe3e9/kernel/bpf/verifier.c#L7494-L7498
[2] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb10235fe3e9/kernel/bpf/verifier.c#L11904

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 137240681fa9..6832ed743765 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6577,7 +6577,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
  * The minimum valid offset is -MAX_BPF_STACK for writes, and
  * -state->allocated_stack for reads.
  */
-static int check_stack_slot_within_bounds(int off,
+static int check_stack_slot_within_bounds(s64 off,
 					  struct bpf_func_state *state,
 					  enum bpf_access_type t)
 {
@@ -6606,7 +6606,7 @@ static int check_stack_access_within_bounds(
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
 	struct bpf_func_state *state = func(env, reg);
-	int min_off, max_off;
+	s64 min_off, max_off;
 	int err;
 	char *err_extra;
 
@@ -6619,7 +6619,7 @@ static int check_stack_access_within_bounds(
 		err_extra = " write to";
 
 	if (tnum_is_const(reg->var_off)) {
-		min_off = reg->var_off.value + off;
+		min_off = (s64)reg->var_off.value + off;
 		max_off = min_off + access_size;
 	} else {
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
-- 
2.39.2


