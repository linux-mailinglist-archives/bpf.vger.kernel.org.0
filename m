Return-Path: <bpf+bounces-32617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0260911194
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E40F2875D2
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72FD1B3732;
	Thu, 20 Jun 2024 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQRI90gx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69836381B9;
	Thu, 20 Jun 2024 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909839; cv=none; b=AxvGCkZnv+ugOGslO8sMi4eGH/b4lct7WSXNQ7PoxGq8ZFQhG1D8AV3K9kEccvPnGno4U8QlpKzlR3mReXdfZ37H3d+LlGHzjjPQ2ynIWA4mgUxizUjjfEUq7XiBAFxCefrScp2Tpb1iKagw0RAXarJtLhZC9eEzp5R5/T235js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909839; c=relaxed/simple;
	bh=0nrN+oIc4sLMs0HNchgdz1IvGpOv0OVXQS/bQIadZQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=devfZ6Jih+1b+ox4tXip4RLtll96FoJ4Dd6HyOHGyzfLx1C7CZUVEHfScGf6CDIOh4R3mj1pkRDgV9sHV9H94dVG1/+ztv4zPdNNaK8Vaum9kN2xplH9PACSe1qZ7r+MOqOqKMjljXNus6BnfXhtSaboRI2vFXMA29mgSrHssII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQRI90gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC1AC2BD10;
	Thu, 20 Jun 2024 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718909838;
	bh=0nrN+oIc4sLMs0HNchgdz1IvGpOv0OVXQS/bQIadZQM=;
	h=From:To:Cc:Subject:Date:From;
	b=vQRI90gxFnkz9q3F1uLt0YM/SGrgfXK7OBl6Iodsu1iPSMtejIRuZgQGcKAMotSOj
	 z06K8PmZ5t/qxDgGK9XGz05lMvDlxIpt0qABsY+jIAnv6brReu2WsEBlWgbzMDpoVm
	 ZSk7YiZeR5/g8ZUqNEriOfB2zuEckdtF3oe9TK57tH5feg2BZkjxlhMXEt7xb0aCtl
	 AgnzrXHX10ac9VFVoP/dhX74RCySCb5T/anOCm25wrT6uLN2IeKchfHv1EiBRnx04W
	 AfLeLxEbeO2WtcWmXLRe/mxsGm8NQzktVs5Y0R12btt+Ge4b7b1Q5jlCT6B0N/HnJ3
	 Nug0BXp20eV6Q==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [RFC PATCH v3 00/11] powerpc: Add support for ftrace direct and BPF trampolines
Date: Fri, 21 Jun 2024 00:24:03 +0530
Message-ID: <cover.1718908016.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the patches posted here:
http://lkml.kernel.org/r/cover.1718008093.git.naveen@kernel.org

Since v2, I have addressed review comments from Steven and Masahiro 
along with a few fixes. Patches 7-11 are new in this series and add 
support for ftrace direct and bpf trampolines. 

This series depends on the patch series from Benjamin Gray adding 
support for patch_ulong():
http://lkml.kernel.org/r/20240515024445.236364-1-bgray@linux.ibm.com


- Naveen


Naveen N Rao (11):
  powerpc/kprobes: Use ftrace to determine if a probe is at function
    entry
  powerpc/ftrace: Unify 32-bit and 64-bit ftrace entry code
  powerpc/module_64: Convert #ifdef to IS_ENABLED()
  powerpc/ftrace: Remove pointer to struct module from dyn_arch_ftrace
  kbuild: Add generic hook for architectures to use before the final
    vmlinux link
  powerpc64/ftrace: Move ftrace sequence out of line
  powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_CALL_OPS
  powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_DIRECT_CALLS
  samples/ftrace: Add support for ftrace direct samples on powerpc
  powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into
    bpf_jit_emit_func_call_rel()
  powerpc64/bpf: Add support for bpf trampolines

 arch/Kconfig                                |   3 +
 arch/powerpc/Kconfig                        |   9 +
 arch/powerpc/Makefile                       |   8 +
 arch/powerpc/include/asm/ftrace.h           |  29 +-
 arch/powerpc/include/asm/module.h           |   5 +
 arch/powerpc/include/asm/ppc-opcode.h       |  14 +
 arch/powerpc/kernel/asm-offsets.c           |  11 +
 arch/powerpc/kernel/kprobes.c               |  18 +-
 arch/powerpc/kernel/module_64.c             |  67 +-
 arch/powerpc/kernel/trace/ftrace.c          | 269 +++++++-
 arch/powerpc/kernel/trace/ftrace_64_pg.c    |  73 +-
 arch/powerpc/kernel/trace/ftrace_entry.S    | 210 ++++--
 arch/powerpc/kernel/vmlinux.lds.S           |   3 +-
 arch/powerpc/net/bpf_jit.h                  |  11 +
 arch/powerpc/net/bpf_jit_comp.c             | 702 +++++++++++++++++++-
 arch/powerpc/net/bpf_jit_comp32.c           |   7 +-
 arch/powerpc/net/bpf_jit_comp64.c           |  68 +-
 arch/powerpc/tools/Makefile                 |  10 +
 arch/powerpc/tools/gen-ftrace-pfe-stubs.sh  |  49 ++
 samples/ftrace/ftrace-direct-modify.c       |  85 ++-
 samples/ftrace/ftrace-direct-multi-modify.c | 101 ++-
 samples/ftrace/ftrace-direct-multi.c        |  79 ++-
 samples/ftrace/ftrace-direct-too.c          |  83 ++-
 samples/ftrace/ftrace-direct.c              |  69 +-
 scripts/Makefile.vmlinux                    |   8 +
 scripts/link-vmlinux.sh                     |  11 +-
 26 files changed, 1813 insertions(+), 189 deletions(-)
 create mode 100644 arch/powerpc/tools/Makefile
 create mode 100755 arch/powerpc/tools/gen-ftrace-pfe-stubs.sh


base-commit: e2b06d707dd067509cdc9ceba783c06fa6a551c2
prerequisite-patch-id: a1d50e589288239d5a8b1c1f354cd4737057c9d3
prerequisite-patch-id: da4142d56880861bd0ad7ad7087c9e2670a2ee54
prerequisite-patch-id: 609d292e054b2396b603890522a940fa0bdfb6d8
prerequisite-patch-id: 6f7213fb77b1260defbf43be0e47bff9c80054cc
prerequisite-patch-id: ad3b71bf071ae4ba1bee5b087e61a2055772a74f
-- 
2.45.2


