Return-Path: <bpf+bounces-29864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BA88C7AC8
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3396E283673
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375F143C48;
	Thu, 16 May 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qFDMeKEP"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8006FD5
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878912; cv=none; b=TLFIuHIn0aDP3YXOgzCfPBYnLLGagJE6xOPLRHiTbhD2zdV+x2gDtuzD7Nl68v/0vmYUssYDTQRlVrMGF+A5KBshobUDpa59Lp4xhXXZedhGcmIByYu6yZ4IcFyWjUIomsDmA8UyRU1XuVvG+a0cwbiUTkM3pkcvow71t7zFIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878912; c=relaxed/simple;
	bh=ygB4SVJzckqkpu00QTrhIJGKfI0PulRTEPeBo/95ZZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZTbnJY9tD9H6SQJgq51OSJGL/2VjlvJFFg8umxEg6ywQkLSotzmvFxKc3hCeA+/J1i2yMtWkcCXG1QbJa88xGQeA/kIn6qE27xVG/ED3VqsAAvhIYyar6fgw5G6KoQLx3+05wPnUjQX57h276xslBwKZz83lx9TaqqwrgMJLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qFDMeKEP; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715878908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pZYph7RE5HIsAUXY3qvtsCaYU7HEqasW33Bu9SsuqHA=;
	b=qFDMeKEPQVYO0DP5A7MRxjBrlk0ImAhCduFJPf2LbH8wYhn3GR/QtLyHzOIqTHM9qbjuy7
	31fkUD0RDSpb5Pqpv5K5XbDJI0WbZ2b83q40spFFdKg7wAWTJkO5Zvew6hSWGaRnNmLo61
	iaNH15fPHDzGcpbDiw3un/aGYMZthBE=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf] selftests/bpf: Adjust test_access_variable_array after a kernel function name change
Date: Thu, 16 May 2024 10:01:40 -0700
Message-ID: <20240516170140.2689430-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

After commit 4c3e509ea9f2 ("sched/balancing: Rename load_balance() => sched_balance_rq()"),
the load_balance kernel function is renamed to sched_balance_rq.

This patch adjusts the fentry program in test_access_variable_array.c
to reflect this kernel function name change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_access_variable_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_access_variable_array.c b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
index 808c49b79889..326b7d1f496a 100644
--- a/tools/testing/selftests/bpf/progs/test_access_variable_array.c
+++ b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
@@ -7,7 +7,7 @@
 
 unsigned long span = 0;
 
-SEC("fentry/load_balance")
+SEC("fentry/sched_balance_rq")
 int BPF_PROG(fentry_fentry, int this_cpu, struct rq *this_rq,
 		struct sched_domain *sd)
 {
-- 
2.43.0


