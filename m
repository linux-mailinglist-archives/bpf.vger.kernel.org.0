Return-Path: <bpf+bounces-79086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B610D26AD9
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1155D30FF3FF
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD43C1FF2;
	Thu, 15 Jan 2026 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4AlkygR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F523BFE25
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497988; cv=none; b=ru5Oz2EnLxCC0e8XgdehMaGkx7zN7IEDrtmmJp459CtF3tuJrperNYMDChzLe6YPU/CIvEGmihvFBNxQp9wPX1pIbFI4fmh12bgh2a7K5WetLTUzVC2l7bbL/AR4aQ/ARHnNKz08rMRYOyIbacgV5yWWR1dpm+gYPiPlABwqPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497988; c=relaxed/simple;
	bh=T7o0zP6EJubXjuBW2C/9GrQT2Gye/tqv6VQ1VxV83rs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWPWGD8KMx8Yk2AbNZXske7M9XGlWgqNW1un+EudfqKgfY58yauVojlCmf7aYn0jwkNR6BE+xV5HnF1thKa3bH9q2BSSPIePuKhlTIJzD58KKLsn80x2N17jz6m2NrT3uxBar3tvjgJc6hNwuJKldbYgxFd0yCdfAzeSNi2CjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4AlkygR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768497986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8KTz5utFl7V46Z0aDTcTYKhxj6BI+IbgWi2PWVNcmE=;
	b=V4AlkygRpjah/a5bFC65BJxKeMwqbN+n2FBC14OVQsSI3gBW94bWQ6nJ4rk/qLOtq97e54
	xV2/qHec6v61BciRWX6BUAoWcwAQscMBAsoKCVRVEKCAlwsrmPIQB9iMxBr7pdL5NGJCjm
	lDkhd28uTRRq4aa3RbVVkKQDzSA6I6g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-tbDEcCIEOoufTouSJuJYug-1; Thu,
 15 Jan 2026 12:26:24 -0500
X-MC-Unique: tbDEcCIEOoufTouSJuJYug-1
X-Mimecast-MFC-AGG-ID: tbDEcCIEOoufTouSJuJYug_1768497983
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C509B18005AD;
	Thu, 15 Jan 2026 17:26:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35FB918004D8;
	Thu, 15 Jan 2026 17:26:17 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 06/18] rtla: Simplify code by caching string lengths
Date: Thu, 15 Jan 2026 13:31:49 -0300
Message-ID: <20260115163650.118910-7-wander@redhat.com>
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

Simplify trace_event_save_hist() and set_comm_cgroup() by computing
string lengths once and storing them in local variables, rather than
calling strlen() multiple times on the same unchanged strings. This
makes the code clearer by eliminating redundant function calls and
improving readability.

In trace_event_save_hist(), the write loop previously called strlen()
on the hist buffer twice per iteration for both the size calculation
and loop condition. Store the length in hist_len before entering the
loop. In set_comm_cgroup(), strlen() was called on cgroup_path up to
three times in succession. Store the result in cg_path_len to use in
both the offset calculation and size parameter for subsequent append
operations.

This simplification makes the code easier to read and maintain without
changing program behavior.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/trace.c |  6 ++++--
 tools/tracing/rtla/src/utils.c | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index e1af54f9531b8..2f529aaf8deef 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -346,6 +346,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	mode_t mode = 0644;
 	char path[MAX_PATH];
 	char *hist;
+	size_t hist_len;
 
 	if (!tevent)
 		return;
@@ -376,9 +377,10 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	}
 
 	index = 0;
+	hist_len = strlen(hist);
 	do {
-		index += write(out_fd, &hist[index], strlen(hist) - index);
-	} while (index < strlen(hist));
+		index += write(out_fd, &hist[index], hist_len - index);
+	} while (index < hist_len);
 
 	free(hist);
 out_close:
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 75cdcc63d5a15..b5a6007b108d2 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -811,6 +811,7 @@ static int open_cgroup_procs(const char *cgroup)
 	char cgroup_procs[MAX_PATH];
 	int retval;
 	int cg_fd;
+	size_t cg_path_len;
 
 	retval = find_mount("cgroup2", cgroup_path, sizeof(cgroup_path));
 	if (!retval) {
@@ -818,16 +819,18 @@ static int open_cgroup_procs(const char *cgroup)
 		return -1;
 	}
 
+	cg_path_len = strlen(cgroup_path);
+
 	if (!cgroup) {
-		retval = get_self_cgroup(&cgroup_path[strlen(cgroup_path)],
-				sizeof(cgroup_path) - strlen(cgroup_path));
+		retval = get_self_cgroup(&cgroup_path[cg_path_len],
+				sizeof(cgroup_path) - cg_path_len);
 		if (!retval) {
 			err_msg("Did not find self cgroup\n");
 			return -1;
 		}
 	} else {
-		snprintf(&cgroup_path[strlen(cgroup_path)],
-				sizeof(cgroup_path) - strlen(cgroup_path), "%s/", cgroup);
+		snprintf(&cgroup_path[cg_path_len],
+				sizeof(cgroup_path) - cg_path_len, "%s/", cgroup);
 	}
 
 	snprintf(cgroup_procs, MAX_PATH, "%s/cgroup.procs", cgroup_path);
-- 
2.52.0


