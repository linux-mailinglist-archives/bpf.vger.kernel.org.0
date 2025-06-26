Return-Path: <bpf+bounces-61650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883EAE96A0
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5130E3B6B8F
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 07:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7623A578;
	Thu, 26 Jun 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BKwQjytn"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F78219E0;
	Thu, 26 Jun 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750921931; cv=none; b=LEg5wHY9ykN0U47Od9y54+DZvk9+opJeoFYA+3Ufcia4mZVajAypGgPNhdAd7tvp06Vc03UHzNsDbhzewsaYOcYOYgms6YUuCPV6ua7toHiX3NwJVU4aXCJMibv2ZPL7tV3udVY0qJJd4JJda5faAVlpbJRHHPq4opftBiu5oAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750921931; c=relaxed/simple;
	bh=Yt2V0eidQa+ghNGsVxeSBE2I7uB5gFCQN/DlJbc6/2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpvjlMiRXfXkUwNumxN8tUr1LSM5SdGI+q0iML/3pLbZQQG8ZsopdMF8cOeKb3EKDQYWxccdkb53XDyuEE5G4+edt3Nogi3n4M+ooZkohzeaRVO1L0GKF1pyNw3YRAr1J9GdYhkt3/WOBRnSoUGYtqHnG7Ve7y4yZo0Hpl53fD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BKwQjytn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oC
	uXxpJaFVMaup5vFMWHfy/qw2zbykFfszV4pCVvvVQ=; b=BKwQjytn4ny5Zt9MAN
	ZS/XuTKtFVckQIuO/OxangQRFzLsWjy2CDXs0FOkLgL0PkNsvXm88IOuW60g/4Fd
	yMgNT3aYUTGCONTSoSGVLyCNfekHpCntvB7QDeAkwB8HnC1POpcjYXEdViBJJ+4k
	SUUQtmUZXulxg7WAwyiKGqisA=
Received: from 163.com (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB33JKy8lxoEFQFAQ--.36212S2;
	Thu, 26 Jun 2025 15:11:47 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: ast@kernel.org,
	qmo@qmon.net
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH v2] bpftool: Add CET-aware symbol matching for x86_64 architectures
Date: Thu, 26 Jun 2025 15:11:40 +0800
Message-Id: <20250626071140.58000-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250626061158.29702-1-chenyuan_fl@163.com>
References: <20250626061158.29702-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB33JKy8lxoEFQFAQ--.36212S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF47uF1fAF4xWw4UZF1UZFb_yoW8Wr1rp3
	93Ars5KFWUXw43Wan7ua12yFW3WFs2vrWDZF9rG34Y9r45Xwn2vr17CF40yr1avr1kJw13
	Z34avrZ0gryvvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pioa0DUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNxx4vWhc8SsoVAAAs8

From: Yuan Chen <chenyuan@kylinos.cn>

Adjust symbol matching logic to account for Control-flow Enforcement
Technology (CET) on x86_64 systems. CET prefixes functions with a 4-byte
'endbr' instruction, shifting the actual entry point to symbol + 4.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
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


