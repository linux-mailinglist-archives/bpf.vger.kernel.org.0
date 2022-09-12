Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ADE5B5495
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiILGfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 02:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiILGfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 02:35:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBADD192B2;
        Sun, 11 Sep 2022 23:35:43 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d8so3157324iof.11;
        Sun, 11 Sep 2022 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OeMN0o1tfLEw0gxowCE6mEcXVxpZ30LUoP8MCJFavJo=;
        b=ZtoBn20mbYVKes0mgcPB4tDyqSUs6XQlsMyduznF6RHjsxZUvKs8GA+nSzK76FpKhi
         3O3+Q/nY1eOea9J6+vYdQ8EyCdGawe3b/gjBjGWfmkeZKAUA8KgXOYxfg4osWwCG8BFz
         uv4492+SOhc7n8xcZg+W64jug9pemqJX6bxGduWlC+DvyH2F+1m8U+zfmHfPbX+c0GTA
         1TRf3rKhtNLGUveg88j7mpEOfjfacS3i2rtUAHTkYmH/XLYY3LtRyZWAAckGNWmatzZp
         0WCl8BLSq+oTtvwewCNJ+wF94s5Qd+H5lRMXX2i2CamBG5N54c7tkdppWy5qlE74NCzh
         pT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OeMN0o1tfLEw0gxowCE6mEcXVxpZ30LUoP8MCJFavJo=;
        b=jB0zdzBECUSW0XnKUNTfhwyqO/YhTw7+Vv3CEL5wFz1rOOiunGRnNri2Esij6MSSVj
         B2lpd1ywU2hQLrejPg5CnKO8ZAmA++/MwgQ9yaoukffTYhrdWaZS/icOVo0/hLcHSRbI
         sOoAsAUHvPSLEpAyxM0OXH1xpz8tfrmbvOUeje0KmyWotBoK0ygvi33l+aJEo7CVH5P6
         lGGGzw7AQAuyeCLv8Sjajtqlb9Nm3mpzazB+GnVhntn11UdxXtzGg7+Yo7HfOk/rxHW8
         /ez4sAZyXFkXTmuyalNwh3kxhYcNLYP2LHQqm1Uv4hxmMl7wGHlBZFp38XLDFRrI2w34
         0mfg==
X-Gm-Message-State: ACgBeo1THU7QzgEJdCbmOcmSqXmaAY6SU2cz6jcYFVdjuQY6vxeUfQjP
        prTg28/FP7sBNq9uKj2R1hMNxjQtCvbj0w==
X-Google-Smtp-Source: AA6agR4HLP3lHT2BXIc9pDYr/CPsLU9HeBb2Cd9HkpnfKc3CGdRQqYtBVZB3ou4YmNcqRmavPRJ/Nw==
X-Received: by 2002:a05:6638:130c:b0:356:5271:c739 with SMTP id r12-20020a056638130c00b003565271c739mr13324875jad.82.1662964541524;
        Sun, 11 Sep 2022 23:35:41 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id b41-20020a05663838a900b0035a0d844e43sm2160286jav.159.2022.09.11.23.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:35:40 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH v2] libbpf: define bpf_tail_call_static when __clang__ is not defined
Date:   Mon, 12 Sep 2022 00:35:13 -0600
Message-Id: <20220912063514.2824432-1-james.hilliard1@gmail.com>
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

To support bpf_tail_call_static on GAS we can check if __clang__ is
not defined to enable bpf_tail_call_static.

We need to use a GAS assembly syntax check so that the assembler
is provided GAS compatible assembly as well.

We can use gasversion to provide a migration path to llvm syntax
for GAS once llvm syntax is natively supported.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
Changes v1 -> v2:
  - use gasversion to detect assembly variant
---
 tools/lib/bpf/bpf_helpers.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 7349b16b8e2f..5b98f5506798 100644
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
@@ -148,12 +148,18 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 	 *
 	 * Note on clobber list: we need to stay in-line with BPF calling
 	 * convention, so even if we don't end up using r0, r4, r5, we need
-	 * to mark them as clobber so that LLVM doesn't end up using them
-	 * before / after the call.
+	 * to mark them as clobber so that the compiler doesn't end up using
+	 * them before / after the call.
 	 */
-	asm volatile("r1 = %[ctx]\n\t"
+	asm volatile(".ifdef .gasversion.\n\t"
+		     "mov %%r1,%[ctx]\n\t"
+		     "mov %%r2,%[map]\n\t"
+		     "mov %%r3,%[slot]\n\t"
+		     ".else\n\t"
+		     "r1 = %[ctx]\n\t"
 		     "r2 = %[map]\n\t"
 		     "r3 = %[slot]\n\t"
+		     ".endif\n\t"
 		     "call 12"
 		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
 		     : "r0", "r1", "r2", "r3", "r4", "r5");
-- 
2.34.1

