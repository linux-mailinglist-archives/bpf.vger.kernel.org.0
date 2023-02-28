Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA36A5829
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 12:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjB1Ldb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 06:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjB1Lda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 06:33:30 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D71258C;
        Tue, 28 Feb 2023 03:33:29 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C5C45C025F;
        Tue, 28 Feb 2023 06:33:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 28 Feb 2023 06:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677584009; x=
        1677670409; bh=s1U2xDkTTCN+09FeGuSytsW4DsGUYbTluserdVVYkL0=; b=J
        S7YjqqjMr5YgOe7UtXy8AYNH+zm89iNhMdF6uPFa8c9rIKZlr6D/skWvcihdrqMe
        MVhN0N2QaLOBXxH4KT4QjJj8LNWhiVG+uDDcywbamrTEqWDYBWXMtIN8ePVfrKBJ
        RxD+ongbdhHsSZGVyoOqUWGN0lQE43KBSMKmVfOnKb3hJxnfEUa8gF0/EvhGqytW
        gtoC64rbAF/wJS1Q0KEHke8P1/I47xOmDnPYFV27B/ojaLYNqgHioIOGObIIdK4G
        kglckQXTexicuD0XWW7l2h3+4Uhvir00s3eAwfRHEIcpuYhlhJNz85UzGcQcfJ8e
        263Et7WkJFqxuPpF5AZOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677584009; x=
        1677670409; bh=s1U2xDkTTCN+09FeGuSytsW4DsGUYbTluserdVVYkL0=; b=O
        hBAtIle8nroeuEsPTrbLwMP8z3HG5ocOzwb2qZplI+Lynz5MvQfpXC/jHw4OdEi/
        2Nmf1GtIZ355lGVOjJiVOMNIh6aNCwDKwkejQrUw+VL2bAyOlFPFI+S4YYKtMKDJ
        sT0K5bLHUBIcW6I2UgAs2D7OiWbvLzwWw/Zj9cJ5Bgoh2BQ9ZoUQyPu7ZGOYRKgz
        qp3dpWGBKeJND9dbwp0KYSs+ug5IvOZxUIEu9Q1HIZKdrG8WxkhzkX1Asstmf6UP
        twtDilJzeFO6Mm0cGvZyySQ9Jniu+cuaKW8tylBFtBz9J0Fbi4KUOm1Ro3S/yDNs
        Sszeqsvwca9U303gLFX/g==
X-ME-Sender: <xms:ieb9Y2opGMCQWJr_Jfigb9f-LThg2IRSLkIX6W7kvti4Gvda8BSC9A>
    <xme:ieb9Y0r6LOFGVPsUCeppTvGf01HDYPmM_uC0ev_UnlAK7STiN7gIDrD--3GRnnMoW
    65YWQ08kq2yb32PMck>
X-ME-Received: <xmr:ieb9Y7NlnSjhqEXrMgEUEOI2uOOG--LgXFeevk7De0EnCo0A_fGVB18lEXZF7FeKJqIeKJfFprpmWhV_aHCwRnu_gVvoJuidmwbTlXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelvddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepveeftdffkeejfeffjedtuddvudejfedvjeeluedtueefffef
    tdeuvedvudevjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ieb9Y16LSvQXVwG955xcaPLQ4h3XHdEtUveqatvAnUGQN2f4TWiqZw>
    <xmx:ieb9Y16P3zeHc8jRVCAt352rUkpnZtG3bjGVT5PQK-hcG_DAPjc1og>
    <xmx:ieb9Y1gbjdSQLQ32qiNTaR97P9jFGVNR_m8MJX5kUWMAhJjGCFfYIw>
    <xmx:ieb9Yyu96iUsWo-6f1SSK6zhGKF7zya_FuYGU4I4W4k6SwJsi95LXA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 06:33:27 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        bpf@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] MIPS: ebpf jit: Implement R4000 workarounds
Date:   Tue, 28 Feb 2023 11:33:05 +0000
Message-Id: <20230228113305.83751-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230228113305.83751-1-jiaxun.yang@flygoat.com>
References: <20230228113305.83751-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
every multiplication instruction according to workaround suggestion
in the document.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
v2: Drop 32bit part
---
 arch/mips/Kconfig              | 4 +---
 arch/mips/net/bpf_jit_comp64.c | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

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
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 0e7c1bdcf914..fa7e9aa37f49 100644
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

