Return-Path: <bpf+bounces-77942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3448CF8950
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F92230A3F1A
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D6332907;
	Tue,  6 Jan 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2VqFiSK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C832ED30
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706752; cv=none; b=PfZwL9bgqewzXsW/opwS+5Hbl6kOXjphsZffLzNk3ibAQ6Zzha1TW32eU83fsY5pZuqKHFyqNz9ZDxUB0gkm+4O4gYmMlXFblOkRF7H/fOIVTq3IdrQsKAYQ62DfmAb9OwV15L2+rxh7xalXVnFTDtkkODvhOt417QVoQB0YyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706752; c=relaxed/simple;
	bh=I6Y2Bnj5DjlTKswbTwkLRHVOQ3wPXG/AMGsGn2yZi04=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS7K0pxyk2TD7KCfpTcZYYsxvSqxOFMLFmGLPIZWy92UI5pxxJrvZCV0HfaCpH9jf1YH//SZcS3LQznRpY9mUd8LYzT9hdXARktlbkRLVFtTIm52JqXxbVvOCpi0KkcDtRt0crFAc4g/1qXZk8ldXfjCuYJPMdX1TRaneRMDVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2VqFiSK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uaMzECtULTxucImjVPwH8LTz8bTXnv1pm1HYLWyzkw=;
	b=S2VqFiSKclSbdwdWGt6N6fkzMVX8ypGklAQgKlQ/fF1U4rEFYx10kOcebfIWNXjDLxENHO
	1Gb4nmiqMelXTxBYS5XbEDe1WxgCzBLPumx3/1dUQmJJ8Yszdi3reiUz9ZWjgf/7vLdi5g
	BFvBGVgBaKMc1PSJ4Qx8uDiTj0VjDQI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-tYE0V7fbMImPiH-ewnz63g-1; Tue,
 06 Jan 2026 08:39:08 -0500
X-MC-Unique: tYE0V7fbMImPiH-ewnz63g-1
X-Mimecast-MFC-AGG-ID: tYE0V7fbMImPiH-ewnz63g_1767706747
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E1F41800625;
	Tue,  6 Jan 2026 13:39:07 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23BD2180035A;
	Tue,  6 Jan 2026 13:39:02 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 02/18] rtla: Use strdup() to simplify code
Date: Tue,  6 Jan 2026 08:49:38 -0300
Message-ID: <20260106133655.249887-3-wander@redhat.com>
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

The actions_add_trace_output() and actions_add_shell() functions were
using calloc() followed by strcpy() to allocate and copy a string.
This can be simplified by using strdup(), which allocates memory and
copies the string in a single step.

Replace the calloc() and strcpy() calls with strdup(), making the
code more concise and readable.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index ff7811e175930..090d514fe4126 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -69,8 +69,7 @@ actions_add_trace_output(struct actions *self, const char *trace_output)
 
 	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
-	action->trace_output = calloc_fatal(strlen(trace_output) + 1, sizeof(char));
-	strcpy(action->trace_output, trace_output);
+	action->trace_output = strdup_fatal(trace_output);
 }
 
 /*
@@ -97,8 +96,7 @@ actions_add_shell(struct actions *self, const char *command)
 
 	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
-	action->command = calloc_fatal(strlen(command) + 1, sizeof(char));
-	strcpy(action->command, command);
+	action->command = strdup_fatal(command);
 }
 
 /*
-- 
2.52.0


