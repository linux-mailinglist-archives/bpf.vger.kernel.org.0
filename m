Return-Path: <bpf+bounces-56508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F02A9959C
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B443BBB17
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F89284665;
	Wed, 23 Apr 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TeuGcN4E"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76556280CF8
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426373; cv=none; b=MAsGbEBTuMZVsio3MortKBAnMF+B9+Q6hw3utjtETcs9rFHqWBJXY41PhEyBYs8W8Kyb5CDoTyBJeZOFE8p0SOLLR2vI3gtbm82ylRRyBJDq1bnAQhzEEpmwC43VjeXUh/NpIr2R1VuEKsUQ0ohG6KPjSGNFBLQ5L4AeUzaJTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426373; c=relaxed/simple;
	bh=zimmtmD99dnKOyLRfPg8967hyoaxqnN7TpuZFvJE1AI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPdVAmCjOMh3qQywY91BukMg9j7ooruft2KNbJ+UYdq8YLRZkLnkE5PevuLpc3xpASbHYXv68Ibw8hHkL9h8Zr3HBl3WK29n5TaIKer5zfgcThCom25aplFF73ZNbSHGiKAkhVe4yMXyBHQbA7U0ChITqyoiJkrUrpgZIg8O7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TeuGcN4E; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745426367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4prA7EimAOb2F+VNMeXtULfXBkke0SBTV6754I0x+3g=;
	b=TeuGcN4Eifto+uSARFYL3HRAVc3zM6KG+WXqFy324+0jfPEfa/zr0zQ6nJ6PVOaiUs6vff
	idLXmyTH3DEWRYo8tmT/XHY5PLH5kyg0f3c5muKKJMKSQB3/9Su8COvK5g10mqy2NmWULf
	Z8VUXd/RtSdUykPOTbNHAz+Myql08AY=
From: Tao Chen <chen.dylane@linux.dev>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH bpf-next] libbpf: remove sample_period init in perf_buffer
Date: Thu, 24 Apr 2025 00:39:01 +0800
Message-Id: <20250423163901.2983689-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It seems that sample_period no used in perf buffer, actually only
wakeup_events valid about events aggregation for wakeup. So remove
it to avoid causing confusion.

Fixes: fb84b8224655 ("libbpf: add perf buffer API")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/lib/bpf/libbpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..1830e3c011a5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13306,7 +13306,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
 	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.sample_period = sample_period;
 	attr.wakeup_events = sample_period;
 
 	p.attr = &attr;
-- 
2.43.0


