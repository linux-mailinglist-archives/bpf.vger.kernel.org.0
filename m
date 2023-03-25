Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B426F6C8A5D
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCYCz6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYCz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:55:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F015170
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:55:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n19so2116999wms.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF8P9FiaiI2MSHzgq6xQZtBEtCB0PXnPU8XGOb1XJgI=;
        b=YXUIyv9ZhFKZa93B/vT4qTPfhYkOZt+xekqdVscEJnfz7YfARB52/yPhmPeKa/qbed
         hy5sYy/fZsDtpOhoL5IJNBpZePJzJvXSymBCIYoPsQOhmrQmM1vekuRVAkEpvW4UZeIH
         eJMFCOcFxriSaRhrALnvD6Q9AiGCX5ePRj6KFzES5pHt7HhGw9etPYnAgqI0JHUCGOYL
         +vWT+8H0GT0r3tkWjfYY07a3eI+88UnWhz2qatiI93zBzo93ePH6hUjdvAtlLnUKDydC
         LmV3aPnZhsdIKSxaNlI/ZeKiq2nuDv/lDjC6MmNDY+5kKGey/tvNbR25ETLvqGyEn5SW
         37YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF8P9FiaiI2MSHzgq6xQZtBEtCB0PXnPU8XGOb1XJgI=;
        b=Yoz1VSIIGg6kKivBqlUWND/EeVzEm7bPSPwpRqgBsxdKbNYqMjvnNtKltAgfEmDcuM
         d2hDs9NC70/DcsP2vAlCmTpvZ/ANUlr43U7LYDjyovfvFAfU2EvGtoXF1U0Cdtww8t0J
         oF3wgswnOvxTGtd57UihBzyjCQdvIicTrN3vzIJ06KhSbHeO+tEgJiE8Z+UUtpA0FsVv
         mE12I0ianNGJSwyyOJozLlZwBx9rQ/esD3bcGP6RrkvN4xFbW6CaouKcUAp4UbflRcEP
         3GF0KFJ7tK89mydAO14ciHN5gkHHo2TOfa6vRUVQyHUhtssuB4qAEsWLFkALGbQ2blV8
         du1w==
X-Gm-Message-State: AO0yUKV/Du1F3+t1Ap1aPZV4SKZ/7Y8D2UguRDc8vsFeViKT3HxK3K0S
        4TfjEmqS2gOk9WW2WVxisaUp4TQ89sM=
X-Google-Smtp-Source: AK7set/ixkvI26YDCnM++HsBhqXWVBZKYLvxEodYDy3lR1CCY9p+LrvBnD/ofokbne7we6T8sAuDtw==
X-Received: by 2002:a05:600c:213:b0:3e2:1368:e395 with SMTP id 19-20020a05600c021300b003e21368e395mr3854591wmi.33.1679712954991;
        Fri, 24 Mar 2023 19:55:54 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:55:53 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 02/43] selftests/bpf: __imm_insn & __imm_const macro for bpf_misc.h
Date:   Sat, 25 Mar 2023 04:54:43 +0200
Message-Id: <20230325025524.144043-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two convenience macro for BPF test cases,
allowing the following usage:

  #include <linux/filter.h>

  ...
  asm volatile (
  ...
  ".8byte %[raw_insn];"
  ...
  "r1 += %[st_foo_offset];"
  ...
  :
  : __imm_insn(raw_insn, BPF_RAW_INSN(...)),
    __imm_const(st_foo_offset, offsetof(struct st, foo))
  : __clobber_all);

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 3c03ec8056ce..8b4681a96f89 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -35,8 +35,10 @@
 #define __clobber_all "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "memory"
 #define __clobber_common "r0", "r1", "r2", "r3", "r4", "r5", "memory"
 #define __imm(name) [name]"i"(name)
+#define __imm_const(name, expr) [name]"i"(expr)
 #define __imm_addr(name) [name]"i"(&name)
 #define __imm_ptr(name) [name]"p"(&name)
+#define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
 
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
-- 
2.40.0

