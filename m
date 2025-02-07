Return-Path: <bpf+bounces-50714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3318FA2B893
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5BE166D9C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D0F145A0B;
	Fri,  7 Feb 2025 02:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LB1xS+PU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96A2154C05
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893903; cv=none; b=LWz1MYAw+Ixt1rhucUQrMg6qklkRxdBbPcLz3hdwh4nwRd9rhcjF+LKenRXMi+Kl8K2dsVFe9jPywfpZvKFC3aiQ4LnNRNppPUUi8pW9Gx7hB9Bii9X6XrI62hQsMdJqOPLwej5flIHxlpmWys6BksHDBS5RHTLE4rvoHwppDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893903; c=relaxed/simple;
	bh=w1bV79e7Lf0EXtksIfnG/vhdBZ2q+XT8RMia2w7ph18=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eIeLQXWNBE+ux1YwD48nlF3HBc+1qltajIMDrI8fR2ZRlTF+jR+1I7evVDOgFIN5bdANO+qDxgFaZwPMZQO0XTW+/rI+WI+dLcvOWmnxH5KD4gLYzvMarLE/RmBY/eJcbDBPm41o0SN3dUY9hyAmx6YUUGywm8cYv1wGBm8PtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LB1xS+PU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f9c5b046d0so3346696a91.0
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 18:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738893901; x=1739498701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqLAn/53hD5bzHEF3DH1g9kKveGsXY5lagU+X8oybEw=;
        b=LB1xS+PUXXv3aq1MtY9TptKv7AZgzoNriNknnu/Ajyt7JANEBaCnfQICVm8J9Vi9TK
         JnVGbnubIANAaX07gGSjnWfRGcguv8743w1YExXxGLIvvA5TJBDu95TjX2c4voM533S+
         3ETy3GhVZxlw4phUI6ca6OfS8s5I9FJxAznJsaiL2ouYDBKqAxSjVgVJgmyTOb/cR2HF
         96HrEJyS2fhFgL6vczKOi8+vJ2+6P8vG1q5zae7zra3X6e1398IH49gk/c1cQIYLmbtV
         TnxQlhRSrt4E6aNdlfnWvmMVM6qYo7sz2VppSH8QOG8iDZHsHQM4ypZLhC83IJD/mY+j
         FDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738893901; x=1739498701;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqLAn/53hD5bzHEF3DH1g9kKveGsXY5lagU+X8oybEw=;
        b=n1zC6yViPZbjERoJlLehujNbi5wTgNyVfouvKOexZCvwvpY2sziDAXP/JTmA/MhhwN
         fbhOoiGysD5tUwgpMWH8l+Ff8IMViRaK65ikVAHuRCSkfVyDkVQXSD3SZHXsqwRVFxb6
         UyIUP5k99ZgIhKbHtow5sfNHu9VV6lASAZVDMohUQeVHe3zP6VupRr7mqZ66g74jKKR3
         rzZPAqNsiSg1hjXP31rOEp7qqszFdSzPVkCarZVqryDguEP+7cGimwtlGg8qYvtiQCGu
         6LH5YPNLBx00xKAFChXXHegEe5+dsmx9n38uUUpZzDV1IkHCSI7n4kLJCaPfZSpYVGjR
         yJLw==
X-Gm-Message-State: AOJu0YwPaWNTh/ATdqIJXzcFvGkGp+Xqy2AOs7/g8cYp7XiFzSFWku2R
	HqC5MK08dGqjDuK1Aq1N29qrryppZP3BkSakneppsy+zFoEGd+jPMAfzKz1Jl9skHGmgKzUjxZL
	cTcp32/Ns0Iq7jPhlC6sC6DKr4oKAYzqoef0FQn/funcyX65uQuBGQYZCn/Tuz1Na6QMHOkNKyn
	V5dKAA9EKpb2Pus4xsvLQor4AtCfSpdpEMjyqTeSY=
X-Google-Smtp-Source: AGHT+IFI+zjtKAOB2+wQvSyOruCXfpfwBdWdB7zywXf/dZud1XWE0JoQzOJjfbv2/vxSfhxiEaFJeYbvg0pWGQ==
X-Received: from pfey8.prod.google.com ([2002:a62:b508:0:b0:728:958a:e45c])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9283:b0:72a:bcc2:eefb with SMTP id d2e1a72fcca58-7305d421c08mr2090191b3a.2.1738893900877;
 Thu, 06 Feb 2025 18:05:00 -0800 (PST)
Date: Fri,  7 Feb 2025 02:04:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <cover.1738888641.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 0/9] Introduce load-acquire and store-release BPF instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all!

This patchset adds kernel support for BPF load-acquire and store-release
instructions (for background, please see [1]), mainly including
core/verifier, arm64 JIT compiler, and Documentation/ changes.  x86-64
and riscv64 are also planned to be supported.  The corresponding LLVM
changes can be found at:
  https://github.com/llvm/llvm-project/pull/108636

An atomic load/store is a BPF_STX | BPF_ATOMIC instruction, with the
lowest 8 bits of the 'imm' field in the following format:

  +-+-+-+-+-+-+-+-+
  | type  | order |
  +-+-+-+-+-+-+-+-+

  o 'type' indicates ATOMIC_LOAD (0x1) or ATOMIC_STORE (0x2)
  o 'order' is one of RELAXED (0x0), ACQUIRE (0x1), RELEASE (0x2),
    ACQ_REL (0x3, acquire-and-release) and SEQ_CST (0x4, sequentially
    consistent)

Currently only two combinations are legal:

  o LOAD_ACQ (0x11: ATOMIC_LOAD, ACQUIRE)
  o STORE_REL (0x22: ATOMIC_STORE, RELEASE)

During v1 there was a discussion on whether it is necessary to have a
dedicated 'order' field and define all possible values, considering that
we only allow two combinations at the moment.  Please refer to [2] for
more context.

v1: https://lore.kernel.org/all/cover.1737763916.git.yepeilin@google.com/
v1..v2 notable changes:

  o (Eduard) for x86 and s390, make
             bpf_jit_supports_insn(..., /*in_arena=*/true) return false
	     for load_acq/store_rel
  o add Eduard's Acked-by: tag
  o (Eduard) extract LDX and non-ATOMIC STX handling into helpers, see
             PATCH v2 3/9
  o allow unpriv programs to store-release pointers to stack
  o (Alexei) make it clearer in the interpreter code (PATCH v2 4/9) that
             only W and DW are supported for atomic RMW
  o test misaligned load_acq/store_rel
  o (Eduard) other selftests/ changes:
    * test load_acq/store_rel with !atomic_ptr_type_ok() pointers:
      - PTR_TO_CTX, for is_ctx_reg()
      - PTR_TO_PACKET, for is_pkt_reg()
      - PTR_TO_FLOW_KEYS, for is_flow_key_reg()
      - PTR_TO_SOCKET, for is_sk_reg()
    * drop atomics/ tests
    * delete unnecessary 'pid' checks from arena_atomics/ tests
    * avoid depending on __BPF_FEATURE_LOAD_ACQ_STORE_REL, use
      __imm_insn() and inline asm macros instead

RFC v1: https://lore.kernel.org/all/cover.1734742802.git.yepeilin@google.com
RFC v1..v1 notable changes:

  o 1-2/8: minor verifier.c refactoring patches
  o   3/8: core/verifier changes
         * (Eduard) handle load-acquire properly in backtrack_insn()
         * (Eduard) avoid skipping checks (e.g.,
                    bpf_jit_supports_insn()) for load-acquires
         * track the value stored by store-releases, just like how
           non-atomic STX instructions are handled
         * (Eduard) add missing link in commit message
         * (Eduard) always print 'r' for disasm.c changes
  o   4/8: arm64/insn: avoid treating load_acq/store_rel as
           load_ex/store_ex
  o   5/8: arm64/insn: add load_acq/store_rel
         * (Xu) include Should-Be-One (SBO) bits in "mask" and "value",
                to avoid setting fixed bits during runtime (JIT-compile
                time)
  o   6/8: arm64 JIT compiler changes
         * (Xu) use emit_a64_add_i() for "pointer + offset" to optimize
                code emission
  o   7/8: selftests
         * (Eduard) avoid adding new tests to the 'test_verifier' runner
         * add more tests, e.g., checking mark_precise logic
  o   8/8: instruction-set.rst changes

Please see the individual kernel patches (and LLVM commits) for details.
The LLVM GitHub PR will be split into three (each containing a single
commit) soon.  Feedback is much appreciated!

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/
[2] https://lore.kernel.org/bpf/Z5srM--fdH_JAgYT@google.com

Thanks,
Peilin Ye (9):
  bpf/verifier: Factor out atomic_ptr_type_ok()
  bpf/verifier: Factor out check_atomic_rmw()
  bpf/verifier: Factor out check_load_mem() and check_store_reg()
  bpf: Introduce load-acquire and store-release instructions
  arm64: insn: Add BIT(23) to {load,store}_ex's mask
  arm64: insn: Add load-acquire and store-release instructions
  bpf, arm64: Support load-acquire and store-release instructions
  selftests/bpf: Add selftests for load-acquire and store-release
    instructions
  bpf, docs: Update instruction-set.rst for load-acquire and
    store-release instructions

 .../bpf/standardization/instruction-set.rst   | 114 ++++++--
 arch/arm64/include/asm/insn.h                 |  12 +-
 arch/arm64/lib/insn.c                         |  29 ++
 arch/arm64/net/bpf_jit.h                      |  20 ++
 arch/arm64/net/bpf_jit_comp.c                 |  87 +++++-
 arch/s390/net/bpf_jit_comp.c                  |  14 +-
 arch/x86/net/bpf_jit_comp.c                   |   4 +
 include/linux/bpf.h                           |  11 +
 include/linux/filter.h                        |   2 +
 include/uapi/linux/bpf.h                      |  13 +
 kernel/bpf/core.c                             |  63 ++++-
 kernel/bpf/disasm.c                           |  12 +
 kernel/bpf/verifier.c                         | 234 +++++++++++-----
 tools/include/uapi/linux/bpf.h                |  13 +
 .../selftests/bpf/prog_tests/arena_atomics.c  |  50 ++++
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/arena_atomics.c       |  88 ++++++
 .../bpf/progs/verifier_load_acquire.c         | 190 +++++++++++++
 .../selftests/bpf/progs/verifier_precision.c  |  47 ++++
 .../bpf/progs/verifier_store_release.c        | 262 ++++++++++++++++++
 20 files changed, 1164 insertions(+), 105 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_load_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_store_release.c

-- 
2.48.1.502.g6dc24dfdaf-goog


