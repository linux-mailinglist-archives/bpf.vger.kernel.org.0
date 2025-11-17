Return-Path: <bpf+bounces-74795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B395DC660F4
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB2F74EADDA
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4B328617;
	Mon, 17 Nov 2025 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgglA8ki"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3071E9B1A
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409910; cv=none; b=N/8uDe+n9eahQmHrALkD4DxOu50rcnddSJeP3J7F02NK/hkUS7XjYyEhe3V8VQ/jLXPLKi02gClw30guQgDNJG991wGmhtydnlv+TYTLLuVV/yszkRNXolRqMAnzv6PR60lX/NDbEYef21bfB4vazN/iqG+7zP36ZNv09kgazm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409910; c=relaxed/simple;
	bh=zBdq8RYinT7zJqEW2WPDz3GbSiHb0WVbRocMVAjXfBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSTilzrCUnZd+zUAvs4ASmvo/HmdaiAXQGeKcZqHXbMLHf2XWLaaXFW2lroH2UBjrEON90xqIqa142+K/kwcaowwA7JmUBerSFkgEt3HThsxYobUxO8c/gegDBQTF9NkM3wT2RB6a8npGoFrusi80VcdDXtsUupMkO+ejlLO56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgglA8ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE3C113D0;
	Mon, 17 Nov 2025 20:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763409909;
	bh=zBdq8RYinT7zJqEW2WPDz3GbSiHb0WVbRocMVAjXfBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgglA8kivMre4pnzZOX9U2pwPjDE5pt49kkmgEXfpJ5faKj167amya4CHy/2q9NRF
	 ygbncG4GHyuaiyWLU8vcQwzYqH+F/KCCMzeLyqSBhpMNS3b5Y60+CPUYnebF8InNQp
	 VxeL/G/Weugb10W5Q+REBCKG0WHlRjYmu/9t71e9omIvfpewd7HA+dlcTudB2epStN
	 H8KLLLLEcTSHrTAR5JF3OaFT/aJLuw9Zc8FdFpBHDNhJzIw+LRb6rSKznafaqaun4U
	 mk+CQvhocU2LGAnnnn5PLNupXlQzLSP0UDdBPsF6NsM/EyImzHFGNF2J4uABWJosQG
	 4pZ5CSrzx/xjw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 2/2] selftests: bpf: Add tests for unbalanced rcu_read_lock
Date: Mon, 17 Nov 2025 20:04:10 +0000
Message-ID: <20251117200411.25563-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117200411.25563-1-puranjay@kernel.org>
References: <20251117200411.25563-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As verifier now supports nested rcu critical sections, add new test
cases to make sure unbalanced usage of rcu_read_lock()/unlock() is
rejected.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  2 +
 .../selftests/bpf/progs/rcu_read_lock.c       | 40 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index 451a5d9ff4cb..246eb259c08a 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -79,6 +79,8 @@ static const char * const inproper_region_tests[] = {
 	"non_sleepable_rcu_mismatch",
 	"inproper_sleepable_helper",
 	"inproper_sleepable_kfunc",
+	"nested_rcu_region_unbalanced_1",
+	"nested_rcu_region_unbalanced_2",
 	"rcu_read_lock_global_subprog_lock",
 	"rcu_read_lock_global_subprog_unlock",
 	"rcu_read_lock_sleepable_helper_global_subprog",
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 3a868a199349..d70c28824bbe 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -278,6 +278,46 @@ int nested_rcu_region(void *ctx)
 	return 0;
 }
 
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int nested_rcu_region_unbalanced_1(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	/* nested rcu read lock regions */
+	task = bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_lock();
+	real_parent = task->real_parent;
+	if (!real_parent)
+		goto out;
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int nested_rcu_region_unbalanced_2(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	/* nested rcu read lock regions */
+	task = bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_lock();
+	real_parent = task->real_parent;
+	if (!real_parent)
+		goto out;
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 int task_trusted_non_rcuptr(void *ctx)
 {
-- 
2.47.1


