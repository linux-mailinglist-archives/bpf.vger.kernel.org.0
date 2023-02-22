Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FFF69F8B3
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjBVQMh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 11:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjBVQMc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 11:12:32 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE103028D;
        Wed, 22 Feb 2023 08:12:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A37B45C0094;
        Wed, 22 Feb 2023 11:12:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 22 Feb 2023 11:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677082350; x=1677168750; bh=6v
        /zPwyX3MdA4FxDLq+vxFIi1peSuQrw2Jm0T+UWKJQ=; b=cZqOCSLoK5QsQv3siS
        9J0QNdr0jy+UwcTnw7+2jp8lucxlqNy0N2nNy95AqBiYZfgQssnmCYANNCJHrhc/
        10OCaQS9bWP9ULTcNYWjNz+fuFi1RDWRCiYkMZWWJb02Oy5FI5YJoVRb2EGijeeE
        U+uiSnjgjpISkppftIo9LmQ5N4cmh0MuWC7l9/+72bI0bNbM4XTT0j2CjWzUjyWF
        VJrSjk6C0bxyGkfsmeMoJhLQHA/NiCWzoe7gt8DrBV5WfmRy5QJrerF1ZFk/jXco
        z0nC6jr4QrcESrcvF69onZVVCAV4WnqitSVshe24IScM1Raw1bnkFf2TWpSFT8YQ
        9S5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677082350; x=1677168750; bh=6v/zPwyX3MdA4
        FxDLq+vxFIi1peSuQrw2Jm0T+UWKJQ=; b=aZTMYZ7wt6iD2jakeE7Lvyy+KfX5g
        vd3kOBE9fHHw905J4+++3XoNAqIaj2hWpJXEZY585ysSAyYgObUvFoyP/0oFHP4w
        Eb9LS3nuyWCskaincwyjWB6qHuuzdG13ZVhcWXbT72UsCt+v0xR9CckmV5NgS3/g
        fJGcuJD3zk6NaQpzhdI3Y7fTVFZtUQ9jBH/meaDAxuUPsHmFCX0LEuT4P3lco44B
        xHSkHvPW0IsYhoNILhlt87zaw9m0FDlgxOkeeEfzMQ2OCJrhpCi4sZ848N9lTawQ
        gdFogq5GpOnHKeRSu6GO+2N0pgw2mbwX/JunEKFyUvdTd8BU3nHJYa2ug==
X-ME-Sender: <xms:7j72Y3PVnlAMRed2dzaBuWCutHC9IMgJl5HsCnQtPTbT_0y7DvIO0w>
    <xme:7j72Yx9QYM_2AQe1YoX4JWG2v8YXrpiRxlYaRRwoJo_jj_PveCcBJAtEHOMyIC8J8
    LW63snxSahfVf8mzgs>
X-ME-Received: <xmr:7j72Y2RP8ok809RKG-L1HusCmXFkfEOMYGe5LITM_rhSkd6xP_3BtomW3qUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:7j72Y7sRk5zWAum9H08BKEptwMyryJNVKMM-AvDgKJoQLTP2Og0uqg>
    <xmx:7j72Y_dSNIuv0y50Ujd9Q88U0exCPktd6KrZAqx3mMuVsqZdmH0olQ>
    <xmx:7j72Y33Za3a7vwJPWAqJIhFhf1IphOk3NAhVrzjYm_UmF5VLjbeGxg>
    <xmx:7j72YwHGDTm0dRBaKRSaAHjZqbkMk0_O0rGVYqjCfUdWY3kw18k9CQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 11:12:28 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        bpf@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/2] MIPS: ebpf jit: Implement DADDI workarounds
Date:   Wed, 22 Feb 2023 16:12:21 +0000
Message-Id: <20230222161222.11879-2-jiaxun.yang@flygoat.com>
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

For DADDI errata we just workaround by disable immediate operation
for BPF_ADD / BPF_SUB to avoid generation of DADDIU.

All other use cases in JIT won't cause overflow thus they are all safe.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig            | 1 -
 arch/mips/net/bpf_jit_comp.c | 8 ++++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index b17130d510d4..7110a6687f7a 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -218,9 +218,17 @@ bool valid_alu_i(u8 op, s32 imm)
 		/* All legal eBPF values are valid */
 		return true;
 	case BPF_ADD:
+#ifdef CONFIG_64BIT
+		if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
+			return false;
+#endif
 		/* imm must be 16 bits */
 		return imm >= -0x8000 && imm <= 0x7fff;
 	case BPF_SUB:
+#ifdef CONFIG_64BIT
+		if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
+			return false;
+#endif
 		/* -imm must be 16 bits */
 		return imm >= -0x7fff && imm <= 0x8000;
 	case BPF_AND:
-- 
2.37.1 (Apple Git-137.1)

