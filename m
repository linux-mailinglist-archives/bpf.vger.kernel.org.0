Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6947C5A55E9
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 23:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiH2VF4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiH2VFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 17:05:55 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289EF74BAC;
        Mon, 29 Aug 2022 14:05:54 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s11so3359583ilt.7;
        Mon, 29 Aug 2022 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=iMrKlQSZZ8llMPUpcA2wkZ6GcnRo6xzhVqACLMFFoSU=;
        b=bIW6nMBxac3oWFkumBvaLSV52Vt9AeCRygcLmOsPHX3jxbSjnojDVwFhOJ+HdvtNze
         P5zhXtolNVwIHZN7XcUwe1zJrKI2XrmMAu/zmRaAWnLuaYhEHl0IoKa1FDsaqgZcLN15
         nuNIOP2iyiCM8TAajoSkPoq4YTwvWn1nHPORFWJHRReuqt4cmS0BLBSutK+PQiK1xooh
         I01m9MfCQNmjywINSvWr/UDdKuHJaic4oPimpSMBerCIbw72oCkbyV46uzYJxlgUPrMR
         1C7D9HO1qaYDIMcsx5dcIeGsHqc59tfavyXoPhuKRjIoT5/1gzONB/ltMwVs7+ipAbAJ
         CS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=iMrKlQSZZ8llMPUpcA2wkZ6GcnRo6xzhVqACLMFFoSU=;
        b=ya5NiYLqm5+vdcZXg52d9HqsAYaM9a+8NxbzFNrTZojCdeFS2iChpPob6ZshG2NrpB
         Xh+dc40JoFRswXtKA9RMNJnTWJow+3iA4zw/P51gPN03yuoWCq6ua2syzC1QL0A+ujpZ
         nQ4rI5E8DyIf+Kxl0x+ynEiuDM6RwyoEGoTfgGRe2R92xNfEcTb7U5jM0VSUAvLhECqY
         ZhWP9UZnlBvriu9P1VCt1rVCGi8NSGYPciC9i1+QfbNnlpcHsU/c47gBwSQWlGOAmF5S
         KMg9Gi/Hg48Rk8QvlbVfkhzc5BzywRKMCLX84ktFkdOoP97ShL0QKuCx6w9xFnFFdB7E
         cusg==
X-Gm-Message-State: ACgBeo1LJaNitOeUmP2Wo7Sx1gGwo5SP8/XW8Zz2ha9EbkCP2d3+UXc+
        UYrDblIwbsmGDjJfWPtmReeNZFWefCu99A==
X-Google-Smtp-Source: AA6agR6HwPl7lcId2NQFwlhhy8MwBh/S/oUdT5J+eVfJVXe2bjQjiGZUk/XL01VRi41cBEqKLyL9xA==
X-Received: by 2002:a92:130f:0:b0:2e4:22c9:7721 with SMTP id 15-20020a92130f000000b002e422c97721mr11343828ilt.34.1661807152810;
        Mon, 29 Aug 2022 14:05:52 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id p6-20020a022906000000b00349dccb3855sm4638981jap.72.2022.08.29.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:05:52 -0700 (PDT)
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
Subject: [PATCH v2] libbpf: add GCC support for bpf_tail_call_static
Date:   Mon, 29 Aug 2022 15:05:46 -0600
Message-Id: <20220829210546.755377-1-james.hilliard1@gmail.com>
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

We need to use GCC assembly syntax when the compiler does not define
__clang__ as LLVM inline assembly is not fully compatible with GCC.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - drop __BPF__ check as GCC now defines __bpf__
---
 tools/lib/bpf/bpf_helpers.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 7349b16b8e2f..867b734839dd 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -131,7 +131,7 @@
 /*
  * Helper function to perform a tail call with a constant/immediate map slot.
  */
-#if __clang_major__ >= 8 && defined(__bpf__)
+#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
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

