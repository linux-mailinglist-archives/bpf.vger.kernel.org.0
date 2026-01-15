Return-Path: <bpf+bounces-79091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A1D26C56
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CABD3090B5D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2613C1FFA;
	Thu, 15 Jan 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KajLu1Q5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEF3D3CFC
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498088; cv=none; b=Dk/EwSkWywfNYRIB+VqjPPmZjNb51bT11tfiFVMDW4HLmRORdzuZMYA75Z07G/Fpe/y7jICc/XarkNcKYgQsM+NzESW8ss6uPay6/jAAFfbY9m45jIxo5bSCW/gLR5ivbUKEMB/b3MC9+VR8oyBTAL/I8sIM02gPMWHhiRg0YBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498088; c=relaxed/simple;
	bh=qXmnbKh15Yoqog4/pNkLVy8wSmDJ2XbnpsmpCqnrXQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4IekmiNd6ObOjF1y4OvY4uIpm2LM+KUwYXqRmGW9CuwhqDrgr5pHAKEeCoL16n1QIb6Shh93Lim2d+GHt/aebZBK2RSYut1ShaxTVrX9rrcFapVnMOw/AMUhzGKHQaLmVErD3MYA+M6zgVhnGoW18Dh3mAHLQ7YuGrHVUhTg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KajLu1Q5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kubPD8fTiVdrHvK6irQ9IsmC0Dnun29r0AdecZyP2Dg=;
	b=KajLu1Q5JN/CHv2AqTdPf35GviRy5EUTEOCecxmsga8AhVdVPFMDNYXm0KMr5sTAqQ0hwa
	1VTBBhrdXuw+23umeflIzmL+yENuLgHKphkRjeHRo8yvZcQqAN7L1EgBLI7rOwomjSZ4Dv
	VEySE/DeUAMtIS9y7nmoelj+TsgVwMs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-OlBDCZ9aPF2hDbneA927gg-1; Thu,
 15 Jan 2026 12:28:02 -0500
X-MC-Unique: OlBDCZ9aPF2hDbneA927gg-1
X-Mimecast-MFC-AGG-ID: OlBDCZ9aPF2hDbneA927gg_1768498081
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE2001955F34;
	Thu, 15 Jan 2026 17:28:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A40D18007D2;
	Thu, 15 Jan 2026 17:27:56 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 11/18] rtla: Use str_has_prefix() for prefix checks
Date: Thu, 15 Jan 2026 13:31:54 -0300
Message-ID: <20260115163650.118910-12-wander@redhat.com>
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

The code currently uses strncmp() combined with strlen() to check if a
string starts with a specific prefix. This pattern is verbose and prone
to errors if the length does not match the prefix string.

Replace this pattern with the str_has_prefix() helper function in both
trace.c and utils.c. This improves code readability and safety by
handling the prefix length calculation automatically.

In addition, remove the unused retval variable from
trace_event_save_hist() in trace.c to clean up the function and
silence potential compiler warnings.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 5 ++---
 tools/tracing/rtla/src/utils.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 2f529aaf8deef..ed7db5f4115ce 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -342,7 +342,7 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 static void trace_event_save_hist(struct trace_instance *instance,
 				  struct trace_events *tevent)
 {
-	int retval, index, out_fd;
+	int index, out_fd;
 	mode_t mode = 0644;
 	char path[MAX_PATH];
 	char *hist;
@@ -356,8 +356,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 		return;
 
 	/* is this a hist: trigger? */
-	retval = strncmp(tevent->trigger, "hist:", strlen("hist:"));
-	if (retval)
+	if (!str_has_prefix(tevent->trigger, "hist:"))
 		return;
 
 	snprintf(path, ARRAY_SIZE(path), "%s_%s_hist.txt", tevent->system, tevent->event);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index e98288e55db15..486d96e8290fb 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -318,8 +318,7 @@ static int procfs_is_workload_pid(const char *comm_prefix, struct dirent *proc_e
 		return 0;
 
 	buffer[MAX_PATH-1] = '\0';
-	retval = strncmp(comm_prefix, buffer, strlen(comm_prefix));
-	if (retval)
+	if (!str_has_prefix(buffer, comm_prefix))
 		return 0;
 
 	/* comm already have \n */
-- 
2.52.0


