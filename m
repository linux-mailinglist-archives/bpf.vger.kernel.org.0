Return-Path: <bpf+bounces-77952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98048CF8997
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBC4301A1F8
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E2123BCFD;
	Tue,  6 Jan 2026 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDbPH3RF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69D12FF69
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707119; cv=none; b=qZrv+7VoO/IQ7jACeo9wZo3dOiY0HmwyGg7P4QN9MH6XjzjcHIyBB3bR0N4dYR/cUIxSm8/00mJelxVH2CD2H9Q+ZddE2P9qyZM8bMy/cNF2Pqf8X3ePaJwSWTPAdJON2Q2hDDNI7Duokoj6EfGvdjl/TvVDzZSvLB9loHqwbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707119; c=relaxed/simple;
	bh=s2TZMSh4wNlugwQUb/grB4j80JCmYqggHPpNTuBQUks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXsqOUdwS0D/uL7U2/0LwqatIEeq35prOHOCMkUAp6nZB8LS+/Y/D1/fxPg/4rY/XnDFHJXnl9sl3VB2W7AfyyyOkfYwNUJkKwpv8eFSUoiZio6vhduI4Xio1FKLxCRYjxcyaL0LWQg/OLHsI3WvXSGrom4xT0gRcl9CJ75VcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDbPH3RF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BanPd8d6y/CBsOyxFKDYt9T0QkVzk6reOpvMykHk2A=;
	b=UDbPH3RFw9Xejbp4Qzlv5FI1L3mVfjBGEAab0EATf2qkij8hNBF/yWDoPC5an88T++RoTY
	SiQIR748D/uv+XsWy/54Vl3hBZE1IldlpEfl3JfZrIq3gdHyIY5Po8NSrn7PAWUJVvl/Cg
	lhqe7gyjzrvQDbu+ReKfL5+6cr/HTIM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-2v_Wx45JO3eXZdm8xw726A-1; Tue,
 06 Jan 2026 08:45:14 -0500
X-MC-Unique: 2v_Wx45JO3eXZdm8xw726A-1
X-Mimecast-MFC-AGG-ID: 2v_Wx45JO3eXZdm8xw726A_1767707112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94D9195DE56;
	Tue,  6 Jan 2026 13:45:12 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E27D1800367;
	Tue,  6 Jan 2026 13:45:08 +0000 (UTC)
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
Subject: [PATCH v2 12/18] rtla: Fix NULL pointer dereference in actions_parse
Date: Tue,  6 Jan 2026 08:49:48 -0300
Message-ID: <20260106133655.249887-13-wander@redhat.com>
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

The actions_parse() function uses strtok() to tokenize the trigger
string, but does not check if the returned token is NULL before
passing it to strcmp(). If the trigger parameter is an empty string
or contains only delimiter characters, strtok() returns NULL, causing
strcmp() to dereference a NULL pointer and crash the program.

This issue can be triggered by malformed user input or edge cases in
trigger string parsing. Add a NULL check immediately after the strtok()
call to validate that a token was successfully extracted before using
it. If no token is found, the function now returns -1 to indicate a
parsing error.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 00bbc94dec1bd..b0d68b5de08db 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -153,6 +153,8 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 
 	strcpy(trigger_c, trigger);
 	token = strtok(trigger_c, ",");
+	if (!token)
+		return -1;
 
 	if (strcmp(token, "trace") == 0)
 		type = ACTION_TRACE_OUTPUT;
-- 
2.52.0


