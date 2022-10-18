Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5EC602DBD
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiJROAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiJROAN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:00:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03989917
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o21so11502936ple.5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag5Q1CLOoCiOe4E6jcNn0D/qd7Ptx/xklL9ZKfmmK+A=;
        b=qhUjJu+zD1mkiVxwGYIonMV5bFwn5kce1chAoBi4/BD7rWjQExtrcuI1Ab/JFYHFzx
         8Myj40S1zxPqPMdHbMviwOOCmtcFzkWx9PFfiDGOZh82ZwbEiGaacbnc3EqtAme/BASm
         YtWYikKTyILD4rE3eScqJjkecvj5t+XBdsGZy/THcoEJBrSv9P2HSE6klvwg1SDFuyqO
         OxsBtW8JZtV4gFASocwwK5iZmAHQhEZXY8JXU8QDTX17bSTiobiIDHc3TeerWs6s090j
         Ry9aLxjni+Dpcy8HWGIF9SrGjIxdowjFVEBT9Kt5v5nvqFBb+dDs2uQ8OPXyZFOjC7dj
         WPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag5Q1CLOoCiOe4E6jcNn0D/qd7Ptx/xklL9ZKfmmK+A=;
        b=HA7UdhHgdtB+LAQ5D/pOK9s2e6ehVbi+LRUqW+C0qfmV7u4CTLiDRRlAVGJk8wqt88
         PDZRhxwSScgNb9Sm2kCGILUPWkeMXZju0yt7TFXmE69rDIrEdPvuqqa6wcNCcV6nYVKP
         k4jPpJMI87sjHTeG1bG7yNjDdDTiZyr1QJKmzyISeQ1t9/mZVHGc+dWeq9w8BUy0gaj8
         0xExHMcQ56r9CVfuT6lmq8LMsyqEy1qn7cWgCaIF96y21WDusMjwJ6LZWbpfDd4LfycO
         S5tMIgnvTS/rVcD/UF30zTHeHBtuLIRaR/6x18c8KEccO/V44Xwe7da8CUlP6PZeAjht
         gzYg==
X-Gm-Message-State: ACrzQf0Sh/lZ6x8Hu01iHk//ag+E/v6okf2hkpjvUeYx5iKaMEp0d4bl
        dd3ZEESgkXFpBfAxwhTh0U7NaphBCjbKSQ==
X-Google-Smtp-Source: AMsMyM701Bvaj0M+7dOsyvshR6cbSw/3T3zyDuY3p4d/4fMvQh4O4Xye/MyXjgNWdsnfaUXBO9RXQw==
X-Received: by 2002:a17:902:70c4:b0:17c:f9fe:3200 with SMTP id l4-20020a17090270c400b0017cf9fe3200mr3181546plt.1.1666101608156;
        Tue, 18 Oct 2022 07:00:08 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id y17-20020a634951000000b0046a1c832e9fsm7984183pgk.34.2022.10.18.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:00:07 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 12/13] selftests/bpf: Add dynptr partial slot overwrite tests
Date:   Tue, 18 Oct 2022 19:29:19 +0530
Message-Id: <20221018135920.726360-13-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=memxor@gmail.com; h=from:subject; bh=n6R+Kc1fES01TnB4BRh9DyPo8cyoSpbfFQ92Z+ogpQs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEisz4QmcCQCAZzWRRCitFtyC0TyN/Ktw/4AGj1 M8MjLPCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RygqLD/ 9QfwP93D/WXJFoPCG3bJPrZyXwpZ/DgkKrS87ShMMX16qX8rFaKRL6SlKZ/+HNj0sguzTVGFZSX1Qj vKHTJufxj6kKnwIn8TwCQakxRcDqiLR9909TqGxrN2/lBbxrDTO/RcGjwdWmbjkgWwUBQJuKlJVI6s UCqoTnkJ4Aqt0mUmaZ08lOo2ajw9tXRhSMTDa/G2O5OUJZdqYmk4Lhsomawg2kdHMJcNEsquoQY6at Gg+wjcfFQE+in1+n7U2/dz7FXB9LozMPMvrIYe+hpzZpEaFVoxXZHy9Yc7fM1Zze4iTWkvObFGLA5M Z4GTox0VBSQ1a6AXP3eYFrtUXEdR9mXK+of8XpMPa5/7nrQ6K7eAQhX5RLVM+kH6FKJf6H/JCKGsXQ V6QUAkHISdFaIkZLqdMen8lvOjfjR/mfS6j3nZiyRD9nKKmAZ6cN6wlhPlWWMeOd9CfY1Lanx16T47 cvZ7ik0WleotXZHINejIn0YcaNhE2GDG81b8e7mHOfnNsSMHMwjbFP21vg0Tq3TFHxWN8iCBP57rvM eQXBpjK8Ej/h+ZlXRaOAZeP22JTCReQ0YZUFqVhC3Yk1dtiLcy4GVJhNRnOa2p3j9b0ww7ilcn7Ozc CgqMJmJF0QL9pCDFJPvH87rjROSCx2g3jOWJyVImKfcMI+HTnrBuB/kUt9JQ==
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

Try creating a dynptr, then overwriting second slot with first slot of
another dynptr. Then, the first slot of first dynptr should also be
invalidated, but without our fix that does not happen. As a consequence,
the unfixed case allows passing first dynptr (as the kernel check only
checks for slot_type and then first_slot == true).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/dynptr.c | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/dynptr.c b/tools/testing/selftests/bpf/verifier/dynptr.c
index 1aa7241e8a9e..8c57bc9e409f 100644
--- a/tools/testing/selftests/bpf/verifier/dynptr.c
+++ b/tools/testing/selftests/bpf/verifier/dynptr.c
@@ -122,3 +122,61 @@
 	.result = REJECT,
 	.errstr = "dynptr has to be at the constant offset",
 },
+{
+       "dynptr: partial dynptr slot invalidate",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_LD_MAP_FD(BPF_REG_7, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_IMM(BPF_REG_2, 8),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -24),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_MOV64_IMM(BPF_REG_2, 8),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_dynptr_from_mem),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -512),
+	BPF_MOV64_IMM(BPF_REG_2, 488),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -24),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	BPF_MOV64_IMM(BPF_REG_5, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_dynptr_read),
+	BPF_MOV64_IMM(BPF_REG_8, 1),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_MOV64_IMM(BPF_REG_8, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -24),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_ringbuf = { 1 },
+	.fixup_map_hash_8b = { 3 },
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
+	.result = REJECT,
+	.errstr = "Expected an initialized dynptr as arg #3",
+},
-- 
2.38.0

