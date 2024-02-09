Return-Path: <bpf+bounces-21662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9816850099
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CDE2852B2
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 23:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE3A374FA;
	Fri,  9 Feb 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVvk5ckK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176031E4AD
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520159; cv=none; b=XBCt3sK1+VoK9ZcVvV0C9hnTvke0S574yhOcoWYaJB/ADea1fQgZKR36jPD+YAY41Zd3t+Wv+jEv8KiwxA9pEouD9q1iVIKpv2NzK3aVrFjSjPIqOcTQNs6lU0Qq721lc9hwv6X6CgVNX2OafVUY95+iCOn2vJ6/5bAsVhYj9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520159; c=relaxed/simple;
	bh=peNHuCp0hVvKAmLOF5CeQ2pDRxZpVOFKhKvpMynj7DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ChMbinH1Ww6JmuyrAdRA17IqxA88ODxQkx9ZpzoWir9EcDZzWvMIaJ6MrB03GK8w5/j+N2m1j6dDS9Dbfw4JUXrWrgUn3HgkNMpEvYbRaylAoQvxoZl5EN5qK+8IwBX2Q7OhO9jdEeUAhlzRAxTJgqsrAxFUrBwrMWKp2oCwV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVvk5ckK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821E3C433C7;
	Fri,  9 Feb 2024 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707520158;
	bh=peNHuCp0hVvKAmLOF5CeQ2pDRxZpVOFKhKvpMynj7DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVvk5ckKvHdPY83PO2Wr4la9t9IaAugHI3Ve9O5/JcF+qcDxH55DZaxXiydHmbBZf
	 n8lBXf6WkUUwfIvqBNrp+wvyKLl0BRPn8j5IyJHSEK2oCLHVA3g4kdo9uw0Jjkegwd
	 5rM/HL0q28LwpPUtpUvCcFhyuspSi8EwIwns2RqZpcS/+5hrNpYViAbxKLSb7x+d/H
	 vrLpCYo60fa9XFrzjEoVGO5uM0UsqlK+0SvppgE20HLbhvVgau+FkMxstkur5tV7i+
	 MXzm36LVcRrYlDHJRmzGimuVQHDDrrQRXxrpygixyYir869DWg5oo9/ANVLWmHPfy/
	 QLzut/IV8iBZg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: add anonymous user struct as global subprog arg test
Date: Fri,  9 Feb 2024 15:09:08 -0800
Message-Id: <20240209230908.2380782-2-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240209230908.2380782-1-andrii@kernel.org>
References: <20240209230908.2380782-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests validating that kernel handles pointer to anonymous struct
argument as PTR_TO_MEM case, not as PTR_TO_CTX case.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/verifier_global_subprogs.c      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 67dddd941891..fed847bc1911 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -115,6 +115,35 @@ int arg_tag_nullable_ptr_fail(void *ctx)
 	return subprog_nullable_ptr_bad(&x);
 }
 
+typedef struct {
+	int x;
+} user_struct_t;
+
+__noinline __weak int subprog_user_anon_mem(user_struct_t *t)
+{
+	return t ? t->x : 0;
+}
+
+SEC("?tracepoint")
+__failure __log_level(2)
+__msg("invalid bpf_context access")
+__msg("Caller passes invalid args into func#1 ('subprog_user_anon_mem')")
+int anon_user_mem_invalid(void *ctx)
+{
+	/* can't pass PTR_TO_CTX as user memory */
+	return subprog_user_anon_mem(ctx) & 1;
+}
+
+SEC("?tracepoint")
+__success __log_level(2)
+__msg("Func#1 ('subprog_user_anon_mem') is safe for any args that match its prototype")
+int anon_user_mem_valid(void *ctx)
+{
+	user_struct_t t = { .x = 42 };
+
+	return subprog_user_anon_mem(&t);
+}
+
 __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __arg_nonnull)
 {
 	return (*p1) * (*p2); /* good, no need for NULL checks */
-- 
2.39.3


