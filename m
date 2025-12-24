Return-Path: <bpf+bounces-77431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C690CDD0B0
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CA92304218F
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5647341AC6;
	Wed, 24 Dec 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtexm5U7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A86224B0D
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604363; cv=none; b=ugla99luXRsv+2l9qtswoyMYDaPFe+f1ARdjipTEIWRCIgvtXn1SEcgl7Ze3m0LImPMBdyqJ3MXMgh09R7+O+w+0em02vwoj3JpZqHQK5PpE9ZqpjaupFQGOiaX5s6DmBPQd4yI0+fZ0DVRWiPi2kZWYxkKQKhPDiTWIvEXH+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604363; c=relaxed/simple;
	bh=Ne4Bly6gZj+adU+xojeAqWImMkqSMnZop2vW8AJA8bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/ZXnZtri1hEGxbQzrHhXKvr7eetf6P+lxRPj7D0GWQVV6cw2ZYKsc3j+GQox2V95fxZDKXWGEY7kGmNhgEPopFyoQoDBbMEXRb3ZN8+m4bI5OpZNmC9X+E9UB1+WfdW5oPcsncxJazUg/V9hydUf1AZRaoGUHlcgSklPFCwKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtexm5U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EE6C4CEF7;
	Wed, 24 Dec 2025 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766604361;
	bh=Ne4Bly6gZj+adU+xojeAqWImMkqSMnZop2vW8AJA8bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gtexm5U7rRIhDtk14MWxwjWQszyj0oBw3S0JIWSZhr5NstulZbAkmBl1QQAG7LPSi
	 9zktfT8+mFhtdOJkpzJC1mr4ZPICuBgTnvS0kwjUs6qrZ8USrz/rWix3b9tlx2FGOd
	 +nDcXeFDLJFE0qKWsvpE2NKECv9iLAWctX+l9yMPhB5SOozrD72JqytPIH5n2muSoZ
	 n5aYy5qjwSkL7i42BkpVo8XlC3BDMTOxHUoAUPWZxNTq5jeAt/J31TyADVvAd5CsfP
	 RthhAK1NY4l3JtFIFLUvrdADqiqt8GXrMEN1xOjsMN4XGYRNYMY0GCX8EGyItLmb3e
	 UgUYjJqRHVufg==
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
Subject: [PATCH bpf-next 7/7] selftests: bpf: fix cgroup_hierarchical_stats
Date: Wed, 24 Dec 2025 11:24:36 -0800
Message-ID: <20251224192448.3176531-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224192448.3176531-1-puranjay@kernel.org>
References: <20251224192448.3176531-1-puranjay@kernel.org>
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


