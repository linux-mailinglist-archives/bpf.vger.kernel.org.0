Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C9584A30
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 05:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiG2DbJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 23:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiG2DbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 23:31:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E091A068;
        Thu, 28 Jul 2022 20:31:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso7171590pjo.1;
        Thu, 28 Jul 2022 20:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MxegPP+9eR+tqzB10w9UP7S+nttT/U9nMghcqqAW8Tc=;
        b=ZuMiPGRjx2u0bWndPQFq3JctNqzjgqzlOstPsDNefFEgX6OnLCGcnYvMLQBvj8/C1v
         A1YSL7zuNfm3bo5s63cvTnQOW2vqXQ2QaMV2D43USVKnaLc7ORTIC8pbeECuH6nnpsex
         nk8635x9d7X9W2NgQWvEY5YGg9O1lBvEXHnoVcIq4+OTf44oSFE+N7REcC0F/v5OoiqD
         Q+D1e1GT0Li23yQevFmaRuQJN4BSQfMFGSJoDP8FSOC5Hf888FTaBHdXIs5lPrXaFeh6
         mA3h10NXUMjxbDxPj3sycbndDrkWJLubedxSBDzh8YI0SvwH+2m/tMJ0vALy9LXrMPCW
         vrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MxegPP+9eR+tqzB10w9UP7S+nttT/U9nMghcqqAW8Tc=;
        b=gOAyHKsEiVQXxXaPNdVCsbsVWZ9iQzNbi+RDWMvhOjvvPNvzfFCy9Gve4wWbOGwvWO
         4fVQIpH1ljK3ga+iZqa0akKj45Ecttni8K+t1gr3I7uMnvmf2ToPnZt1RWh6mZZw91p5
         E68MwThajdxmy0Hw0qb5mgHgILQ9bMPN1hh1io5ap71N3CMaljfmnG9yhjddilwiaqLM
         hJYDI1WqAd4xWnWcaB6vX8zVzV8Ews3AwLp3qmqpYoAVABbbQdkC0G151f2B4eLjvm6D
         PaVENRn023E6h/LI/Dqf7ExNgCF8QFNeKjEcv7pXitCs6Mmp7RUEtFBhw51xJ89EmonV
         4xdg==
X-Gm-Message-State: ACgBeo0t95UoGoGdcZ5VkCC0BWuN2admLNIqPpDsqRaqtZZgGXpQTS7n
        eOFidsprAx7xdrUAzn4rQZ0=
X-Google-Smtp-Source: AA6agR6xpVkKhZ8x+zIF0whAenQYv9jNsIv574ISUsr7qXKwexYM5ARUhkEF/k9AHq0yD20N/VrGTA==
X-Received: by 2002:a17:90b:1e4f:b0:1f2:b482:bab9 with SMTP id pi15-20020a17090b1e4f00b001f2b482bab9mr1909636pjb.9.1659065466045;
        Thu, 28 Jul 2022 20:31:06 -0700 (PDT)
Received: from Kk1r0a.localdomain ([220.158.232.156])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902ec0100b0016d338160d6sm2145840pld.155.2022.07.28.20.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:31:05 -0700 (PDT)
From:   Kuee K1r0a <liulin063@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuee K1r0a <liulin063@gmail.com>
Subject: [PATCH bpf] bpf: Do more tight ALU bounds tracking
Date:   Fri, 29 Jul 2022 11:30:33 +0800
Message-Id: <20220729033033.3022-1-liulin063@gmail.com>
X-Mailer: git-send-email 2.25.1
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

32bit bounds and 64bit bounds are updated separately in
adjust_scalar_min_max_vals() currently, let them learn from each other to
get more tight bounds tracking. Similar operation can be found in
reg_set_min_max().

Before:

    func#0 @0
    0: R1=ctx(off=0,imm=0) R10=fp0
    0: (b7) r0 = 0                        ; R0_w=0
    1: (b7) r1 = 0                        ; R1_w=0
    2: (87) r1 = -r1                      ; R1_w=scalar()
    3: (87) r1 = -r1                      ; R1_w=scalar()
    4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
    5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0xffffffff))  <--- [*]
    6: (95) exit

It can be seen that even if the 64bit bounds is clear here, the 32bit
bounds is still in the state of 'UNKNOWN'.

After:

    func#0 @0
    0: R1=ctx(off=0,imm=0) R10=fp0
    0: (b7) r0 = 0                        ; R0_w=0
    1: (b7) r1 = 0                        ; R1_w=0
    2: (87) r1 = -r1                      ; R1_w=scalar()
    3: (87) r1 = -r1                      ; R1_w=scalar()
    4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
    5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0x3))  <--- [*]
    6: (95) exit

Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
Signed-off-by: Kuee K1r0a <liulin063@gmail.com>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0efbac0fd126..888aa50fbdc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8934,10 +8934,13 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	}
 
-	/* ALU32 ops are zero extended into 64bit register */
-	if (alu32)
+	if (alu32) {
+		/* ALU32 ops are zero extended into 64bit register */
 		zext_32_to_64(dst_reg);
-	reg_bounds_sync(dst_reg);
+		__reg_combine_32_into_64(dst_reg);
+	} else {
+		__reg_combine_64_into_32(dst_reg);
+	}
 	return 0;
 }
 
-- 
2.25.1

