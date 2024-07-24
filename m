Return-Path: <bpf+bounces-35485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40893AE22
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 10:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CB11F2398A
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC9114D2A6;
	Wed, 24 Jul 2024 08:55:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD813A418;
	Wed, 24 Jul 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811312; cv=none; b=S36r5AzdNR1lAhcprmm8D/2erbb9LpTYLmufLINMaF1hM5DCpgYJMjuaSR9dCoSo/CorUeG6+GU5YnHRoTnHEiQbbRBha4nFtL0lpbm8yUFSX9bwln3B31kYoHr1lx+5+ijQRz3acbxk69Czi7ffJe1TJ1os+/zepZfjnE5rDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811312; c=relaxed/simple;
	bh=qgWs+ZnotCAjXk9AqBfixZvTkMPsNdd22e9KmTjfysI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ThFHdK+FhXG2cNsprMA8faxSXrhyCGgJzCq4VKgg/V94Uqxv6FWEygLieRSBSEJZ6jw+j80eHjdhAHgECQ9qZt91G2Pu2PcmYVTNUMIIQ7oP9VHSZpKGjocffPCkK1iMh/f97LKJIQ1/yUzy1BXya96clllsbVlV4sadj8DZomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366a0c0da778-67f83;
	Wed, 24 Jul 2024 16:52:43 +0800 (CST)
X-RM-TRANSID:2ee366a0c0da778-67f83
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee966a0c0d9e7c-a2b42;
	Wed, 24 Jul 2024 16:52:43 +0800 (CST)
X-RM-TRANSID:2ee966a0c0d9e7c-a2b42
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: qmo@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] tools/bpf:Fix the wrong format specifier
Date: Wed, 24 Jul 2024 01:52:42 -0700
Message-Id: <20240724085242.9967-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The format specifier of "unsigned int" in printf() should be "%u", not
"%d".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes
v2:modify commit info

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




