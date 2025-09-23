Return-Path: <bpf+bounces-69379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B8B958D3
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0196E3BAC47
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376632142E;
	Tue, 23 Sep 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWHfkpvx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BD321262
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625350; cv=none; b=GOxBvxVLD03BoGCKj03yBUBQx7U1ecPo0BmPDVmiwc+vFb6E7BAiWagLVSBbZMcynLcDnvDzKpid/mv6oZCJu2gutoh9nXea8OzloaQvzRmxGzgMUyTKbqE+jD4zWVN3u+PLbUz/7r1IjfvZVLfLrr5CNKtBqnrjRX6S8xIUqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625350; c=relaxed/simple;
	bh=NH4s3AN2ZmwkKDKs+DklvVPFVNoCcxlQ5tgFRWqrWsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZG9JRBdGuCHnJCCUAdefglOUlIQHA2TXCkIo0bPGpIsJmxGem6prdnCsZh55rD3x6nevw/s+EcYYcxnEvOFcNmoXz0tQWkfsFwOVA8IIu63f/SJ93wKQaoHXCxM+tQvIw1esfUxbSkW8rrdSvURYicS+JYopRr9BfTAf37kU4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWHfkpvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE6C4CEF5;
	Tue, 23 Sep 2025 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758625348;
	bh=NH4s3AN2ZmwkKDKs+DklvVPFVNoCcxlQ5tgFRWqrWsg=;
	h=From:To:Cc:Subject:Date:From;
	b=dWHfkpvxpZZq2ebn2ev4ZLWA/RlEG8a6qlIYHqREmYABlo01RtJ7djqk7DVUCNNFO
	 utxeB6Vnl/dWawtVk8xPrN3RlpX46sUyP3jSs4F3QRoCwAcSRbQPT1Tnior1c3SxRs
	 zBBtoAWFSU+FVxhA9XFJ/m3Okv4PTj70QXKhVwuB0gW2lm+4aBZLLueW6OL8qH55aF
	 NmT+4CAdlI3yH96gjRnp8iW6dF+veqTDlU94RNHLMrMnXvT3KlJzP8dUI3JeiQyWN/
	 /ppuZDVHu9mMUH5w7eknDCKDrRJ9bZMcxlKp3W5XAtL1xy0oE6t79LrhpN8o2VlfR3
	 j2/xbfJTwG9Vw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 0/3] Signed loads from Arena
Date: Tue, 23 Sep 2025 11:01:48 +0000
Message-ID: <20250923110157.18326-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:

v3 -> v4:
v3: https://lore.kernel.org/all/20250915162848.54282-1-puranjay@kernel.org/
- Update bpf_jit_supports_insn() in riscv jit to reject signed arena loads (Eduard)
- Fix coding style related to braces usage in an if statement in x86 jit (Eduard)

v2 -> v3:
v2: https://lore.kernel.org/bpf/20250514175415.2045783-1-memxor@gmail.com/
- Fix encoding for the generated instructions in x86 JIT (Eduard)
  The patch in v2 was generating instructions like:
        42 63 44 20 f8     movslq -0x8(%rax,%r12), %eax
  This doesn't make sense because movslq outputs a 64-bit result, but
  the destination register here is set to eax (32-bit). The fix it to
  set the REX.W bit in the opcode, that means changing
  EMIT2(add_3mod(0x40, ...)) to EMIT2(add_3mod(0x48, ...))
- Add arm64 support
- Add selftests signed laods from arena.

v1 -> v2:
v1: https://lore.kernel.org/bpf/20250509194956.1635207-1-memxor@gmail.com
- Use bpf_jit_supports_insn. (Alexei)

Currently, signed load instructions into arena memory are unsupported.
The compiler is free to generate these, and on GCC-14 we see a
corresponding error when it happens. The hurdle in supporting them is
deciding which unused opcode to use to mark them for the JIT's own
consumption. After much thinking, it appears 0xc0 / BPF_NOSPEC can be
combined with load instructions to identify signed arena loads. Use
this to recognize and JIT them appropriately, and remove the verifier
side limitation on the program if the JIT supports them.

Kumar Kartikeya Dwivedi (1):
  bpf, x86: Add support for signed arena loads

Puranjay Mohan (2):
  bpf, arm64: Add support for signed arena loads
  selftests: bpf: Add tests for signed loads from arena

 arch/arm64/net/bpf_jit_comp.c                 |  25 ++-
 arch/riscv/net/bpf_jit_comp64.c               |   5 +
 arch/s390/net/bpf_jit_comp.c                  |   5 +
 arch/x86/net/bpf_jit_comp.c                   |  40 +++-
 include/linux/filter.h                        |   3 +
 kernel/bpf/verifier.c                         |  11 +-
 .../selftests/bpf/progs/verifier_ldsx.c       | 176 ++++++++++++++++++
 7 files changed, 251 insertions(+), 14 deletions(-)

-- 
2.47.3


