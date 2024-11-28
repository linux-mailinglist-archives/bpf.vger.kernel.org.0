Return-Path: <bpf+bounces-45797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C09DB193
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99AB8B2198F
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674C6F2F2;
	Thu, 28 Nov 2024 02:47:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B838B;
	Thu, 28 Nov 2024 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732762058; cv=none; b=p9Wdv2iIKMAEpuZrdEhUWYmX/0OkRnqs5Bdpf99LHtrH1x/L8SNoe1/hHYW20rBaUI777Nq4LJ7yxfEyXVyK7q1p949Vry1dwshsQ5lkm/pwm4WqvHoI2X21/b9i5OjklL5iPYnd3QE4VDGVZHa3bipyFRrj6JhAfpUY8N1pYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732762058; c=relaxed/simple;
	bh=xmaFxRdrgNfJcwyHHQw1qs56AzQMnTfM8YZhKwo2EY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPLnOsK2cHCcf7xbA8jdDBavZasLSZ9s/+yl0LVw/R0CJ6Ebz2V8faRcXjXsifWreYDNh/1SNsZwPfT1IL0c2bn6toDzWZQMgSRnbaul9jOOp2wyrajnRhjMdl6M/Fncw3i5D/HrGhmDgTZGuFU77HHn5XTfctJqZGxlsFvJUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96747d9bc6aa-9b6c0;
	Thu, 28 Nov 2024 10:47:25 +0800 (CST)
X-RM-TRANSID:2ee96747d9bc6aa-9b6c0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96747d9bb754-859af;
	Thu, 28 Nov 2024 10:47:25 +0800 (CST)
X-RM-TRANSID:2ee96747d9bb754-859af
From: liujing <liujing@cmss.chinamobile.com>
To: ast@kernel.org,
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] bpf: Optimize resource leakage problems
Date: Thu, 28 Nov 2024 10:47:17 +0800
Message-Id: <20241128024717.2719-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fopen executes successfully in the main function, it does
not close the open file stream before the end of the function.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 00e560a17baf..2445dfb4fc46 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -1388,11 +1388,17 @@ static int run_shell_loop(FILE *fin, FILE *fout)
 int main(int argc, char **argv)
 {
 	FILE *fin = NULL, *fout = NULL;
-
+	int result;
 	if (argc >= 2)
 		fin = fopen(argv[1], "r");
 	if (argc >= 3)
 		fout = fopen(argv[2], "w");
 
-	return run_shell_loop(fin ? : stdin, fout ? : stdout);
+	result = run_shell_loop(fin ? : stdin, fout ? : stdout);
+	if (fin)
+		fclose(fin);
+
+	if (fout)
+		fclose(fout);
+	return result;
 }
-- 
2.27.0




