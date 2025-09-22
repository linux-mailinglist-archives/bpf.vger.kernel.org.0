Return-Path: <bpf+bounces-69186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E2B8F7AC
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4876E2A0056
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5728522F;
	Mon, 22 Sep 2025 08:22:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB52F5461;
	Mon, 22 Sep 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529379; cv=none; b=SUJEqj0uAZIfpdMNQdqBLy46i1xbySEnpQ+2WvGmXqVRJDWOJFvj0EGCqWu+SM+mBnrUanyn/7GsFvGkkwEa+0fnJGJbCMrN4qHDabRgyzR/yMKxxJxg61TN+5GH2/ynw4Du6TaEynaFhVCi1SjGfBaSIfFBYsrV/z40LRMpM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529379; c=relaxed/simple;
	bh=7cjjMwT7IWZt7tYGMDfhx7KVTrrh/KvpkF8sru3bg1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBMvYV1kDmVOSWvCvpArxO/66143NsVk2V8LfwuU8KFryK1j+cmC0w+LfAtufx8MsY/lrUoXhXLCAO/K/CyNL8xOslS89Ek6eCjkW5BA69FrOPdPhKyf4hLGZIAwYBb3Ysk+Nfe8SqB/g/GwQ0tZp5i7X0cusac9pEFIRyI1c4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee368d10756f95-fa88d;
	Mon, 22 Sep 2025 16:22:46 +0800 (CST)
X-RM-TRANSID:2ee368d10756f95-fa88d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee668d10755b0a-9c337;
	Mon, 22 Sep 2025 16:22:46 +0800 (CST)
X-RM-TRANSID:2ee668d10755b0a-9c337
From: liujing <liujing@cmss.chinamobile.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH] bpf: The main function in the file tools/bpf/bpf_dbg.c does not call fclose() to close the opened files at the end, leading to issues such as memory leaks.
Date: Mon, 22 Sep 2025 16:22:41 +0800
Message-Id: <20250922082241.2204-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 tools/bpf/bpf_dbg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 00e560a17baf..ac834b6d78a8 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -1388,11 +1388,18 @@ static int run_shell_loop(FILE *fin, FILE *fout)
 int main(int argc, char **argv)
 {
 	FILE *fin = NULL, *fout = NULL;
+	int result;
 
 	if (argc >= 2)
 		fin = fopen(argv[1], "r");
 	if (argc >= 3)
 		fout = fopen(argv[2], "w");
 
-	return run_shell_loop(fin ? : stdin, fout ? : stdout);
+	result = run_shell_loop(fin ? : stdin, fout ? : stdout);
+
+	if (fin && fin != stdin)
+		fclose(fin);
+	if (fout && fout != stdout)
+		fclose(fout);
+	return result;
 }
-- 
2.27.0




