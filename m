Return-Path: <bpf+bounces-19789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2248311D2
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 04:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814931F22E6F
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880D568B;
	Thu, 18 Jan 2024 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAVH6m+g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434F8BF6
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705548706; cv=none; b=r5bnKnED22SCspeaESZUaR3oRuJE/zJ3VbHpXXPpYS82sbojT/9kZGWE5e/MUSSDX7ptBG7dcSA4eDdVdVg2SMMm9eTOgX6yQ8aQPvz00OPKOhr4ohmw6JZo6EAL9EoIZ6PTUJDuxLzmLWWDKEdX5czZinJex2iXpI+BfnxVB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705548706; c=relaxed/simple;
	bh=Whd5HwRE8+EM2XMmERpO8hZ3is2G08egySHuKIBswd4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=RuGTP1nAcPrjDH67euDkTd3e3SZyzQQ8htJdFxFNCBkPDcLJSxpD8ZLfpEat1x0leVyze38GyX68OPbWBVZv+j0RzshrmRtTIPa0Y02vK1J9CD3FO7lFtfn7S/sZaiQIsJ3WXe/zqpmQ9Pyki73fx89nHy49FaccJAQ2a8nJEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAVH6m+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA96C433C7;
	Thu, 18 Jan 2024 03:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705548705;
	bh=Whd5HwRE8+EM2XMmERpO8hZ3is2G08egySHuKIBswd4=;
	h=From:To:Cc:Subject:Date:From;
	b=sAVH6m+gQ9u/0uN1KwTqP1n5FVh0LY01RKpFaX0Rbe2A2s0XObxx38YgxTA61MltH
	 n+Oaelw7M2bzyRBcVKxAcPLSqbvkxvPP3vZ/yM6vjfBfZf+hArVaG97wxFxiOdrgXB
	 fj1Q2zQXQS496RyPPaKkpIfCUWfb1PGgeyDmCSNZYt+WTSQEQf2zieeEc+9xjEwvHz
	 R4YmlinCvFEmfZBAPkvjuow3KUvuQ66hMz6gCvtv62gnwO/rjDce2qbEntaQ6MK7AJ
	 Qw+n/7SrvDaFy2QM4+Vx31DNl7dZuePZQ+ht/lD9eoZhuqxMajfkRhah29sNdsfRw+
	 JcWZTUREiE/aQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 bpf 0/5] Tighten up arg:ctx type enforcement
Date: Wed, 17 Jan 2024 19:31:38 -0800
Message-Id: <20240118033143.3384355-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow up fixes for kernel-side and libbpf-side logic around handling arg:ctx
(__arg_ctx) tagged arguments of BPF global subprogs.

Patch #1 adds libbpf feature detection of kernel-side __arg_ctx support to
avoid unnecessary rewriting BTF types. With stricter kernel-side type
enforcement this is now mandatory to avoid problems with using `struct
bpf_user_pt_regs_t` instead of actual typedef. For __arg_ctx tagged arguments
verifier is now supporting either `bpf_user_pt_regs_t` typedef or resolves it
down to the actual struct (pt_regs/user_pt_regs/user_regs_struct), depending
on architecture), but for old kernels without __arg_ctx support it's more
backwards compatible for libbpf to use `struct bpf_user_pt_regs_t` rewrite
which will work on wider range of kernels. So feature detection prevent libbpf
accidentally breaking global subprogs on new kernels.

We also adjust selftests to do similar feature detection (much simpler, but
potentially breaking due to kernel source code refactoring, which is fine for
selftests), and skip tests expecting libbpf's BTF type rewrites.

Patch #2 is preparatory refactoring for patch #3 which adds type enforcement
for arg:ctx tagged global subprog args. See the patch for specifics.

Patch #4 adds many new cases to ensure type logic works as expected.

Finally, patch #5 adds a relevant subset of kernel-side type checks to
__arg_ctx cases that libbpf supports rewrite of. In libbpf's case, type
violations are reported as warnings and BTF rewrite is not performed, which
will eventually lead to BPF verifier complaining at program verification time.

Good care was taken to avoid conflicts between bpf and bpf-next tree (which
has few follow up refactorings in the same code area). Once trees converge
some of the code will be moved around a bit (and some will be deleted), but
with no change to functionality or general shape of the code.

v2->v3:
  - support `bpf_user_pt_regs_t` typedef for KPROBE and PERF_EVENT (CI);
v1->v2:
  - add user_pt_regs and user_regs_struct support for PERF_EVENT (CI);
  - drop FEAT_ARG_CTX_TAG enum leftover from patch #1;
  - fix warning about default: without break in the switch (CI).

Andrii Nakryiko (5):
  libbpf: feature-detect arg:ctx tag support in kernel
  bpf: extract bpf_ctx_convert_map logic and make it more reusable
  bpf: enforce types for __arg_ctx-tagged arguments in global subprogs
  selftests/bpf: add tests confirming type logic in kernel for __arg_ctx
  libbpf: warn on unexpected __arg_ctx type when rewriting BTF

 include/linux/btf.h                           |   2 +-
 kernel/bpf/btf.c                              | 231 ++++++++++++++++--
 tools/lib/bpf/libbpf.c                        | 142 ++++++++++-
 .../bpf/prog_tests/test_global_funcs.c        |  13 +
 .../bpf/progs/verifier_global_subprogs.c      | 164 ++++++++++++-
 5 files changed, 513 insertions(+), 39 deletions(-)

-- 
2.34.1


