Return-Path: <bpf+bounces-35495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315E93B023
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 13:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAF52828F2
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9F156C6C;
	Wed, 24 Jul 2024 11:11:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0CD6BFD2;
	Wed, 24 Jul 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819490; cv=none; b=mABiNMk3jbjsPvcWBCC3X4uuUtcuJRc/sQkIAyghTvv/cQjosj44OOfEs5TryCo1BHm8KASsil40a1OUDCivtPpp8THFNY28PWkvlkJ6FnEZwqADQ301kfrU5eiCCufxLUJ/KXwMZq4H7hN0a0OE3x4KwWDCOqNLPb2u8LmJzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819490; c=relaxed/simple;
	bh=Pfuo2baySnR6689GK89/olXtrcD1jmb/qCSjgqJukuo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fdHqBlmLLACom7rlXTFT4R0h+Z6mne/OucBpZNjpE3S10u2PjceCebl36xlqcWwhbgLSn+duPh+x4Ceo5lSmfdzcK/OlHYIUtnHraueCeT0wdE5srn2G613Dje3v4kV3bL1pC1C+FeeoCIaeRqjKckXv/UpNg1R8uR8VH/r/PYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666a0e154849-69103;
	Wed, 24 Jul 2024 19:11:20 +0800 (CST)
X-RM-TRANSID:2ee666a0e154849-69103
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166a0e156885-a332b;
	Wed, 24 Jul 2024 19:11:20 +0800 (CST)
X-RM-TRANSID:2ee166a0e156885-a332b
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
Subject: [PATCH v4] tools/bpf:Fix the wrong format specifier
Date: Wed, 24 Jul 2024 04:11:20 -0700
Message-Id: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
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
v2:
modify commit info
v3:
fix compile warning
v4:
Thanks! But unsigned seems relevant here, and it doesn't make much sense
to change the type of the int just because we don't have the right
specifier in the printf(), does it? Sorry, I should have been more
explicit: the warning on v1 and v2 can be addressed by simply removing
the "space flag" from the format string, in other words:

 tools/bpf/bpftool/xlated_dumper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 567f56dfd9f1..d0094345fb2b 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -349,7 +349,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
 
 		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
 
-		printf("% 4d: ", i);
+		printf("%4u: ", i);
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




