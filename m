Return-Path: <bpf+bounces-44715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503539C6792
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 04:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40FF1F219AB
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 03:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902C15F40B;
	Wed, 13 Nov 2024 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PjUyUbbD"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E7158214
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731467174; cv=none; b=lUBzybVheBiKsW5xXqgIZFNqcxNVNsNO3D4kHHAXPHGnhz3TZ1tvSUAt+hpZkggfJ9jE9SB+C+ruriKP0HI9v4kwwKWl/qeqz/QWzNnaYOlva2GgYQ4OFd4AopsHHKu36oKlpGQaWgId0Xu84jKIPSpZjKrQlfueKiSYP5pNDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731467174; c=relaxed/simple;
	bh=HjIDJZyHA+vT0bTOGrZ1p/Os6LF8fgM06c7pdNMcP9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+9sbYw7qg8x5RujjxPWMr0G+gAA0ElcjFuYqR1klzwp+QSW3f6m4XMovG38+NNrmldlhd1TF97WKKo9TcVpu4/h5qTaqKfzQN+yT4cD5X/jMKV7sDGA6MwbaQFHAKwZuG6lEJUZ2WgGlXj80cI79dS1r9EsQlpcaeB02eA8E48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PjUyUbbD; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731467169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14BsIB1O/hE+ocIdD64cCor+P5wffmchPARwiX2o8JQ=;
	b=PjUyUbbDx/4/NOFKTICKMXc2PccWOIMV2JCjwIAOM7gpNffTKJFenMndJ1KeX0zs/cFY7l
	RuXNOBP6+ouNwGJYGoFd96REwlQ0jwbH7uyvS/Ake4OXFgLni15DtzrjFcANWqvTdqavji
	B8UDekuT0R0NvKpY813nE81BxdUIuXw=
From: Hao Ge <hao.ge@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] perf bpf-filter: Return -ENOMEM directly when pfi allocation fails
Date: Wed, 13 Nov 2024 11:05:37 +0800
Message-Id: <20241113030537.26732-1-hao.ge@linux.dev>
In-Reply-To: <ZzOJOEpyAc92462-@x1>
References: <ZzOJOEpyAc92462-@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Directly return -ENOMEM when pfi allocation fails,
instead of performing other operations on pfi.

Fixes: 0fe2b18ddc40 ("perf bpf-filter: Support multiple events properly")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Replace -1 with -ENOMEM as per Arnaldo's reminder.
    Update title and commit message due to code change
---
 tools/perf/util/bpf-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index e87b6789eb9e..a4fdf6911ec1 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -375,7 +375,7 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	pfi = zalloc(sizeof(*pfi));
 	if (pfi == NULL) {
 		pr_err("Cannot save pinned filter index\n");
-		goto err;
+		return -ENOMEM;
 	}
 
 	pfi->evsel = evsel;
-- 
2.25.1


