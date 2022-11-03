Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8101A617A09
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 10:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKCJe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCJe5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 05:34:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98522DF78
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 02:34:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g62so1075905pfb.10
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QbGEY4J71OX2r9n4LqKfmPqOIgB9erqJsHB6/sGCpk=;
        b=DaO5+jedHAQSK3ekGj9SQTlNTTjLyRU/JhTf1qoRfBrFF61AV8FSiEezJ8Urv6GRpd
         IBxuEfAcqIGlgDVO8Dzs59mJh/iz1xQcaGfjJTuvBnfogaM/v4qcWx94i6p5ZNncWCTX
         djm/s0FlokRR8lZZ/crUHDjxcA2fVvZcnFlpywrD99IOGFNajYtj4w7S1B0ofddJlP3F
         IBeGjX1OXcoh7F1rozq7IEBGtYj4NCAYdZMtO+i5TyNdFOfDu1l7BuvI29r6McOnH4NE
         3MrFFeIoj1gU4tWpieUA1Xt5YxlENQWIi4aXnQD7fSBXtdxlKPmBsEG7mOGSPLJnlEf4
         yCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QbGEY4J71OX2r9n4LqKfmPqOIgB9erqJsHB6/sGCpk=;
        b=lzvegOw8H2GCTZMcXTjaVPQTQlHqEJ1+WXLWwMnOGPnYgpMBIgXR0cNZN/ljapbuK/
         K8B0iZjRevFNtLg7TjCG0jW7Q+gKE2ek2JtKxT9Lckp79XZQdJf7VmEQUWOWbNtx2V8l
         e9NM9riKfT1MNIW28SYltNeilgNnrbWn9cjmrxjt7lQjB9JU5TDfT642O5BQvUgJ+vhy
         XOrEr13xZTmeYfd8yLp7ewW+qAKVshMGNM4i+cct6KnfnS35kJCvdcft/qtYnj+2PFAH
         Qy5yqa/eYAgXn3izbIYpo3UxWSPq/dyUesfneBfAY/h6whhPBxzpNlACkn8hyqaNQ8Uk
         Td6g==
X-Gm-Message-State: ACrzQf1GFBiqknbNKJUIjBRyI/gBxrdGkR+4beWOQ/o1IbI6g0spSDpu
        Tj9fCMOifeIOB4NWzB7jl1JKyJ4bMwEHxBGKLJI=
X-Google-Smtp-Source: AMsMyM6vTWfs1HirVaFhEOcSQnXCzvAPkz1CRgCDz0AkDUVAuyBZJvi6cPDk17AczVtN9THiaafHmQ==
X-Received: by 2002:a05:6a00:1251:b0:56d:cabd:7207 with SMTP id u17-20020a056a00125100b0056dcabd7207mr12447923pfi.45.1667468095983;
        Thu, 03 Nov 2022 02:34:55 -0700 (PDT)
Received: from k1r0aKuee.localdomain ([20.255.2.235])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b0018668bee7cdsm177786plg.77.2022.11.03.02.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:34:55 -0700 (PDT)
From:   Youlin Li <liulin063@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, Youlin Li <liulin063@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add verifier test for release_reference()
Date:   Thu,  3 Nov 2022 17:34:40 +0800
Message-Id: <20221103093440.3161-2-liulin063@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103093440.3161-1-liulin063@gmail.com>
References: <20221103093440.3161-1-liulin063@gmail.com>
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

Add a test case to ensure that released pointer registers will not be
leaked into the MAP.

Before fix:
./test_verifier 984
    984/u reference tracking: try to leak released ptr reg FAIL
    Unexpected success to load!
    verification time 67 usec
    stack depth 4
    processed 23 insns (limit 1000000) max_states_per_insn 0 total_states 2
    peak_states 2 mark_read 1
    984/p reference tracking: try to leak released ptr reg OK
    Summary: 1 PASSED, 0 SKIPPED, 1 FAILED

After fix:
./test_verifier 984
    984/u reference tracking: try to leak released ptr reg OK
    984/p reference tracking: try to leak released ptr reg OK
    Summary: 2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Youlin Li <liulin063@gmail.com>
---
 .../selftests/bpf/verifier/ref_tracking.c     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index f18ce867271f..fd683a32a276 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -1044,3 +1044,39 @@
 	.result_unpriv = REJECT,
 	.errstr_unpriv = "unknown func",
 },
+{
+	"reference tracking: try to leak released ptr reg",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+		BPF_LD_MAP_FD(BPF_REG_1, 0),
+		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
+
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_LD_MAP_FD(BPF_REG_1, 0),
+		BPF_MOV64_IMM(BPF_REG_2, 8),
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+		BPF_EMIT_CALL(BPF_FUNC_ringbuf_reserve),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_EMIT_CALL(BPF_FUNC_ringbuf_discard),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+
+		BPF_STX_MEM(BPF_DW, BPF_REG_9, BPF_REG_8, 0),
+		BPF_EXIT_INSN()
+	},
+	.fixup_map_array_48b = { 4 },
+	.fixup_map_ringbuf = { 11 },
+	.result = ACCEPT,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R8 !read_ok"
+},
-- 
2.25.1

