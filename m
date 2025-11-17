Return-Path: <bpf+bounces-74785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB38C65D71
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C280F4E8DD5
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F633374E;
	Mon, 17 Nov 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6jSf2/9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC4332EAD
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405773; cv=none; b=J3Y+P1WKdvOHN50KphSqjkPW2Rd/1RXiegrF4TgTlIHPTH053tP8wl8rntmPVST+srNgGaWJF18T6d6CmieWlftZNJN3nmS1WRAJGwI/bH7yWzxyYMgwUJlNPn3PbObBu5YeI7+4MByIO6loWCLQwyS5CETIgzHTqzQ6RLo8R8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405773; c=relaxed/simple;
	bh=zuQMygyE/fNMvfguYZAXLubepSrga+iMRwkhc12myPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTdtUM1l5YRKHmpvMJUaz0yKtJwGtV66yajOWSen+XSxIFLklbll2U5xk6rM8maEbIUwaeeKxhjMd8TBpaBQUNprqMHzZfVGD7m5EofLt/THzLJ4rPAab7NQjXPQae4GreqJ9oolWJvJtP/VT44iC3e3x6S2meXUHBOFP3Ake9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6jSf2/9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkhAYW9mMK6YIr6jWOVp1CntEtvFvQsO6wElJ8Bztr0=;
	b=N6jSf2/9L+GQPFKg+dcUInw+ToTvcGWPhvA64JMTDi9/UhKRPbtlNmPNGwlMKEPlBm6eUC
	oI2OickUgBewkOoGN/+OXMgq+/O0euvKe+yrQ3atcPZmSBa329BlOeLF0MPNcOp86jSVCt
	yrGTC5fHEzRuYsbo0P3iXyyCNBJ+J9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-coE_3v_4Om-tNrqBEl3pSw-1; Mon,
 17 Nov 2025 13:56:07 -0500
X-MC-Unique: coE_3v_4Om-tNrqBEl3pSw-1
X-Mimecast-MFC-AGG-ID: coE_3v_4Om-tNrqBEl3pSw_1763405766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00D97180122F;
	Mon, 17 Nov 2025 18:56:06 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22E041800298;
	Mon, 17 Nov 2025 18:56:00 +0000 (UTC)
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
Subject: [rtla 08/13] rtla: Use standard exit codes for result enum
Date: Mon, 17 Nov 2025 15:41:15 -0300
Message-ID: <20251117184409.42831-9-wander@redhat.com>
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

The result enum defines custom values for PASSED, ERROR, and FAILED.
These values correspond to standard exit codes EXIT_SUCCESS and
EXIT_FAILURE.

Update the enum to use the standard macros EXIT_SUCCESS and
EXIT_FAILURE to improve readability and adherence to standard C
practices.

The FAILED value is implicitly assigned EXIT_FAILURE + 1, so there
is no need to assign an explicit value.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index f7ff548f7fba7..beff211fdae2d 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -4,6 +4,7 @@
 #include <time.h>
 #include <sched.h>
 #include <stdbool.h>
+#include <stdlib.h>
 
 /*
  * '18446744073709551615\0'
@@ -97,7 +98,7 @@ bool strtoi(const char *s, int *res);
 #define ns_to_per(total, part) ((part * 100) / (double)total)
 
 enum result {
-	PASSED = 0, /* same as EXIT_SUCCESS */
-	ERROR = 1,  /* same as EXIT_FAILURE, an error in arguments */
-	FAILED = 2, /* test hit the stop tracing condition */
+	PASSED	= EXIT_SUCCESS,
+	ERROR	= EXIT_FAILURE,
+	FAILED, /* test hit the stop tracing condition */
 };
-- 
2.51.1


