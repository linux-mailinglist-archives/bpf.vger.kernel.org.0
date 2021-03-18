Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D07340B53
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 18:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhCRRMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhCRRLq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:46 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EDEC06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:46 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y26so23010161pga.10
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qy/qpaQcjeJGAGSX/SJfdvrV6+xztRS9WV/l31kV3fo=;
        b=c2hTTF5tVw2Zkjg2BQ/t8/oPhiKF2nLKpbN6o85lqbzdLuNwgLxdZtapB3jgv7Jtjn
         5PPpgX2oj4cWhKsE+uMWJ510PLIzgH3HaO2mO51+/aXSn9MltdR+iyxrSmFuV8/OuxCq
         HEI4OcimcN242vISpRy0KAcVRLzmHZ/l71eQW7cg9ktaf+xkDMqexVxFVlz/23ieFoQE
         hk4tlgYSkhKIeFY1jby3Py3Ch++ovSOcAKpWSL5Sh/N7Jj48vC8xq9Vdd5eimNRIuQfl
         m5cjcZifAhB80labrIm2se6EWEROyemU19ZF5F75p0aKuw1WLupxSw9+ozFe9rhyZnj1
         shcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qy/qpaQcjeJGAGSX/SJfdvrV6+xztRS9WV/l31kV3fo=;
        b=Iy6y0vi6R94/KuohrBeSE7lct9aw1IpbelT5KDinX4QjUtKgbl/vdnfk1PgWH1VtT2
         MUN5oZr9AEEfwtQoRDVZ//cua033Rg1KQD/vSd1PuJOjgFbpuO+Ly5plI+kdetsXvqBC
         Deo0gF9lYjGHhObJWKf1A268FycxrONE8FlhwIriynmmFQD8R6OJ6BCrrAxpqRaHbSiu
         3/ZOoRvfkBpWUxo0p9yjSuiTgBmpttM9XfCsFZZJKbj3XF8totHonV003hELro0JP+10
         vzFQTQQoBo3ZrB0Vb45A16Wftlv9/HFyRTcz3LiPk292l5wsMOwggGvCRBCwlpn2hsXz
         wkhA==
X-Gm-Message-State: AOAM533QiKh3buwq1tyS7LxbivzK2NQgyB3zORf0UkB2QMFvDDk6u5GW
        Yh2kMiu9ee4HtQHa0BVUZmd2emlR8zm5qKcakpQ=
X-Google-Smtp-Source: ABdhPJzCXMFhAa2NKV6IDoPedF109qURHLuK0r/JIiSgzJgQstBmygmx77tZs7udLN2dCC5RnEr52xTHcy2QbI0lfG8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:fcb:: with SMTP id
 gd11mr1106688pjb.0.1616087505409; Thu, 18 Mar 2021 10:11:45 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:08 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 14/17] arm64: add __nocfi to functions that jump to a
 physical address
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Disable CFI checking for functions that switch to linear mapping and
make an indirect call to a physical address, since the compiler only
understands virtual addresses and the CFI check for such indirect calls
would always fail.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/cpu-reset.h        | 8 ++++----
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 16cc9a694bb2..270ba8761a23 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -119,7 +119,7 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index dfba8cf921e5..a05bda363272 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -13,10 +13,10 @@
 void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 	unsigned long arg0, unsigned long arg1, unsigned long arg2);
 
-static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
+static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
+						       unsigned long arg0,
+						       unsigned long arg1,
+						       unsigned long arg2)
 {
 	typeof(__cpu_soft_restart) *restart;
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7ec1c2ccdc0b..473212ff4d70 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1443,7 +1443,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void
+static void __nocfi
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.31.0.291.g576ba9dcdaf-goog

