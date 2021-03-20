Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7A34293B
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 01:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCTAAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 20:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCTAAE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 20:00:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1CAC061760
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 17:00:04 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u17so33096545qvq.23
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 17:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oRO6V4kyhNwQVkxp5wVbKiww18hZhgJE1+XBqqpontc=;
        b=VQh+b2d6VkDVIwEEIF+paEKHKEfS0TJoMYaysVLIkKKNcJhMCLGIVu95R+5VnR+tu2
         hod1FyumjnvNRY/4uoelmWc2S2H3GiQNi8JdCXGJrQUhsfG5SNhqePX23QyyZ5sXzf/T
         ftdozoHDn6kEblaYjZ6lr26oEUYVyLZRbgNost/pr0FEtZWy0giO2o8JyyC30CSLxIYH
         mUpsGgTJOrHFNmNV3Ed/ZjvZQJLuKRk5eXPRstjQgaqI354oEEhqw9mZBzw03eRVkr6N
         ff/L7GiO32Cfedjyx7Ebr3bGOHS/o6HYuvQg3N21FEC/xDm30FGfwWfLXUl3MdAK3gUn
         O0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oRO6V4kyhNwQVkxp5wVbKiww18hZhgJE1+XBqqpontc=;
        b=Zcw0u+QkRNLeBrnnMOC7z7KwAkZOWGScY707Z8rTDawySLFIQNLYS0sI0wmfOhw1LM
         7mua2oxaK2Op/DczU0DSaOorXDUh4oPzfr+HBK/5vO7Xn21RybiijGypyl9cvy+ZSLuP
         Xt0WKsVyVhR8arc2YS7iF6zmd/Ani1m1r1xpXk51A+4RgW8/HaWj8wP3IdW4/YMqZ23T
         mTAHK8uBtRHB0XSGBDjBLPC3bw0Cq9hRupIY1nWltPp5tJcQBw0mLtLlGqfsGw5l5R/f
         kt4Lw8Ajx4NFQxkdRVFNXncpoYIIah3CRsIrmEMAFyKRA4ikgTMea/BerNAjy2c4S+fv
         wimA==
X-Gm-Message-State: AOAM530VMKifdEyWLh0aga5BAe+INoI9H0jHOw4BglIhmzJla3eH58bm
        Hjlj7Mz01oOcDSErPjTQZSMfIfg=
X-Google-Smtp-Source: ABdhPJxxoeyk2e7+jO81gnWwZkF5t6YzHc9GgpqG0Tc6GN6B5aRFsd8KkR8zISnPEJ2qi6/O4Agns+U=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:c149:3008:7703:e722])
 (user=sdf job=sendgmr) by 2002:a0c:df02:: with SMTP id g2mr11730912qvl.40.1616198403418;
 Fri, 19 Mar 2021 17:00:03 -0700 (PDT)
Date:   Fri, 19 Mar 2021 17:00:01 -0700
Message-Id: <20210320000001.915366-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH bpf] bpf: use NOP_ATOMIC5 instead of emit_nops(&prog, 5) for BPF_TRAMP_F_CALL_ORIG
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__bpf_arch_text_poke does rewrite only for atomic nop5, emit_nops(xxx, 5)
emits non-atomic one which breaks fentry/fexit with k8 atomics:

P6_NOP5 == P6_NOP5_ATOMIC (0f1f440000 == 0f1f440000)
K8_NOP5 != K8_NOP5_ATOMIC (6666906690 != 6666666690)

Can be reproduced by doing "ideal_nops = k8_nops" in "arch_init_ideal_nops()
and running fexit_bpf2bpf selftest.

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 72b5a57e9e31..b35fc8023884 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2012,7 +2012,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 		im->ip_after_call = prog;
-		emit_nops(&prog, 5);
+		memcpy(prog, ideal_nops[NOP_ATOMIC5], X86_PATCH_SIZE);
+		prog += X86_PATCH_SIZE;
 	}
 
 	if (fmod_ret->nr_progs) {
-- 
2.31.0.rc2.261.g7f71774620-goog

