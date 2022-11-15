Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6716262AE9C
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbiKOWtm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiKOWtO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:49:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF939D
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:49:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id k2so39907413ejr.2
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wBKihR/ahpGcyV8LDxIJNI8Si8oH9un5wWftmd2Zvc=;
        b=a+aIZ4E95naPbiwe+L3gmdpKA6AC7O9Wo6snexMuYfGN9M3gNYA57WRCl8GhHjq39Z
         kKjg/gHnyFx9pam1t/H9NR0s3U1QoY1e37ekhl/iu+da/HMKbEZ6RIlipVfKoLFVuiFr
         Mu2WnELLS8zq5sv47A5pmxLPTLmKiqH1m/TvJnZNre9bG6hBsa/h/muvu8A8AHNky/9C
         SEWEifXoLz4cX+i3uIlHhCoyodNk8Dhk4Ci9QtqlecBHFmKsxEryEPwkKulZKybQSkam
         hFnQzKdE0UM2fkvEQeV9Lq0jHQKbwiq2BlfIHH57pHNPUnls0VnM6/4efPKSneVKt8mh
         ZJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wBKihR/ahpGcyV8LDxIJNI8Si8oH9un5wWftmd2Zvc=;
        b=cCWMFGcVAZ4FmwEe1Qb0J6wFAl2f3gUm/0VAj3Dg6zriCxMdAX4j96vQ30EOboidUJ
         qbuGj8xY3tqRl6tVWVcjOlu10syRXJ+LeYQDnEBPgcX6oQsKxBo9NujZbxL1P9AZfkgV
         1D1DOq/BEde57wO+ZX3YIiL6Uq9EuDZTmZdXufDYzgP4+t7vPg2UTYOIe5K8aUQY7LBD
         4/HEZP2qM/859X3pUi8uiLOSJKxipQShL78G3xe/PWfuZ8EEzLma3n7DCHvWi1ickaea
         SKidgXQK0BOrK4VzQrbuQfNESqljNcAXFC9ZpqsTkFLruOjcPKVbSU2WrJw+NwulzxcO
         Q7SA==
X-Gm-Message-State: ANoB5pmBkBjmlCWXbmeCdEn3V0n6iGeJzTEQfQ4Jv0MSkn6JUsep3BuJ
        h/jyESQD2z5MdNPMo3t9UDFgpJQEf2Xtogwg
X-Google-Smtp-Source: AA0mqf6VQ4N7255usuPQ8cNEzk9PDS+ze/KbU0KewWtBhdGP4H8JNfKFsyF05wmFU28Udk9n40LEgA==
X-Received: by 2002:a17:906:e094:b0:78d:48fa:8038 with SMTP id gh20-20020a170906e09400b0078d48fa8038mr15682364ejb.309.1668552551195;
        Tue, 15 Nov 2022 14:49:11 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id y22-20020a056402171600b0046776f98d0csm5461854edu.79.2022.11.15.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:49:10 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, shung-hsi.yu@suse.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: propagate nullness information for reg to reg comparisons
Date:   Wed, 16 Nov 2022 00:48:58 +0200
Message-Id: <20221115224859.2452988-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115224859.2452988-1-eddyz87@gmail.com>
References: <20221115224859.2452988-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index be24774961ab..0312d9ce292f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10267,6 +10267,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *other_branch;
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
+	struct bpf_reg_state *eq_branch_regs;
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -10376,8 +10377,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -10426,6 +10427,36 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		find_equal_scalars(other_branch, &other_branch_regs[insn->dst_reg]);
 	}
 
+	/* if one pointer register is compared to another pointer
+	 * register check if PTR_MAYBE_NULL could be lifted.
+	 * E.g. register A - maybe null
+	 *      register B - not null
+	 * for JNE A, B, ... - A is not null in the false branch;
+	 * for JEQ A, B, ... - A is not null in the true branch.
+	 */
+	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
+	    __is_pointer_value(false, src_reg) && __is_pointer_value(false, dst_reg) &&
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
2.34.1

