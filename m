Return-Path: <bpf+bounces-34751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A4930906
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C9C28140B
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426F1C68D;
	Sun, 14 Jul 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9eji2i0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078C14AB2;
	Sun, 14 Jul 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945734; cv=none; b=XP6yjMfZm0QOftqWRrVHpGGCrmzn+/tMpcqIKDcHwzzwHkkZx1onwYlRqqrKknuAV4Zxxc03bXDgF6CrNWDFSfz0eC96dcm4k/bSd69Uj+19WHx/Fir7VAglajF8h2EJFHAYapu87roUzBtWY2dWhEsx+swL4zDSlxYIw9ulEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945734; c=relaxed/simple;
	bh=qxzGnovbe3DGz52bIjhuany+pekl+uhzWVtTS59g6hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnlZWUjGUJwHSFFG8NIa48bt1ckYglRhtws00wvdcUot2HJ74NwZ9GgozhcyzeXPCj7hwyNyPZI9TGWb3SGACIGTJuJavzgM87b4OFuUIOZ91wfO8Jo4LL307L+KVb495PW/0BUqhUhd+fwip02HNjEb4RC504EAKue151hG/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9eji2i0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F1DC116B1;
	Sun, 14 Jul 2024 08:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945734;
	bh=qxzGnovbe3DGz52bIjhuany+pekl+uhzWVtTS59g6hQ=;
	h=From:To:Cc:Subject:Date:From;
	b=l9eji2i0bCnZkeyHSVlHXp/SbNc7N+HA/px/f7JgMf5fE0sCTryHD84Ehqi2pGLko
	 eHSNHop5xe3GWNMkzlu692pXt1mVILqhUz9k4YZSRTZlS1rvzajx6q4YtRcJW0NoIk
	 cJ2Wykhki3hM45tIPMRo5l3sE9auposDMHxNhPg7YP3mN2ZQPKZ1cPYzkDIAbAPEfR
	 lNgdYjLrszRJLUcz9Zzoi/ro/AC1O6M7gNwJURHSd7VMcsJJLZbxH8ilxHgYih11y6
	 3nGmFca/rd+Y5c8HflEv4ciSDag9/Jo43Hx1XeZVyBpfx2iWLz2rtNS65aWC7vZQvO
	 GxYNUil7UuzSw==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>,
	linux-kbuild@vger.kernel.org,
	<linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [RFC PATCH v4 00/17] powerpc: Core ftrace rework, support for ftrace direct and bpf trampolines
Date: Sun, 14 Jul 2024 13:57:36 +0530
Message-ID: <cover.1720942106.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the series posted here:
http://lkml.kernel.org/r/cover.1718908016.git.naveen@kernel.org

This series reworks core ftrace support on powerpc to have the function 
profiling sequence moved out of line. This enables us to have a single 
nop at kernel function entry virtually eliminating effect of the 
function tracer when it is not enabled. The function profile sequence is 
moved out of line and is allocated at two separate places depending on a 
new config option.

For 64-bit powerpc, the function profiling sequence is also updated to 
include an additional instruction 'mtlr r0' after the usual 
two-instruction sequence to fix link stack imbalance (return address 
predictor) when ftrace is enabled. This showed an improvement of ~22% in 
null_syscall benchmark on a Power 10 system with ftrace enabled.

Finally, support for ftrace direct calls is added based on support for
DYNAMIC_FTRACE_WITH_CALL_OPS. BPF Trampoline support is added atop this.

Support for ftrace direct calls is added for 32-bit powerpc. There is 
some code to enable bpf trampolines for 32-bit powerpc, but it is not 
complete and will need to be pursued separately.

This is marked RFC so that this can get more testing. Patches 1 to 10 
are independent of this series and can go in separately though. Rest of 
the patches depend on the series from Benjamin Gray adding support for 
patch_uint() and patch_ulong():
http://lkml.kernel.org/r/20240515024445.236364-1-bgray@linux.ibm.com


Changelog v4:
- Patches 1, 10 and 13 are new.
- Address review comments from Nick. Numerous changes throughout the 
  patch series.
- Extend support for ftrace ool to vmlinux text up to 64MB (patch 13).
- Address remaining TODOs in support for BPF Trampolines.
- Update synchronization when patching instructions during trampoline 
  attach/detach.


- Naveen


Naveen N Rao (17):
  powerpc/trace: Account for -fpatchable-function-entry support by
    toolchain
  powerpc/kprobes: Use ftrace to determine if a probe is at function
    entry
  powerpc64/ftrace: Nop out additional 'std' instruction emitted by gcc
    v5.x
  powerpc32/ftrace: Unify 32-bit and 64-bit ftrace entry code
  powerpc/module_64: Convert #ifdef to IS_ENABLED()
  powerpc/ftrace: Remove pointer to struct module from dyn_arch_ftrace
  powerpc/ftrace: Skip instruction patching if the instructions are the
    same
  powerpc/ftrace: Move ftrace stub used for init text before _einittext
  powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into
    bpf_jit_emit_func_call_rel()
  powerpc/ftrace: Add a postlink script to validate function tracer
  kbuild: Add generic hook for architectures to use before the final
    vmlinux link
  powerpc64/ftrace: Move ftrace sequence out of line
  powerpc64/ftrace: Support .text larger than 32MB with out-of-line
    stubs
  powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_CALL_OPS
  powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_DIRECT_CALLS
  samples/ftrace: Add support for ftrace direct samples on powerpc
  powerpc64/bpf: Add support for bpf trampolines

 arch/Kconfig                                |   6 +
 arch/powerpc/Kconfig                        |  23 +-
 arch/powerpc/Makefile                       |   8 +
 arch/powerpc/Makefile.postlink              |   8 +
 arch/powerpc/include/asm/ftrace.h           |  32 +-
 arch/powerpc/include/asm/module.h           |   5 +
 arch/powerpc/include/asm/ppc-opcode.h       |  14 +
 arch/powerpc/kernel/asm-offsets.c           |  11 +
 arch/powerpc/kernel/kprobes.c               |  18 +-
 arch/powerpc/kernel/module_64.c             |  66 +-
 arch/powerpc/kernel/trace/Makefile          |  11 +-
 arch/powerpc/kernel/trace/ftrace.c          | 295 ++++++-
 arch/powerpc/kernel/trace/ftrace_64_pg.c    |  69 +-
 arch/powerpc/kernel/trace/ftrace_entry.S    | 246 ++++--
 arch/powerpc/kernel/vmlinux.lds.S           |   3 +-
 arch/powerpc/net/bpf_jit.h                  |  12 +
 arch/powerpc/net/bpf_jit_comp.c             | 842 +++++++++++++++++++-
 arch/powerpc/net/bpf_jit_comp32.c           |   7 +-
 arch/powerpc/net/bpf_jit_comp64.c           |  68 +-
 arch/powerpc/tools/Makefile                 |  10 +
 arch/powerpc/tools/ftrace-gen-ool-stubs.sh  |  52 ++
 arch/powerpc/tools/ftrace_check.sh          |  45 ++
 samples/ftrace/ftrace-direct-modify.c       |  85 +-
 samples/ftrace/ftrace-direct-multi-modify.c | 101 ++-
 samples/ftrace/ftrace-direct-multi.c        |  79 +-
 samples/ftrace/ftrace-direct-too.c          |  83 +-
 samples/ftrace/ftrace-direct.c              |  69 +-
 scripts/Makefile.vmlinux                    |   8 +
 scripts/link-vmlinux.sh                     |  11 +-
 29 files changed, 2083 insertions(+), 204 deletions(-)
 create mode 100644 arch/powerpc/tools/Makefile
 create mode 100755 arch/powerpc/tools/ftrace-gen-ool-stubs.sh
 create mode 100755 arch/powerpc/tools/ftrace_check.sh


base-commit: 582b0e554593e530b1386eacafee6c412c5673cc
prerequisite-patch-id: a1d50e589288239d5a8b1c1f354cd4737057c9d3
prerequisite-patch-id: da4142d56880861bd0ad7ad7087c9e2670a2ee54
prerequisite-patch-id: 609d292e054b2396b603890522a940fa0bdfb6d8
prerequisite-patch-id: 6f7213fb77b1260defbf43be0e47bff9c80054cc
prerequisite-patch-id: ad3b71bf071ae4ba1bee5b087e61a2055772a74f
-- 
2.45.2


