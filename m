Return-Path: <bpf+bounces-21800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79684852293
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DF91F239C7
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C914F5FE;
	Mon, 12 Feb 2024 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvKfARnI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68C3A8C2
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780757; cv=none; b=YzCYLI1pfSEHqk4gWFxOfSNG60QyMPVO5GVPB8qSJKxoUCwrKUIDEL9t2GKtvQ/FNZ5BSmFvQhOFM3dSyslMPWuRLzazVH/5plQFCIl+mzusdohu8OvQ9GJt28xEqzETzcn9s2aLWHhoxctRFkPRSDsYf9rLzbkfCoRe2Ttk8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780757; c=relaxed/simple;
	bh=N37XfCaS7bdcPg0qDrwSRW/oJljCUpgb2fdACke0c00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=audKgeifA6zhL3cOn6x/Z8pJMmJU7erT5BJUwby6tL2xp1dwnbgjmbLsw5j4H/oje3r40OCAFCS1sdhRLZ9ku+5gyIuST5dQxM9dPBYOPkwxsg/F5X0/KWb0UtkDIW7B8+PyY8H94LcTP7zbZH206zttFesJ85ft8O1Gj9Ql6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvKfARnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3713C433F1;
	Mon, 12 Feb 2024 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780756;
	bh=N37XfCaS7bdcPg0qDrwSRW/oJljCUpgb2fdACke0c00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvKfARnINcSypFMgI2SHm390tl3enQgUYFcDYSrdjaNAaB4jtluKuXA2g4o1qpzMW
	 itXFj7oXgWP3sKqaW+CEDmurtQCMq9mj+rG1QuQZmgXl6yCPlDyxlAMDapjv9Krnyk
	 ThdTKGHuDFwE9OL9lVIbzB7h1hDKIPY3nA9pOB4Pr1R/NB1fRn7tTBuFcHFYyjTRlO
	 CVeEUJmvM8JwCnhxtA1wn4V2h89dqpWfEQ9hswqd8+PbC3fW5UPWdmBu/PboEXalwf
	 z4RACQUM/6fuy3t5FTGCpPMLbqRvRk4ZyIuAIciMgRRaf0nt6BUodfm9htzf22oFs5
	 p6aA/29VfJ+OQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: add anonymous user struct as global subprog arg test
Date: Mon, 12 Feb 2024 15:32:21 -0800
Message-Id: <20240212233221.2575350-5-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212233221.2575350-1-andrii@kernel.org>
References: <20240212233221.2575350-1-andrii@kernel.org>
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
index 67dddd941891..baff5ffe9405 100644
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
+	return subprog_user_anon_mem(ctx);
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


