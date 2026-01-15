Return-Path: <bpf+bounces-79096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF1DD26D40
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4926331371DE
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9C03D3016;
	Thu, 15 Jan 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU78eToi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE33D3305
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498186; cv=none; b=h4hzqhTThKL2fRqSN/jqBlhXwCGaPC9qfC1sq6gJhmq1XzQet10O8jIjJvUfxrUXr1hZTIob4GG7/Cz5gPpjyw7mQfRIniiTDbHFNpjtX763NXGmtrd0AxW07ClricFWhSatdxzTp02PB116NGBHC3qIc/PAryCeldQYnigOLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498186; c=relaxed/simple;
	bh=ShCFLV0cl6uWodOfkKPQsW7EQxQrPSPPxjVzA5jQP5o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNrmVeEu2VIIem7eJDtZYuwgK3zO7y2o6tGibmUps3IiLLU3ecM/c4RSAUwui42SEIS43hJCXDvmrbxAFuTgaM408sThY0iNWI4mDqLsp5XR3RhQaLE2W+JXQZY3TXb6Dmmo3ADCZsBoWaHIry7JcCAXpiL0nUTF/ZX9YEcSWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CU78eToi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3Gh9XqLfm/ta5RTgIzRh8pa4KVIwrKEpFGs+x5qjPA=;
	b=CU78eToiAXphXLWc1jIb8rHugAvG85Hr750SL7PbEhCqN3CdzaQd6zyjqRMNxnRTcypA8h
	IGDza8gpI6tjbJK8bZ9yyfG6sVZMNm7zYnGdel5BN3fe6j/ryBcR/mRUfKP8M3PuZbBxlo
	ScriKQ0C3WrwD6dMnlAXnWRnEHvvl2M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-Gw0g7wEEMaiF07PzifD5pw-1; Thu,
 15 Jan 2026 12:29:42 -0500
X-MC-Unique: Gw0g7wEEMaiF07PzifD5pw-1
X-Mimecast-MFC-AGG-ID: Gw0g7wEEMaiF07PzifD5pw_1768498180
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DA5E1954B24;
	Thu, 15 Jan 2026 17:29:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC76818004D8;
	Thu, 15 Jan 2026 17:29:35 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Haiyong Sun <sunhaiyong@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 16/18] rtla/trace: Fix I/O handling in save_trace_to_file()
Date: Thu, 15 Jan 2026 13:31:59 -0300
Message-ID: <20260115163650.118910-17-wander@redhat.com>
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

The read/write loop in save_trace_to_file() does not correctly handle
errors from the read() and write() system calls. If either call is
interrupted by a signal, it returns -1 with errno set to EINTR, but
the code treats this as a fatal error and aborts the save operation.
Additionally, write() may perform a partial write, returning fewer
bytes than requested, which the code does not handle.

Fix the I/O loop by introducing proper error handling. The return
value of read() is now stored in a ssize_t variable and checked for
errors, with EINTR causing a retry. For write(), an inner loop ensures
all bytes are written, handling both EINTR and partial writes. Error
messages now include strerror() output for better debugging.

This follows the same pattern established in the previous commit that
fixed trace_event_save_hist(), ensuring consistent and robust I/O
handling throughout the trace saving code.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index fed3362527b08..8e93b48d33ef8 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -73,6 +73,7 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
 	char buffer[4096];
 	int out_fd, in_fd;
 	int retval = -1;
+	ssize_t n_read;
 
 	if (!inst || !filename)
 		return 0;
@@ -90,15 +91,30 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
 		goto out_close_in;
 	}
 
-	do {
-		retval = read(in_fd, buffer, sizeof(buffer));
-		if (retval <= 0)
+	for (;;) {
+		n_read = read(in_fd, buffer, sizeof(buffer));
+		if (n_read < 0) {
+			if (errno == EINTR)
+				continue;
+			err_msg("Error reading trace file: %s\n", strerror(errno));
 			goto out_close;
+		}
+		if (n_read == 0)
+			break;
 
-		retval = write(out_fd, buffer, retval);
-		if (retval < 0)
-			goto out_close;
-	} while (retval > 0);
+		ssize_t n_written = 0;
+		while (n_written < n_read) {
+			ssize_t w = write(out_fd, buffer + n_written, n_read - n_written);
+
+			if (w < 0) {
+				if (errno == EINTR)
+					continue;
+				err_msg("Error writing trace file: %s\n", strerror(errno));
+				goto out_close;
+			}
+			n_written += w;
+		}
+	}
 
 	retval = 0;
 out_close:
-- 
2.52.0


