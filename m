Return-Path: <bpf+bounces-53146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099E3A4D07A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCBF3ACF30
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004842AAF;
	Tue,  4 Mar 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qloowQrp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F060BE5E
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050349; cv=none; b=rNErG/vUHSKHZa7LA6+u9IBcWbFQ/BQ14aFXNO+aCGC0DtYzVt2bmOIrY9E++XAoOhO1cS7Ug7W5ciEE1gQ8wJ5PFFMOnlqrKP1TaEcRwBfXkpEWbLNrvczJ9uSMLD7wxY/V7ng5QCGmHHTZkcuxCpSh0m09JsFZR1TsF71oZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050349; c=relaxed/simple;
	bh=I0xHb257P71zQvxrNfPXsqfTQI1QXMoZeXgVoySwPuA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZINKF4sXp27Syq1+crDgjj3U1CZx65fclML/Auie+7ChjPr90eG1yTslZkJ7aefmNiJURRjeAlJasmoeRuBgM7XX+6eIaZMxR7CwVxdzfKDKSHWdYZs97DT5KohHhXGxzXEzMeP+chZL1+CMG3lsrjYqGhM4RiqHEP51uRUwrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qloowQrp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fee4c7ef4dso7100488a91.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 17:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741050347; x=1741655147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9SXgAIBBHli4r2G7pcbe+vJLfoKPTcPXAN+0NYitAWQ=;
        b=qloowQrpxIvpA/foGrCRRU1QbbZ3U+WBTD3V0nma0ytjPdH+lJbSRH/ris2WcSdkLc
         yr074iGAq8kx70LvBfZO4MWTkr6pZizaXT5UGQz8exPFqW0uLFBn9/HfTXaa/mOiL2Mo
         cahUwslr42jbkD0/3mWDiCqzFNk+vRmyq+yINX/jwoklDK/+h67qR/UuewL0n5aEjnpn
         Hv9Dj9+BkA2XQG58oVlsvdZoBT2MPxrycAPm+V7I80zggLCl2CSr2duBoyjPPCENy60J
         883PHnyemvsiNO0CrB24vrOUEYn2082OjoQi9UtvPMOgoaNTSGZEuGHlz1RjIlaxNoMB
         +sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050347; x=1741655147;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SXgAIBBHli4r2G7pcbe+vJLfoKPTcPXAN+0NYitAWQ=;
        b=ElIl8ydOCu/A2P807VqMRTMMUumvJAbFw4auIxexvKQhh1yrsZKDMj0oSIsSx6GmL9
         V8GFUoYAUCdbfbOPH0TMln0tP/nKSWl0LcRyppHBH68VMpM1mz9Kv6BuaWIp1dTwQwPu
         bm2eqHnTExr3pSzcHgm4aCfLvKkye20xpMs/ucsr/QhQoKC3AQuSJNmOtOP/ts9sD5pv
         PPGcaMlNEO7l3zB8wf38lW5a4jk+WLbyMDm6Y9YMeYTK/rFdfRpXhUyv5jcN3nmlZCNu
         yelQOczSEn7Bx3BNtLF5flexxJgsw1GarlYurbpv4T4tCNupNI0kV2h2h+1gB78YUOYs
         RJbQ==
X-Gm-Message-State: AOJu0YwXfznYhqGHaDkOmOyemAAU4TAwL1D417H2VESzGRfRBJnL5dFj
	IHllJkqMRo5w9VuPQNKOUUzK2amqN1jGc2XHi6+WFYLTwI7/aBfzMt3OuVTTbp59q8b/WGLwyIG
	/iXScIplU5lfthy08OVDALp1yMXtX50ZWvzi1Dvi3/g4OFt62YhSniHa3Cvn1rzb/AogpBzEQwK
	GC4HSiVoFE9d3m+vsSMcLE2SY4UosILfV75SMHFWA=
X-Google-Smtp-Source: AGHT+IGGKvvuo9gbYc5M0ieWPKrOF84HlNam7skz5aDvJF3ITlWMxgAk5BpAxwurfoJIEkLnp2itpoOBy/P7ag==
X-Received: from pjur16.prod.google.com ([2002:a17:90a:d410:b0:2fa:1fac:269c])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1805:b0:2ee:5bc9:75c3 with SMTP id 98e67ed59e1d1-2febab2ec49mr22094627a91.5.1741050347512;
 Mon, 03 Mar 2025 17:05:47 -0800 (PST)
Date: Tue,  4 Mar 2025 01:05:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <cover.1741049567.git.yepeilin@google.com>
Subject: [PATCH bpf-next v6 0/6] Introduce load-acquire and store-release BPF instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
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
instructions (for background, please see [1]), including core/verifier
and arm64/x86-64 JIT compiler changes, as well as selftests.  riscv64 is
also planned to be supported.  The corresponding LLVM changes can be
found at:

  https://github.com/llvm/llvm-project/pull/108636

The first 3 patches from v4 have already been applied:

  - [bpf-next,v4,01/10] bpf/verifier: Factor out atomic_ptr_type_ok()
    https://git.kernel.org/bpf/bpf-next/c/b2d9ef71d4c9
  - [bpf-next,v4,02/10] bpf/verifier: Factor out check_atomic_rmw()
    https://git.kernel.org/bpf/bpf-next/c/d430c46c7580
  - [bpf-next,v4,03/10] bpf/verifier: Factor out check_load_mem() and check_store_reg()
    https://git.kernel.org/bpf/bpf-next/c/d38ad248fb7a

Please refer to the LLVM PR and individual kernel patches for details.
Thanks!

v5: https://lore.kernel.org/all/cover.1741046028.git.yepeilin@google.com/
v5..v6 change:

  o (Alexei) avoid using #ifndef in verifier.c

v4: https://lore.kernel.org/bpf/cover.1740978603.git.yepeilin@google.com/
v4..v5 notable changes:

  o (kernel test robot) for 32-bit arches: make the verifier reject
                        64-bit load-acquires/store-releases, and fix
                        build error in interpreter changes
    * tested ARCH=arc build following instructions from kernel test
      robot
  o (Alexei) drop Documentation/ patch (v4 10/10) for now

v3: https://lore.kernel.org/bpf/cover.1740009184.git.yepeilin@google.com/
v3..v4 notable changes:

  o (Alexei) add x86-64 JIT support (including arena)
  o add Acked-by: tags from Xu

v2: https://lore.kernel.org/bpf/cover.1738888641.git.yepeilin@google.com/
v2..v3 notable changes:

  o (Alexei) change encoding to BPF_LOAD_ACQ=0x100, BPF_STORE_REL=0x110
  o add Acked-by: tags from Ilya and Eduard
  o make new selftests depend on:
    * __clang_major__ >= 18, and
    * ENABLE_ATOMICS_TESTS is defined (currently this means -mcpu=v3 or
      v4), and
    * JIT supports load_acq/store_rel (currenty only arm64)
  o work around llvm-17 CI job failure by conditionally define
    __arena_global variables as 64-bit if __clang_major__ < 18, to make
    sure .addr_space.1 has no holes
  o add Google copyright notice in new files

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

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/

Thanks,
Peilin Ye (6):
  bpf: Introduce load-acquire and store-release instructions
  arm64: insn: Add BIT(23) to {load,store}_ex's mask
  arm64: insn: Add load-acquire and store-release instructions
  bpf, arm64: Support load-acquire and store-release instructions
  bpf, x86: Support load-acquire and store-release instructions
  selftests/bpf: Add selftests for load-acquire and store-release
    instructions

 arch/arm64/include/asm/insn.h                 |  12 +-
 arch/arm64/lib/insn.c                         |  29 ++
 arch/arm64/net/bpf_jit.h                      |  20 ++
 arch/arm64/net/bpf_jit_comp.c                 |  86 +++++-
 arch/s390/net/bpf_jit_comp.c                  |  14 +-
 arch/x86/net/bpf_jit_comp.c                   |  95 ++++++-
 include/linux/bpf.h                           |  15 +
 include/linux/filter.h                        |   2 +
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/core.c                             |  67 ++++-
 kernel/bpf/disasm.c                           |  12 +
 kernel/bpf/verifier.c                         |  55 +++-
 tools/include/uapi/linux/bpf.h                |   3 +
 .../selftests/bpf/prog_tests/arena_atomics.c  |  66 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/arena_atomics.c       | 121 +++++++-
 .../bpf/progs/verifier_load_acquire.c         | 197 +++++++++++++
 .../selftests/bpf/progs/verifier_precision.c  |  49 ++++
 .../bpf/progs/verifier_store_release.c        | 264 ++++++++++++++++++
 19 files changed, 1081 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_load_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_store_release.c

-- 
2.48.1.711.g2feabab25a-goog


