Return-Path: <bpf+bounces-58897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04AAC3109
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70899E147B
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386481F03C5;
	Sat, 24 May 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn4cuflH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B918BB8E
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114394; cv=none; b=jUCW0SZBFK3WxjhRe4byhNGngyRAB5oKSiK77R3vAorJB8Cnvyjy77mF6WhaX5FT83TtXXt0KTzoMrTKgEhME2Dx9bNz4W8zQfmUZ2zUpsKAl6Dol4tIbApMrDB6vb2LR0yAB9DokvWNIQMW/1jKqKsRt6FzA/F1pkZV4mFURW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114394; c=relaxed/simple;
	bh=fKHOg3LYmoEYulsE9NDVSHLN2LMDpCjKexxNVV6fbVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRxUvTQT653B4ZYWRRWMWrAg5rhahm891AdXKiWbwI0sxmYdVOMpRxKyF+cIAp8efK1TZXhSpbT84EMoaO3bU6osCiGiQ6jcsN9JCQvPYw1miGStW6SrTOdcssuusXpZq147tCVfsCNQt2CeVi+PNW/hYEaMDgzosd20U7jgHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn4cuflH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so851393a12.0
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114392; x=1748719192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3+a8zV0BfJUOCuqnMUV9zDAJsDF/NzO2PtH8i13hzI=;
        b=Kn4cuflHa6qhyTstXEQ/NPY+WSxjdOfmwDu5sLoFCOoMMje/G7Hhu4nIYY5UR2a6Tt
         kWRoLxaJdZxVC5yKNoGEjPaJlCHPKL8LswIWg5IM2wZwteEuUXebchgFmrrkGGO3znde
         NTfsj8eh+932E0iO4FzVzXZgLf/i6UBoRJkmcuP5oaFf0e27oSnCY6yFcdCCQINVN9Pc
         ixz3eSLr/vWmVyAkFxLbhB23vXjBitRJ3W9bPZtDpjMTfWHvN3Bojv1debUNKBUzmfZf
         EuKZrXekIoKb8xWk0iUE+vdHQwiKHCnLwGihd929p4lTaouAp9eJKU/J/U94QRwSwHtG
         HfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114392; x=1748719192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3+a8zV0BfJUOCuqnMUV9zDAJsDF/NzO2PtH8i13hzI=;
        b=desaxAsksM6GZbh1wieunsFIM0PEg7rLwLE61460V1SB1/ge9hphDPDOdjD79j6wp3
         Ud9S9Nd0ZVdCo20FvaEmj9nVMRg4BDU8i/j5eBMvFdYqgGKhN3uA3LQej7jLllIiJGLr
         Q412y4jGvhS4CzJD8Ml+M9uvffxoxnCHW9WN/RVIO8NlLIu9oYfzO6pDmtoEn2rm3ab8
         dnbmqEnrx7vA8+nCyBHf/NNWVSFE4tk5mRrrzKdlhWDWWvS8fwNPogvHhpplqGEb0UAc
         0sg1x72dqNSx/CBhoXEdyaZYhh2vXlEsViSNVICSn6cqwG2l/Z9AD4g3OkxtGXN8G7X5
         +jWQ==
X-Gm-Message-State: AOJu0YxiD4lQqy6byXjUtBxuSk2uXhbrYlg6+bODyKiBDykgVU8zeUXL
	XWGLXOy0H0KwZUkQTKVHNgR5ofFzGJJVJvyeQCAQnTdb7NrPVDDJaDQJPrBzR22V
X-Gm-Gg: ASbGncuYDTnqH2S/cpB0FAq1IfjRtLLj1iNlwBu+QnTifDv7tyuFcg6TSI0FQLwJcts
	KcMVzlfzoMKAX7UdrYD8rP0SsSUhOoW7yonq8+VjuEWHoBk9clpewVeFZEAIURBg83zmrt5lZnB
	WMMFOXfMy8m/yu2PLvTq5flEOZbng3xOVwpA0tvZve4oXt/eMDFbIOMdZqWRO0NHMo7LM4+p9Gn
	EZGHwzN8TPzyg5zCpzRkRYj4FJptpJNMHC3fGYrj79AGTn3sm5i5xqCObXHJAGsK6ugBTAb+WWn
	irg9Np1v67yhnk/l4uDQOsIBmHy6g4eoA5uTIk8yGNpu81k=
X-Google-Smtp-Source: AGHT+IE9fwhxRV1tb0yu7msgDDsX8WegstVBAenyVJLpxh6EBuhIz/n1UT2LVG4LHoVGl9wWwqsMMQ==
X-Received: by 2002:a05:6a21:38b:b0:203:ad33:1ae3 with SMTP id adf61e73a8af0-2188c23f8aemr6297931637.10.1748114392216;
        Sat, 24 May 2025 12:19:52 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 05/11] bpf: set 'changed' status if propagate_precision() did any updates
Date: Sat, 24 May 2025 12:19:26 -0700
Message-ID: <20250524191932.389444-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
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
index fa0f6bce1e2a..59d7e29dd637 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4663,7 +4663,9 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
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
@@ -4671,13 +4673,14 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
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
 
@@ -4723,8 +4726,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
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
@@ -4783,10 +4788,12 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
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
@@ -4801,10 +4808,12 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
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
@@ -4840,7 +4849,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, env->cur_state, regno);
+	return __mark_chain_precision(env, env->cur_state, regno, NULL);
 }
 
 /* mark_chain_precision_batch() assumes that env->bt is set in the caller to
@@ -4849,7 +4858,7 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 static int mark_chain_precision_batch(struct bpf_verifier_env *env,
 				      struct bpf_verifier_state *starting_state)
 {
-	return __mark_chain_precision(env, starting_state, -1);
+	return __mark_chain_precision(env, starting_state, -1, NULL);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -18868,7 +18877,9 @@ static int propagate_liveness(struct bpf_verifier_env *env,
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
@@ -18916,7 +18927,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			verbose(env, "\n");
 	}
 
-	err = mark_chain_precision_batch(env, env->cur_state);
+	err = __mark_chain_precision(env, cur, -1, changed);
 	if (err < 0)
 		return err;
 
@@ -19239,7 +19250,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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


