Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3064AE0A
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 04:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiLMDF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 22:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiLMDF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 22:05:29 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA9193C4;
        Mon, 12 Dec 2022 19:05:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c7so1271338pfc.12;
        Mon, 12 Dec 2022 19:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRz1ndE/MNsp7SX3z6xwVJjSnJS8PPptEfHAdy5xitk=;
        b=q65PtU/OnLz+25mz/mVduCl7jZSDJoi13dQGQCSLvKN6GODR3uguXnhLQdv64ym6ug
         2CiBmWcQvAVY61gDaXEcwOvcnIopxaMjVJf9bw/QNxSdwU9/vyOS94qbtedEnYwfSqUS
         Dgcxvo1fuzXWetK1aqanQvhe3ztc3ndXlB2iL5bij7uBGg5r11fmxarVmolhHJKtJzoC
         biQz7tgeNJ5Oh8MGB1hrvekudjKcLwP1/C7sIKiF2k6Wm6DAUZJGZz312gzayZeP5Day
         0C6+SUQnX5eU1nLTyboJNGnmrfryy+2+NMIN7UDPPCYrynbbYH32qoAXA1uHmyD/bcqR
         M0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRz1ndE/MNsp7SX3z6xwVJjSnJS8PPptEfHAdy5xitk=;
        b=y92Vb/KTgXhS66HEAt6XpgkSJpcDFiw7BxbcKwJ9IBGLDSYlevHhFvuz9NNuB538SY
         x3JqQD5U7vc9Bd+xsrJjfWHk8uq0H2GvBOOH+fpObolNsKTjLtPWEzjh4QskMJFkIy92
         +TB1XSr8lrE6+xj55f8DCCkDF3O4BVIq4P7DMpKiUu3z51/ls3SnuMxrRFm6wxr8VQtF
         x5MY2tvDRf1kUqemnE+y4/WtaRHHfKQ9VBo0SOVl1Rx0Z9y+wfzbwvFnz27D3Odlfbwg
         TYY457MjCN/3loPQSrMm8K90VFN+WzFE4aieMtuHEbGVJi00poG+nq+tQ3+rC91FMxEM
         FycQ==
X-Gm-Message-State: ANoB5pkDC60OjXwi3RRmuzhuRR5UhdAu+C/ylGhY8iy02HdzTSoVtb6w
        XoBIOES2ptM4c1R+FtOCBvKPrH69viID
X-Google-Smtp-Source: AA0mqf60HvpiWuMtdGpFxMGaEMw6MLrEfv3EMwJJyC1YK2MysYXIUBp3Qxxkw7wxC7yYsMmFJ+ycZA==
X-Received: by 2002:a62:3247:0:b0:574:7015:5501 with SMTP id y68-20020a623247000000b0057470155501mr19666643pfy.5.1670900727267;
        Mon, 12 Dec 2022 19:05:27 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79495000000b005746c3b2445sm6481716pfk.151.2022.12.12.19.05.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Dec 2022 19:05:26 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: fix nullness propagation for reg to reg comparisons
Date:   Tue, 13 Dec 2022 11:04:35 +0800
Message-Id: <20221213030436.17907-1-sunhao.th@gmail.com>
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

After befae75856ab, the verifier would propagate null information after
JEQ/JNE, e.g., if two pointers, one is maybe_null and the other is not,
the former would be marked as non-null in eq path. However, as comment
"PTR_TO_BTF_ID points to a kernel struct that does not need to be null
checked by the BPF program ... The verifier must keep this in mind and
can make no assumptions about null or non-null when doing branch ...".
If one pointer is maybe_null and the other is PTR_TO_BTF, the former is
incorrectly marked non-null. The following BPF prog can trigger a
null-ptr-deref, also see this report for more details[1]:

	0: (18) r1 = map_fd	        ; R1_w=map_ptr(ks=4, vs=4)
	2: (79) r6 = *(u64 *)(r1 +8)    ; R6_w=bpf_map->inner_map_data
					; R6 is PTR_TO_BTF_ID
					; equals to null at runtime
	3: (bf) r2 = r10
	4: (07) r2 += -4
	5: (62) *(u32 *)(r2 +0) = 0
	6: (85) call bpf_map_lookup_elem#1    ; R0_w=map_value_or_null
	7: (1d) if r6 == r0 goto pc+1
	8: (95) exit
	; from 7 to 9: R0=map_value R6=ptr_bpf_map
	9: (61) r0 = *(u32 *)(r0 +0)          ; null-ptr-deref
	10: (95) exit

So, make the verifier propagate nullness information for reg to reg
comparisons only if neither reg is PTR_TO_BTF_ID.

[1] https://lore.kernel.org/bpf/CACkBjsaFJwjC5oiw-1KXvcazywodwXo4zGYsRHwbr2gSG9WcSw@mail.gmail.com/T/#u

Fixes: befae75856ab4 ("bpf: propagate nullness information for reg to reg comparisons")
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..243d06ce6842 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11822,10 +11822,17 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 *      register B - not null
 	 * for JNE A, B, ... - A is not null in the false branch;
 	 * for JEQ A, B, ... - A is not null in the true branch.
+	 *
+	 * Since PTR_TO_BTF_ID points to a kernel struct that does
+	 * not need to be null checked by the BPF program, i.e.,
+	 * could be null even without PTR_MAYBE_NULL marking, so
+	 * only propagate nullness when neither reg is that type.
 	 */
 	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
 	    __is_pointer_value(false, src_reg) && __is_pointer_value(false, dst_reg) &&
-	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type)) {
+	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type) &&
+	    base_type(src_reg->type) != PTR_TO_BTF_ID &&
+	    base_type(dst_reg->type) != PTR_TO_BTF_ID) {
 		eq_branch_regs = NULL;
 		switch (opcode) {
 		case BPF_JEQ:

base-commit: ef3911a3e4d65d2db617366e79517b896045a6e2
-- 
2.38.1

