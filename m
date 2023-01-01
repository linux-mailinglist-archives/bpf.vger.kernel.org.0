Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFFE65A94C
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjAAIea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAAIe3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:29 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A2A6246
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:28 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so18031343pjk.3
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NdDIoiTNx/8nBOVqwD3u8E3YffJXgMuSkkETx6NZTg=;
        b=UpNMqfvp2AvlTHdU1HZqH6byI+aDb1TdAQ9QXKvSuGVFtCE/DMxNidJ9cLWUsOYr45
         zwYGnUnOYCmgkqHgU4xpDUm+s+odTmTT6mMEVKBqy8QDRc0f3PdMoVJ7YuDn9D3O2KvM
         22XIhoTL/LqJWtrzXsts9uP8Y6jMAgr75ZTc8n+WH5JHgekTJRSmgZMEWS19STo49H8G
         rpzr8L9cPY9Xtx+IssyrWGm2MYnhCUelea0eGZR58CQxEgfOmJiJdXNwjww39uS3PKoz
         tVNTnfVMuXFTBz/NsmM85w/pHtP289uYa/C+CLCNrOs4ryvx4HQ9GUMDsEccowYO5Gel
         32hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NdDIoiTNx/8nBOVqwD3u8E3YffJXgMuSkkETx6NZTg=;
        b=BIXO6Vp2P7QVzH3WWRNi3l+UKmykTZsi/FCiCvCHk4E/R8cfjDxKVsvBkTTBov6A0g
         CMQKJJgoMm3SPBwzb862eAE7KEV7Oox/HCRtWVdfhHeV5duli7mHvAwUEubuBqB/r8Dm
         3gypypekPYoWzP5dWjnSXsyGUJLzph1eDiUM5in+z37aOHjMIihOzgxjjefb2PIy2JC2
         aKzS8SJ9PpTvZhU5MzDNkSfPxGgpqOsgTquQyGiejBwSQk1vvh4jPKc+4OrSbHrTM1Hu
         0VsS5oNVvzOzFAaVD8Wg3N9FrpvOS4LuSrF0pWc8knjV18HGI4Cl1Ud7O9LCBVZr9Ypc
         qPGQ==
X-Gm-Message-State: AFqh2kp2XiC5nK6fwds3bfS/fseCNxs/8gtobYeAJ6/6uxCcqm+Hq4yX
        j8nq9mD6ImNBnIVD3Yo7CidMqIELLmyNwRo4
X-Google-Smtp-Source: AMrXdXvM0d0mRAFgEp1ox0ssPFJNt0GXKI+z2WQP+7ezKQHFsPTYCps/nZWc+2+WKvmg6/nmuG9niA==
X-Received: by 2002:a05:6a20:4f86:b0:b0:3ff8:282e with SMTP id gh6-20020a056a204f8600b000b03ff8282emr22958606pzb.6.1672562068095;
        Sun, 01 Jan 2023 00:34:28 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id q24-20020a631f58000000b0043c732e1536sm15221837pgm.45.2023.01.01.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:27 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 6/8] selftests/bpf: Add dynptr var_off tests
Date:   Sun,  1 Jan 2023 14:04:00 +0530
Message-Id: <20230101083403.332783-7-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558; i=memxor@gmail.com; h=from:subject; bh=jAVWM2AMRTegvbN+p23/XBMDwp6jZopeYu2HCKwy6KY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV1jSkgOHzecyZaWzNkiMCMGj6SooC1TOJO3e+h ypYb0zSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdQAKCRBM4MiGSL8RyhKFEA DDXPtmLxD+VHeRUIJVkehB94qjhpu9DUagT+1vJDu817M2xNiAsvoMQh7LkBV1XAc5NC/N6C6NbOBq 5/CkAN2cXypbQZelKQxLhvzNumZT/tubC5CsaSDu4+zBUCWB97KJ0rKipTyA0PJVq0WMzR1qQ/vnNp HqPAFp+zhcMOugurFxCpoeXI+qGNWCvNveJ0bmz9EOxXTacBCxrtxAj0zggMNDVGOQlq05oaGJZsYr v94wivB1bQbWb3DsK3qAv3J1OBghk3dt179qdaaGBbE6rlTZUropYk1bI95nxUJQX5hsyE/xvcb+KF cESKpxW4fB2XLq4UMxNirAuPMXPg2H/Sn8O/5XpFyuychLqnWZ4igI+0OjkvZVWWVcDDLCfzT5KgI3 ikYoZLNCzgtaAanb5f9DGwfQ8VzO2ZiG3BOxLvUZ1EyxVY6FdH4vW9EBEB7biEZ20FoENxetHZSu4O FA7inxhWXbRi13PrCq3yY0CEMPhg71DEtBSu0u842WTPSIT3xtuj5mk+3f2Ve/WXzmnc/KIGfJsohu 8LoCY/N8D97sjSwjig5d4bDApBykDfrSZCgfHxQNsBpjZj6I4z9iR7NvaScD7vfYWuZsdFgqsSQPmX eW7w6y9wrQ3u40e0JA5oSejaTRAJIYi26I8qL+q0jlTojUG34c49IiHcoo2w==
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

Ensure that variable offset is handled correctly, and verifier takes
both fixed and variable part into account. Also ensure that only
constant var_off is allowed.

Make sure that unprivileged BPF cannot use var_off for dynptr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/dynptr.c | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/dynptr.c b/tools/testing/selftests/bpf/verifier/dynptr.c
index 798f4f7e0c57..1aa7241e8a9e 100644
--- a/tools/testing/selftests/bpf/verifier/dynptr.c
+++ b/tools/testing/selftests/bpf/verifier/dynptr.c
@@ -1,5 +1,5 @@
 {
-       "dynptr: rewrite dynptr slot",
+       "dynptr: rewrite dynptr slot (pruning)",
         .insns = {
         BPF_MOV64_IMM(BPF_REG_0, 0),
         BPF_LD_MAP_FD(BPF_REG_6, 0),
@@ -26,7 +26,7 @@
 	.errstr = "arg 1 is an unacquired reference",
 },
 {
-       "dynptr: type confusion",
+       "dynptr: type confusion (pruning)",
        .insns = {
        BPF_MOV64_IMM(BPF_REG_0, 0),
        BPF_LD_MAP_FD(BPF_REG_6, 0),
@@ -88,3 +88,37 @@
        .result = REJECT,
        .errstr = "arg 1 is an unacquired reference",
 },
+{
+       "dynptr: rewrite dynptr slot (var_off)",
+	.insns = {
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 16),
+	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_10, -4),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_8, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_8, 16, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_8, 16),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_IMM(BPF_REG_2, 8),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9F),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_ringbuf = { 9 },
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R4 variable stack access prohibited for !root, var_off=(0x0; 0x10) off=-32",
+	.result = REJECT,
+	.errstr = "dynptr has to be at the constant offset",
+},
-- 
2.39.0

