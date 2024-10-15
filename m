Return-Path: <bpf+bounces-42010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EE99E531
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D5C283286
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89551E282B;
	Tue, 15 Oct 2024 11:09:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100FD1E571A;
	Tue, 15 Oct 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990593; cv=none; b=NoU981N1pWfRSPWic1jAKFjUtxpwJ8Z+F+ytROqFdUEtmEhZnGdcm/E8aAafgxiZ8m355wyknvH/R1SlaeraAyw82hzcYxgw0N9HpGiDD/TCwgthRX8sOxNg34Hbqy20DHoFPmDgRAs7BKyUfBtY/pF4zIFrWm+kCi5C/DyOs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990593; c=relaxed/simple;
	bh=+G7yFXFTJdYUvkwG9ZrXJHw6lTDClttw60acmxAQajg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UIVix7tdPHfoU8KNupj/DGL4LBLhTPpDdakbcDjbxjhVX8R0aC63kPqDyhsVgZYYZ2Jr9GfR8a/fSqe2VwygSNSxZ7em7tlrJHLAlxPKDhlXFvHp2rffUg1xqcUR0VczT8K04dWvybK2rAlRO6uh4E+Mpf7N1Tyzvvqpwb5uNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1670e4d78aab-f43b9;
	Tue, 15 Oct 2024 19:09:46 +0800 (CST)
X-RM-TRANSID:2ee1670e4d78aab-f43b9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1670e4d78962-01745;
	Tue, 15 Oct 2024 19:09:45 +0800 (CST)
X-RM-TRANSID:2ee1670e4d78962-01745
From: Liu Jing <liujing@cmss.chinamobile.com>
To: qmo@kernel.org
Cc: ast@kernel.org,
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
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] bpftool: optimize if statement code
Date: Tue, 15 Oct 2024 19:09:44 +0800
Message-Id: <20241015110944.6975-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since both conditions are used to check whether len is valid, we can combine the two conditions into a single if statement
Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 tools/bpf/bpftool/feature.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 4dbc4fcdf473..0121e0fd6949 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -158,10 +158,9 @@ static int get_vendor_id(int ifindex)
 
 	len = read(fd, buf, sizeof(buf));
 	close(fd);
-	if (len < 0)
-		return -1;
-	if (len >= (ssize_t)sizeof(buf))
+	if ((len < 0) || (len >= (ssize_t)sizeof(buf)))
 		return -1;
+
 	buf[len] = '\0';
 
 	return strtol(buf, NULL, 0);
-- 
2.27.0




