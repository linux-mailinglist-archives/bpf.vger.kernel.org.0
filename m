Return-Path: <bpf+bounces-69825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03688BA33F8
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CFB3AF93A
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E929DB99;
	Fri, 26 Sep 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aStKIwRZ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDC29BDB9;
	Fri, 26 Sep 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880387; cv=none; b=gk6v9wVAcHhFIDjRYutJ5icOhcYZ1qdo2l9ug9V4EisA3OpRrrVogjoFVtOoD5GAu8pc29zrI61uNiUtSrcQktVrpWBwXdkvmTexObo7WKeizG0z7qJvgQwtaj4a7G2fsHouF+r4kgeuEIx6cqdBX4/EpDHZRLejDGIV0RIITD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880387; c=relaxed/simple;
	bh=Pger4DEXLXhxKjmKNlZGBq+3iYijMA9lE/bmX5B/xEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bV4MDpczSoo9uRX7WZWPJwpZtqfviLoIwNKQiudyeH8AgxhJiRGQc6ny3RWBdBMvIbYbn/2FrBV7/JmVjnPHWHq8eEsMcXWjnLy3CWTNNLW84s3kfJF5UGtjfpm2M1zuRfD8X3y8TyuMjQusZJhOvUucTVyD6ETCSNMw6wyldQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aStKIwRZ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758880382; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=179Ko0XNcFhIANaYew2WJowx/WDx6ZHrGOCQgQz2FGE=;
	b=aStKIwRZKxdN7Iz4l+2DyZJYN6jM6jsz7R2KQPoyjCsjdIXzNlHdzgp51NCIELIGc7uXwXC04JOgP1akyggV7TXN1MDL7xLcj5f2t5oIHWF/EaNHr2/w+dwKgu+Nhj/lcefpICKiaOwoaIOpqmfLV05LEsiTz9xv7GE7pClBgsI=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Wornc4T_1758880363 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 17:53:01 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2 1/2] bpf: Remove duplicate crypto/sha2.h header
Date: Fri, 26 Sep 2025 17:52:39 +0800
Message-ID: <20250926095240.3397539-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./include/linux/bpf.h: crypto/sha2.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25501
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Combine two patches into a single patch series.

 include/linux/bpf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ea2ed6771cc6..7dcdd287f9a0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -32,7 +32,6 @@
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <asm/rqspinlock.h>
-#include <crypto/sha2.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
-- 
2.43.5


