Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84982648323
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 14:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLIN7A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 08:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLIN66 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF7C54778
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 05:58:56 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so11777124ejh.0
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzjyzNxTIAqPjPKUEr8bfwrktvhNTDX4WTTNouBssS8=;
        b=lMHI2M6w2HVZot/sx0Llbpqjz41Nl5Omy24J25xLqTygY5cGHlPe5AOuvxYxDSsHYE
         lmJ+ynwGaeWJjMrt/G1vzWRKuGSDsvQ0hoWUKydPk3h7XQzWDsjh6MKE1sel5eT5gqQZ
         o1Lllgx2gJw+fWipMQbUjhuAAd311B7iHUTgqQvzekdMJ1KmiwrQCuNBOTq+AQ2I17Bc
         NpixJsuT0ydWcaHrcCh2zxZw1rgRz2FeL8fLS8v8xU7a2BxOaA5sQ9g0VCklkTg9bB37
         Xen35NuSetLx3Mc6I5H/qzJJ0X3k/FItSv4pL25zr7q/DR2k3l1Tzh075sOlTR8RRmBh
         oLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzjyzNxTIAqPjPKUEr8bfwrktvhNTDX4WTTNouBssS8=;
        b=1sousk0c5NYeLurM8Wujc5RmfkHSN4cmj7OUoUN4Q/ptoNYeWoXdE/k+s56c36VZLD
         X57J+9Fh6rc0vEqw5woX0Ra5Kyzxqf+xYyEf8ph6ecY6fD5mQLhwcf6YPxyfZqlNeW0R
         +wDEmXm+RkFxSqhVx3Az50yWyF6uZ2vzc9S9w+Dxm2TjTHsM+wLEsl68A699fqnioCas
         jqJ+j7XjbIFCEkEx9sJH/r/v2u20MQg4z/IIYJUCd9gtzwliSN1emUivwcNP7NPaLsAs
         fSHRm6M+yFcowzIxUvwwzQslrrI4eY9fnV9E/CWkXfLkKt7/VoKT/JfZO4N+mcx5QPaY
         YpGg==
X-Gm-Message-State: ANoB5pkDcv6mB9pNyPvGNwisSzChwSUqAO4Dcmch6EPOQoi/sOYyoLqs
        43aqGDU2y467xt+75RuqjpGLjkdKY47x9g==
X-Google-Smtp-Source: AA0mqf4Wm09JtaAmjklB366PY55uNsclwHTlXwbvs6OCIEkqwrZm66tVkhwEPsCn2u1KTxPLXRW9XQ==
X-Received: by 2002:a17:906:3ac1:b0:7c0:ba3b:8e04 with SMTP id z1-20020a1709063ac100b007c0ba3b8e04mr4845627ejd.43.1670594334845;
        Fri, 09 Dec 2022 05:58:54 -0800 (PST)
Received: from pluto.. (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906830600b007c10fe64c5dsm589028ejx.86.2022.12.09.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:58:54 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, memxor@gmail.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 7/7] selftests/bpf: test case for relaxed prunning of active_lock.id
Date:   Fri,  9 Dec 2022 15:57:33 +0200
Message-Id: <20221209135733.28851-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209135733.28851-1-eddyz87@gmail.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
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

Check that verifier.c:states_equal() uses check_ids() to match
consistent active_lock/map_value configurations. This allows to prune
states with active spin locks even if numerical values of
active_lock ids do not match across compared states.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/verifier/spin_lock.c        | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/spin_lock.c b/tools/testing/selftests/bpf/verifier/spin_lock.c
index 0a8dcfc37fc6..eaf114f07e2e 100644
--- a/tools/testing/selftests/bpf/verifier/spin_lock.c
+++ b/tools/testing/selftests/bpf/verifier/spin_lock.c
@@ -370,3 +370,78 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.flags = BPF_F_TEST_STATE_FREQ,
 },
+/* Make sure that regsafe() compares ids for spin lock records using
+ * check_ids():
+ *  1: r9 = map_lookup_elem(...)  ; r9.id == 1
+ *  2: r8 = map_lookup_elem(...)  ; r8.id == 2
+ *  3: r7 = ktime_get_ns()
+ *  4: r6 = ktime_get_ns()
+ *  5: if r6 > r7 goto <9>
+ *  6: spin_lock(r8)
+ *  7: r9 = r8
+ *  8: goto <10>
+ *  9: spin_lock(r9)
+ * 10: spin_unlock(r9)             ; r9.id == 1 || r9.id == 2 and lock is active,
+ *                                 ; second visit to (10) should be considered safe
+ *                                 ; if check_ids() is used.
+ * 11: exit(0)
+ */
+{
+	"spin_lock: regsafe() check_ids() similar id mappings",
+	.insns = {
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
+	/* r9 = map_lookup_elem(...) */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_LD_MAP_FD(BPF_REG_1,
+		      0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 24),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
+	/* r8 = map_lookup_elem(...) */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_LD_MAP_FD(BPF_REG_1,
+		      0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 18),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	/* r7 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r6 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* if r6 > r7 goto +5      ; no new information about the state is derived from
+	 *                         ; this check, thus produced verifier states differ
+	 *                         ; only in 'insn_idx'
+	 * spin_lock(r8)
+	 * r9 = r8
+	 * goto unlock
+	 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 5),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
+	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
+	BPF_JMP_A(3),
+	/* spin_lock(r9) */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
+	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
+	/* spin_unlock(r9) */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
+	BPF_EMIT_CALL(BPF_FUNC_spin_unlock),
+	/* exit(0) */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_spin_lock = { 3, 10 },
+	.result = VERBOSE_ACCEPT,
+	.errstr = "28: safe",
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "",
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.flags = BPF_F_TEST_STATE_FREQ,
+},
-- 
2.34.1

