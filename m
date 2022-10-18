Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE21D602DBB
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiJROAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJROAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:00:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29687E00C
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id i6so13880702pli.12
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMwTFgRUP580axj5yBnU9+zFqX7iQ7qQm+gg72pN00U=;
        b=nrfJvUfqAZmFHEqcOJqzxVeuQ1/tnemles2fBA10V3SS931SoqGBuHAnqCk444sMN8
         RDmLkMElB4tVXtUt+iM7qMKHajn/71tuFZwvKpx80jusuN5mQSPa/tg7Tc62aeHXTTig
         F0P0+0Ba957jAcAuIXv7k6nKdQV5jiVQGzyFwBpMcBbKBFl+7N/eEA0+SF47AwTXyKXX
         UT24q2xBrDmAkSLhVj9a+fZsOOSANKlq7ZqQ7Db8Hz3dMG5CpTdYYBQMUeZyK1FihFBh
         d/rPYzPmaiB/q2EGyhdIR9+TQUvVprYJHtg/UMMGx8gW4Xrp0RhW4A2WzebudGkoR/ii
         Sy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMwTFgRUP580axj5yBnU9+zFqX7iQ7qQm+gg72pN00U=;
        b=iOy/YiAybF+CyyhDKa+KdJ319gCns2t5ZF4wSaDv9SxoJznlOCZ45v51odk0a+NA43
         Boa5XMt2ZAYaQgaWMXfWsAL9CMAkbyRXq+MafCQpNR4+YuAsKW57xayes9khIR1ZfNfZ
         cYGFNrB+HUWQ2UjljK4XAjIsoIln8RdR/6ZWHrH4vol0+HWJjzCzrd7fkGDz80O/WFvU
         IYhiQJkcWedejtB6IMT1Xq5fudKptFvCrkNfvbwuUi/ohwNp/tEJpunpLjCsLfmZvPf+
         9ILUu/L1YdhxwvC+aEf7nCeEGR+u8jD9MY9xifkH8Zer65ykipvDav3cmSoph/h64CZ2
         WfPQ==
X-Gm-Message-State: ACrzQf3Embiyf0mZmi3up+eurYX9i1O85bT6k0E1iWu6U1BS8fdOhb55
        Pib1Xv1EZVGJhUlkZ8wdcx7r7suYdzTI9w==
X-Google-Smtp-Source: AMsMyM6MgBo2+79EGOSN/NlitzAShAboW79nTch2GkGhoQVGUiu0fQ6+oaQ2AiUyVgFpE/SSnN69gw==
X-Received: by 2002:a17:902:ec91:b0:182:8eca:ade2 with SMTP id x17-20020a170902ec9100b001828ecaade2mr3150125plg.12.1666101601770;
        Tue, 18 Oct 2022 07:00:01 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id g8-20020a631108000000b00462612c2699sm8139942pgl.86.2022.10.18.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:00:01 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 10/13] selftests/bpf: Add dynptr pruning tests
Date:   Tue, 18 Oct 2022 19:29:17 +0530
Message-Id: <20221018135920.726360-11-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4765; i=memxor@gmail.com; h=from:subject; bh=1+xaYPFvhSVh1B1HYsq6/v3Prh+5k7T7cXmAvII84mA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEiPAEB6C2K8pH+r5ktTXNziLVqwMCWX1BDetV3 c3M3LRmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8Ryn1GD/ 44pHjkwfn3UAXiOH29FsqaJ45G0uxh5OAwKC35TpaeqNxgEP6j17k0Z3ruDC1D6eahSvEB47SIFxRW hPEVS/HQX0ZnYMisc/WvYH9/x5nslF3/mOev3JHXC0hR4xkp0tsNm6cV7gQ0UQ9MfzWb9T/b1u2qYt ekX/pkbo677GUZhM5DZNbKRvyUUE7zR8qIs43gmVX0GnFTk1tMv2GplQQd/osbp072WToOp3dL49Kc dGixqhkHmfouXxc2ehH6Vojvme1yesxS0I7ppoaF8V6uiihNuHdee4J2hDrcoXDaCgHoNUXctZf3SP W6chb7eAEQsP4FOU6JCea5RIDPZnI8OkwOAErC863Y13zd1/8DVgdV6wjRXSGsYmSn0QCaakChIRcC 1LRz1TbE9CJNHNTVfP/xwCpLMTbnYf285Uu/2wPpe265LJ61E9KDCulpTMCQUMK41QmyTj7xwr7JXH ZiWSowSnkDZUt+yeaF42dC0lb5WvTIPsSosGDHexqVhn4dcaSIrkwI0LQcC63WL5Y+8LcptoSkp0Jj utfhWHUkQclG+Z6gtZmam0F/OgO11JD7KRFsj5P8H3PErMwXfXjjFheLLl/zyn8TfX+5Q9y/AROA8D EWvqbjejbfjTvHEWv0NGjfaSNPgj+iqdn4pNXO4kuPGOBD7lkqx5OSv7/90w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add verifier tests that verify the new pruning behavior for STACK_DYNPTR
slots, and ensure that state equivalence takes into account changes to
the old and current verifier state correctly.

Without the prior fixes, both of these bugs trigger with unprivileged
BPF mode.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/dynptr.c | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c

diff --git a/tools/testing/selftests/bpf/verifier/dynptr.c b/tools/testing/selftests/bpf/verifier/dynptr.c
new file mode 100644
index 000000000000..798f4f7e0c57
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/dynptr.c
@@ -0,0 +1,90 @@
+{
+       "dynptr: rewrite dynptr slot",
+        .insns = {
+        BPF_MOV64_IMM(BPF_REG_0, 0),
+        BPF_LD_MAP_FD(BPF_REG_6, 0),
+        BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+        BPF_MOV64_IMM(BPF_REG_2, 8),
+        BPF_MOV64_IMM(BPF_REG_3, 0),
+        BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+        BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
+        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
+        BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+        BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+        BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9F),
+        BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+        BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
+        BPF_MOV64_IMM(BPF_REG_2, 0),
+        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
+        BPF_MOV64_IMM(BPF_REG_0, 0),
+        BPF_EXIT_INSN(),
+        },
+	.fixup_map_ringbuf = { 1 },
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
+	.result = REJECT,
+	.errstr = "arg 1 is an unacquired reference",
+},
+{
+       "dynptr: type confusion",
+       .insns = {
+       BPF_MOV64_IMM(BPF_REG_0, 0),
+       BPF_LD_MAP_FD(BPF_REG_6, 0),
+       BPF_LD_MAP_FD(BPF_REG_7, 0),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+       BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+       BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -24),
+       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9FeB9F),
+       BPF_ST_MEM(BPF_DW, BPF_REG_10, -24, 0xeB9FeB9F),
+       BPF_MOV64_IMM(BPF_REG_4, 0),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+       BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+       BPF_EXIT_INSN(),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+       BPF_MOV64_IMM(BPF_REG_2, 8),
+       BPF_MOV64_IMM(BPF_REG_3, 0),
+       BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
+       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
+       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+       /* pad with insns to trigger add_new_state heuristic for straight line path */
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_JMP_IMM(BPF_JA, 0, 0, 9),
+       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+       BPF_MOV64_IMM(BPF_REG_2, 0),
+       BPF_MOV64_IMM(BPF_REG_3, 0),
+       BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_dynptr_from_mem),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
+       BPF_MOV64_IMM(BPF_REG_2, 0),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
+       BPF_MOV64_IMM(BPF_REG_0, 0),
+       BPF_EXIT_INSN(),
+       },
+       .fixup_map_hash_16b = { 1 },
+       .fixup_map_ringbuf = { 3 },
+       .result_unpriv = REJECT,
+       .errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
+       .result = REJECT,
+       .errstr = "arg 1 is an unacquired reference",
+},
-- 
2.38.0

