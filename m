Return-Path: <bpf+bounces-78160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29AD00098
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 21:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06563043558
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119AC3346B9;
	Wed,  7 Jan 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3wWllin"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D05236A73
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818440; cv=none; b=mvd/Bwgit0lF+OIPsy+ZaYMIs0CHZ3Ho5krYuXYyXK8s0W+5bIMfEXCmtc7+VwKi7hXhPOyVb+kjfTLdkZmy1yvhyzEaSqSygKg/jKqwsf5HjTPeVT8GLpk5ErxLpRxLj0hjfuup9in6OR5/MaA9EhS6Cn3/9u9qXWxBpuVl3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818440; c=relaxed/simple;
	bh=YGms/BPfyqA9p3mN94Fmnsa/PjI6bcYTJ2lyjmNidrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iyg0x9m1pIqM4rMgvda47irHAh5tcZud5k/noVn8CvzKYbLAFTR+jb1pgmhpTdo4vjeQzX3CoEQBv+YMbJ9mECC1Bwn181OtFmpgzwbNVCvUiG9FWqLI2mmu5Di/an9HaQD2Bbuuxakv1fAcdqrkfhs/ysvSutdICE/yMjLR4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3wWllin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60623C4CEF1;
	Wed,  7 Jan 2026 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818439;
	bh=YGms/BPfyqA9p3mN94Fmnsa/PjI6bcYTJ2lyjmNidrs=;
	h=From:To:Cc:Subject:Date:From;
	b=m3wWllin3D/MxysLVhK8rZ0GtZkUIl/joNgi73zN/3yYLguYJeXpUbCeYAX87IfEM
	 ebYJngnsptAvxhxHpbupSxnV32zRxLw15UkmUIT6C0sC00BFaNi9NAnT4/6QA63ENS
	 10t8eJ0UIqMuhDJGNZDcxvQEp1sTCWhNkCL8i8WjQN02rTT9LoFXbpDVRFgqnpchdh
	 C1LK3wX1BKoMsiaxj4N4mRPITgkf0Ss65DpqQoxPwSCLNa8jRMVwQvQWIx0MBw0791
	 aGORCanstfgNDVffKkHBJdRvGlCTut+SGSpkXuhczY5VRZ1515eNE54ImbnWgvUNZJ
	 eqXjlmZzuoSvg==
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
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/3] bpf: Improve linked register tracking
Date: Wed,  7 Jan 2026 12:39:33 -0800
Message-ID: <20260107203941.1063754-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the BPF verifier's linked register tracking to handle
negative offsets and BPF_SUB operations, enabling better bounds propagation for
common arithmetic patterns.

The verifier previously only tracked positive constant deltas between linked
registers using BPF_ADD. This meant patterns using negative offsets or
subtraction couldn't benefit from bounds propagation:

  r1 = r0
  r1 += -4
  if r1 s>= 0 goto ...   // r1 >= 0 implies r0 >= 4
  // verifier couldn't propagate bounds back to r0

Patch 1 extends scalar_min_max_add() to:
  - Accept BPF_SUB in addition to BPF_ADD (treating r1 -= 4 as r1 += -4)
  - Change the overflow check to properly validate s32 range
  - Add a guard against S32_MIN negation overflow
  - Retain the !alu32 restriction due to known issues with 32-bit ALU upper bits

Patches 2-3 update the selftests:
  - Patch 2 adds comprehensive tests covering success cases (negative offsets,
    BPF_SUB), failure cases (32-bit ALU, double ADD), and large delta edge cases
    (S32_MIN/S32_MAX offsets)
  - Patch 3 updates an existing test's expected output to reflect the new
    tracking behavior

Puranjay Mohan (3):
  bpf: Support negative offsets and BPF_SUB for linked register tracking
  selftests/bpf: Add tests for linked register tracking with negative
    offsets
  selftests/bpf: Update expected output for sub64_partial_overflow test

 kernel/bpf/verifier.c                         |  26 ++-
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../bpf/progs/verifier_linked_scalars.c       | 213 ++++++++++++++++++
 3 files changed, 233 insertions(+), 8 deletions(-)


base-commit: 2175ccfb93fd91d0ece74684eb7ab9443de806ec
-- 
2.47.3


