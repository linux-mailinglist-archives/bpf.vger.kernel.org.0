Return-Path: <bpf+bounces-19759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD80830F37
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 23:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6065A1C21F7D
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB01E879;
	Wed, 17 Jan 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBhz278i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F51E874
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530823; cv=none; b=g4qK4IU1q7Aiw1AT8plRKEcRLovPuLEqYQb+SC8uqXtmDFCN8/sbsnBFcqAbUMqRrgbhVO7M9t2iwL/Krn2/eheU2ZR7nfw5s312lxo4ws4EK70YJBxWnQ6kI3vcT2PwmgJRhxpEvR9y2hd4E9OeeFtAV9QJipzhrZ5k6j4hsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530823; c=relaxed/simple;
	bh=cA/XHGrdKkBgBmUqga4EZbNX/z0iZr9UXQFqdg9YHJY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=Fk/tRqJBZPngTJOHGmMNpcaDZWillNY6D4Xao+oqBbxXi70vKuEveDRd1qHMrDxjgeXL1uAr7dQVDOT0mbIsuX1tYAEHaN/tEOINhTITMT3vIXVfdehIaP9JQhPxOtj0UUQ3R3QAPlQzTFnt58p+/7TlguFrdWx9+J1sDTaDScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBhz278i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6766C433C7;
	Wed, 17 Jan 2024 22:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705530822;
	bh=cA/XHGrdKkBgBmUqga4EZbNX/z0iZr9UXQFqdg9YHJY=;
	h=From:To:Cc:Subject:Date:From;
	b=aBhz278idgObbrqeu4hA2UNfcA9mRBhei92HRu+jAG8yLnp/J36IpihUd0jKLEGEE
	 P5Pvkm3bEF0lKWXzHhed6oD69Du70gd7hxNVsFNRmfmGoItwitWAiWlarPWlMFkZjF
	 LAO+t7l7FN5iTEyj+hCSjUAm39j1s/ukKnwEcDNzQqTDPbpIcTGWg1nF9mleBwkWW9
	 qNxNnMYMTti/Q4ey8JtNH4hFfpR+MxKyP0ODDImiHHf6mGdFzBGEhJdvWlAgnxJKpG
	 Y5Yw3VAELq2CgIjl/oW7jFIplfYlvGHksPlsDW50xOnt+O8Wlmqigi2//eZ6vN9Ojl
	 fi3PhQVbfYmCw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 0/5] Tighten up arg:ctx type enforcement
Date: Wed, 17 Jan 2024 14:33:35 -0800
Message-Id: <20240117223340.1733595-1-andrii@kernel.org>
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
verifier is now ignoring superficial `bpf_user_pt_regs_t` typedef and resolves
it down to the actual struct (pt_regs/user_pt_regs/etc, depending on
architecture), but for old kernels without __arg_ctx support it's more
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
 kernel/bpf/btf.c                              | 217 +++++++++++++++---
 tools/lib/bpf/libbpf.c                        | 142 +++++++++++-
 .../bpf/prog_tests/test_global_funcs.c        |  13 ++
 .../bpf/progs/verifier_global_subprogs.c      | 164 ++++++++++++-
 5 files changed, 499 insertions(+), 39 deletions(-)

-- 
2.34.1


