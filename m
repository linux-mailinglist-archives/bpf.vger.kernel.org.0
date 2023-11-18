Return-Path: <bpf+bounces-15289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A57EFCFB
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB522813B5
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547E111A;
	Sat, 18 Nov 2023 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2ASJGDM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E8D7E
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e2838bcb5eso365169966b.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271256; x=1700876056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foOB9pNPFyC+bOprRS+x7IZ74/wpQcudg4kxpus7DpA=;
        b=b2ASJGDM8UZ+zCEJ+4/M3Q0ZCkd2zeLNsn2Ta3o1VBESOJ5bIQk0JjcCkXe6IVsVTc
         wjx8EVcFu9TVRP98qTevIdtiUvLpLNqMwVZUHHVIvWqQueF13RZygCPfjHbjpWOgtB0q
         Bxy2WIw+BuPkHN7c0HBBfrgM76WdMd03vAewdl5ifTMm1nmd3feg6S62FpAvdJqwzbPi
         irKOqWgUU/171kPkcNMVCqHIJio7bKJyooKU4Ci9fC2YPuvLDdcxg9uZ7RAFYYHUZ+Xu
         tSngRdO7cosByzo9jmqTCRkXy8gleN47zRc9G9/Y/yzji7VsMUcenFZTbIV4h/DL/Z2Z
         1LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271256; x=1700876056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foOB9pNPFyC+bOprRS+x7IZ74/wpQcudg4kxpus7DpA=;
        b=RF6t+0K8Lrt4x2ce5vnL1V7QviK3MX2Fxa5JK1pi0RdjiGhLPtTs3Fx1lnwWxHLSPa
         rdrTc9bFaDt03tw+jG4Di2QXe6AsrsNEJ7TV/XZpQT22Hg2LnIeBnjZWFv7uo2N1/rNN
         zqw+ADw/aTTiMN1eMey+hCnCELB+64za19jT7XhEXcaVP7Pt/R1ccmz70ppF3UyP1Wax
         +JMT0sgsM3seyiQXimUJjY9Kz7FCOr0+pS1mbEpxmsnrTcxai+xX8/w3UwMSRXDIh+uP
         wCVPkZ8/8GhWhPU114VjjAoHQwJ3XrGpw99icQExN1ezrtWqSee/db9C3Gr227aAcQE/
         7eig==
X-Gm-Message-State: AOJu0YxbFpaujYVDQJviXBYxxhkI98vvjCazKFZkYVpfUdv5JzrX1UUS
	BdT19VKC5VxqRMu60WBQAd03E6EqdSQ=
X-Google-Smtp-Source: AGHT+IF4qZlw079thR2O7VGkJAHvS594SL0p7BJGe5zHHFqd++UaKSZKFLwFTDivA4viG2ica7K7MA==
X-Received: by 2002:a17:906:c1da:b0:9d2:9dbe:a2f9 with SMTP id bw26-20020a170906c1da00b009d29dbea2f9mr600831ejb.50.1700271255966;
        Fri, 17 Nov 2023 17:34:15 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:15 -0800 (PST)
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
Subject: [PATCH bpf v2 08/11] bpf: widening for callback iterators
Date: Sat, 18 Nov 2023 03:33:52 +0200
Message-ID: <20231118013355.7943-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118013355.7943-1-eddyz87@gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
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
index 35e137c5f29a..b9e3067890b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9977,9 +9977,10 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
-	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_verifier_state *state = env->cur_state, *prev_st;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
+	bool callback_iter;
 	int err;
 
 	callee = state->frame[state->curframe];
@@ -10029,7 +10030,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	 * there function call logic would reschedule callback visit. If iteration
 	 * converges is_state_visited() would prune that visit eventually.
 	 */
-	if (callee->in_callback_fn && is_callback_iter_next(env, callee->callsite))
+	callback_iter = callee->in_callback_fn && is_callback_iter_next(env, callee->callsite);
+	if (callback_iter)
 		*insn_idx = callee->callsite;
 	else
 		*insn_idx = callee->callsite + 1;
@@ -10044,6 +10046,24 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
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
+	prev_st = callback_iter ? find_prev_entry(env, state, *insn_idx) : NULL;
+	if (prev_st) {
+		err = widen_imprecise_scalars(env, prev_st, state);
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
-- 
2.42.1


