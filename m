Return-Path: <bpf+bounces-74780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E67BC65D40
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62B1F4EAA11
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C381533DED9;
	Mon, 17 Nov 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvQdrGZ5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABCB32C932
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405690; cv=none; b=QF0eITBd0scBSmfAQCqGxHZB46cXeqPAbjsoRLfmLA8g2svN62cabZqhONB/I2jjGmmoBz5WKtf0rAMYa7iD95Ja6FbH16MK+D3AMCzj4a25sMAkziFQZZp4DpYRHF8XhPs0+Cncri9l+OY5PZBOijZSHVGFNh0TuwFthuatwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405690; c=relaxed/simple;
	bh=KZNGCErladIv7DUjLnlytiY04Zips/SMhtaQ8kxPwp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=higk+LXx3cepu9T5vjsPNMd4qSo2TtxD0kalhwtBX+uxL1/mv7jvtN/2OVFw0MOqReTwWmjcKCob/FzomD8yB7wOLJdJICieNSZgjcFH4NAykD5th9jEenFYKm+40AvassFR2WUCl/03omBT5zBRmE65pDHuOAHhrqEj4lLIMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BvQdrGZ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/91aqlMG90jMVYPWMYCXSLUYrI0o0P8LIA3DXEBJJo=;
	b=BvQdrGZ5bfsvjqohbGSlg09BOerAFS2Ms5lCc2jKbGhyn3q3kveUP50YX1+VJl5NvPLOF3
	jP/OozH6zJ6njCa+KkvvmMBd4Hsf1t6inyb26UzDyLfB6d9EM3LqsIEtFObejI9GyD1Y+g
	+QUq9SDnNF+PYg/1bowWYarw3vGPPbw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-rw7XQ3AoO8GbsHSx7CCgmg-1; Mon,
 17 Nov 2025 13:54:45 -0500
X-MC-Unique: rw7XQ3AoO8GbsHSx7CCgmg-1
X-Mimecast-MFC-AGG-ID: rw7XQ3AoO8GbsHSx7CCgmg_1763405684
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 464D1195608E;
	Mon, 17 Nov 2025 18:54:44 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4035180049F;
	Mon, 17 Nov 2025 18:54:39 +0000 (UTC)
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
Subject: [rtla 03/13] rtla: Introduce for_each_action() helper
Date: Mon, 17 Nov 2025 15:41:10 -0300
Message-ID: <20251117184409.42831-4-wander@redhat.com>
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

The for loop to iterate over the list of actions is used in
more than one place. To avoid code duplication and improve
readability, introduce a for_each_action() helper macro.

Replace the open-coded for loops with the new helper.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 6 ++++--
 tools/tracing/rtla/src/actions.h | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 696dd1ed98d9a..efa17290926da 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -35,7 +35,9 @@ void
 actions_destroy(struct actions *self)
 {
 	/* Free any action-specific data */
-	for (struct action *action = self->list; action < self->list + self->len; action++) {
+	struct action *action;
+
+	for_each_action(self, action) {
 		if (action->type == ACTION_SHELL)
 			free(action->command);
 		if (action->type == ACTION_TRACE_OUTPUT)
@@ -241,7 +243,7 @@ actions_perform(struct actions *self)
 	int pid, retval;
 	const struct action *action;
 
-	for (action = self->list; action < self->list + self->len; action++) {
+	for_each_action(self, action) {
 		switch (action->type) {
 		case ACTION_TRACE_OUTPUT:
 			retval = save_trace_to_file(self->trace_output_inst, action->trace_output);
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index 439bcc58ac93a..9b9df57a0cb34 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -42,6 +42,11 @@ struct actions {
 	struct tracefs_instance *trace_output_inst;
 };
 
+#define for_each_action(actions, action)			\
+	for ((action) = (actions)->list;			\
+	     (action) < (actions)->list + (actions)->len;	\
+	     (action)++)
+
 int actions_init(struct actions *self);
 void actions_destroy(struct actions *self);
 int actions_add_trace_output(struct actions *self, const char *trace_output);
-- 
2.51.1


