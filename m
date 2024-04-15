Return-Path: <bpf+bounces-26760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F0F8A4A32
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E27D28153A
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B08364CD;
	Mon, 15 Apr 2024 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cJ/Ndf+n"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399D2E645;
	Mon, 15 Apr 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169213; cv=none; b=s9eFjOL3NckQuDKYAc+N0Y6f9DCMQmnqfMRRIdPJ5PjsEWDzOrDtQpsdvlekXvFaVs8zWkHfyaY60jKs8WKkN4x3CqtP3DwG/3q+VU5S1a/z+93gNAS1OIbUlueRj9BxJ5bIgqyqaeSxuq06RwKcwdlA8d2bw3Oot5WrNjyPnUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169213; c=relaxed/simple;
	bh=7gGqP1iO5IzTZtjFeXrYhSEdlKFpkiWlvtkSTMbtOec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F6zqkBfcSC5SpCl4EfLAhNEt18QyFoq2/bpDXh5c5d7AfBPaYQZ7Wxqd3r5Qx+QzCjXYHmtG3BpTvHVgRnAKb2F0xzFTfhzTIIOMSvTmZfKQ+hneRVimVbkXIWowGPX6jwiQbcNeKqnskCJD+bmbOcirevD/Ia/am43QuPxOqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cJ/Ndf+n; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713169204; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SuT+aLhWDuDTyxdPI1dSogMeJ/gqcAYwGuBkMfzVUP0=;
	b=cJ/Ndf+n0yCARJ6WXEa2RY50MPHXFOnr5kmlS1ybollst5XBDGNUo00fnHW4/pThoVIJp91dd90cqxppo2y2B5CAHGpnEqq6zyL7Q28ATEInVSnVBXj5bWw9qh0/fR7hApK9aD45md+8TiWGQxl4fBEA6RyrQPXklzr2dJpqg2I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W4Yrfrc_1713169196;
Received: from localhost.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0W4Yrfrc_1713169196)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 16:20:03 +0800
From: cp0613@linux.alibaba.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH] bpf/tests: Fix typos in comments
Date: Mon, 15 Apr 2024 16:19:28 +0800
Message-Id: <20240415081928.17440-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

Currently, there are two comments with same name 
"64-bit ATOMIC magnitudes", the second one should
be "32-bit ATOMIC magnitudes" based on the context.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 569e6d2dc55c..207ff87194db 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -13431,7 +13431,7 @@ static struct bpf_test tests[] = {
 		.stack_depth = 8,
 		.nr_testruns = NR_PATTERN_RUNS,
 	},
-	/* 64-bit atomic magnitudes */
+	/* 32-bit atomic magnitudes */
 	{
 		"ATOMIC_W_ADD: all operand magnitudes",
 		{ },
-- 
2.25.1


