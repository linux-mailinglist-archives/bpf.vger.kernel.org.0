Return-Path: <bpf+bounces-77676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A13CEECF4
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49ECF300B910
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D20621CA02;
	Fri,  2 Jan 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DabqC3OW"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AF1F16B
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366106; cv=none; b=qf76r4CC3xKqxzgygmv4pV/A59G71Cz8I1geqdkQbuSoxL52+EWlPGRE5RNgej9qlYpU6B83zwEXalz7NWLCGzgbVWGZrilP2lg1hQYQc5xRoRJ6UMljYY84b5jZ3+kuAlKGT6hUetXgnSvHQhaalGM++UzDfB+y+abrakr9qj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366106; c=relaxed/simple;
	bh=3/STyZQ6KuX+xvZ6JTum6U+Nz29JODH6abBJ4FGY2Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWNVoiFtgTgIk1bofSGaubdWv9CWYgKj7qM6XFrPFbozksjUIFoolu34Qatuv+uePX+ugz9eLSUrqIeJ9txdzM3H3I3smdMY21hg+bdWVMZFkba0yHg6YhvvEuCJzovOZpi2u5OipL9h+dRCELepU6THqlOSAmr25JUq7rgegWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DabqC3OW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767366101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BiRCJtw4ELvsXjmY6Q3y3Drgdzip5X30NSHjEWzRHx0=;
	b=DabqC3OWDAIBs9M6SPPDyL32w6/4Fhiq9+8+V0B+dkhXafrqj6RoOvDXCi0nKj/H2LekNl
	tlQzcLDVBn687MtMndiRNxC1ZzpwZClYqefHi4YPuV0sNwc+md5/3/c+HmKCGAB7DyFCJm
	69TpO5x1z1/hNGYzoQQSeSL8q63O0v8=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and bpf_func access at runtime
Date: Fri,  2 Jan 2026 23:00:28 +0800
Message-ID: <20260102150032.53106-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series optimizes BPF tail calls on x86_64 and arm64 by
eliminating runtime memory accesses for max_entries and 'prog->bpf_func'
when the prog array map is known at verification time.

Currently, every tail call requires:
  1. Loading max_entries from the prog array map
  2. Dereferencing 'prog->bpf_func' to get the target address

This series introduces a mechanism to precompute and cache the tail call
target addresses (bpf_func + prologue_offset) in the prog array itself:
  array->ptrs[max_entries + index] = prog->bpf_func + prologue_offset

When a program is added to or removed from the prog array, the cached
target is atomically updated via xchg().

The verifier now encodes additional information in the tail call
instruction's imm field:
  - bits 0-7:   map index in used_maps[]
  - bits 8-15:  dynamic array flag (1 if map pointer is poisoned)
  - bits 16-31: poke table index + 1 for direct tail calls

For static tail calls (map known at verification time):
  - max_entries is embedded as an immediate in the comparison instruction
  - The cached target from array->ptrs[max_entries + index] is used
    directly, avoiding the 'prog->bpf_func' dereference

For dynamic tail calls (map pointer poisoned):
  - Fall back to runtime lookup of max_entries and prog->bpf_func

This reduces cache misses and improves tail call performance for the
common case where the prog array is statically known.

Leon Hwang (4):
  bpf: tailcall: Introduce bpf_arch_tail_call_prologue_offset
  bpf, x64: tailcall: Eliminate max_entries and bpf_func access at
    runtime
  bpf, arm64: tailcall: Eliminate max_entries and bpf_func access at
    runtime
  bpf, lib/test_bpf: Fix broken tailcall tests

 arch/arm64/net/bpf_jit_comp.c | 71 +++++++++++++++++++++++++----------
 arch/x86/net/bpf_jit_comp.c   | 51 ++++++++++++++++++-------
 include/linux/bpf.h           |  1 +
 kernel/bpf/arraymap.c         | 27 ++++++++++++-
 kernel/bpf/verifier.c         | 30 ++++++++++++++-
 lib/test_bpf.c                | 39 ++++++++++++++++---
 6 files changed, 178 insertions(+), 41 deletions(-)

--
2.52.0


