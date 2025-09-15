Return-Path: <bpf+bounces-68403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8267AB5820D
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C8D171335
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9012836B4;
	Mon, 15 Sep 2025 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKIuNec0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E526215F5C
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953733; cv=none; b=bHchZAgkAx5wnhyacscGM4b4qgTQWAtBTsxCuiarfNmRIY0vV1MBckFURGtuqOR6wyZG2/nBqBSBwEUt+BqBWvGuSMFVyvHt4dcIFVWmVbvwnVyB7IoQBEUIeeBQKsRHJKyNmOMcX6m1BOTa0uUwhGZNTNm/izoIqF3TIfjJM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953733; c=relaxed/simple;
	bh=VUcskqwLO9nj0euP/h7tOXi3yDZKkzN4373uQNCZBw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cizcNxlsVg/nToLSPci5GcX3EZxU+dqDJ0NVOyhUeAQScvHgOEaRwU0fqkM/7y1SYT3XEnudhnmoNz4J+zkIY6swBB8Uh0ILyFL0VdSFwm0o4Clp+A/h3XUxEeIRImG+8GRjsTT8LFjR7f2kdMnuRitSPG5fQ7abn7UN9ShDrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKIuNec0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD80C4CEF1;
	Mon, 15 Sep 2025 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757953732;
	bh=VUcskqwLO9nj0euP/h7tOXi3yDZKkzN4373uQNCZBw8=;
	h=From:To:Cc:Subject:Date:From;
	b=GKIuNec0liPdysCkDgzlZFAjM0EvdX7JOyky7Cp/NlrswVtTrFdfMQLPJyUzqMp3H
	 MIH/Z4ZKfqrutdHTqnOQEMp/LrExJ4U9Un/Qsd0fWe6XRTjvsgNAFYtjt4JJmD7Mo+
	 03P1aUqH0p217mUieJs0h8CDhmlpnhV6aghtj5tsFJuU1fE+/3acmrLidn8hm/4/b/
	 ICmVAVkQtaj0uWiaoJ7DGiNXvlpwg/q/cLz0z3g1Zb9B13/ZRQdmIr0agtzu4Lu3QF
	 UVjTSzejVIKdP4FwIiC8hzivrmksYjryoL3KksILbQqucufzjSV3VlBepZn0AMdByZ
	 51cziguoD3mfQ==
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
Subject: [PATCH bpf-next v3 0/3] Signed loads from Arena
Date: Mon, 15 Sep 2025 16:28:44 +0000
Message-ID: <20250915162848.54282-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1 -> v2:
v1: https://lore.kernel.org/bpf/20250509194956.1635207-1-memxor@gmail.com
- Use bpf_jit_supports_insn. (Alexei)

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
 arch/s390/net/bpf_jit_comp.c                  |   5 +
 arch/x86/net/bpf_jit_comp.c                   |  35 +++-
 include/linux/filter.h                        |   3 +
 kernel/bpf/verifier.c                         |  11 +-
 .../selftests/bpf/progs/verifier_ldsx.c       | 176 ++++++++++++++++++
 6 files changed, 243 insertions(+), 12 deletions(-)

-- 
2.47.3


