Return-Path: <bpf+bounces-61647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BDAE9600
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 08:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD716A2E0C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F35122A1D5;
	Thu, 26 Jun 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bmnVH+7L"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C1B217F40;
	Thu, 26 Jun 2025 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918371; cv=none; b=t3zkeeHIvc5QAR7XFSKLVpb3y2xHLsq7Tv44e+9MRTTNYJz/0kfVdGgpFSPZoLxfdQmRNHTsI4+Pn4PprqsOg6fHdytkT8BntBVHPUqzjybskqbJPN8fnDZHVZl1MMz299GwgfntGJDx1umvmdywTSkjIfXOCLoD9yzCkyDsB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918371; c=relaxed/simple;
	bh=LNDVWqKnANqaLDSLCVZPh2blBQFLB8dawnJf9/+U74Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDVpKxniQIm21ppgn9trptqN59U6uscSOI1k2zSG/oN10b2MqoxgvHKCgDKdD6Xr/2HFofHiJJdnjttRGdwfe93YE0eX+C1aC8JO0Y7FpnUJN1WcHC9mj8C9qG348jx9UWGibaGcAfcF7lhmuEJIGfcHw8wLuJdhuZhNM/SXWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bmnVH+7L; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=t7
	a61QuJVKBLezRRUhEoBCMadWsQdpjNWHXS0MLyvd0=; b=bmnVH+7LJTYBppwurX
	ntcjhVnrur1Guvh2ba1YSBXYF70alUCOEkRbKfKUBRIFR8rWXRxRguytzKABnWwz
	VDltr7N1V4uVsyWVvac3C0zTy9LDG5VJiKUpaTdxzukyrR95obIlkTHauU9/cOwL
	DO87Bj2G5rGMAqjj+a1GL4NkI=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXMM+05FxohS2TAg--.58321S2;
	Thu, 26 Jun 2025 14:12:06 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: ast@kernel.org,
	qmo@qmon.net
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	chenyuan <chenyuan@kylinos.cn>
Subject: [PATCH] bpftool: Add CET-aware symbol matching for x86_64 architectures
Date: Thu, 26 Jun 2025 14:11:58 +0800
Message-Id: <20250626061158.29702-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXMM+05FxohS2TAg--.58321S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF47uF1fAF4xAF4kKw48JFb_yoW8Wr1rp3
	93AFs5KFWUXr43Wan7ua1ayFW3WFs2v3yDZF9rG34Y9r45Xwn2vr17CF40yF1avr1kJw17
	Z34avrs0gryvvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piw0ekUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiURp2vWha87d2dgABs3

From: chenyuan <chenyuan@kylinos.cn>

Adjust symbol matching logic to account for Control-flow Enforcement
Technology (CET) on x86_64 systems. CET prefixes functions with a 4-byte
'endbr' instruction, shifting the actual entry point to symbol + 4.

Signed-off-by: chenyuan <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/link.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 189bf312c206..96c62d8aff8e 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -744,8 +744,21 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 
 	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (dd.sym_mapping[i].address != data[j].addr) {
+#if defined(__x86_64__) || defined(__amd64__)
+			/*
+			 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
+			 * function entry points have a 4-byte 'endbr' instruction prefix.
+			 * This causes the actual function address = symbol address + 4.
+			 * Here we check if this symbol matches the target address minus 4,
+			 * indicating we've found a CET-enabled function entry point.
+			 */
+			if (dd.sym_mapping[i].address == data[j].addr - 4)
+				goto found;
+#endif
 			continue;
+		}
+found:
 		printf("\n\t%016lx %-16llx %s",
 		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
 		if (dd.sym_mapping[i].module[0] != '\0')
-- 
2.25.1


