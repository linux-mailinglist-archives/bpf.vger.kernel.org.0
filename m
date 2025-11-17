Return-Path: <bpf+bounces-74730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A13C6448B
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8233A486E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC11DF27D;
	Mon, 17 Nov 2025 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb9mWRB+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78332ED27
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384863; cv=none; b=KHaTjcvfcAKy6aPrKLMdw1XapHhxuwmjMG/rIq1JXM60NUv4CSuDMvm+STrbafsr9eKi6U2B4Rw6Ua0WTdRazpGGmPsk4/U+2Z7nWL/yDXDjA3J2FMXHmO9MICT/UhTsVHPzs6AbfxVzfJvvUYuxc+DnuWJZMIB7SAZ7bWGhLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384863; c=relaxed/simple;
	bh=X86uQTpfJsiPm2K17wjCx9NakuyUu15A8mbWKYS4hnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZqYTapy3z17KMraQjXH7odMZj52zMBgukIl0AJDzfZb3fnIlmAKuMA/L4u2BlxIPIq1OdllPtqvePRi5/NPEgEI3FQpMdpjFKhxrldzJYnWX3dE3B5931hXDXfrd/PZPeIv2N93tbgtW6Us186SJ63+TocPG/y+AIwrR1XKFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb9mWRB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6448C4CEF1;
	Mon, 17 Nov 2025 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763384863;
	bh=X86uQTpfJsiPm2K17wjCx9NakuyUu15A8mbWKYS4hnU=;
	h=From:To:Cc:Subject:Date:From;
	b=kb9mWRB+oE0259dy6gqTHaNvn0bteRZB20GMDiQeivEACc0v0+JxYl1JcMIkN5ETW
	 i2Te+V3F8pZkglMBzKG6yAvXtScrI3jhcXj7eqlRJpwHoMjHcE+CwIhXsBpHjzWOPS
	 5SCCUneZU0Z7uwrbPoP6kPjCvZ2SKqzwDVd6wE1rnQ8eeSiojOFykmwY2q/wskIsZL
	 9vrebDtAb67Dv++siBdQ0HZSEty2m41npLn8oG76AeC+HIRsQw3DfFCwpElJSHzmjA
	 lid7rEuGUAsicjgqcO/dITTkVxj0zS6YaW0mUOKDnT3ErRp/3THCmmK3o7T3L79tC+
	 6PmK8hu/1H2zw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] bpf: arm64: Indirect jumps
Date: Mon, 17 Nov 2025 13:07:28 +0000
Message-ID: <20251117130732.11107-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v1->v2:
v1: https://lore.kernel.org/all/20251117004656.33292-1-puranjay@kernel.org/
- Dropped patch 3 that was ignoring relocations for .jumptables. LLVM
  has been fixed to not emit relocations for .jumptables, so this patch
  is not needed.
- Added Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

This set adds the support of indirect jumps to the arm64 JIT. It
involves calling bpf_prog_update_insn_ptrs() to support instructions
array map. The second piece is supporting BPF_JMP|BPF_X|BPF_JA, SRC=0,
DST=Rx, off=0, imm=0 instruction that is trivial to implement on arm64.

The final patch enables selftests on arm64:

 [root@localhost bpf]# ./test_progs-cpuv4 -a "*gotox*"
 #20/1    bpf_gotox/one-switch:OK
 #20/2    bpf_gotox/one-switch-non-zero-sec-offset:OK
 #20/3    bpf_gotox/two-switches:OK
 #20/4    bpf_gotox/big-jump-table:OK
 #20/5    bpf_gotox/static-global:OK
 #20/6    bpf_gotox/nonstatic-global:OK
 #20/7    bpf_gotox/other-sec:OK
 #20/8    bpf_gotox/static-global-other-sec:OK
 #20/9    bpf_gotox/nonstatic-global-other-sec:OK
 #20/10   bpf_gotox/one-jump-two-maps:OK
 #20/11   bpf_gotox/one-map-two-jumps:OK
 #20      bpf_gotox:OK
 #537/1   verifier_gotox/jump_table_ok:OK
 #537/2   verifier_gotox/jump_table_reserved_field_src_reg:OK
 #537/3   verifier_gotox/jump_table_reserved_field_non_zero_off:OK
 #537/4   verifier_gotox/jump_table_reserved_field_non_zero_imm:OK
 #537/5   verifier_gotox/jump_table_no_jump_table:OK
 #537/6   verifier_gotox/jump_table_incorrect_dst_reg_type:OK
 #537/7   verifier_gotox/jump_table_invalid_read_size_u32:OK
 #537/8   verifier_gotox/jump_table_invalid_read_size_u16:OK
 #537/9   verifier_gotox/jump_table_invalid_read_size_u8:OK
 #537/10  verifier_gotox/jump_table_misaligned_access:OK
 #537/11  verifier_gotox/jump_table_invalid_mem_acceess_pos:OK
 #537/12  verifier_gotox/jump_table_invalid_mem_acceess_neg:OK
 #537/13  verifier_gotox/jump_table_add_sub_ok:OK
 #537/14  verifier_gotox/jump_table_no_writes:OK
 #537/15  verifier_gotox/jump_table_use_reg_r0:OK
 #537/16  verifier_gotox/jump_table_use_reg_r1:OK
 #537/17  verifier_gotox/jump_table_use_reg_r2:OK
 #537/18  verifier_gotox/jump_table_use_reg_r3:OK
 #537/19  verifier_gotox/jump_table_use_reg_r4:OK
 #537/20  verifier_gotox/jump_table_use_reg_r5:OK
 #537/21  verifier_gotox/jump_table_use_reg_r6:OK
 #537/22  verifier_gotox/jump_table_use_reg_r7:OK
 #537/23  verifier_gotox/jump_table_use_reg_r8:OK
 #537/24  verifier_gotox/jump_table_use_reg_r9:OK
 #537/25  verifier_gotox/jump_table_outside_subprog:OK
 #537/26  verifier_gotox/jump_table_contains_non_unique_values:OK
 #537     verifier_gotox:OK
 Summary: 2/37 PASSED, 0 SKIPPED, 0 FAILED

Puranjay Mohan (3):
  bpf: arm64: Add support for instructions array
  bpf: arm64: Add support for indirect jumps
  selftests: bpf: Enable gotox tests from arm64

 arch/arm64/net/bpf_jit_comp.c                      | 11 +++++++++++
 tools/testing/selftests/bpf/progs/verifier_gotox.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.47.1


