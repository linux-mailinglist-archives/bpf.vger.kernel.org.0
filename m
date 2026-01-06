Return-Path: <bpf+bounces-77943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA626CF88FA
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBC6A305FE2B
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97373333421;
	Tue,  6 Jan 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlSw7/tO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C633291F
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706797; cv=none; b=qQHht47snF3yrlHXD2/Xf0/gsuJN0avBlH2mybO37AX7F6TGgeAwLWrKpShr41WnhI03+XBmyMttoIS93g3f3OlS5caLPWbMliZfu/cgkszJXeKMlCezaTgUntMuHO51BuTDmOujjabBuXxpZ2iySy6hrMY0iW1WvHtq8foefWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706797; c=relaxed/simple;
	bh=2eL6u1tYXRr0f4T07e3bqQR8vmyHHp/n5Y06Uc7Bdt0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExvLHu2u9ZBEHpRDnsHXBpKwF++SpF4ePnr0nNjz6K6NO5mmH2jVKlR2RK9gORE7afCWFffDgHVBxOPsb1rzixz5Ip5KXOyfwhdJ+uHzD2IHDWupsIUe45yglY306G0I6nxBQqZIk7TCm0Adk8F1sN5/vlYkOt8eDc2ovsqN1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlSw7/tO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9x6woanR4M28vlHIWpobUJ+jS/qyut7AGYHXp5l5JGc=;
	b=YlSw7/tOucRlbiAlkCyK36IfUS5V93MNdps++/xls0Zkd51hy58AFYjSU89GjTn68eMa+W
	v8B6R02Kj5VXXp6D0EUWaJDn4fPDtr4hUKZ1Lsx+J4aqJ8WJXvThTCc7PzbND+58nnvSWS
	zF50b1JyOJoYtgOrOFxiokRnaUGib+w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307--aQgs27MOXSidvNkQQP4JQ-1; Tue,
 06 Jan 2026 08:39:46 -0500
X-MC-Unique: -aQgs27MOXSidvNkQQP4JQ-1
X-Mimecast-MFC-AGG-ID: -aQgs27MOXSidvNkQQP4JQ_1767706784
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF8611800654;
	Tue,  6 Jan 2026 13:39:43 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA0251800367;
	Tue,  6 Jan 2026 13:39:39 +0000 (UTC)
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
Subject: [PATCH v2 03/18] rtla: Introduce for_each_action() helper
Date: Tue,  6 Jan 2026 08:49:39 -0300
Message-ID: <20260106133655.249887-4-wander@redhat.com>
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
index 090d514fe4126..a4d0dc47e6aa1 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -32,7 +32,9 @@ void
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
@@ -217,7 +219,7 @@ actions_perform(struct actions *self)
 	int pid, retval;
 	const struct action *action;
 
-	for (action = self->list; action < self->list + self->len; action++) {
+	for_each_action(self, action) {
 		switch (action->type) {
 		case ACTION_TRACE_OUTPUT:
 			retval = save_trace_to_file(self->trace_output_inst, action->trace_output);
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index fb366d6509b8b..034048682fefb 100644
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
 void actions_init(struct actions *self);
 void actions_destroy(struct actions *self);
 void actions_add_trace_output(struct actions *self, const char *trace_output);
-- 
2.52.0


