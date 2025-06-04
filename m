Return-Path: <bpf+bounces-59595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE45ACD30D
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 03:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC423A340A
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010025EFBF;
	Wed,  4 Jun 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihmS67Wi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1781D8E01;
	Wed,  4 Jun 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998833; cv=none; b=dO4jac99tY5wXIaP2bhjj/pYyqzjXw7xZhXoBzF4CRIgss9sFCgUEEVBnaSivRkH0QDG986tfKeDf3IGy+iXHwNHf53uBCkEEkeF8QdYGLj7kZDpy74cCaPRO2VzQ0w2jJHI/cT+w5OXV+NNE8DkmnDrpvbsaGBgbIiKD72qCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998833; c=relaxed/simple;
	bh=CGlUeXlAS/kQgGDZAKLhIDakIvO74PaLIE+8TWQnlXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnZbvtyWF2RcXZ7+jWIA6HPabBocp386moXf16c+K+FHpFDsaBJGasWnUAYwh6ejBf0931Ox3TIY4N06/7ZApfMv/prvqauNbWH2EojwVRQ2kox+tZJEwmQ4aXRMG57hMYi4EjGiC14F8vGiM2kJs/fGW7hpRC6bZ8AqesNKSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihmS67Wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EAFC4CEED;
	Wed,  4 Jun 2025 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998833;
	bh=CGlUeXlAS/kQgGDZAKLhIDakIvO74PaLIE+8TWQnlXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihmS67WiWPi3EYytcBWIVPxdI6QjkRASGEQ2f0B7J6rXpUwxYiliYiAzbXJgx9DRk
	 g1rdDytJloaMZ17kTth2KCPhd98d96g4DRateVX8KEGKGJldOQwxpgGkjoNrj3hu11
	 Mm5yp2UIUN706QbUylJi4RyZ5CMnOm3CQFaOhAeQ/LU+TZnGapuxo6i+1mVc+D/Tpk
	 Tq6xxurlhJb7EJKSqlKOVB9wXtOtyRiOtY8N6oME0WLS4BFcTsZFgYM0sGS/3Q8vGv
	 Ek07lBqzDqHwmyKpFNZDuhGuKqnaoocISQPaTFcRJapZb3eAdmdw2m2F4jOGybRvhd
	 blAhxcSPTBkuA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 40/93] bpf: Pass the same orig_call value to trampoline functions
Date: Tue,  3 Jun 2025 20:58:26 -0400
Message-Id: <20250604005919.4191884-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Transfer-Encoding: 8bit

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 94bde253d3ae5d8a01cb958663b12daef1d06574 ]

There is currently some confusion in the s390x JIT regarding whether
orig_call can be NULL and what that means. Originally the NULL value
was used to distinguish the struct_ops case, but this was superseded by
BPF_TRAMP_F_INDIRECT (see commit 0c970ed2f87c ("s390/bpf: Fix indirect
trampoline generation").

The remaining reason to have this check is that NULL can actually be
passed to the arch_bpf_trampoline_size() call - but not to the
respective arch_prepare_bpf_trampoline()! call - by
bpf_struct_ops_prepare_trampoline().

Remove this asymmetry by passing stub_func to both functions, so that
JITs may rely on orig_call never being NULL.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20250512221911.61314-2-iii@linux.ibm.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Analysis **Nature of the Fix:** This commit addresses an asymmetry in
the BPF trampoline infrastructure where `NULL` could be passed to
`arch_bpf_trampoline_size()` but not to `arch_prepare_bpf_trampoline()`.
The fix ensures that `stub_func` is consistently passed to both
functions, allowing JIT implementations to rely on `orig_call` never
being `NULL`. **Code Changes Analysis:** The change is minimal and
surgical - only one line in `kernel/bpf/bpf_struct_ops.c`: ```c - size =
arch_bpf_trampoline_size(model, flags, tlinks, NULL); + size =
arch_bpf_trampoline_size(model, flags, tlinks, stub_func); ``` This
passes `stub_func` instead of `NULL` to `arch_bpf_trampoline_size()`,
creating consistency with the `arch_prepare_bpf_trampoline()` call on
line 620 which already receives `stub_func`. **Why This Should Be
Backported:** 1. **Fixes Architectural Inconsistency:** Based on the
repository analysis, this addresses confusion in JIT implementations
(particularly s390x) about when `orig_call` can be `NULL` and what that
signifies. 2. **Prevents Potential Crashes:** The repository history
shows that similar asymmetries in BPF trampoline handling caused crashes
on architectures like RISC-V and incorrect code generation on s390x. 3.
**Minimal Risk:** The change is extremely contained - it only affects
the parameter passed to `arch_bpf_trampoline_size()` in the struct_ops
path. Since this function is used for size calculation, passing a valid
function pointer instead of `NULL` should not break existing
functionality. 4. **Follows Stable Tree Criteria:** - **Important
bugfix:** Prevents JIT confusion and potential incorrect behavior -
**Minimal risk:** Single line change with clear semantics - **Confined
to subsystem:** Only affects BPF struct_ops trampoline generation - **No
architectural changes:** Does not modify core BPF infrastructure 5.
**Related Historical Precedent:** Looking at the similar commits in the
analysis, commit #3 (s390/bpf: Let arch_prepare_bpf_trampoline return
program size) was marked "YES" for backporting, and it was a similar
cleanup/consistency fix for the BPF trampoline infrastructure. 6.
**Prevents Future Issues:** This fix eliminates a source of confusion
for JIT maintainers and ensures all architectures can implement
consistent `NULL` checking logic. The fix aligns with the principle
established in commit 0c970ed2f87c that JITs should use the
`BPF_TRAMP_F_INDIRECT` flag rather than checking for `NULL` parameters,
and this change supports that by ensuring parameters are never `NULL` in
the first place.

 kernel/bpf/bpf_struct_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 477947456371a..2285b27ce68c7 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -577,7 +577,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	if (model->ret_size > 0)
 		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
 
-	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
+	size = arch_bpf_trampoline_size(model, flags, tlinks, stub_func);
 	if (size <= 0)
 		return size ? : -EFAULT;
 
-- 
2.39.5


