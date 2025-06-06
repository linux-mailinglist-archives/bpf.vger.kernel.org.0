Return-Path: <bpf+bounces-59931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73454AD094B
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62CC189FEEA
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6A21CA13;
	Fri,  6 Jun 2025 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAifNGUZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7D21CC74
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243876; cv=none; b=oZzBede/dgzCtm57KabCGCDqAxpHWWHedzGbYmHwUrtHYs7bcTlBtKYUedmOqNVrspcC0BzuXXDIy8u6eXHQ89UnoqZNXbOSZsv/LmQS2YTRG/D/pAm+48UbJ4TMWO4nQLk7aq61XmB15p1mMvZC+FrcYxxd9u0wh/i6KY4uN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243876; c=relaxed/simple;
	bh=5rIX4Dnb+vR65YGOYKouPF9EIxIya1VnCjNE8J4ZjZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7URBv4ONAUsAMODdWpk00trMh7F2xeTr69+s+YBdW96QLy6TrWuPH3S2uBUsGs8++FiF+MeK8+tmW8N8yfAasvuMc+B0z9ojyzdWqCSnqLEHKlFhz7OOqt/Npx94dWn+oeU4NM0lDk4MlPuO4XAGgHbW7UQYsxRALoM7S+hT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAifNGUZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742af84818cso1908277b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243874; x=1749848674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM2bI06N/EerME+Kp35EQ6sRbkZ/0Vcn8GNjCkdCToU=;
        b=JAifNGUZdFOIB2NgA1AMhquztg8w9lVITG90J+vLVr5DdnAl4vNkn8PlVR6CiXAjZ7
         MzyWLvpKZyXOTw1wwVyhKHrjwHqEOcOTO7UCy/MDzkNFAqi9nv20eZZw6k92C1u3ypjw
         dpD0Jj19U3K6wVeiLY3kpymz/t4JxsanLezd9SKwx6NmFD9jc97mucLwSk2i3La7wwPY
         f2P1c4Y/8i0rglrE8ru5fOEcY5bPYfNUeeW4YqSkTs3JYULCLEyZwKRnHFh4w/k9R7dE
         5lYa4T2a5qXIx1gU7VGrAlfVvV+Ub1XfKSMcoFatTUypz26fCvzlDZYVqjz5PCHyAPJk
         WMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243874; x=1749848674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM2bI06N/EerME+Kp35EQ6sRbkZ/0Vcn8GNjCkdCToU=;
        b=uQObez/G7SWx7+sIVX4yrOzgKHsiEf6WPuzFlNURNKLpDVpryPCnXJPwo0F9G7XiMn
         GYDao255rF5toNIVIjB//ndW5Ms0UNLNiR155y8gA7gNRHShAQVs62asqW4jqDciN54J
         hPreKYixBzkl/sq/sp31XGWpCav0ZSMOizfo2jMlisIc9XrE76kE1LW5/lVh80DvzmVo
         BPTYdYnbLNNhwMeO+saVt0cwJOgIq97KD1jfnouI3saIXVmAMycSBxJM0DTv23WJMbXm
         Uv2bpaQULczT9NrKZpXeOw0KqsNUJ3IBU3ZudnOcqGZIc0gdApqXZpz0H9O2BpwnjGGU
         gIkA==
X-Gm-Message-State: AOJu0Yx+CzckdYQsS+0eiFsioFEsrMq7luGY3ooJh1TL3ngqEng4RUIP
	2EUQMJMJPvhxOuVMA90LAMwo9616Adift2AhsHTXZj8XWRiClKqVfiGk19rYd+nB
X-Gm-Gg: ASbGncsPFaxCV8+qWqmX93E70ukyYg4dgYNPPhxqRh2afLQUZn9mkYKzRyirhBZbq17
	gZxIVZRPvbWELNYv937gyxu75/BZUre1h/lzNL1zyM+/l3I5//vrFMEA9LHh89HKzhBLnUJGGcI
	CSLjyihK4DrGAYyLhDxPxEr3H28HmPkrHBDjI/JwHC2whiHrPCpX4bXltSieCUBbF7dHAhvdyfp
	RVk5zYMi5t9rrCtYimAnsf2R0Hq5+EW130nwClVI3zXrWiG1W21qPpQK6GIsBfLlLHX3i2Pl2VC
	S2banWWz60geaHm8fpEKtjCzaRK2ypQ4pJr2ZN7cCIQV7ks=
X-Google-Smtp-Source: AGHT+IFOFTSgicsM+cjh7au2sRZog5wJPOlJeex8VI6O6Xc/Fado8OoM6x/lvVE6oLq8iTIOJW0+RQ==
X-Received: by 2002:a05:6a20:2583:b0:21d:2244:7c5c with SMTP id adf61e73a8af0-21ee685ead4mr7214934637.26.1749243874118;
        Fri, 06 Jun 2025 14:04:34 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.33
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
Subject: [PATCH bpf-next v2 05/11] bpf: set 'changed' status if propagate_precision() did any updates
Date: Fri,  6 Jun 2025 14:03:46 -0700
Message-ID: <20250606210352.1692944-6-eddyz87@gmail.com>
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

Add an out parameter to `propagate_precision()` to record whether any
new precision bits were set during its execution.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20e9d629380f..046d5515008b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4665,7 +4665,9 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
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
@@ -4673,13 +4675,14 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
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
 
@@ -4725,8 +4728,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
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
@@ -4785,10 +4790,12 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
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
@@ -4803,10 +4810,12 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
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
@@ -4842,7 +4851,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, env->cur_state, regno);
+	return __mark_chain_precision(env, env->cur_state, regno, NULL);
 }
 
 /* mark_chain_precision_batch() assumes that env->bt is set in the caller to
@@ -4851,7 +4860,7 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 static int mark_chain_precision_batch(struct bpf_verifier_env *env,
 				      struct bpf_verifier_state *starting_state)
 {
-	return __mark_chain_precision(env, starting_state, -1);
+	return __mark_chain_precision(env, starting_state, -1, NULL);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -18878,7 +18887,9 @@ static int propagate_liveness(struct bpf_verifier_env *env,
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
@@ -18926,7 +18937,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			verbose(env, "\n");
 	}
 
-	err = mark_chain_precision_batch(env, env->cur_state);
+	err = __mark_chain_precision(env, cur, -1, changed);
 	if (err < 0)
 		return err;
 
@@ -19249,7 +19260,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 */
 			if (is_jmp_point(env, env->insn_idx))
 				err = err ? : push_jmp_history(env, cur, 0, 0);
-			err = err ? : propagate_precision(env, &sl->state);
+			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
 			if (err)
 				return err;
 			return 1;
-- 
2.48.1


