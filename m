Return-Path: <bpf+bounces-79090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BCFD26960
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 152DB308F1F4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4743D3CE4;
	Thu, 15 Jan 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHgeJjll"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA03C00AD
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498068; cv=none; b=oJ/AzbpaGep2oCHHvy/oS7jEkZ8Ou/PSE/KZxSDMX2MHIzWp0ZIhvv8LZElAynNsYWR6DobR9j+Ha0lfwgijU9zsPVBUzHlTzGqU7HH5r4oQhJJyBWw2DzcHcP46PsqLPMwFavDaWhqd8ZOG9R159jve5HTdA1WX+OY6Bd/58ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498068; c=relaxed/simple;
	bh=SflMTlFbfvCdZHNORr+SoiLJU7P3mYXJ3mlN96zPHHk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V52UeksG6bET0S8I7qH7cjeLqu15hIuwXsGW7dNharXNW8ZEvI8N/dAWgmPySw3YT2nEeBB8Z4LvULxlM+y2q0q+drW/iBC5llTCBDq7+Gg+2nmxQwFgC8mHjdwdnBXuot348xN8MGC24rafKMl8idVS07KmDsFFyaGzBzO1+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHgeJjll; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceyQmDDfhyqenhcNfQjdho74xmls3IZhe6sIRNkyvRM=;
	b=ZHgeJjll/o70Plvwkn8dyhOnKqWV5njYyMcjQRPgexgmd+fbh71ES53/sAoLMnuK5vTI5k
	yaTqDjdiwoLvnWpGQu6mJKYEDVyd5y1wgmqXid9ZI4rSZ2Wo08ra/uiqJZKFZiB5SsV90r
	QQv2aH277cTTSGyXfBA0J2cUlzPvfIU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-jbfw4COsOBOuYKhC4wgjyQ-1; Thu,
 15 Jan 2026 12:27:43 -0500
X-MC-Unique: jbfw4COsOBOuYKhC4wgjyQ-1
X-Mimecast-MFC-AGG-ID: jbfw4COsOBOuYKhC4wgjyQ_1768498061
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E1AA1954B0B;
	Thu, 15 Jan 2026 17:27:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0A3D1800285;
	Thu, 15 Jan 2026 17:27:36 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Haiyong Sun <sunhaiyong@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 10/18] rtla: Add str_has_prefix() helper function
Date: Thu, 15 Jan 2026 13:31:53 -0300
Message-ID: <20260115163650.118910-11-wander@redhat.com>
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

Add a str_has_prefix() helper function that tests whether a string
starts with a given prefix. This function provides a cleaner interface
for prefix matching compared to using strncmp() with strlen() directly.

The function returns a boolean value indicating whether the string
starts with the specified prefix. This helper will be used in
subsequent changes to simplify prefix matching code throughout rtla.

Also add the missing string.h include which is needed for the strlen()
and strncmp() functions used by str_has_prefix() and the existing
strncmp_static() macro.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 25b08fc5e199a..1235d0f3a7bfd 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stdint.h>
+#include <string.h>
 #include <time.h>
 #include <sched.h>
 #include <stdbool.h>
@@ -24,6 +25,18 @@
 /* Compare string with static string, length determined at compile time */
 #define strncmp_static(s1, s2) strncmp(s1, s2, ARRAY_SIZE(s2))
 
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * Returns: true if @str starts with @prefix, false otherwise
+ */
+static inline bool str_has_prefix(const char *str, const char *prefix)
+{
+	return strncmp(str, prefix, strlen(prefix)) == 0;
+}
+
 #define container_of(ptr, type, member)({				\
 	const typeof(((type *)0)->member) * __mptr = (ptr);		\
 	(type *)((char *)__mptr - offsetof(type, member)) ; })
-- 
2.52.0


