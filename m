Return-Path: <bpf+bounces-45340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C259D4952
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 09:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F271F20FB6
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941871D07BA;
	Thu, 21 Nov 2024 08:55:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B031CB338;
	Thu, 21 Nov 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179326; cv=none; b=bzYEmH3gVW9G9XAJiToqUllKSPiSr4xboPobVzvHN2B9y3Fa4qTz8zC2wdxiiheAq9AwFXoHPoIVC6RQjOOT3zHExavgbSlpWlU614hEWaLMp1o/FDJdAwthsNU07UF+nTlWDO+8WopjCrYqlXrHyYgZ7VN8wqTZpYOaC5Ic+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179326; c=relaxed/simple;
	bh=idWFuNeGFu+29MpLoouGziP9KKOimeHGYWeDbZAYpaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+Mk+VRiWYAz2B/5dzOS5a21nURShEibnzNEcRi7/qSNRkSNA1OVNbrTnnglMuZsjK/jDN6B7UnPjKzZyysGza6mgQafnwMyBLxPRkeaIghKc1jtSeffy+R4rngRoSUW2rbuA5FGfM2/XYSR2TJllP0i5TNhFLegBPp3zhxFBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3673ef579959-2c181;
	Thu, 21 Nov 2024 16:55:21 +0800 (CST)
X-RM-TRANSID:2ee3673ef579959-2c181
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5673ef578cd4-ca220;
	Thu, 21 Nov 2024 16:55:21 +0800 (CST)
X-RM-TRANSID:2ee5673ef578cd4-ca220
From: liujing <liujing@cmss.chinamobile.com>
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
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] bpftool: Fix the wrong format specifier
Date: Thu, 21 Nov 2024 16:55:18 +0800
Message-Id: <20241121085518.3738-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The type of lines is unsigned int, so the correct format specifier should be
%u instead of %d.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 08d0ac543c67..030556ce4d61 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -423,7 +423,7 @@ static int do_batch(int argc, char **argv)
 		err = -1;
 	} else {
 		if (!json_output)
-			printf("processed %d commands\n", lines);
+			printf("processed %u commands\n", lines);
 	}
 err_close:
 	if (fp != stdin)
-- 
2.27.0




