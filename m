Return-Path: <bpf+bounces-77951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F70CF89D3
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1957230268CE
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B13446DE;
	Tue,  6 Jan 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InodwHkW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3D3446B8
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707085; cv=none; b=W6h5E0hJNd43fqZ0GsJAK8CYnmIoZSvgpArYnl/8Ji5bupbzq1tcycnTw79yH8unDm2kfx4tdiaIZzVm1gncnLHKYdm0+HdhZ+HvkC873+pA87tU9RLKoYf7jt3xm1wazdZPmrkFv250gILofa+ycxQ6LpXQ5EkyWfBrSXTJfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707085; c=relaxed/simple;
	bh=WXnCGYc+gwvQe0yvnlFsYFUDt9lQeVOnfPCOO+Gr3hY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkj8rl0kLleTGH5u2W0kQPFrEUlaV2klOz5eWX6grtzf5YyjkLO7nCMrJsqrI89SxjN3VMjbcEMAX90DFPE9bHxcNj5J9J3hvykMhHqIMCGVkf/iozINygQB2gLOCbpEzpoCwYhstIvB6gRYL4vGVQaCr1HhSaNdq29EzoqHm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InodwHkW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlj+8dE+8UhnMtv9WnHlh2eX/Ry+9eXzJV0pLxebN3M=;
	b=InodwHkWLLu0vmJNiWuMPTX/7IgatSzWvVD6uwpI4NWrCzF+GZVOUrjPwrOJWwLRf3HzZ3
	nFY3NWWIhBlroWoKu029g4Y6SMBfbaQAdxTMpZkF1uX5V/iHjn9dsz4L4frGO0yZOHd1cN
	WbiiJjs97oudEGwNzgJ7dK8eJ99lcJs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-GOLBlbopOFyqibhnNvNWdQ-1; Tue,
 06 Jan 2026 08:44:39 -0500
X-MC-Unique: GOLBlbopOFyqibhnNvNWdQ-1
X-Mimecast-MFC-AGG-ID: GOLBlbopOFyqibhnNvNWdQ_1767707078
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 624B818011FB;
	Tue,  6 Jan 2026 13:44:37 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB4701800663;
	Tue,  6 Jan 2026 13:44:32 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 11/18] rtla: Remove unused headers
Date: Tue,  6 Jan 2026 08:49:47 -0300
Message-ID: <20260106133655.249887-12-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
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
index af7d8621dd9d7..c8e681f732315 100644
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
index ac2ec89d3b6ba..b3d63506c4a62 100644
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
index f7e85dc918ef3..79ee66743bf1d 100644
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
index 0a81a2e4667ef..092fcab77dc4c 100644
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
2.52.0


