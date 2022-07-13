Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7849573C0C
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGMRfU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiGMRfT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 13:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAAC2CCA5;
        Wed, 13 Jul 2022 10:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F38561D0E;
        Wed, 13 Jul 2022 17:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B7AC34114;
        Wed, 13 Jul 2022 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657733717;
        bh=HFYEMG5wmH1mdTjCQGIo+9rp7fPWoJyZUnWc3Tmd2sw=;
        h=From:To:Cc:Subject:Date:From;
        b=KZH39mymqASDm9q7u3QUhCZoUL+Xy0JxQwhNr+L/ru6UA4A62Xz2q9o/4KkwE5Afh
         UJLM1p0KFFf6v7bRnUfh4vXa+ka3+H+jhcDFwR3isapLzjYSV/rY3Vt77RZZtQku0A
         RqKc+KDtptHIrcsho28fHkXw4/MNky5HsK/qWHVtbyYxbWMvYepM8dfVLRG1eladHQ
         y/yc5sO4hevdwpfw+ay2aic61o+ISvEe3zHgwh7SO8QdGQgsCerk5Alyr61XRT/mgs
         7sgv8jAJI0FuCvBO5XQVosT14554IMlcoNxlWM7oMZwu0N8FIwOmJlyNKwOgt1+N8W
         YiI92vMFWKEcg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH] bpf, arm64: Mark dummy_tramp as global
Date:   Wed, 13 Jul 2022 10:35:03 -0700
Message-Id: <20220713173503.3889486-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When building with clang + CONFIG_CFI_CLANG=y, the following error
occurs at link time:

  ld.lld: error: undefined symbol: dummy_tramp

dummy_tramp is declared globally in C but its definition in inline
assembly does not use .global, which prevents clang from properly
resolving the references to it when creating the CFI jump tables.

Mark dummy_tramp as global so that the reference can be properly
resolved.

Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
Link: https://github.com/ClangBuiltLinux/linux/issues/1661
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index fd1cb0d2aaa6..dcc572b7d4da 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -604,6 +604,7 @@ void dummy_tramp(void);
 
 asm (
 "	.pushsection .text, \"ax\", @progbits\n"
+"	.global dummy_tramp\n"
 "	.type dummy_tramp, %function\n"
 "dummy_tramp:"
 #if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)

base-commit: ace2bee839e08df324cb320763258dfd72e6120e
-- 
2.37.1

