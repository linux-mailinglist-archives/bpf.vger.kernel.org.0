Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4071F5B4299
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIIWqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 18:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiIIWqP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:46:15 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6766DC6B51;
        Fri,  9 Sep 2022 15:46:13 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y15so1554422ilq.4;
        Fri, 09 Sep 2022 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dzQRKjNXBN2X1C+bDxNUc6KcBKqucdHKpIeoNgjV1yM=;
        b=YQwDKdNbYs9yzPupNoeI+QhCPK4MB/PMHZ0bCIz+6TBW3QUR5JvxaL+Si7ndB6pd39
         nFqYC9g0FuBGsx1F8C8EfWvM8V2py454+1WdhcnZn+O7fXWkpP+tCJa8BVbMh2fJPWLH
         5C4v/98UmDTS98z7QXO93GtieIpFIfg/0bFS2lhInM/iH/Zw56pDuiHZSANy5dYzNRhT
         03zGLZ4WEoCvt74vtT9chot2gdRqhdWzdVWtZmZIb+cslBRPeiCfsRsAZvRh9SQFV8aH
         KiFdWDGRDVgk1h6dGdpIiicCBe85uLAV1vnTtuCCIyDSJNi52tcaHTpsO8bUwrcHaYdB
         /SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dzQRKjNXBN2X1C+bDxNUc6KcBKqucdHKpIeoNgjV1yM=;
        b=T+lc1Jvt/gU2cQwMemGB+JhqFL/AufeWQ02Rb5t6lAYMN6YVbXK/yvR3SMTk3naim4
         KpsVslc0j+lGZaUjH6NuNDkty5NvIA5JlluiHlVo6ITynFzY/agGLpUajRZba3zUNx7K
         F5zR9xTcJ0O+plpF/Wa5WSyMaCfW5ReX14/siUXjQiZYDdSEg0v7OTfXpdtBpJ2ww3NG
         3snwkI6vvBhK1eWcx68OTJgDiHMLGELJixj/BfXFRGVuLyqfXxXdN17F6a8k4O1mVEv2
         zaGdmWXx+VDbM9WLKjy6sPz5qteyJgypFDkOUzDAG8crqAbJQLBgEFuoLUV1d83aVn0w
         RRqA==
X-Gm-Message-State: ACgBeo3ENupY/vtJ7zMJTNHDRmd3JFMCCEdfc5VWu+OGFEPWTdOg9+iB
        wWiYttQfJtVAf2cUBZ6jODFoo/EQV/aCNw==
X-Google-Smtp-Source: AA6agR4GcezE1UgvP/2CEUs2lazsIDtnAHJrPC+kC1DbPhKGyr10Xesvcyx8FVugufLJXTZPeAtG8g==
X-Received: by 2002:a05:6e02:1568:b0:2f2:b10f:6da4 with SMTP id k8-20020a056e02156800b002f2b10f6da4mr5536126ilu.140.1662763572170;
        Fri, 09 Sep 2022 15:46:12 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id q5-20020a02a985000000b0034689175166sm639765jam.86.2022.09.09.15.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 15:46:11 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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
Subject: [PATCH] libbpf: define bpf_tail_call_static when __clang__ is not defined
Date:   Fri,  9 Sep 2022 16:45:44 -0600
Message-Id: <20220909224544.3702931-1-james.hilliard1@gmail.com>
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

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/bpf_helpers.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 7349b16b8e2f..30fc95e7cd76 100644
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
@@ -148,8 +148,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 	 *
 	 * Note on clobber list: we need to stay in-line with BPF calling
 	 * convention, so even if we don't end up using r0, r4, r5, we need
-	 * to mark them as clobber so that LLVM doesn't end up using them
-	 * before / after the call.
+	 * to mark them as clobber so that the compiler doesn't end up using
+	 * them before / after the call.
 	 */
 	asm volatile("r1 = %[ctx]\n\t"
 		     "r2 = %[map]\n\t"
-- 
2.34.1

