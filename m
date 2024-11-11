Return-Path: <bpf+bounces-44494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4749C366B
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 03:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016C2B21643
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 02:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDD433B3;
	Mon, 11 Nov 2024 02:11:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5B3C3C;
	Mon, 11 Nov 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731291118; cv=none; b=oMZVKOwmpyD/xZY3vwwwfGSK8RsLqoRvunRh7R4N1uKmpuEH+XHVcaalIgTtrwo8RMD4s0e2ZUj5BuXXGkHEZ9sCpG3EGTpXFC+Y5ar8tTeap4P4jr4zn/N9IzV41rwjxjilfQH5IPFzjLncmDS8EijWRoGkingBE+MooCRNV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731291118; c=relaxed/simple;
	bh=/GqSN44up1BEAN00a9vcx/k8X0/LYqowKV5wg1GRuuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0x0VQYUft8r6JKYg05R2Tl/PT4tutY2wcTssMffFQ8LEavWvYvqcsZiu9boDfcaDmz9ae9KWPwyLOfug6P4P7sipqG5G1rWO0lblb7djujOZT5vYhwogDK5+2aY/rxRPymktybo/8pOV8zx2fAAbdOXug/awuZwVy/6q7sgfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3673167e0761-cef81;
	Mon, 11 Nov 2024 10:11:44 +0800 (CST)
X-RM-TRANSID:2ee3673167e0761-cef81
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea673167dfc2b-0d6e0;
	Mon, 11 Nov 2024 10:11:44 +0800 (CST)
X-RM-TRANSID:2eea673167dfc2b-0d6e0
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] tools/bpf_jit_disasm: Fix the wrong format specifier
Date: Mon, 11 Nov 2024 10:10:04 +0800
Message-Id: <20241111021004.272293-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a static checker warning that the %d in format string is
mismatch with the corresponding argument type, which could result in
incorrect data print. This patch fixes it.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/bpf/bpf_jit_disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpf_jit_disasm.c b/tools/bpf/bpf_jit_disasm.c
index a90a5d110..1baee9e2a 100644
--- a/tools/bpf/bpf_jit_disasm.c
+++ b/tools/bpf/bpf_jit_disasm.c
@@ -210,7 +210,7 @@ static uint8_t *get_last_jit_image(char *haystack, size_t hlen,
 		return NULL;
 	}
 	if (proglen > 1000000) {
-		printf("proglen of %d too big, stopping\n", proglen);
+		printf("proglen of %u too big, stopping\n", proglen);
 		return NULL;
 	}
 
-- 
2.27.0




