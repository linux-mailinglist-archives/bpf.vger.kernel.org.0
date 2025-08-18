Return-Path: <bpf+bounces-65906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327E4B2AEDD
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F674E0F6D
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190F7350853;
	Mon, 18 Aug 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c9BU2ZxZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD3350840
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536540; cv=none; b=BT59Nc2abpbFIlL6FIvsCrFfBToJCz33b5/FfaltJhm7R8kWlrSiwjMWue2Gag57Q9BjfSYgyTqZkpWmbVOXi09eBdXRo6CWbVaTy4uiUxw6lZFtS1NmyxkfpliPG+Ag8CbjbfRXcNkXxYhYtmpm7iZcaTjvDgUCQzCT87vYK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536540; c=relaxed/simple;
	bh=L76RNvsn/XDlLpgNSihLqM9GD4IV0OFBqI3VWeftGLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvg1v2dGEiVgn1BmqO07GRYkw/D7Y7QlXW3fEVeZZEofJyebWtrqOvcNuqAI9vOXGtYa1Tm9eTuALIChAwR+IinBanERvJQ+MefLsNkJUKfzZR5/4LvQm9BDex0p4fR3DeLis9fRJSX4SCo9Xx4km4xgdRiv3T5BgxbMx/2Bhnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c9BU2ZxZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mwt3OHKrQ6H4MDHsSz3qoIKrO+SSIvtmYL/lFo8ussA=;
	b=c9BU2ZxZSDg31TJtdgdrRnY30VLA37u2N0l2k3tuhQngnqGpEuOtjGzNcqFUWpGOsUrQC5
	4dgKOQdbOg7/I7V5T39IJlU3N2D5ZsIQhdJ+eAoQsA5lfTXIJTEaHMof7exLhQbd8Rb/Cv
	amf9TSDOqkbE68038pDGb423QpmyCEY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 08/14] mm: introduce bpf_task_is_oom_victim() kfunc
Date: Mon, 18 Aug 2025 10:01:30 -0700
Message-ID: <20250818170136.209169-9-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Export tsk_is_oom_victim() helper as a bpf kfunc.
It's very useful to avoid redundant oom kills.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/oom_kill.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 67afcd43a5f7..fe6e69dfbdba 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1388,11 +1388,25 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
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
 
 static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
-- 
2.50.1


