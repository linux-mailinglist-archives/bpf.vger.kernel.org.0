Return-Path: <bpf+bounces-79087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B55B2D26884
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 422833061C75
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A713C1FEF;
	Thu, 15 Jan 2026 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfRjGi+s"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC02C027B
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498017; cv=none; b=UMvnzHi1SJqH1h+9hJqDRlRwv3lNPjKk9H6Esq6nSPtSFu2DCDEqgys4i5sm/KmwREeLm/VxRgf92h/HnYTWSgEHo7lCZZ4nUi+Ny+ENG2Z4owuCVvOrAuKGn02niG/LaWAgdpaRb0iC1pZ5mLW3CIDLlb1/lFQFEHhrHNMNmzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498017; c=relaxed/simple;
	bh=szhz/dB9EAzsGuSsGHAlmKNjv6lSXykuU7dDqVz0V+w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfYpHTn2Fh2n+7FDL4wLskj2JVBFsI1xMLqbuvQExNh7NhYTUcvob5PxLN67hbIaj+HgEtPYXHnKBw/YQtJjquw8ZDNAbDLI2ZB/tPoinGyvA2RsW7i6n4YzC/LkG8gqGDGCwZkOSPYY36/dfm7hE1FXCWjm/DLjtApylBMhA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfRjGi+s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rSo0ZpftjCBpY+QQsVLQhenX4Nub+dXJ6+E44kUmrI=;
	b=IfRjGi+s1lShTHFHT4SBOM0pKQrTSVOEliv/HSnZFcGnyFooGzDfJS7XMIaDSXO9JAy8Mj
	HRCu/UVIeLP3LKTW0zwySeF27C2DnSvWMazKtGnHlKK9cSqsGp5YRWsultEWV5Y/hrOyzb
	98dw3BHp/LDN9zeZx30Een7Q8/W8cq4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-Ocnl8lsaMYqGiJHHLWbIig-1; Thu,
 15 Jan 2026 12:26:45 -0500
X-MC-Unique: Ocnl8lsaMYqGiJHHLWbIig-1
X-Mimecast-MFC-AGG-ID: Ocnl8lsaMYqGiJHHLWbIig_1768498002
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78CFD18003FD;
	Thu, 15 Jan 2026 17:26:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A586B18004D8;
	Thu, 15 Jan 2026 17:26:37 +0000 (UTC)
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
Subject: [PATCH v3 07/18] rtla: Add strscpy() and replace strncpy() calls
Date: Thu, 15 Jan 2026 13:31:50 -0300
Message-ID: <20260115163650.118910-8-wander@redhat.com>
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

Introduce a userspace strscpy() implementation that matches the Linux
kernel's strscpy() semantics. The function is built on top of glibc's
strlcpy() and provides guaranteed NUL-termination along with proper
truncation detection through its return value.

The previous strncpy() calls had potential issues: strncpy() does not
guarantee NUL-termination when the source string length equals or
exceeds the destination buffer size. This required defensive patterns
like pre-zeroing buffers or manually setting the last byte to NUL.
The new strscpy() function always NUL-terminates the destination buffer
unless the size is zero, and returns -E2BIG on truncation, making error
handling cleaner and more consistent with kernel code.

Note that unlike the kernel's strscpy(), this implementation uses
strlcpy() internally, which reads the entire source string to determine
its length. The kernel avoids this to prevent potential DoS attacks from
extremely long untrusted strings. This is harmless for a userspace CLI
tool like rtla where input sources are bounded and trusted.

Replace all strncpy() calls in rtla with strscpy(), using sizeof() for
buffer sizes instead of magic constants to ensure the sizes stay in
sync with the actual buffer declarations. Also remove a now-redundant
memset() call that was previously needed to work around strncpy()
behavior.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat_aa.c |  6 ++---
 tools/tracing/rtla/src/utils.c       | 34 ++++++++++++++++++++++++++--
 tools/tracing/rtla/src/utils.h       |  1 +
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 31e66ea2b144c..30ef56d644f9c 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -455,9 +455,9 @@ static int timerlat_aa_thread_handler(struct trace_seq *s, struct tep_record *re
 		taa_data->thread_blocking_duration = duration;
 
 		if (comm)
-			strncpy(taa_data->run_thread_comm, comm, MAX_COMM);
+			strscpy(taa_data->run_thread_comm, comm, sizeof(taa_data->run_thread_comm));
 		else
-			sprintf(taa_data->run_thread_comm, "<...>");
+			strscpy(taa_data->run_thread_comm, "<...>", sizeof(taa_data->run_thread_comm));
 
 	} else {
 		taa_data->thread_thread_sum += duration;
@@ -519,7 +519,7 @@ static int timerlat_aa_sched_switch_handler(struct trace_seq *s, struct tep_reco
 	tep_get_field_val(s, event, "next_pid", record, &taa_data->current_pid, 1);
 	comm = tep_get_field_raw(s, event, "next_comm", record, &val, 1);
 
-	strncpy(taa_data->current_comm, comm, MAX_COMM);
+	strscpy(taa_data->current_comm, comm, sizeof(taa_data->current_comm));
 
 	/*
 	 * If this was a kworker, clean the last kworkers that ran.
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index b5a6007b108d2..e98288e55db15 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -722,8 +722,7 @@ static const int find_mount(const char *fs, char *mp, int sizeof_mp)
 	if (!found)
 		return 0;
 
-	memset(mp, 0, sizeof_mp);
-	strncpy(mp, mount_point, sizeof_mp - 1);
+	strscpy(mp, mount_point, sizeof_mp);
 
 	debug_msg("Fs %s found at %s\n", fs, mp);
 	return 1;
@@ -1036,6 +1035,37 @@ int strtoi(const char *s, int *res)
 	return 0;
 }
 
+/**
+ * strscpy - Copy a C-string into a sized buffer
+ * @dst: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the source string @src, or as much of it as fits, into the destination
+ * @dst buffer. The destination @dst buffer is always NUL-terminated, unless
+ * it's zero-sized.
+ *
+ * This is a userspace implementation matching the kernel's strscpy() semantics,
+ * built on top of glibc's strlcpy().
+ *
+ * Returns the number of characters copied (not including the trailing NUL)
+ * or -E2BIG if @count is 0 or the copy was truncated.
+ */
+ssize_t strscpy(char *dst, const char *src, size_t count)
+{
+	size_t len;
+
+	if (count == 0)
+		return -E2BIG;
+
+	len = strlcpy(dst, src, count);
+
+	if (len >= count)
+		return -E2BIG;
+
+	return (ssize_t) len;
+}
+
 static inline void fatal_alloc(void)
 {
 	fatal("Error allocating memory\n");
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 8323c999260c2..25b08fc5e199a 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -97,6 +97,7 @@ static inline int have_libcpupower_support(void) { return 0; }
 #endif /* HAVE_LIBCPUPOWER_SUPPORT */
 int auto_house_keeping(cpu_set_t *monitored_cpus);
 __attribute__((__warn_unused_result__)) int strtoi(const char *s, int *res);
+ssize_t strscpy(char *dst, const char *src, size_t count);
 
 #define ns_to_usf(x) (((double)x/1000))
 #define ns_to_per(total, part) ((part * 100) / (double)total)
-- 
2.52.0


