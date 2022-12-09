Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE2648321
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 14:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLIN66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 08:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLIN64 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:56 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457B976165
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 05:58:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vp12so11664601ejc.8
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 05:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvK1Et8SyzpumnwYURWJzUwXW3OX+TLtUGxkUllETWQ=;
        b=YHTOw4avlKUA6WG6sPeBZ1upI3LwloFG4A5fipQYAPj2Q9dtlgowv/6F8+MnpHVPMW
         vgcSMyqFrR7r3voeagbYU+zA1Byzd+9mPj1lufnlQJeXeoRPQ4c3CghZ9QMrbqziTQSi
         7Dd3EvvUgq6HAJVfzfKTS36Ur8ROZKR7K3xkqOC+wFmiHL6Uu9NME6dUA0Ah0QxgB4n9
         KAzer9/vdJpQzmRhOdvU9+3q7rYhhsRFHBfrMJtkg+XC4wD75xVa2W/W5aOYSlAi3e2/
         4T3gzGjLLBPn7YCrVvCzHXK3v2IKyEdOkvccMk430N+aD8eaqwMfvMYen9wlpR635vBa
         nvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvK1Et8SyzpumnwYURWJzUwXW3OX+TLtUGxkUllETWQ=;
        b=qK30TWo86w/3jCOB+NjKkVv1erIP5gsb/rJXk94MOUARxKRXCMG7ZDwzad9XyJZEpP
         7JcTkwlqIKsH4fox55vG42WI4LlE++NwMC/S+bwQX8/63NmXnvbKsu3g1URfTwJCy0O4
         BavrG2HaIOC3+IY4b2eD2Cz3DtxzlC1SpDT03uB8TCWFXfEVAH4cUzkTivFAG1ASJTIj
         Qcm+SdIqEfvB0Z58RKB/86wKacM6DxvJRj3akN87sdhHHAQ1PQqIIwqshDRb9A7plsGp
         4LCA/Sefazyn66B5L8qWTivg9zamOW951cBgto+1wKLc9d55dSwK/yRLJjp56R0QJJnb
         U9DA==
X-Gm-Message-State: ANoB5pnP2VwOg+/uJ6YPOIVve8zy4m3UV6pBG1GBRsiUxxevjlubkEyp
        zEc8zP+yrL1dXgWNqjCoT/aBLNYNvRx3cw==
X-Google-Smtp-Source: AA0mqf4gPL2KyA+FxOS005TF3teuGPQpSbTE/1ItRgqZ4MrJ7FX/NQW1zrud7QcG53FANoLpxlIyyA==
X-Received: by 2002:a17:907:8746:b0:7bc:1e7e:6b8e with SMTP id qo6-20020a170907874600b007bc1e7e6b8emr5604535ejc.43.1670594333604;
        Fri, 09 Dec 2022 05:58:53 -0800 (PST)
Received: from pluto.. (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906830600b007c10fe64c5dsm589028ejx.86.2022.12.09.05.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:58:53 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, memxor@gmail.com, ecree.xilinx@gmail.com
Subject: [PATCH bpf-next 6/7] selftests/bpf: Add pruning test case for bpf_spin_lock
Date:   Fri,  9 Dec 2022 15:57:32 +0200
Message-Id: <20221209135733.28851-7-eddyz87@gmail.com>
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

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Test that when reg->id is not same for the same register of type
PTR_TO_MAP_VALUE between current and old explored state, we currently
return false from regsafe and continue exploring.

Without the fix in prior commit, the test case fails.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/verifier/spin_lock.c        | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/spin_lock.c b/tools/testing/selftests/bpf/verifier/spin_lock.c
index 781621facae4..0a8dcfc37fc6 100644
--- a/tools/testing/selftests/bpf/verifier/spin_lock.c
+++ b/tools/testing/selftests/bpf/verifier/spin_lock.c
@@ -331,3 +331,42 @@
 	.errstr = "inside bpf_spin_lock",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
+{
+	"spin_lock: regsafe compare reg->id for map value",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_6, offsetof(struct __sk_buff, mark)),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_spin_lock = { 2 },
+	.result = REJECT,
+	.errstr = "bpf_spin_unlock of different lock",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.flags = BPF_F_TEST_STATE_FREQ,
+},
-- 
2.34.1

