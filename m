Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903C653AC4
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 03:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLVCor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 21:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVCoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 21:44:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205CC19288;
        Wed, 21 Dec 2022 18:44:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so507701pjh.5;
        Wed, 21 Dec 2022 18:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTIpJWonjUXndSlUh/081qXEdn8CFGHfdUk14rXmSvs=;
        b=lIE9m3xystASzY37+oafMZYOu+ArGf2FcGa80JLrO3TpI0c9xcuew1IL5Oub8Xwmb7
         8gEkegOvLfjN9fAvoW7UGA2f9Z7+wAFbuKkRtLBotPT76V0tYRCY39/PvcjD1qkQch7k
         NdovBxzan1qFCjMwAXAJLGQbwBFE78FSJRu3wKuX9TGLwp2D1n7YJoDh/wiy4hrx8U6I
         PzmICUmDYajrZGIip2jZ3oifkUtLeNEaOUnfX7DSR0LktUWZ18VNrB8LbDTt+jjD9Edu
         k2yrASXlN8Pttl8U7f1NpvooYngN8+7ggmzemlupc4hfBu6OCUqIGH04OP/p2do2icKe
         Qr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTIpJWonjUXndSlUh/081qXEdn8CFGHfdUk14rXmSvs=;
        b=7tRgeo0ylPJkert8iscdJJayqE/rtjyHxKgmYJMtSlaxpV/IkSuVOPQpU+hk/Rf3mL
         i47azvJEYLXBv3+MmxFvwdIbF2rnswy/2YW4TuED8v51MkDnxF78vjMoxuD/4EQfvqYH
         NTec5TAn0mwuMlh3SbJSP4TvqZKIUzcFgkhIkY+XJ6affBBu61EY05ExRCyUg//nbFGw
         l41tiWYozWYV7bikrTKx9tmsiJfZbgKiYocNKoTQPyJY3BnzR4MTFpd53ITOcaygCAUZ
         7cxe/+K7NP9vWDZ89fl5HovwmHB+WjrBwd+l+yEZwC1/FV5QDycd9ObQJtn6UbYm9AA5
         5lzA==
X-Gm-Message-State: AFqh2ko6xnxmLgo4WkWUVU8aiUcKAV1thBnz5R9Sxakk2+vIdQQ3UJvC
        NZCpkyJ0gSv/TYGkaSRMSo9vM+H7rg==
X-Google-Smtp-Source: AMrXdXvZepxEWOOcBDvNHM1/Sn26yqMI3CHRZctGSst+5k2AChcs4YPJGV0HxzWcrqGj69SHYwsb5Q==
X-Received: by 2002:a17:902:a406:b0:189:6ab3:9e75 with SMTP id p6-20020a170902a40600b001896ab39e75mr4605590plq.15.1671677085102;
        Wed, 21 Dec 2022 18:44:45 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id b3-20020a636703000000b004768b74f208sm10752587pgc.4.2022.12.21.18.44.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Dec 2022 18:44:44 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: fix nullness propagation for reg to reg comparisons
Date:   Thu, 22 Dec 2022 10:44:13 +0800
Message-Id: <20221222024414.29539-1-sunhao.th@gmail.com>
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
v1 -> v2 add explanation comments above changes
v2 -> v3 rewrite selftests that run under test_progs to use CO-RE
---
 kernel/bpf/verifier.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa358b3d5d7..966d98bfdb60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11823,10 +11823,17 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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

base-commit: 7b43df6c6ec38c9097420902a1c8165c4b25bf70
-- 
2.39.0

