Return-Path: <bpf+bounces-62938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C7B008E6
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1547A3D0A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C22F0C45;
	Thu, 10 Jul 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IuRmBI+6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEAC274FD0;
	Thu, 10 Jul 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165354; cv=none; b=I+QAIuSc28kQV6U+rOQ/jFToSJ+RLfrhljz7rOkm6hOWk0Bvw2GDiizYSYDCsdyzD4HoQL1VSRD5gWDCZVGVHcvfAD7mfnsC9RzA26BKkoR8vBwi9KJlfQKSqzaKueGkJjBpAXZIAF6mOLjIq8icBldi181TLIln0HO6etUrUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165354; c=relaxed/simple;
	bh=JwlH4YX3Qe6Lid4Xwg+ptX46xa6odkrKvdDsZ1tByV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXFe2Shjs9KjaOY9unfvse8MFZHBmy82Bz5YSBqQRzj5JlRLGx+Z4oAVaGxntMNrOUyoFUpdNId1GfKVUNVH38nGUjhrZJpLZwNfDhSAZ6XmFkk5HcMRTkO6hKrQYcrf9a7IcD0WNAodrQ+90IYxbguRLZlnNmjWP9DBWNS79/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IuRmBI+6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ACdsjR017464;
	Thu, 10 Jul 2025 16:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+j6wd4oY2UPGRlpEyGgHh/zaL6zkFLhzQyy5wboMg
	XU=; b=IuRmBI+6dB90/sSk6JywShBvEgePZ6ZWNnLG3K8Ohv365FxUR13/iaesf
	c8g1KBHnjbP7FcNmtpf5PP+PUfrTf8wqDihFs1PR5nK4CSsOJa2zMwovk/dEhFhd
	IvFJW8D9ElUnPC3tEpW2n6moB3UACDBoTqekOtD4M4xrdi2bXJ+/DPdmC7JHnfUB
	oafDyd3fRH01Itsv98XMXZcG5MLh13MenF1qkAdh2JLBbqttmsZz1RULIDssSdnw
	9ixMLUrQsawOyFulcdlcp05QH7JXz3z8sfQg46R+OMmmnA0wk2vqWk/DLAn2r4nR
	T0KOArQowOmFC6uZXyTZL/WQ8ndkQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrd3au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFafb5013583;
	Thu, 10 Jul 2025 16:35:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm6bbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZOXY53215674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B5112004B;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 138F320040;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 00/16] s390: SFrame user space unwinding
Date: Thu, 10 Jul 2025 18:35:06 +0200
Message-ID: <20250710163522.3195293-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686febd1 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=CCpqsmhAAAAA:8 a=VnNF1IyMAAAA:8 a=meVymXHHAAAA:8 a=pMNNJ6ZO70f3YaTwUIkA:9
 a=ul9cdbp4aOFLsgKbc677:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: oKv2ucYe_BJ8Shu36TSUi6F5Vl2pssFa
X-Proofpoint-GUID: oKv2ucYe_BJ8Shu36TSUi6F5Vl2pssFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX0rYjrtLAriGJ 8lPGgYyUa9f1wPHJqTbwJAB03x2adFHVjJAo+cdHv63RthDnHkCJfJNI1GHcuo0uO3v7d26dLH5 xNtv6TpQP0/Az2KhVDfH+ND2zq8W09eq28psnxviRCH/wR38VrJ0PKPPiWfPSwh6Y50fYmSeeIx
 p/9amlY2LFGLl7lHQNaXKD/fJ9NjLFxhhL7nl/mBAQIj4Wvlt84EKFihzk5nuhRmYF85/XPEWs/ SqD15EwZM30AxVHCJUqbyY/kboOWGwrddnhSOKH4hE+BV4Rv1igsHIbWQYzu9K/FSxhEeDVtLjq uQuBWtgaEX16dHvoamePtxD2lpuxzFDlGQKMqYQDQP8s1UkpMyzfZ2wlEp+kxD4XG6LyWDmHTJg
 iv8PMWw3f0EnetBhLTNCF45vmqWbq3ZzoNMfLx1/XYy0ea8AAQs7In2yBXiazLrVjpZLccV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

This RFC series adds s390 support for unwinding of user space using
SFrame. It is based on Josh's and Steven's work (see prerequisites
below).  The generic unwind user (sframe) frameworks are extended to
enable support for a few s390-particularities (see patches 6-9),
including unwinding of user space using back chain (see patch 12).
The latter could be broken apart as a separate patch series.

Posting as RFC so that the s390-particularities could be taken into
account in any of the prerequisite series from Steve and to obtain
early feedback to improve my patches.  I would also be fine with any
of the required infrastructure changes being integrated into the
prerequisite series.

Hopefully it was the right think to use the distribtion list from
Steve's prerequisite series.


Motivation:

On s390 unwinding using frame pointer (FP) is unsupported, because of
lack of proper s390 64-bit (s390x) ABI specification and compiler
support.  The ABI does only specify a "preferred" FP register.  Both GCC
and Clang, regardless of compiler option -fno-omit-frame-pointer, setup
the preferred FP register as late as possible, which usually is after
static stack allocation, so that the CFA cannot be deduced from the FP
without any further data, such as provided by DWARF CFI or SFrame.

In theory there is a s390-specific alternative of unwinding using
back chain (compiler option -mbackchain), but this has its own
limitations and there is currently no distribution that builds user
space with back chain.

As a consequence the Kernel stack tracer cannot unwind user space
(except if it is built with back chain).  Recording call graphs of user
space using perf is limited top stack sampling (i.e. perf record
--call-graph dwarf), which generates a fairly large amount of data and
has limitations.

Initial testing of recording call graphs using perf using the s390
support for SFrame provided by this series (on top of Josh's and
Steve's) shows that both the sampling rate and data size notably
improve:

perf record data size is greatly reduced (smaller perf.data):

  SFrame (--call-graph fp):
  # perf record -F 9999 --call-graph fp objdump -wdWF objdump
  [ perf record: Woken up 9 times to write data ]
  [ perf record: Captured and wrote 2.498 MB perf.data (10891 samples) ]

  Stack sampling (--call-graph dwarf) with a default stack size of 8192:
  # perf record -F 9999 --call-graph dwarf objdump -wdWF objdump
  [ perf record: Woken up 270 times to write data ]
  [ perf record: Captured and wrote 67.467 MB perf.data (8241 samples) ]

perf record sampling rate is a lot higher (higher number of events):

  SFrame (--call-graph fp):
  # perf record -F 99999 --call-graph fp objdump -wdWF objdump
  [ perf record: Woken up 213 times to write data ]
  [ perf record: Captured and wrote 53.167 MB perf.data (283993 samples) ]

  Stack sampling (--call-graph dwarf) with a default stack size of 8192:
  # perf record -F 99999 --call-graph dwarf objdump -wdWF objdump
  [ perf record: Woken up 2678 times to write data ]
  Warning:
  Processed 91458 events and lost 45 chunks!
  Check IO/CPU overload!
  Warning:
  Processed 102157 samples and lost 19.24%!
  [ perf record: Captured and wrote 675.513 MB perf.data (82497 samples) ]


Prerequirements:

This RFC series applies on top of Josh's and Steve's series
"[PATCH v8 00/12] unwind_deferred: Implement sframe handling":
https://lore.kernel.org/all/20250708021115.894007410@kernel.org/
Note that this series depends on others.

It is based on top of Steve's branch available at:
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/main

It depends on my Binutils series "[PATCH v3 00/11] s390: Support to
generate .sframe in assembler and linker":
https://inbox.sourceware.org/binutils/20250627110849.1198336-1-jremus@linux.ibm.com/
Note that my latest v4 of that series is already based on SFrame V2
format changes (i.e. SFRAME_F_FDE_FUNC_START_PCREL), that require
changes to the generic unwind user sframe implementation.

Josh's and Steve's series depends on a Glibc patch from Josh, that adds
support for the prctls introduced in the Kernel:
https://lore.kernel.org/all/20250122023517.lmztuocecdjqzfhc@jpoimboe/
Note that Josh's Glibc patch needs to be adjusted for the updated prctl
numbers from "[PATCH v8 12/12] unwind_user/sframe: Add prctl() interface
for registering .sframe sections":
https://lore.kernel.org/all/20250708021200.397301537@kernel.org/


Overview:

Patch 1 adds and rewords a few comments to Josh's and Steve's user
unwind framework.

Patch 2 aligns asm/dwarf.h to x86 asm/dwarf2.h.

Patch 3 replicates Josh's x86 patch "x86/asm: Avoid emitting DWARF
CFI for non-VDSO" for s390.

Patch 4 replicates Josh's patch "x86/vdso: Enable sframe generation
in VDSO" for s390.  It enables generation of SFrame stack trace
information (.sframe section) for the vDSO if the assembler supports it.
Note that this depends on a new config option CONFIG_AS_SFRAME that is
introduced by a separate series by Josh/Steven, from which I have
included the required patches as PREREQ.

Patch 5 changes the build of the vDSO on s390 to keep the function
symbols for stack tracing purposes.  Note that Josh does this in his
patch "x86/vdso: Enable sframe generation in VDSO", by chaning objcopy
option -S to -g.

Patches 6-9 enable Josh's generic unwind user (sframe) frameworks to
support the following s390 particularities:

- Patch 6 adds support for architectures that define their CFA as SP at
  callsite + offset.

- Patch 7 adds support support for architectures that do not necessarily
  save the RA on the stack (or in another register) in the topmost
  frame (e.g. in the prologue or in lead functions).

- Patch 8 adds support for architectures that save RA/FP in other
  registers.

- Patch 9 adds support for architectures that store the CFA offset
  from CFA base register (e.g. SP or FP) in SFrame encoded.  For
  instance on s390 the CFA offset is stored adjusted by -160 and
  then scaled down by 8 to enable and improve the use of signed 8-bit
  SFrame offsets (i.e. CFA, RA, and FP offset).

Patch 10 introduces frame_pointer() and user_return_address() in
ptrace on s390.  Both are prerequisites for the subsequent patch.

Patch 11 adds support for unwinding of user space using SFrame on
s390.  It leverages the extensions of the generic unwind user
framework from patches 6-9.

Patch 12 introduces unwinding of user space using back chain to the
unwind user framework.

Patch 13 adds support for unwinding of user space using back chain on
s390.

Patches 14-15 are pre-requisite patches from Josh's and Steve's
series "[PATCH v6 0/6] x86/vdso: VDSO updates and fixes for sframes":
https://lore.kernel.org/all/20250425023750.669174660@goodmis.org/
They introduce the config option CONFIG_AS_SFRAME required by patch 4.

Patch 16 is a WIP fixup for user unwind sframe on s390 to use macros
instead of magic numbers that I would like to get some feedback on,
whether that would be the correct approach.

Initially I had a patch on top that uses the unwind user framework in
stack trace on s390 in arch_stack_walk_user_common(), now that it can
unwind user space using back chain.  But a recent change changed
macro for_each_user_frame() private, so that it can no longer be used.
Note that this would still not enable stack traces of user space to be
generated.  The reason is that the stack tracer does not allow for page
faults, causing the unwind user framework attempt to unwind using SFrame
to fail and fallback to unwind using back chain, which usually also
fails, as user space is not built with back chain (see motivation).


Limitations:

Unwinding of user space using back chain cannot - by design - restore
the FP.  Therefore unwiding of subsequent frames using e.g. SFrame may
fail, if the FP is the CFA base register.

Thanks and regards,
Jens

Jens Remus (14):
  fixup! unwind_user: Add frame pointer support
  s390: asm/dwarf.h should only be included in assembly files
  s390/vdso: Avoid emitting DWARF CFI for non-vDSO
  s390/vdso: Enable SFrame generation in vDSO
  s390/vdso: Keep function symbols in vDSO
  unwind_user: Enable archs that define CFA = SP_callsite + offset
  unwind_user: Enable archs that do not necessarily save RA
  unwind_user: Enable archs that save RA/FP in other registers
  unwind_user/sframe: Enable archs with encoded SFrame CFA offsets
  s390/ptrace: Enable HAVE_USER_RA_REG
  s390/unwind_user/sframe: Enable HAVE_UNWIND_USER_SFRAME
  unwind_user/backchain: Introduce back chain user space unwinding
  s390/unwind_user/backchain: Enable HAVE_UNWIND_USER_BACKCHAIN
  WIP: fixup! s390/unwind_user/sframe: Enable HAVE_UNWIND_USER_SFRAME

Josh Poimboeuf (2):
  PREREQ: x86/asm: Avoid emitting DWARF CFI for non-VDSO
  PREREQ: x86/vdso: Enable sframe generation in VDSO

 arch/Kconfig                                  |  21 +++
 arch/s390/Kconfig                             |   4 +
 arch/s390/include/asm/dwarf.h                 |  53 +++++---
 arch/s390/include/asm/ptrace.h                |  25 +++-
 arch/s390/include/asm/unwind_user.h           |  83 ++++++++++++
 arch/s390/include/asm/unwind_user_backchain.h | 127 ++++++++++++++++++
 arch/s390/include/asm/unwind_user_sframe.h    |  37 +++++
 arch/s390/kernel/vdso64/Makefile              |   9 +-
 arch/s390/kernel/vdso64/vdso64.lds.S          |   5 +
 arch/x86/entry/vdso/Makefile                  |  10 +-
 arch/x86/entry/vdso/vdso-layout.lds.S         |   3 +
 arch/x86/include/asm/dwarf2.h                 |  54 +++++---
 arch/x86/include/asm/unwind_user.h            |  26 +++-
 include/asm-generic/Kbuild                    |   1 +
 include/asm-generic/unwind_user.h             |  20 +++
 include/asm-generic/unwind_user_sframe.h      |  65 +++++++++
 include/linux/ptrace.h                        |   8 ++
 include/linux/sframe.h                        |   4 +-
 include/linux/unwind_user_backchain.h         |  17 +++
 include/linux/unwind_user_types.h             |  21 ++-
 kernel/unwind/Makefile                        |   1 +
 kernel/unwind/sframe.c                        |  28 ++--
 kernel/unwind/sframe.h                        |  16 +++
 kernel/unwind/user.c                          | 101 +++++++++++---
 kernel/unwind/user_backchain.c                |  13 ++
 25 files changed, 671 insertions(+), 81 deletions(-)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_backchain.h
 create mode 100644 arch/s390/include/asm/unwind_user_sframe.h
 create mode 100644 include/asm-generic/unwind_user_sframe.h
 create mode 100644 include/linux/unwind_user_backchain.h
 create mode 100644 kernel/unwind/user_backchain.c

-- 
2.48.1


