Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04245A54D2
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 21:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiH2TyJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 15:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiH2TyD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 15:54:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CEA7FF81;
        Mon, 29 Aug 2022 12:54:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d68so7480173iof.11;
        Mon, 29 Aug 2022 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WUgMijwl3W/QqZyM5v4oVVeLOTQBRv/iBPfrAQK3cSM=;
        b=GF2Pf2kbP1bSwmxwKabzsaine2PsPmjRpXpr0oIii0TWbFI2h2/VIQ4ER842ndSgHC
         BB+YE71B0mKuwPEQ1JW2qu1JIB+fcQNkrw5tnFmE4ZTgrf0u5y4jM+3B06ASeBLny7qn
         QOF1gAxuY2nLDNq3Rogeqq9yb+zoyju9oujpKoWvGmRsebu1bEe3Kuev8Wm4tNVOFdc9
         Rah+bJsFxRN0WP2SBUjJu49Wy1vbareMzUoywImszv7gJMVCnw0ZPlrASixQYamWGv6+
         LKZ0DvRHRXQZ5TUz18FYNLU/+WCFlOwcqZcb7hAkW8YQBLSQ7geH6Yul4KGS3bVmtnQL
         OnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WUgMijwl3W/QqZyM5v4oVVeLOTQBRv/iBPfrAQK3cSM=;
        b=r/sjUL+PtJ4WL7Q1g2QAkS2wTcBjKjuV8JeDQbzM0Ke+bk2GrPwlB5JBhevHf6O7Ya
         2fy9BO2s7aFMoX6jxiC+vnL3ll6nYnMUd7P+/UCY631q5orNi8XUrXZ9vCCe8zJmx5ar
         y542jkceXeSBN61YJ+khMrskAlkujyj6Cc4FhmX0J8vZnWcw4SESbZuXU0uB+WUGTVUj
         GYkPusmWGVl2yqnj2J3AMRm2jIU7go4ilzWom4Ks9fCJmAlM9VGK5RJx7bHjo9+gBhPP
         JiQXeKAQ2b7jFGAOXDycOiGsN25sML6zTVoFCU78sOURQlp8RvtXoWr4An6FSOl8bN+Z
         hS9w==
X-Gm-Message-State: ACgBeo2ES9rhEU5eoIN8zE2LzfP29zNOpB1SLQd8IdKnrKjOIM86cguR
        Jw1bU6jPTEMCw/a6A9KkUvQGbe/Gy3V23g==
X-Google-Smtp-Source: AA6agR7JxuA2bQaS834AqPvIcem/ZAFJkF8Qf3POvbHbAw2OGF941suyh0ZkzMo0E9PbNIqrQkq18Q==
X-Received: by 2002:a6b:b7c2:0:b0:688:ae30:27d1 with SMTP id h185-20020a6bb7c2000000b00688ae3027d1mr9590645iof.1.1661802841930;
        Mon, 29 Aug 2022 12:54:01 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id 66-20020a021d45000000b0034a54523fcfsm475119jaj.28.2022.08.29.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:54:01 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] libbpf: add GCC support for bpf_tail_call_static
Date:   Mon, 29 Aug 2022 13:53:49 -0600
Message-Id: <20220829195349.706672-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_tail_call_static function is currently not defined unless
using clang >= 8.

To support bpf_tail_call_static on GCC we can check if __clang__ is
not defined to enable bpf_tail_call_static.

We also need to check for the GCC style __BPF__ in addition to __bpf__
for this to work as GCC does not define __bpf__.

We need to use GCC assembly syntax when the compiler does not define
__clang__ as LLVM inline assembly is not fully compatible with GCC.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 7349b16b8e2f..a0650b840cda 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -131,7 +131,7 @@
 /*
  * Helper function to perform a tail call with a constant/immediate map slot.
  */
-#if __clang_major__ >= 8 && defined(__bpf__)
+#if (!defined(__clang__) || __clang_major__ >= 8) && (defined(__bpf__) || defined(__BPF__))
 static __always_inline void
 bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 {
@@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 		__bpf_unreachable();
 
 	/*
-	 * Provide a hard guarantee that LLVM won't optimize setting r2 (map
-	 * pointer) and r3 (constant map index) from _different paths_ ending
+	 * Provide a hard guarantee that the compiler won't optimize setting r2
+	 * (map pointer) and r3 (constant map index) from _different paths_ ending
 	 * up at the _same_ call insn as otherwise we won't be able to use the
 	 * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
 	 * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
@@ -148,12 +148,19 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 	 *
 	 * Note on clobber list: we need to stay in-line with BPF calling
 	 * convention, so even if we don't end up using r0, r4, r5, we need
-	 * to mark them as clobber so that LLVM doesn't end up using them
-	 * before / after the call.
+	 * to mark them as clobber so that the compiler doesn't end up using
+	 * them before / after the call.
 	 */
-	asm volatile("r1 = %[ctx]\n\t"
+	asm volatile(
+#ifdef __clang__
+		     "r1 = %[ctx]\n\t"
 		     "r2 = %[map]\n\t"
 		     "r3 = %[slot]\n\t"
+#else
+		     "mov %%r1,%[ctx]\n\t"
+		     "mov %%r2,%[map]\n\t"
+		     "mov %%r3,%[slot]\n\t"
+#endif
 		     "call 12"
 		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
 		     : "r0", "r1", "r2", "r3", "r4", "r5");
-- 
2.34.1

