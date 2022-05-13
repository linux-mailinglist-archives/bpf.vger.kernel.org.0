Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6F525943
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353559AbiEMBKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbiEMBK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:10:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975C328E4C6
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:10:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c11so6487060plg.13
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukN8hGIpUdmPsxoRT+qhF7s2cL7ICnqPohu+0RqRvS0=;
        b=okXTNoAeRTqNuvV9FSYFbbXZn7smsKVPlKB3XpVdWGDlgPyEOkVVgV0Q3Ti+JUS6O8
         CfVA4Sc0aqxbVLGzAc5S8ZzXUl61jHvAVbCTgOO8GnDlniq7WHK6f0wZyoogqUwbF8hk
         rfw8qO9XIeoqZblMDxcvfSlgbeK+R606NRRIUNQAWUcsnHB3yCeE3lVj9xsIwFt+lhsN
         aJqvDU9AnOfaCmWtSLOYKI8PAtKQpuxBj/uurq3vil8RAOpGjGsG4RzTPmyT4fJlDKGM
         ZXV8J0aoGaDhzeuwBPqVyCR9FT5mtHzXyzOjkYhgp/aXp1fvtJRVBixUx17QHQVjOblP
         dszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukN8hGIpUdmPsxoRT+qhF7s2cL7ICnqPohu+0RqRvS0=;
        b=rL5zJfIytk++HR63J+x1DKyrazrapbWG8YNuOcRmmDr0dQk3EWT8Az63uLmRrFGHIb
         mRJC1/5mVUIOeW3FWOMQKOJTIX38rAu7RT1T0SChUcgtebWSwR+kHae1Cp4jA9G1mBqr
         uoNkyesKdtjc5PWCCKYoN3SS/Or+EKQfjbylc/xJpCNTbrTrLoVDXqFhbSINznqcMNJf
         +DNRBBO99EdoPkTCQiKL+VUPxfdyEMYIKr+OB35rEBEZtFT0+ipMB6/QyV4n+klVuayY
         BIiwtHbcNQo/QW2EHS9jNhy2qrl7tdgBed40tI4p42Z1zdZKr3yRSbK8tdk+FThKO70f
         Xx7g==
X-Gm-Message-State: AOAM530NlwYm3HEeCzKBxaXI2cs3S0T6cSeXJnoMa2zmKTZX5P4PZOBI
        jKIoKv/cvqZewdY6sZHv7+s=
X-Google-Smtp-Source: ABdhPJxr6RK2Vm6zeT/qb2V0XyiVK8Sd64xj544nmSrX1fqIePHN+2xouVFx2Pr/MVoyMWJlIw4d0g==
X-Received: by 2002:a17:90b:4b48:b0:1de:af4f:7e13 with SMTP id mi8-20020a17090b4b4800b001deaf4f7e13mr2209808pjb.146.1652404227986;
        Thu, 12 May 2022 18:10:27 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::4:7ccc])
        by smtp.gmail.com with ESMTPSA id o23-20020a17090aac1700b001cd4989ff61sm385139pjq.40.2022.05.12.18.10.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 May 2022 18:10:27 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Fix combination of jit blinding and pointers to bpf subprogs.
Date:   Thu, 12 May 2022 18:10:24 -0700
Message-Id: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The combination of jit blinding and pointers to bpf subprogs causes:
[   36.989548] BUG: unable to handle page fault for address: 0000000100000001
[   36.990342] #PF: supervisor instruction fetch in kernel mode
[   36.990968] #PF: error_code(0x0010) - not-present page
[   36.994859] RIP: 0010:0x100000001
[   36.995209] Code: Unable to access opcode bytes at RIP 0xffffffd7.
[   37.004091] Call Trace:
[   37.004351]  <TASK>
[   37.004576]  ? bpf_loop+0x4d/0x70
[   37.004932]  ? bpf_prog_3899083f75e4c5de_F+0xe3/0x13b

The jit blinding logic didn't recognize that ld_imm64 with an address
of bpf subprogram is a special instruction and proceeded to randomize it.
By itself it wouldn't have been an issue, but jit_subprogs() logic
relies on two step process to JIT all subprogs and then JIT them
again when addresses of all subprogs are known.
Blinding process in the first JIT phase caused second JIT to miss
adjustment of special ld_imm64.

Fix this issue by ignoring special ld_imm64 instructions that don't have
user controlled constants and shouldn't be blinded.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 76f68d0a7ae8..9cc91f0f3115 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1434,6 +1434,16 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 	insn = clone->insnsi;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (bpf_pseudo_func(insn)) {
+			/* ld_imm64 with an address of bpf subprog is not
+			 * a user controlled constant. Don't randomize it,
+			 * since it will conflict with jit_subprogs() logic.
+			 */
+			insn++;
+			i++;
+			continue;
+		}
+
 		/* We temporarily need to hold the original ld64 insn
 		 * so that we can still access the first part in the
 		 * second blinding run.
-- 
2.30.2

