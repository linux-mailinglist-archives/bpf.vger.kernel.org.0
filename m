Return-Path: <bpf+bounces-79095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F21D26781
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43A4030563D4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E33D3007;
	Thu, 15 Jan 2026 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJ1CvWB6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD03C1973
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498171; cv=none; b=ffUU76urYUTFIHPmMdhaaXXjX8XnCcU6jdI/VMFacV9DrshcnLQcidJBv/xJcE4sNuHyPz4njESlg/rbXboBlz04TObigZWcoU5uW8i8QT2PaCxxf4y9BhquRL7TguPrmm2AOJeH94ocP5kbK+/lhH7wKatPtcRCcoZjD3lvs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498171; c=relaxed/simple;
	bh=/8OuF00pp6FFiPuSw3AMppL0kz8wKPiLAYLFZ1Ivp8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAgaOU4DTw6SxH1KF6ZHmSRW17+Of3hZwUa+6lxlroBNYlDrAG0m3boloRZpE9UuxhWF4zgBYNqM54N3jVhYVIIbsNvwZxg0A4fMbR03GIUGp9eis7VZhNJR/vr9OCCYnRYOCqtByBQmD6oHQNU6LJHQaSpb3rpzU34sVHRD89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJ1CvWB6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbxiRjdWmA02eWzJj/JqfOkUupAYpZjuI15c7UU19T8=;
	b=ZJ1CvWB6sKYD5wiDtadZJ1hSbUiRw5eTnIe56JFDNqtIXjPu0NhH62N2Rimt8ZAD+ulmg9
	4NcYiVfXAOhHkSTIpQqqf2sCgsJbyznkXgtaY37M3+puyQr8gOoPuc77x29apfrMNAVS2D
	Ul1O0Q3M5DUkFBMFj9aawS5qScTYCkY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-uGbfuLnvMPe36yLhCBSY2w-1; Thu,
 15 Jan 2026 12:29:24 -0500
X-MC-Unique: uGbfuLnvMPe36yLhCBSY2w-1
X-Mimecast-MFC-AGG-ID: uGbfuLnvMPe36yLhCBSY2w_1768498160
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B94B180045C;
	Thu, 15 Jan 2026 17:29:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 677AC1800285;
	Thu, 15 Jan 2026 17:29:15 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Haiyong Sun <sunhaiyong@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 15/18] rtla/trace: Fix write loop in trace_event_save_hist()
Date: Thu, 15 Jan 2026 13:31:58 -0300
Message-ID: <20260115163650.118910-16-wander@redhat.com>
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

The write loop in trace_event_save_hist() does not correctly handle
errors from the write() system call. If write() returns -1, this value
is added to the loop index, leading to an incorrect memory access on
the next iteration and potentially an infinite loop. The loop also
fails to handle EINTR.

Fix the write loop by introducing proper error handling. The return
value of write() is now stored in a ssize_t variable and checked for
errors. The loop retries the call if interrupted by a signal and breaks
on any other error after logging it with strerror().

Additionally, change the index variable type from int to size_t to
match the type used for buffer sizes and by strlen(), improving type
safety.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index ed7db5f4115ce..fed3362527b08 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -342,11 +342,11 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 static void trace_event_save_hist(struct trace_instance *instance,
 				  struct trace_events *tevent)
 {
-	int index, out_fd;
+	size_t index, hist_len;
 	mode_t mode = 0644;
 	char path[MAX_PATH];
 	char *hist;
-	size_t hist_len;
+	int out_fd;
 
 	if (!tevent)
 		return;
@@ -378,7 +378,15 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	index = 0;
 	hist_len = strlen(hist);
 	do {
-		index += write(out_fd, &hist[index], hist_len - index);
+		const ssize_t written = write(out_fd, &hist[index], hist_len - index);
+
+		if (written < 0) {
+			if (errno == EINTR)
+				continue;
+			err_msg("  Error writing hist file: %s\n", strerror(errno));
+			break;
+		}
+		index += written;
 	} while (index < hist_len);
 
 	free(hist);
-- 
2.52.0


