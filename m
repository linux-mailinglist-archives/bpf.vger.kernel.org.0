Return-Path: <bpf+bounces-9746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAE79D155
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C3D281CB5
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6857168D3;
	Tue, 12 Sep 2023 12:45:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41F8F41
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 12:45:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC110D8;
	Tue, 12 Sep 2023 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694522724; x=1726058724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fP06kTzAN8WOEYJEVv+7hMOrn0c51DQEva6ses5OiO4=;
  b=mSVLddfoR1X5CRBONCywrFJBzIJQRd7/H2DPJsCOKWUqQOd0bBc4SxXu
   46kGfZVjLsk4GDfPdO4aLrLlYrgY6oj5wrRPhiTGjKW6wRwV8jKrhSW+X
   MDnTO1RRz06fpH4HYiUdrfsato2PxUvBbf0JPysI5bIoxtTsS1/MOpGGV
   +BWx2LSpMS6BimRPmrkHnRt4bnOx6Q/YjKwOFvXeXNkbAHW1pgcLx6ozt
   Vlf6I4Wi8NR1/eybfyGq3VunQ1FPghiZtsvbe17AHdOxf1SCUdSRRjSXM
   hjJA8K/hAFufqauJKjHvQ4OODXJXq96b5tM0BWSGsTFlIuRDBZFpOefGs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358638834"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358638834"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867352818"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="867352818"
Received: from srosalim-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.217.51])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:18 -0700
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
	jolsa@kernel.org,
	Kan Liang <kan.liang@intel.com>
Subject: [RESEND PATCH 1/2] perf/x86/cstate: Allow reading the package statistics from local CPU
Date: Tue, 12 Sep 2023 15:44:31 +0300
Message-Id: <20230912124432.3616761-2-tero.kristo@linux.intel.com>
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

The MSR registers for reading the package residency counters are
available on every CPU of the package. To avoid doing unnecessary SMP
calls to read the values for these from the various CPUs inside a
package, allow reading them from any CPU of the package.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Suggested-by: Kan Liang <kan.liang@intel.com>
---
 arch/x86/events/intel/cstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 96fffb2d521d..cbeb6d2bf5b4 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -336,6 +336,9 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!(pkg_msr_mask & (1 << cfg)))
 			return -EINVAL;
+
+		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
+
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
 				      topology_die_cpumask(event->cpu));
-- 
2.40.1


