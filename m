Return-Path: <bpf+bounces-77953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BADA8CF89AC
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17520302BA92
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1F21CC51;
	Tue,  6 Jan 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEI191Yw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC622CBC0
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707157; cv=none; b=ANcfL1tq0SRiSMvD2wJdsIIKhusqWopLM0iFm960rxIai4rl7o7NCN0lWDys/gXBvkeHtfCQzjOLmCYGqz93dY+RPLNvlrW2rXnyahrQwQSNgE8t+Nm9r4fd+y9OtaPGfRzzoDfJ6WxFqxM/M5M0KqX3JqK09OZPtoy5gxkXhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707157; c=relaxed/simple;
	bh=8gnOH+Eo89f+VcICPmqndkLq6lSKcePozRGfu/ZjDQc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQZ953JHjqptrq3NZA0tiF9W70ch1oyWUalQwQxBjw4XCMCFCFmygEgxxLb+9HkyFDvraAZ97QmAzpcNXUiijuhY4sAmvaMnmNwwTGJWrhhulasdQFb15zuyvOIxhr8wkP/8jzF8XvWziaN+xXD14taLCZBxDh3dkMfBgcRqP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEI191Yw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa3BDtkXy0XBMcTKcISXu7dZ5d/WNRYV5EhDhDMbaJA=;
	b=fEI191YwJXrT+g6gpkAtSb1asCpuXiwVnZNSQOfRHsX9o4uF2QChCDBBgk/Q+0QLWwnT8F
	/a7PODmXAij57oC8o1zhZNkGgatII2008qGN0TuasdHZsRISWof6lyLuLoM+80Z5QBDSGa
	jp9OzKYf8+czE/UgLcV7Us7+CUPLAu8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-3okzsnYrPyC0qyTG8nV0Gw-1; Tue,
 06 Jan 2026 08:45:51 -0500
X-MC-Unique: 3okzsnYrPyC0qyTG8nV0Gw-1
X-Mimecast-MFC-AGG-ID: 3okzsnYrPyC0qyTG8nV0Gw_1767707150
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36C001956096;
	Tue,  6 Jan 2026 13:45:50 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E414180035A;
	Tue,  6 Jan 2026 13:45:45 +0000 (UTC)
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
Subject: [PATCH v2 13/18] rtla: Fix buffer size for strncpy in timerlat_aa
Date: Tue,  6 Jan 2026 08:49:49 -0300
Message-ID: <20260106133655.249887-14-wander@redhat.com>
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

The run_thread_comm and current_comm character arrays in struct
timerlat_aa_data are defined with size MAX_COMM (24 bytes), but
strncpy() is called with MAX_COMM as the size parameter. If the
source string is exactly MAX_COMM bytes or longer, strncpy() will
copy exactly MAX_COMM bytes without null termination, potentially
causing buffer overruns when these strings are later used.

Increase the buffer sizes to MAX_COMM+1 to ensure there is always
room for the null terminator. This guarantees that even when strncpy()
copies the maximum number of characters, the buffer remains properly
null-terminated and safe to use in subsequent string operations.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat_aa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 31e66ea2b144c..d310fe65abace 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -47,7 +47,7 @@ struct timerlat_aa_data {
 	 * note: "unsigned long long" because they are fetch using tep_get_field_val();
 	 */
 	unsigned long long	run_thread_pid;
-	char			run_thread_comm[MAX_COMM];
+	char			run_thread_comm[MAX_COMM+1];
 	unsigned long long	thread_blocking_duration;
 	unsigned long long	max_exit_idle_latency;
 
@@ -88,7 +88,7 @@ struct timerlat_aa_data {
 	/*
 	 * Current thread.
 	 */
-	char			current_comm[MAX_COMM];
+	char			current_comm[MAX_COMM+1];
 	unsigned long long	current_pid;
 
 	/*
-- 
2.52.0


