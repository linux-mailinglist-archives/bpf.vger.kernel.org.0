Return-Path: <bpf+bounces-74790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2AAC65DA4
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 711EB35ABE8
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F153446C0;
	Mon, 17 Nov 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxIpPPVW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A234404E
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405855; cv=none; b=VklGP9KXePANGE2YZR8r8UKD7KGcEwdQgcqAP7id3XMlqen4+M3HQWw77iDDeaijH32hc2NqNG+d6lXKDnI1iEIMSJeNEjKR+PUfXvthJ9KMQEs6Xo8hxEKJb0cDU3efWVbYUvuTO0SgD8T9YmCD3lZJF3djk3hQ7pCG8zngBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405855; c=relaxed/simple;
	bh=bD12Zma+HqAn33iDOUsFKDSv5z71KSEUkEEij0/v2hg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiELlRPBkHePYHtQ3/mZdgZlPVQpLfz5GWgMDAtn1R83XdAV6MgETyyYADfQK3WpC0mqfHsIcWaPbyUq4qhDUt6MNUPyRcga6/LhF9JvxnL+7l2fIfhUliWUS9K+wBN9REUii+ypwFERqxWPG5aHEyfgKvR6/4YNZkOA4pvg+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxIpPPVW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJgzWUqlEf8G/5190vKWYurdG9FvRAIrgrn7gi1E2RQ=;
	b=OxIpPPVWcUaznDdiiqx5xVOuOYDCdv9H/PpRVimY5NkWMkQRHljK6xnUKwbL/valTzYpaO
	8Jyy0LQRPjtpCX5dS6rw3yg72QeGJGqhleY3rgVPi+AKCNNx+STIP8iX1k6PVDRRYcHtfo
	malnx4erBbdi3eaxdS1cDeg3fWHdEQo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-k3ENyNDvN7KLae-DJ5KLZg-1; Mon,
 17 Nov 2025 13:57:27 -0500
X-MC-Unique: k3ENyNDvN7KLae-DJ5KLZg-1
X-Mimecast-MFC-AGG-ID: k3ENyNDvN7KLae-DJ5KLZg_1763405846
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E867E1956069;
	Mon, 17 Nov 2025 18:57:25 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1255180049F;
	Mon, 17 Nov 2025 18:57:21 +0000 (UTC)
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
Subject: [rtla 13/13] rtla: Fix inconsistent state in actions_add_* functions
Date: Mon, 17 Nov 2025 15:41:20 -0300
Message-ID: <20251117184409.42831-14-wander@redhat.com>
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

The actions_add_trace_output() and actions_add_shell() functions
leave the action list in an inconsistent state when strdup() fails.
The actions_new() function increments self->len before returning a
pointer to the new action slot, but if the subsequent strdup()
allocation fails, the function returns an error without decrementing
self->len back.

This leaves an action object in an invalid state within the list.
When actions_destroy() or other functions iterate over the list
using for_each_action(), they will access this invalid entry with
uninitialized fields, potentially leading to undefined behavior.

Fix this by decrementing self->len when strdup() fails, effectively
returning the allocated slot back to the pool and maintaining list
consistency even when memory allocation fails.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 2d153d5efdea2..4aaaedadcc42a 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -76,11 +76,13 @@ actions_add_trace_output(struct actions *self, const char *trace_output)
 	if (!action)
 		return -1;
 
-	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
 	action->trace_output = strdup(trace_output);
-	if (!action->trace_output)
+	if (!action->trace_output) {
+		self->len--; // return the action object to the pool
 		return -1;
+	}
+	self->present[ACTION_TRACE_OUTPUT] = true;
 
 	return 0;
 }
@@ -115,11 +117,13 @@ actions_add_shell(struct actions *self, const char *command)
 	if (!action)
 		return -1;
 
-	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
 	action->command = strdup(command);
-	if (!action->command)
+	if (!action->command) {
+		self->len--;
 		return -1;
+	}
+	self->present[ACTION_SHELL] = true;
 
 	return 0;
 }
-- 
2.51.1


