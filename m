Return-Path: <bpf+bounces-45368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE659D4CA5
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 13:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC651F2272E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D613A1D2715;
	Thu, 21 Nov 2024 12:17:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ADC1369AA;
	Thu, 21 Nov 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191447; cv=none; b=cTBVSGe6IodOyi7CEfWFpsFE1zs8lgjycKGfq9cztYNlvIa3wPLLA3l2aWTI4AcKNEH9OGp0WH/MtBquHpa7HQgWsm8bP8OgPM7eW3L94ToHCjbP73JN67jFP1LelefarCgCAI4uITeyxOBG+eL0yfWpAwYxxEgulp3HGVXfMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191447; c=relaxed/simple;
	bh=+oRS4ZYMrcGbdaOnmvCzJQ96i8DmAEY38eqO/d+/zx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bn/NhAtIy0Zb0dYF5jH1W8ODANHGGHS9HlyyJh0lslTQ0xO+BUtHxHEg3pK8XzQzvtpJOrnyXBO0UcKWEIGzrdt5MdC5XNSIExOE1uQ2k2ic73v9cqsKNTvxra93uG/ol245AkyJGMjiHDWQY+PYLCfWgNfRiIFzbWYaXN+JJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4673f24cbc81-3058b;
	Thu, 21 Nov 2024 20:17:15 +0800 (CST)
X-RM-TRANSID:2ee4673f24cbc81-3058b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5673f24c9270-d6802;
	Thu, 21 Nov 2024 20:17:14 +0800 (CST)
X-RM-TRANSID:2ee5673f24c9270-d6802
From: liujing <liujing@cmss.chinamobile.com>
To: qmo@kernel.org,
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
Subject: [PATCH] bpftool: Fix the wrong format specifier
Date: Thu, 21 Nov 2024 20:17:12 +0800
Message-Id: <20241121121712.5633-1-liujing@cmss.chinamobile.com>
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

V1 -> V2: Fixed two other wrong type outputs about lines

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 08d0ac543c67..84f723b275e3 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -370,7 +370,7 @@ static int do_batch(int argc, char **argv)
 		while ((cp = strstr(buf, "\\\n")) != NULL) {
 			if (!fgets(contline, sizeof(contline), fp) ||
 			    strlen(contline) == 0) {
-				p_err("missing continuation line on command %d",
+				p_err("missing continuation line on command %u",
 				      lines);
 				err = -1;
 				goto err_close;
@@ -381,7 +381,7 @@ static int do_batch(int argc, char **argv)
 				*cp = '\0';
 
 			if (strlen(buf) + strlen(contline) + 1 > sizeof(buf)) {
-				p_err("command %d is too long", lines);
+				p_err("command %u is too long", lines);
 				err = -1;
 				goto err_close;
 			}
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




