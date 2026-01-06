Return-Path: <bpf+bounces-77946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A718BCF8AC0
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 15:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90307300E407
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 14:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EAD33CEB4;
	Tue,  6 Jan 2026 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1+2okFt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2A33A029
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706904; cv=none; b=fv8DugxG5aV/cjTVCgHsJYpjZy4nW2gz2GxgDszLwxOtxKVcQ/25e1L/X1sVxI8RYVHnBtzOBiKKFvrAuy8HI99IlBFHP7XpNsBrwyXB61ktGjsBfu/deWx3zV1RLUJMEXc3zX35gkslwqjTFub4lB5DmsAMijDrGsVKa7diFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706904; c=relaxed/simple;
	bh=FIQU6/noRh/DqRmJSN92ZNNQKs6OnQ2XEwbcrtd2R5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNXakAsEnhMTCAqkSz3Cse8ygPCn7QPtQzfH/LMX3lfF2mlYBAiIePWTQDwtltEZ0fgMqWO2johqcurFVa9b1qICrGxPy1MHGOJ0vJp2YoZ9cvcqsGbTrPg/DQP4CSjsBSD/b3gG/rCOhHnx5IJmE/j0bQsjmmnOkNcT67TIvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1+2okFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977R6OMVKeJ7HyZ84fNIsYfSl3IYsNqr8X/5/SqWz/w=;
	b=E1+2okFtK7xIK0UoMA6cygMkQ5fi+T96WTd1pedZNl8bOfIgqtiOExuLZkmJb3yj4xNPe0
	zggzSF6h6g/3imGH76GhQPnKB7UX9ApFmGdSJQG+bv6CScnQhUpAmWSxK6B7ClZvRdiySh
	48eUcmCH9or3yjecYxFGn0h9VwKnAWU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-IV61w0_OOneAqtSBBtN4ng-1; Tue,
 06 Jan 2026 08:41:38 -0500
X-MC-Unique: IV61w0_OOneAqtSBBtN4ng-1
X-Mimecast-MFC-AGG-ID: IV61w0_OOneAqtSBBtN4ng_1767706897
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7722619560B2;
	Tue,  6 Jan 2026 13:41:37 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17DE7180035A;
	Tue,  6 Jan 2026 13:41:33 +0000 (UTC)
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
Subject: [PATCH v2 06/18] rtla: Use strncmp_static() in more places
Date: Tue,  6 Jan 2026 08:49:42 -0300
Message-ID: <20260106133655.249887-7-wander@redhat.com>
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

The recently introduced strncmp_static() helper provides a safer way
to compare strings with static strings by determining the length at
compile time.

Replace several open-coded strncmp() calls with strncmp_static() to
improve code readability and robustness. This change affects the
parsing of command-line arguments and environment variables.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c  | 2 +-
 tools/tracing/rtla/src/timerlat.c | 4 ++--
 tools/tracing/rtla/src/trace.c    | 2 +-
 tools/tracing/rtla/src/utils.c    | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index c5b41ec26b0a4..f2ec2da7b6d3a 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1219,7 +1219,7 @@ int osnoise_main(int argc, char *argv[])
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
 		osnoise_usage(0);
-	} else if (strncmp(argv[1], "-", 1) == 0) {
+	} else if (strncmp_static(argv[1], "-") == 0) {
 		/* the user skipped the tool, call the default one */
 		run_tool(&osnoise_top_ops, argc, argv);
 		exit(0);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index df4f9bfe34331..ac2ec89d3b6ba 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -34,7 +34,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 	 * Try to enable BPF, unless disabled explicitly.
 	 * If BPF enablement fails, fall back to tracefs mode.
 	 */
-	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
+	if (getenv("RTLA_NO_BPF") && strncmp_static(getenv("RTLA_NO_BPF"), "1") == 0) {
 		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
 		params->mode = TRACING_MODE_TRACEFS;
 	} else if (!tep_find_event_by_name(tool->trace.tep, "osnoise", "timerlat_sample")) {
@@ -271,7 +271,7 @@ int timerlat_main(int argc, char *argv[])
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
 		timerlat_usage(0);
-	} else if (strncmp(argv[1], "-", 1) == 0) {
+	} else if (strncmp_static(argv[1], "-") == 0) {
 		/* the user skipped the tool, call the default one */
 		run_tool(&timerlat_top_ops, argc, argv);
 		exit(0);
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index b22bb844b71f3..45328c5121f79 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -356,7 +356,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 		return;
 
 	/* is this a hist: trigger? */
-	retval = strncmp(tevent->trigger, "hist:", strlen("hist:"));
+	retval = strncmp_static(tevent->trigger, "hist:");
 	if (retval)
 		return;
 
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index f3e129d17a82b..e0f31e5cae844 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -211,15 +211,15 @@ long parse_ns_duration(char *val)
 	t = strtol(val, &end, 10);
 
 	if (end) {
-		if (!strncmp(end, "ns", 2)) {
+		if (!strncmp_static(end, "ns")) {
 			return t;
-		} else if (!strncmp(end, "us", 2)) {
+		} else if (!strncmp_static(end, "us")) {
 			t *= 1000;
 			return t;
-		} else if (!strncmp(end, "ms", 2)) {
+		} else if (!strncmp_static(end, "ms")) {
 			t *= 1000 * 1000;
 			return t;
-		} else if (!strncmp(end, "s", 1)) {
+		} else if (!strncmp_static(end, "s")) {
 			t *= 1000 * 1000 * 1000;
 			return t;
 		}
-- 
2.52.0


