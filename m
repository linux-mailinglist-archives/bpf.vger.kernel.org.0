Return-Path: <bpf+bounces-8-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1426F750A
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D42280F6A
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 19:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195A513AF0;
	Thu,  4 May 2023 19:45:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AF13AD8
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:45:02 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9CB17DE3;
	Thu,  4 May 2023 12:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DE0806376B;
	Thu,  4 May 2023 19:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1769BC433A7;
	Thu,  4 May 2023 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683229478;
	bh=qZYIJvR010xYBic9m1qbZLw+mEEFPpB8Iz+8lLPEuHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hk9bw+0Z4zwONKPImrFlZgbnauNEuuynZbrdU476wcq3gzVQ5QavUlGWZSU8Hz+2J
	 l1iZl82FvqJMwokEg5zcozlfPM9dOtxan0ERJh5JNG9d68DopYiDBF2L3+eESHpA12
	 G8P39fYivlykyaDIk/RWuwbb6L+Mmlx1b0mp1jvpCCKcqr5y/QkQs9854boBJyLLGd
	 iGSZHeKRxZsWEYpJSqGp8iSlVrkFgck4+scbBKoOao+yxZlJX3sDWk9CUOcc9z1wgC
	 x/iVsJ+2xN5Om22QSNYR1hERIJHeOBgrcwL8pP45JhATbdHXLa4aNZeKhWu6CzB3p3
	 KEBLA/lOTVKtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Sasha Levin <sashal@kernel.org>,
	tsbogend@alpha.franken.de,
	ast@kernel.org,
	andrii@kernel.org,
	paulburton@kernel.org,
	linux-mips@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 06/53] bpf, mips: Implement DADDI workarounds for JIT
Date: Thu,  4 May 2023 15:43:26 -0400
Message-Id: <20230504194413.3806354-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit bbefef2f07080cd502a93cb1c529e1c8a6c4ac8e ]

For DADDI errata we just workaround by disable immediate operation
for BPF_ADD / BPF_SUB to avoid generation of DADDIU.

All other use cases in JIT won't cause overflow thus they are all safe.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Link: https://lore.kernel.org/bpf/20230228113305.83751-2-jiaxun.yang@flygoat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Kconfig            | 1 -
 arch/mips/net/bpf_jit_comp.c | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 15cb692b0a097..b89c4bf2fa0ad 100644
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
index b17130d510d49..a40d926b65139 100644
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
2.39.2


