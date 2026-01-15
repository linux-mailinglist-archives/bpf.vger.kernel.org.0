Return-Path: <bpf+bounces-79093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF5D26953
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6474D305F0B9
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B93C1983;
	Thu, 15 Jan 2026 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIyHqGnd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C33BC4D8
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498127; cv=none; b=IncwsTLccqzr5H9c20Ok0L5sxFdd24DIYe4c5KV9q9pqoccNOaBBkirSdJ9m3pBXCLXP2TWfiuoeE9RR7pLQ6hRYz+7gZCZabTN/IpYSZFhhTqs2dYlPfPnRko/QSMAovJ5lCw+B21hik36f0z/uN0MOSQGhV7fosLKMEIOxgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498127; c=relaxed/simple;
	bh=M6q+1YKSMR2qj9nmEYe1yRlHW29HrcG/JoUGyEha3OM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iK+z8ycEcM/Ami0AeRMQHYN/od4RM3SdwESae8+iI9777zjhbTVHSqNKv9cxRmp2M6ad2Juyd/hJ8M7INnSNrnsCwdzjHezZnx2tNIGnzUGDhlubXjdb8JAA8CgYWH2mwOL2dzFXgb1VF7r9z3CYDur1ISGkoY4mzZgnPXuue/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIyHqGnd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCDIg29v0GPRUT83B438eXBl9CQINW2Seue9qN0fCYg=;
	b=GIyHqGndr8TIVlxztKBuHrjJ4yPDnHB9i0dZQ89o0WpC245otyo7tvRVHOC0iTdWW1h9Yy
	wZFXhRAnKVwAmiYdP/CKGnFkRKsGfjeav9L14AfovD3iQOJVFQILDOABOtxCcY2kbPMSUK
	IMzH1rL3BTv6i5bzblajE/BBoP3mqs0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-7JG8i3brMzebvukj_r-L8A-1; Thu,
 15 Jan 2026 12:28:41 -0500
X-MC-Unique: 7JG8i3brMzebvukj_r-L8A-1
X-Mimecast-MFC-AGG-ID: 7JG8i3brMzebvukj_r-L8A_1768498120
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A66B195609D;
	Thu, 15 Jan 2026 17:28:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CFFD1800285;
	Thu, 15 Jan 2026 17:28:35 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 13/18] rtla: Use str_has_prefix() for option prefix check
Date: Thu, 15 Jan 2026 13:31:56 -0300
Message-ID: <20260115163650.118910-14-wander@redhat.com>
In-Reply-To: <20260115163650.118910-1-wander@redhat.com>
References: <20260115163650.118910-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The argument parsing code in timerlat_main() and osnoise_main() uses
strncmp() with a length of 1 to check if the first argument starts
with a dash, indicating an option flag was passed.

Replace this pattern with str_has_prefix() for consistency with the
rest of the codebase. While character comparison would be slightly
more efficient, using str_has_prefix() provides better readability
and maintains a uniform coding style throughout the rtla tool.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c  | 2 +-
 tools/tracing/rtla/src/timerlat.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 4890a9a9d6466..5b342d945c5f6 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1210,7 +1210,7 @@ int osnoise_main(int argc, char *argv[])
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
 		osnoise_usage(0);
-	} else if (strncmp(argv[1], "-", 1) == 0) {
+	} else if (str_has_prefix(argv[1], "-")) {
 		/* the user skipped the tool, call the default one */
 		run_tool(&osnoise_top_ops, argc, argv);
 		exit(0);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 8f8811f7a13bd..84577daadd668 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -272,7 +272,7 @@ int timerlat_main(int argc, char *argv[])
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
 		timerlat_usage(0);
-	} else if (strncmp(argv[1], "-", 1) == 0) {
+	} else if (str_has_prefix(argv[1], "-")) {
 		/* the user skipped the tool, call the default one */
 		run_tool(&timerlat_top_ops, argc, argv);
 		exit(0);
-- 
2.52.0


