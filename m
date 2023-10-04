Return-Path: <bpf+bounces-11361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CE07B7EB1
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EC7BB1C20987
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E8313ACA;
	Wed,  4 Oct 2023 12:07:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F64134DF;
	Wed,  4 Oct 2023 12:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A32C433C7;
	Wed,  4 Oct 2023 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696421238;
	bh=jiwF/a0PTTygMSsmAPMD6cp4z/ZqdiLgziTxoP11oDg=;
	h=From:To:Cc:Subject:Date:From;
	b=rmhaw58iLsxW4Gr3byt0TNlCS8nNUD+lr00+679s8fRwqPTX1BzNVjyUNvRsAqOR6
	 fjF0eI4lo/624C8zlX5D3Zn59FXHswT3peYewYJrafb9VvGNGSQmI+REoIsXYnoqyb
	 NEhNkcuePwm7Z83wDdogWISAVjyqI4bgwj57rbO4PQtOsDOnPLNNXCa81O53IcqDVm
	 fJb0uqHB8PtlbMQL2Au3r6YFBUidKXyOZWANR07KO+HGpK2Q1KkUuPDgNqWOw/MIgg
	 S0HnKWDJzv3aau/5AlwR9cOlDztikig1jXfHsQnZQlQDFNG0vS62lp7hiYxTCQEgLa
	 afMFOSqkw86jw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH bpf 0/2] riscv, bpf: Properly sign-extend return values
Date: Wed,  4 Oct 2023 14:07:04 +0200
Message-Id: <20231004120706.52848-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V architecture does not expose sub-registers, and hold all
32-bit values in a sign-extended format [1] [2]:

  | The compiler and calling convention maintain an invariant that all
  | 32-bit values are held in a sign-extended format in 64-bit
  | registers. Even 32-bit unsigned integers extend bit 31 into bits
  | 63 through 32. Consequently, conversion between unsigned and
  | signed 32-bit integers is a no-op, as is conversion from a signed
  | 32-bit integer to a signed 64-bit integer.

While BPF, on the other hand, exposes sub-registers, and use
zero-extension (similar to arm64/x86).

This has led to some subtle bugs, where a BPF JITted program has not
sign-extended the a0 register (return value in RISC-V land), passed
the return value up the kernel, e.g.:
    
  | int from_bpf(void);
  |
  | long foo(void)
  | {
  |    return from_bpf();
  | }

This series fixes this issue by keeping a pair of return value
registers; a0 (RISC-V ABI, sign-extended), a5 (BPF, zero-extended).

The following test_progs now pass, which were previously broken:

  | 13      bpf_cookie
  | 19      bpf_mod_race
  | 68      deny_namespace
  | 119     libbpf_get_fd_by_id_opts
  | 135     lookup_key
  | 137     lsm_cgroup
  | 284     test_lsm


Björn


Björn Töpel (2):
  riscv, bpf: Sign-extend return values
  riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values

 arch/riscv/net/bpf_jit_comp64.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)


base-commit: 9077fc228f09c9f975c498c55f5d2e882cd0da59
-- 
2.39.2


