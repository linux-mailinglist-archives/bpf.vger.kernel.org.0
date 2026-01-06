Return-Path: <bpf+bounces-77955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65CCF8A4E
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17CFB30C0497
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D9D313E1A;
	Tue,  6 Jan 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTWIQoiy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4628643C
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707231; cv=none; b=WjEQaZDtOnxXIiZxQhP/98+5E8uUcHDSJV5uNsHmsBMIqkamoC6qy3oO7fmLd6MD2OoMwGg3AQbvwXCBg+H1aYnV7uSXJ7IsgSXcYspYPyGczTecHT3kM/FDB5EFpSCQOxh254Tj0aw8qfPqF5QvfCzqAIyZtGYZ5E8ozAUtfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707231; c=relaxed/simple;
	bh=kLhmG8r8/G/ZBzcMsD21dGTit7z/QexGf+BuN2OdGGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7rbXLXecxwBnaGxl49Jn43Rski+PYmc1IypHwAUFlRNFpKKtrzqJSNtXVNLOsA4nLwF9Q3Yehx/8Rsn8SZGFhkQbaxpSVAJK7Ci51nDYgvhWawmMnLGArXH87J3wNpn3MC3M2M1MLLyKdS46Dg6sLNEKPFGN/9Ad4uuyu9/gtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTWIQoiy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2MacZa0tkiAD+rR0g1h1MHJtgQHxTFEHFa+WubSNqk=;
	b=iTWIQoiyAoSb3kk9SuO/BYIKymogCmt40Vtgv4CYZ926nDTqW8j3FuCsqB2ITx5gSfnz6n
	4vV64pm2SPnQzX0f8Nwl3yj8Lxkj0pu+bLo642TpAOLfim2dg2DR3ra0GjPvjmo0TlbaJ9
	vHocGHGqWsbQ5z3VoEYymTpPgPgdL2c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-U3IkJEZZNYiniFGAwG_s1A-1; Tue,
 06 Jan 2026 08:47:06 -0500
X-MC-Unique: U3IkJEZZNYiniFGAwG_s1A-1
X-Mimecast-MFC-AGG-ID: U3IkJEZZNYiniFGAwG_s1A_1767707225
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 117521956068;
	Tue,  6 Jan 2026 13:47:05 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A7DD1800367;
	Tue,  6 Jan 2026 13:47:01 +0000 (UTC)
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
Subject: [PATCH v2 15/18] rtla: Make stop_tracing variable volatile
Date: Tue,  6 Jan 2026 08:49:51 -0300
Message-ID: <20260106133655.249887-16-wander@redhat.com>
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

The stop_tracing global variable is accessed from both the signal
handler context and the main program flow without synchronization.
This creates a potential race condition where compiler optimizations
could cache the variable value in registers, preventing the signal
handler's updates from being visible to other parts of the program.

Add the volatile qualifier to stop_tracing in both common.c and
common.h to ensure all accesses to this variable bypass compiler
optimizations and read directly from memory. This guarantees that
when the signal handler sets stop_tracing, the change is immediately
visible to the main program loop, preventing potential hangs or
delayed shutdown when termination signals are received.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/common.c | 2 +-
 tools/tracing/rtla/src/common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index d608ffe12e7b0..1e6542a1e9630 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -8,7 +8,7 @@
 #include "common.h"
 
 struct trace_instance *trace_inst;
-int stop_tracing;
+volatile int stop_tracing;
 
 static void stop_trace(int sig)
 {
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index f2c9e21c03651..283641f3e7c9b 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -54,7 +54,7 @@ struct osnoise_context {
 };
 
 extern struct trace_instance *trace_inst;
-extern int stop_tracing;
+extern volatile int stop_tracing;
 
 struct hist_params {
 	char			no_irq;
-- 
2.52.0


