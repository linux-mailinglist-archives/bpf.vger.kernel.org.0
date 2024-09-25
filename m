Return-Path: <bpf+bounces-40288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C75E9856C9
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD3D1F24F47
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA6156C73;
	Wed, 25 Sep 2024 10:00:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9353C099
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258413; cv=none; b=XGu2TJaApd9oqq2qCEvs5ZdHkMHO4bwQw2z2Q+n9gESr25NHUUU/psf6lwH0QTctP3VOv0sbICRtj06wgr6rc0R5pWtFXZyYCX/wjkdM4aTgGXeOYpzrllM0+iR8cNHt1//t41lihDkBfDonkhsUKIPey3XLnuiN6O+juKcfar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258413; c=relaxed/simple;
	bh=UyhP677+b30cwl46foSulXhGFTwVIVONc7JFE7FKye0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rkZyP9ixaD3FLM+ex083CmHaG9eYmISqgT/+1NiV3cyBp/HucoaOw5NfImaYI1MeU2hUSlAKrPakIRr3ZM5DO7TnA+GB7lvv197yeWgy5NrUFvd/udbKK6QC0mQkYWY/endsLwNHFa7IXDgJTQdQ8Y/pD2WeFVKaedTDXMuWgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866f3df27174-c91aa;
	Wed, 25 Sep 2024 18:00:07 +0800 (CST)
X-RM-TRANSID:2ee866f3df27174-c91aa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366f3df269b7-cb9bd;
	Wed, 25 Sep 2024 18:00:07 +0800 (CST)
X-RM-TRANSID:2ee366f3df269b7-cb9bd
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: eddyz87@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	zhujun2@cmss.chinamobile.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Subject: [PATCH] tools/bpf:remove unused variable
Date: Wed, 25 Sep 2024 03:00:05 -0700
Message-Id: <20240925100005.3989-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This variable is never referenced in the code, just remove it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/bpf/runqslower/runqslower.bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bpf/runqslower/runqslower.bpf.c b/tools/bpf/runqslower/runqslower.bpf.c
index 9a5c1f008fe6..fced54a3adf6 100644
--- a/tools/bpf/runqslower/runqslower.bpf.c
+++ b/tools/bpf/runqslower/runqslower.bpf.c
@@ -70,7 +70,6 @@ int handle__sched_switch(u64 *ctx)
 	struct task_struct *next = (struct task_struct *)ctx[2];
 	struct runq_event event = {};
 	u64 *tsp, delta_us;
-	long state;
 	u32 pid;
 
 	/* ivcsw: treat like an enqueue event and store timestamp */
-- 
2.17.1




