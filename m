Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573E459BD16
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 11:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiHVJoH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 05:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiHVJoG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 05:44:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD322BD5
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 02:44:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bs25so12474267wrb.2
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cx4WvVKmj28fnD04KMdbN5IgkweIGgZNMjxwXdjN2Ek=;
        b=UBxB1FLV2LWN8cBXYTaRImgR5VuE6EZbPMwl6qC3aHf3aVkDgpjptWwuLzq/SAN+mW
         vjRoQMf5zIy9m/C9ogyhBL3vgk32eGt2aC/NJggFdgMeax/mHw7/73qJrwOtqKxcJ21f
         MPTdf4LmuTdCTark95PoblZgQDF1jy3W7aBEyhzR6p8rKahf8xtoF82DT30E3HvCNPSx
         PX5Su0eC5C4vb6D0wdtmVJ8C6N4BM56VdKHJFffXyHx2mlwDW8PtVMK5qsyTzKKaRB8N
         kuvxuwoWHo9IKCMRsFRB5fnrqrYJES1DP1dAVZXvRrogGOfpiHohOALLjc9Z3lJiJ/8c
         oP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cx4WvVKmj28fnD04KMdbN5IgkweIGgZNMjxwXdjN2Ek=;
        b=VTeEIqIcWWInZdn8nS/9iARvgH+Zg3gG/I1pjoGPKn4QReCkK6zhK7N24LZS0212qb
         bV64UY5e8tfgcdKUJ5MwyUqY5/oPbQZD6GoohAdvVZU2aOntnJXwezUMfIZ3y3sDkhpM
         ObUpVJkQYoDWIaNiZOGLi55AFT8f5MVB3axw/A3JZFuYMX66ADnpCICL7+hXmIPE5LSg
         1boZQ1z9/pLlGcbsEI5e4jNryr1wtnlJtAe/bCHQhN/T6AHgI0FThh5rWIowv6tMLATV
         S4vf1gYwox0USkWFYVDwSHQ3bM/s7EkFSOTCxgIQXqAc7kV0SIC2nmGg+hoNwW/bKQpu
         CjxA==
X-Gm-Message-State: ACgBeo2bwn4EY5DQ0b2go+S0ozmtnnMKWWfl0inLGJuYE6tgCwDfGp0y
        89n/pXSnAP9ToGQd4LcICji7epzqnSz+6eLB
X-Google-Smtp-Source: AA6agR7EJgWUhuuWBl225xHEwnFh1waVlomRvQxnCh09guueNFqxdUY4UBSCGv0l46IwF78Z6v9Y5Q==
X-Received: by 2002:a5d:47c4:0:b0:21f:e92:7ba1 with SMTP id o4-20020a5d47c4000000b0021f0e927ba1mr10098535wrc.408.1661161441469;
        Mon, 22 Aug 2022 02:44:01 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a54fffa809sm14841558wms.17.2022.08.22.02.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 02:44:01 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 1/2] bpf: propagate nullness information for reg to reg comparisons
Date:   Mon, 22 Aug 2022 12:43:11 +0300
Message-Id: <20220822094312.175448-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822094312.175448-1-eddyz87@gmail.com>
References: <20220822094312.175448-1-eddyz87@gmail.com>
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
---
 kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c1f8069f7b7..c48d34625bfd 100644
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
@@ -10046,6 +10051,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *other_branch;
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
+	struct bpf_reg_state *eq_branch_regs;
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -10155,7 +10161,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	/* detect if we are comparing against a constant value so we can adjust
 	 * our min/max values for our dst register.
 	 * this is only legit if both are scalars (or pointers to the same
-	 * object, I suppose, but we don't support that right now), because
+	 * object, I suppose, see the next if block), because
 	 * otherwise the different base pointers mean the offsets aren't
 	 * comparable.
 	 */
@@ -10199,6 +10205,37 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 					opcode, is_jmp32);
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
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
 	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
 		find_equal_scalars(this_branch, dst_reg);
-- 
2.37.1

