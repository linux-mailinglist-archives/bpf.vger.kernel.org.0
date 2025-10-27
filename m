Return-Path: <bpf+bounces-72400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF42DC11FFF
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93576500C3B
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F432D0E0;
	Mon, 27 Oct 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xew2qL4G"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACA63321CE
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607359; cv=none; b=O8odkRs2pOBzTYUuxSvlX31hyVETp1SnCCNQ3m3XiLNXEb85zLXIoX8OQgKw1b3+h2ZDPuXpcMhUEe3b3kFwmfIVtBQDNqMAt1/3bht0rvC8c/W3ZlVZwx7HLu8f+jJXPSF2tma1zATF0+6/MbdXBaxxnxCYf1hrEmhzfVSgoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607359; c=relaxed/simple;
	bh=+QFr8S/MP8ZlR/XqFWOIMCyq8BfKBKR3X4Zblr91oUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lY87pcKjnRSoChAanFx4TBWLdqKINaytE7hH9h+HPjcPmhADbfq9bOKxgwHllxjgvyOf890wgJe6en8JdVgYHDDBuacfCXc92CMmh1QEMkWJwVtApDgE4iqDpnlnKMPUDCSrXuJJFWTbF0oHm1E+Q2mfA7T18q5AvvZuPMqqhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xew2qL4G; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdK0aCR8A07YZRsNoWuzLvR86FzrKXgk6tVODaQUgqs=;
	b=Xew2qL4G/tWdDy6CNgxiCYnwBMK9DK6KFVqIAnXSBNQMYcs3G7gG9nbce81eK/BwtmDDHc
	g+tN4YMVvDQt2CbI07LM4/eh0MNyo3y+aC1NPAyKQt/wUHU72S6D4umO0NRYt9Tq1AvzqQ
	1ka9AhsBKnJgbN2AZ7/PFQf5ARhmIrY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 15/23] mm: introduce bpf_task_is_oom_victim() kfunc
Date: Mon, 27 Oct 2025 16:21:58 -0700
Message-ID: <20251027232206.473085-5-roman.gushchin@linux.dev>
In-Reply-To: <20251027232206.473085-1-roman.gushchin@linux.dev>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Export tsk_is_oom_victim() helper as a BPF kfunc.
It's very useful to avoid redundant oom kills.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/oom_kill.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 72a346261c79..90bb86dee3cf 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1397,11 +1397,25 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
 	return ret;
 }
 
+/**
+ * bpf_task_is_oom_victim - Check if the task has been marked as an OOM victim
+ * @task: task to check
+ *
+ * Returns true if the task has been previously selected by the OOM killer
+ * to be killed. It's expected that the task will be destroyed soon and some
+ * memory will be freed, so maybe no additional actions required.
+ */
+__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
+{
+	return tsk_is_oom_victim(task);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_oom_kfuncs)
 BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_out_of_memory, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_is_oom_victim, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_oom_kfuncs)
 
 BTF_SET_START(bpf_oom_declare_oom_kfuncs)
-- 
2.51.0


