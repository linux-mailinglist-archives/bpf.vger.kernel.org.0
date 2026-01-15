Return-Path: <bpf+bounces-79088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB3D26B63
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E8ED310D3A1
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139BC3D3005;
	Thu, 15 Jan 2026 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgI+HZ54"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513153C1FC3
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498031; cv=none; b=f+t7apmMXB9Y+pQdULV9y1MlRWJr5gPWc5d+EQDDSiFDMJupRGYxSC8CzpuJmNTAtwVT6t5J9Rg+6GL+iZNpHy++vqx+Ap1YcFIafLT5Tu/vg0COcljM/P58/GKgLHJHfgjA9x/IE+viX5yJbDlfdEDRpF9ntqzL5WHrpk3e2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498031; c=relaxed/simple;
	bh=tJLt5B2DZji/ml4Afp0udSPkcIunpC8Iq9d4OE08FUY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qj+WsTVc/40PnxxznGzwyRHAZ5RhGCjIu+B+ECeM0RBlRso27iMn2TryceQ4n4iXok52diBI1o4KxFTiWJjvKFiSMGGLK4QVYiV4n+SYGvwdiZWKvuDj3HF+myk61WhwwRo7C3HN85IuwtZBvnFLqVqCgkKZxFMgpyWKKovYS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgI+HZ54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkBXskbl+1yjIDirDDZ66gzhrdCqszVJfA3kLEp28sU=;
	b=XgI+HZ54+kPpVVInTWjXbYxIvWbMha2ul4ZzdfKAdeO+XdZUUxn/kkFtUoOjiGVVH50poC
	GHG5SzRW8GZQ2FQIV44WSLoIb7iurEPsEsKlr6uVhbApkTksRmah1W7SmjT0376CDT6hdE
	rCyTgI9KuPw3JNS8GZ/JN+WgYKtGd7w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-zEVz8VLlNKOeoLOTAr2Ztw-1; Thu,
 15 Jan 2026 12:27:03 -0500
X-MC-Unique: zEVz8VLlNKOeoLOTAr2Ztw-1
X-Mimecast-MFC-AGG-ID: zEVz8VLlNKOeoLOTAr2Ztw_1768498022
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45BB7180047F;
	Thu, 15 Jan 2026 17:27:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E7F318004D8;
	Thu, 15 Jan 2026 17:26:57 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Haiyong Sun <sunhaiyong@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 08/18] rtla/timerlat: Add bounds check for softirq vector
Date: Thu, 15 Jan 2026 13:31:51 -0300
Message-ID: <20260115163650.118910-9-wander@redhat.com>
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

Add bounds checking when accessing the softirq_name array using the
vector value from kernel trace data. The vector field from the
osnoise:softirq_noise event is used directly as an array index without
validation, which could cause an out-of-bounds read if the kernel
provides an unexpected vector value.

The softirq_name array contains 10 elements corresponding to the
standard Linux softirq vectors. While the kernel should only provide
valid vector values in the range 0-9, defensive programming requires
validating untrusted input before using it as an array index. If an
out-of-range vector is encountered, display the word UNKNOWN instead
of attempting to read beyond the array bounds.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat_aa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 30ef56d644f9c..bc421637cc19b 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -417,8 +417,8 @@ static int timerlat_aa_softirq_handler(struct trace_seq *s, struct tep_record *r
 	taa_data->thread_softirq_sum += duration;
 
 	trace_seq_printf(taa_data->softirqs_seq, "  %24s:%-3llu %.*s %9.2f us\n",
-			 softirq_name[vector], vector,
-			 24, spaces,
+			 vector < ARRAY_SIZE(softirq_name) ? softirq_name[vector] : "UNKNOWN",
+			 vector, 24, spaces,
 			 ns_to_usf(duration));
 	return 0;
 }
-- 
2.52.0


