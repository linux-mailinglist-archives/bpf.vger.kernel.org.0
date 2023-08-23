Return-Path: <bpf+bounces-8344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A458785045
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 07:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3543C281282
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 05:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA86FBF;
	Wed, 23 Aug 2023 05:57:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EC6D24
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 05:57:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E77AA1;
	Tue, 22 Aug 2023 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692770276; x=1724306276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKQknWrLrf78uQf9GH3dL4JsbgZGq50+lfliSCkg8zA=;
  b=S1eMAawR1CuhekvdXBA8ICsq3Tw7WOPyTHCxiptBOJZXebBP9zH4dhD4
   mM/PHAAVfrzXSg1iMQa3VZdAo09aEp5lHbjDnLM1cLYJK/IdzHoRok4xh
   1724o3zm+T2eCl+ZVX0m6Ux2LH/UJVS4qTxTSBkTPjPGP0UuQVSasv0gs
   Br6U0epYiMPa27LpHiOfdrK1LirkyzZ/IbRZd/DwpVRJDpqhNaauAyXyV
   DI0InLpBu7hbpc9nav1J+yyz53qx9Gt7GqDyyBeEeiuTVzX7RMh6MpNJ0
   fBgNr5yZtwwNQtD3bU8QzBGMH/19OKvdQppAd56L9OldvqAXVqMm9MR3J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="438009784"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438009784"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 22:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="983140557"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="983140557"
Received: from ebold-mobl1.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.251.213.156])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 22:57:51 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	x86@kernel.org,
	bp@alien8.de
Cc: artem.bityutskiy@linux.intel.com,
	acme@kernel.org,
	bpf@vger.kernel.org,
	namhyung@kernel.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	hpa@zytor.com,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org
Subject: [PATCH 2/2] perf/core: Allow reading package events from perf_event_read_local
Date: Wed, 23 Aug 2023 08:56:53 +0300
Message-Id: <20230823055653.2964237-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823055653.2964237-1-tero.kristo@linux.intel.com>
References: <20230823055653.2964237-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Per-package perf events are typically registered with a single CPU only,
however they can be read across all the CPUs within the package.
Currently perf_event_read maps the event CPU according to the topology
information to avoid an unnecessary SMP call, however
perf_event_read_local deals with hard values and rejects a read with a
failure if the CPU is not the one exactly registered. Allow similar
mapping within the perf_event_read_local if the perf event in question
can support this.

This allows users like BPF code to read the package perf events properly
across different CPUs within a package.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 kernel/events/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 78ae7b6f90fd..37db7c003b79 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4528,6 +4528,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 {
 	unsigned long flags;
 	int ret = 0;
+	int event_cpu;
 
 	/*
 	 * Disabling interrupts avoids all counter scheduling (context
@@ -4551,15 +4552,19 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 		goto out;
 	}
 
+	/* Allow reading a per-package perf-event from local CPU also */
+	event_cpu = READ_ONCE(event->oncpu);
+	event_cpu = __perf_event_read_cpu(event, event_cpu);
+
 	/* If this is a per-CPU event, it must be for this CPU */
 	if (!(event->attach_state & PERF_ATTACH_TASK) &&
-	    event->cpu != smp_processor_id()) {
+	    event_cpu != smp_processor_id()) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	/* If this is a pinned event it must be running on this CPU */
-	if (event->attr.pinned && event->oncpu != smp_processor_id()) {
+	if (event->attr.pinned && event_cpu != smp_processor_id()) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -4569,7 +4574,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
 	 * oncpu == -1).
 	 */
-	if (event->oncpu == smp_processor_id())
+	if (event_cpu == smp_processor_id())
 		event->pmu->read(event);
 
 	*value = local64_read(&event->count);
-- 
2.25.1


