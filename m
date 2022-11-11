Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15762620B
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiKKTeV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiKKTeU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:34:20 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5877576FB2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:19 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so5510132pjd.4
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW6kTYVA+y8b43HdcehxOTQglQ0619cSpShurQ4DCNI=;
        b=VQ/++5mL2S2MoypmSgUmH8N9aeORZfHN3I7Vx9J846awQbfjrk+6JjtuMlHXvodZ9j
         H4f6tsP7HOwaqLUmZ0Nk6hfg3dlY4VYPD1lKPEgw1mNFLBQ7sC8UAxM9ngsjbQdrq0Av
         lP4YlkjmHlhyQ8xGgWhC6AsgObszTjBHIoevwl7zwuRM6pbUKGjT455oqhCuHcjZ79AJ
         /9s44YZNRUs6gt0FGyvVKsZ0ciV1LsSJTY8DIkA2/1JG0IrTqNRIpS+kiPW6OoSO2nfB
         6Z3YEhVeWyXg8+K6R2rlmVlyzOtMITfRsOrohqOZbo3CVmmU2vzeu4/xtoYahvTMz2Be
         /yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW6kTYVA+y8b43HdcehxOTQglQ0619cSpShurQ4DCNI=;
        b=bUCQpBIg+BXEWJJpuEILG4xD+spCsS+Yyh96Rtf4Cg1MyTvXIrHk4FdfBCEibj5TLd
         vUY2enT0RmiAQXUsMcsC2pVLtdflrEHz6WqUSyAtgoqbhqmXBJvvB/qkTQs9i9VA8ep2
         hth/OCjWRGqhN7UCvOGV6XpsNfeeaqlxmVPsx0HgBUDXN/rbQvNYuc36+9/12Z8vrWMb
         BDfXh3urr4EZ+ApNV4Pu8BYidfu3z5cB/RollnOlFwRg4ntcxC3/10GI9xnIAnSgD1NU
         WMRu+x6jQYPTKK/EI45yFXpT7yhVPoHK/OaLC76nRtAOg8kTkBrGh5U4g7YEJjWMD6Ee
         cp6A==
X-Gm-Message-State: ANoB5pm9iIlfH3mWq7MwLIxvmYqYn0iTmNHtK26SsiET2/lIwu1AVdEc
        02aMF/51dmvAXXQT4teO4u8aikIk+PaEYw==
X-Google-Smtp-Source: AA0mqf4uiAKBfpHQt34rkbp6pZ8Y24BEK2LS6tq2fEuWbpfnsVerxjcqLG9nsn/ZpuYnbZGRBewWoA==
X-Received: by 2002:a17:90a:9ce:b0:200:40a2:eaaa with SMTP id 72-20020a17090a09ce00b0020040a2eaaamr3483870pjo.68.1668195258621;
        Fri, 11 Nov 2022 11:34:18 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001868ed86a95sm2090498plg.174.2022.11.11.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:34:18 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 19/26] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Sat, 12 Nov 2022 01:02:17 +0530
Message-Id: <20221111193224.876706-20-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227; i=memxor@gmail.com; h=from:subject; bh=QQzN5i+KVGSbJY/B6kG18+QcbhNJQ0FLx/9bPyIyj94=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIoyWIZpGQdJsqdKnCM9pbpjWfQelScT3yZZP6B sYxnWaOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKAAKCRBM4MiGSL8RylQwEA CTjXtLH73tr6rq8rQOltYG54cDIs/NYIiN/BqQoMlMJr+xjrjYW3IMb5qqbx9MU0RWFEYmgKEOnd5T txpaLRSNbnpkGAm0/Ken0E1hsxLc77IM4drbon5IMbhFrJoExpctmP2GTaQAXjOTQFSnRhWcqCqoyQ 6shobJNpfQwNdY4WX1FawP+nEAvM2UrpSMikvtzdYqBQkiAl3bLlZevfD0ILJTjZ7gbXI0RMGQ/oRr J71kUWiFfF6JfhlxsCBzPV25hZPZN8W0qweMkr34VflaHtKGTPz+FMFOnz9BGNl6sLzpdNMhZQnk5I hE5luMmmWMKKaAJTNHA0AtQEpJ4qj91TkqtxFKxEh+hT4/Ie2pHgN+4xYYRolntre2nD3dQIolmNRw gkpr2CaFGZbL/oRXKwF9/k/+N5titE8uI8NM/5Jwx0rVrB8rYzJgBjP9sU7aRIPH5gIAiZwt9HVSLg MRBT0XB1envsGDsOVhmE4sLuazMTbYYKjx1tJ9J/BGFShughLRO8EUEkSijpmDlnTC049H7kog+Zck +J17r48PbImWN1CVWKz2y74HXreh0UEacw+yiwWb8DdDvwoCtA9OyJhITyiKum1zG4r+OGc4sHrI0l yGOgcA19Aey3HUSkp8pIdGt+3sUCPuwH5Xh/UIDKiKYiSBE9brpHuCznK6Pw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pointer increment on seeing PTR_MAYBE_NULL is already protected against,
hence make an exception for PTR_TO_BTF_ID | MEM_ALLOC while still
keeping the warning for other unintended cases that might creep in.

bpf_list_pop_{front,_back} helpers planned to be introduced in next
commit will return a MEM_ALLOC register with incremented offset pointing
to bpf_list_node field. The user is supposed to then obtain the pointer
to the entry using container_of after NULL checking it. The current
restrictions trigger a warning when doing the NULL checking. Revisiting
the reason, it is meant as an assertion which seems to actually work and
catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f98aa4c9d7c..7f44885d04dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10791,15 +10791,20 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
-				 !tnum_equals_const(reg->var_off, 0) ||
-				 reg->off)) {
+		if (reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0) || reg->off) {
 			/* Old offset (both fixed and variable parts) should
 			 * have been known-zero, because we don't allow pointer
 			 * arithmetic on pointers that might be NULL. If we
 			 * see this happening, don't convert the register.
+			 *
+			 * But in some cases, some helpers that return local
+			 * kptrs advance offset for the returned pointer.
+			 * In those cases, it is fine to expect to see reg->off.
 			 */
-			return;
+			if (WARN_ON_ONCE(reg->type != (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL)))
+				return;
+			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+				return;
 		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
-- 
2.38.1

