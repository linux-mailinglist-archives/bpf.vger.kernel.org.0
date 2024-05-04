Return-Path: <bpf+bounces-28563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A339C8BB900
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 02:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CEC283842
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DC1103;
	Sat,  4 May 2024 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gc+Q3ojv"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE71A34
	for <bpf@vger.kernel.org>; Sat,  4 May 2024 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783859; cv=none; b=PVVPpa874LdC/jXfhZFMQCwvo+2L/bWROAanAKQtRdO3qQLtli4YruCyZPAwri7bNt98FAfnSO2MhPsiuQ/6HiLGSFAQYxRrKAZ9y/umlkcy2TjzraYPjja1tSGNxSi5Nj1Z0kd8daJ70RJ4MUsyr+GtolxrWmsQBkwo47t/A5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783859; c=relaxed/simple;
	bh=2+ROFbIVqjU/GO9tT6Rf5nvABujjW9h8vCDroZJIyw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBo4tMi7FL2d2oLdVxe79QVreYGExtD/86NxxgXGM8FIBHjkJuspIAomYIJnWUAD+ThIi+uryAvklIwMHCkiJWfZBKUVCtvF46zsfNV7mxp6VsVBaAMsNp52pJBgWKCDefRt4V3/WXWDXA7mSJLWvOsVCoEYRH0Kfv/tBgyr1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gc+Q3ojv; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714783854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oebQoLc9vnWtP+HRuk1pU3ehvakUKyPlZDyt2VjbVjY=;
	b=Gc+Q3ojvsN0mvjeolQ+/EayJSMlsriTQ5CCryRl/1Wgc9gNDqjqaZcO3bYfLSM/N+OhF4R
	KX85ILBTAuPt/hZUNNMavSGGyxkiI3eKzLYF1/tHSP9151b7QwCNPS7LYrSCsrqZYQt/hY
	TooCAPfCeT8Ia/IrF+IGu8ZHr8eAKu8=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Use bpf_tracing.h instead of bpf_tcp_helpers.h
Date: Fri,  3 May 2024 17:50:45 -0700
Message-ID: <20240504005045.848376-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf programs that this patch changes require the BPF_PROG macro.
The BPF_PROG macro is defined in the libbpf's bpf_tracing.h.
Some tests include bpf_tcp_helpers.h which includes bpf_tracing.h.
They don't need other things from bpf_tcp_helpers.h other than
bpf_tracing.h. This patch simplifies it by directly including
the bpf_tracing.h.

The motivation of this unnecessary code churn is to retire
the bpf_tcp_helpers.h by directly using vmlinux.h. Right now,
the main usage of the bpf_tcp_helpers.h is the partial kernel
socket definitions (e.g. socket, sock, tcp_sock). While the test
cases continue to grow, fields are kept adding to those partial
socket definitions (e.g. the recent bpf_cc_cubic.c test which
tried to extend bpf_tcp_helpers.c but eventually used the
vmlinux.h instead).

The idea is to retire bpf_tcp_helpers.c and consistently use
vmlinux.h for the tests that require the kernel sockets. This
patch tackles the obvious tests that can directly use bpf_tracing.h
instead of bpf_tcp_helpers.h.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/progs/timer.c            | 3 ++-
 tools/testing/selftests/bpf/progs/timer_failure.c    | 2 +-
 tools/testing/selftests/bpf/progs/timer_mim.c        | 2 +-
 tools/testing/selftests/bpf/progs/timer_mim_reject.c | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index f615da97df26..4c677c001258 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -2,9 +2,10 @@
 /* Copyright (c) 2021 Facebook */
 #include <linux/bpf.h>
 #include <time.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 struct hmap_elem {
diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/testing/selftests/bpf/progs/timer_failure.c
index 0996c2486f05..5a2e9dabf1c6 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -5,8 +5,8 @@
 #include <time.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-#include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/timer_mim.c b/tools/testing/selftests/bpf/progs/timer_mim.c
index 2fee7ab105ef..50ebc3f68522 100644
--- a/tools/testing/selftests/bpf/progs/timer_mim.c
+++ b/tools/testing/selftests/bpf/progs/timer_mim.c
@@ -4,7 +4,7 @@
 #include <time.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 struct hmap_elem {
diff --git a/tools/testing/selftests/bpf/progs/timer_mim_reject.c b/tools/testing/selftests/bpf/progs/timer_mim_reject.c
index 5d648e3d8a41..dd3f1ed6d6e6 100644
--- a/tools/testing/selftests/bpf/progs/timer_mim_reject.c
+++ b/tools/testing/selftests/bpf/progs/timer_mim_reject.c
@@ -4,7 +4,7 @@
 #include <time.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 struct hmap_elem {
-- 
2.43.0


