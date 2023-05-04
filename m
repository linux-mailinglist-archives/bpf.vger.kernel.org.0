Return-Path: <bpf+bounces-4-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ADE6F73D5
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768D81C2126D
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F124C130;
	Thu,  4 May 2023 19:42:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B8C12A
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:42:43 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5A93FC;
	Thu,  4 May 2023 12:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 18761636FD;
	Thu,  4 May 2023 19:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359AAC433EF;
	Thu,  4 May 2023 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683229333;
	bh=yGdU6LmRneX8nmQX8uyT5+6jzBckt9pX6pzjCTeRi0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=up5Bk7EF5nRxMm1nEmcOJjDb/HdVhTu9QezQ1272GuQVm+Ha44TZxMMozvP1LgQ3Q
	 siwMYouvP42rXuzFx4ukC9tODIu0ADWkG2gK3v2sXt7Xyr5ukoX/J2rpC5JyoZWAT5
	 OHV9JAhS6n7Pdes1LbctROp3BHzGNw+A5SICvIJFxET22gfuB8jLN50hwZ60lVX8Kk
	 Z90ZUanyA0vWgdYIW4/ib775kfsTgTKIBRrNlNlsIurjTS+ilv9ghkby6VJLodYLRf
	 Z0h1iHcRkR6/opv+i+/9+7ntOfrSj9y3twLPnjBKgzKCV9XjH6hf1EaBYCXMjtzkp/
	 YsK2LxxOigbkQ==
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
Subject: [PATCH AUTOSEL 6.3 08/59] bpf, mips: Implement DADDI workarounds for JIT
Date: Thu,  4 May 2023 15:40:51 -0400
Message-Id: <20230504194142.3805425-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
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
index e2f3ca73f40d6..edc7d8790f1e8 100644
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


