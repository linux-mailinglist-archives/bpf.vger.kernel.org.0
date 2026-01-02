Return-Path: <bpf+bounces-77705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6EFCEF2C0
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA26630198D7
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005EB24634F;
	Fri,  2 Jan 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY1t4HWT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB11EEBB
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377619; cv=none; b=p36eWgqZOnddHq9FGyEc+uw8xZaEkhMVdYsg+8h4wrUOIPNA480Uj6jAr9NRbKUXqWQt0CeQJBDdHl5I9cTIFyj2KOphJaFovR9A89TMtHUmK1b2k7dWVV6pOBu4K3k4vZrvKvpuFMkqIcm1X+jbSfB3KdAPJIrUlxhEX79wdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377619; c=relaxed/simple;
	bh=v1fL9HgYVS5GXJMnZPan+Z0+ztcY6cgHf4xYcxkuRE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POlc3omkPZiMnptxSNRfsS5GxlLV35iF8lKNbvp8nTSQuf/L1BhzV4P0gIuQkamMfDZssnvzcIowdj+ARdFyQDr6H/DJfjOBGFQOzxipMMYozaqJrW6jZXNTfcNDHJOVPgK4HvWNRK7y6am/3YFcXDc4DcWMNrYJdxKuCJD2Kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY1t4HWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295F9C116B1;
	Fri,  2 Jan 2026 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767377619;
	bh=v1fL9HgYVS5GXJMnZPan+Z0+ztcY6cgHf4xYcxkuRE4=;
	h=From:To:Cc:Subject:Date:From;
	b=KY1t4HWTrnVyt6Jaxuz88x3IlhKdlYMlTC5QoVltfnTO9HgdECMkqEdubfjM+JgX1
	 nJluTGvwQxVevySQaomH22E50GXrjGnkNBlmILkI8N1EU0CN15klqeUzPtJqLjloyB
	 Dz+YFVvtFrOKXUCqGh2qpffYyCKpoAl9Ug7SLrUfz7wltWnK2tZAbzCL3ZvKz0+wkc
	 J+Q7GFWY0Ry0OdNPTSLgoFdYzLTlNRSn9P1GYCdv+/2t8LlZXeRNJuFZfumaPRgF7j
	 kt4wVLidpqcANwbBQs5IvXWfgOiaYO+E8GtsYvXbgg+nTkSuF/eSoUIVHao8sl9vu3
	 koeGwJISFCoCQ==
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
Subject: [PATCH bpf-next v4 0/2] memcg accounting for BPF arena
Date: Fri,  2 Jan 2026 10:13:30 -0800
Message-ID: <20260102181333.3033679-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 kernel/bpf/arena.c      | 29 ++++++++++++++++++++---
 kernel/bpf/range_tree.c |  5 ++--
 kernel/bpf/syscall.c    | 52 +++++++++++++++++++----------------------
 4 files changed, 68 insertions(+), 33 deletions(-)


base-commit: c286e7e9d1f1f3d90ad11c37e896f582b02d19c4
-- 
2.47.3


