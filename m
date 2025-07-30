Return-Path: <bpf+bounces-64695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C9AB15F7A
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6618C7B33
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81CC290D81;
	Wed, 30 Jul 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t87RExfG"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA5296153
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875059; cv=none; b=mdcKnHCcMXIMyclt52rRyQf4KUKoMnjk5WZUFLF/o3eR+lrvNYz4a1FoRP/fkDNrXsfLXbmyjhriGqmJZ+cTF8iut79QcUPcuL4vrW5m2sq91Pi6ySvQ0cMjfxdESmU0TDwZVg+LasK/gQAYVav1Rp1GhwSi/SpmY52BkyG5kGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875059; c=relaxed/simple;
	bh=1e0fzHuI/rntwQ57mo91TY0dA532PxuDhYaJ1EW9Fz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cF6OkQ/xvyOXNvih0HPb6c7W9S+h8hontgCZk5V/QHIIjl98vSsOjRLtlTiL9ZJ0w65KuvWkeCzjxrfgz4cIzD/2QRHncmxv/eorRcUBNrPFOD7zhUzCdfyLMxjc8S3sWCYlSEY6+y/kLSxFzDTPB/A4ZHg3JY2zhqj4JqR9gI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t87RExfG; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753875045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1tv44tN9Mkqwho1YUvMPXc0XtnufGsYHnhFM50s3ejw=;
	b=t87RExfGxDlCWLoEd8I2gjZws88G6p2YEPKi9fShkszQWsXN/hSW6fqe0lpFcQlxXhNorx
	RdVGllDZkaasdetDsGU8qYj12okMrA/msC2X7X1N9SvhGFOJGs9nAlQZAeBiDCR2K3Bk9E
	D3b2Q6nzIiqEF3lLHY/TcMPO8NxBmxA=
From: Tao Chen <chen.dylane@linux.dev>
To: rostedt@goodmis.org,
	bristot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 1/2] tools/latency-collector: Check pkg-config install
Date: Wed, 30 Jul 2025 19:30:27 +0800
Message-ID: <20250730113028.1666038-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The tool pkg-config used to check libtraceevent and libtracefs, if not
installed, it will report the libs not found, even though they have
already been installed.

Before:
libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel
libtracefs is missing. Please install libtracefs-dev/libtracefs-devel

After:
Makefile.config:10: *** Error: pkg-config needed by libtraceevent/libtracefs is missing
on this system, please install it.

Fixes: 9d56c88e5225 ("tools/tracing: Use tools/build makefiles on latency-collector")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/tracing/latency/Makefile.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
index 0fe6b50f029b..6efa13e3ca93 100644
--- a/tools/tracing/latency/Makefile.config
+++ b/tools/tracing/latency/Makefile.config
@@ -1,7 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+include $(srctree)/tools/scripts/utilities.mak
+
 STOP_ERROR :=
 
+ifndef ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
+  endif
+endif
+
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
   $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
-- 
2.48.1


