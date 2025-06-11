Return-Path: <bpf+bounces-60376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D779FAD5FD7
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709CF3A90C4
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563F18787A;
	Wed, 11 Jun 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REl9JAEL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF5289811
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672538; cv=none; b=HPIHRDnqMyfnDy7tPiFkxOrh0LodmSZROZChh58V8jjhd+aBSz4jWgDPpK1lrZ9EYxTnbgwS5TiHm5QunOfkGE5Qg8947a7JjPY57B2dLRd0awvu2Rz/PiDrEp45rGX+QNO/gA+qD51q2UZj+FmkS1rVs4PdQKhmfoRlsuXdK+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672538; c=relaxed/simple;
	bh=c0Z95poBtGjyucIKkjBz/s4RHHDWJebw4JbN2KGFA9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlPcQHvN5OwsLqA3VM8icyjb2d4zBF2zOcxF+khshKTsm8eMoroiaQjxysMahDfbRGW0iylmWwPhMiNqMXqE0rCOPwFY4osp9cpgK4nTzxH17AquWnuQRpdYn+PX+mMUznn779eO280a7s7vMHuT1SdaeudSESZxXjOkARNcnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REl9JAEL; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-710e344bbf9so1491217b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672535; x=1750277335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha9e9zJwMBZt6u69dWTCkRNd6OmnBc/td+5GINgFeiU=;
        b=REl9JAELLvxDAmnz7Wtm8jhcmekD/I9vzP7m5fsuOk5pgfojlYu9ZjdGDANSiIizZS
         4vqlfcXyZ4mE5MLR6zIC0FYoTFoYl1c6KvQAsqoDVJ+MlvfAzHNbheq9usHnN0tPJU8P
         5m0NMuErT6D6XT0C1oGPRHo4GvlqZ9hyTA+0CC10m24Y+I5+g1XgS7dBUW54W7AsxmjM
         nvWBkDnmNVSlcPE+q0T+Tuyg14cSNykfkO7+k5yc5kbmyhDPENNexVilMM/7hmfYnk+C
         E655PmIhY0TaaowaYeDRyd1BelTZvCIuX4sxmEyK9pzoG/exI7kyf7iJAqS7l1U65Tii
         hC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672535; x=1750277335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha9e9zJwMBZt6u69dWTCkRNd6OmnBc/td+5GINgFeiU=;
        b=WHL7GsERykYCaSa2SboCngJzNce54Yg3WYKTUibOMc4Ugt74ePEPvlAgVxrv2AfZrO
         kHkCQxsegO4B44RN88/5YTl21+EYFTAAJuyvZDvgPxs3dnrGHKIW2Uo5dTJ5tSk399Gy
         jcOdoVO59cNNC6H1zZr4nr3xUMDvp6bV+IBRXRm/1mCYArgB9NnKTVNgfGjWxz3xbIQ6
         vmzVIXzME7Nrx/MHQzJfrjToeyfNHZmEA/9Adz3NJDHWxKxVn/63xdybvrtwOgepP48h
         46wuqzEdbKeDJquavjM0CwyxsQ91+7XTqxVESILDdZ2Fu5TlrBTx6zI2DgnzKPhn96lq
         QYzA==
X-Gm-Message-State: AOJu0YxymzGcA0peD/hSdenRiinhRw209SM9v9lrEhmqiiTVimchKFGt
	m4VjZZo8/lwu6KOxlYE7XxhL+PTh2+y9GAuFcUULYraw3BWlwExumJyocFyqR4KS
X-Gm-Gg: ASbGncukEMgugiw8CFJ+90a4s83IXrfT2M8uhVQ4A532Gvcl2jxvtasqvsKmh80ehmo
	KgvwtUjy0YLWm7bPKJTwVAp9TvjBJm1pWpHEU0r5ZoLEyCMXDWccjGrOzn3HlWbIhE5CeaHdjlP
	fTcsncc+UPpt1mnNZsBauS4lRqgMTwWYF9x6WnhaY4mk3bwBA5X9Z+tuSyiI7j3we1aUayLOtbn
	2pNBNPC3QZa8XcXmBgpxyFBud8otP0HXVja2rYWA3VIRG0IwHZUtYMrGirnc7pLjo80yDlV37wT
	jac3Q3f1dUN9DaAmT5JnMI3Mzxn58+90/6VzdPbi8oS0B9MY0qhiLQ==
X-Google-Smtp-Source: AGHT+IHxdr/IQ7hB3iSh6Os2ynpEaaOeQmFSNFtX5sPjvN5lgqEXe5TlmyfkOyTTlE27K6e4+2i0lA==
X-Received: by 2002:a05:690c:d07:b0:70d:f338:8333 with SMTP id 00721157ae682-71150a8028bmr7110287b3.22.1749672535394;
        Wed, 11 Jun 2025 13:08:55 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711527d8b5esm109227b3.123.2025.06.11.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:08:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 05/11] bpf: set 'changed' status if propagate_precision() did any updates
Date: Wed, 11 Jun 2025 13:08:30 -0700
Message-ID: <20250611200836.4135542-5-eddyz87@gmail.com>
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

Add an out parameter to `propagate_precision()` to record whether any
new precision bits were set during its execution.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63f8d2ee8a1b..25b50a98558b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4678,7 +4678,9 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * finalized states which help in short circuiting more future states.
  */
 static int __mark_chain_precision(struct bpf_verifier_env *env,
-				  struct bpf_verifier_state *starting_state, int regno)
+				  struct bpf_verifier_state *starting_state,
+				  int regno,
+				  bool *changed)
 {
 	struct bpf_verifier_state *st = starting_state;
 	struct backtrack_state *bt = &env->bt;
@@ -4686,13 +4688,14 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 	int last_idx = starting_state->insn_idx;
 	int subseq_idx = -1;
 	struct bpf_func_state *func;
+	bool tmp, skip_first = true;
 	struct bpf_reg_state *reg;
-	bool skip_first = true;
 	int i, fr, err;
 
 	if (!env->bpf_capable)
 		return 0;
 
+	changed = changed ?: &tmp;
 	/* set frame number from which we are starting to backtrack */
 	bt_init(bt, starting_state->curframe);
 
@@ -4738,8 +4741,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 				for_each_set_bit(i, mask, 32) {
 					reg = &st->frame[0]->regs[i];
 					bt_clear_reg(bt, i);
-					if (reg->type == SCALAR_VALUE)
+					if (reg->type == SCALAR_VALUE) {
 						reg->precise = true;
+						*changed = true;
+					}
 				}
 				return 0;
 			}
@@ -4798,10 +4803,12 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 					bt_clear_frame_reg(bt, fr, i);
 					continue;
 				}
-				if (reg->precise)
+				if (reg->precise) {
 					bt_clear_frame_reg(bt, fr, i);
-				else
+				} else {
 					reg->precise = true;
+					*changed = true;
+				}
 			}
 
 			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
@@ -4816,10 +4823,12 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 					continue;
 				}
 				reg = &func->stack[i].spilled_ptr;
-				if (reg->precise)
+				if (reg->precise) {
 					bt_clear_frame_slot(bt, fr, i);
-				else
+				} else {
 					reg->precise = true;
+					*changed = true;
+				}
 			}
 			if (env->log.level & BPF_LOG_LEVEL2) {
 				fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
@@ -4855,7 +4864,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, env->cur_state, regno);
+	return __mark_chain_precision(env, env->cur_state, regno, NULL);
 }
 
 /* mark_chain_precision_batch() assumes that env->bt is set in the caller to
@@ -4864,7 +4873,7 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 static int mark_chain_precision_batch(struct bpf_verifier_env *env,
 				      struct bpf_verifier_state *starting_state)
 {
-	return __mark_chain_precision(env, starting_state, -1);
+	return __mark_chain_precision(env, starting_state, -1, NULL);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -18893,7 +18902,9 @@ static int propagate_liveness(struct bpf_verifier_env *env,
  * propagate them into the current state
  */
 static int propagate_precision(struct bpf_verifier_env *env,
-			       const struct bpf_verifier_state *old)
+			       const struct bpf_verifier_state *old,
+			       struct bpf_verifier_state *cur,
+			       bool *changed)
 {
 	struct bpf_reg_state *state_reg;
 	struct bpf_func_state *state;
@@ -18941,7 +18952,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			verbose(env, "\n");
 	}
 
-	err = mark_chain_precision_batch(env, env->cur_state);
+	err = __mark_chain_precision(env, cur, -1, changed);
 	if (err < 0)
 		return err;
 
@@ -19264,7 +19275,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 */
 			if (is_jmp_point(env, env->insn_idx))
 				err = err ? : push_jmp_history(env, cur, 0, 0);
-			err = err ? : propagate_precision(env, &sl->state);
+			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
 			if (err)
 				return err;
 			return 1;
-- 
2.47.1


