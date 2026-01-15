Return-Path: <bpf+bounces-79097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69FD2683B
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0D603091BD1
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFE3D523B;
	Thu, 15 Jan 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVGpO59v"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304523D332D
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498206; cv=none; b=RXwwxze6QHAilQQwQooe1zSa2oFJsqTRFb2nBcbDYyyhCPwU448cNyxpHFqr/dPxVW8YwxYrEj1uo29zl9gNbRAexkX+Zsv05P/HROc6KzSsGc7KSepOeBUPVFo0B0hzxYW9OkYT+3IKpE2/gCHZrbux5GSH7YC7nOlcphTcsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498206; c=relaxed/simple;
	bh=pcZuVBEpKHuMkiFAbHRlsLm6TtFLtJutf7CGGP8HEhs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvQrCmdkM83NcjIgtQTseANRRQ24V19omYlxBCWudGwCe7Ba9wGk57Mt1FBnqN0ECc9d/DS9jnkIOxyE+ecz50CcOil4RLl1rOFzkaChyPmBzKgL9zd4f4K5r3czbP0AKB0Wiky1x0sGKBJM7zjtn8tu/RFIa8K85EEEeHaXiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVGpO59v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPVrOWC176arGNNcGQ7j00oHxNfVI2h958WatvwkW7A=;
	b=CVGpO59veqHZblEy0NNKuih1xygJ394siY/gbPO0hykKgY5Gog8NYz4mzaN5mTY+sFU4TW
	/JtP9lxPg5ZLczAw1ryRmmze2giD+1bt11FjtKak2cgc7YFIca5vzJmvWMBQGzpYJbKx7z
	BD6zOMlQz0ZEuR3DfaafgMPdGREfeuY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-xfMwIAJhMiSF0A-W9h2tGQ-1; Thu,
 15 Jan 2026 12:30:02 -0500
X-MC-Unique: xfMwIAJhMiSF0A-W9h2tGQ-1
X-Mimecast-MFC-AGG-ID: xfMwIAJhMiSF0A-W9h2tGQ_1768498201
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE91919560A3;
	Thu, 15 Jan 2026 17:30:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C874918004D8;
	Thu, 15 Jan 2026 17:29:55 +0000 (UTC)
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
Subject: [PATCH v3 17/18] rtla/utils: Fix resource leak in set_comm_sched_attr()
Date: Thu, 15 Jan 2026 13:32:00 -0300
Message-ID: <20260115163650.118910-18-wander@redhat.com>
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

The set_comm_sched_attr() function opens the /proc directory via
opendir() but fails to call closedir() on its successful exit path.
If the function iterates through all processes without error, it
returns 0 directly, leaking the DIR stream pointer.

Fix this by refactoring the function to use a single exit path. A
retval variable is introduced to track the success or failure status.
All exit points now jump to a unified out label that calls closedir()
before the function returns, ensuring the resource is always freed.

Fixes: dada03db9bb19 ("rtla: Remove procps-ng dependency")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index b029fe5970c31..1ea9980d8ecd3 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -362,22 +362,23 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
 
 		if (strtoi(proc_entry->d_name, &pid)) {
 			err_msg("'%s' is not a valid pid", proc_entry->d_name);
-			goto out_err;
+			retval = 1;
+			goto out;
 		}
 		/* procfs_is_workload_pid confirmed it is a pid */
 		retval = __set_sched_attr(pid, attr);
 		if (retval) {
 			err_msg("Error setting sched attributes for pid:%s\n", proc_entry->d_name);
-			goto out_err;
+			goto out;
 		}
 
 		debug_msg("Set sched attributes for pid:%s\n", proc_entry->d_name);
 	}
-	return 0;
 
-out_err:
+	retval = 0;
+out:
 	closedir(procfs);
-	return 1;
+	return retval;
 }
 
 #define INVALID_VAL	(~0L)
-- 
2.52.0


