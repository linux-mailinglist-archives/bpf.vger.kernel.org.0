Return-Path: <bpf+bounces-9747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B079D157
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045F21C20DD9
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8BC171CD;
	Tue, 12 Sep 2023 12:45:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24918F41
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 12:45:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEE610DC;
	Tue, 12 Sep 2023 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694522728; x=1726058728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QbKO5F53E+2iDJzfFlggemhEhBQc5+LlHD2g0rs4x5M=;
  b=FaPqQdqFuXkabTgD+bZEGM0fF3xI7ybQMmrPUtVzM34hR/GStlKQf2Ps
   rL2AxkGwppHczctvRUO/xbJMY2eIOCiEnCM6Xv5RqhDiKlwzcAxXSmLdo
   48uomb561rOMsSDZ890aYxrGgHKzgBbwUFFR5erkEBYyn34wY205NMhUA
   aRoj2d7IDRgPbsC6BdhJNSiHow3jI1bz+0Q39NXYFiovwmJ98SblStHGp
   8E1ICtAoOJ2MT1NCNCmW1t5uoSsRcTDn5xzga4VSzyIniarMJUdheiYTc
   Cuk/Arr29TpNvhdsTc5Be//O36Ca1VpyAq7/ZAZ+Z4BQvy2FoYPXtoohj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358638856"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358638856"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867352848"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="867352848"
Received: from srosalim-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.217.51])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:23 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: x86@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: irogers@google.com,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	hpa@zytor.com,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acme@kernel.org,
	peterz@infradead.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	namhyung@kernel.org,
	jolsa@kernel.org
Subject: [RESEND PATCH 2/2] perf/core: Allow reading package events from perf_event_read_local
Date: Tue, 12 Sep 2023 15:44:32 +0300
Message-Id: <20230912124432.3616761-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912124432.3616761-1-tero.kristo@linux.intel.com>
References: <20230912124432.3616761-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 kernel/events/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41f11af..780dde646e8a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4528,6 +4528,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 {
 	unsigned long flags;
 	int ret = 0;
+	int event_cpu;
 
 	/*
 	 * Disabling interrupts avoids all counter scheduling (context
@@ -4551,15 +4552,18 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 		goto out;
 	}
 
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
@@ -4569,7 +4573,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
 	 * oncpu == -1).
 	 */
-	if (event->oncpu == smp_processor_id())
+	if (event_cpu == smp_processor_id())
 		event->pmu->read(event);
 
 	*value = local64_read(&event->count);
-- 
2.40.1


