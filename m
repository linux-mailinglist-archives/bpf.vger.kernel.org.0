Return-Path: <bpf+bounces-77956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD7CF8A00
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E727630133B6
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEB9335BDB;
	Tue,  6 Jan 2026 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5eK66jL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B73346B2
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707271; cv=none; b=Ha41R82A1j3NY3PnkQoQhza7d76+fCmJTA63MWMot0eEnOokPLx5awTBXBg1xjqQzHau8KJ+SlzdKgJmxg83hqyIacLsKHD/zOWt9/6j6Oj4mRHyHKiA8frPzhNJNuqX0B+2kXSNJN7mxnTnzrhN5ZQUW2yfhjQzfg+hwXvwtao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707271; c=relaxed/simple;
	bh=X0mhfphzyzLPUFjrtvGZjqO0h8g5+dpKSw/dmcSM54k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOYtjPQWv0ZwvJDjeYx/lsb1Xbi+43sFH42mGbpx4uNsnZzZclGoQ+rAhmDT2kvsKumYxQOhZyyOr5tYKupnRXK74lRons+m20JfBMOcQPkmCpZsbCaJnOu8MVxBWHWD3VYnDgoKTl/ILXfu2LY6hdyUJN93y4S9xE969n1qlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5eK66jL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2PckU0JC5Ea9d4GrF2OBPBlpYWIkdOC3Apu6J3z5gQ=;
	b=P5eK66jLDIhtwubLs1VPTivaxePnM1lcsp45tp4JAqkBW1hyu2oxhEFwvr8yDRSnLITgu1
	mIoiYy+YfhhrLx6c4SGMPXBhR+rqG3mDaSWV662OlTMFXkpTZgxFjrYcib97R4LeaL17xF
	mbj8qz8Oo+TLssmv2VI1DApuf2YRO5c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-oRXwTd-_OTqtkSl4qfStLA-1; Tue,
 06 Jan 2026 08:47:44 -0500
X-MC-Unique: oRXwTd-_OTqtkSl4qfStLA-1
X-Mimecast-MFC-AGG-ID: oRXwTd-_OTqtkSl4qfStLA_1767707263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D0191956068;
	Tue,  6 Jan 2026 13:47:43 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42DE21800667;
	Tue,  6 Jan 2026 13:47:39 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 16/18] rtla: Ensure null termination after read operations in utils.c
Date: Tue,  6 Jan 2026 08:49:52 -0300
Message-ID: <20260106133655.249887-17-wander@redhat.com>
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

Add explicit null termination and buffer initialization for read()
operations in procfs_is_workload_pid() and get_self_cgroup() functions.
The read() system call does not null-terminate the data it reads, and
when the buffer is filled to capacity, subsequent string operations
will read past the buffer boundary searching for a null terminator.

In procfs_is_workload_pid(), explicitly set buffer[MAX_PATH-1] to '\0'
to ensure the buffer is always null-terminated before passing it to
strncmp(). In get_self_cgroup(), use memset() to zero the path buffer
before reading, which ensures null termination when retval is less than
MAX_PATH. Additionally, set path[MAX_PATH-1] to '\0' after the read to
handle the case where the buffer is filled completely.

These defensive buffer handling practices prevent potential buffer
overruns and align with the ongoing buffer safety improvements across
the rtla codebase.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index e0f31e5cae844..508b8891acd86 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -317,6 +317,7 @@ static int procfs_is_workload_pid(const char *comm_prefix, struct dirent *proc_e
 	if (retval <= 0)
 		return 0;
 
+	buffer[MAX_PATH-1] = '\0';
 	retval = strncmp(comm_prefix, buffer, strlen(comm_prefix));
 	if (retval)
 		return 0;
@@ -750,6 +751,7 @@ static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
 	if (fd < 0)
 		return 0;
 
+	memset(path, 0, sizeof(path));
 	retval = read(fd, path, MAX_PATH);
 
 	close(fd);
@@ -757,6 +759,7 @@ static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
 	if (retval <= 0)
 		return 0;
 
+	path[MAX_PATH-1] = '\0';
 	start = path;
 
 	start = strstr(start, ":");
-- 
2.52.0


