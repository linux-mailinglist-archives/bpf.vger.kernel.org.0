Return-Path: <bpf+bounces-49718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A396A1BE33
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 23:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84346188E5C2
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B71DD866;
	Fri, 24 Jan 2025 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/k3vbFX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FCDFBF6;
	Fri, 24 Jan 2025 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756041; cv=none; b=DUpsz1i9GZhPwgAg9n+SY6FphjmUWDYKhorWK383c8JTFdEsjeWlnW5BkXJx6W4BAna8JTBXcfyCm2b7M3gr8bZKEZmLM55i7URMcUZkgz8wGAIFXP+sEXV7oxkdpyhxWypJ3h/lXhIIaA/QoCCu5ltUPl/TF4YDAjFofu0CkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756041; c=relaxed/simple;
	bh=v9VM+3C98uJIVoSYEiK2KIhp/tWbOfo46XIEjx7fjdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7Pu+TuAiU87cHTVsWjZd5kZxpEbdnbbCZgUfU0YOhXKm6uI8kk5aQK/Tvb0vd8AyoPcyhOf7wr3eSd0Hu34xCtaFc7YA3UWp40OjkE7oQayiTJmwgYBqnTWqKpDM6XovFDsLioq7hecy9UQl/H8sLse1bC7ZJrQOAGVkM4Xfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/k3vbFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE2CC4CED2;
	Fri, 24 Jan 2025 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737756039;
	bh=v9VM+3C98uJIVoSYEiK2KIhp/tWbOfo46XIEjx7fjdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/k3vbFXyAB+ydcTjTnO33djsPZSBxBL9cDo/rpqbrXv2PqX4lm1xxu7CK4lWSDhU
	 foV8ZiTbxcW/Nri1DEKxkoeQ1GajnutnFyMm9tMG+Ny+6MDpZniQ199sRaZL5PKP8R
	 6mtATvDXb9lxuA99AEyPg8hTXLYlq4j+UCrGYSRLZr8M2fYr5SU0rm65X8oGuvXWXD
	 2Enlsr5xYcDgI+zbGFKZSG6Hlmlwl6F0/PqEGhJbmqb8mbAo1YD3QxxkqS6efAELsq
	 oB/WLGQh2UfNTLLd+Hv6wXljy2dL5dNGHjPxl4A0uYvWztSWYaiWAGzk+leFxSiH6l
	 /3jBureaRC7xQ==
Date: Fri, 24 Jan 2025 12:00:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: [PATCH sched_ext/for-6.14-fixes] sched_ext: selftests/dsp_local_on:
 Fix sporadic failures
Message-ID: <Z5QNhsWw0P1iPd2q@slm.duckdns.org>
References: <Z2MV001RfiG7DNqj@slm.duckdns.org>
 <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
 <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
 <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
 <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
 <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
 <Z5IOpOD9cs2fLaIg@gpd3>
 <Z5J1Ft2YwSRpedzx@slm.duckdns.org>
 <Z5KOLqwLq96HjkwH@gpd3>
 <Z5LCHVHZPl2fjPyc@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5LCHVHZPl2fjPyc@gpd3>

From e9fe182772dcb2630964724fd93e9c90b68ea0fd Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 24 Jan 2025 10:48:25 -1000

dsp_local_on has several incorrect assumptions, one of which is that
p->nr_cpus_allowed always tracks p->cpus_ptr. This is not true when a task
is scheduled out while migration is disabled - p->cpus_ptr is temporarily
overridden to the previous CPU while p->nr_cpus_allowed remains unchanged.

This led to sporadic test faliures when dsp_local_on_dispatch() tries to put
a migration disabled task to a different CPU. Fix it by keeping the previous
CPU when migration is disabled.

There are SCX schedulers that make use of p->nr_cpus_allowed. They should
also implement explicit handling for p->migration_disabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>
---
Applying to sched_ext/for-6.14-fixes. Thanks.

 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index fbda6bf54671..758b479bd1ee 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -43,7 +43,7 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
 	if (!p)
 		return;
 
-	if (p->nr_cpus_allowed == nr_cpus)
+	if (p->nr_cpus_allowed == nr_cpus && !p->migration_disabled)
 		target = bpf_get_prandom_u32() % nr_cpus;
 	else
 		target = scx_bpf_task_cpu(p);
-- 
2.48.1


