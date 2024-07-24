Return-Path: <bpf+bounces-35492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E49B393AF86
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D2A1C233F9
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F3B156677;
	Wed, 24 Jul 2024 10:00:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56396155A4F;
	Wed, 24 Jul 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815231; cv=none; b=hxh/Iq8Xrd6FUU5dmB/nFCpTH7k3mrOWemQjnyUYDpdH1eJ0w8epAGia5PXeVnAs3ZbORuybYRkCYshnSkUqsSOJD4exb79hc4ytDAR2F5nu8AdoNvjxxKGSdMJYvhVvuCjosH6XmR0NJPeSYEZnVSmF0rwIqbkhYbyYIgeueEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815231; c=relaxed/simple;
	bh=NIGa9iQpUqam5IWuTrnW2Gks9anUK/UsvSSlyhNda04=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n79pyfIsdYJYYWQkLLuKfQYLSfCx0u4YmAx2AT378km8XjV7K67OYa+zFCbmsUqDo4FGGGd7qSiWHRACPjvzJPzefvZyop35eb0ICEaywxzWTr/1SXUKtCg3Og/wsNLYpGqO0EKMcOixFA9/vkCSGkzGQtZXWdQuBfwbnN37O3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666a0d0b707f-68939;
	Wed, 24 Jul 2024 18:00:24 +0800 (CST)
X-RM-TRANSID:2ee666a0d0b707f-68939
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366a0d0b70c5-a1be0;
	Wed, 24 Jul 2024 18:00:24 +0800 (CST)
X-RM-TRANSID:2ee366a0d0b70c5-a1be0
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
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v3] tools/bpf:Fix the wrong format specifier
Date: Wed, 24 Jul 2024 03:00:22 -0700
Message-Id: <20240724100022.10850-1-zhujun2@cmss.chinamobile.com>
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
Changes:
v2:modify commit info
v3:fix compile warninf

 tools/bpf/bpftool/xlated_dumper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 567f56dfd9f1..d9c198e0a875 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -316,7 +316,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
 	unsigned int nr_skip = 0;
 	bool double_insn = false;
 	char func_sig[1024];
-	unsigned int i;
+	int i;
 
 	record = dd->func_info;
 	for (i = 0; i < len / sizeof(*insn); i++) {
@@ -415,7 +415,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 			}
 		}
 
-		printf("%d: ", insn_off);
+		printf("%u: ", insn_off);
 		print_bpf_insn(&cbs, cur, true);
 
 		if (opcodes) {
-- 
2.17.1




