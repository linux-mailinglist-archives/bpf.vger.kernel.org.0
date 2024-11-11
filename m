Return-Path: <bpf+bounces-44499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9919C3842
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 07:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CED1C216F3
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 06:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DBC1537CE;
	Mon, 11 Nov 2024 06:15:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16818E1F;
	Mon, 11 Nov 2024 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305724; cv=none; b=eo/mPQ6LrVRBvttnREwpHI+1HiJGLj0rVkGfwNWarwy5gXvdYDn7thYgHZoneY9i8YOxTMnQ5Xilv89XcTjZ4tm3doPLT/etL0C3nC6Oo5oVEDwRzHdoD5BeYC+d9JSB8mhRto1mMEjAa52T/29XDtUNtydS73plLn5d+F2EVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305724; c=relaxed/simple;
	bh=djhqMcvNei+15HbeeSkpFbxE/FBQ5+n7EBel/b2ljMo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Y3pDHKs4rhTiJ3O33jjEG1Y/h2FbZkRGj+CMUg4qhvvzaesXiTS/83DqNbJIa+ubLbye0VJ1IuJjATc6oQO0Xd2GYxlwjSWfWg7VQzU/Pb3h2A2wsN3aN5DgpusI4J82uW3nnBKJlMZqd6s977THwtq/Fwfwsfzyrhvs0gTTMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76731a0f44ff-0251b;
	Mon, 11 Nov 2024 14:15:17 +0800 (CST)
X-RM-TRANSID:2ee76731a0f44ff-0251b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26731a0f423d-1b859;
	Mon, 11 Nov 2024 14:15:17 +0800 (CST)
X-RM-TRANSID:2ee26731a0f423d-1b859
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: martin.lau@linux.dev
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] samples: bpf: Remove unused variable
Date: Sun, 10 Nov 2024 22:15:14 -0800
Message-Id: <20241111061514.3257-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The variable is never referenced in the code, just remove it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/bpf/xdp2skb_meta_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/xdp2skb_meta_kern.c b/samples/bpf/xdp2skb_meta_kern.c
index d5631014a176..af29a1bde4e4 100644
--- a/samples/bpf/xdp2skb_meta_kern.c
+++ b/samples/bpf/xdp2skb_meta_kern.c
@@ -32,7 +32,7 @@ SEC("xdp_mark")
 int _xdp_mark(struct xdp_md *ctx)
 {
 	struct meta_info *meta;
-	void *data, *data_end;
+	void *data;
 	int ret;
 
 	/* Reserve space in-front of data pointer for our meta info.
-- 
2.17.1




