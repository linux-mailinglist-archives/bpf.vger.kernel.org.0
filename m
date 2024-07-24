Return-Path: <bpf+bounces-35476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A251993ACC1
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 08:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA86B233B6
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 06:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B043535B7;
	Wed, 24 Jul 2024 06:43:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA285336B;
	Wed, 24 Jul 2024 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803380; cv=none; b=IiFAZDWwDCfWN+jC6sjkMIDNtK/PVtErk25qAYuk4K09ibknJcMikyp+5F/mIIhu5t2hnLhSZ6HeteYCFV67HxIq8VpqyMZjusEq1g9adGMCrCMybKGlOCfHcgjhC0Q7z6TAds7H67DhcuxynNraCKe/b8YjeuvQfJIwTdXcI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803380; c=relaxed/simple;
	bh=ss5L2oIuYC/tGnPcHOaBY3GVpk6byMurCxtaESRvMTU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=q4AYfg98BXOGIAV2KBMvqA+Y51AGXll3OdVUXQCNwHQBAmDwNW/6u/n5xpNzhlIbobhwB7xmXakrygrwnYH1o8/31RQTY+ylE5JujpXbjXLIDF5dzzHNRW1M4qBmjqpPb5Vu5LveN1/IDpZ67Pjd2T1oFcxpqJJEnTS6Hnqh2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366a0a26ce3a-66645;
	Wed, 24 Jul 2024 14:42:54 +0800 (CST)
X-RM-TRANSID:2ee366a0a26ce3a-66645
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566a0a26d27d-9ab64;
	Wed, 24 Jul 2024 14:42:54 +0800 (CST)
X-RM-TRANSID:2ee566a0a26d27d-9ab64
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: qmo@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools/bpf:Fix the wrong format specifier
Date: Tue, 23 Jul 2024 23:42:52 -0700
Message-Id: <20240724064252.5565-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The unsigned int should use "%u" instead of "%d".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/bpf/bpftool/xlated_dumper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 567f56dfd9f1..3efa639434be 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -349,7 +349,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
 
 		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
 
-		printf("% 4d: ", i);
+		printf("% 4u: ", i);
 		print_bpf_insn(&cbs, insn + i, true);
 
 		if (opcodes) {
@@ -415,7 +415,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 			}
 		}
 
-		printf("%d: ", insn_off);
+		printf("%u: ", insn_off);
 		print_bpf_insn(&cbs, cur, true);
 
 		if (opcodes) {
-- 
2.17.1




