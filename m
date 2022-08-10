Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E6D58EA44
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiHJKJd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 06:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHJKJc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 06:09:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE3C7436C;
        Wed, 10 Aug 2022 03:09:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ha11so14282767pjb.2;
        Wed, 10 Aug 2022 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KcmHJefryIxAiZBfRnjU5qecxx/rK/aM8Ha7CjqQQlM=;
        b=kl9I5pFTBuw8+Sq/Ag3aM7mTJ5MLA87i5Gfma9VL28i8mEyo3paDft6pqNfwPFymh1
         GpId3pzgxWlizyKFgwYUbll3+ujOc6y/3/Gp9cQgpaZ/eTnE7wjdZhgNSZFdmBTtxK61
         2Mz0IE3lJVhLRPQe7OZDWeBIfS2dzsfHcGXazSTqfc+0M4XJlfeFNtfEef5d9GRyRVax
         N3XXmD2S2gfla77WbiDUdzw8t64Ih8vjbgvXu9K8TYxupixwOmXCWf1Q+o0/l0Ekt134
         4vSfLF3wFlVTAW/RxCb+MqrL0HueRNw1dBb4faPZ3axwbb3JKIzdATZR2dcnHvj6ndHl
         PwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KcmHJefryIxAiZBfRnjU5qecxx/rK/aM8Ha7CjqQQlM=;
        b=hMleyo0ceLtYuiythbgw1Uaqegjfaz1OkPCjyM06zasSOPjlJJHAaWhD0RRzuTlr8s
         cRm4nP8ZYAP1DmiCrq3VMb5Q2V89UNB6PMrdx6qYdYK1ScUBtxMc26j6fWL0sRpy9vtb
         dV7+n1DUZwfXaXHtSYoWMzQbOYR8c2UMhXarPfzAXXNIMBjPBqukL/9Od9fL17O2eerO
         SrS/5EsP4Z07Dosl4QbP55hYvEwxcQom4NpK6Bb8Xxxs7NG0aFdGChHN7oTZ+Tf/DmGY
         /no55C+vec0mOWEB9xt2OUpvDpzXxcRfsJmjrzIiUXRp2XPTEg+mRFsSxPUPHIBcxdbO
         n9Ww==
X-Gm-Message-State: ACgBeo10zY6km5Ax+VaVFcntC8dbCrAXqC+w6BpUn9/SsldTL1bIV1F0
        FS27c1GvaX4XVw1nnkvQ96JcOzdWi8urCRdp6GU=
X-Google-Smtp-Source: AA6agR6wtwY1QyETP8dUDItPiaXa+PCUBe3tyGDvEncw3AU5xVc2av6Ipq/lvr9tra0aSXfTky4wow==
X-Received: by 2002:a17:90a:fd82:b0:1f7:2cb2:e369 with SMTP id cx2-20020a17090afd8200b001f72cb2e369mr3023151pjb.134.1660126171611;
        Wed, 10 Aug 2022 03:09:31 -0700 (PDT)
Received: from Kk1r0a.localdomain ([20.205.61.210])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0016f8e8032c4sm11379778plp.129.2022.08.10.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:09:31 -0700 (PDT)
From:   Youlin Li <liulin063@gmail.com>
To:     daniel@iogearbox.net, haoluo@google.com
Cc:     ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Youlin Li <liulin063@gmail.com>
Subject: [PATCH 2/2] bpf, selftests: Add verifier test case for ALU64
Date:   Wed, 10 Aug 2022 18:09:19 +0800
Message-Id: <20220810100919.26447-1-liulin063@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9f954e67-67fc-e3b9-d810-22bfea95d2aa@iogearbox.net>
References: <9f954e67-67fc-e3b9-d810-22bfea95d2aa@iogearbox.net>
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

Add a test case to ensure that 32-bit bounds can be learned from 64-bit
bounds when performing 64-bit ALU operations.

Make use of dead code elimination, so that we can see the verifier
bailing out on unmodified kernels.

Before:
    ./test_verifier 165
    #165/p 32-bit bounds update in ALU64 FAIL
    Failed to load prog 'Permission denied'!
    R2 !read_ok
    verification time 49 usec
    stack depth 0
    processed 8 insns (limit 1000000) max_states_per_insn 0 total_states
    0 peak_states 0 mark_read 0
    Summary: 0 PASSED, 1 SKIPPED, 1 FAILED

After:
    ./test_verifier 165
    #165/p 32-bit bounds update in ALU64 OK
    Summary: 1 PASSED, 1 SKIPPED, 0 FAILED

Signed-off-by: Youlin Li <liulin063@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bounds.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index 33125d5f6772..b9aee2f2c66e 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -753,3 +753,20 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
+{
+	"32-bit bounds update in ALU64",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_1, 63),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 2),
+	BPF_JMP32_IMM(BPF_JGE, BPF_REG_1, 1, 1),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_JMP32_IMM(BPF_JLE, BPF_REG_1, 2, 1),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_EXIT_INSN()
+	},
+	.result = ACCEPT,
+},
-- 
2.25.1

