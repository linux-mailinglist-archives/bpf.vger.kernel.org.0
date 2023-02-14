Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1366971BA
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjBNXVE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBNXVB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:21:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BD30E95
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:21:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so294257wms.0
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuAKa6tuXX+2xublR81dUwnlNZg1dDcmp7dUGtQdU6o=;
        b=Ih4Qc31KYK8uH2IsTNdYNG55jcUepyBcBOA0DEzkrbs7iEwMdGdZiJtwv5qwoPtE5o
         9izt/6PXwo/uxhxZz5hJyeKaPdarwN2Pn0i0r7b9tiLXz8mspQWbT/HCkLFXn0nEGTfu
         nWIgY6UBEbhTgt4WjKbPMIwTSjRy5u0eRVq+pqA8p3nDmCH7hF+WGAw75SaAPX4t9XH3
         gjc+fCxGTVyAyAZJhhK7gjfEjD9StnPSQUBe35tltVdtnyc2L7+kpO1Jag1d7s87JUI1
         VkNFupoCO3AYFSjndTJ2c/62PnSjHsSh8oG1rPpC/zaMQsItAqIF5rjvfRB2UuwYRkTy
         RKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuAKa6tuXX+2xublR81dUwnlNZg1dDcmp7dUGtQdU6o=;
        b=oCNbGoC3fvjEqW3zRnArsu3XuJrChauIcXAYm5W9Bca04GDNxKffe6NauQKKxzFDJ8
         7IqaN5l22BS6YrgXopvEJ4uk7S3zadpCP/7XrOuu2TrZqmLAoqj+iJ5JI0rlwPAAHxak
         H8RWS0zIQ6UtjSjtevh2H9DXWsUeW25BZfEYUYttUv7li4b5IW2CzGYZ/vgf0XMAqDfE
         Cjnqwut0Lj+gFMTS0KM/whn21dfa9eQItNdPqh+j7QEyz3c+zb32IvJGAJV4EMQIXnbz
         V/qPprtVUGtV51YOGW1FRp+RBAU6xoxWIyCP9jzdXqLzSPXAt7s/BVI++RTcMjT3kMBA
         SpDg==
X-Gm-Message-State: AO0yUKXd0VvNJjlwWdX2ZlI5VE+8tXCUjfWSERPj7qcIXIEMJEy8OVev
        kEaFY2sDi0QiWY6d5v0pdLammkuuTdYsaA==
X-Google-Smtp-Source: AK7set/CKzQ71go1j6J3orV9As6wB1/4siy/kbfrACrpf28XZ48so8cgZYbqWR9KwQ57XkBqMSC7fw==
X-Received: by 2002:a05:600c:30d2:b0:3e0:c4b:18f5 with SMTP id h18-20020a05600c30d200b003e00c4b18f5mr417027wmn.5.1676416858725;
        Tue, 14 Feb 2023 15:20:58 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003b47b80cec3sm168515wmb.42.2023.02.14.15.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:20:58 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, jose.marchesi@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/4] bpf: BPF_ST with variable offset should preserve STACK_ZERO marks
Date:   Wed, 15 Feb 2023 01:20:29 +0200
Message-Id: <20230214232030.1502829-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214232030.1502829-1-eddyz87@gmail.com>
References: <20230214232030.1502829-1-eddyz87@gmail.com>
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

BPF_STX instruction preserves STACK_ZERO marks for variable offset
writes in situations like below:

  *(u64*)(r10 - 8) = 0   ; STACK_ZERO marks for fp[-8]
  r0 = random(-7, -1)    ; some random number in range of [-7, -1]
  r0 += r10              ; r0 is now a variable offset pointer to stack
  r1 = 0
  *(u8*)(r0) = r1        ; BPF_STX writing zero, STACK_ZERO mark for
                         ; fp[-8] is preserved

This commit updates verifier.c:check_stack_write_var_off() to process
BPF_ST in a similar manner, e.g. the following example:

  *(u64*)(r10 - 8) = 0   ; STACK_ZERO marks for fp[-8]
  r0 = random(-7, -1)    ; some random number in range of [-7, -1]
  r0 += r10              ; r0 is now variable offset pointer to stack
  *(u8*)(r0) = 0         ; BPF_ST writing zero, STACK_ZERO mark for
                         ; fp[-8] is preserved

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c28afae60874..272563a0b770 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3631,6 +3631,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	int min_off, max_off;
 	int i, err;
 	struct bpf_reg_state *ptr_reg = NULL, *value_reg = NULL;
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	bool writing_zero = false;
 	/* set if the fact that we're writing a zero is used to let any
 	 * stack slots remain STACK_ZERO
@@ -3643,7 +3644,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	max_off = ptr_reg->smax_value + off + size;
 	if (value_regno >= 0)
 		value_reg = &cur->regs[value_regno];
-	if (value_reg && register_is_null(value_reg))
+	if ((value_reg && register_is_null(value_reg)) ||
+	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
 
 	err = grow_stack_state(state, round_up(-min_off, BPF_REG_SIZE));
-- 
2.39.1

