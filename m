Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246CF64831D
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 14:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLIN6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 08:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIN6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA575BCC
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 05:58:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t17so11732070eju.1
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yJ7ZyFEyQN7jPS3YYUIZ0tR6YmAAhUd4UH8MqxA4G0=;
        b=AR9GjI0oKD8HRn0iDZs/AcO8tzXXwBHw/mgAXBxvblOm46X8q8zjn+BuOcTrSrAwYb
         8Cy4d7dr/s8/WtCK52tTfRmlgCgFw+q9ireSCGskGr7T8PtrWrtxYSCQgqM8B7kR3+8E
         WbRLKmPQ2Av2qzOvP4mfE7fAIM/FyV7HS2npvYbce9C39Uc1dY9qVxy6KhH/EFBJ+exH
         NSZWkohPqEJNCYi5vxTEcdxnNELa5gxUjRcu/IaAyvliUGWrbVExYOmE1+5bSCi8PU5i
         7H1Ttb4HbegWsHNTLMGSa2vKyzWzv71EKWEJisO1e1tId0GI9DwSgk6DT5WMyABvWf22
         Zqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yJ7ZyFEyQN7jPS3YYUIZ0tR6YmAAhUd4UH8MqxA4G0=;
        b=o2o5U08I+FxRaxoA+DFbNs+1+leZqPENZ2U5KMQ3ISmXJ9ni9Mia3NszMRXsVU8wsf
         F+svPbjVeW9TC08L7lExUGRncekyRbPjKrPGMO2+AgsyTTbPo7acV4ltZZFFwcMW4XWw
         B6BrIDaEDy9lcnfo0DxLnRPPDnq3+C0aIcD8veuGgBQp+p1hGRhCBu3U/TPxcmMNdstX
         B5az+Or1PSjKE+bDhsXz5jWIjNZYP31VfqdHK73xuzIN6psSQVfPEN8HNMS89xdqzo/v
         8Z0KKczxnqLbtiWAcyww4ggCS2aiB4hbaW0gEFvgtJqbrg/NDIgQcASovGJoq3K8nCOU
         IoVQ==
X-Gm-Message-State: ANoB5pleUeIK/bYpCShd/2y7FfN9y+8Ish7HjovHc3nB9/wHNMc7JGOq
        Z6CdAJC6ySyNA0MQyn17xkTn7IEUJt2XqA==
X-Google-Smtp-Source: AA0mqf5X2F8HBDwp7PJSOYwkF03hMXtw1U1Aat5ltlu1b32PUtu5ga+7sYG1CwfCb2VtN8LgQ9C/AA==
X-Received: by 2002:a17:906:850d:b0:7c0:d886:b9ff with SMTP id i13-20020a170906850d00b007c0d886b9ffmr7756678ejx.16.1670594327348;
        Fri, 09 Dec 2022 05:58:47 -0800 (PST)
Received: from pluto.. (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906830600b007c10fe64c5dsm589028ejx.86.2022.12.09.05.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:58:47 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, memxor@gmail.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/7] bpf: regsafe() must not skip check_ids()
Date:   Fri,  9 Dec 2022 15:57:27 +0200
Message-Id: <20221209135733.28851-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209135733.28851-1-eddyz87@gmail.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier.c:regsafe() has the following shortcut:

	equal = memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
	...
	if (equal)
		return true;

Which is executed regardless old register type. This is incorrect for
register types that might have an ID checked by check_ids(), namely:
 - PTR_TO_MAP_KEY
 - PTR_TO_MAP_VALUE
 - PTR_TO_PACKET_META
 - PTR_TO_PACKET

The following pattern could be used to exploit this:

  0: r9 = map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=1.
  1: r8 = map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=2.
  2: r7 = ktime_get_ns()        ; Unbound SCALAR_VALUE.
  3: r6 = ktime_get_ns()        ; Unbound SCALAR_VALUE.
  4: if r6 > r7 goto +1         ; No new information about the state
                                ; is derived from this check, thus
                                ; produced verifier states differ only
                                ; in 'insn_idx'.
  5: r9 = r8                    ; Optionally make r9.id == r8.id.
  --- checkpoint ---            ; Assume is_state_visisted() creates a
                                ; checkpoint here.
  6: if r9 == 0 goto <exit>     ; Nullness info is propagated to all
                                ; registers with matching ID.
  7: r1 = *(u64 *) r8           ; Not always safe.

Verifier first visits path 1-7 where r8 is verified to be not null
at (6). Later the jump from 4 to 6 is examined. The checkpoint for (6)
looks as follows:
  R8_rD=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
  R9_rwD=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
  R10=fp0

The current state is:
  R0=... R6=... R7=... fp-8=...
  R8=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
  R9=map_value_or_null(id=1,off=0,ks=4,vs=8,imm=0)
  R10=fp0

Note that R8 states are byte-to-byte identical, so regsafe() would
exit early and skip call to check_ids(), thus ID mapping 2->2 will not
be added to 'idmap'. Next, states for R9 are compared: these are not
identical and check_ids() is executed, but 'idmap' is empty, so
check_ids() adds mapping 2->1 to 'idmap' and returns success.

This commit pushes the 'equal' down to register types that don't need
check_ids().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3194e9d9e4e4..d05c5d0344c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12926,15 +12926,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	equal = memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
 
-	if (rold->type == PTR_TO_STACK)
-		/* two stack pointers are equal only if they're pointing to
-		 * the same stack frame, since fp-8 in foo != fp-8 in bar
-		 */
-		return equal && rold->frameno == rcur->frameno;
-
-	if (equal)
-		return true;
-
 	if (rold->type == NOT_INIT)
 		/* explored state can't have used this */
 		return true;
@@ -12942,6 +12933,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return false;
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
+		if (equal)
+			return true;
 		if (env->explore_alu_limits)
 			return false;
 		if (rcur->type == SCALAR_VALUE) {
@@ -13012,20 +13005,14 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
-	case PTR_TO_CTX:
-	case CONST_PTR_TO_MAP:
-	case PTR_TO_PACKET_END:
-	case PTR_TO_FLOW_KEYS:
-	case PTR_TO_SOCKET:
-	case PTR_TO_SOCK_COMMON:
-	case PTR_TO_TCP_SOCK:
-	case PTR_TO_XDP_SOCK:
-		/* Only valid matches are exact, which memcmp() above
-		 * would have accepted
+	case PTR_TO_STACK:
+		/* two stack pointers are equal only if they're pointing to
+		 * the same stack frame, since fp-8 in foo != fp-8 in bar
 		 */
+		return equal && rold->frameno == rcur->frameno;
 	default:
-		/* Don't know what's going on, just say it's not safe */
-		return false;
+		/* Only valid matches are exact, which memcmp() */
+		return equal;
 	}
 
 	/* Shouldn't get here; if we do, say it's not safe */
-- 
2.34.1

