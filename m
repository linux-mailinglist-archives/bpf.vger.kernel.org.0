Return-Path: <bpf+bounces-77957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41DCF8988
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1D863003840
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B894346E60;
	Tue,  6 Jan 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVoK/tQk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777C33D6F9
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707308; cv=none; b=c41UPQF8Lt4YCSrIDDyVdy06zr3qMg7RcuPJz+B/wpR7xW4X4Nuhh/E1OUFqvkwrIFyMIwKkGxNX3Mc9yK4tPcPoXfBVcCKfcpNQ//S8JZY1dqb3T/PU2qPjQmlPRj7pBqw7Ty0szhJ4Y/1aXwZua3khyP8QpyGoR4c+cFylCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707308; c=relaxed/simple;
	bh=SQR+A6Rt1nFESNQ3gMr0olAyt1eeqZOPR2xNeMz1fRI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQt7QVSBhKM/PcmkCE5b2NOMF2f82aOPrxCrFRtH5LIw/pLqLfYKLT3tsKO0U/aCTbONR5hgqcrLzl5hI3MZZqCpd9wHtNs4C/Lgt/5nfVQr0/082c/jmUU3mVciprPZWXv0abCcRN92hXBV2BthVlGCxvC5DA0teKUWpzsFLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVoK/tQk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNP90wk4H8rdVkur8zqT0itxOHKAzLeaufg8KGIEo/w=;
	b=cVoK/tQkmv+lF/ZlxQR8aU1PIdOU4gsueOR7CM2JL+IOjN/re0oJyjHUqEQr72YJEZ/TBI
	ACpc8T8Y1FB3a7Ut6vUdkqhLPBMfVTj5WTj4/ZQgoCmziKHYea/8UVG1JtjMU9wFYoP3+a
	qJ1kPAs+NrAL89n54N8s8V/sdYEIhJg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-fylWa2GDO0moLpfc42uI_g-1; Tue,
 06 Jan 2026 08:48:23 -0500
X-MC-Unique: fylWa2GDO0moLpfc42uI_g-1
X-Mimecast-MFC-AGG-ID: fylWa2GDO0moLpfc42uI_g_1767707302
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ABF21956063;
	Tue,  6 Jan 2026 13:48:22 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64C941800576;
	Tue,  6 Jan 2026 13:48:17 +0000 (UTC)
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
Subject: [PATCH v2 17/18] rtla: Fix parse_cpu_set() return value documentation
Date: Tue,  6 Jan 2026 08:49:53 -0300
Message-ID: <20260106133655.249887-18-wander@redhat.com>
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

Correct the return value documentation for parse_cpu_set() function
in utils.c. The comment incorrectly stated that the function returns
1 on success and 0 on failure, but the actual implementation returns
0 on success and 1 on failure, following the common error-on-nonzero
convention used throughout the codebase.

This documentation fix ensures that developers reading the code
understand the correct return value semantics and prevents potential
misuse of the function's return value in conditional checks.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 508b8891acd86..4093030e446ab 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -113,7 +113,7 @@ void get_duration(time_t start_time, char *output, int output_size)
  * Receives a cpu list, like 1-3,5 (cpus 1, 2, 3, 5), and then set
  * filling cpu_set_t argument.
  *
- * Returns 1 on success, 0 otherwise.
+ * Returns 0 on success, 1 otherwise.
  */
 int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 {
-- 
2.52.0


