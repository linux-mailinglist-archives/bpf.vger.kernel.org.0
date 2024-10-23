Return-Path: <bpf+bounces-42851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5A9ABA68
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E8F284F1E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF417753;
	Wed, 23 Oct 2024 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh0fM182"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE65D27E;
	Wed, 23 Oct 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642172; cv=none; b=DDGoaw05lQ7DonV/v6tdoDVcC5vuEvNfmG8gSScJBXK5u3dml+BlGIG0x4nGqzhl+bzS7o2U/OF3xyGXLwtZbs5vuIBNqL+d7cO0wMWqLN5cdgjme+ZW7v5tGvGvfeZANPMAgSepgF8ZGBIps3k/AGg3GvDqYkrOAzqM20nIeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642172; c=relaxed/simple;
	bh=PKH4Jgsz//Q/of6iS1YGe153y5OqAJsRm7bX4nqyHko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucgrau9lyuyPU+eBSPbcI8DP5Op1v1+qZEZEFRTjr75O2B71c2RvtfDGcZJ+VArnHi6uw8WvLLS33fzzZYBTpCAiCEAMbUZNbwKLrZTqx57uW16rXfVFQwQDtaXtT25NehBJCU9s+Njr+yd31zd4RwrvLHP3S3NOe4ouDa4p3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh0fM182; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F349DC4CECD;
	Wed, 23 Oct 2024 00:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729642171;
	bh=PKH4Jgsz//Q/of6iS1YGe153y5OqAJsRm7bX4nqyHko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rh0fM182/aJDP8EyWTODmgWd748o++4ysFpRNbTKxu1I70JLyjtyCBbX/jyshjnXm
	 4fc9mWye5Jn+ADUKcSY9ESrTA+2Nk2wDAwnUaJdOm+3oXOlIWFKColC1hCfmQ2ZICb
	 Xt0iiHC7Zak2fBw7VfG2zhq2trYS1BR4XI5oVj19XbWhHMhx1McEIRNPCWg/FlGni9
	 rPAkY24w6kmD2MdFTz+9yn3a/2OT459ORjlu5FORfPEuFaI05GpIah3MfiXodJe54o
	 qoMqEDkXIi0j9ciIoKgpDkcntwPJV83AcXjrJ2zt+RROsODATUX44G8+MBVZTSSPbM
	 QnF59rcV2l1Vg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Kyle Huey <me@kylehuey.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH v4 3/5] perf/core: Account dropped samples from BPF
Date: Tue, 22 Oct 2024 17:09:26 -0700
Message-ID: <20241023000928.957077-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241023000928.957077-1-namhyung@kernel.org>
References: <20241023000928.957077-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like in the software events, the BPF overflow handler can drop samples
by returning 0.  Let's count the dropped samples here too.

Acked-by: Kyle Huey <me@kylehuey.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5d24597180dec167..b41c17a0bc19f7c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9831,8 +9831,10 @@ static int __perf_event_overflow(struct perf_event *event,
 	ret = __perf_event_account_interrupt(event, throttle);
 
 	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
-	    !bpf_overflow_handler(event, data, regs))
+	    !bpf_overflow_handler(event, data, regs)) {
+		atomic64_inc(&event->dropped_samples);
 		return ret;
+	}
 
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
-- 
2.47.0.105.g07ac214952-goog


