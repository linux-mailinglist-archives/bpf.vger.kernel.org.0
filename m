Return-Path: <bpf+bounces-77958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 917BACF8A2D
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCFB330FE0B0
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05451346E70;
	Tue,  6 Jan 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZumnRRX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268C33A9C4
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707348; cv=none; b=m5rbaemYt2QSFWJ6LRne5utDaaPnS7gEQgX9BV3BDhysaXmYOistv8vc1gkjeellEbwGEV8zpJNzpJl7kRUFqdNDfICKiZ53tBUxk0tr2I3YA4owECo5wwG5jKfmtp1O7TCfVwamU8uS3EXMirHTU3apAdyJ3eK7qkXT6DTVGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707348; c=relaxed/simple;
	bh=khr4HXouOlKmupfOwr1RNYMaHRidP4N+XAnyKcMrmB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgh5A2LvsXqxZ7fd91pkFJv9ZXyvpMH3shearQPwQPkIAMv9GT0/PHOsNkc7HDzVba/GAxoQT9AZn9+ZkipzCcPTn4EQUmXAiOqEmXn52uhuEbODNad0e61RYPdL8pzI+BU9PPONJYv42PNL/06VWqvlxro/boIdm5L2IbMyFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZumnRRX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Km5rA7vjuSWs0NIc9MqaKbnKolitv5jNiI4g81bW+B4=;
	b=XZumnRRX6/8C886DOhnY1olrsjgvOSPc5Inf4yHRoemtxk9ycseAXRtwsCsNY1tu69dni8
	pFQcDA0MFzY/2y1nDl5qbvS9hG2Z/eUMRIOYAy8vvYETDcnR6Qkz+v2Afz7EdBDEONn3jA
	EWM3j7lWExfSynUYTCIyM6jG0TTn5GQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-ES6CsnRGPX2AIcy5TtcRvw-1; Tue,
 06 Jan 2026 08:49:03 -0500
X-MC-Unique: ES6CsnRGPX2AIcy5TtcRvw-1
X-Mimecast-MFC-AGG-ID: ES6CsnRGPX2AIcy5TtcRvw_1767707342
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 083B81801207;
	Tue,  6 Jan 2026 13:49:02 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A3181800576;
	Tue,  6 Jan 2026 13:48:57 +0000 (UTC)
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
Subject: [PATCH v2 18/18] rtla: Simplify code by caching string lengths
Date: Tue,  6 Jan 2026 08:49:54 -0300
Message-ID: <20260106133655.249887-19-wander@redhat.com>
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
index 092fcab77dc4c..223ab97e50aed 100644
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
index 4093030e446ab..aee7f02b1e9b4 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -870,6 +870,7 @@ int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
 	DIR *procfs;
 	int retval;
 	int cg_fd;
+	size_t cg_path_len;
 
 	if (strlen(comm_prefix) >= MAX_PATH) {
 		err_msg("Command prefix is too long: %d < strlen(%s)\n",
@@ -883,16 +884,18 @@ int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
 		return 0;
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
 			return 0;
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


