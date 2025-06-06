Return-Path: <bpf+bounces-59930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F4AD0946
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40423B557C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEAC21E08A;
	Fri,  6 Jun 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNGRDplf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446421C9FF
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243875; cv=none; b=ZxF8JtzvnyHP18c3j6QQ8bC+oIQW4b5tYesY61vnz/HNzr66CkLyTqd8gEQZoF/jTBCqeWp6LWzkZ6bGqG0gMu4yeC5e0ssjCUiekbMkiAtYw3QLIhDJKz1Lo3lKmHg4qiJwo5SWmrtFNga8x7Ia0jK96c3yFngiLASv7w7tjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243875; c=relaxed/simple;
	bh=T5IgXugnbOxRgk3l4JvGc9mbg2Oan/KcgTEYxXim2Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZbV6TMjFaF/7HYY++scOuOavnR0V9RRtCM7EEQuUxEunBeojSq97xNVsE3YQ6yOB+P3DmC3v953KFORw0AY+Z72EzgRcw3PU3Vj2Aojxnygi8c81K4GB0EP+MMdk9atThQWbKqnmdvOP8W2mf0/6lLjZ8LVLeOoah1TD78dGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNGRDplf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so3232574b3a.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243873; x=1749848673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5zcBR/xvXf8AQ1wAXJ4s1+cOBJXZSXPPFlKSdX9a4g=;
        b=LNGRDplfvw5jdLAU0ZwnwmnBo7Hs6+HiBD6iUBISVAR4tgZn7+63TBM4dNNHqF9PdF
         YYJCbocIxXVZu1orS4IyZQD5yFsATdseJUuPahb84Y8RnWhG/QnFaoikGturiWQNuXvK
         Ds3A6/5Qm7buqMvrGVCnXuGnoGYJFZQlKKmghM62vJY9ylIDmthAVr9US6ukVrEHiVTn
         51/QpzTYdzbr5MAFSONJMDpC8AUtqumAtSgDu8IBluatALGu/F9ERcBcRj5MSRap9K2Q
         Pznm5FWi3FdWK07Vn9IHW5vQM/2kDtIRgkYb3RT5f4PJPDs82LuYPvYzDjek2YUBq/be
         bY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243873; x=1749848673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5zcBR/xvXf8AQ1wAXJ4s1+cOBJXZSXPPFlKSdX9a4g=;
        b=BfHz2O9KMmaVtdCqcpaUSwT1rv291zcEA8OcMrLE15NstuEkUdC0e+Mr6eRmJdWxSa
         dkd5vCviEDyxDds9o3B4PvjjpN0U7jX/X8prtuPKEmS/GPQumZooThE0QiNHyu8Y2elq
         vMU2oqbshyR66U5SRTWc06stUCELUe6nq+RzFWCy1YmFbEs0rggaTF59Mbk4MzkiLdCB
         h+mYxM8YRKYalxnsdNItzXyWoPwJgAlcbuLvtiqp3CxphOndKrmOpBX/JT+Z5Z2mLSFf
         urJty8m8F08CeLK8zHmgyz4BNEEBithAwguXvmpon0lgL2tkzBm7LN0V3bdDhhpBSCAS
         aSEQ==
X-Gm-Message-State: AOJu0YzA80yPlTRZjnBa4GkDq3Dsdbn20xzbiVzCAH7R4uPpLVWw5rS7
	IVl2CygYaGkGNcFv+0ubuzB77vCyGA+a5nsXootCIp2pYWPs6w9YBa5t25O/lcM1
X-Gm-Gg: ASbGncuAhaugaA6R/5uKJrLEE1huWU8GA4lRY8ZmxNVLNLkb3qgz+n1ndRRKjitr96G
	lRYV/D2uLlnFhdhUYpL1cvjt7n4MefLxmUZlwVkNajwW6iswaSS5dG74oSO0ecM29PPmixssUZv
	STelnfxl+mN+BDpM6O/4ZlwcH1EUqGTe0DB3KcRk+1IhkZ/G5+Cbi9MhIRCTinRTJ1Of+WvsGQt
	DyMnV7f5+aVpypg5/3iuQDNRu0Jv/v106KWCPWtup4E3s8vMtIGqjaDA6ahZKmAYZQtNn7hReBO
	HmJ8lU2fLaErmGipGk+OWQjK5Yg/najc9D9We3PygQ5ClTi8zblTNbo+PA==
X-Google-Smtp-Source: AGHT+IGzGTQXY3xBAE/f2rf1X7LHjRRQkqcSMSH0JvpqRAlcaxJ5FEDptKQ9VMlhZ7BjQ+YoMQ9yLg==
X-Received: by 2002:a17:902:d2cc:b0:235:e94b:62dd with SMTP id d9443c01a7336-23613673b24mr2988425ad.12.1749243873386;
        Fri, 06 Jun 2025 14:04:33 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:33 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 04/11] bpf: starting_state parameter for __mark_chain_precision()
Date: Fri,  6 Jun 2025 14:03:45 -0700
Message-ID: <20250606210352.1692944-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606210352.1692944-1-eddyz87@gmail.com>
References: <20250606210352.1692944-1-eddyz87@gmail.com>
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
index 644ffc23db1a..20e9d629380f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4664,12 +4664,13 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
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
@@ -4680,7 +4681,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 		return 0;
 
 	/* set frame number from which we are starting to backtrack */
-	bt_init(bt, env->cur_state->curframe);
+	bt_init(bt, starting_state->curframe);
 
 	/* Do sanity checks against current state of register and/or stack
 	 * slot, but don't set precise flag in current state, as precision
@@ -4744,7 +4745,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				err = backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err == -ENOTSUPP) {
-				mark_all_scalars_precise(env, env->cur_state);
+				mark_all_scalars_precise(env, starting_state);
 				bt_reset(bt);
 				return 0;
 			} else if (err) {
@@ -4832,7 +4833,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 	 * fallback to marking all precise
 	 */
 	if (!bt_empty(bt)) {
-		mark_all_scalars_precise(env, env->cur_state);
+		mark_all_scalars_precise(env, starting_state);
 		bt_reset(bt);
 	}
 
@@ -4841,15 +4842,16 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 
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
@@ -9502,7 +9504,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	 * to prevent pruning on it.
 	 */
 	bt_set_frame_slot(&env->bt, key->frameno, spi);
-	err = mark_chain_precision_batch(env);
+	err = mark_chain_precision_batch(env, env->cur_state);
 	if (err < 0)
 		return err;
 
@@ -18924,7 +18926,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			verbose(env, "\n");
 	}
 
-	err = mark_chain_precision_batch(env);
+	err = mark_chain_precision_batch(env, env->cur_state);
 	if (err < 0)
 		return err;
 
-- 
2.48.1


