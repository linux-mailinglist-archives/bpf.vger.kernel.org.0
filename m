Return-Path: <bpf+bounces-39947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA589798CD
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 22:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58965B21DBC
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD271B3A;
	Sun, 15 Sep 2024 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QNm3Vq/j"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354764965B;
	Sun, 15 Sep 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433852; cv=none; b=tJaQQIs9rYYK81K446VKLeddUc5kJV9hM8zTnC3QuWJqIXmxehp9dx4c7tD/24aGjDLulx+hMXOvUMRGJL2UtkZS4O6lyOqnWsJVD/N7ccC0FmcYhyZ3jU1ldkbNrTTiOcMQBmTdKy/ppVcayXpZFOIkGOF/AsfB6LLXlmLLldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433852; c=relaxed/simple;
	bh=9vvZzvaxgDB7EqXwPGMCfPMU7CR+H6d5WfPna3OOidQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGUxgbQ+khwNCC0+dAcCHr93+xY0XJu+CSn3XGGaTS/+IQm6NHYrlzT5o5IwkZrBwBLx/kzXp1ogxWmTsdK1/r3Rx9JXXbD6DPgK0jl82rhfwe0uHSLrcfTe4I/nw2BKBIsVbdczL4OBNr0qEnmISYACihufyV2RwgqvOlFdagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QNm3Vq/j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FAFxU1023503;
	Sun, 15 Sep 2024 20:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=Ugn0Yrgm2MUs+4SWHdqJV7bEgVdPTrB2iBhc/n6
	ktso=; b=QNm3Vq/jFgJzWd03YPpdwMCG/qNKSrLXXewFhN+vLBus5PlVXBhTPcp
	rNQAsq7XRfu0jmdiQslDgZJ9klDr3m/77QYUzKTuuamVl6P/ngxZzwElZ6fvMz2R
	nEI3x/C0YKQMumwGkfe/rWqBHglnzemAIj6L7uF1uebuKW6BmBm0MNTd3nN5BjWP
	1qMySkQLMZxxNgtkUl2plL2CTD8SeZaIqJ6J2QY+m+ZlSljp95L5rF3hoI0zvhzK
	zdG17n8goDCOXBWFGmSRFxBid67Zo6dQek8nztzVGfLyPPqzWvtRVu3U8DwtojSR
	Wpcunbgw46J9w+0CJjPnZ8nQpN771oA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41a682j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:56:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48FKuwvG010563;
	Sun, 15 Sep 2024 20:56:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41a682f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:56:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48FIYSk6001906;
	Sun, 15 Sep 2024 20:56:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nmtubyc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:56:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48FKurua30737120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 20:56:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75B2820049;
	Sun, 15 Sep 2024 20:56:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A89D420040;
	Sun, 15 Sep 2024 20:56:49 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.68.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Sep 2024 20:56:49 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: "Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v5 00/17] powerpc: Core ftrace rework, support for ftrace direct and bpf trampolines
Date: Mon, 16 Sep 2024 02:26:31 +0530
Message-ID: <20240915205648.830121-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 35M_0baBj8BwEKBy9x7HHGs_httRDY3b
X-Proofpoint-ORIG-GUID: XPAIqLoa7QQeaeBB0FdvAy9EqwAgKZ8v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409150159

This is v5 of the series posted here:
https://lore.kernel.org/all/cover.1720942106.git.naveen@kernel.org/

This series reworks core ftrace support on powerpc to have the function
profiling sequence moved out of line. This enables us to have a single
nop at kernel function entry virtually eliminating effect of the
function tracer when it is not enabled. The function profile sequence is
moved out of line and is allocated at two separate places depending on a
new config option.

For 64-bit powerpc, the function profiling sequence is also updated to
include an additional instruction 'mtlr r0' after the usual
two-instruction sequence to fix link stack imbalance (return address
predictor) when ftrace is enabled. This showed an improvement of ~10%
in null_syscall benchmark (NR_LOOPS=10000000) on a Power 10 system
with ftrace enabled.

Finally, support for ftrace direct calls is added based on support for
DYNAMIC_FTRACE_WITH_CALL_OPS. BPF Trampoline support is added atop this.

Support for ftrace direct calls is added for 32-bit powerpc. There is
some code to enable bpf trampolines for 32-bit powerpc, but it is not
complete and will need to be pursued separately.

Patches 1 to 10 are independent of this series and can go in separately
though. Rest of the patches depend on the series from Benjamin Gray
adding support for patch_uint() and patch_ulong():
https://lore.kernel.org/all/172474280311.31690.1489687786264785049.b4-ty@ellerman.id.au/

Changelog v5:
* Intermediate files named .vmlinux.arch.* instead of .arch.vmlinux.*
* Fixed ftrace stack tracer failure due to inadvertent use of
  'add r7, r3, MCOUNT_INSN_SIZE' instruction instead of
  'addi r7, r3, MCOUNT_INSN_SIZE'
* Fixed build error for !CONFIG_MODULES case.
* .vmlinux.arch.* files compiled under arch/powerpc/tools
* Made sure .vmlinux.arch.* files are cleaned with `make clean`
* num_ool_stubs_text_end used for setting up ftrace_ool_stub_text_end
  set to zero instead of computing to some random negative value when
  not required.
* Resolved checkpatch.pl warnings.
* Dropped RFC tag.

Changelog v4:
- Patches 1, 10 and 13 are new.
- Address review comments from Nick. Numerous changes throughout the
  patch series.
- Extend support for ftrace ool to vmlinux text up to 64MB (patch 13).
- Address remaining TODOs in support for BPF Trampolines.
- Update synchronization when patching instructions during trampoline
  attach/detach.


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
 arch/powerpc/Kbuild                         |   2 +-
 arch/powerpc/Kconfig                        |  23 +-
 arch/powerpc/Makefile                       |   8 +
 arch/powerpc/Makefile.postlink              |   8 +
 arch/powerpc/include/asm/ftrace.h           |  33 +-
 arch/powerpc/include/asm/module.h           |   5 +
 arch/powerpc/include/asm/ppc-opcode.h       |  14 +
 arch/powerpc/kernel/asm-offsets.c           |  11 +
 arch/powerpc/kernel/kprobes.c               |  18 +-
 arch/powerpc/kernel/module_64.c             |  66 +-
 arch/powerpc/kernel/trace/Makefile          |  11 +-
 arch/powerpc/kernel/trace/ftrace.c          | 298 ++++++-
 arch/powerpc/kernel/trace/ftrace_64_pg.c    |  69 +-
 arch/powerpc/kernel/trace/ftrace_entry.S    | 244 ++++--
 arch/powerpc/kernel/vmlinux.lds.S           |   3 +-
 arch/powerpc/net/bpf_jit.h                  |  12 +
 arch/powerpc/net/bpf_jit_comp.c             | 847 +++++++++++++++++++-
 arch/powerpc/net/bpf_jit_comp32.c           |   7 +-
 arch/powerpc/net/bpf_jit_comp64.c           |  68 +-
 arch/powerpc/tools/Makefile                 |  12 +
 arch/powerpc/tools/ftrace-gen-ool-stubs.sh  |  52 ++
 arch/powerpc/tools/ftrace_check.sh          |  50 ++
 samples/ftrace/ftrace-direct-modify.c       |  85 +-
 samples/ftrace/ftrace-direct-multi-modify.c | 101 ++-
 samples/ftrace/ftrace-direct-multi.c        |  79 +-
 samples/ftrace/ftrace-direct-too.c          |  83 +-
 samples/ftrace/ftrace-direct.c              |  69 +-
 scripts/Makefile.vmlinux                    |   7 +
 scripts/link-vmlinux.sh                     |   7 +-
 30 files changed, 2098 insertions(+), 200 deletions(-)
 create mode 100644 arch/powerpc/tools/Makefile
 create mode 100755 arch/powerpc/tools/ftrace-gen-ool-stubs.sh
 create mode 100755 arch/powerpc/tools/ftrace_check.sh

-- 
2.46.0


