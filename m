Return-Path: <bpf+bounces-69403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD7CB9634B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B71C4A35C9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5AD24A069;
	Tue, 23 Sep 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOWiwj2f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1FD230BDB;
	Tue, 23 Sep 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637296; cv=none; b=b5GKXQ2KP1kDxCewVvqsBt1Eyy8FnKtPFhpC7DvRjHUhVk1ZTcOFYUQ/mTlJ3g+JhjsoXoz6+YCUe0MoZm3zPZs3bNcDJT/7PnsauNmpS+l6Zm0tFE0va0Qln50Y8oUuHckyEQAqqJRutLv6iyDl0G503j8kK4FUTlFPXyKISkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637296; c=relaxed/simple;
	bh=FCc3TPZVw9grK2mrF1tFguXdehf44jNav5ZIKxFutYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hl/NLF4v5h5EvjZVtdfbxGTwHk5+nqQbFGFbA4LG2kwg2+yaKar5Q2ZsbNmYX7XmNV0/Do7EbrJ9f23C/+fwlx0RhMnwvuae7x/BLA1TOA58JAkQHTlO4b2r+/k4PjbmWUkXtMb//MrLBlh6B7n/AB6oUQ2zzQ4bg6VemwGJeaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOWiwj2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6E6C16AAE;
	Tue, 23 Sep 2025 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637296;
	bh=FCc3TPZVw9grK2mrF1tFguXdehf44jNav5ZIKxFutYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XOWiwj2fy5+SAHmDwfpQz0qEuhN9OGAyPIICL4OsBCybJUXFQQbzFkOGjlpT2A5mo
	 vrXHUNQk/pFYoiVjV3NTbClHy1YLbx+YLiC9lrfKkmJgIFMBN+chEnBi0l+Ax1846t
	 QsbSyB9Q2UVHKiUHagwX0dgovj/iM3r4bhq52wDV/ENp5L45bVIhYYddLt6OQHmZD7
	 BzxP9S8ecYbyuVBz7Qz5O24iOqRowwOBwJXFpFkf1//tCQDxeKWlhVNLPZL9Fqr7QE
	 be98X9WOx9A2Aoc1J22w2rJHHIGgQmWEgycf/aubjgUOlG+bwVZJS+dqTiNbUxsFqt
	 nm+rh38NmISPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B91F0CE0EDC; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 02/34] rcu: Remove unused ->trc_ipi_to_cpu and ->trc_blkd_cpu from task_struct
Date: Tue, 23 Sep 2025 07:20:04 -0700
Message-Id: <20250923142036.112290-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that RCU Tasks Trace has been re-implemented in terms of SRCU-fast,
the ->trc_ipi_to_cpu and ->trc_blkd_cpu task_struct fields are no
longer used.  This commit therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 89d3646155525f..47bd062b21c2bc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -940,11 +940,9 @@ struct task_struct {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	int				trc_reader_nesting;
 	struct srcu_ctr __percpu	*trc_reader_scp;
-	int				trc_ipi_to_cpu;
 	union rcu_special		trc_reader_special;
 	struct list_head		trc_holdout_list;
 	struct list_head		trc_blkd_node;
-	int				trc_blkd_cpu;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 	struct sched_info		sched_info;
-- 
2.40.1


