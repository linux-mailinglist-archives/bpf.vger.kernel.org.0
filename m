Return-Path: <bpf+bounces-79092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86CD2699E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00FA930589B3
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF4A3BF2FF;
	Thu, 15 Jan 2026 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWRN6aiR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C83C1969
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498107; cv=none; b=XmMMCMwZD9JXUa31bXpVEvVP1GiHoh/e6mfTYDFC8FnCtmJiTQGd0YTfv4Ltkm/aM2jLk97qAyMOo8VvWkGGKgcGgXWOVQhOlNdxEm9Rz8IRWP7XuS7NJHJAEai/LQIQN5AAZwPzeq3H/EP8YiyNrGSfuzMFAiiimk+XU7jjcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498107; c=relaxed/simple;
	bh=i+zvPJCwKsJSTY0DS4qLye0RX9bNjeXEO9JZECY/rbk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6OCcTDIfutmYp1yUA/6q7om2HKEu3wvgbLlhRGNtOUhUT9uIyeSBkifJ5WMmItiWScVbh1nYlLY0DENEKxqYtcyWBcwsozYR6C5KQP5hSXZnIzjjN4Ok6Lg3exuLiE44z0qZY3vBcwk2S72kWfSTFr3c9S/FwQP9nGndzXlbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWRN6aiR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86QMRTFiSKKXrEOcjxY7eSDwbxvO+9yhIJmoFALNgP4=;
	b=PWRN6aiRPLooSq/fs58tjOLcUtujBcPmEHIvM7aNJVJYJZEvqLQ2zJsEfbkPEgGYqTJHW7
	lOXXnzxaEiDbK/PA0Y+om3Jn/e9gI7fvUknelEwWM96V/PxKvkmJ3nNPZNfntVyAkftMjb
	yRMdXPQ8fYwLtHZsXlhKxeoyvJ6Z2dc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-oWg-JDsOOGKxRwOlQH3UCA-1; Thu,
 15 Jan 2026 12:28:21 -0500
X-MC-Unique: oWg-JDsOOGKxRwOlQH3UCA-1
X-Mimecast-MFC-AGG-ID: oWg-JDsOOGKxRwOlQH3UCA_1768498100
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64E0818005B2;
	Thu, 15 Jan 2026 17:28:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D83C218004D8;
	Thu, 15 Jan 2026 17:28:15 +0000 (UTC)
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
Subject: [PATCH v3 12/18] rtla: Enforce exact match for time unit suffixes
Date: Thu, 15 Jan 2026 13:31:55 -0300
Message-ID: <20260115163650.118910-13-wander@redhat.com>
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

The parse_ns_duration() function currently uses prefix matching for
detecting time units. This approach is problematic as it silently
accepts malformed strings such as "100nsx" or "100us_invalid" by
ignoring the trailing characters, leading to potential configuration
errors.

Switch to using strcmp() for suffix comparison to enforce exact matches.
This ensures that the parser strictly validates the time unit and
rejects any input containing invalid trailing characters, thereby
improving the robustness of the configuration parsing.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 486d96e8290fb..b029fe5970c31 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -211,15 +211,15 @@ long parse_ns_duration(char *val)
 	t = strtol(val, &end, 10);
 
 	if (end) {
-		if (!strncmp(end, "ns", 2)) {
+		if (strcmp(end, "ns") == 0) {
 			return t;
-		} else if (!strncmp(end, "us", 2)) {
+		} else if (strcmp(end, "us") == 0) {
 			t *= 1000;
 			return t;
-		} else if (!strncmp(end, "ms", 2)) {
+		} else if (strcmp(end, "ms") == 0) {
 			t *= 1000 * 1000;
 			return t;
-		} else if (!strncmp(end, "s", 1)) {
+		} else if (strcmp(end, "s") == 0) {
 			t *= 1000 * 1000 * 1000;
 			return t;
 		}
-- 
2.52.0


