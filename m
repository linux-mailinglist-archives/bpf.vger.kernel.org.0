Return-Path: <bpf+bounces-77607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 566BCCEC55D
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BFDB300723A
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E929D280;
	Wed, 31 Dec 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFde1bjR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B629D269
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201117; cv=none; b=cqfLl6vEWlzMFyAOGmkp6oSRPYBfHHpnkztUHLVUXVqMHa8MmVxSN2hYl13MOr6zKWHsNTMGZH2llK260DpKRbbmy26Ekq0PIPnem1kZeGam67omUjin84h1KfEZ6hfPZqpX3f8giTMcbJTsT3MIXvzn+/6a+FC3dZx37Eiz1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201117; c=relaxed/simple;
	bh=Ne4Bly6gZj+adU+xojeAqWImMkqSMnZop2vW8AJA8bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpE638t0yOjiaMGQ+QqMDjVnsRgPaorcWS4OE4JlR6esm7U1v1PEldSKwI2orJeOD080AVtgCKSflvFradpE9YUGGByoaIENjxei1L4zdSP94ho/03NmjKuDbV72Z5mjwXlta+oaeIcCL8BPjOKaxeAfGgbinW77nxBS8To2O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFde1bjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E15C113D0;
	Wed, 31 Dec 2025 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201117;
	bh=Ne4Bly6gZj+adU+xojeAqWImMkqSMnZop2vW8AJA8bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFde1bjRERjlIqmykJ5SlpGvE3PSOFpgWX+dsGzDWVhSnAnwUX5wzZbqy50lST34r
	 v9YSx+1N4DjEpKBxLU31GYtOMFkMpF4LwC+d+GcSYuzWV/xarHqAAwKm2AR3ja9mXx
	 pwwy9QXukVYFOLtT6z+Ob5LLn8nNCBTKBHqVktLyWjZXCLhtGq+kV2qi0a+USziq98
	 LO+8fN6OUZXkErSbPxzCP01ZqmfBOV7/3UR9cR3zw2DyQTOdO6RVn+mmMr+933yGnA
	 aPfXEUQuahrlgVAEjAU72NyQavgmPvJkWdWeOj9T80173xH6MdMkvDMYfb48a6s7rB
	 PQa/P74XJRlAQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 7/9] selftests: bpf: fix cgroup_hierarchical_stats
Date: Wed, 31 Dec 2025 09:08:53 -0800
Message-ID: <20251231171118.1174007-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231171118.1174007-1-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroup_hierarchical_stats selftests uses an fentry program attached
to cgroup_attach_task and then passes the received &dst_cgrp->self to
the css_rstat_updated() kfunc. The verifier now assumes that all kfuncs
only takes trusted pointer arguments, and pointers received by fentry
are not marked trustes by default.

Use a tp_btf program in place for fentry for this test, pointers
received by tp_btf programs are marked trusted by the verifier.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/progs/cgroup_hierarchical_stats.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
index ff189a736ad8..8fc38592a87b 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -62,9 +62,9 @@ static int create_attach_counter(__u64 cg_id, __u64 state, __u64 pending)
 				   &init, BPF_NOEXIST);
 }
 
-SEC("fentry/cgroup_attach_task")
-int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
-	     bool threadgroup)
+SEC("tp_btf/cgroup_attach_task")
+int BPF_PROG(counter, struct cgroup *dst_cgrp, const char *path,
+	     struct task_struct *task, bool threadgroup)
 {
 	__u64 cg_id = cgroup_id(dst_cgrp);
 	struct percpu_attach_counter *pcpu_counter = bpf_map_lookup_elem(
-- 
2.47.3


