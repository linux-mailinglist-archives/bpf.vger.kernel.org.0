Return-Path: <bpf+bounces-74779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E3C65D28
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5C49429806
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0133D6C5;
	Mon, 17 Nov 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3dC8cZz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B58301483
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405675; cv=none; b=oRcGOsTE04h6EcZqjKKPUNDWyta4dyCI1kpWD24745NdkMoWBL4ZPfBgwVWXPIPytNgcAbyVEF/OSWtFP/RsBBU0g6RAWsyNCNm8ZPOgKVMcpONrzNNENWE5m4QPTTVa3XZjXak/hOTlngNUH0ydLs7HOJH4O3S/Ck+SnaecVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405675; c=relaxed/simple;
	bh=YPixvNi32P13IxIqq7e56t+ezsA5HQVE4Nde4+v41lY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkoZS0igLfZ7irUHiZfI/ooF9ZtoZ5HbMISg7yqSqqXs6e2loPO/d0dvVNWbFD9dkKp2pQs66PDwCv21Z/nsIDGhMF3pYQSxCxKtr4ddIqZLpUUaFYSU/ER/yQzNyDbK1XQQPWDZ0CRRFhmu88/0kNDrhBVp1l2G5OTGaIwM3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3dC8cZz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYplZIckiwqMSukeuleTlKYUvfjWjNZOEwl16HghBAQ=;
	b=R3dC8cZzn5LvedCD1TBM2QUIjhfjFM/Pe01IQ/JYRAZvEG5PvU0VU4nsVirDHnk+11klXr
	lNFrHIW1WFXmzJRrZrzoJddKxafGEkmAQbhmvNinZ/T3944vxesb0ZKpi5mKw6p2m1wX6z
	GwZqsun7+E8zlqSNm7n7DX1Zii8kpLs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-_X1R_qNuM26uU3_Td8F7cQ-1; Mon,
 17 Nov 2025 13:54:29 -0500
X-MC-Unique: _X1R_qNuM26uU3_Td8F7cQ-1
X-Mimecast-MFC-AGG-ID: _X1R_qNuM26uU3_Td8F7cQ_1763405668
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 041E31956094;
	Mon, 17 Nov 2025 18:54:28 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B031180049F;
	Mon, 17 Nov 2025 18:54:23 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 02/13] rtla: Use strdup() to simplify code
Date: Mon, 17 Nov 2025 15:41:09 -0300
Message-ID: <20251117184409.42831-3-wander@redhat.com>
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
index 01648a1425c10..696dd1ed98d9a 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -78,10 +78,9 @@ actions_add_trace_output(struct actions *self, const char *trace_output)
 
 	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
-	action->trace_output = calloc(strlen(trace_output) + 1, sizeof(char));
+	action->trace_output = strdup(trace_output);
 	if (!action->trace_output)
 		return -1;
-	strcpy(action->trace_output, trace_output);
 
 	return 0;
 }
@@ -118,10 +117,9 @@ actions_add_shell(struct actions *self, const char *command)
 
 	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
-	action->command = calloc(strlen(command) + 1, sizeof(char));
+	action->command = strdup(command);
 	if (!action->command)
 		return -1;
-	strcpy(action->command, command);
 
 	return 0;
 }
-- 
2.51.1


