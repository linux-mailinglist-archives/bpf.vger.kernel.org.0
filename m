Return-Path: <bpf+bounces-20342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE0F83CDD9
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90DB29AD75
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756361386CF;
	Thu, 25 Jan 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daEfV2r7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33211386C5
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216113; cv=none; b=sreH7wCaVPSAHVvuzXXc7wp2xLc5i++QaOiOP3Q12sdRFbqPIaKZN33xvh2KvRTv43GumhYAnLrlACXG9Bi/UIRcibZZtOn2dytLQI+ElentvsagfNSTQgtSPhGHfdSWWh50lgSIvs+zlZVAfxXQPfK/5mggF3hGQqK+wy64tDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216113; c=relaxed/simple;
	bh=yo02jNEvcWAcqatBwW8bc4FoY4bGIXaXVKX+pRApBPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HsrHBYqCW0AE8D5bzV+kq1SOdfDM0ckudTsJpKx69qpvIif1dJcJ/bWnCqq9Mrvpp35vZpyVny/sIh7BIUPYQKRVW/P/ncwptKEAOTKKnlZ9T7veawuyOHU/PYhD7IX5lgbtGVT/aL9zO1dLdlOeOLhDAt+3AStk3h8Z5i9tAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daEfV2r7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3B9C433F1;
	Thu, 25 Jan 2024 20:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706216112;
	bh=yo02jNEvcWAcqatBwW8bc4FoY4bGIXaXVKX+pRApBPs=;
	h=From:To:Cc:Subject:Date:From;
	b=daEfV2r7T+mFqtprKjt23GZrnDfbh+QF03oUw/4sqpodNAeWcXVj0zqvqDGRUhyiq
	 5nviWCGD2mIAosxVsAmJmlX6WOWUwVqUGCnqc2+DVQjo8in9c5zzVA8FhPwXiI/rvO
	 TS3IphN/dez33i2EQVt9Axw5Ty8cKg9mooUEbBH8k3BNllh6DValkgwxEihebmOhQq
	 rXoezWZQYae8HEhNHWyqRnVOMgT33a3BTmXRL4xHBF/ZXQbgs0Yfdu5EjvEDbul+9w
	 DpyQFxXJZhlAZ87t3FrWdK4U5Jm7Bi3L5mr4wOSyRQq1Of6pTIainyDkvBgHCbpV8c
	 66G/3Fi8dTPLA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/7] Trusted PTR_TO_BTF_ID arg support in global subprogs
Date: Thu, 25 Jan 2024 12:55:03 -0800
Message-Id: <20240125205510.3642094-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set follows recent changes that added btf_decl_tag-based argument
annotation support for global subprogs. This time we add ability to pass
PTR_TO_BTF_ID (BTF-aware kernel pointers) arguments into global subprograms.
We support explicitly trusted arguments only, for now.

First three patches are preparatory. Patches #1 and #3 does post-BPF token
code adjustments, to undo merge conflict avoidance measures. Patch #2 makes
PERF_EVENT type enforcement logic aligned with kernel-side logic.

Patch #4 adds logic for arg:trusted tag support on the verifier side. Default
semantic of such arguments is non-NULL, enforced on caller side. But patch #5
adds arg:maybe_null tag that can be combined with arg:trusted to make callee
explicitly do the NULL check, which helps implement "optional" PTR_TO_BTF_ID
arguments.

Patch #6 adds libbpf-side __arg_trusted and __arg_maybe_null macros. Patch #7
adds a bunch of tests validating __arg_trusted in combination with
__arg_maybe_null.

v1->v2:
  - added fix up to type enforcement changes, landed earlier;
  - dropped bpf_core_cast() changes, will post them separately, as they now
    are not used in added tests;
  - dropped arg:untrusted support (Alexei);
  - renamed arg:nullable to arg:maybe_null (Alexei);
  - and also added task_struct___local flavor tests (Alexei).

Andrii Nakryiko (7):
  libbpf: integrate __arg_ctx feature detector into kernel_supports()
  libbpf: fix __arg_ctx type enforcement for perf_event programs
  bpf: move arg:ctx type enforcement check inside the main logic loop
  bpf: add __arg_trusted global func arg tag
  bpf: add arg:maybe_null tag to be combined with trusted pointers
  libbpf: add __arg_trusted and __arg_maybe_null tag macros
  selftests/bpf: add trusted global subprog arg tests

 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/btf.c                              | 130 +++++++++++----
 kernel/bpf/verifier.c                         |  24 +++
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 tools/lib/bpf/features.c                      |  58 +++++++
 tools/lib/bpf/libbpf.c                        |  86 +++-------
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_global_ptr_args.c      | 156 ++++++++++++++++++
 9 files changed, 366 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c

-- 
2.34.1


