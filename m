Return-Path: <bpf+bounces-78973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F11B3D22089
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 02:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E17DD3019375
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 01:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0CA19E968;
	Thu, 15 Jan 2026 01:32:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28A8F4A
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768440722; cv=none; b=nKrV2+DsXXxzPMaoX0lgADBi01iXht1yVYjRtFMUncov2bqt18sfWfhbTNSkJQ+kpd5JW0kYPkFXwpFmMuKUVZbhZPA3xwc9FO0my+9osTqb6o50GKO8JMFQxrCKqWQnK9/UCAUR3cFWv7jOk7lCNIlr7z/0x4lkClKem0G78LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768440722; c=relaxed/simple;
	bh=AlGkuX55E+iwWNCiSmQbkU502zKTm6EkPkUORp4GlAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaO6rnK4sz0TMWnDZmpNaOPrF97XhMtI8G0SkOFyslu8Tuy4Mr/srnoPdZUnsthd4d7DJ0JNSFCijF6O/174Kx91dg0OJYF0+IMU2ee9pR7XR1YLydQbY8f6pgQlrW7MONuu8pCP8pxMbRb/+8fhtdNAps4qt8qbKLt6IM4JsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id g8WWveso7KjfogCDLvc0Yy; Thu, 15 Jan 2026 01:31:55 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id gCDKvoTtmPL32gCDLvzRZS; Thu, 15 Jan 2026 01:31:55 +0000
X-Authority-Analysis: v=2.4 cv=MqhS63ae c=1 sm=1 tr=0 ts=6968438b
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=uc9KWs4yn0V/JYYSH7YHpg==:17
 a=vUbySO9Y5rIA:10 a=z6gsHLkEAAAA:8 a=odGvurlAbDJ6Lck-HAUA:9
 a=bcJbkyMg_6Rm9PQ4FUss:22 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.46.62] (port=34982 helo=timdesk..)
	by host2044.hostmonster.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <tim.bird@sony.com>)
	id 1vgCDI-000000033kt-3tTM;
	Wed, 14 Jan 2026 18:31:53 -0700
From: Tim Bird <tim.bird@sony.com>
To: kuba@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org
Cc: linux-spdx@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Bird <tim.bird@sony.com>
Subject: [PATCH] kernel: bpf: Add SPDX license identifiers to a few files
Date: Wed, 14 Jan 2026 18:31:29 -0700
Message-ID: <20260115013129.598705-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.46.62
X-Source-L: No
X-Exim-ID: 1vgCDI-000000033kt-3tTM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk..) [66.118.46.62]:34982
X-Source-Auth: tim@bird.org
X-Email-Count: 3
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfBN7bYpJShXAq4sT1cX8tjtcUUr0Nwp+0qVbp8hu4UXcqz+HUxyepzB6qlIfoGxoN5sHVNcvP8WQoo9Tv/4NQ0iMKVTBx7cxEx307BLrOz385J0pKQui
 Bj3awii7tG1WOGBoK0E4UbulvOO+rwz2mLGx4BogSXYUSaEJsJ2TA3FLQEM+Wzhu57BReJYUjblkeqh6EXLJYHsp4daEh2XneR8=

Add GPL-2.0 SPDX-License-Identifier lines to some files,
and remove a reference to COPYING, and boilerplate warranty
text, from offload.c.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 kernel/bpf/offload.c | 12 +-----------
 kernel/bpf/ringbuf.c |  1 +
 kernel/bpf/token.c   |  1 +
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 42ae8d595c2c..227f9b5f388b 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017-2018 Netronome Systems, Inc.
- *
- * This software is licensed under the GNU General License Version 2,
- * June 1991 as shown in the file COPYING in the top-level directory of this
- * source tree.
- *
- * THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS"
- * WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING,
- * BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
- * FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE
- * OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME
- * THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
  */
 
 #include <linux/bpf.h>
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index f6a075ffac63..35ae64ade36b 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/err.h>
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index feecd8f4dbf9..7e4aa1e44b50 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <linux/vmalloc.h>
 #include <linux/file.h>
-- 
2.43.0


