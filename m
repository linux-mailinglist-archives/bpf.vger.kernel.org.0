Return-Path: <bpf+bounces-47689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FC9FE32A
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 08:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6043A1A0A
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1341E19EEC2;
	Mon, 30 Dec 2024 07:17:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC528F4A;
	Mon, 30 Dec 2024 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543033; cv=none; b=AT+nj8WCJacTzBa4CTQOetO028chOwxC+47hkT5P0QvFCNJk8eq2gjh/Q0qUCLy/VUGRI4RCvkXolbYdP3z8nwhU22hCFy/KEZWKeYoA8zeRLn7Gheh7/H4XSQ0uh5uh2T9GZYTk/K6j7vJZCve33VDujyr0Ajpuiop7G4ahI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543033; c=relaxed/simple;
	bh=NmS5i2qU3obD3u3PTgg79huLb8morjznKdppkVjV1Po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKTe5e/n1kqhYiM3rEBKq5zya702WW2Bt3CF1/jD9ahzLIjuE6Jev+vpP20EevsQlYibzYSQzGsrJ9FOaGw2xrvQe4uCfTxT5n/Fy0LYHzH9Qbay0fc4UPqAyTwc4xSWNy1tzR6VUEAY+meEjeSzKYGD0IWrP3GdGlowDpVUBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1035ed96c67e11efa216b1d71e6e1362-20241230
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e0ffdf3a-9162-4381-a886-c370092d2488,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.41,REQID:e0ffdf3a-9162-4381-a886-c370092d2488,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:6dc6a47,CLOUDID:81cff4b26c5fa3d384fe22ebb3cb6884,BulkI
	D:2412301517020DQSZIAC,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102,TC:nil,
	Content:0|50,EDM:5,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 1035ed96c67e11efa216b1d71e6e1362-20241230
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1713643918; Mon, 30 Dec 2024 15:17:01 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] bpf: Use refcount_t instead of atomic_t for mmap_count
Date: Mon, 30 Dec 2024 15:16:55 +0800
Message-Id: <6ecce439a6bc81adb85d5080908ea8959b792a50.1735542814.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use an API that resembles more the actual use of mmap_count.

Found by cocci:
kernel/bpf/arena.c:245:6-25: WARNING: atomic_dec_and_test variation before object free at line 249.

Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412292037.LXlYSHKl-lkp@intel.com/
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 kernel/bpf/arena.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 945a5680f6a5..8caf56a308d9 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -218,7 +218,7 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
 struct vma_list {
 	struct vm_area_struct *vma;
 	struct list_head head;
-	atomic_t mmap_count;
+	refcount_t mmap_count;
 };
 
 static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
@@ -228,7 +228,7 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 	vml = kmalloc(sizeof(*vml), GFP_KERNEL);
 	if (!vml)
 		return -ENOMEM;
-	atomic_set(&vml->mmap_count, 1);
+	refcount_set(&vml->mmap_count, 1);
 	vma->vm_private_data = vml;
 	vml->vma = vma;
 	list_add(&vml->head, &arena->vma_list);
@@ -239,7 +239,7 @@ static void arena_vm_open(struct vm_area_struct *vma)
 {
 	struct vma_list *vml = vma->vm_private_data;
 
-	atomic_inc(&vml->mmap_count);
+	refcount_inc(&vml->mmap_count);
 }
 
 static void arena_vm_close(struct vm_area_struct *vma)
@@ -248,7 +248,7 @@ static void arena_vm_close(struct vm_area_struct *vma)
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct vma_list *vml = vma->vm_private_data;
 
-	if (!atomic_dec_and_test(&vml->mmap_count))
+	if (!refcount_dec_and_test(&vml->mmap_count))
 		return;
 	guard(mutex)(&arena->lock);
 	/* update link list under lock */
-- 
2.25.1


