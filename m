Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FB0584AC5
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 06:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiG2EoK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 00:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiG2EoJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 00:44:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD77A500;
        Thu, 28 Jul 2022 21:44:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l23so6497519ejr.5;
        Thu, 28 Jul 2022 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W307cKMsb6DPyWr0X6lTH1Vjbw0z3PqxnN4FmNS8G68=;
        b=Sh8XNz2Lk+RX4ovQpXaF5Jp7OAv3RRcn9hQ8vhof0RJRkxz7z37FYOOC5rf+lcW9hM
         aEmvF3dWgms3/UWDca++4ZoG8PTqYwJ5ugz0niFjsamWHDIIDA4/RauyWdiq/cn/eiQ9
         5vuThOHPEEF1BfEySlmGPOLbdLQquwstF1B5IRZIvB9AyHzx+diI/cF1YLcMk7hLVq6+
         PtKYl/DFNCOveWIDHBesUBODJdyvVwlvx3Mcc8EdoYKHZCZu0wyJrXxJcF9VTjb3ddfn
         VP62n6Sw7TwrmQsa4X+D3iaHKJaMwqYuxLqaeuizd5qIPaFBoWPiZr51Qmdficnd2jVe
         +HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W307cKMsb6DPyWr0X6lTH1Vjbw0z3PqxnN4FmNS8G68=;
        b=Yn3WM9seauhzz1lBbaBnK66oOoOrmWi6D25XUOKXPbNP718keJ7SKeCWkeKdZs1Wjx
         koP3S30R+l+SlnwGRfr/iLXIX/PVNAMOPl3PkUoKhTYnpbRFqlveTgrmpVbkT3U2GSL6
         9iHNq1E3H8s498NV4FuTTehTrLETdNARuwyt2j+/TrZSWjsm6ze2VvNU+S4O+VLs5PMS
         N7AJv7tJaPkMk7LDVCpBW+TBHB3ITyjxE6i/pd2MYpF5EY+RZxwh1As6VdhVZPwYdhuG
         htn3iTbVwg5VgHawH1p3ztgRVWqvKywMWvX0Ip6NbqlxXKnybbXff8VZPWYj031Xp4Ag
         THIg==
X-Gm-Message-State: AJIora+Pq/Sbg6+r2Q3fWtA3z7hJZ9QSdHflBOwMCDCCUX4EXCFAS+ik
        9xKcCClrvMjxxeQVXtYQl7YgfGQTu7SpRTT2+txTPA==
X-Google-Smtp-Source: AGRyM1v4tNbo78TIvXYPRPhbd07nqlvNmOH6b+foWDU3MKaVe4VWcU1DyIXk0cNuc5pTd42fidpYSA==
X-Received: by 2002:a17:906:9b86:b0:72f:56db:ccf3 with SMTP id dd6-20020a1709069b8600b0072f56dbccf3mr1574569ejc.422.1659069846655;
        Thu, 28 Jul 2022 21:44:06 -0700 (PDT)
Received: from Kk1r0a.localdomain ([185.22.153.144])
        by smtp.gmail.com with ESMTPSA id o21-20020a1709061d5500b007300d771a98sm1206928ejh.175.2022.07.28.21.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 21:44:06 -0700 (PDT)
From:   Youlin Li <liulin063@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Youlin Li <liulin063@gmail.com>
Subject: [PATCH bpf] bpf: Do more tight ALU bounds tracking
Date:   Fri, 29 Jul 2022 12:43:17 +0800
Message-Id: <20220729044317.31975-1-liulin063@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CA+khW7hVwRQwXshymZCotPZyHmWXj7gjZvJO1_NnjnBSNjYj+A@mail.gmail.com>
References: <CA+khW7hVwRQwXshymZCotPZyHmWXj7gjZvJO1_NnjnBSNjYj+A@mail.gmail.com>
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
Signed-off-by: Youlin Li <liulin063@gmail.com>
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

