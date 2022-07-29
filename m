Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72B5856EA
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 00:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbiG2WnR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiG2WnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 18:43:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C18C599;
        Fri, 29 Jul 2022 15:43:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ha11so5973275pjb.2;
        Fri, 29 Jul 2022 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Vfurx0avHmoD+/rx7I7utriu6TPRnA65smWowv9rlG4=;
        b=Y1znAxBrqBMBIqNu4h6bSE3uKx/kwWJUsg7ejDuCSjK/JEBbDP2uCZqCNtHKznTars
         qxkuJkwK/9fpo6tkZ/3cjOi4gRD+y9b8aJD0HTwI0HepVO1QuzwiujMWIbNjW0HuvETJ
         QAnbOait9YG2DQ1fBOJTOP4ZsJyASZM4bemtaEjLSWBDy/hryhNKsoFEWr7Hp/jK7u5H
         gZKV6tXF5/igXKjqXl4vK5S175ChlTzRbnSqDcvLJ8WOcBVWGo31+WV9+QFBySLUKtuO
         l2Cq6iSrx4+hX43l4khcG5McVtGdQK+sM80a/UxB97ZLHoVaN5hqXQ8MQbECYuSDTYYu
         MGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Vfurx0avHmoD+/rx7I7utriu6TPRnA65smWowv9rlG4=;
        b=grUWpu+Xft3CD2q91kc82FGhzS07+cYqacW0D/lpZJ8/bLtLABd6wsZItEeuobeApD
         WSm1b/JfnN+D1SQUGO5u8V9LQEoHc3yVVLKowNj03eaz8EEqtz7rttCsZiOgBvyY8DUx
         N33jedJUk3tNZzbzEEz84fuARNLWc3g+nSVzAAx/+JlW5AHoU+sqLiUl99ZjZSpmNg2k
         8T8fq6Ya6aYFqL2hFoNH6Y40gu484W2lRrZwhvbJakc/IZyAD/hhhtnWr9LqJhmszAc6
         Kr65w0MYXhp+csiDWnjIjGZ+pyvbgbbFglzn1MDSrD+NOX8LfizaPq+kc47fp/M/FhHf
         JpNw==
X-Gm-Message-State: ACgBeo1cH/IEwJKqVBmL7KcxUjglus/LJ5mH+ijMoKVLSPg95yVENh1H
        zQfz9kFLm4gYq4bQMHQcCmY=
X-Google-Smtp-Source: AA6agR5XgYRLrcHNGRzGv+TsFhwmRNY5BfpImdUfTueiobph/fLj9r4kf+ghJrL7bDPGvOjVEHHAXg==
X-Received: by 2002:a17:90a:b007:b0:1f1:d31e:4914 with SMTP id x7-20020a17090ab00700b001f1d31e4914mr7134882pjq.36.1659134592539;
        Fri, 29 Jul 2022 15:43:12 -0700 (PDT)
Received: from Kk1r0a.localdomain (1-164-146-226.dynamic-ip.hinet.net. [1.164.146.226])
        by smtp.gmail.com with ESMTPSA id n8-20020a170903110800b0016bdeb58611sm4295483plh.112.2022.07.29.15.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 15:43:12 -0700 (PDT)
From:   Youlin Li <liulin063@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Youlin Li <liulin063@gmail.com>
Subject: [PATCH bpf] bpf: Do more tight ALU bounds tracking
Date:   Sat, 30 Jul 2022 06:42:54 +0800
Message-Id: <20220729224254.1798-1-liulin063@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CA+khW7iknv0hcn-D2tRt8HFseUnyTV7BwpohQHtEyctbA1k27w@mail.gmail.com>
References: <CA+khW7iknv0hcn-D2tRt8HFseUnyTV7BwpohQHtEyctbA1k27w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In adjust_scalar_min_max_vals(), let 32bit bounds learn from 64bit bounds
to get more tight bounds tracking. Similar operation can be found in
reg_set_min_max().

Also, we can now fold reg_bounds_sync() into zext_32_to_64().

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

Signed-off-by: Youlin Li <liulin063@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0efbac0fd126..1f5c6e3634d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4383,6 +4383,7 @@ static void zext_32_to_64(struct bpf_reg_state *reg)
 {
 	reg->var_off = tnum_subreg(reg->var_off);
 	__reg_assign_32_into_64(reg);
+	reg_bounds_sync(reg);
 }
 
 /* truncate register to smaller size (in bytes)
@@ -8934,10 +8935,12 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	}
 
-	/* ALU32 ops are zero extended into 64bit register */
-	if (alu32)
+	if (alu32) {
+		/* ALU32 ops are zero extended into 64bit register */
 		zext_32_to_64(dst_reg);
-	reg_bounds_sync(dst_reg);
+	} else {
+		__reg_combine_64_into_32(dst_reg);
+	}
 	return 0;
 }
 
@@ -9126,7 +9129,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							 insn->dst_reg);
 				}
 				zext_32_to_64(dst_reg);
-				reg_bounds_sync(dst_reg);
 			}
 		} else {
 			/* case: R = imm
-- 
2.25.1

