Return-Path: <bpf+bounces-5586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9C75C063
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF041C21607
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730003FFF;
	Fri, 21 Jul 2023 07:49:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C262102
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:49:58 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B119AD;
	Fri, 21 Jul 2023 00:49:54 -0700 (PDT)
X-UUID: ff14eda7f0934741a23db9006c625495-20230721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:089c6898-c99c-4694-97ea-33c64382b269,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.28,REQID:089c6898-c99c-4694-97ea-33c64382b269,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:2e61e187-44fb-401c-8de7-6a5572f1f5d5,B
	ulkID:2307211549211PU76SGO,BulkQuantity:1,Recheck:0,SF:38|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ff14eda7f0934741a23db9006c625495-20230721
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
	(envelope-from <guodongtai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1614632383; Fri, 21 Jul 2023 15:49:40 +0800
From: George Guo <guodongtai@kylinos.cn>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	martin.lau@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH] btf: Remove unnecessary header file inclusions
Date: Fri, 21 Jul 2023 15:50:07 +0800
Message-Id: <20230721075007.4100863-1-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove unnecessary header file inclusions in btf.c

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/bpf/btf.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 817204d53372..e5ea729ba6b8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1,20 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018 Facebook */
 
-#include <uapi/linux/btf.h>
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/bpf_perf_event.h>
-#include <uapi/linux/types.h>
-#include <linux/seq_file.h>
-#include <linux/compiler.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
 #include <linux/anon_inodes.h>
-#include <linux/file.h>
-#include <linux/uaccess.h>
-#include <linux/kernel.h>
-#include <linux/idr.h>
 #include <linux/sort.h>
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
@@ -22,9 +9,6 @@
 #include <linux/bpf_lsm.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
-#include <linux/bsearch.h>
-#include <linux/kobject.h>
-#include <linux/sysfs.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
-- 
2.34.1


