Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B431E8519
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgE2Rhn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgE2Rhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 13:37:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A383C0A88B4
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:28:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nm22so900229pjb.4
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BybVUlqaPGJwIFa9o/WOHmSnqcN8QLmxnLu4HO0AETk=;
        b=mEYeOEcopiALNxvKzHrxmAAEQr5roeQY26s5t6cfVNJFN3K+rnaCHWI43x5Ev26eXt
         OL0Gg/geCbrxKouAb1y+3cbhykpWjDVrugfYO6qIGXumx6tBWj+tYT5MjGJtny/v/YP+
         LpQgGySxrKpfRmKA2jEEE0t3BtpSInmnoXjU8QEBhLijYdLqSyOtjkr1XmFV/BH7MoB1
         3iU4/39r2YA7hrIIjgwhWSm8qmW+MbRSA3q1/J1g0cdw2CULEIDmAt60PU3fliuMEot5
         +DTUJyizAHXZ2AnW+6X6vmeQkSWWY/l+2AKnb9qIl56FwPEsy9EAbsTZc8dd7fGaAmmi
         cduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BybVUlqaPGJwIFa9o/WOHmSnqcN8QLmxnLu4HO0AETk=;
        b=MUeqPEZkvyTpZHNM4pHrD0osYg8cp9MUw6dEqkKXkx/Zc5VMlcrr6JYWD5XkC47D7M
         VqqAHjX5wxan0jHVfrLQmo2PXruQ8urI3adImm/Rj8An0ro3WkSqN7LH4Bz4cseNIWsp
         P/7PR1kZmuBSyOpL3mq8KfInipRFdXrHDPKMDbRJ4WTMRgiXGsXVXeghen5DSpEQDWTw
         6KeuePpVygnDL2VpH34vTIhTlYLBTOF7NlWhrGxYttW8uxHtv7Dy1dsFIbNFSRVjMuuK
         jm0YgHL+aFw4rKtsF/23289Yv2/oVhN66ewWryEJDxkOqMvW5s2B9SDpmLFy3a9xVaAg
         RP4g==
X-Gm-Message-State: AOAM530E2J6KIq2kbUNT5Ch2Nzd63daseTzpgWSHvgng4JlChrUT7+wU
        rF58QtfCyVY+uCbKzujr+Gs=
X-Google-Smtp-Source: ABdhPJxzG9InmlaJMnMpTb377/jq3/tPH+YxmJ+sCS8D5O30BAerCgyL2Y9iBKYWWuqpmcbEE31gUQ==
X-Received: by 2002:a17:902:8210:: with SMTP id x16mr9607386pln.284.1590773333033;
        Fri, 29 May 2020 10:28:53 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id e16sm7286351pgg.8.2020.05.29.10.28.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 10:28:52 -0700 (PDT)
Subject: [bpf PATCH 1/3] bpf: fix a verifier issue when assigning 32bit reg
 states to 64bit ones
From:   John Fastabend <john.fastabend@gmail.com>
To:     yhs@fb.com, alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, john.fastabend@gmail.com, kernel-team@fb.com
Date:   Fri, 29 May 2020 10:28:40 -0700
Message-ID: <159077331983.6014.5758956193749002737.stgit@john-Precision-5820-Tower>
In-Reply-To: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
References: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the latest trunk llvm (llvm 11), I hit a verifier issue for
test_prog subtest test_verif_scale1.

The following simplified example illustrate the issue:
    w9 = 0  /* R9_w=inv0 */
    r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
    r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
    ......
    w2 = w9 /* R2_w=inv0 */
    r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
    r6 += r2 /* R6_w=inv(id=0) */
    r3 = r6 /* R3_w=inv(id=0) */
    r3 += 14 /* R3_w=inv(id=0) */
    if r3 > r8 goto end
    r5 = *(u32 *)(r6 + 0) /* R6_w=inv(id=0) */
       <== error here: R6 invalid mem access 'inv'
    ...
  end:

In real test_verif_scale1 code, "w9 = 0" and "w2 = w9" are in
different basic blocks.

In the above, after "r6 += r2", r6 becomes a scalar, which eventually
caused the memory access error. The correct register state should be
a pkt pointer.

The inprecise register state starts at "w2 = w9".
The 32bit register w9 is 0, in __reg_assign_32_into_64(),
the 64bit reg->smax_value is assigned to be U32_MAX.
The 64bit reg->smin_value is 0 and the 64bit register
itself remains constant based on reg->var_off.

In adjust_ptr_min_max_vals(), the verifier checks for a known constant,
smin_val must be equal to smax_val. Since they are not equal,
the verifier decides r6 is a unknown scalar, which caused later failure.

The llvm10 does not have this issue as it generates different code:
    w9 = 0  /* R9_w=inv0 */
    r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
    r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
    ......
    r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
    r6 += r9 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
    r3 = r6 /* R3_w=pkt(id=0,off=0,r=0,imm=0) */
    r3 += 14 /* R3_w=pkt(id=0,off=14,r=0,imm=0) */
    if r3 > r8 goto end
    ...

To fix the above issue, we can include zero in the test condition for
assigning the s32_max_value and s32_min_value to their 64-bit equivalents
smax_value and smin_value.

Further, fix the condition to avoid doing zero extension bounds checks
when s32_min_value <= 0. This could allow for the case where bounds
32-bit bounds (-1,1) get incorrectly translated to (0,1) 64-bit bounds.
When in-fact the -1 min value needs to force U32_MAX bound.

Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2e27db..d0bdd55 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1217,14 +1217,14 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
 	 * but must be positive otherwise set to worse case bounds
 	 * and refine later from tnum.
 	 */
-	if (reg->s32_min_value > 0)
-		reg->smin_value = reg->s32_min_value;
-	else
-		reg->smin_value = 0;
-	if (reg->s32_max_value > 0)
+	if (reg->s32_min_value >= 0 && reg->s32_max_value >= 0)
 		reg->smax_value = reg->s32_max_value;
 	else
 		reg->smax_value = U32_MAX;
+	if (reg->s32_min_value >= 0)
+		reg->smin_value = reg->s32_min_value;
+	else
+		reg->smin_value = 0;
 }
 
 static void __reg_combine_32_into_64(struct bpf_reg_state *reg)

