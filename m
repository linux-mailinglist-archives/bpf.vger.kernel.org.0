Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450805A3805
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiH0N5p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0N5o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 09:57:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC03AB09;
        Sat, 27 Aug 2022 06:57:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so3851729pgs.3;
        Sat, 27 Aug 2022 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=g37hXBDxa4gAGFGLqqielVPHOcCQvgMHWIbRrDd8m/Y=;
        b=F07IXbBU8wh/m/PCqmLQzhJR9I4XzxWT/tBBYt8bTyzZYpV8t5VCuCue3V1XjQ8qBU
         kzKPBhZeshE46mZuxnfVqfl5o/OkbiZqIqswrx09+ucorNH9DYnsvcOZa+unp6e+lAuX
         lDp84vOnZ25bRNAC94ftUBX7wHnz7UK4KstyUaWPNOCiki9GSN9EibPXZc0u3TA4L3xv
         doJx3qvp1+tv4xFjZCXiK4f/0u9z0ezmdRTmYyV5rg2NsyQUkojeUwnwywCPS5yKYlpd
         oVQr6Ms1Toky02MrBBkjzCaoQdI2k+1Q9G+4T3PxyLghHsXpA1uppahk57cZIrexIOoP
         Ndug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=g37hXBDxa4gAGFGLqqielVPHOcCQvgMHWIbRrDd8m/Y=;
        b=xYj4htPEENl/ZB6XTiQgpQqXriJL97X5tY7TVuZv+Dfj35boISM+FSYHTnT7wFU005
         hRt5ecSYCcRSv0JvX6iDvZqRPQODB2Jcqquz3d+oJFB2gzcDoK6EBAG3YdYLISJDrTz4
         leYoOC7OoD2CfKD8MVGq457cYYCJlC5XKxuSpEXl0ieWz7iHJ0ac/iRDF1XrHsJgxXwQ
         7i0qGfC7A+URfMWSlj3xqGSlwedjmzAxFXI5xjNJWXjoZqLFzh9Z10/aNDePFjwMcdtk
         6CSaA8z1Ac0jZWKM5D6dwv6UABAve2G248htlpNwKfBSIRNI/EccNJuZpbabGJyl0ZXL
         A62w==
X-Gm-Message-State: ACgBeo3AXaaUd6H0kl5AexaO5VeMOGSb1/TcSgEJYR4jED4jPU0zfIxs
        nMCDaMC+VRH4diYJOu6W2pI=
X-Google-Smtp-Source: AA6agR5KOIJ82rCC0BIKftcAN7uD205uJmdj0ilFp4i6CdPgvWGs6wVTFne7DqipMq26jU9HXRDoTg==
X-Received: by 2002:a05:6a00:e8f:b0:536:c98e:8307 with SMTP id bo15-20020a056a000e8f00b00536c98e8307mr8514274pfb.73.1661608659337;
        Sat, 27 Aug 2022 06:57:39 -0700 (PDT)
Received: from Kk1r0a.localdomain ([15.235.171.180])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902c60b00b0016bdcb8fbcdsm3656106plr.47.2022.08.27.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 06:57:38 -0700 (PDT)
From:   Youlin Li <liulin063@gmail.com>
To:     daniel@iogearbox.net, haoluo@google.com
Cc:     ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Youlin Li <liulin063@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: Do more tight ALU bounds tracking
Date:   Sat, 27 Aug 2022 21:57:11 +0800
Message-Id: <20220827135711.21507-1-liulin063@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5d2addca-10e5-f7a6-9efd-43322eec8347@iogearbox.net>
References: <5d2addca-10e5-f7a6-9efd-43322eec8347@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In adjust_scalar_min_max_vals(), let 32bit bounds learn from 64bit bounds
to get more tight bounds tracking. Similar operation can be found in
reg_set_min_max().

Note that we cannot simply add a call to __reg_combine_64_into_32(). In
previous versions of the code, when __reg_combine_64_into_32() was
called, the 32bit boundary was completely deduced from the 64bit
boundary, so there was a call to __mark_reg32_unbounded() in
__reg_combine_64_into_32(). But in adjust_scalar_min_max_vals(), the 32bit
bounds are already calculated to some extent, and __mark_reg32_unbounded()
will eliminate these information.

Simply copying a code without __mark_reg32_unbounded() should work.

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
v1 -> v2:
    Replaced the call to __reg_combine_64_into_32() with the code in
    __reg_combine_64_into_32(), and removed the call to
    __mark_reg32_unbounded().

Sorry for the delay, I've been busy looking for a job recently :)

 kernel/bpf/verifier.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3eadb14e090b..b7403773e834 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4383,6 +4383,7 @@ static void zext_32_to_64(struct bpf_reg_state *reg)
 {
 	reg->var_off = tnum_subreg(reg->var_off);
 	__reg_assign_32_into_64(reg);
+	reg_bounds_sync(reg);
 }
 
 /* truncate register to smaller size (in bytes)
@@ -9010,10 +9011,22 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	}
 
-	/* ALU32 ops are zero extended into 64bit register */
-	if (alu32)
+	if (alu32) {
+		/* ALU32 ops are zero extended into 64bit register */
 		zext_32_to_64(dst_reg);
-	reg_bounds_sync(dst_reg);
+	} else {
+		if (__reg64_bound_s32(dst_reg->smin_value) &&
+		    __reg64_bound_s32(dst_reg->smax_value)) {
+			dst_reg->s32_min_value = (s32)dst_reg->smin_value;
+			dst_reg->s32_max_value = (s32)dst_reg->smax_value;
+		}
+		if (__reg64_bound_u32(dst_reg->umin_value) &&
+		    __reg64_bound_u32(dst_reg->umax_value)) {
+			dst_reg->u32_min_value = (u32)dst_reg->umin_value;
+			dst_reg->u32_max_value = (u32)dst_reg->umax_value;
+		}
+		reg_bounds_sync(dst_reg);
+	}
 	return 0;
 }
 
@@ -9202,7 +9215,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							 insn->dst_reg);
 				}
 				zext_32_to_64(dst_reg);
-				reg_bounds_sync(dst_reg);
 			}
 		} else {
 			/* case: R = imm
-- 
2.25.1

