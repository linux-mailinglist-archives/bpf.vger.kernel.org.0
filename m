Return-Path: <bpf+bounces-41523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87921997A3A
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6D8B22BC1
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22054339AB;
	Thu, 10 Oct 2024 01:41:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A24C63D5;
	Thu, 10 Oct 2024 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728524499; cv=none; b=WYOXmYaeLq7XP8SKHCsn2Y/dJgiITsmRwSV+IgjWDuIMB1fDfLhGJ7QyB4kYecRA3/FePnJO9krS4a2+EzPygi6HEcjbDN0Y9olFvBrjCv6WoO+A0gQDFLe2ZV4P3BAgLo+m0tiizAoGZ+kOTBvQ7+T5XF84KdOnF0ZswVuUYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728524499; c=relaxed/simple;
	bh=NXRdyC01lMr+Pd6PpT3+cXa24y33Bbc4Vhny53iMjMg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=l9igdRdtXQc5NPzpeD7/bFgR/lwQJI3TcW4aZ4n8LDILIGvKv7FVWrHP4cIYXeZA0Pq/wkM7L7Vz8ZTNautG+KWZvVV36A1Ns+qWxp3TomE+PsWAUZtY0cj2+aIMOo0Q2KzH7pScbGntJiYDSTmi6b5OhcW0wQ4ysoPphmL1d2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6670730ccb2c-bf3f3;
	Thu, 10 Oct 2024 09:41:32 +0800 (CST)
X-RM-TRANSID:2ee6670730ccb2c-bf3f3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9670730c973b-2432b;
	Thu, 10 Oct 2024 09:41:32 +0800 (CST)
X-RM-TRANSID:2ee9670730c973b-2432b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: eddyz87@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] samples/bpf: Fix a resource leak
Date: Wed,  9 Oct 2024 18:41:26 -0700
Message-Id: <20241010014126.2573-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The opened file should be closed in show_sockopts(), otherwise resource
leak will occur that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/bpf/test_cgrp2_sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
index a0811df888f4..8ca2a445ffa1 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -178,8 +178,10 @@ static int show_sockopts(int family)
 		return 1;
 	}
 
-	if (get_bind_to_device(sd, name, sizeof(name)) < 0)
+	if (get_bind_to_device(sd, name, sizeof(name)) < 0) {
+		close(sd);
 		return 1;
+	}
 
 	mark = get_somark(sd);
 	prio = get_priority(sd);
-- 
2.17.1




