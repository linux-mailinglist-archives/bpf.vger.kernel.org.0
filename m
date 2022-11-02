Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CBB616EA7
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiKBU1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKBU1W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D46333
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2941500pjl.3
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmcrU6Wntj9T6+/2PbrfHYHYXtsZmvlZZIau4WshjWw=;
        b=qMr3XjKDLpFN5Cj5WXmiSRLN2LufYr3foXfUaOyUts8tU0+BRN1LtjiYrrpNZbK9Cb
         VigCWrGQ3ZlTOLPo+w+MUi512w5UYI/oUhkOGse1TWFwWyaQ7psteWOwsN9ODDTU3eRx
         Aer1a9xhrYIT6vgnD4Q7cxqM6QOApI1/0UMizgMOZre6nFIJ9TicSNJfYw9Y5kixeTNg
         Gj9yAlBK4T21tEqREwyNGRFqZFmdMBn5Fu56scm6gdQdoi7dl2IoSsT/ENIPcD6XZLUj
         zSyBULmXVLR69mfysbCUVJMBe/eMViOG/+cODGQoUHJ4e9kRKmbHKDyB47F+Q9WTt+r9
         JCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmcrU6Wntj9T6+/2PbrfHYHYXtsZmvlZZIau4WshjWw=;
        b=qQbaCxIi2oar7f5pPOAtVwrRUDhNzRe1vaauVapulhB9yJxf0gywzru/ldal7YI7GY
         mgCtkLdApnWh0nc/g3AS37ayjboC4OmiYS/uUqQiNgWBN+Izxzr3WOYnjmenwiqQDHM7
         yXZGnycuUnsBJ0B+y7PwO8wJNPDAup7FkOaW50gc51pMfviLztycasFOeSMUcBxif70o
         0gw69BPccmBT5+lZ4YPx5deWAqK+CI+6hc1yVTC8PqzACDHfBg77mropURildkm67YpI
         o91g3R+YT0SRUf3tmIprCAM/o41rad0e7ZYugfXNFjLHD/3b8TeWEPHG4wlnF+OyaNPB
         /F0Q==
X-Gm-Message-State: ACrzQf3WlI1/VE2Cp/AnBEzsybkYb803tZF0C1wJ/0+gpq5WP49tVHbV
        Pfx2z1eOKjNJqLF0gQLE++IgJxh8/ZUV8A==
X-Google-Smtp-Source: AMsMyM70KRhZpVEZm56i8U57sKYoirEmzxM2np1IPf43IaxgPLiSp24UMZnHHsh7WOjDZnRrgjwnfQ==
X-Received: by 2002:a17:902:7b87:b0:179:ec0a:7239 with SMTP id w7-20020a1709027b8700b00179ec0a7239mr27401888pll.139.1667420840752;
        Wed, 02 Nov 2022 13:27:20 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id z2-20020a626502000000b0056e0ff577edsm1908376pfb.43.2022.11.02.13.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:20 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 04/24] bpf: Fix slot type check in check_stack_write_var_off
Date:   Thu,  3 Nov 2022 01:56:38 +0530
Message-Id: <20221102202658.963008-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916; i=memxor@gmail.com; h=from:subject; bh=2A24L+SDeo6HhPIaFXaa7CB1KPzqdsp4JoIVE8BBBOc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtICIaFuN4ePk22LXQMvPOV3DtBMLJvkK4Nrq1l6 Rm5Qg+SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAgAKCRBM4MiGSL8RyuMfEA C5vJuCZZv7Trxi1B1Oztvi2HTMIvvIj2mLgJ6sVg1p9U4D+PNN0oBKSaJDvKy5FcezRPClHOVAxIzV g8lvo8qabLHZ4XHp7xg2M5xN0tteuUVky5vtoHuXGjPjY+oeq3wVFMysKqomQ4IbKr6d3zmbAKkQvY 3s9DbySPgkfUWbSO2WUUAGAnvOWyS0FX2mDpixBwtUMKPGmFf4vi68ZXMu2aHLrLrI9QTMEBzHFXHI jyeTMzYmQ4F72QGD24VbokpIB2BeT5nQCQjmK/E2OLK8aby3iDU6bzY0BsvXeAjcaRo+Yy7JXYzpSE ao9VlGE2+iDRREUR2rFeDs//Z/nRTDjamo2nCsIw+NgCN/QukuxOFw6I4z32OZFtJzerSKIby9P0Tv SicBtiSE8725vD1ryNyNde2HpewTAtuXxw98RwULFN+axvuDCnaauS62d7k5MPGlVmRLU/G12rOYPv SxqHf9MkY8Amh34BMeb1vh4LhC/HlOK6mic8EL7NYpORtNyi0wS1hXThAeLUkdrc/jnI66xiy4yI8+ 9+wUIYQ/GBhC0f5WYwl+XkzTPjmBeBHI8ZXYz0QNy6WZYHMEeZf45e16jV6/Wf7mTqw+gT4gREya6j 1Y+eBYyjhPh4mHo6/DD9hbLp2AQfhmi9khYKGD/QzYSdD6wMTpxMEsWO8RFA==
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

For the case where allow_ptr_leaks is false, code is checking whether
slot type is STACK_INVALID and STACK_SPILL and rejecting other cases.
This is a consequence of incorrectly checking for register type instead
of the slot type (NOT_INIT and SCALAR_VALUE respectively). Fix the
check.

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 123fcb1b2cca..abdd293e4358 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3181,14 +3181,17 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		mark_stack_slot_scratched(env, spi);
 
-		if (!env->allow_ptr_leaks
-				&& *stype != NOT_INIT
-				&& *stype != SCALAR_VALUE) {
-			/* Reject the write if there's are spilled pointers in
-			 * range. If we didn't reject here, the ptr status
-			 * would be erased below (even though not all slots are
-			 * actually overwritten), possibly opening the door to
-			 * leaks.
+		if (!env->allow_ptr_leaks && *stype != STACK_MISC && *stype != STACK_ZERO) {
+			/* Reject the write if range we may write to has not
+			 * been initialized beforehand. If we didn't reject
+			 * here, the ptr status would be erased below (even
+			 * though not all slots are actually overwritten),
+			 * possibly opening the door to leaks.
+			 *
+			 * We do however catch STACK_INVALID case below, and
+			 * only allow reading possibly uninitialized memory
+			 * later for CAP_PERFMON, as the write may not happen to
+			 * that slot.
 			 */
 			verbose(env, "spilled ptr in range of var-offset stack write; insn %d, ptr off: %d",
 				insn_idx, i);
-- 
2.38.1

