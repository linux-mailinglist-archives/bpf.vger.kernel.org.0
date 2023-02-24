Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F1D6A157C
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 04:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBXDko (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 22:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBXDkn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 22:40:43 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7E64FC8C
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 19:40:42 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t18-20020a170902e85200b0019c91fd0967so5068811plg.20
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 19:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tz/fgJduKsVCOU3o92NlRuL4rbz7T6tbZlMwZgCQlZA=;
        b=YQm24ux8aqXaHfxAZO+kBkwkXuWzed/yCs1ecIlfFHNmN3YbzYPnUy5Y5cN62A/miI
         FlUaJloJJDV1jAS8Cw5njmoI2Paddj+qFcvV1ZXi7/g6OiJMgt0dLGxBdegHQ3TDEKYN
         ivEFmmT5Aple1wz6w/mui8hHnWiDWBtap4WWfKOlEoSrz1TYn3tu8jKkLZj0wBZ3T56O
         +t+yQJiE+/mUexfNoupTGkpVp+sWLum8gFa/cwCTmW1Tn3SfHoCC7nr2HbJZyjEMM0MD
         aQOT7R7q/IrvAYkWh/2d2jT9TsPLTiItjoPlGuR4G96g3YUqyYSoE8Po4CWJz10DI40W
         L6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tz/fgJduKsVCOU3o92NlRuL4rbz7T6tbZlMwZgCQlZA=;
        b=xOT0uohqys+8jbiHO/dxo940Ikfyp5l9nHzatMJR6tOs9uOZ4TnCJiepzYJQCnuuE8
         hjIEWZwamDRnTesfwCGYud4PbE0knSdZJIhEt9i2z/IyQNCk+DELYzUc98XVy9dewnpW
         ZDuFeVaLIcOudjrpUQTGiqD1c36HxRRRbpY6GixCa7e9G0jTDp+jh1dsnA89cyqb7J0e
         agxv0g4cIjxpVe0Pah1wCZN+OPiiXt6zQS37gn7JEoj7lg7r+OP4DGyy/KIETpl9bcWe
         +pz6KS7CLsIQ8QKwV/2AotAE0D8dydrsxTFWe/uyLGBLe6qPr4q1TTUiNjP4D3Zo4h+i
         Cyfg==
X-Gm-Message-State: AO0yUKVoFt/lq+AkZxjVkExTeV4QhTkM0rLDGgGaNlLM9ovTUwGeaD0j
        zMHlACYcaUjzIGSrRupB0Jc1Ef/dAQA=
X-Google-Smtp-Source: AK7set8Y74VoWYiHplekedhR9miefSOxqdya1d+JkmMLyRnHZ+UkVnfNrNE/F4+Hlf+xCYbNh9yLqGcN9Bo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a62:ce0c:0:b0:5aa:72b4:2fe1 with SMTP id
 y12-20020a62ce0c000000b005aa72b42fe1mr2592075pfg.1.1677210041847; Thu, 23 Feb
 2023 19:40:41 -0800 (PST)
Date:   Fri, 24 Feb 2023 03:40:16 +0000
In-Reply-To: <20230224034020.2080637-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230224034020.2080637-1-edliaw@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224034020.2080637-2-edliaw@google.com>
Subject: [PATCH 4.14 v3 1/4] bpf: Do not use ax register in interpreter on div/mod
From:   Edward Liaw <edliaw@google.com>
To:     stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     bpf@vger.kernel.org, kernel-team@android.com,
        Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

Commit c348d806ed1d3075af52345344243824d72c4945 upstream.

Partially undo old commit 144cd91c4c2b ("bpf: move tmp variable into ax
register in interpreter"). The reason we need this here is because ax
register will be used for holding temporary state for div/mod instruction
which otherwise interpreter would corrupt. This will cause a small +8 byte
stack increase for interpreter, but with the gain that we can use it from
verifier rewrites as scratch register.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
[cascardo: This partial revert is needed in order to support using AX for
the following two commits, as there is no JMP32 on 4.19.y]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
[edliaw: Removed redeclaration of tmp introduced by patch differences
between 4.14 and 4.19]
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/core.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5d649983de07..4ddb846693bb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -663,9 +663,6 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 	 * below.
 	 *
 	 * Constant blinding is only used by JITs, not in the interpreter.
-	 * The interpreter uses AX in some occasions as a local temporary
-	 * register e.g. in DIV or MOD instructions.
-	 *
 	 * In restricted circumstances, the verifier can also use the AX
 	 * register for rewrites as long as they do not interfere with
 	 * the above cases!
@@ -1060,22 +1057,22 @@ static unsigned int ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn,
 	ALU64_MOD_X:
 		if (unlikely(SRC == 0))
 			return 0;
-		div64_u64_rem(DST, SRC, &AX);
-		DST = AX;
+		div64_u64_rem(DST, SRC, &tmp);
+		DST = tmp;
 		CONT;
 	ALU_MOD_X:
 		if (unlikely((u32)SRC == 0))
 			return 0;
-		AX = (u32) DST;
-		DST = do_div(AX, (u32) SRC);
+		tmp = (u32) DST;
+		DST = do_div(tmp, (u32) SRC);
 		CONT;
 	ALU64_MOD_K:
-		div64_u64_rem(DST, IMM, &AX);
-		DST = AX;
+		div64_u64_rem(DST, IMM, &tmp);
+		DST = tmp;
 		CONT;
 	ALU_MOD_K:
-		AX = (u32) DST;
-		DST = do_div(AX, (u32) IMM);
+		tmp = (u32) DST;
+		DST = do_div(tmp, (u32) IMM);
 		CONT;
 	ALU64_DIV_X:
 		if (unlikely(SRC == 0))
@@ -1085,17 +1082,17 @@ static unsigned int ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn,
 	ALU_DIV_X:
 		if (unlikely((u32)SRC == 0))
 			return 0;
-		AX = (u32) DST;
-		do_div(AX, (u32) SRC);
-		DST = (u32) AX;
+		tmp = (u32) DST;
+		do_div(tmp, (u32) SRC);
+		DST = (u32) tmp;
 		CONT;
 	ALU64_DIV_K:
 		DST = div64_u64(DST, IMM);
 		CONT;
 	ALU_DIV_K:
-		AX = (u32) DST;
-		do_div(AX, (u32) IMM);
-		DST = (u32) AX;
+		tmp = (u32) DST;
+		do_div(tmp, (u32) IMM);
+		DST = (u32) tmp;
 		CONT;
 	ALU_END_TO_BE:
 		switch (IMM) {
-- 
2.39.2.637.g21b0678d19-goog

