Return-Path: <bpf+bounces-49744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C349FA1C065
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F141188E611
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D81FC7E1;
	Sat, 25 Jan 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ve1HtKLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E71FA14E
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771446; cv=none; b=h0AvbcA2ahHbqAFPv4NZ/q+5u4A8D77m2H1Y9iTzuySm7aYo3y+CW+AQLwqk/0NeRuBswQLUuFYsEfB4miwq0s8bOb5/czk7xk4IjK7aXWnS4hA4l0uFgWKV0P1KKUkQuZqBP79QM6kW1i8oBgxj0vatzeDcH2+4WusbkU1vCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771446; c=relaxed/simple;
	bh=pu2EhaQhZ+/mIdUpfRz38I9rC1PV12/P7s8Fm38QhjE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jNZxZwz+nBpnfh+3LmyyZqKqpFIZEDN/xWO5pv3HjvKqdiEAZxR1sBniKkA7SXJx+plkrRCbjiCHlLlzLHOYTv8689oS05PjhvvReVtWxR0XTse+bAkAtJ+D39qX1WqyjYv4Zks5b36vvleY1P/AkXtek/xDYaX/jtvp3S9OtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ve1HtKLn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso5278880a91.3
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771444; x=1738376244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h3bkVoi9K3lmVDVc5ocA3NDmYedo978QaFzTUvD0tLE=;
        b=Ve1HtKLn0dsPzRIiyvjxUuC43cDL5KSveKOed9efi2sRuHkuClC3JM34k4RwUv/nCB
         UeYuOfEWfbPymRRaxh4QZpjdTu82wWZBeBv0KpORzKFoTgm5uLenbWLLvSuQqDnUm5NH
         r3qirWz/hMQfC4HJj7KWzTDwexJUR2DRVE7dC0nBFL8PFo681NGs0/ebsvO+9z8Xdore
         IZGeBtBBEbMhWI97dCUHmyQoTCxPMIuOofJ7M851r1JaJyoZY2f3HYwYiu+R+mgH8E7A
         mKjYGpHUE1c1Lohh5S7vThVrfYCsJuFOQuyws0rh/w5miZjeOoAIvYiyv3Ew8X4zGr5E
         L/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771444; x=1738376244;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3bkVoi9K3lmVDVc5ocA3NDmYedo978QaFzTUvD0tLE=;
        b=aKj0vcEyIFcl+z0drFvhI6bHZ0XVLhnT8S+70ti1fa+Io9ScP+yVUX7Lw56+OO0Xdb
         hB6ClcYajO9+Tt2j570IoB1dUGbSukVAJytd28zKOYFyU15V0HkUNIugx/7V1ODtu1fq
         pBa3igtNiSdzwTS3f5xYtT/f3kTaIeAhliBBVuDIbeNtUUP0hKSfwcFLwHlXsuoSiTxo
         /EF+JLUlB4H82bNmLs3IcU0+c7iL1yOVMKu62vMv5sD4nka4lA5x+B5qhfSd7LmCJR8G
         oFri4Yh4q1Q/ZmDv9OVulfTpfyqHVf9VIykaqFpsrNYnGCP3WsC71Yq5haYcYiYUUQQb
         zLXQ==
X-Gm-Message-State: AOJu0Yxo7dbc2XgkWa+tbW9ikBoafev8STjh5ww32MJYqUP9L56J5WeM
	1Fom1ZIHx2pVKNPoX2hSwCvL3/aE8PGBByxKjR7LSvMlSvORvHNX83t9pOjcn6jIA5nlu0puvGV
	IOwEmc8AK2F5jh6pPLKb0+6FEtROgVHSDgyvCvuVM0xTLcadEIDM3pKYI0lQacObHiEdVcaDhBc
	CMoWdVM4mxMz0ltd3sb96E6L757GN3j/h7ooI4wes=
X-Google-Smtp-Source: AGHT+IHN3T/fppy6ufj+AIX32GgCXgIkSJTU3btPBtKv0LakDy15nE9uX+biultAZ61nn2WuE7FZK8L8XPRlfg==
X-Received: from pjbpx11.prod.google.com ([2002:a17:90b:270b:b0:2ea:5469:76c2])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:54d0:b0:2ee:bbd8:2b9d with SMTP id 98e67ed59e1d1-2f782d8c81fmr41701777a91.34.1737771443886;
 Fri, 24 Jan 2025 18:17:23 -0800 (PST)
Date: Sat, 25 Jan 2025 02:16:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <cover.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 0/8] Introduce load-acquire and store-release BPF instructions
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
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all!

This patchset adds kernel support for BPF load-acquire and store-release
instructions (for background, please see [1]), including core/verifier,
arm64 JIT compiler, and Documentation/ changes.  x86-64 and riscv64 are
also planned to be supported.  The corresponding LLVM changes can be
found at:
  https://github.com/llvm/llvm-project/pull/108636

Following RFC 9669, 7.3. Adding Instructions [2], this patchset adds two
conformance groups for the new instructions:

  * atomic32v2: includes "atomic32", plus the new 8-, 16- and 32-bit
                atomic load-acquire and store-release instructions

  * atomic64v2: includes "atomic64" and "atomic32v2", plus the new
                64-bit atomic load-acquire and store-release
                instructions

See patch 8/8 for details; please suggest if you believe the new
instructions should be grouped differently.

RFC v1: https://lore.kernel.org/all/cover.1734742802.git.yepeilin@google.com

This patchset has been reorganized based on comments and suggestions
from Xu and Eduard.  Notable changes since RFC v1:

  o 1-2/8: minor verifier.c refactoring patches
  o   3/8: core/verifier changes
         * (Eduard) handle load-acquire properly in backtrack_insn()
         * (Eduard) avoid skipping checks (e.g.,
                    bpf_jit_supports_insn()) for load-acquires
         * track the value stored by store-releases, just like how
           non-atomic STX instructions are handled [3]
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

Please refer to individual kernel patches (and LLVM commits) for
details.  Any feedback would be much appreciated!

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/
[2] https://www.rfc-editor.org/rfc/rfc9669.html#section-7.3
[3] Specifically, for store-releases, make sure we do that
    check_mem_access(..., BPF_WRITE, ...) call with @value_regno equals
    'src_reg' instead of -1.

Thanks,
Peilin Ye (8):
  bpf/verifier: Factor out atomic_ptr_type_ok()
  bpf/verifier: Factor out check_atomic_rmw()
  bpf: Introduce load-acquire and store-release instructions
  arm64: insn: Add BIT(23) to {load,store}_ex's mask
  arm64: insn: Add load-acquire and store-release instructions
  bpf, arm64: Support load-acquire and store-release instructions
  selftests/bpf: Add selftests for load-acquire and store-release
    instructions
  bpf, docs: Update instruction-set.rst for load-acquire and
    store-release instructions

 .../bpf/standardization/instruction-set.rst   | 114 ++++++++++--
 arch/arm64/include/asm/insn.h                 |  12 +-
 arch/arm64/lib/insn.c                         |  28 +++
 arch/arm64/net/bpf_jit.h                      |  20 +++
 arch/arm64/net/bpf_jit_comp.c                 |  92 +++++++++-
 include/linux/filter.h                        |   2 +
 include/uapi/linux/bpf.h                      |  13 ++
 kernel/bpf/core.c                             |  41 ++++-
 kernel/bpf/disasm.c                           |  12 ++
 kernel/bpf/verifier.c                         | 165 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |  13 ++
 .../selftests/bpf/prog_tests/arena_atomics.c  |  61 ++++++-
 .../selftests/bpf/prog_tests/atomics.c        |  57 +++++-
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/arena_atomics.c       |  62 ++++++-
 tools/testing/selftests/bpf/progs/atomics.c   |  62 ++++++-
 .../bpf/progs/verifier_load_acquire.c         |  92 ++++++++++
 .../selftests/bpf/progs/verifier_precision.c  |  39 +++++
 .../bpf/progs/verifier_store_release.c        | 153 ++++++++++++++++
 19 files changed, 988 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_load_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_store_release.c

-- 
2.48.1.262.g85cc9f2d1e-goog


