Return-Path: <bpf+bounces-60375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658CAD5FD6
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBE23A912A
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2392BDC28;
	Wed, 11 Jun 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiD5BruP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6C2BDC2D
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672533; cv=none; b=R1DBhWlw20D6CyJd8pW4DcYJpMZmjhRmrZ9OrzaUxdTSzMK/6IIwlLz0nFc6JpZOkhXhDX80hp3sHfjvcmmJyrcJ0pYC+I07SPVuvpJjf4miHjP0tV6vpSOy0snXrM81qlsTjbzYskCvWvuIemBEsKpagtwMFxZmG3FIafLETgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672533; c=relaxed/simple;
	bh=VnW3DdDP5YoarpS0x3INs2A2TF+HJwyymEdAF6oUhI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQfMljXIeYXcm2h+A34sjnBZsME51MJO56srrk8yjhOAumcIHH+tbrfubSMyEgUXWZPWwxVr9Ea915aIRFm3041w+m67lqr+aIsYpJXZNdhR0Ja701sjj5IRTBHyOcPJX5tkMZwhp+eVtNuir49w7NrN0OEEfrRAKFEkd/VBFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiD5BruP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e3c6b88dbso1379687b3.0
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672530; x=1750277330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZKY2C45rCdeHretGGp2q5zY9d8eM4JgUMBb3dtZfls=;
        b=QiD5BruPde3K3unHTyHisUAnUXbkJu6kS1UYcAUXwu/cCelZZ+ZzuespbLm5C9LVbx
         f2GqNgeCDBk5qQ6to6tcNBmiy5V82yz6QkQh2vNPHDDPiYJWnMjhZlvoWTtaECmNFvU9
         AHUE9SpjUqYWidMDbm+k/VNWe5g3ulavCHK/WBouYA1FIwqqtB2Xt2fo3JihqIo1l/MW
         hH/8HrKbPMw8l22OR4LW/nUASBEYDx0DMlQsw0JciMtMwi54EBRSJDyN1obV2JMtdfmr
         xCyw20YObzlRz7xyX21CNKRcHxFeCTjCabjlhRt5ElSxflJaLDz1c2EQ9KP+GD2DoQJP
         VxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672530; x=1750277330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZKY2C45rCdeHretGGp2q5zY9d8eM4JgUMBb3dtZfls=;
        b=JmOT4C+x1t11H85nGNhIz/WWhMDjXRJV4ZbniQdWVNDzOC/6yMf+9BKf+SrrVxByRP
         oTAvTTA7AFi+GDjCYEeTUkdSvmDcd3kv19BBeQqeVdPKEY20Jfsm6C4QK7onGtaG9AWQ
         gDm7+P7qj90UF5/YAk0cvjzRbHoaUNoqIESWDU+CAeTQexDgPRTg2faFIYvEPAhICQup
         MtR5OwRm3tmwUJUDS99KxXMapIdXtiqxQ7v3nw+iNerPfOsE1+PiTWP+vY8AHYYx+YDf
         +JKpueRUoAYbFvxTG+lRliq/QsbO+Jdz7/GvGIOacW7bHUxdJT/djLpqOKwtK41SHd1S
         DmCg==
X-Gm-Message-State: AOJu0Ywb5op5IHA/f8AVsTYuzK54YAVSNdU2Ang9/Oe3kgmos5XZxk+Y
	rRvvispSnqV6u6GsIkkBrnvO1CBCZJsfG4bQkdsuocW2Z8pviF2xP0+bXV4rDg6u
X-Gm-Gg: ASbGnctboVS/WosBIR4aNlv0SCScF4rG4mevZNIEefcwc676TM7pThmuxDc8R/L1Z/Y
	p38BjkJqMav5/wUwXcSdOjOZv/2l2/b8vhReRI/JIkTX3hMY4yyfIeWKMGrIC1nlzLxVvYLgVbH
	TyusQNaZL6Y6mqy5oWXMEeqVB/JVsoc79VU4L8c1mYNh3N7Yv6rrT6zmVatTRLi3rsG21R3k9S/
	CfZOYB6DmE5/bvsT0do3ZsuRRp6vXss6zaRL9ZRM9ZqdGPNFUJlC+EuBfkF2nKZI11tD21Rlu1y
	/9VQiJ3wbJQvsi7Fsa+5eSYWZ4dDxnrkus1g/srsKZ7Xgs33O/EsWg==
X-Google-Smtp-Source: AGHT+IHxIYikH4y5GhXn71wuCnxF5Yc8lVQ/9ljRHRC7rT+u29kG47jcOEQvw25/G3dmMYaWuA5LYA==
X-Received: by 2002:a05:690c:360e:b0:6fb:1c5a:80ea with SMTP id 00721157ae682-71140b056a3mr75159377b3.32.1749672530434;
        Wed, 11 Jun 2025 13:08:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:46::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711520c0fd3sm148727b3.55.2025.06.11.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:08:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 04/11] bpf: starting_state parameter for __mark_chain_precision()
Date: Wed, 11 Jun 2025 13:08:29 -0700
Message-ID: <20250611200836.4135542-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow `mark_chain_precision()` to run from an arbitrary starting state
by replacing direct references to `env->cur_state` with a parameter.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 002d1e9b2260..63f8d2ee8a1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4677,12 +4677,13 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * mark_all_scalars_imprecise() to hopefully get more permissive and generic
  * finalized states which help in short circuiting more future states.
  */
-static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
+static int __mark_chain_precision(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *starting_state, int regno)
 {
+	struct bpf_verifier_state *st = starting_state;
 	struct backtrack_state *bt = &env->bt;
-	struct bpf_verifier_state *st = env->cur_state;
 	int first_idx = st->first_insn_idx;
-	int last_idx = env->insn_idx;
+	int last_idx = starting_state->insn_idx;
 	int subseq_idx = -1;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
@@ -4693,7 +4694,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 		return 0;
 
 	/* set frame number from which we are starting to backtrack */
-	bt_init(bt, env->cur_state->curframe);
+	bt_init(bt, starting_state->curframe);
 
 	/* Do sanity checks against current state of register and/or stack
 	 * slot, but don't set precise flag in current state, as precision
@@ -4757,7 +4758,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				err = backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err == -ENOTSUPP) {
-				mark_all_scalars_precise(env, env->cur_state);
+				mark_all_scalars_precise(env, starting_state);
 				bt_reset(bt);
 				return 0;
 			} else if (err) {
@@ -4845,7 +4846,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 	 * fallback to marking all precise
 	 */
 	if (!bt_empty(bt)) {
-		mark_all_scalars_precise(env, env->cur_state);
+		mark_all_scalars_precise(env, starting_state);
 		bt_reset(bt);
 	}
 
@@ -4854,15 +4855,16 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, regno);
+	return __mark_chain_precision(env, env->cur_state, regno);
 }
 
 /* mark_chain_precision_batch() assumes that env->bt is set in the caller to
  * desired reg and stack masks across all relevant frames
  */
-static int mark_chain_precision_batch(struct bpf_verifier_env *env)
+static int mark_chain_precision_batch(struct bpf_verifier_env *env,
+				      struct bpf_verifier_state *starting_state)
 {
-	return __mark_chain_precision(env, -1);
+	return __mark_chain_precision(env, starting_state, -1);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -9515,7 +9517,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	 * to prevent pruning on it.
 	 */
 	bt_set_frame_slot(&env->bt, key->frameno, spi);
-	err = mark_chain_precision_batch(env);
+	err = mark_chain_precision_batch(env, env->cur_state);
 	if (err < 0)
 		return err;
 
@@ -18939,7 +18941,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			verbose(env, "\n");
 	}
 
-	err = mark_chain_precision_batch(env);
+	err = mark_chain_precision_batch(env, env->cur_state);
 	if (err < 0)
 		return err;
 
-- 
2.47.1


