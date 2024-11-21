Return-Path: <bpf+bounces-45339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7F59D492F
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 09:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C66282D2B
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527E1CF7CE;
	Thu, 21 Nov 2024 08:47:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC01CD209;
	Thu, 21 Nov 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178866; cv=none; b=t2HbuCjDjxhGSJOXodx8z+DS73yzV0plzf0ZAioUk44zGqyXtIMCXYpJuywWQdyLrhcu8TTGmT9yR/gJcsxgY+NxNfhD94xEt9upjKdO4Vc8uQpsNdlWhD+nJ4wbT/ASxe8mkd23xLwXWf0V8k8qXePzJdYsAnU3gsJRk2dlg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178866; c=relaxed/simple;
	bh=ftzAq4vflAz24cttcvqVsPMPX2K4t6awAwHzg91p1O4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OMu1qqVWDweMEpXHkQK4WSiDCwUH3vbexlwDDMdeK9e9W961dLoXXTRmJ01xos3YVy/KXPtK9Qav4M2sIMxDgloWUAZ23N8d2i0FFccx2yP1lu95WOcgv7/AG4s6TsFRg3RJrbf9dRtlBl8Ae2rzgJSA4RDTJtAhwyFOxRbhRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3673ef3a67f3-2c01b;
	Thu, 21 Nov 2024 16:47:34 +0800 (CST)
X-RM-TRANSID:2ee3673ef3a67f3-2c01b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8673ef3a4dd8-c4d90;
	Thu, 21 Nov 2024 16:47:34 +0800 (CST)
X-RM-TRANSID:2ee8673ef3a4dd8-c4d90
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
	liujing <liujing_yewu@cmss.chinamobile.com>,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] bpftool: Fix wrong format output
Date: Thu, 21 Nov 2024 16:47:31 +0800
Message-Id: <20241121084731.3570-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liujing <liujing_yewu@cmss.chinamobile.com>

%d in format string requires 'int' but the argument type
of pf is 'unsigned int'.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 5cd503b763d7..5bc442d93456 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -699,7 +699,7 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
 	if (pfname)
 		printf("\n\t%s", pfname);
 	else
-		printf("\n\tpf: %d", pf);
+		printf("\n\tpf: %u", pf);
 
 	if (hookname)
 		printf(" %s", hookname);
-- 
2.27.0




