Return-Path: <bpf+bounces-45235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C309D3283
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 04:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46106283EED
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 03:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F725156669;
	Wed, 20 Nov 2024 03:22:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE34E545;
	Wed, 20 Nov 2024 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072976; cv=none; b=A9z5eIGLD8zi4O8760qV/3n06meSkKz2Mp06BNJMFLCBH2xmmKoRuv/1gRy+9Hc4GGbu8nsHbQcgdbmqAvj9VIvL5KWq4HdP3Zc1r2ywjYCvH8x2C2CZvDU9mBmpVY2i0cAlWTmQ8huIkDYicUOznj+AgKdzw5Be1CIPX3ZskVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072976; c=relaxed/simple;
	bh=zieIBsncEidNacUls1QLyahkP9BMPYQJc1K2JSfcddg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BY1+C7cMlzyPYaqoPpDf2MYiIkLJa3cVJq39l2RP9mUaNwH/l47dUaqm0lKcLVg7IHAg895QzETLt6OLxt02YxETMdz4dO3xUZv4nPTASRyxvMNM8URD3SX9KfAhtQxzVPuYxwL7M2Bc3y4aVGxgyt/xFHRcnmt2+wAZ0GAltw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5673d560462d-50643;
	Wed, 20 Nov 2024 11:22:44 +0800 (CST)
X-RM-TRANSID:2ee5673d560462d-50643
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8673d5603e67-59b00;
	Wed, 20 Nov 2024 11:22:44 +0800 (CST)
X-RM-TRANSID:2ee8673d5603e67-59b00
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: martin.lau@linux.dev
Cc: song@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] samples/bpf: Remove unused variable
Date: Tue, 19 Nov 2024 19:22:41 -0800
Message-Id: <20241120032241.5657-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The variable is never referenced in the code, just remove it
that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/bpf/xdp2skb_meta_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/xdp2skb_meta_kern.c b/samples/bpf/xdp2skb_meta_kern.c
index af29a1bde..3c36c25d9 100644
--- a/samples/bpf/xdp2skb_meta_kern.c
+++ b/samples/bpf/xdp2skb_meta_kern.c
@@ -63,7 +63,6 @@ SEC("tc_mark")
 int _tc_mark(struct __sk_buff *ctx)
 {
 	void *data      = (void *)(unsigned long)ctx->data;
-	void *data_end  = (void *)(unsigned long)ctx->data_end;
 	void *data_meta = (void *)(unsigned long)ctx->data_meta;
 	struct meta_info *meta = data_meta;
 
-- 
2.17.1




