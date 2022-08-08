Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B066858CB9B
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbiHHPx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbiHHPx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:53:57 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF1115728;
        Mon,  8 Aug 2022 08:53:56 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id m7so6749145qkk.6;
        Mon, 08 Aug 2022 08:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=dJ+Ni/bJkEWtcZa+5+ckVVEs4jZ3rpmL+NmlOHOSxI0=;
        b=JJBlYJ6pgMxUIdpyomdfd83qt/QUBt5Bsx1tUrfEdcDnHLBdRhm9yTBFxOKrlqk3RE
         5YDYVNT1EAvN2sosEMO2Yz+Zu5+XcNwl5JXH2bLdvhMrnRsgoWtJgP4BzVaH6Sb8uRcH
         LHxMOoMiOU39xM6ilcZBIWb8c97UZwlJaktFqNfDk5q3ASKYQL+3bctkm97qp3FH/UU8
         8/hPtizXIL7DLxj/Lnm/vbEbnNVEU6nUDCuCerBdpKOFx4o6O7Ckh2sV9Hi9Rr7j5y1u
         E2GkDxVyEJi6lZs03k4FrZbjmjH2m6BttOCvmQSsHK0ArkJ5sWcJRQTGsqCFFTbh9OvC
         BkxA==
X-Gm-Message-State: ACgBeo3tXyi0p5+Zv9193JRaXLhpdKj7oQQMiqSC48Oz3psQuTc7lRJX
        UrGY2Eey44a9ij75u93Ky00WzCbYvdCEHw==
X-Google-Smtp-Source: AA6agR4MCuBFZILWTgvGGOpcxpU4+rq3AYeb6jLNkqDOe55Cv4OQewth58ViQ76Uh66RL2QdMyv1fQ==
X-Received: by 2002:a05:620a:2589:b0:6ab:91fd:3f7 with SMTP id x9-20020a05620a258900b006ab91fd03f7mr14768375qko.104.1659974035052;
        Mon, 08 Aug 2022 08:53:55 -0700 (PDT)
Received: from localhost (fwdproxy-ash-117.fbsv.net. [2a03:2880:20ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006a65c58db99sm10009817qko.64.2022.08.08.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:53:54 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Subject: [PATCH 1/5] bpf: Clear callee saved regs after updating REG0
Date:   Mon,  8 Aug 2022 08:53:37 -0700
Message-Id: <20220808155341.2479054-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the verifier, we currently reset all of the registers containing caller
saved args before updating the callee's return register (REG0). In a
follow-on patch, we will need to be able to be able to inspect the caller
saved registers when updating REG0 to determine if a dynptr that's passed
to a helper function was allocated by a helper, or allocated by a program.

This patch therefore updates check_helper_call() to clear the caller saved
regs after updating REG0.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 096fdac70165..938ba1536249 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7348,11 +7348,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err)
 		return err;
 
-	/* reset caller saved regs */
-	for (i = 0; i < CALLER_SAVED_REGS; i++) {
-		mark_reg_not_init(env, regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
-	}
+	/* reset return reg */
+	mark_reg_not_init(env, regs, BPF_REG_0);
+	check_reg_arg(env, BPF_REG_0, DST_OP_NO_MARK);
 
 	/* helper call returns 64-bit value. */
 	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
@@ -7488,6 +7486,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].ref_obj_id = dynptr_id;
 	}
 
+	/* reset remaining caller saved regs */
+	BUILD_BUG_ON(caller_saved[0] != BPF_REG_0);
+	for (i = 1; i < CALLER_SAVED_REGS; i++) {
+		mark_reg_not_init(env, regs, caller_saved[i]);
+		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+	}
+
 	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
 
 	err = check_map_func_compatibility(env, meta.map_ptr, func_id);
-- 
2.30.2

