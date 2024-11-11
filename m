Return-Path: <bpf+bounces-44500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E89C3852
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 07:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7861F21F25
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99124155352;
	Mon, 11 Nov 2024 06:23:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C5A933;
	Mon, 11 Nov 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306201; cv=none; b=tvAdqnquk4D+vXXeU2AbNMRtnnAwUf75sfOH1CvMQQ/XD++33vstIGTKCdF43IjnLIP0BO0dFXV3uwWP1Z/XWsDsVC8h4wugqPAG/D9NDQeDg84L8dDvEpF+ip7N6LlElpxn9iuRQNkwZUahfwCvA79al7DvhlsTgObcz1psAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306201; c=relaxed/simple;
	bh=iP7Frx9UHTyfKys12nXpS+cOQ5XpYUkhERAgTZoqnEo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aKPlOAI8vtZUrGDy8naOkYcGOsuCou+x8/VAYsNLQtNVlfnjzRoFvC4MSboN4KHx5YKS8dyNL+p3Bj2rEX5KlJyesIoE2z6Q+LDG6z3w4naoh4YWZfPX5SY2KoF54I5DgRCd5S5302As4mvUr2RGm0ufOqxJ6k0kGlPjyjGOfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76731a2d3663-0267f;
	Mon, 11 Nov 2024 14:23:15 +0800 (CST)
X-RM-TRANSID:2ee76731a2d3663-0267f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96731a2d1f6c-170ed;
	Mon, 11 Nov 2024 14:23:15 +0800 (CST)
X-RM-TRANSID:2ee96731a2d1f6c-170ed
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: martin.lau@linux.dev
Cc: eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] samples/bpf: Remove unused variables
Date: Sun, 10 Nov 2024 22:23:12 -0800
Message-Id: <20241111062312.3541-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

These variables are never referenced in the code, just remove them

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/bpf/tc_l2_redirect_kern.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/samples/bpf/tc_l2_redirect_kern.c b/samples/bpf/tc_l2_redirect_kern.c
index fd2fa0004330..729657d77802 100644
--- a/samples/bpf/tc_l2_redirect_kern.c
+++ b/samples/bpf/tc_l2_redirect_kern.c
@@ -64,8 +64,6 @@ int _l2_to_iptun_ingress_forward(struct __sk_buff *skb)
 	void *data_end = (void *)(long)skb->data_end;
 	int key = 0, *ifindex;
 
-	int ret;
-
 	if (data + sizeof(*eth) > data_end)
 		return TC_ACT_OK;
 
@@ -115,8 +113,6 @@ int _l2_to_iptun_ingress_redirect(struct __sk_buff *skb)
 	void *data_end = (void *)(long)skb->data_end;
 	int key = 0, *ifindex;
 
-	int ret;
-
 	if (data + sizeof(*eth) > data_end)
 		return TC_ACT_OK;
 
-- 
2.17.1




