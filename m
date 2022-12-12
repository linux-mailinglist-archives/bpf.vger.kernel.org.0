Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3864985B
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 05:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLLEJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 23:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLLEJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 23:09:25 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F02DE88;
        Sun, 11 Dec 2022 20:09:23 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 65so7677814pfx.9;
        Sun, 11 Dec 2022 20:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIZiat2O72XRyDJnwdHMvwW0k0rbsu/PLtfkAzPrxE0=;
        b=q2w8k80qwccjgploX1Ewd0opyyi4K/d1aDESTaGB9NwGxg/WjNhmbQsmguX5h+rhi/
         m5vJb+k7dW0XMJv368EpsZLu9SsPYXj55AUww4g0UdZihHPlnZ91OpEhg1ML+CVKqe85
         DcOvTDvA4Y+g/gxVPBQOEhvecSwN7WijIIHzk7VrgO5TzA8UK9Uyt+bRmJxa/0Wo8UaI
         GimrKX+rUvNFXnLOqLsEroPnP5+YQk+B2DwnqU/MkQbn7C1Mgop2cJ9/wIrcbzAxVhJG
         CnpX3FZ4o2mz4GSEZJ+OAHQCR3Px3qUPo6SOPmUzPpszrN44qknWP9r1GftBr/Vfn11F
         YynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIZiat2O72XRyDJnwdHMvwW0k0rbsu/PLtfkAzPrxE0=;
        b=KvHyLMj2WvdPQNYHvrr5qSGrj3+gjpH8q5tRmIsydjIocsb+B1VoMyjsG9rUT2n/4+
         mbvlFkdtCdIUqfVkpbwnQhx8OazxNCnfoGQsDC9jZ3UwNuRiM+tvfV5QWpvDsDapqBfD
         yhIv7TvCICwW2coJeu59m92Q3Dtz8WTlFEnPzkW8k4UiQRtjfA2A3ZjmvGaJvRZYlFZf
         H7NYcOmWkYLGH42UJF8ZnJe9/YDxm8idrvJ2sx6BvRo+xE0NzWjej+LnJinHIihjegTc
         89LWb98W+ghp9nCetxJJxALaQwxbyEmGK18nCHQga+3m+RLhy3mLleAT6Lh+Ma27MYry
         M9qQ==
X-Gm-Message-State: ANoB5pm0YXiGs4yosHiJpxrSZhbKIsIunYyfnBFLejsIJYrT87MOXvGW
        xB+xkcbiuHzD/FRoFtQrpEdQlDiHJNE+
X-Google-Smtp-Source: AA0mqf5snyH4n+NsNbtIi2G57hlnTmlGhq2/8pZnRHkFmjOOifuB3NzyZsqp+l+kz263n1QPtwwDyg==
X-Received: by 2002:a05:6a00:2189:b0:56d:59f0:d291 with SMTP id h9-20020a056a00218900b0056d59f0d291mr16842301pfi.18.1670818162705;
        Sun, 11 Dec 2022 20:09:22 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id w185-20020a6262c2000000b00577adb71f92sm4631039pfb.219.2022.12.11.20.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 20:09:22 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: fix nullness propagation for reg to reg comparisons
Date:   Mon, 12 Dec 2022 12:09:10 +0800
Message-Id: <20221212040911.2337521-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.38.1
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
If one pointer is maybe_null and the other is PTR_TO_BTF_ID, the former
is incorrectly marked non-null. The following BPF prog can trigger a
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
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..aa651e4517e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11825,7 +11825,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
-- 
2.38.1

