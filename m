Return-Path: <bpf+bounces-38949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045C96CD0F
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 05:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB2328229A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 03:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A5514F126;
	Thu,  5 Sep 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB1IBoEz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7703149E0E;
	Thu,  5 Sep 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505831; cv=none; b=RKkseVY+5nXFmTVnNTp1Yfe+QiJXWCqjR6Hfdn14MbyOEEUEr6g0P01ECwLhJq178zZLRblIAgzuy1WOvnLvvTA5gY0YgQEJD0cDx9hPhqwa02WRNMwMeLzq2ycaKqh0raanEYV5OuB/LIGyGsqSgtmi1ROAjDmxHhOdsCdiDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505831; c=relaxed/simple;
	bh=uqzF4+T6nDeU2anut/u2vTsVtQcSdsdNORWq/SfW8kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxlbQbRyeKFTd/tRKdwtYtiXQMIUWV34H6mhn1QO7PUXA7gPty4LEVY3kGHi9Pir0QzUQKSsd3etmmps8Jxw0Xbf2GMztGIf8s9nXbPjrUcKv2EBnKE+E7XIMudL/Mkr9uRCJ9BVjHBNxmvdCoitN/kcyMxcQbh1lo8vf4TbG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB1IBoEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA106C4CEC9;
	Thu,  5 Sep 2024 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725505830;
	bh=uqzF4+T6nDeU2anut/u2vTsVtQcSdsdNORWq/SfW8kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hB1IBoEzok+S2QmTY6Q7m3Yukj2kUxViVsaPCsxC4VtET2+3WHhAD3gs13HmjhPJs
	 KU1BjmW8ISgESz0te7/Ec1wjcALuSQBA1dXJTLZwYfODYPjZN2soesDVrwl+aqtGqq
	 3+5F1o+Lw3/1+xjTnNsz6sGFbEIwkzLIRqCn1OU4FHbuFtZj3+xw/EIUSyB009RVUW
	 77TiRbznY3/1UcaOrz6zMqu5TLxBr/DkdZL6sKeouO4xEaADwAoWNhqylxbniLAc63
	 7JUuvL1kg/v4hKT59iyHz75RMNj96bGKDj0i4ojFmXWVCk2pwusfclNjKPUDAMsgWN
	 C0taGYIFltZ1w==
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
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Kyle Huey <me@kylehuey.com>,
	bpf@vger.kernel.org
Subject: [PATCH 3/5] perf/core: Account dropped samples from BPF
Date: Wed,  4 Sep 2024 20:10:25 -0700
Message-ID: <20240905031027.2567913-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905031027.2567913-1-namhyung@kernel.org>
References: <20240905031027.2567913-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like in the software events, the BPF overflow handler can drop samples
by returning 0.  Let's count the dropped samples here too.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Kyle Huey <me@kylehuey.com>
Cc: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8250e76f63358689..ba1f6b51ea26db5b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9808,8 +9808,10 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
-	if (event->prog && !bpf_overflow_handler(event, data, regs))
+	if (event->prog && !bpf_overflow_handler(event, data, regs)) {
+		atomic64_inc(&event->dropped_samples);
 		return ret;
+	}
 
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
-- 
2.46.0.469.g59c65b2a67-goog


