Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67746A5826
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjB1Lda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 06:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjB1Ld2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 06:33:28 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04246113F6;
        Tue, 28 Feb 2023 03:33:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 701A25C0271;
        Tue, 28 Feb 2023 06:33:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 Feb 2023 06:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677584007; x=1677670407; bh=L9
        nai6+cQcojdRxjq91COMK8Hap2EIINX0BDdi7jny8=; b=BJn8Jm/nPC8mXLQ2PJ
        zmZWfy2T4G8MrRbpWUXVcRjyKepXczKJOUuGqX81Z0c9r1K0WTWTV96nYH2Po4Wl
        LLvVLGCjMGYd/g6ykkOJgBmk52apHA/k4gY37TB5il2JkbeZ06awBTdQY9IB2/od
        JZuBcuc4AUZ6+A74qt+CSgpFQZURdTaBBDZwQaeYxW05E69SxzGKUN/WIEB+7TRi
        QSdMWOaEcI1pGiXXj+8xUg1GOLsK+P5PMJMTp/0rPhMU7TiU+7HaYAcBJWjlfG9O
        faKnywzfHeciYk7tBYFEMYPMk9Ol1mBjW2a5J+oVvVSpUN57vdJqJiV5Pi20fsEN
        DGaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677584007; x=1677670407; bh=L9nai6+cQcojd
        Rxjq91COMK8Hap2EIINX0BDdi7jny8=; b=oLSQzi6bDpi62vN0jJ+VQBmr6WOeQ
        D8Waj3XxgwyzcNiguNgt9YIub0vfFYIIw9zvmm4TIXY+kyTIlxXWfJDC+XA7NfHk
        DEpyB6aSp9CaMaL4ruLslLQYQ1sG4Yni/weBZWLrcwJMpcfoFXKOp6tUoG77L6qw
        PjVxHA7AUtSFN+6ZR6qn+7epKQOGzuK20KHqSeE6nvLbCmvpeKK6XobApWDO7B0u
        930eP0CwIiM49RvrtjOkjM9JlApfAvpWjs6X6rpNrbGFwqrnfTvLGoW3XMSWkPsJ
        /4VwyFjMy7bdtMq5Y246oJRCaqqVJ8zmvirrwKF/N961sv8DSIdiEG+yA==
X-ME-Sender: <xms:hub9Y8uckVsuoCz8UhO0ffZjlsg3atcRu5zpghzf0SKVMTTQk_hnZQ>
    <xme:hub9Y5dA-KwcbZTyWsM1JpNP3mYBub0VLu9v_YWYS6z4pX8dvxe8vSRG-l3rf2xGV
    vkXwVE0VdUIri77zZs>
X-ME-Received: <xmr:hub9Y3yCTyQGJPz2uy3XdK3kDih5YIZjaN49Q_iowR8JEUwHN30c4gdVD-6d5xZvaeE0CqTHJbz6NTw-9t7xtRpigRlQU8LMqi4G5YU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelvddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:h-b9Y_NiSfwzpW6o1XuwKmOtE5KQOKXa8glX7MflHem4sT-SEpLMng>
    <xmx:h-b9Y883bYjvAPBNge4fWEwRdA7xxGYSYO97E3RvPCbegeFVHbrNtQ>
    <xmx:h-b9Y3VZX6x0q1WZCBLUOIzQ0X_xFSrXbMoyYFPqOYPASj3ol_g-ww>
    <xmx:h-b9Y7nRMLFcBYTWzf6_CT80LvGWhKmxJQNCQhXr670kGVBxSRp6wA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 06:33:25 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        bpf@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/2] MIPS: ebpf jit: Implement DADDI workarounds
Date:   Tue, 28 Feb 2023 11:33:04 +0000
Message-Id: <20230228113305.83751-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230228113305.83751-1-jiaxun.yang@flygoat.com>
References: <20230228113305.83751-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
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

For DADDI errata we just workaround by disable immediate operation
for BPF_ADD / BPF_SUB to avoid generation of DADDIU.

All other use cases in JIT won't cause overflow thus they are all safe.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Drop 64BIT ifdef
---
 arch/mips/Kconfig            | 1 -
 arch/mips/net/bpf_jit_comp.c | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 37072e15b263..df0910e3895c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -64,7 +64,6 @@ config MIPS
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
-				!CPU_DADDI_WORKAROUNDS && \
 				!CPU_R4000_WORKAROUNDS && \
 				!CPU_R4400_WORKAROUNDS
 	select HAVE_EXIT_THREAD
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index b17130d510d4..a40d926b6513 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -218,9 +218,13 @@ bool valid_alu_i(u8 op, s32 imm)
 		/* All legal eBPF values are valid */
 		return true;
 	case BPF_ADD:
+		if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
+			return false;
 		/* imm must be 16 bits */
 		return imm >= -0x8000 && imm <= 0x7fff;
 	case BPF_SUB:
+		if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
+			return false;
 		/* -imm must be 16 bits */
 		return imm >= -0x7fff && imm <= 0x8000;
 	case BPF_AND:
-- 
2.37.1 (Apple Git-137.1)

