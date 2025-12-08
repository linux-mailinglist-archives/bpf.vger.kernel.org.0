Return-Path: <bpf+bounces-76305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDCECADE3A
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B5B3063F7A
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EE3168E4;
	Mon,  8 Dec 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iN5C2CUu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF322173A;
	Mon,  8 Dec 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214204; cv=none; b=EVVvDg244sLFHVAEsKtkfgzeeTGqF20Yv6YGbZNqw9lYHPZ005IpAmGu2g4Y7V4F5v7AsvHG7glWVXhOPNdKPnVtMMiQPhRLeSM/qwCnY8rOkKGWFcVX5DCcBgWpR6xvCwIDfll6hjgSRTpMh+yvP1ZA0cXUGOYXD01c/fcHbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214204; c=relaxed/simple;
	bh=x6lKLDteU5GRau7fcOYtPWzN8ouuzSThMpuFxNobwyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ojt1ScXeAm/XHcpkvBZFD4tqh/ggB9JmpqASVZvf4lGPOn2taiRL2FxF+PfKnsE9lObRym/ZbMRRjFV3C+rDmLL5dCuuSTGZwK9oXJgi+vT1LQ8grEZShhAfwKljs0r3aPJEElNDyp7OIfk6XmZ3pLVQiJGHKkj0jujoflN1W0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iN5C2CUu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B88mlrZ019359;
	Mon, 8 Dec 2025 17:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rdATdSrJh24c1RXMe3o/fHSkYXTV
	XUBW9p+883UrfWw=; b=iN5C2CUu+v730OD5hDRouOl20wYNn/SyhA4JENWTThBz
	urUrCF+jP3Ouowa6E6P+PkS3vvH7b0O56hlMmVwq+E8pZWynqzuAaBmo0i6BcWmb
	WVketeB06MyW5413J55julk0zGlzYrsbI18QNnWCgNPMjrMD+r7jwtSjsVbNTp+P
	wkGfvUFHbYBCZJRlkUFs+f1qi5J38MIcTFEdPCE9tH7jm8dtW3NV/lOuG6VnIET4
	wKOzXNKnZ6ePGHQBwg7bdWMg7cAeRco0hzEGfpjY1MnUteQ5yjlb+QSOhJJwONOy
	nAhOhcZOrzpdRHcCzKO9i0bw7T9xpkzXn9+l3IBTvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawv0k3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HG63T008601;
	Mon, 8 Dec 2025 17:16:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawv0k3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8EWkf3028147;
	Mon, 8 Dec 2025 17:16:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xpw8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG2Sm53608736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A7842004E;
	Mon,  8 Dec 2025 17:16:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC46320043;
	Mon,  8 Dec 2025 17:16:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:01 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v3 00/17] s390: SFrame user space unwinding
Date: Mon,  8 Dec 2025 18:15:42 +0100
Message-ID: <20251208171559.2029709-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rJxbQ8dgUbGc91eiuhbK16gz1jmF56Vs
X-Proofpoint-ORIG-GUID: K6GvHPed4nMg4stO213Lvtzd2l3n1p7H
X-Authority-Analysis: v=2.4 cv=aY9sXBot c=1 sm=1 tr=0 ts=693707d7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-dFlDAyDCAhLAYqPnkQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwNyBTYWx0ZWRfXy1A5Enrcif3F
 oR50xCgSyZqcMJYNraJqfJFuyee81j3pDGbgT1qdM2ChVYDUqJVKVXWiql38FVaR6lHmxSkICNM
 jCyBz5taHSo47s5tb6/Hn5kkpL+i9oGyu86afw3Rxa0U6NGPLm9EFW0SJAAgZdj0HXNwrAgmmLO
 NAkGD0wIKKnkZ/wp8P5YMsmvag9XEn11Gd3jtd58Av1esR3SRX9zCPfF0DvgzxHxGeATNIY8FNk
 3XUzC44io0hC0DfALA6UbDkUJQ6AiR0Ml+zlwuhF3eYCI86IiKRBltEDK6KeCj6RDBouoElHyul
 UrQSm5xs8fO9E6OQymyyTESwF1n5dPNRw7bwFG+CJVsa+RfYq4GGsoWfwT3QDcr92Q6mYj9Raky
 8SELrmu1oVgK1fTOkPJwnSyBI+aTsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060007

This RFC series adds s390 support for unwinding of user space using
SFrame.  It is based on Josh's, Steven's, and my work (see prerequisites
below).  The generic unwind user (sframe) frameworks are extended to
enable support for a few s390-particularities (see patches 9-12),
including unwinding of user space using back chain (see patches 15-17).
The latter could be broken apart as a separate patch series.


Changes in RFC v3:
- Rebase on and include my unwind user cleanup series v4, which includes
  a simplification of unwind_user_word_size() on x86. (Linus)
- Implement unwinding of user space using s390 back chain using unwind
  user fp instead of introducing a new unwind user backchain. (Josh)

Changes in RFC v2:
- Rebased on latest "unwind user" enhancements from Peter Zijlstra and
  my latest "unwind user sframe" series v12.
- Incorporated RFC v1 review feedback.
- No new config options (except for unwind user backchain).


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
limitations.  Ubuntu is currently the only distribution that that
builds user space with back chain.

As a consequence the Kernel stack tracer cannot unwind user space
(except if it is built with back chain).  Recording call graphs of user
space using perf is limited to stack dump sampling (i.e. perf record
--call-graph dwarf), which generates a fairly large amount of data and
has limitations.

Initial testing of recording call graphs using perf using the s390
support for SFrame provided by RFC v1 of this series shows that
data size notably improves:

perf record data size is greatly reduced (smaller perf.data):

  SFrame (--call-graph fp):
  # perf record -F 9999 --call-graph fp objdump -wdWF objdump
  [ perf record: Woken up 9 times to write data ]
  [ perf record: Captured and wrote 2.498 MB perf.data (10891 samples) ]

  Stack sampling (--call-graph dwarf) with a default stack size of 8192:
  # perf record -F 9999 --call-graph dwarf objdump -wdWF objdump
  [ perf record: Woken up 270 times to write data ]
  [ perf record: Captured and wrote 67.467 MB perf.data (8241 samples) ]


Prerequirements:

This RFC series applies on top of the latest unwind user sframe series
"[PATCH v12 00/13] unwind_deferred: Implement sframe handling":
https://lore.kernel.org/all/20251119132323.1281768-1-jremus@linux.ibm.com/

It depends on binutils 2.45 to build executables and libraries
(e.g. vDSO) with SFrame on s390, including the latest SFrame V2 with
PC-relative FDE encoding.  Optionally a binutils mainline build is
required for SFrame V2 with outermost frame indication.

The unwind user sframe series depends on a Glibc patch from Josh, that
adds support for the prctls introduced in the Kernel:
https://lore.kernel.org/all/20250122023517.lmztuocecdjqzfhc@jpoimboe/
Note that Josh's Glibc patch needs to be adjusted for the updated prctl
numbers from "[PATCH v12 13/13] unwind_user/sframe: Add prctl()
interface for registering .sframe sections":
https://lore.kernel.org/all/20251119132323.1281768-14-jremus@linux.ibm.com/


Overview:

Patches 1-4 originate from my "[PATCH v4 0/3] unwind_user: Cleanups"
series and can be ignored here (please review in the respective series):
https://lore.kernel.org/all/20251208160352.1363040-1-jremus@linux.ibm.com/

Patch 5 aligns asm/dwarf.h to x86 asm/dwarf2.h.

Patch 6 replicates Josh's x86 patch "x86/asm: Avoid emitting DWARF
CFI for non-VDSO" for s390.

Patch 7 changes the build of the vDSO on s390 to keep the function
symbols for stack tracing purposes.

Patch 8 replicates Josh's patch "x86/vdso: Enable sframe generation
in VDSO" for s390.  It enables generation of SFrame stack trace
information (.sframe section) for the vDSO if the assembler supports it.

Patches 9-12 enable Josh's generic unwind user (sframe) frameworks to
support the following s390 particularities:

- Patch 9 adds support for architectures that define their CFA as SP at
  callsite + offset.

- Patch 10 adds support support for architectures that pass the return
  address (RA) in a register instead of on the stack and that do not
  necessarily save the RA on the stack (or in another register) in the
  topmost frame (e.g. in the prologue or in leaf functions).

- Patch 11 adds support for architectures that save RA/FP in other
  registers instead of on the stack, e.g. in leaf functions.

- Patch 12 adds support for architectures that store the CFA offset
  from CFA base register (e.g. SP or FP) in SFrame encoded.  For
  instance on s390 the CFA offset is stored adjusted by -160 and
  then scaled down by 8 to enable and improve the use of signed 8-bit
  SFrame offsets (i.e. CFA, RA, and FP offset).

Patch 13 introduces frame_pointer() in ptrace on s390, which is a
prerequisite for enabling unwind user.

Patch 14 adds support for unwinding of user space using SFrame on
s390.  It leverages the extensions of the generic unwind user (sframe)
frameworks from patches 8-11.

Patches 15-16 enable unwind user (fp) to support the following s390
back chain particularities:

- Patch 15 introduces FP/RA location unknown, which enables s390
  back chain unwinding, which cannot unwind FP.

- Patch 16 enables sophisticated architecture-specific initialization
  of the FP frame, which enables s390 back chain unwinding to provide
  dynamic information.

Patch 17 adds support for unwinding of user space using back chain on
s390.  Main reasons to support back chain on s390 are:
- With Ubuntu there is a major distribution that builds user space with
  back chain.
- Java JREs, such as OpenJDK, do maintain the back chain in jitted code.


Limitations:

Unwinding of user space using back chain cannot - by design - restore
the FP.  Therefore unwinding of subsequent frames using e.g. SFrame may
fail, if the FP is the CFA base register.

Thanks and regards,
Jens

Jens Remus (17):
  unwind_user: Enhance comments on get CFA, FP, and RA
  unwind_user/fp: Use dummies instead of ifdef
  x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
  x86/unwind_user: Simplify unwind_user_word_size()
  s390: asm/dwarf.h should only be included in assembly files
  s390/vdso: Avoid emitting DWARF CFI for non-vDSO
  s390/vdso: Keep function symbols in vDSO
  s390/vdso: Enable SFrame generation in vDSO
  unwind_user: Enable archs that define CFA = SP_callsite + offset
  unwind_user: Enable archs that pass RA in a register
  unwind_user: Enable archs that save RA/FP in other registers
  unwind_user/sframe: Enable archs with encoded SFrame CFA offsets
  s390/ptrace: Provide frame_pointer()
  s390/unwind_user/sframe: Enable HAVE_UNWIND_USER_SFRAME
  unwind_user: Introduce FP/RA location unknown
  unwind_user/fp: Use arch-specific helper to initialize FP frame
  s390/unwind_user/fp: Enable back chain unwinding of user space

 arch/Kconfig                               |   3 +
 arch/s390/Kconfig                          |   2 +
 arch/s390/include/asm/dwarf.h              |  53 ++++--
 arch/s390/include/asm/ptrace.h             |  18 +-
 arch/s390/include/asm/unwind_user.h        | 183 +++++++++++++++++++++
 arch/s390/include/asm/unwind_user_sframe.h |  33 ++++
 arch/s390/kernel/vdso64/Makefile           |   9 +-
 arch/s390/kernel/vdso64/vdso64.lds.S       |   9 +
 arch/x86/include/asm/unwind_user.h         |  66 ++++++--
 include/asm-generic/Kbuild                 |   1 +
 include/asm-generic/unwind_user_sframe.h   |  35 ++++
 include/linux/unwind_user.h                |  30 +++-
 include/linux/unwind_user_types.h          |  20 ++-
 kernel/unwind/sframe.c                     |  13 +-
 kernel/unwind/sframe.h                     |  14 ++
 kernel/unwind/user.c                       |  83 ++++++----
 16 files changed, 493 insertions(+), 79 deletions(-)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_sframe.h
 create mode 100644 include/asm-generic/unwind_user_sframe.h

-- 
2.51.0


