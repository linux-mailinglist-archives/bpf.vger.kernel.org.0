Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98A64985D
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 05:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLLEP4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 23:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLLEPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 23:15:54 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6737ECE03;
        Sun, 11 Dec 2022 20:15:53 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q1so7342529pgl.11;
        Sun, 11 Dec 2022 20:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zgyoOcPBhpv3ytDISbkkUvDrkckjoT82+Oh6xRzCzY=;
        b=d++QQSd7i5V5nvaU4P7cqVJUBMbIcivw158VcugJFj6daA4bUO899ijVjwjKAuFnzq
         OyZ0vzReWgAjqiS2qug8765WNNot4H9B+067YroHDa65p83vTuVapWRFbn2uqq/T6vJq
         fEiS/2tcT1QsQ+mribiSdKIIVhgMZcgrWJ9PugjJDwYWleWKW0dWRUYvGzeDDsJFKHzx
         HOfm8UdusugR/TY6rpjQHfa+B2FiXoG/+XsqudhDV8he2Bw9689pR1OMAMCsDly81w7J
         H/FZ08DOsBmnSW1odkCkxXe8Be21fOlKMWM/CX8wIIdynCf38Gbcb1N8sdzQbbtdT8AZ
         kACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zgyoOcPBhpv3ytDISbkkUvDrkckjoT82+Oh6xRzCzY=;
        b=kVditqFpy0Y7JIro8qVquXJkQo4VOidE9NXF5ryA/aD7Lii3ydJc1J5H+TENahnDRX
         dsrw3VW2sBukrNr8lkV2I+HtSDsGQjCbTibk63MpIghXV3rsLziNYFptkU5jKAN0APby
         A2+/cqNTMmgCMqtbQC05+ZNXw8VshmyRZqkALZRqGFXHM/dcllm3pQ/nNVH/vT1xpYIs
         +hUHUcuSeQg5AOPslvbQgoskjY5U3ua3a9xFVDJ9b6ySGZ3lnx2zJnAsLp0Ndii/AV86
         M9yHKpyiiEjuUPw3K7A/+JrN86LlkqJbkxuGGLg5GOZfJEKNn2fmAJmOGGEx+P3oAJob
         twDg==
X-Gm-Message-State: ANoB5pni0uousSrwP5sxwZPyvLYz3NlmMKRTTIHxfXSFQFUsAftyBXDM
        OSVN7Aot4wIrrxHE0Q9TwRKae4lBLSql
X-Google-Smtp-Source: AA0mqf4HcSrhSmPASv5cmUQSAhCkdPlbeyOp1sGs/j0x+0mGCfNMOdjpo6JOLpjpsMiPgA8e7dFrrg==
X-Received: by 2002:a05:6a00:f8c:b0:578:202d:7c21 with SMTP id ct12-20020a056a000f8c00b00578202d7c21mr8412150pfb.12.1670818552626;
        Sun, 11 Dec 2022 20:15:52 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id w15-20020a627b0f000000b0057682f44f8bsm4686805pfc.220.2022.12.11.20.15.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Dec 2022 20:15:52 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: check null propagation only neither reg is PTR_TO_BTF_ID
Date:   Mon, 12 Dec 2022 12:15:47 +0800
Message-Id: <20221212041547.12775-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
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

Verify that nullness information is not porpagated in the branches
of register to register JEQ and JNE operations if one of them is
PTR_TO_BTF_ID.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 .../bpf/verifier/jeq_infer_not_null.c         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
index 67a1c07ead34..b2b215227d97 100644
--- a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
@@ -172,3 +172,25 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.result = ACCEPT,
 },
+{
+	"jne/jeq infer not null, PTR_TO_MAP_OR_NULL unchanged with PTR_TO_BTF_ID reg",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	/* r6 = bpf_map->inner_map_meta; */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),
+	/* r0 = map_lookup_elem(r1, r2); */
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	/* if (r0 == r6) read *r0; */
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_6, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b = { 3 },
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.result = REJECT,
+	.errstr = "R0 invalid mem access 'map_value_or_null'",
+},
-- 
2.38.1

