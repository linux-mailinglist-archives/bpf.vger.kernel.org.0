Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924F961E6AF
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 22:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKFVuD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKFVuC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 16:50:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDADA1
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 13:50:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so8546880wma.3
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 13:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lJpSxfSEjVG1/bCCyfxjb0uPUEHKIir8y1Bnj2ycCw=;
        b=nw7D81kodJmlXCTO9LGgezsGeT0mp9uImTbKmRQ1iuY+/WnNTM2/UPlT2KvkIKhwaI
         cmVy9RpTWUsXSqcvGowPh6Fcq4LnDM8XdUzXooc+vhRES30y9aLUkDnJPRPDnG8iMM3B
         mzaaYT0PvvSDelkZQtReoehzgNBfBazmgf3qnNcn1pR4smPqU5BhfYYAAzyEUwXqRN97
         tFdCPTh6R/OMe7Y6HhtDqXIzt2JRQYC4erpC/Fwxb+XMJrNssbzsNmH3FDQMZNxmwZIv
         crlt6/6tJnZCoqNmSyBYiT8KMs+W091oqJihsfYgOEJpv7wDnsHi6OsVBypIzqgDJ8W4
         yNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lJpSxfSEjVG1/bCCyfxjb0uPUEHKIir8y1Bnj2ycCw=;
        b=47gwCqqfW6MUc70wMLnddNFbA/GCqGHyycqDKRzn6r2D3AiY/tzXfT9UsC6IAi3DOv
         Ta/cZ5BHR/M+TF82vItvrm/gVPvKDhpTU7GsLYmPHXdkhXeN76voZA23haYtXPgVt6rR
         EYTZFUiGzn3LjSjMkW43ZkqmVJPUHY0tjgRUuqknHJcSQi+DSJoSpqQTHtxNq0OZSXWA
         WJS0hrjkdGkb6KsZN4ZGyTzJs705m31g5HjJUjOLry7zh73X1bZbK4c/HqBUNUtkDLtA
         oRDzF/5UzyQ8CEcxT1Qwmsniqm3Rm7vIsqoE5GtcKB/ahpXqc7Dnj8WG94KHkwCkzDqy
         3dWw==
X-Gm-Message-State: ACrzQf1rJksCauVohZRa9CJFmi3ZHvKUPQ6m8WmmxfkOxvqva60TJq1T
        w+zrkig82coqRhdXAi4F4TGapJdNsEFr3KSD
X-Google-Smtp-Source: AMsMyM7CHsvKUqSccMO690HNTaCCJ35QVou7/N2JFKa0KkEBDh/FK/vjQ+O+Azn49AT9/RZ7PWz8zw==
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id hg8-20020a05600c538800b003c504c1a1f6mr31234831wmb.11.1667771399483;
        Sun, 06 Nov 2022 13:49:59 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003a3170a7af9sm6345326wme.4.2022.11.06.13.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 13:49:59 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, shung-hsi.yu@suse.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: propagate nullness information for reg to reg comparisons
Date:   Sun,  6 Nov 2022 23:49:20 +0200
Message-Id: <20221106214921.117631-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106214921.117631-1-eddyz87@gmail.com>
References: <20221106214921.117631-1-eddyz87@gmail.com>
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
index d3b75aa0c54d..0e66ddeafe0b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10256,6 +10256,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *other_branch;
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
+	struct bpf_reg_state *eq_branch_regs;
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -10365,8 +10366,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -10415,6 +10416,36 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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

