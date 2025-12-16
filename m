Return-Path: <bpf+bounces-76714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E5CC350D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 14:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0853D305C802
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615323845D8;
	Tue, 16 Dec 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqRAkau4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE35382BF1
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891808; cv=none; b=ss0MmDuzRF2rBksBE3zzzPz+Cl6HSBAh1BuHVn9j2rS7dLqnzZgMFZL4xSVIlrpAySEt4VX51MT8tu5xMMsx1VLkgCjIMboQzRyBiqn3WnljDTHB8FN1tjjVQOlVxWO2Ul07PNKe3GUq3ZePJ+86laVcChUpXkX3sPVWwuozJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891808; c=relaxed/simple;
	bh=IrIABrj+7xfUgYfX8kOHvGNBr7U8dCf/n9p4jnGSqwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mma/WEkJldEK9+xRJnaJ3EQzgIAeKKiJJPk8AWsc44NNWZmzBhN1yaCDJhZRypnpGOhTSSHAoil5TPBKgDfwQJOQ+fY0RZV8Eg8rFIwxrnIPr0YgfV4ozV98jVRbbYJSL9zBbjNp5ByX6kONMMdViE6SZqKD+fJe7Gd1iYL93NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqRAkau4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47a97b7187dso14147265e9.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 05:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765891805; x=1766496605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kjZacfeSscdoRxj5z6iTGxu+PZ43tsLcMUojAWcvTc=;
        b=SqRAkau4zBcEgqrIHvpzVAo29Kumsg0O/2Mnl4DyOXlSG0eLRJ1pDVc+bhRTgjMV/Z
         Eyy9UZ4EJZOyMsgbSCdPeZ6h603ZtkBbKgfFcFSv6ucpqmIsLkZAFNK5AFbvy6biB4PV
         HlUNBqK2Q2B2bZcdJF5h05XrktbchZ6td3Xd8IHYsx0UbxcGNYxjk9h608mKnelyEItt
         UA2zZWpsNISlwBnL8ZgAb1VToAjiz2p0DKHy3z2ruZixj8fyko4Ol2mrOppJxD3whIfW
         RwEdtavGGCTekzAoWeAR9G/6RrcJ2usNFfuIp4a3EoYNf9VhhGPhaF1JQ6skSthZjlfe
         +lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765891805; x=1766496605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kjZacfeSscdoRxj5z6iTGxu+PZ43tsLcMUojAWcvTc=;
        b=LuIN8rsA48lrOP+7MZdejeC4vSFdC9TJO/wgkQKW6XDPAEqwGxexG6aSG1zsGOq5t0
         VV2qlT9N+KN7iZj4VeFxMw9jrDWBlptDbW7hVYZFow36adIdYRvPZzVhL5E8/6xI2FdZ
         Cb7Mky+KpoIyrChC2lN8rnoMywmvMhvBBFZ+Dcs+4Clo6/b2YTVx00bI0VmL2t/xiOKo
         Qrh9n4Lf6EwBwta3EgfJ/CTQIiuL3qSYi/kM1/D0qzKX+uzkqW/i9kmwyvy6Jfvaehxd
         vy/X3+hvys+qNmDw9/fF7R5XAIR+tLGidhWbpgDaZ92oM0Gh7iYOU4N0R+Gr8XtTgP2N
         7f2w==
X-Gm-Message-State: AOJu0YxAZId3ik1SnkT4GnhdTI5YFDtqbOIEityCY3Dmhl69vs8fVFiP
	zFHaNncRS+0qswHm3+CfbY2LBwwuVNiz8aMfmVM7BS7jgjBWJBniByfQXxprF+KVybTWfJd+BYz
	Xsd+tmbEdw0sSsR177ipFgTybYVzSA0DqesLETP4pcwHrLzKd5i/uRg1qkOEj+K7w+nIsCdZIPx
	uXI12g2o1U4ojiZ5vwfIKHMdxrl4pLItbfgpdeI35OKyPykXSSFnDQOXv8G3f2iG9VPjalLw==
X-Google-Smtp-Source: AGHT+IHPy0+LIRm1XRhmHjC1B8qBDOCmA2g/1UiOQeVzUjFsNVLMftlImorApgW5iT9CI46917VjJfRPe7LLjq6eDA/c
X-Received: from wmsl5.prod.google.com ([2002:a05:600c:1d05:b0:476:ddb0:2391])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:644e:20b0:47a:9574:b75f with SMTP id 5b1f17b1804b1-47a9574ba21mr101317865e9.33.1765891805595;
 Tue, 16 Dec 2025 05:30:05 -0800 (PST)
Date: Tue, 16 Dec 2025 13:30:00 +0000
In-Reply-To: <20251216133000.3690723-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251216133000.3690723-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.52.0.313.g674ac2bdf7-goog
Message-ID: <20251216133000.3690723-2-mattbobrowski@google.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add test case for BPF LSM hook bpf_lsm_mmap_file
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a trivial test case asserting that the BPF verifier enforces
PTR_MAYBE_NULL semantics on the struct file pointer argument of BPF
LSM hook bpf_lsm_mmap_file().

Dereferencing the struct file pointer passed into bpf_lsm_mmap_file()
without explicitly performing a NULL check first should not be
permitted by the BPF verifier as it can lead to NULL pointer
dereferences and a kernel crash.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/progs/verifier_lsm.c        | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index 6af9100a37ff..38e8e9176862 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
 SEC("lsm/file_permission")
@@ -159,4 +160,32 @@ __naked int disabled_hook_test3(void *ctx)
 	::: __clobber_all);
 }
 
+SEC("lsm/mmap_file")
+__description("not null checking nullable pointer in bpf_lsm_mmap_file")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(no_null_check, struct file *file)
+{
+	struct inode *inode;
+
+	inode = file->f_inode;
+	__sink(inode);
+
+	return 0;
+}
+
+SEC("lsm/mmap_file")
+__description("null checking nullable pointer in bpf_lsm_mmap_file")
+__success
+int BPF_PROG(null_check, struct file *file)
+{
+	struct inode *inode;
+
+	if (file) {
+		inode = file->f_inode;
+		__sink(inode);
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0.313.g674ac2bdf7-goog


