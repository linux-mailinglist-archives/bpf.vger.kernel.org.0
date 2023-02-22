Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80669F8B6
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 17:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBVQMi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 11:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBVQMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 11:12:33 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB33D092;
        Wed, 22 Feb 2023 08:12:32 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6123F5C00CD;
        Wed, 22 Feb 2023 11:12:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 11:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677082352; x=1677168752; bh=6P
        LncvDNe/nJ55qRYE4c+4zrSl5PSlFbdt4C/GIEcco=; b=aH62uEIk63UXx1CdBP
        MrPiynszOEQQKeSVOgh5rzwrdmLksq7nprALqTARhAJH/9s8y/k4b0BmWrRclpCC
        NSnuqUDJNkKazc5qxkxCbKgymEjhkO0d2oL7kaN9RfwVvh8I1ml00OS6g+6PFvJp
        GDU+fLCa2xe0fJfsBSrLFTJg3fjEDJApuf6DStjP0ejIBduwKKC0c7JMgVuFC2xP
        TRqUHBXfH0eDGu6IfYzSvOzpjnLduVEfl7EGf9NdjAQcUssJGhOkOuOjtF2jxnMr
        lYXbJ94TSbPZ2DQUwItMBNiNyl7wNwplAEPcP2xU1U8V4RoLAHo5yeC6gKP7YuCL
        JvHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677082352; x=1677168752; bh=6PLncvDNe/nJ5
        5qRYE4c+4zrSl5PSlFbdt4C/GIEcco=; b=ldnB4JNPTsZqfVuigS5UjTIMcrR4l
        GO5rL+RdG2I/uelk/zPpR+JWaVISGYsq3yzmFOZw5wDYNkMhX8Q8FX1UuDE7Pz+b
        iYd0WsVeAp19f6UDfv22mS/UL+hVw9Od+OLECQTFKW3z1YyeM8livcxh+ILvl/B8
        Y8hbJphQjpi4I5KcIIirX9yXv185tYjOsXZ0L8AzZmgbPIBQVsiX4aE9zFqZp+aD
        sF4KZweYmyZ41RaayPcyNpxieX7mTWCHuKgQcL+n+qVdzp8qw7zH3QiOaY76aENy
        kZdeOZoGG/EewPeqKEK1PENt1KqgPxVGg1OTz1ms+rkJ6hk99Ir9fxozw==
X-ME-Sender: <xms:8D72Y2VSDVvtknQRC1WHidBWahODN70M9nphm1HSPjBsyYkxRMh4LQ>
    <xme:8D72YynvxI-78bvSX5hE8_sBLEo-f88Png_rvAInX7KpVESVG-v6ztJKf7_CXjK6S
    SlUiSWzHMLQA7_BqBo>
X-ME-Received: <xmr:8D72Y6YC5SQS4Vcx4rXASwvzC19RvrxHL4wldgi3fnivNcK8_nPHMUoO2oPl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:8D72Y9Wwzh9bdiFqf9LUNIY9Z4ZmhUQywnnN8wsUBAB_bnrxEhNvKA>
    <xmx:8D72YwltgDSI5GsJuMbUku6i-JBwUdAiEhj8hRBu2_5o4kCgaOta5Q>
    <xmx:8D72Yycf14-9d4ZRqke7DxC_P3tBmd4ZLV24wDN7rEEezjZAEKAHDw>
    <xmx:8D72Y_tZbEatKZzO6f8o2gGJShfu9Fic-XRcTVos0-3Op_vONYcV7Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 11:12:30 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        bpf@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/2] MIPS: ebpf jit: Implement R4000 workarounds
Date:   Wed, 22 Feb 2023 16:12:22 +0000
Message-Id: <20230222161222.11879-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For R4000 erratas around multiplication and division instructions,
as our use of those instructions are always followed by mflo/mfhi
instructions, the only issue we need care is

"MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0" Errata 28:
"A double-word or a variable shift may give an incorrect result if
executed while an integer multiplication is in progress."

We just emit a mfhi $0 to ensure the operation is completed after
every multiplication instruction accorading to workaround suggestion
in the document.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig              | 4 +---
 arch/mips/net/bpf_jit_comp32.c | 4 ++++
 arch/mips/net/bpf_jit_comp64.c | 3 +++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index df0910e3895c..5ea07c833c5b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -63,9 +63,7 @@ config MIPS
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
-				!CPU_R4000_WORKAROUNDS && \
-				!CPU_R4400_WORKAROUNDS
+	select HAVE_EBPF_JIT if !CPU_MICROMIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index ace5db3fbd17..fee334544d2f 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -446,6 +446,9 @@ static void emit_mul_i64(struct jit_context *ctx, const u8 dst[], s32 imm)
 		} else {
 			emit(ctx, multu, hi(dst), src);
 			emit(ctx, mflo, hi(dst));
+			/* Ensure multiplication is completed */
+			if (IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS))
+				emit(ctx, mfhi, MIPS_R_ZERO);
 		}
 
 		/* hi(dst) = hi(dst) - lo(dst) */
@@ -504,6 +507,7 @@ static void emit_mul_r64(struct jit_context *ctx,
 	} else {
 		emit(ctx, multu, lo(dst), lo(src));
 		emit(ctx, mflo, lo(dst));
+		/* No need for workaround because we have this mfhi */
 		emit(ctx, mfhi, tmp);
 	}
 
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 0e7c1bdcf914..5f5a93f997bc 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -228,6 +228,9 @@ static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		} else {
 			emit(ctx, dmultu, dst, src);
 			emit(ctx, mflo, dst);
+			/* Ensure multiplication is completed */
+			if (IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS))
+				emit(ctx, mfhi, MIPS_R_ZERO);
 		}
 		break;
 	/* dst = dst / src */
-- 
2.37.1 (Apple Git-137.1)

