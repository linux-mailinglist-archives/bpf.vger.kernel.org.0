Return-Path: <bpf+bounces-43716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B929B8F2A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EA41C21068
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83261166F16;
	Fri,  1 Nov 2024 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnpEfCya"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9B158558
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456909; cv=none; b=W/9XzKfB51HQZHm+mPcy8Lau4L6kKS8mKhcXi5g35Wt3ONepM46DsvupFHTaQ+/DdlHkibN4pjIVJPJztiFtuA5hW/9TughF2ZOMlrXsWrEdo04b5miV1r7AMIfp7smGmw/U0XwiORxYc14a4M3MG/XXlznwRiuJRWtU+gHzFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456909; c=relaxed/simple;
	bh=A1X12V2liHng3a0bbBlpfNrA5XGY4s5u3oZ/EYt736k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agkqWPAd/SkUD/By9M5Sse151XrOGrPLcYI94p1zlHs96OIQ5xNSv5nQQ8+F5s1DqsftbNNyNBP/g74y6BxcxT1DNGFrqHFVq2lWnHiEJtCsOTUbkt2mkl4w+wD9YnMS4A9RPX+1dFanViua0UzYMt31HNHjD8OHMLjxqC350HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnpEfCya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730456905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c3CVAGPZaOmAJ9yE4G4knuMYwAw/VX1+cSI4HMGCRtM=;
	b=JnpEfCyaL78ztbAZtubtQtvKNh41VZr5Q2TgxC9M6LmPzMdvDURd2hEaDBLeO42w7CilRs
	CCwK9OonHnP26E9oCxVRu2VoWK6y5h51QSydWTaIsPqsHkABkCHSqhnhBBpb/Zh/V0STFe
	fK1e83huyZ7yhmg5fZfgMZhIzhVcblM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-jiaLstsGNP6_PyNZBaOlkA-1; Fri,
 01 Nov 2024 06:28:20 -0400
X-MC-Unique: jiaLstsGNP6_PyNZBaOlkA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C525F19560BD;
	Fri,  1 Nov 2024 10:28:18 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.39.208.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69A521956052;
	Fri,  1 Nov 2024 10:28:14 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	mingo@kernel.org,
	peterz@infradead.org,
	bpf@vger.kernel.org,
	vmolnaro@redhat.com
Subject: [PATCH] perf test stat_bpf_counters_cgrp: Remove cpu-list BPF counter test
Date: Fri,  1 Nov 2024 11:28:12 +0100
Message-ID: <20241101102812.576425-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The cpu-list part of this testcase has proven itself to be unreliable.
Sometimes, we get "<not counted>" for system.slice when pinned to CPUs
0 and 1. In such case, the test fails.

Since we cannot simply guarantee that any system.slice load will run
on any arbitrary list of CPUs, except the whole set of all CPUs, let's
rather remove the cpu-list subtest.

Fixes: a84260e314029e6dc9904fd ("perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test")

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index e75d0780dc78..2ec69060c42f 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -58,22 +58,9 @@ check_system_wide_counted()
 	fi
 }
 
-check_cpu_list_counted()
-{
-	check_cpu_list_counted_output=$(perf stat -C 0,1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
-	if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; then
-		echo "Some CPU events are not counted"
-		if [ "${verbose}" = "1" ]; then
-			echo ${check_cpu_list_counted_output}
-		fi
-		exit 1
-	fi
-}
-
 check_bpf_counter
 find_cgroups
 
 check_system_wide_counted
-check_cpu_list_counted
 
 exit 0
-- 
2.43.5


