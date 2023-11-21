Return-Path: <bpf+bounces-15491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E27F239F
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D9B282339
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF92014AB6;
	Tue, 21 Nov 2023 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m89lV8dN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB8ACC
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so7341649a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532455; x=1701137255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiNAnHYV601OVusAzxNLJxsUpGUvfrj+rZZJBNLwZzY=;
        b=m89lV8dNvsvo9RbivCkYAfgV2FXqV08x93WROZfTm4FQStw4yCpAJ2Tv7CvbA10OXr
         E/rvmP+Z1n7ZcUIEprelG2j0WyGeKQuHhntvBT2oQ/BAJfdo17BMAb49/Cn4dko/lunF
         PVh6IsaDOGSEDyGs1igGD9QmWLqsYnt6cOwGPCLgThPNEUkmuQBnQrwATpqDbWw+VRmX
         T2qcOeONyIf279FDND7EdBu03dpmduMUmmXV1CLho4DpLV980Y+adkcPpmnC4dEswsuJ
         sOYWGHytzf6M4l6S9CSkf4n1Zfrgwvuak6PI55HRyoZ4Bfu0+2SmMeUKfFM4zN1C0PkN
         CdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532455; x=1701137255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiNAnHYV601OVusAzxNLJxsUpGUvfrj+rZZJBNLwZzY=;
        b=CSHFeqzn2q00ivyIQBc5ONW77P48ouR6UEqeJn8zWGByedIp+RNY4kNDZVFNnWkUOC
         ARPq0BMRcAIcnWRkw5651wHo+NJSHxslSvh7bPNeSj1qereqcUQ0lgoX9VrHe/s9aA0m
         HfBhVEq99QhbkGde3B6lXYVV+E6H9LD29kLoihsj0K3bxTfS+AG4ch/YvhkvzZFngPxO
         Yy4DXctX/4BwWWmrUo6ILUJqaTPxQe5B+sIC3ekhWLJWR86jAuIY2ea/VjoNeUSwFxU9
         p0fudozHiFO4NO9yYybRXNI1vVZWp5uIfQcpXGCMw1TQayEM3d1GhZ29/VkLY69lRR61
         AItw==
X-Gm-Message-State: AOJu0YzDL8OgCvUNqZHjZKE6lplmn++M6dhI4i5vEqdnYBaNLKTZChdu
	Zn0GHYUazjFe6QdIdW6YJVR7Zz/kU1CZuw==
X-Google-Smtp-Source: AGHT+IEkObUtgtwh1+aLyI1ySdRFuZSqwSHYcfEaWXekJAF4aI7ctjI2vGXkoUKfdZYyKEpFg2lb5A==
X-Received: by 2002:a17:906:b1c4:b0:9e5:cef:6ff with SMTP id bv4-20020a170906b1c400b009e50cef06ffmr6801116ejb.33.1700532454980;
        Mon, 20 Nov 2023 18:07:34 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:33 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v4 08/11] bpf: widening for callback iterators
Date: Tue, 21 Nov 2023 04:06:58 +0200
Message-ID: <20231121020701.26440-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121020701.26440-1-eddyz87@gmail.com>
References: <20231121020701.26440-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callbacks are similar to open coded iterators, so add imprecise
widening logic for callback body processing. This makes callback based
loops behave identically to open coded iterators, e.g. allowing to
verify programs like below:

  struct ctx { u32 i; };
  int cb(u32 idx, struct ctx* ctx)
  {
          ++ctx->i;
          return 0;
  }
  ...
  struct ctx ctx = { .i = 0 };
  bpf_loop(100, cb, &ctx, 0);
  ...

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a60dfa56ebb3..2f03e6b11bb9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9799,9 +9799,10 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
-	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_verifier_state *state = env->cur_state, *prev_st;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
+	bool in_callback_fn;
 	int err;
 
 	callee = state->frame[state->curframe];
@@ -9856,7 +9857,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	 * there function call logic would reschedule callback visit. If iteration
 	 * converges is_state_visited() would prune that visit eventually.
 	 */
-	if (callee->in_callback_fn)
+	in_callback_fn = callee->in_callback_fn;
+	if (in_callback_fn)
 		*insn_idx = callee->callsite;
 	else
 		*insn_idx = callee->callsite + 1;
@@ -9871,6 +9873,24 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
 	free_func_state(callee);
 	state->frame[state->curframe--] = NULL;
+
+	/* for callbacks widen imprecise scalars to make programs like below verify:
+	 *
+	 *   struct ctx { int i; }
+	 *   void cb(int idx, struct ctx *ctx) { ctx->i++; ... }
+	 *   ...
+	 *   struct ctx = { .i = 0; }
+	 *   bpf_loop(100, cb, &ctx, 0);
+	 *
+	 * This is similar to what is done in process_iter_next_call() for open
+	 * coded iterators.
+	 */
+	prev_st = in_callback_fn ? find_prev_entry(env, state, *insn_idx) : NULL;
+	if (prev_st) {
+		err = widen_imprecise_scalars(env, prev_st, state);
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
-- 
2.42.1


