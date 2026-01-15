Return-Path: <bpf+bounces-79098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C88D2751A
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0E0032EFFD0
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E079D3D3481;
	Thu, 15 Jan 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BB/Z6PyK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB128725F
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498227; cv=none; b=XvUIbP6cKtKnc1XMeQYsviOhtRRCwr29L4kbqckY06N+WbEdPmV0/GZhH1vH5GePmWlyA/jcJAMpP6nuBfLLiGFscAHwAZPnBz5MVbVU97KYcIa/NW6+aek9DeYuNWBC3uNgQ6ypRBi3dQ+dU5VCiUvk21R+xQK7Uwh/JDju5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498227; c=relaxed/simple;
	bh=KoiAGygCsP7LdXIPJKl87sZsR/SSo6UkoSgUMxQy9Hc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhzqOWBtP5G12ZTYEehAws3WCejJQi3sC5DGneK/MmfM6Ima7Xn7w8/px7Phuvps3SQhQcJP6f/2OkiCZVADE28heeg9LgZAB26/Nijs5360dF4g1teM6Tf4AvS2exDQ4YNuKcI06dwfE9VDgIusPRXP72r9MtQsbDYvPvIEq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BB/Z6PyK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tu3p1Zj6pQY7Vz4/LZDPBl0XAGrdE37S9bZ1+G2txM=;
	b=BB/Z6PyKu+FGW+rMF20VH/t+PYYPe1QThrYvyYWj0k7G756qfoSJWrnC4eugj7cD7e1Irr
	+9mMF9ZPuNBW/JE5qHlNRDJIlY9LDw9iIFtyBkRIwaS9igYt2ChmbypQ+hRrQdjPjYqQH4
	nwVgQxI5ZufZFrAoZWmYl9lJp3UHfM8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-F7Y7gd1ZOAmofL9UcD7uvg-1; Thu,
 15 Jan 2026 12:30:22 -0500
X-MC-Unique: F7Y7gd1ZOAmofL9UcD7uvg-1
X-Mimecast-MFC-AGG-ID: F7Y7gd1ZOAmofL9UcD7uvg_1768498220
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A82EF19560B5;
	Thu, 15 Jan 2026 17:30:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 194AC1800285;
	Thu, 15 Jan 2026 17:30:15 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 18/18] rtla/utils: Fix loop condition in PID validation
Date: Thu, 15 Jan 2026 13:32:01 -0300
Message-ID: <20260115163650.118910-19-wander@redhat.com>
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

The procfs_is_workload_pid() function iterates through a directory
entry name to validate if it represents a process ID. The loop
condition checks if the pointer t_name is non-NULL, but since
incrementing a pointer never makes it NULL, this condition is always
true within the loop's context. Although the inner isdigit() check
catches the NUL terminator and breaks out of the loop, the condition
is semantically misleading and not idiomatic for C string processing.

Correct the loop condition from checking the pointer (t_name) to
checking the character it points to (*t_name). This ensures the loop
terminates when the NUL terminator is reached, aligning with standard
C string iteration practices. While the original code functioned
correctly due to the existing character validation, this change
improves code clarity and maintainability.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 1ea9980d8ecd3..3d47f3ed52dee 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -296,7 +296,7 @@ static int procfs_is_workload_pid(const char *comm_prefix, struct dirent *proc_e
 		return 0;
 
 	/* check if the string is a pid */
-	for (t_name = proc_entry->d_name; t_name; t_name++) {
+	for (t_name = proc_entry->d_name; *t_name; t_name++) {
 		if (!isdigit(*t_name))
 			break;
 	}
-- 
2.52.0


