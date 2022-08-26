Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15B45A2D7E
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbiHZRaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiHZRaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 13:30:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26566E8B1
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:30:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so4443367ejc.1
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gZPHolGeQ9kHWgDJvA3e7p1d0KYEdfpTn+cIOF7RCvU=;
        b=kDEm7srz61odMfDTnsdWgJ25tcG2YXqLxSSXXezCqW4RHVbwCQOVGHvrIMDIvG/Sq/
         2CN73uTowt0CtfjhO0RGeW5Fkpk6RwffiadCD8ALMnMpSSxpMOzFOetm8UIcmKgyLXhx
         jfEqUHVpXW8u7ka1o5yOEtVlOPiVfRRmlgZ3QNOeVwRjANuinSXWXADL0DKbNZTIaA0s
         o7qSFLxkonxQ6S/qoRa0BQs4jHedGkywuqCykRCtu1fdEv53hIluPjPwq8KXZK29GHIR
         ECELyd3libAY3vGezzOnWdEgoUxL/5QWA6w2zYce+roXf8zmz6wECTwyCBC+KwmBm5Np
         N51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gZPHolGeQ9kHWgDJvA3e7p1d0KYEdfpTn+cIOF7RCvU=;
        b=QUvGpE64xTXFmbtqFOjGxaX6zetUPKULsZ7mbad2vyowaQ5didwZySxjAWgXdI2PUs
         5FKv52uMzqdO2bnc2rsXl9arj+c6UottnhsV9sq7P1xKi45eJKWgQYWo2e5tNGkm06FZ
         tNmKFlXoXM09E85SF93N88Pmwti9YXemvniPQ/QSwZwfk+0So28nVFzTjd8WdB1aAMHt
         rynOstqvRsfwZEDblvNRyrmuzl/OToxh1ZkXmbNDvgf+oyyUMXl4i/2eJKZm+bMXlUrv
         jnsI77JtywUOxiAGZ6u5oLiBaCBX110mdIoxUdBkq+zJJCGLMDobJQuHmhCc90Ei6iIu
         L/cA==
X-Gm-Message-State: ACgBeo3MsYiVXc+mSpwhTuCJURG7Ble0YItN+/7EXOj0wc6h3TzA5Er4
        m+ImMdZXPpSYoGnhYkfRvmj28jLlPA/iK7v3
X-Google-Smtp-Source: AA6agR6NTQ1dpfJV1JKVFmo1x0EGe+lv5S87/Jhta1sx65cKG3Tk6AxP0ervUsks3vyHKwIn0Bt5Dg==
X-Received: by 2002:a17:907:60c7:b0:731:4b42:4e3e with SMTP id hv7-20020a17090760c700b007314b424e3emr6076553ejc.236.1661535001698;
        Fri, 26 Aug 2022 10:30:01 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906a40d00b0073d79d0c9c7sm1119896ejz.127.2022.08.26.10.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:30:01 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: propagate nullness information for reg to reg comparisons
Date:   Fri, 26 Aug 2022 20:29:14 +0300
Message-Id: <20220826172915.1536914-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826172915.1536914-1-eddyz87@gmail.com>
References: <20220826172915.1536914-1-eddyz87@gmail.com>
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

Propagate nullness information for branches of register to register
equality compare instructions. The following rules are used:
- suppose register A maybe null
- suppose register B is not null
- for JNE A, B, ... - A is not null in the false branch
- for JEQ A, B, ... - A is not null in the true branch

E.g. for program like below:

  r6 = skb->sk;
  r7 = sk_fullsock(r6);
  r0 = sk_fullsock(r6);
  if (r0 == 0) return 0;    (a)
  if (r0 != r7) return 0;   (b)
  *r7->type;                (c)
  return 0;

It is safe to dereference r7 at point (c), because of (a) and (b).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0194a36d0b36..7585288e035b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
 
+static bool type_is_pointer(enum bpf_reg_type type)
+{
+	return type != NOT_INIT && type != SCALAR_VALUE;
+}
+
 static bool is_acquire_function(enum bpf_func_id func_id,
 				const struct bpf_map *map)
 {
@@ -10064,6 +10069,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *other_branch;
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
+	struct bpf_reg_state *eq_branch_regs;
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -10173,8 +10179,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	/* detect if we are comparing against a constant value so we can adjust
 	 * our min/max values for our dst register.
 	 * this is only legit if both are scalars (or pointers to the same
-	 * object, I suppose, but we don't support that right now), because
-	 * otherwise the different base pointers mean the offsets aren't
+	 * object, I suppose, see the PTR_MAYBE_NULL related if block below),
+	 * because otherwise the different base pointers mean the offsets aren't
 	 * comparable.
 	 */
 	if (BPF_SRC(insn->code) == BPF_X) {
@@ -10223,6 +10229,37 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		find_equal_scalars(other_branch, &other_branch_regs[insn->dst_reg]);
 	}
 
+	/* if one pointer register is compared to another pointer
+	 * register check if PTR_MAYBE_NULL could be lifted.
+	 * E.g. register A - maybe null
+	 *      register B - not null
+	 * for JNE A, B, ... - A is not null in the false branch;
+	 * for JEQ A, B, ... - A is not null in the true branch.
+	 */
+	if (!is_jmp32 &&
+	    BPF_SRC(insn->code) == BPF_X &&
+	    type_is_pointer(src_reg->type) && type_is_pointer(dst_reg->type) &&
+	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type)) {
+		eq_branch_regs = NULL;
+		switch (opcode) {
+		case BPF_JEQ:
+			eq_branch_regs = other_branch_regs;
+			break;
+		case BPF_JNE:
+			eq_branch_regs = regs;
+			break;
+		default:
+			/* do nothing */
+			break;
+		}
+		if (eq_branch_regs) {
+			if (type_may_be_null(src_reg->type))
+				mark_ptr_not_null_reg(&eq_branch_regs[insn->src_reg]);
+			else
+				mark_ptr_not_null_reg(&eq_branch_regs[insn->dst_reg]);
+		}
+	}
+
 	/* detect if R == 0 where R is returned from bpf_map_lookup_elem().
 	 * NOTE: these optimizations below are related with pointer comparison
 	 *       which will never be JMP32.
-- 
2.37.2

