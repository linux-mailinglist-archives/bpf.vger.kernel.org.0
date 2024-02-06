Return-Path: <bpf+bounces-21262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0D84AB22
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 01:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77254B242C6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E5EC7;
	Tue,  6 Feb 2024 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFVQjpBe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CA1361
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180012; cv=none; b=V3zqB8fSWVMFAuQPo/ydbDG2CwnKscnckJLdf96TxGKC3YqnYqbSPFLkdyRCmDozSI9ZH+Q8l9UfJ6TmC4dWBXY/G/qqrZk4wFdpxlMVdADy6etCK/GY5jLWpEyndc3zoXi2fWl3gPXtloqfONzjlijLoij0ho1NtgzIe+jn9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180012; c=relaxed/simple;
	bh=d+dAUvYjS9Cx1eJu59JGi3qtAxWmlx4VTWpA7QIt1sA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aHQhTgsq/3ovThF3EsYVM0COiI+w8eP01u2dFhWCRHBifyeziuueFxIRSj1QoWYR0iZXbooFyBiQA35kJbO1rp6tYxHHGzMJcvd9Bwp/TF7nmr8pxL+OTWqk7duiRCpRlToEG0l3nlDmY26CPT54L3NaHJCkA0idS0T8IJoMnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFVQjpBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA6FC433F1;
	Tue,  6 Feb 2024 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180012;
	bh=d+dAUvYjS9Cx1eJu59JGi3qtAxWmlx4VTWpA7QIt1sA=;
	h=From:To:Cc:Subject:Date:From;
	b=UFVQjpBeD/LJXppHkedUwoMy9SwPI4XbeQnXN38ZqrrhHXbkHnc/UWodG1uZoiA3t
	 IxOPpkFLxDEKzCi2fTzZSbNnQKRkSyWLRx2KGmsSUYvPIg+x4VByGv7ufKYELW6Lwi
	 xInw8zozI0VXb1E/GQwXy+/CwAeoGDftbedK5ZW3zlPjIJKD1wUJ0ZIr/aMipGUfRl
	 0eTjBZk9VgkTFPV3DKNp2+iplLpr7zXhkz3nNxvMtkVgKzV7G1tBxDfMKixp7Hgs+a
	 WZgb+Tg6vt515mIdFdzM0T/4CB1PKoNq/WiPszxMS1fvyE1SBYVRvAo0ceiiOXwf/+
	 FM1EUO6kVXQdw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: mark dynptr kfuncs __weak to make them optional on old kernels
Date: Mon,  5 Feb 2024 16:40:08 -0800
Message-Id: <20240206004008.1541513-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark dynptr kfuncs as __weak to allow
verifier_global_subprogs/arg_ctx_{perf,kprobe,raw_tp} subtests to be
loadable on old kernels. Because bpf_dynptr_from_xdp() kfunc is used
from arg_tag_dynptr BPF program in progs/verifier_global_subprogs.c
*and* is not marked as __weak, loading any subtest from
verifier_global_subprogs fails on old kernels that don't have
bpf_dynptr_from_xdp() kfunc defined. Even if arg_tag_dynptr program
itself is not loaded, libbpf bails out on non-weak reference to
bpf_dynptr_from_xdp (that can't be resolved), which shared across all
programs in progs/verifier_global_subprogs.c.

So mark all dynptr-related kfuncs as __weak to unblock libbpf CI ([0]).
In the upcoming "kfunc in vmlinux.h" work we should make sure that
kfuncs are always declared __weak as well.

  [0] https://github.com/libbpf/libbpf/actions/runs/7792673215/job/21251250831?pr=776#step:4:7961

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 0cd4111f954c..14ebe7d9e1a3 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -9,7 +9,7 @@ struct bpf_sock_addr_kern;
  *  Error code
  */
 extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
-    struct bpf_dynptr *ptr__uninit) __ksym;
+    struct bpf_dynptr *ptr__uninit) __ksym __weak;
 
 /* Description
  *  Initializes an xdp-type dynptr
@@ -17,7 +17,7 @@ extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
  *  Error code
  */
 extern int bpf_dynptr_from_xdp(struct xdp_md *xdp, __u64 flags,
-			       struct bpf_dynptr *ptr__uninit) __ksym;
+			       struct bpf_dynptr *ptr__uninit) __ksym __weak;
 
 /* Description
  *  Obtain a read-only pointer to the dynptr's data
@@ -26,7 +26,7 @@ extern int bpf_dynptr_from_xdp(struct xdp_md *xdp, __u64 flags,
  *  buffer if unable to obtain a direct pointer
  */
 extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u32 offset,
-			      void *buffer, __u32 buffer__szk) __ksym;
+			      void *buffer, __u32 buffer__szk) __ksym __weak;
 
 /* Description
  *  Obtain a read-write pointer to the dynptr's data
@@ -35,13 +35,13 @@ extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u32 offset,
  *  buffer if unable to obtain a direct pointer
  */
 extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u32 offset,
-			      void *buffer, __u32 buffer__szk) __ksym;
+			      void *buffer, __u32 buffer__szk) __ksym __weak;
 
-extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u32 start, __u32 end) __ksym;
-extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;
-extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
-extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
-extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
+extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u32 start, __u32 end) __ksym __weak;
+extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym __weak;
+extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym __weak;
+extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
+extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym __weak;
 
 /* Description
  *  Modify the address of a AF_UNIX sockaddr.
-- 
2.34.1


