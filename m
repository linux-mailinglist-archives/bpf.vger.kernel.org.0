Return-Path: <bpf+bounces-65903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7EBB2AED6
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3816B682EA2
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A7634AAFD;
	Mon, 18 Aug 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UQf/ux/y"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4CE343D96
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536530; cv=none; b=HcvPIkFw8V9gq8R5kr6WpW35nEdlkLrzl4kaIH0GX7juPjmLW8u7vHRpAwlCDhQ5WwOzTlFkkTgvo4AKLUgtwAizNx66MHb41/fXTTUJYOofI2Ckm3RdxwmeqEOOivWrBk+3bCVZp5CAVkUyhVI4YeWSPQjPOto0c+RFeXy9Jvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536530; c=relaxed/simple;
	bh=E2BhppgzFUlQ5lTqeZyZg+1Z/QXYkFBhZ9Y5K0aoKpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Up49X+UOW8GC1daONpOu411relWfwMNamGxv1YLI4vrWZ4FG1zJb1A3yH/N0lFnMo2WSQVpwcYSDVCJPuaoTiljrGRIBApdTUipH1uuniTuoAppZpjj5boAEarhfalHOkt9naXoap7bwa4Sl5x+2WwDInL5PTuUt2FqAk6k6bRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UQf/ux/y; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6r+LPu0pSFsz4Xm/eQ1z/XPznLAX+8OLgc0s/PVh14=;
	b=UQf/ux/y+q4m6txXDXG2RhzT0g0AxXDkgQwJ8Af7N6Bmd0yDMCdgna4YuRuOSEiaZnRX4x
	VjU4YYWKAFrW3w0CP6RuXC7F4PccfTvnLX6eStoaE9l31FapcAhFtZPb+oltmQ0qGtf75b
	k5ugS/MCzTGdcS9vUtDiOPKu0aiQYiw=
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
Subject: [PATCH v1 05/14] mm: introduce bpf_get_root_mem_cgroup() bpf kfunc
Date: Mon, 18 Aug 2025 10:01:27 -0700
Message-ID: <20250818170136.209169-6-roman.gushchin@linux.dev>
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

Introduce a bpf kfunc to get a trusted pointer to the root memory
cgroup. It's very handy to traverse the full memcg tree, e.g.
for handling a system-wide OOM.

It's possible to obtain this pointer by traversing the memcg tree
up from any known memcg, but it's sub-optimal and makes bpf programs
more complex and less efficient.

bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
however in reality it's not necessarily to bump the corresponding
reference counter - root memory cgroup is immortal, reference counting
is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/bpf_memcontrol.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 66f2a359af7e..a8faa561bcba 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -10,6 +10,20 @@
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
+ *
+ * The function has KF_ACQUIRE semantics, even though the root memory
+ * cgroup is never destroyed after being created and doesn't require
+ * reference counting. And it's perfectly safe to pass it to
+ * bpf_put_mem_cgroup()
+ */
+__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
+{
+	/* css_get() is not needed */
+	return root_mem_cgroup;
+}
+
 /**
  * bpf_get_mem_cgroup - Get a reference to a memory cgroup
  * @css: pointer to the css structure
@@ -122,6 +136,7 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
+BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
 
-- 
2.50.1


