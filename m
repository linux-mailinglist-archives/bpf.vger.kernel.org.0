Return-Path: <bpf+bounces-15143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C377ED937
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF61280ECD
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E498C0C;
	Thu, 16 Nov 2023 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9m+/Ssx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF1D196
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso448545a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101120; x=1700705920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx9d/iiNKpvBhav4ns3oaAVyhhe7n5uW5yeViBSXMu4=;
        b=d9m+/SsxwXoV0DxVM+eT9O1TSY2UcwVnLVweIx5be220Y4V5om5ywyaKNQfM0uPvGH
         DpvLtVy0HlFVRlmB1q3F5VeEMw8Mfa1XnO6Nx8wfszUFKRwYWCIjIPsPD+ii0IAFSQ9l
         Q5bAbI4vaM/I4mn6pJ5IUStAQe86EUyFdzFdpXakqJRUVrtkp+CnyYSlC2+7U71htdpA
         ndCB+yW6tlJZJyS9mzVVttBo46BrpM1T+Fui2L6QimLPuZ+p7sWaMXVTboOMv6lkT2hW
         nMIC6swm3rbRVd1RbGqvwhOSiXCmKuCJlCVGG3aluQQmk9yEPRDCMvMLqxYGhgPCvcyi
         JPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101120; x=1700705920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx9d/iiNKpvBhav4ns3oaAVyhhe7n5uW5yeViBSXMu4=;
        b=hHDj8X/vN4cUmQJgm5yjVbUXCUfr+JkXrmtDTQb4MYIn3xQmVkqMBIazoMZv2J63pB
         R29OJz+rq/TkJUfVRPgK35mD9Lm5ah0bL3oVE5gRu/9Zylad9lsiZKWE5XHcDBBzwPg3
         EzxihbODb4AMxAt8vUT2RtM6ecDcB3Zj1Vfi7ceT4p2u+qPqLgZvD88yWv6QjN/RsjKE
         pWIodO79jq+/fD1B9H7JvJTVQoCLZYh2V3X/I2xeiJE15Nw1zVmgNPhZFzlsb/AGSyD5
         lyvRZgj2hWBAoVwoH2jxNVl8ASNsjxGQJ+HhZQ+1f7g4T9lTwu2Atc8AbkJHzVXy1Qzc
         i9ZA==
X-Gm-Message-State: AOJu0YzcixqddkEQWB3aJzo5QZHfFHrG43TWwfZ8YnQ3Bde5b6VmB81q
	YF8bS/1lRT2jmZArQVzO24YKniuWVpqUBw==
X-Google-Smtp-Source: AGHT+IE3vRq7CSQcaz2YBMFoq8KB1iq4dWI9PIAu6JTig9RyrBlnL1a00cmMthwmw0GM/WeTEgTFXQ==
X-Received: by 2002:a17:907:8687:b0:9c2:a072:78bf with SMTP id qa7-20020a170907868700b009c2a07278bfmr15282915ejc.26.1700101120301;
        Wed, 15 Nov 2023 18:18:40 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:39 -0800 (PST)
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
Subject: [PATCH bpf 08/12] bpf: widening for callback iterators
Date: Thu, 16 Nov 2023 04:17:59 +0200
Message-ID: <20231116021803.9982-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 270f7ca3c44d..5b8c0ebcb4f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9974,9 +9974,10 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
-	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_verifier_state *state = env->cur_state, *prev_st;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
+	bool callback_iter;
 	int err;
 
 	callee = state->frame[state->curframe];
@@ -10026,7 +10027,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	 * there function call logic would reschedule callback visit. If iteration
 	 * converges is_state_visited() would prune that visit eventually.
 	 */
-	if (callee->in_callback_fn && is_callback_iter_next(env, callee->callsite))
+	callback_iter = callee->in_callback_fn && is_callback_iter_next(env, callee->callsite);
+	if (callback_iter)
 		*insn_idx = callee->callsite;
 	else
 		*insn_idx = callee->callsite + 1;
@@ -10041,6 +10043,24 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
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
2.42.0


