Return-Path: <bpf+bounces-19743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07243830D78
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 20:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1911C219A2
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 19:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B44A24A03;
	Wed, 17 Jan 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAEoVGKo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562A249FD
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521134; cv=none; b=QDPwkdcdh+UXFEGBh4e5Ng6+VIvKatSujOldgWxXab6xF6DI0G2Jcf26tI56FaCJCcnkuDd89QT7Fxy0ayJTqk7SoK3mrhL4jvxBsu5bWgSlkA/TTk+bUIw6xNyiZDFzHsc7uL4xEWCzun0sdCdydvxxjV/B9lOw7c0bqSYLniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521134; c=relaxed/simple;
	bh=5kgq2f3PJsduiEOX5jpnY6Z/Z27IQJZmEDxbpHrBjqE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=J8QJ/jYVbWVpVY+GwbQ1hoFhIPOSj+b+bCofS6fewpNZGEVyEzxf6SCT5YlXtRaUpJbUxzvKf1DPTTNCSLc40nd5O7uuV3a8V41PJ9uhPUe4xaw03baP6Sr4u1j77s2YObAbNxgzMtXNYrhyshqC5F0twd0IRQAQMy3uszvbKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAEoVGKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66161C433F1;
	Wed, 17 Jan 2024 19:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521133;
	bh=5kgq2f3PJsduiEOX5jpnY6Z/Z27IQJZmEDxbpHrBjqE=;
	h=From:To:Cc:Subject:Date:From;
	b=nAEoVGKovWK/Shyk8Kv2lmmzzBROPOe2JgPMhHqkllHwTHJ6HOcPpVXsLOM7buiW7
	 ICAzKglrxaQPB2faD7rsjmTbfazZKzpoddOJRJhJC4xrsFXYOwZAcNcfPSFqOvxS6X
	 tgqOHpbSdGvHW1wC2N0ZsWqQ/U7sHVNfW9FBavsP3sTpFWW3G2i1lwjysjm7bqwuIT
	 8UqPg0DFkRP1zy4rUTDGZc4ZBUzIxbeM04jgB51gRkTrDuPyVs1Jdv+alK6ywkHenb
	 3XN1FnY4H/ChR1TlOHg2Rbo8sUECD0gRlEDhAzdb84LRYkdT4wYWqWl2TS60nXflxk
	 RI6SdJIvJP7AA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 0/5] Tighten up arg:ctx type enforcement
Date: Wed, 17 Jan 2024 11:52:05 -0800
Message-Id: <20240117195210.739597-1-andrii@kernel.org>
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

Andrii Nakryiko (5):
  libbpf: feature-detect arg:ctx tag support in kernel
  bpf: extract bpf_ctx_convert_map logic and make it more reusable
  bpf: enforce types for __arg_ctx-tagged arguments in global subprogs
  selftests/bpf: add tests confirming type logic in kernel for __arg_ctx
  libbpf: warn on unexpected __arg_ctx type when rewriting BTF

 include/linux/btf.h                           |   2 +-
 kernel/bpf/btf.c                              | 200 +++++++++++++++---
 tools/lib/bpf/libbpf.c                        | 141 +++++++++++-
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../bpf/prog_tests/test_global_funcs.c        |  13 ++
 .../bpf/progs/verifier_global_subprogs.c      | 164 +++++++++++++-
 6 files changed, 483 insertions(+), 39 deletions(-)

-- 
2.34.1


