Return-Path: <bpf+bounces-72170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4692CC0852F
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 01:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5273BA958
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 23:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530A30DEA1;
	Fri, 24 Oct 2025 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkXMn9sl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B68303A09;
	Fri, 24 Oct 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348831; cv=none; b=GpVxvhksaca0Q5Zx4WpOQXaMht9iTuMfIspFYPsymlbsIcjvCsK6L+YRL6rv3UX8kogms38zVEep30Saq87wCNpO1alx6ilbNf+EIgAGPdH83HaLNCOlR+nsmWkxejQIKjjmZrTOGVVA30zQ1eyWPBCvxIazKf5xcecbGIkmNFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348831; c=relaxed/simple;
	bh=+VEU9nhPEHtAMMHzg5x5itMvJngxn1huwVpTNGZ1sug=;
	h=Date:Message-ID:From:To:Cc:Subject; b=B6ETlyZ0MKqGsyJBCjRWcRMhk2nhukpFg5LfQgXDjFZjb3x5rTOXP9WkZI457GXYpAR0sb5rDMLYXodh04Ysey7RmzkMFruijT8jJ9wtAmu1iGWvKFrJm68DMKDEU0lvMUD3l/lDA6cqXB5gxQdbsa9/fUwCw/Rnr0XJVzkoOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkXMn9sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC27C4CEF1;
	Fri, 24 Oct 2025 23:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761348831;
	bh=+VEU9nhPEHtAMMHzg5x5itMvJngxn1huwVpTNGZ1sug=;
	h=Date:From:To:Cc:Subject:From;
	b=fkXMn9slYBK6TmFYl2nUX7PG96ixgNCkdHebekUOeEtqWBs088A6lcV0cvhYpAjgw
	 k3WKv1RVlHmpg71hwPYWtzoZg4nWOcy4m11HKUgNeRcJNJnm3E2NPGp71nMQwzN/Bw
	 dv/CD7Ukkijaen/2pqvErMMhsK6772TbWkGCo7hgcCMN4WKnKmlN3d9lnIKEZaF7eg
	 IHJwfUHFDmZkp+YXg7KsW8CdDnxpCkennBK2aUTG9io23Fy4mk7XUXFkY4fQxoILEm
	 VxFeESw8M2h1fqHjt43w/Zy7r5jY4KlScNkZmUTlCT4B3jVCYokGsbUKslfwDH9lZ8
	 atkIzlGSsdOGQ==
Date: Fri, 24 Oct 2025 13:33:50 -1000
Message-ID: <6c9852055cae7d54ce33df77c5c7a1dc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH sched_ext/for-6.19] sched_ext: Add ___compat suffix to scx_bpf_dsq_insert___v2 in compat.bpf.h
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert() backward binary
compatibility") renamed the new bool-returning variant to scx_bpf_dsq_insert___v2
in the kernel. However, libbpf currently only strips ___SUFFIX on the BPF side,
not on kernel symbols, so the compat wrapper couldn't match the kernel kfunc and
would always fall back to the old variant even when the new one was available.

Add an extra ___compat suffix as a workaround - libbpf strips one suffix on the
BPF side leaving ___v2, which then matches the kernel kfunc directly. In the
future when libbpf strips all suffixes on both sides, all suffixes can be
dropped.

Fixes: 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert() backward binary compatibility")
Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.bpf.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -237,15 +237,17 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime
 /*
  * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
  * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
+ * The extra ___compat suffix is to work around libbpf not ignoring __SUFFIX on
+ * kernel side. The entire suffix can be dropped later.
  */
-bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dsq_insert___v2___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert___v1(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;

 static inline bool
 scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
 {
-	if (bpf_ksym_exists(scx_bpf_dsq_insert___v2)) {
-		return scx_bpf_dsq_insert___v2(p, dsq_id, slice, enq_flags);
+	if (bpf_ksym_exists(scx_bpf_dsq_insert___v2___compat)) {
+		return scx_bpf_dsq_insert___v2___compat(p, dsq_id, slice, enq_flags);
 	} else {
 		scx_bpf_dsq_insert___v1(p, dsq_id, slice, enq_flags);
 		return true;

