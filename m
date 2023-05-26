Return-Path: <bpf+bounces-1333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E2712CAC
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B091C210C0
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F127722;
	Fri, 26 May 2023 18:42:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D618B0D
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 18:42:16 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631511B1
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 11:41:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso1157355e87.0
        for <bpf@vger.kernel.org>; Fri, 26 May 2023 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126499; x=1687718499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgB4/yqrcnRs3g67JcbLOGDczqccKnRLWG2kwpPPWhg=;
        b=rU+ebHPyJsyaDyKwLHHhD+h2mp/WhTfdn5aKi2Ur4tt65kG+f/kz2V/h+64Owrwa4D
         F9IPGghnqJyhuFfUWDRXzXO41Pa9nvWB76Ft0okzyC71D+4XxGuX7KdBSewF4NE1GZe4
         Ym9CJHD0m3Pwg3o0E/XkNVebTyausm2jMIvREY1U4b3mRgjXeVZmtAuRoX8007DiPppg
         +7hROgDj5Odz2BO3ZXTAKI2946/yfqxWfSV0P3zBK6ldBZavpgW9TR0YB8LIPcvsXUGZ
         8UnsPG785psHVcp8sCaCsUr3+ovW0miAqFAnjstPwCI1kPQ2UENy58k/yANRYwZCHNq4
         7XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126499; x=1687718499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgB4/yqrcnRs3g67JcbLOGDczqccKnRLWG2kwpPPWhg=;
        b=VtZsUGZU9rw0WID0QLYAjl5nhO+Le//l+blnh8hcRk70h9brKWtlDD6pWOLPOHR5Uo
         gXvkOyiWmNsOzmqA8+fnQbkhyLUl2HH0DwGNzgmi3m4dNlRwzsYGVDj44UsTNOaLTVbU
         S2mDrsyNIOpg8Xzt0AjDDmACAYpgAxV29q3gZBKIDe16Rc161FhfuBx/spDT2G8Ii1+K
         J54liP89HKygY8XKk3FMESNWnStcCbslMprtsly0i00+ovnAJgC0y1WJwskf8sgG95fA
         Stz6Nx5AUL34+lZDIwvwfNqJcYDkiqbq21AoNgznEjlUMjAhdWk8KooQPxC0DfJ6ZkSD
         Cvxw==
X-Gm-Message-State: AC+VfDzKU66HK6CL4xWlh59F6q0nG7rR0Bcvj4N2zK7m1XYzyHSB8ymM
	qyQ2JBR8ys0Ol0gqkhbRtvgNKhBp4tETGA==
X-Google-Smtp-Source: ACHHUZ73Yf3093yIvdYGE0T94VqykNykrFudj0Qi8DeKzxyA72RfxruFLbLf+9JDoDlTduwb5tNtmw==
X-Received: by 2002:ac2:47eb:0:b0:4f3:7c24:1029 with SMTP id b11-20020ac247eb000000b004f37c241029mr677887lfp.60.1685126498553;
        Fri, 26 May 2023 11:41:38 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x7-20020ac25dc7000000b004f155762085sm735767lfq.122.2023.05.26.11.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:41:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: verify scalar ids mapping in regsafe() using check_ids()
Date: Fri, 26 May 2023 21:41:25 +0300
Message-Id: <20230526184126.3104040-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526184126.3104040-1-eddyz87@gmail.com>
References: <20230526184126.3104040-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure that the following unsafe example is rejected by verifier:

1: r9 = ... some pointer with range X ...
2: r6 = ... unbound scalar ID=a ...
3: r7 = ... unbound scalar ID=b ...
4: if (r6 > r7) goto +1
5: r6 = r7
6: if (r6 > X) goto ...
--- checkpoint ---
7: r9 += r7
8: *(u64 *)r9 = Y

This example is unsafe because not all execution paths verify r7 range.
Because of the jump at (4) the verifier would arrive at (6) in two states:
I.  r6{.id=b}, r7{.id=b} via path 1-6;
II. r6{.id=a}, r7{.id=b} via path 1-4, 6.

Currently regsafe() does not call check_ids() for scalar registers,
thus from POV of regsafe() states (I) and (II) are identical. If the
path 1-6 is taken by verifier first, and checkpoint is created at (6)
the path [1-4, 6] would be considered safe.

This commit updates regsafe() to call check_ids() for scalar registers.

The change in check_alu_op() to avoid assigning scalar id to constants
is performance optimization. W/o it the regsafe() change becomes
costly for some programs, e.g. for
tools/testing/selftests/bpf/progs/pyperf600.c the difference is:

File             Program   States (A)  States (B)  States    (DIFF)
---------------  --------  ----------  ----------  ----------------
pyperf600.bpf.o  on_event       22200       37060  +14860 (+66.94%)

Where A -- this patch,
      B -- this patch but w/o check_alu_op() changes.

Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af70dad655ab..624556eda430 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12806,10 +12806,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				/* case: R1 = R2
 				 * copy register state to dest reg
 				 */
-				if (src_reg->type == SCALAR_VALUE && !src_reg->id)
+				if (src_reg->type == SCALAR_VALUE && !src_reg->id &&
+				    !tnum_is_const(src_reg->var_off))
 					/* Assign src and dst registers the same ID
 					 * that will be used by find_equal_scalars()
 					 * to propagate min/max range.
+					 * Skip constants to avoid allocation of useless ID.
 					 */
 					src_reg->id = ++env->id_gen;
 				copy_register_state(dst_reg, src_reg);
@@ -15151,6 +15153,33 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
+		/* Why check_ids() for precise registers?
+		 *
+		 * Consider the following BPF code:
+		 *   1: r6 = ... unbound scalar, ID=a ...
+		 *   2: r7 = ... unbound scalar, ID=b ...
+		 *   3: if (r6 > r7) goto +1
+		 *   4: r6 = r7
+		 *   5: if (r6 > X) goto ...
+		 *   6: ... memory operation using r7 ...
+		 *
+		 * First verification path is [1-6]:
+		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
+		 * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
+		 *   r7 <= X, because r6 and r7 share same id.
+		 *
+		 * Next verification path would start from (5), because of the jump at (3).
+		 * The only state difference between first and second visits of (5) is
+		 * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, b).
+		 * Thus, use check_ids() to distinguish these states.
+		 *
+		 * The `rold->precise` check is a performance optimization. If `rold->id`
+		 * was ever used to access memory / predict jump, the `rold` or any
+		 * register used in `rold = r?` / `r? = rold` operations would be marked
+		 * as precise, otherwise it's ID is not really interesting.
+		 */
+		if (rold->precise && rold->id && !check_ids(rold->id, rcur->id, idmap))
+			return false;
 		if (regs_exact(rold, rcur, idmap))
 			return true;
 		if (env->explore_alu_limits)
-- 
2.40.1


