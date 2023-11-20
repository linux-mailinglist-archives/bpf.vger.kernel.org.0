Return-Path: <bpf+bounces-15446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2417F2116
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190B2282820
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0193AC3A;
	Mon, 20 Nov 2023 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOy1e/aD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E282C8
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548d1f8b388so1787216a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521214; x=1701126014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m6VuLMsS9hoR8umpm5LOgf84PX7p1mJ/cd6KEQFwoo=;
        b=bOy1e/aDQRPg8HEp7gSUzl7naepLz6u61SApdPqEHDv8Rr2tXJL6QamZGDQdPad0mt
         EuAzJPLP5prXES44hfS+2Uz71Rp/KEWJlaAjAHG4fE9k1E9Li4hYzDAo10xCd2E9NdOJ
         xbhGPZRhFuUTMazA+zVvNwCWOrpSic1lEjW0ktTNwyMWc7I7eBo9Vfe6SID2lDf2EpuS
         KCCzejALNr0x768iuRpZJk8L2rcoLw/nDTaY27LoWFsPfKT58B/7jzkmRtnvzJ5f5oMW
         ua1OXM30hGdTLknjMpLXSz3EJ8jc5uHay59HD9mkAcPV3lbw0aknceo4zBG3iuI5mHC7
         +7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521214; x=1701126014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2m6VuLMsS9hoR8umpm5LOgf84PX7p1mJ/cd6KEQFwoo=;
        b=wUU0vUNd1pMubm6vr55+64Jt6Imkm1nSMY4HqeuMDlOgabsOfeQgvK8WKZcBtH3HV4
         sIxDD/UUXbXjBuXVccWTOfCC8Sf7hwPB1npras0vU3DdlExnlAcsVPGitPT5J5T8B5/l
         u//9ZfLQkXG/DDJS3imq+zVFJpT0y6kGTsk8x+GpL/L3l+3AUBnX6oj7rnlg0Ba7xxWq
         Pf67PbneG3/PSR3GpLRze1w3kGvdjWoBDU9qU7651z0Qw7EwnCIsZS+/4ieRrLoyFBKd
         ShVHGK2FHavpL2gGenj8tVSIBT8WTHfJlBm7bmGjZxC3ZTwwiERSi/gyDPTqYy3QdqtY
         tEVg==
X-Gm-Message-State: AOJu0YzgWN/yTf7QTHx47MYExOS610wfz8Zte5392VZVrg1GU/NKhVuj
	hVZm6p8bdlAQn4Yh6YHftrzu9FddyyHc0Q==
X-Google-Smtp-Source: AGHT+IHXE1pCBUSCRUxC7f/fYISVMOZfkdDTKEHL/Ki6aWbswXcEyIyWYdhUxg7w0oIeFE1/ADCrkw==
X-Received: by 2002:a17:907:9491:b0:a00:131c:bc3e with SMTP id dm17-20020a170907949100b00a00131cbc3emr2518320ejc.11.1700521214543;
        Mon, 20 Nov 2023 15:00:14 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:00:12 -0800 (PST)
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
Subject: [PATCH bpf v3 08/11] bpf: widening for callback iterators
Date: Tue, 21 Nov 2023 00:59:42 +0200
Message-ID: <20231120225945.11741-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120225945.11741-1-eddyz87@gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
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
index 77bfb626cc2c..004de7c32bae 100644
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


