Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6581F3523F7
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhDAXeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbhDAXdq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 19:33:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68580C05BD15
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 16:32:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o129so7365836ybg.23
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4zmDXsca0ECrWDzVS194BszWB+2fKXJW5Au7Imi/uhE=;
        b=PH3FtJBGBsmgrkbZDVz3BXtOomtM40isF73uxHHdcAgWFlI0hQzmJ+Yiu0Nbk36AiS
         oIUF/OouhVLXAHv5lePfztQEQCdoF3WKPYY1A6g21bn1QVawFocJ0FQMqW+JvkyRMXC0
         7MlgKTeKlTukJdkvN/08vCaQdhh5X+mvr2muSbV3dFgjINzTMQPZYmQpEcNiuXE8tNMf
         3VgtV0lRhBFCEGG3XpYQc/aLht2YKd/8ej+EsbM8UOkPXsBBShbt6fFkrZnQbYbNFDMD
         JSw7hOAw7svmOppJvJC33a/bIukeU+OjfUKoipleTgiaIG9tnHBTD0G84ol+6TIFQPCe
         UDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4zmDXsca0ECrWDzVS194BszWB+2fKXJW5Au7Imi/uhE=;
        b=Mp9/IT4Y5mUWlwC4jVefNVt2KKzNQEDl3VA6WeKLCo7Rz1fNp2N6ZmUzL9E+TPueYn
         JaUr5KY9S4DOaTQfxJbf3xJxHDLVKNCOsZV9Bnl96eufVSYbzz4itzIMR0yocgQ0iR6g
         roFaYz0UnOEqsqhgn98F+SgZgxTGq70GJVT7IvZn06vu+SM3qP7uevIuzzu3HXseCC8N
         wSNIWV92AL36F0pEVU7QlM/UdEmjh0K89IKIbYJQeT2J1RwlsP+JcLjsLt4EjoPFx7IH
         rqK0NAcE/fR1RypBS/acWnyxtzv8RtZoZHQUyaZBnGt7B3X0ygXJxpK32TkAS2QKuIt0
         Aw3Q==
X-Gm-Message-State: AOAM533/5Gr+YLrQwtPt2ndoQfmpKt24PtujQVcYHvdcB9RTjK2pInIM
        cxZbhthxfRvIfnO2d0EpyYflCmMyjuS2hb2IPwc=
X-Google-Smtp-Source: ABdhPJxZF9glk9+ZtBirKYDEGjQrdMhhNWgdR3tCZ5JLBfUCEc7h35+3XPVRFL47JJ5bGJZvKS8N/Lhi8ZZQtRsAJC4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a25:880c:: with SMTP id
 c12mr15159486ybl.399.1617319972614; Thu, 01 Apr 2021 16:32:52 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:14 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 16/18] arm64: ftrace: use function_nocfi for ftrace_call
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

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which breaks dynamic ftrace as the address of
ftrace_call is replaced with the address of ftrace_call.cfi_jt. Use
function_nocfi() to get the address of the actual function instead.

Suggested-by: Ben Dai <ben.dai@unisoc.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 86a5cf9bc19a..b5d3ddaf69d9 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -55,7 +55,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned long pc;
 	u32 new;
 
-	pc = (unsigned long)&ftrace_call;
+	pc = (unsigned long)function_nocfi(ftrace_call);
 	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
 					  AARCH64_INSN_BRANCH_LINK);
 
-- 
2.31.0.208.g409f899ff0-goog

