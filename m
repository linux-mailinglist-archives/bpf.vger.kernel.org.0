Return-Path: <bpf+bounces-70056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBADBAE9D3
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 23:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E35F16F636
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AC29D281;
	Tue, 30 Sep 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOLpYIjY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80004246332
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267594; cv=none; b=W4egBQuBj316HD03iFo6JeWuH5hsJznWAqqqXofsL8TpaFy3hnCNAq93+Bkxz3Z6zIHWVwM/mhCeRs6+s4AjlbDw3pIkJ2T4nL4/Qux+WXnRhSj22mgfp5451xYqDvrRfOY7ByFeJsz17APSAvH3Bf37/9YBGTnBtbCL6ZqjFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267594; c=relaxed/simple;
	bh=pZ6hN1vODeDkDdpepsUndFVWMJ5dvgJslYdYbdfalL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scwWQoL2OfcImufrq+PKehNjY5GMT1GL4ur+J/8l01WO0knJ47ZL78EFhcNMqjYmr2T+EyrPj4E6ACJn5EUL0EFnizNymVyFu5AN2+PdWYAn37d5bvVB1b+tGzRIszR6NBoiZrv3hrojRItyEdt7OVW/OEyyXJfy/39xlTKF3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOLpYIjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A0CC4CEF0;
	Tue, 30 Sep 2025 21:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759267593;
	bh=pZ6hN1vODeDkDdpepsUndFVWMJ5dvgJslYdYbdfalL8=;
	h=From:To:Cc:Subject:Date:From;
	b=qOLpYIjYSGxouVpgMtPXUYfM84io3iiPVmwuIUnTdyh7QRwf3nkWbXUJZq2mE4OD0
	 FdpzzQ5XPti7VrJos+r2VQxPZbOdr4GSoMR8GS/7vxElnyGcpr14uNoi6czyJv3UUH
	 m+0kiU6zjnk3UJnrfMoU/QQH4nIBdeRtifLlEKo9SrRjw78IpYz67JXbJQFQzq99V2
	 l5QxbxDdC1TE4gfqH6BE00o1SZ8wZl9F+9MBvTOiIbpu2LqBhf/CpBSSTGCGzEUyVA
	 v6wX+wF5AuZKWy8GHyBtMfdw9RnC37esl/ujturX7zFDdIM3nES3YYngvQeA1AMsHW
	 uqWvM1WM2Rr3g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/5] libbpf: fix libbp_sha256() for Github compatibility
Date: Tue, 30 Sep 2025 14:26:14 -0700
Message-ID: <20250930212619.1645410-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent reimplementation of libbpf_sha256() introduced issues for libbpf's
Github mirror due to reliance on linux/unaligned.h header. This patch set
fixes those issues to make libbpf source code compatible with Github mirror
setup.

This patch set starts with a bit of organization: we introduce libbpf_utils.c
as a place for generic internal helpers like libbpf_errstr() and
libbpf_sha256(), and move a few existing helpers there. We also clean up
libbpf_strerror_r(), which seems to be a leftover of some previous
refactorings.

And finally, we move libbpf_sha256() from huge libbpf.c into libbpf_utils.c,
following up with fix ups to make its code more Github-friendly.

Andrii Nakryiko (5):
  libbpf: make libbpf_errno.c into more generic libbpf_utils.c
  libbpf: remove unused libbpf_strerror_r and STRERR_BUFSIZE
  libbpf: move libbpf_errstr() into libbpf_utils.c
  libbpf: move libbpf_sha256() implementation into libbpf_utils.c
  libbpf: remove linux/unaligned.h dependency for libbpf_sha256()

 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/btf.c             |   1 -
 tools/lib/bpf/btf_dump.c        |   1 -
 tools/lib/bpf/elf.c             |   1 -
 tools/lib/bpf/features.c        |   1 -
 tools/lib/bpf/gen_loader.c      |   3 +-
 tools/lib/bpf/libbpf.c          | 101 -------------
 tools/lib/bpf/libbpf_errno.c    |  75 ----------
 tools/lib/bpf/libbpf_internal.h |  15 ++
 tools/lib/bpf/libbpf_utils.c    | 249 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/linker.c          |   1 -
 tools/lib/bpf/relo_core.c       |   1 -
 tools/lib/bpf/ringbuf.c         |   1 -
 tools/lib/bpf/str_error.c       | 104 -------------
 tools/lib/bpf/str_error.h       |  19 ---
 tools/lib/bpf/usdt.c            |   1 -
 16 files changed, 266 insertions(+), 310 deletions(-)
 delete mode 100644 tools/lib/bpf/libbpf_errno.c
 create mode 100644 tools/lib/bpf/libbpf_utils.c
 delete mode 100644 tools/lib/bpf/str_error.c
 delete mode 100644 tools/lib/bpf/str_error.h

-- 
2.47.3


