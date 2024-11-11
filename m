Return-Path: <bpf+bounces-44495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E99C36B0
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 03:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2161F225C0
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557CE136E3F;
	Mon, 11 Nov 2024 02:48:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBD14AA9;
	Mon, 11 Nov 2024 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293329; cv=none; b=qlq6u9gcdUt4EO0imcgdEh3Saun+XJhoNMOBmk/lTMKreSdUs1VQYJBi/vitQybJYnRfRJ5aXUz9UWot7MObrknG26mVsvz1as80XviBAXmPdXOzhWjTu+Du3mJygm4QaaD/wNvq9PMzdNcNv9W6GsSGPQWwyt6mzSvgTKaXVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293329; c=relaxed/simple;
	bh=QmGuJK1ujSvO+VjZsAUtUvH2s1ZYjQBcu8wRj70Ovls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFvhQ1EnVrOO9ZY0mhmcipaQ6xPhBbZ/svH2RnRQnsKPjiAS3F/JFaXl03W+2qm4orYBxDR4JahD9HLhxTUjPT7XJPhywzziuAzX5HNkMLgraik/y0mUUj6sofMN3y/4P09vue6Zeu0CcYuLD0ow0oYqW3LsrH6ZfUe2Xd1Ejdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee467317083fe9-d18ee;
	Mon, 11 Nov 2024 10:48:35 +0800 (CST)
X-RM-TRANSID:2ee467317083fe9-d18ee
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee167317082e2a-0ff1f;
	Mon, 11 Nov 2024 10:48:35 +0800 (CST)
X-RM-TRANSID:2ee167317082e2a-0ff1f
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: qmo@kernel.org,
	ast@kernel.org,
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
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] bpftool: Fix incorrect format specifier for var
Date: Mon, 11 Nov 2024 10:48:14 +0800
Message-Id: <20241111024814.272940-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cases where the SIGNED condition is met, the variable var is still
used as an unsigned long long. Therefore, the %llu format specifier
should be used to avoid incorrect data print. This patch fixes it.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/bpf/bpftool/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 7d2af1ff3..ff58ff85e 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -283,7 +283,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 				jsonw_end_object(w);
 			} else {
 				if (btf_kflag(t))
-					printf("\n\t'%s' val=%lldLL", name,
+					printf("\n\t'%s' val=%lluLL", name,
 					       (unsigned long long)val);
 				else
 					printf("\n\t'%s' val=%lluULL", name,
-- 
2.27.0




