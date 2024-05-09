Return-Path: <bpf+bounces-29216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933468C145A
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C408F1C20D6D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A07710D;
	Thu,  9 May 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L3Q9k74s"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83D77108
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277053; cv=none; b=hl01PKxbAHmA8NNvfHVJaPAqtfYpd5kWSipPEaPwhN3FitcP0XLA/SRrNCtxg9Rj6ftrx7Ag3vjSN/4yte1xaQK4Oo6P4VNO08UM10T/QYB4IBHwW2JESfYNbbPE4Yy/twQkrKSjXN5qJyjPmFtNSKki7ecUDVz85oyUPozCzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277053; c=relaxed/simple;
	bh=r9pZSEX3ysUCtf+mqFnFD1TNSlC0pNaA9T6n/6Fssus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3V74iMRjY4NX5hC4XLvmS7Eg1/pGCdRSmvJC4qrbdgLc0rt81JM3gIrh/f30zEfrVnvsbvSDpoB+RC3I5NYMVXxsAwRex5G0HTlFSsu/L7ofHSaCe9FlmD68td0S9ysz86zdK2oVSCRH4sg8Y+WWbOZj8Whoxr6stxvwBbFTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L3Q9k74s; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lFczV4bTXgbYPCPtCxMIYeiKWxVc40yaoMdtCu/MEI=;
	b=L3Q9k74sdsreDfZmOnkzn3iGcZnwUfU7nf0QJkZ7s6t1Je79umlFoGYAau8lhZcFuybBKo
	BkMT0BodoevYlLoD3KMD9tYmxmRpmvo7VuIJCLxwSx1EYHRZViRFAvNnPbO0ljrGe0DnQi
	0i686EJ4a/RkbwJPr51s4Airz1838FE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 08/10] selftests/bpf: Remove bpf_tcp_helpers.h usages from other misc bpf tcp-cc tests
Date: Thu,  9 May 2024 10:50:24 -0700
Message-ID: <20240509175026.3423614-9-martin.lau@linux.dev>
In-Reply-To: <20240509175026.3423614-1-martin.lau@linux.dev>
References: <20240509175026.3423614-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch removed the final few bpf_tcp_helpers.h usages
in some misc bpf tcp-cc tests and replace it with
bpf_tracing_net.h (i.e. vmlinux.h)

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_dctcp_release.c | 7 +------
 tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c     | 5 +----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c b/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
index a946b070bb06..c91763f248b2 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp_release.c
@@ -1,14 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
 
-#include <stddef.h>
-#include <linux/bpf.h>
-#include <linux/types.h>
-#include <linux/stddef.h>
-#include <linux/tcp.h>
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "GPL";
 const char cubic[] = "cubic";
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c b/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
index 633164e704dd..8a7a4c1b54e8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/bpf.h>
-#include <linux/types.h>
-#include <bpf/bpf_helpers.h>
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_tracing.h>
-#include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "X";
 
-- 
2.43.0


