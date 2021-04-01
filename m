Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31CF3523CF
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbhDAXdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhDAXcv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:51 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E193C0613BC
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 16:32:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o206so3035751pfd.1
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ygu6iZbbUsR2ZKi8zr0iQyDyVVNKo7dHAEFjMtj8SHY=;
        b=cVUYELPkwyakQO4gpJ1n7nG1A7rYRu+EIAysLbBiPdUejJzOzMX96EChrBRzMBh6zW
         x0dx0cW3zE0Wop2s4iCPSYOfpp1cHt4q/JDYejpAPuJ5EaZ0LDn1eQc/EZSSQ+JcI/Ep
         aSzshOkORkt5as8iBp+LK+0GHTFWu6E+X7Dt6fjBCwDhmMdVOEg0cYoWse5r7hWwupSI
         GIMWTyJUk2Pdk4jDTUiSZMOsvnGKcBr86YBHhdMz5J55XRKRhzQZzbLI8+1/ECst6qrD
         FS5MXyt1H5ODIdkNU7FRNKO5mEHgSlK1RJwyJk198zwyxxkaAm68PyCFKSZaJgsbK+DZ
         4xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ygu6iZbbUsR2ZKi8zr0iQyDyVVNKo7dHAEFjMtj8SHY=;
        b=tlTQpaAmrUjxwlWVVeLb6P7HFpZS7rrgxh6gDickUdkyY4OI7nCanpgk529ghjBr66
         1aj8eFfEUdcTZEvPi1WlhD8M3NCTk8dTJJ/ri5hygLdrwTExWr+mpP/MKhfYUNDY3wGQ
         3WV9H04JcJt6jTl80IK+KPdAQvj6hk6UwQwjjP3TUei5lRQskrt1ZY+4LeZzKbNk+ZFn
         77sqYmf51ms5l5Oq7hOMw2L0Z71Pf9773hJijVPDHgTZnLj14t+oj66OZM2iaj7ByYvP
         zHJcmTyaszYm8XbQECQx/KOq3I5al98qJbKikoD3xiBNA/IqIbWvEiIz1LthooFmSMD8
         edWQ==
X-Gm-Message-State: AOAM533NTGWocwP+dHF9PQLo3t5709dJhP75S7cH0i5+5AtUHQiG4e9I
        QeDF8FU87UHfCIkYHYObEdEaEqGP4OOl+E01Tpg=
X-Google-Smtp-Source: ABdhPJytGMUSgXoVFpBf4jaOpktUMQEi2HRt1jGw3DzlgyJAUXzE/JwtBHr7mViI1KpDfZlI/n45nehfSKBWCsiw8+4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:9008:b029:e6:f37a:2183 with
 SMTP id a8-20020a1709029008b02900e6f37a2183mr10163478plp.49.1617319955033;
 Thu, 01 Apr 2021 16:32:35 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:06 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 08/18] bpf: disable CFI in dispatcher functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF dispatcher functions are patched at runtime to perform direct
instead of indirect calls. Disable CFI for the dispatcher functions to
avoid conflicts.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3625f019767d..2f46f98479e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -650,7 +650,7 @@ struct bpf_dispatcher {
 	struct bpf_ksym ksym;
 };
 
-static __always_inline unsigned int bpf_dispatcher_nop_func(
+static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
 	unsigned int (*bpf_func)(const void *,
@@ -678,7 +678,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
-	noinline unsigned int bpf_dispatcher_##name##_func(		\
+	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		unsigned int (*bpf_func)(const void *,			\
-- 
2.31.0.208.g409f899ff0-goog

