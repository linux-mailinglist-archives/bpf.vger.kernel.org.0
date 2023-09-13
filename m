Return-Path: <bpf+bounces-9904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB279E880
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7132B280FB8
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF421A71C;
	Wed, 13 Sep 2023 13:00:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6933D6C
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 13:00:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6882A1989;
	Wed, 13 Sep 2023 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694610004; x=1726146004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SS5UdfEd5/aGjW95PuR1Hrc1ehfo5reasMr5Jb91wy0=;
  b=abDz9kzUWQ2kSs78Eu+X4vtTDYKdewXwQ4f83lRCbdq0qzG5xo74sORm
   JU//2HDLl7s1TqO7EhQyhKK8RrT3jIGNiijTSuaDL6NZVNf2M0EBsXVp0
   bbt0+TkIvbFDfpHM5zQHaiIQK4lv7/jB1ooIwWiPTz8kp/ZvDcvYIFDwi
   u8/+rFdawT4wQH7oxpk9qQJjL3CdF64BivVoUFelVwhOSolMJEc4xUI1Z
   tqgWr9kZ/TIGWi+Zvhv+wc1WM0twa55iPY4tyOKeTXabswx6l2E3wryZS
   0dL99OnYx9Ep7Q94vIYE6Akqrd6mFQcfdJjvy7UKe/tJ5Pzzvd+LNQPgQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="375983355"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="375983355"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 06:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="990908097"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="990908097"
Received: from asjackso-mobl2.amr.corp.intel.com (HELO tkristo-desk.intel.com) ([10.249.45.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:59:59 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: x86@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de
Cc: hpa@zytor.com,
	irogers@google.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	adrian.hunter@intel.com,
	acme@kernel.org,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexander.shishkin@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	peterz@infradead.org,
	mark.rutland@arm.com
Subject: [PATCHv2 2/2] perf/core: Allow reading package events from perf_event_read_local
Date: Wed, 13 Sep 2023 15:59:56 +0300
Message-Id: <20230913125956.3652667-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912124432.3616761-2-tero.kristo@linux.intel.com>
References: <20230912124432.3616761-2-tero.kristo@linux.intel.com>
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
v2:
  * prevent illegal array access in case event->oncpu == -1
  * split the event->cpu / event->oncpu handling to their own variables

 kernel/events/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41f11af..6b343bac0a71 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4425,6 +4425,9 @@ static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 {
 	u16 local_pkg, event_pkg;
 
+	if (event_cpu < 0 || event_cpu >= nr_cpu_ids)
+		return event_cpu;
+
 	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
 		int local_cpu = smp_processor_id();
 
@@ -4528,6 +4531,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 {
 	unsigned long flags;
 	int ret = 0;
+	int event_cpu;
+	int event_oncpu;
 
 	/*
 	 * Disabling interrupts avoids all counter scheduling (context
@@ -4551,15 +4556,22 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 		goto out;
 	}
 
+	/*
+	 * Get the event CPU numbers, and adjust them to local if the event is
+	 * a per-package event that can be read locally
+	 */
+	event_oncpu = __perf_event_read_cpu(event, event->oncpu);
+	event_cpu = __perf_event_read_cpu(event, event->cpu);
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
+	if (event->attr.pinned && event_oncpu != smp_processor_id()) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -4569,7 +4581,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
 	 * oncpu == -1).
 	 */
-	if (event->oncpu == smp_processor_id())
+	if (event_oncpu == smp_processor_id())
 		event->pmu->read(event);
 
 	*value = local64_read(&event->count);
-- 
2.40.1


