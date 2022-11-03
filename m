Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95596618844
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKCTK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKCTKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:10:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ABB1E3C1
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:10:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p21so2834285plr.7
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfGmH0cBT6tf3UrykusXtQYhxpCV2TiVyfPMAyp7idY=;
        b=YyJrKt9kmnikIA6saw0QXsCSOcku8hbo0LN+PhinKiRaE2doYf4NEaFUR18dTI0UxP
         y2Oz87dkjvlHCPWN911+rfb5ru9x+P6YhFeHX4D9jK81vsfKIZRrwcOtJnfu2I3gcj1p
         v3koTptqX2qVBxXedyrQiNKu8vetQPYBhm4q7pHNW/jtGrw5QSdNop/but/ynaqG+0Or
         sJw/NXP69VdO6dk7C3vmd7xrssIvmcO/xjuVw4WmyKY0u8QPW7G2d2kJESnWhFAFewQ9
         BpDBLP5DRTdqi+iVNfZaTaWJf2L8F5G7UCb8KNhVlR1z9Kbjg8/5HBNQwa7Pqsn7NVjU
         SJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfGmH0cBT6tf3UrykusXtQYhxpCV2TiVyfPMAyp7idY=;
        b=gmuLDdLnQ+LwcpvKFrx0QnNhsMpJ6sPBjZghOW3uN1VfZzX6gZ4N7LPNLua2mJxC9s
         ErBRYTIRVkg4f+qDAs/VGPUbhLsoqrGebbhK/EjIKIwIZbm3X+x6cVzARwMcANF2GvIT
         SRUnxYkMg7OC4JBVLnAha5GOqz38rwo/LTlqoGr52Fz184wmBL460+UHQ4GxdxplUp2J
         Gq4ubKX02BsO7ykEgOWDFSn9IXHO/xdrevpj7E2t2DEkJ1/kDwLm/jBYTMhRNagHFyDk
         TJnoQpryBbJIp1S5L3fIi9SZph0HDlyTUz3hKNomR/5JZR//eF2dPE3fjyCFwGCdLR6u
         RugA==
X-Gm-Message-State: ACrzQf3iJG29w8qMEKy/wjlEldxxtGrpygJ+5THyF3D27ZiVBOq1dVWO
        lIYqX0sHZNnWada/VdAiHmeNAC3vCw6ocA==
X-Google-Smtp-Source: AMsMyM4ZGayr9nFPxCXyfSvDb62cFHk8fSDs9agRTxLfS7CAmLXH0TQ76ADDXBIwJ+h23RrkjZWAXQ==
X-Received: by 2002:a17:90b:2353:b0:216:3194:fc74 with SMTP id ms19-20020a17090b235300b002163194fc74mr3984299pjb.112.1667502646221;
        Thu, 03 Nov 2022 12:10:46 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id x188-20020a6331c5000000b0043941566481sm1104009pgx.39.2022.11.03.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:10:45 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 04/24] bpf: Fix slot type check in check_stack_write_var_off
Date:   Fri,  4 Nov 2022 00:39:53 +0530
Message-Id: <20221103191013.1236066-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916; i=memxor@gmail.com; h=from:subject; bh=AnZ96Bk1+My2wmZMNe32Fdu/YdcMzWPygNF6Nx+G9UM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIA4UHf4bfK3Iz2CCatKTOTMQFO+fiSaL116LSH gRREdUOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RyvTaEA CnU/sXQD9TbDj04g4awHU0oPj/QaJpcAIwvcMltHj669eUoWJSbNYvUPiXbw3ERbAEUDXRt3XSJVKa 9AlXlCVcw2QLU4otiNpO2eUdBJUmT8KUqT/0XPidzT+oArhYy5ezukU3bSxKfSgd5gCweKZYxYiS55 1GIuqf9gJxYsPh8IlVxXMqGC4h0ekAs3pq6pX3TJyqseEOirMUdt/2dZWoo6cBATWP7WOinqhXATVw 4ld/EUx3FxJWEARgsgoNFUdwLU+JyYk8//tb/lKZWZHhfW0mLbUihp7Keqv8d62Eu7T6DYmqqLz/hv MhDoiM6QAQDJfeffYo57l9DpKdYLUxDP5xHLpNkd2sXyjFdZoQZ3vTvooG1UzYRlMhsE9xDJHVaB4D 2j208yZL3DksY0QYhsrjakDgKndpHpf/FNHTsyqAItyeoaUlBcE+sqcO0lXW65A6aG/jtLcP0HoCF+ oZ8x1LcQgre40pljQ0nUCkxpRDGjWXzyb+F8yjluWJTCBay1qFowzSDTBYpwldH6abHrm2AS6xzvPt Ir3oYM7Ii/hsBE7a76yk7uvEgFSETk6TufJIAABUv8+2zoYYBTVluFben5UVkggbrqU5GKfDQM3TtQ A7BYQbaS2kSJdW6LoPhdQSHAVoD23cTVuRPoquZQ1kyTpfXrflyoLo5rEAsw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

For the case where allow_ptr_leaks is false, code is checking whether
slot type is STACK_INVALID and STACK_SPILL and rejecting other cases.
This is a consequence of incorrectly checking for register type instead
of the slot type (NOT_INIT and SCALAR_VALUE respectively). Fix the
check.

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7bf12c492201..eb111a8034e7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3181,14 +3181,17 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		mark_stack_slot_scratched(env, spi);
 
-		if (!env->allow_ptr_leaks
-				&& *stype != NOT_INIT
-				&& *stype != SCALAR_VALUE) {
-			/* Reject the write if there's are spilled pointers in
-			 * range. If we didn't reject here, the ptr status
-			 * would be erased below (even though not all slots are
-			 * actually overwritten), possibly opening the door to
-			 * leaks.
+		if (!env->allow_ptr_leaks && *stype != STACK_MISC && *stype != STACK_ZERO) {
+			/* Reject the write if range we may write to has not
+			 * been initialized beforehand. If we didn't reject
+			 * here, the ptr status would be erased below (even
+			 * though not all slots are actually overwritten),
+			 * possibly opening the door to leaks.
+			 *
+			 * We do however catch STACK_INVALID case below, and
+			 * only allow reading possibly uninitialized memory
+			 * later for CAP_PERFMON, as the write may not happen to
+			 * that slot.
 			 */
 			verbose(env, "spilled ptr in range of var-offset stack write; insn %d, ptr off: %d",
 				insn_idx, i);
-- 
2.38.1

