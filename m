Return-Path: <bpf+bounces-39326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF68C971E8F
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3812830EB
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C15132464;
	Mon,  9 Sep 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWnzVZnU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE21BC49;
	Mon,  9 Sep 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897514; cv=none; b=n/y9pDjQyEmTbz8sG8nVMZLp0IHxsnC74m1y+WfFLCk3fhCR0m/ky2I8eW5UPc/X3n43CgHcL/pEMXaZA+J2QTxeh3rz1MUFinedmvFZzdM68465/JnfZsKhOIMFugbAcMI2rfhOoMvjNx/5gl29sLshDHw0igDl2yJC6cHZl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897514; c=relaxed/simple;
	bh=YD8Ll7S6aZmu4BO+6NGny7r/3U5u0DsKB8SRlzq2lgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SWJcFtt1jidAV6i6uvfKXrpAXcMOl2hR8bOwpANPfvpeH5jkjdj7jdTKw3eWPZ7RW4bN+sXRvwL0OTLJoLzd6s50eBhhVwo4pyAFVeoEqu1B2Kp/5cU7f9RsJZ5HFJfyeJ/cZ6VFpn8sh97VxAeqcD64z1K2OUx+0RUgQiIo94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWnzVZnU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725897508; x=1757433508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YD8Ll7S6aZmu4BO+6NGny7r/3U5u0DsKB8SRlzq2lgU=;
  b=fWnzVZnUIfUQFxnuGUjWC1EVD6vUldL3C4IN3Bd7r209nl1WnC1ajkZw
   W0kpfeNbB25FLtUJoDA7Aa8Snv/fF0Z2xfAz93tuxSX5bR+TkX8lhsUoD
   f9PyCpGKDas8zOV3qeS1HnpgoVCNdEKx3RHJRN4AFBUCHtOZEksuanqdV
   2m7vFpmxpP/Xx8HhCHpRxZTmvfEORSnd8T2u13svmFgHphsYahmKIzo35
   YrTDH+hIZ3AfAkz8Pa2TdoruAkA2F0Gd3lONXi/+meLTe/JHlEIAOdXYX
   WCrCx74MTvuL3lfmOZffjxMN4KKvc66c7x0Hc3HLkuh7W1XdCNdON8Lpv
   g==;
X-CSE-ConnectionGUID: lKG6Wbi5QXCXyW5hy1uEHg==
X-CSE-MsgGUID: xNQb4RKJSFyn+9ck90R8Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="47123196"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="47123196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:58:28 -0700
X-CSE-ConnectionGUID: 08EI6PZvQIyHf5KOLhRYtA==
X-CSE-MsgGUID: 0bHNA+1sSFC9nQ4F/zrvMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="71500936"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 09 Sep 2024 08:58:28 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kernel-team@meta.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Allow to setup LBR for counting event for BPF
Date: Mon,  9 Sep 2024 08:58:48 -0700
Message-Id: <20240909155848.326640-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The BPF subsystem may capture LBR data on a counting event. However, the
current implementation assumes that LBR can/should only be used with
sampling events.

For instance, retsnoop tool ([0]) makes an extensive use of this
functionality and sets up perf event as follows:

	struct perf_event_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.size = sizeof(attr);
	attr.type = PERF_TYPE_HARDWARE;
	attr.config = PERF_COUNT_HW_CPU_CYCLES;
	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
	attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL;

To limit the LBR for a sampling event is to avoid unnecessary branch
stack setup for a counting event in the sample read. Because LBR is only
read in the sampling event's overflow.

Although in most cases LBR is used in sampling, there is no HW limit to
bind LBR to the sampling mode. Allow an LBR setup for a counting event
unless in the sample read mode.

Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag")
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Closes: https://lore.kernel.org/lkml/20240905180055.1221620-1-andrii@kernel.org/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 605ed19043ed..2b5ff112d8d1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3981,8 +3981,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			x86_pmu.pebs_aliases(event);
 	}
 
-	if (needs_branch_stack(event) && is_sampling_event(event))
-		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	if (needs_branch_stack(event)) {
+		/* Avoid branch stack setup for counting events in SAMPLE READ */
+		if (is_sampling_event(event) ||
+		    !(event->attr.sample_type & PERF_SAMPLE_READ))
+			event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	}
 
 	if (branch_sample_counters(event)) {
 		struct perf_event *leader, *sibling;
-- 
2.38.1


