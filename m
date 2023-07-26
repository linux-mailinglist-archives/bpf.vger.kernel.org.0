Return-Path: <bpf+bounces-5907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DDD762B6C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 08:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FB0281BD9
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 06:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897EC79EB;
	Wed, 26 Jul 2023 06:29:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A779CD
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:29:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F68BF;
	Tue, 25 Jul 2023 23:29:15 -0700 (PDT)
X-UUID: 298248b7ac0046aba6541fdef59d3975-20230726
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:31363ec0-5fda-4b34-ba66-addfbed97a15,IP:25,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:28
X-CID-INFO: VERSION:1.1.28,REQID:31363ec0-5fda-4b34-ba66-addfbed97a15,IP:25,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:28
X-CID-META: VersionHash:176cd25,CLOUDID:effeccb3-a467-4aa9-9e04-f584452e3794,B
	ulkID:23072614290472T5GNHT,BulkQuantity:0,Recheck:0,SF:24|16|19|44|102,TC:
	nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 298248b7ac0046aba6541fdef59d3975-20230726
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
	with ESMTP id 1987773905; Wed, 26 Jul 2023 14:29:04 +0800
From: zhaochenguang <zhaochenguang@kylinos.cn>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	zhaochenguang@kylinos.cn
Subject: [PATCH] LoongArch: eBPF: Restrict bpf_probe_read{, str}() only to archs where they work
Date: Wed, 26 Jul 2023 14:29:02 +0800
Message-Id: <20230726062902.566312-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we run nettrace on LoongArch, there is a problem that
ERROR: failed to load kprobe-based eBPF
ERROR: failed to load kprobe-based bpf

Because ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE dose not exist,
so we enable it.

The patch reference upstream id 0ebeea8ca8a4d1d453ad299aef0507dab04f6e8d.

Signed-off-by: zhaochenguang <zhaochenguang@kylinos.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 903096bd87f8..4a156875e9cc 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -11,6 +11,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
-- 
2.25.1


