Return-Path: <bpf+bounces-77711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94054CEF412
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 318253010A8D
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0765B26E718;
	Fri,  2 Jan 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4UdWyHe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AB1E0DE8
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384164; cv=none; b=DfBop0mu4ddQpp8ip0wjy2w+/R1tRX+Nkf3ntVcGFfvvGxJ8ktT09OQzGZQ/3mNfqk9ZYZK2aaKk0R4ApSPIYwsC2qqwWRN+TsjEMbk3SHPR72TC9ijp1CkbtgGBLIn9QA402BMEVA3/MB/ym1+A+UgP2D70fyIZXZbaBejjSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384164; c=relaxed/simple;
	bh=CNtEoNGItYHlwumBzryKgY4RTN8xfOmVs84+I4duClk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dol+qb0w6PRuvlP0STdtvifhRebMwqX4dofeYzhDUT9qU8vcZ+LV8AjEvPrh8ATaIWsOPiZMLO247UimYCBb9lEswKesCMhHRmbZUD1OWbm89POR3/EBIYkFSEp7Hwu5nzqybgCsQ0uDQxIOine5nNBCCqqAhnv9dBVnqMzEbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4UdWyHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA586C116B1;
	Fri,  2 Jan 2026 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767384164;
	bh=CNtEoNGItYHlwumBzryKgY4RTN8xfOmVs84+I4duClk=;
	h=From:To:Cc:Subject:Date:From;
	b=B4UdWyHeewyo6RijMDQbL0SzGOqmWn44yF/fiPE0d1WH8ktDPYb+kAsHWtB6cW/y8
	 Kjxw89ate1knq6EHaMk6T8S+r7TYFOziIecxqXvJumfXZOp2xTMZIWlFNpHPP9eflm
	 6lzz2GENomJJ9lgMbMxT/LTOIAfL3l/8E2O8LpNE+OKMC1sQcOqy7KlCfeSvJoQN4O
	 2/5eBrfgcCo6UgqJArZExj5qYajnaiNaMjgzb3DSX4QaP6hLnOnZIqpTdbtI43ZuYW
	 He50TDl5azflOBkKwWh2THpJNdonxdfRntIQTFx2EE9YZGH0r0tnSxQV3dAR1Qsz6i
	 XCEcVtTG0FYyg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 0/2] memcg accounting for BPF arena
Date: Fri,  2 Jan 2026 12:02:26 -0800
Message-ID: <20260102200230.25168-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4: https://lore.kernel.org/all/20260102181333.3033679-1-puranjay@kernel.org/
Changes in v4->v5:
- Remove unused variables from bpf_map_alloc_pages() (CI)

v3: https://lore.kernel.org/all/20260102151852.570285-1-puranjay@kernel.org/
Changes in v3->v4:
- Do memcg set/recover in arena_reserve_pages() rather than
  bpf_arena_reserve_pages() for symmetry with other kfuncs (Alexei)

v2: https://lore.kernel.org/all/20251231141434.3416822-1-puranjay@kernel.org/
Changes in v2->v3:
- Remove memcg accounting from bpf_map_alloc_pages() as the caller does
  it already. (Alexei)
- Do memcg set/recover in arena_alloc/free_pages() rather than
  bpf_arena_alloc/free_pages(), it reduces copy pasting in
  sleepable/non_sleepable functions.

v1: https://lore.kernel.org/all/20251230153006.1347742-1-puranjay@kernel.org/
Changes in v1->v2:
- Return both pointers through arguments from bpf_map_memcg_enter and
  make it return void. (Alexei)
- Add memcg accounting in arena_free_worker (AI)

This set adds memcg accounting logic into arena kfuncs and other places
that do allocations in arena.c.

Puranjay Mohan (2):
  bpf: syscall: Introduce memcg enter/exit helpers
  bpf: arena: Reintroduce memcg accounting

 include/linux/bpf.h     | 15 ++++++++++++
 kernel/bpf/arena.c      | 29 +++++++++++++++++++---
 kernel/bpf/range_tree.c |  5 ++--
 kernel/bpf/syscall.c    | 53 +++++++++++++++++++----------------------
 4 files changed, 68 insertions(+), 34 deletions(-)


base-commit: c286e7e9d1f1f3d90ad11c37e896f582b02d19c4
-- 
2.47.3


