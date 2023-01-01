Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA765A94F
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAAIef (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAAIed (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:33 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3136246
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:32 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id o2so21444475pjh.4
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhmoW+YWhQSTnzAriplvw885Int1P6BKhpLh33MyrW0=;
        b=q3c3Oy9CRDV44M/uwCnfZElSL4V+9OhsCsQCPtyGL+dJCA9qvSXV8XwxhXRIKdhJut
         CF7D8yXkDIr81eZXo03ZPWjcsB14JOWpuFzvm4XXlXdIh+2BiY0wGWe+tVH7dqCO/Ixc
         ppJij2/flb6DBGCxXsGtNKlMKVJ3nXrp+hMZrBoQZuXTbHGMe3So4Ef4qL/us7xCYZSQ
         JpUzMLi2FnA/nUISC9bTa47U8BbD51FhtTT/RPwofuTjpcge60mRx8tmF9DAAanDViXR
         IrCpJQiBz9hwLigM3wPLlTyfxO2acStgorEH9N63ZUaFJC9QuEvjHPeyjSdjfsZOJpzV
         WWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhmoW+YWhQSTnzAriplvw885Int1P6BKhpLh33MyrW0=;
        b=PBGCFJhkipxjSgMiWV3Jh+ncPIEs67UxBFOJ+GYjit3EL16++z1o/OvBY6a1t9asrL
         vxdOeSpItDpg+GxOwIvUHTNir6j32ffc0JyWj2NqHAwxlc4GbErLoL1PyXr/+H+B22vh
         KgLVchvlzVS4iG1GtbX+O4e277+0fo9NjOQBcMbYu6brZX67r/M6Ui6n0w9jHAZGjoC3
         5MkBaw6sXrrTe5ZxC+8AwaQq6wb62gFpGuo+CFOZy64gjkEY4erp3THS66egoTEl9nvd
         +qBOtVwayScC8IEFiFvt+lBv2DISTiQv3YDh+ldMqx+ad5T4U5sEvRH6gMJgXJkF+tLN
         GQmA==
X-Gm-Message-State: AFqh2kp4V6Jo4RrGChM425FQOAunTR2Bis5TN8I6BGQFnX5vD97SqIbz
        dZuhBpNJ5YuBBiQjXjoS22ATYiXW32hJOW2c
X-Google-Smtp-Source: AMrXdXvbUMkThEY24D68Cps5WWhI98nDXwN8E9OC/Kt+2x/T8mvWabVUB7aLr9nwmlc5RxIZiluJzw==
X-Received: by 2002:a05:6a20:c110:b0:a3:5a61:20ef with SMTP id bh16-20020a056a20c11000b000a35a6120efmr39171283pzb.61.1672562071783;
        Sun, 01 Jan 2023 00:34:31 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id w14-20020a62820e000000b005745635c5b5sm16285756pfd.183.2023.01.01.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:31 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 7/8] selftests/bpf: Add dynptr partial slot overwrite tests
Date:   Sun,  1 Jan 2023 14:04:01 +0530
Message-Id: <20230101083403.332783-8-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=memxor@gmail.com; h=from:subject; bh=eWmNvxGiF5Xaqm4y1ZtdaWfWN8WxTeCQ6gx8Y2rsDnk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV1/ixClzNpVpS5lkZgtI97gYut6AwoR6brsFg5 8MIWKjOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdQAKCRBM4MiGSL8Ryu+TD/ 9eEE25fbu0nqt0g1gBmt1+uKkcNbWdf/CiJPCY1GYgXrt6Ds9l8B0a+BFNWo0xWJv72MB2IEPSIna0 4iA4h1OLIQpwlwAamY2BuUs6HXpTV4AQZMhdmMwNEfbhc/eZNv/2NP3lXaV769UBThWKYXOPJxqhLT guz7R86wsfM5/ZRCWTMQ2JvBVWlmZoohJAEANZmS13TZF50etQjfOCtzp3iQUU8Ks2g0lIzLRpKgLs OIrSyt2Scbix2divSyYc7sMpDFf4VACNbvlA+jZ+in+M5AieGJ3jPNmjYxMnF1SCsafKgiMLTYjfG4 /qpp6gI3YLzDYTUUszfzUb4xs8O5rgVbEON3qgA/zcSVcPIC2dwnfXJUTyJ0RbiwPm+DGXf537vfi4 qP1husrL8QmNrl/7UJFmbi065M7+F7+mNe2+/Juut9vR0SGK99B02wm8aMXopolTV/UAtaQ2O+wXcS jISVDWXyoSSsH1dSlz2hUCac0gONlkAgcJj4D1evPexakfPm0DWPDJ/Zv1mfjuaFu9mLZPekehBsUE g/jepnJzs+7nHUQ7vMIVdom37OSRMa4xfKYv/gLV2QuHUMucyJcsr6Z3a0BG5JiHInqL4GjfowZo5q 0ejH91BrO5H/T1lVtTZzNr/WwLpyONxxAV94SfYNMgOhe6mgScxui64TruQw==
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
2.39.0

