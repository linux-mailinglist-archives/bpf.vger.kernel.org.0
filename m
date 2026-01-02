Return-Path: <bpf+bounces-77702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6BCEF220
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4EE73044374
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA70301004;
	Fri,  2 Jan 2026 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKd8OV/A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C493016E1
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376891; cv=none; b=YEItThQL7pds3XMssrk2elXGW8EJhoEyryFWex9Pf+7FfgGSITCB4GkK1zLyRiz8GwWZhxODKFmfQkeKvikJQRj2gk89D66wmviWtVBxHJ0r10ZtQ3IWVQvFzBVMEM0owLtDhC9Rc5YnZseV/02ZPWG2qc1lNodw2DUn5GhGymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376891; c=relaxed/simple;
	bh=3AHR709VUgv3dCB+cqfLYRvYY+6lf8Gt1R4ShKpsbHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9n6q0mj0yd1/KdI4lCQEBCrvHAjnOx/QfmWFbFt1G6mTGvDAxRxxLBb6/B1i/I4Qc2doN2I6nTqqv68XZg5abANgsp9X/QGJiuwMwDd2UNCuKlwnw1TQssOzViwm6F3MiQ0CTbCQKKbGrNtz7n84bCVFmi3pj9zM0W5uzErEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKd8OV/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE6DC116B1;
	Fri,  2 Jan 2026 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376890;
	bh=3AHR709VUgv3dCB+cqfLYRvYY+6lf8Gt1R4ShKpsbHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKd8OV/AR85h2K0ybR17RiHpkjz5tRouPlF78MnBbfea8JKZRMOiWnIlpp5g29hGQ
	 InlKR2189DRaG0pTXaua2Ri//X32VxMgKu4NuBALz6RQxm/OtTuCscMh9xRvjEgtlA
	 HCrb4mlkBY7P+rUfLJk3EujfFh/UFeaK9JSo+AV+xQ7Ilyz/21NCy3XDK+YiIvU7BM
	 UHpHuPuvFDl+E28DnwJs93RIWNAo5n8sO0gQ9QipzoIDl47oAGmbUnVXQhzw5Ai64F
	 Mf8cHaiKsW1GjgBbkxbm2jrYZ7vZd9cet2L/O0fGA2v06MMqSmuuFrkMX0h2Z+tehm
	 Irzf8tb0Diddw==
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
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 09/10] selftests: bpf: fix cgroup_hierarchical_stats
Date: Fri,  2 Jan 2026 10:00:35 -0800
Message-ID: <20260102180038.2708325-10-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
References: <20260102180038.2708325-1-puranjay@kernel.org>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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


