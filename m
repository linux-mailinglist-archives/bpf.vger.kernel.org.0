Return-Path: <bpf+bounces-54832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F83A73E30
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 19:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E201A7A59A3
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567821ADB4;
	Thu, 27 Mar 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obxinTgG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3C18A6DB;
	Thu, 27 Mar 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743101743; cv=none; b=bE2h+uzGrcWku0LPy0NBFmjexoMu2+7lxg0HegE5h3YClIKdxUpav1zyYEMLTSY0/K67YkdVq79TKdAWrxxZoFufs+8LkJc6QHS5cjc3rl58pDmleO+/khPxtcCc5ToVQg6maak+4aMwdCfS3+SGt6Pa+No1kEvWGn2YYqYpee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743101743; c=relaxed/simple;
	bh=PQ7ZMrk8pqpSMRXerx192dfhJ1WMbERl7hgOfzEAUDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ki7Z37Hl8HeeYSScHjYqr/ruTj0vanLzFAcNy5r7e48l/sNCbK7bW/BIlQkV/C9KzpbxzUtxWqrjOBFKCh0c4i0QkYosY7zPqCGQDq+ED1Zr+ArzYivdz/7XbTyRPDohOBeQRnU7s+ftofXNrhVu29vUPxnqe7KHOrYPaFgqM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obxinTgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20DEC4CEDD;
	Thu, 27 Mar 2025 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743101742;
	bh=PQ7ZMrk8pqpSMRXerx192dfhJ1WMbERl7hgOfzEAUDI=;
	h=From:To:Cc:Subject:Date:From;
	b=obxinTgGE24c8QNrGb6kA+aPmV+9JVQz2Z5Cen9t2B0CHhA0A0kaIwnk0w+XdUvXI
	 9nEg+CTo0fidxgfCWupc+DTFW2bQnBuPa8bdJO8mpbX2/lJbkv2aDrMLktuisA9oxY
	 YPjDasDgnTVinvKK3Do3T+1EoDs+8TzTrSS8lijRcnhI+6Ft+J976tw7OseLC5w3gv
	 GywE67d4ROx0ncobnwgRMH9atvQWdS+wb9numB+3Kj6ganw6P6xXLwvd0H/lbAbW2f
	 Yk/F1u5M5zWil7GOUjMD9u4jOb2tIZcwQBOX8ZFaUnApybz6XNbJTQgl+vmrRvOdyI
	 7Jn5B5SbH2c7g==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel-team@meta.com,
	song@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix tests after change in struct file
Date: Thu, 27 Mar 2025 11:55:28 -0700
Message-ID: <20250327185528.1740787-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change in struct file [1] moves f_ref to the 3rd cache line. This makes
deferencing file pointer as a 8-byte variable invalid, because
btf_struct_walk() will walk into f_lock, which is 4-byte long.

Fix the selftests to deference the file pointer as a 4-byte variable.

[1] commit e249056c91a2 ("fs: place f_ref to 3rd cache line in struct
                          file to resolve false sharing")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_module_attach.c    | 2 +-
 tools/testing/selftests/bpf/progs/test_subprogs_extable.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index fb07f5773888..7f3c233943b3 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -117,7 +117,7 @@ int BPF_PROG(handle_fexit_ret, int arg, struct file *ret)
 
 	bpf_probe_read_kernel(&buf, 8, ret);
 	bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);
-	*(volatile long long *)ret;
+	*(volatile int *)ret;
 	*(volatile int *)&ret->f_mode;
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
index e2a21fbd4e44..dcac69f5928a 100644
--- a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
+++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
@@ -21,7 +21,7 @@ static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
 SEC("fexit/bpf_testmod_return_ptr")
 int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
 {
-	*(volatile long *)ret;
+	*(volatile int *)ret;
 	*(volatile int *)&ret->f_mode;
 	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
 	triggered++;
@@ -31,7 +31,7 @@ int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
 SEC("fexit/bpf_testmod_return_ptr")
 int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
 {
-	*(volatile long *)ret;
+	*(volatile int *)ret;
 	*(volatile int *)&ret->f_mode;
 	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
 	triggered++;
@@ -41,7 +41,7 @@ int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
 SEC("fexit/bpf_testmod_return_ptr")
 int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
 {
-	*(volatile long *)ret;
+	*(volatile int *)ret;
 	*(volatile int *)&ret->f_mode;
 	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
 	triggered++;
-- 
2.47.1


