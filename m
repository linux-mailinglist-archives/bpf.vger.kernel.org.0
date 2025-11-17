Return-Path: <bpf+bounces-74789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6DC65DB3
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D41D84EBAC0
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9032F342C8F;
	Mon, 17 Nov 2025 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZD5/qfAX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498C33F374
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405837; cv=none; b=ClTBgBqLB9vIX/2C92N4G7/Bz3njuu95lu+QbGtvYLYmaEIBKR1IjvZXpLFrBtkpDnjTsYF1tsT9N238EF3aCunHOeg4Qjxc27SgZXge34Igt29SQSDf7AQ5r2IMAkY+Hz2Y8VKOr5zY3E5RH987S/7o+aGNAFM5G48ZkGNoK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405837; c=relaxed/simple;
	bh=9LHwH85GVx+dILDMq0gSzAtnCgezKegZ1fVjvhUvgA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOfyVjx0j+HeQUMnrbyCLeLJL3B14e9Q0rPtRhoJxJiA5LF60LYyqvEIr01YYUrd1XIIifdTqXZ9V0v8VlZjDWVx778WarMZp7sU+hmP/FzewZFbmqh2gAGBMQeDeb7PI0e4A8LNBmQvF8yuGHDR9JSNXYkmeRwMPeWMm5QVVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZD5/qfAX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUJiSXgP7OYZRNQjJLoq/fTS0neWpO/zNbumzcyTMMc=;
	b=ZD5/qfAXJOVngGLzp+SlHFi6zlj2P6AiIyxj3gkXfleIwa+8k5oJNWkJMbjyOTqMBH9zXQ
	WrJEUsXAzPDwfdyvutONKU4lO3LVF3Spe4cmAFf39uG0FrcqGbvKnblcMqCj+m2a6PTVd/
	tDa7/QpwfMX0u1/+e5NlEtPf/sx2JAQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-U9qG0fP1OjWxBOf_WPUeJA-1; Mon,
 17 Nov 2025 13:57:11 -0500
X-MC-Unique: U9qG0fP1OjWxBOf_WPUeJA-1
X-Mimecast-MFC-AGG-ID: U9qG0fP1OjWxBOf_WPUeJA_1763405830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 034FB18AB414;
	Mon, 17 Nov 2025 18:57:10 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF9FB180049F;
	Mon, 17 Nov 2025 18:57:05 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 12/13] rtla: Remove unused headers
Date: Mon, 17 Nov 2025 15:41:19 -0300
Message-ID: <20251117184409.42831-13-wander@redhat.com>
In-Reply-To: <20251117184409.42831-1-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove unused includes for <errno.h> and <signal.h> to clean up the
code and reduce unnecessary dependencies.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 1 -
 tools/tracing/rtla/src/timerlat.c     | 1 -
 tools/tracing/rtla/src/timerlat_top.c | 1 -
 tools/tracing/rtla/src/trace.c        | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index dffb6d0a98d7d..44614f56493f2 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -9,7 +9,6 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
-#include <errno.h>
 #include <stdio.h>
 #include <time.h>
 
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 50c7eb00fd6b7..9b77dbcbd1375 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <sched.h>
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d831a9e1818f4..7f2491e72e495 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -11,7 +11,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <time.h>
-#include <errno.h>
 #include <sched.h>
 #include <pthread.h>
 
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 658a6e94edfba..ab2bf6d04f2ee 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -2,7 +2,6 @@
 #define _GNU_SOURCE
 #include <sys/sendfile.h>
 #include <tracefs.h>
-#include <signal.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
-- 
2.51.1


