Return-Path: <bpf+bounces-39707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05793976509
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FB9284058
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BD1922F8;
	Thu, 12 Sep 2024 08:58:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A43126C16;
	Thu, 12 Sep 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131521; cv=none; b=f0IExzNtKIAPweY05IVS/Cun0ImAQ7NokQk4ccmbxevwqIJGBJENwcA+o1YPOQPo2133J4d9qzQWL1ZOUmFazKXZPWb8oSA3t9UoR03jLI25tJ5AS/xQZqYFqOEySsnKNsHz2z6qh7OZ0dHsDmVKvYEOjXHrBmIAns3XEV29DMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131521; c=relaxed/simple;
	bh=K3jXaSgyOdvs3AxWYgzh1DWjXWKOssh0SQejlBuhSMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EejiokmwXEtBvvEltwVKA7wx+bx4CFo0MJcvRzxmYYq4bw8ejuljMKM9KQEom+zf+XygTpPi7ERll/qwF1xYyEWoMJg7z60C+u2mWdJhtmtD0QMOJp6hRT/+fG8q6lgHvpbaJ2+uCakN4yqzSj+bQwsgOvNt0Wzwqf8qQGaNjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466e2ad3aba5-f849b;
	Thu, 12 Sep 2024 16:58:35 +0800 (CST)
X-RM-TRANSID:2ee466e2ad3aba5-f849b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66e2ad3aaa9-113e2;
	Thu, 12 Sep 2024 16:58:34 +0800 (CST)
X-RM-TRANSID:2eea66e2ad3aaa9-113e2
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools/bpf: Add missing fclose.
Date: Thu, 12 Sep 2024 16:17:30 +0800
Message-Id: <20240912081730.22094-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Cppcheck find a error as below:
	bpf_dbg.c:1397:2: error: Resource leak: fin [resourceLeak]
Add fclose to rm this error.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/bpf/bpf_dbg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 00e560a17baf..5fb17fa0ace8 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -1394,5 +1394,11 @@ int main(int argc, char **argv)
 	if (argc >= 3)
 		fout = fopen(argv[2], "w");
 
-	return run_shell_loop(fin ? : stdin, fout ? : stdout);
+	run_shell_loop(fin ? : stdin, fout ? : stdout);
+
+	if (fin)
+		fclose(fin);
+	if (fout)
+		fclose(fout);
+	return 0;
 }
-- 
2.33.0




