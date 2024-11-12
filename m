Return-Path: <bpf+bounces-44579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DFA9C4C98
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 03:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF71B288D8
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9C205E00;
	Tue, 12 Nov 2024 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DcH0CnzE"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940B4C91
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378533; cv=none; b=qePhAuQMkmU3+/hf8E4ST03epQTwQ8AzPmIohM/6vzQhroMzFM6W71ovCKl/QEPfLFUXuL46Q22og41g8ORNBnfSWM3tNZVrvDUbPYcFwQ8+X+5DB+QKZ+LUlV/a8i+MbYUI5qPOcGqoISJHbFW2q89ow4c2uLmgXLZqxvVfFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378533; c=relaxed/simple;
	bh=WNzIMDWQdxkcsvqN3S+237dyecY9CfJTYr/6Ew976Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q4RprQbgIKR5Vmwob7dIV5/pHm8LV5ZFihDVGg+6PjwYPa9wm8jsxbeZDdFGABNZas8Ptc5eowzL1SQ1T4Zo1BELIn4Ce3vOjoPeF7CbAwUX9juUQEztYod3NE42bz6BOE32IvVeAI/nzXAOXT8hGjsrNKkwPVtp0wBvA3dv/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DcH0CnzE; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731378529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ND5todS9J9CstKjvKk5frxUAvHZOaVKj6kMybP6v2zM=;
	b=DcH0CnzErClR0dSEkYzLHHr0JbD1GFA6aXQqwU5/TjQfdzAk+uF/vI0/qSwWfc82mU+sMY
	IQLonj1Sk2+Q3a/T6nQ3z/RTpxzQ3UA8i0ionhwUkqpdVKGUPlZd27ELxPHsHQLR3x51bH
	1TYKw/J1PePf9cISq8lI+fcq38bSzL4=
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
Subject: [PATCH] perf bpf-filter: Return -1 directly when pfi allocation fails
Date: Tue, 12 Nov 2024 10:28:15 +0800
Message-Id: <20241112022815.191201-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Directly return -1 when pfi allocation fails,
instead of performing other operations on pfi.

Fixes: 0fe2b18ddc40 ("perf bpf-filter: Support multiple events properly")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 tools/perf/util/bpf-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index e87b6789eb9e..34c8bf7e469e 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -375,7 +375,7 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	pfi = zalloc(sizeof(*pfi));
 	if (pfi == NULL) {
 		pr_err("Cannot save pinned filter index\n");
-		goto err;
+		return -1;
 	}
 
 	pfi->evsel = evsel;
-- 
2.25.1


