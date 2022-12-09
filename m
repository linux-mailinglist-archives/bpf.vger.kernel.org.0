Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83306648322
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 14:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLIN67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 08:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLIN6z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:55 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A75675BCC
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 05:58:54 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id b2so11663522eja.7
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 05:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abgGM9CUNndqrEA1w+pChD0KCjzJooML7RT1geS+xYQ=;
        b=VcqW1lfHmpWiDG3Bwhfkor4jx4FT+jvCSMBU8zoKfOkwIE4RtD076wS4ZWopaMtL+V
         f1MHCyRyfjd18s1QaNkMAqwVqvHkGCzleaoSB3LgumozUxB3AeINNtnVHPzhyWgxHi2s
         YzRZuEW1z/662635Wz6TPLBTu85RypGmTwC7afpxLzx/32qwVIq8wq1mGO/QargEPFIM
         763Omdp7epNNNxt7CHmcxcACgpzpWwHMewHbNVzw0rQxeonVGKyJwE2+kILf+wN1k8YA
         bVQQrCmJGdBxZBc1Vdn5WpVqMUDm0RhTGBw+9JlMwG//ThOjUgZfItgY7zI662YTmR1o
         g2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abgGM9CUNndqrEA1w+pChD0KCjzJooML7RT1geS+xYQ=;
        b=dS+HLbCaIIDfsOc5AusEGM9nlIiKfmNzQpwYLqByDkMH9tzN/9QZ391fWwS7PUP+2k
         qB0Sax+w3Fxbdr7CuPX5js1tqdVuyy2r+qWJzWdkKqA4cxne5Uq9CiMKClkDzWZmUvy3
         VGCTRcMwWPlXScIGuXb0ZiHNjc0SCxzASHvc9r6gPsSWTKtmvbarE1eN7ikyTF97AGuE
         RgNarjVOWukiqBvAlQ0oLaNvfHYv2D7YKtW+s7Pa/gGmhrrbGfGGLRTm1AGNHa1k6jpd
         83NTt/c/wPWPlxHTJwJa9DtwKV1UOfLParlA0O6E7ZSV2LPItUUUQK4+kjhGqpfziTz6
         PEcA==
X-Gm-Message-State: ANoB5pn7ac0gAcLdvWp1eYhVnOFYeCizc9e3d9rtX9DCANv9PzQX144R
        dAtX8tZgoLjVlo4gWZCPDnUluU6JeOMhwg==
X-Google-Smtp-Source: AA0mqf5MZ+LnJWJEyy9N4h0OupkaJcKMqmRNUs46Sv4pr9+jbF0uelk4vgECRD9uozvF2zfe1O1uAg==
X-Received: by 2002:a17:906:1685:b0:7c1:458b:a947 with SMTP id s5-20020a170906168500b007c1458ba947mr1911436ejd.26.1670594332472;
        Fri, 09 Dec 2022 05:58:52 -0800 (PST)
Received: from pluto.. (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906830600b007c10fe64c5dsm589028ejx.86.2022.12.09.05.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:58:52 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, memxor@gmail.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 5/7] bpf: use check_ids() for active_lock comparison
Date:   Fri,  9 Dec 2022 15:57:31 +0200
Message-Id: <20221209135733.28851-6-eddyz87@gmail.com>
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

An update for verifier.c:states_equal()/regsafe() to use check_ids()
for active spin lock comparisons. This fixes the issue reported by
Kumar Kartikeya Dwivedi in [1] using technique suggested by Edward Cree.

W/o this commit the verifier might be tricked to accept the following
program working with a map containing spin locks:

  0: r9 = map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=1.
  1: r8 = map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=2.
  2: if r9 == 0 goto exit       ; r9 -> PTR_TO_MAP_VALUE.
  3: if r8 == 0 goto exit       ; r8 -> PTR_TO_MAP_VALUE.
  4: r7 = ktime_get_ns()        ; Unbound SCALAR_VALUE.
  5: r6 = ktime_get_ns()        ; Unbound SCALAR_VALUE.
  6: bpf_spin_lock(r8)          ; active_lock.id == 2.
  7: if r6 > r7 goto +1         ; No new information about the state
                                ; is derived from this check, thus
                                ; produced verifier states differ only
                                ; in 'insn_idx'.
  8: r9 = r8                    ; Optionally make r9.id == r8.id.
  --- checkpoint ---            ; Assume is_state_visisted() creates a
                                ; checkpoint here.
  9: bpf_spin_unlock(r9)        ; (a,b) active_lock.id == 2.
                                ; (a) r9.id == 2, (b) r9.id == 1.
 10: exit(0)

Consider two verification paths:
(a) 0-10
(b) 0-7,9-10

The path (a) is verified first. If checkpoint is created at (8)
the (b) would assume that (8) is safe because regsafe() does not
compare register ids for registers of type PTR_TO_MAP_VALUE.

[1] https://lore.kernel.org/bpf/20221111202719.982118-1-memxor@gmail.com/

Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Suggested-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9188370a7ebe..27caea773491 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12981,7 +12981,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 */
 		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 		       range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off);
+		       tnum_in(rold->var_off, rcur->var_off) &&
+		       check_ids(rold->id, rcur->id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
 		if (rcur->type != rold->type)
@@ -13153,8 +13154,17 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_lock.ptr != cur->active_lock.ptr ||
-	    old->active_lock.id != cur->active_lock.id)
+	if (old->active_lock.ptr != cur->active_lock.ptr)
+		return false;
+
+	/* Old and cur active_lock's have to be either both present
+	 * or both absent.
+	 */
+	if (!!old->active_lock.id != !!cur->active_lock.id)
+		return false;
+
+	if (old->active_lock.id &&
+	    !check_ids(old->active_lock.id, cur->active_lock.id, env->idmap_scratch))
 		return false;
 
 	if (old->active_rcu_lock != cur->active_rcu_lock)
-- 
2.34.1

