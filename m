Return-Path: <bpf+bounces-39047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF67696E16B
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C39D287139
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB31179967;
	Thu,  5 Sep 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj3jh+D0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495547464;
	Thu,  5 Sep 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559263; cv=none; b=a+K1BLV6CnrGeAM4PPMSTTqyxbM27G0f8CZ4OtQAOS0OQUZFa6Fs1itT1w4fUmmSxfAL0NovXBZx1codCxqdVMV6+OV0JR8womf6vw9+w9jWgxZiz/45FKmIZbo9MDf3Z4pDtwCL8Q+QpwYCjxLGg+aeooog1qDcxWltg2v1lG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559263; c=relaxed/simple;
	bh=zJ8GsSFyOKwFoRTc/PIB6h5ujpC6wCdOq68z/pqAI1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k40DsX5/nfOg8poNEJHXwKLLfSIPFHuMvzv6C7TJiOB6ujvNsOJ3pqLQ7WSSW7pXAdW2VEwe0mnLFLP7xpSRGvnFfUHLdbnI5Tp7aWMhDNpa7oj8oESCphMboAbCku3gFZ/ONZJwghuMkvRoVx/4hgE4l+ozc6V0mJAqenH6Agw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj3jh+D0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67DAC4CEC3;
	Thu,  5 Sep 2024 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725559262;
	bh=zJ8GsSFyOKwFoRTc/PIB6h5ujpC6wCdOq68z/pqAI1U=;
	h=From:To:Cc:Subject:Date:From;
	b=dj3jh+D0kHyX4Sk/5s7vOAbK2Fw6VTTdl4Yb1n5o250MRfAgeXJy9mcZPLhzjN0n0
	 q+Lq6nirZJXj5EHHl4IYFXWs4HbuWg1M+MG6+8kl6kelRDJD/mSa1VqW164ZG7yLFL
	 NOgukOm3aZqDNKxR8Gm0qHSPOuvj1rFDmPl4IXxLAixpZ8cwITbIBsoR1KgWEM6YXy
	 CIzx8W/Y4swwFQ1QE5KPJBnGVO3zDHr1/KSn+SiQiW96+7wkGlqlFLN6uHPMpts/Q+
	 kmKyj9tr3sT0eGk1dwDuXO3DEZ4dv9VHAiIm/ruqQ1EDck4NG6ETwhBPDo4x5i9Y/O
	 d9TA0P8idK95g==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-perf-users@vger.kernel.org,
	peterz@infradead.org,
	kan.liang@linux.intel.com
Cc: x86@kernel.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	acme@kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86: fix wrong assumption that LBR is only useful for sampling events
Date: Thu,  5 Sep 2024 11:00:55 -0700
Message-ID: <20240905180055.1221620-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's incorrect to assume that LBR can/should only be used with sampling
events. BPF subsystem provides bpf_get_branch_snapshot() BPF helper,
which expects a properly setup and activated perf event which allows
kernel to capture LBR data.

For instance, retsnoop tool ([0]) makes an extensive use of this
functionality and sets up perf event as follows:

	struct perf_event_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.size = sizeof(attr);
	attr.type = PERF_TYPE_HARDWARE;
	attr.config = PERF_COUNT_HW_CPU_CYCLES;
	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
	attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL;

Commit referenced in Fixes tag broke this setup by making invalid assumption
that LBR is useful only for sampling events. Remove that assumption.

Note, earlier we removed a similar assumption on AMD side of LBR support,
see [1] for details.

  [0] https://github.com/anakryiko/retsnoop
  [1] 9794563d4d05 ("perf/x86/amd: Don't reject non-sampling events with configured LBR")

Cc: stable@vger.kernel.org # 6.8+
Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9e519d8a810a..f82a342b8852 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3972,7 +3972,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			x86_pmu.pebs_aliases(event);
 	}
 
-	if (needs_branch_stack(event) && is_sampling_event(event))
+	if (needs_branch_stack(event))
 		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
 
 	if (branch_sample_counters(event)) {
-- 
2.43.5


