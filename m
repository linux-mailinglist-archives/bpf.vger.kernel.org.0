Return-Path: <bpf+bounces-75071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C6C6EDC4
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 14:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8E4842965B
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64897361DC8;
	Wed, 19 Nov 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V3EhuFvU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AB35773A;
	Wed, 19 Nov 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558695; cv=none; b=geRXdLi7y6FBnMuSQchrL+DDmeDro0QcGQyaBLJO7Gr/j/LA6lDpGBGwv2/SzrEiyinvpQCm6LaFpAnGZ9lkiLs91Jguadp4MhNfd97EhBC63Mb57lDWyDm+JqGZpAKKYiaCTmzZDDNijDkUFYUr94N5E1YupZm2MpQ6dqDKiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558695; c=relaxed/simple;
	bh=x/Mppl6eDDjqoYkuTnFv+sMCJmoLbNx7Vm90d1HVnnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvrcXThpzdrOyGczWEGUl8SLAkIMvYCbzot9vDKWJB7FiCl5VBj3tCrE/gmzHnZT7yF54HJj0sn97ov7igB+KKIoWjyRdK9V6WFB9L7ELaribLtWXnEy9wDTUb+ggFRDvN0WPQe9pYATXbHqTaqZGCyYvg7AnL9nXfkpsBspCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V3EhuFvU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ6QM2w029107;
	Wed, 19 Nov 2025 13:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/vM0IlAh4Z6c1s8EMUYMCtW+J5w+dENAoNFsnfu1o
	a8=; b=V3EhuFvUV53Gkh4mN+gWqvTaK/l6CDme2gwMa5moGcsmahNW57yXvbfHo
	nFfpNn08CFawn89owd60TPOqxf4V2IC2HWYCErKPT+ZL3SEJedkXXTSNCs01MXH/
	jHOuUxoMu8OU1qYLkDkJEFrLFLguBesNLuce8Li4NnpM/F6YmjUQ8QWi2hT72zCz
	gGeCroQA6MyAYYB+QGBCc8N3lpadendbLUyz6G67r/ypWyLdbxY8P2KW/uhIqZe3
	9/KJCSSxo+6gVcDClqRGOSfy59IK3Nt67LqPAmlb5k5OVBjpmiMShojza5Il0W9T
	gA58hO9pftC4RknuQNzKX4Ks3/Taw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsqts4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJDK3Ki003705;
	Wed, 19 Nov 2025 13:23:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsqts1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJB3iPC030837;
	Wed, 19 Nov 2025 13:23:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47y0wpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJDNQ2X53281200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:23:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F2B12004E;
	Wed, 19 Nov 2025 13:23:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7470220040;
	Wed, 19 Nov 2025 13:23:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 13:23:25 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
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
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v12 00/13] unwind_deferred: Implement sframe handling
Date: Wed, 19 Nov 2025 14:23:10 +0100
Message-ID: <20251119132323.1281768-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y2HvlRcaUq6bKG6GwDqY9WrTbMJKZ-RI
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691dc4d4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=CCpqsmhAAAAA:8
 a=iDXTxSz5C1yoLA-4i_QA:9 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: 5dbcuCYkPipvXjAAy75_nuJJb9e0wUzU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX1V7KPAH9A61v
 222ndzm8Asg4XItcEi12Vx3+FfbIZN519WmTRAJzu5Reodw1dCfZdGAE4gZVNKOzx4aXWrwE9A/
 sEP13OevigR9zKURIB6fFHTCRurGoZpAZR9KO+VJq3DZh3SLOgxYHSb2QgadlzM0njssoYHG5N5
 1EEuMS02UEgFJZkAQEwEaf58kJglVm19h/OMYylq48B40PsnKpyJ0Jl8uCy0PRST6quDReRwxCL
 obGk7nYQNDitQeCDPhFGhRGOpUu1YkP288oeV7KMalQp0XyTr/N3uqE/tUSrOCgdg6OYK2KxFoi
 6jTwUqrprPzJLHschkfGp0COLO4bCcgijXH3NgylfH9sQncD01qniOQCF9T6qVBDEtqm0RmgSCO
 TII1rf5Z95E/MFKJEuGuAYR/PLHIrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

This is the implementation of parsing the .sframe section in an ELF file.
It's a continuation of Josh's and Steve's work that can be found here:

   https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
   https://lore.kernel.org/all/20250827201548.448472904@kernel.org/

Currently the only way to get a user space stack trace from a stack
walk (and not just copying large amount of user stack into the kernel
ring buffer) is to use frame pointers. This has a few issues. The biggest
one is that compiling frame pointers into every application and library
has been shown to cause performance overhead.

Another issue is that the format of the frames may not always be consistent
between different compilers and some architectures (s390) has no defined
format to do a reliable stack walk. The only way to perform user space
profiling on these architectures is to copy the user stack into the kernel
buffer.

SFrame [1] is now supported in binutils (x86-64, ARM64, and s390). There is
discussions going on about supporting SFrame in LLVM. SFrame acts more like
ORC, and lives in the ELF executable file as its own section. Like ORC it
has two tables where the first table is sorted by instruction pointers (IP)
and using the current IP and finding it's entry in the first table, it will
take you to the second table which will tell you where the return address
of the current function is located and then you can use that address to
look it up in the first table to find the return address of that function,
and so on. This performs a user space stack walk.

Now because the .sframe section lives in the ELF file it needs to be faulted
into memory when it is used. This means that walking the user space stack
requires being in a faultable context. As profilers like perf request a stack
trace in interrupt or NMI context, it cannot do the walking when it is
requested. Instead it must be deferred until it is safe to fault in user
space. One place this is known to be safe is when the task is about to return
back to user space.

This series makes the deferred unwind user code implement SFrame format V2
with the latest format enhancements (i.e. PC-relative SFrame FDE function
start address, represent return address undefined) and enables it on x86-64.

[1]: https://sourceware.org/binutils/wiki/sframe


This series applies on top of Peter Zijlstras latest unwind user
enhancements and perf deferred callchain support on his tip perf/core
branch which has been merged to the tip master branch (f8fdee44bf2f):

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master

with Namhyung Kim's related latest perf tools deferred callchain support
merged on top (if you want to use "perf record --call-graph fp,defer"
and "perf report/script" for testing):

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git  perf/defer-callchain-v4

The to be stack-traced user space programs (and libraries) need to be
built with the latest SFrame stack trace information format V2, with
the recent PC-relative SFrame FDE function start address encoding and
optionally the support to represent return address undefined, as
generated by binutils 2.45+ with assembler option --gsframe.


Changes since v11 (see patch notes for details):
- Rebase on tip master branch (f8fdee44bf2f) with Namhyung Kim's
  perf/defer-callchain-v4 branch merged on top.
- Adjust to Peter's latest undwind user enhancements.
- Simplify logic by using an internal SFrame FDE representation, whose
  FDE function start address field is an address instead of a PC-relative
  offset (from FDE).
- Rename struct sframe_fre to sframe_fre_internal to align with
  struct sframe_fde_internal.
- Remove unused pt_regs from unwind_user_next_common() and its
  callers. (Peter)
- Simplify unwind_user_next_sframe(). (Peter)
- Fix a few checkpatch errors and warnings.
- Minor cleanups (e.g. move includes, fix indentation).

Changes since v10:
- Support for SFrame V2 PC-relative FDE function start address.
- Support for SFrame V2 representing RA undefined as indication for
  outermost frames.


Patches 1, 4, and 12 have been updated to exclusively support the recent
PC-relative SFrame FDE function start address encoding.  With binutils 2.45
the SFrame V2 FDE function start address field value is an offset from the
field (i.e. PC-relative) instead of from the .sframe section start.  This
is indicated by the new SFrame header flag SFRAME_F_FDE_FUNC_START_PCREL.
Old SFrame V2 sections get rejected with dynamic debug message
"bad/unsupported sframe header".

Patches 7 and 8 add support to unwind user and unwind user sframe for
a recent change of the SFrame V2 format to represent an undefined
return address as an SFrame FRE without any offsets, which is used as
indication for outermost frames.  Note that currently only a development
build of binutils mainline generates SFrame information including this
new indication for outermost frames.  SFrame information without the new
indication is still supported.  Without these patches unwind user sframe
would identify such new SFrame FREs without any offsets as corrupted and
would therefore remove the .sframe section, causing any any further
stack tracing using sframe to fail.

Regards,
Jens

Jens Remus (2):
  unwind_user: Stop when reaching an outermost frame
  unwind_user/sframe: Add support for outermost frame indication

Josh Poimboeuf (11):
  unwind_user/sframe: Add support for reading .sframe headers
  unwind_user/sframe: Store .sframe section data in per-mm maple tree
  x86/uaccess: Add unsafe_copy_from_user() implementation
  unwind_user/sframe: Add support for reading .sframe contents
  unwind_user/sframe: Detect .sframe sections in executables
  unwind_user/sframe: Wire up unwind_user to sframe
  unwind_user/sframe/x86: Enable sframe unwinding on x86
  unwind_user/sframe: Remove .sframe section on detected corruption
  unwind_user/sframe: Show file name in debug output
  unwind_user/sframe: Add .sframe validation option
  unwind_user/sframe: Add prctl() interface for registering .sframe
    sections

 MAINTAINERS                        |   1 +
 arch/Kconfig                       |  23 ++
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/mmu.h         |   2 +-
 arch/x86/include/asm/uaccess.h     |  39 +-
 arch/x86/include/asm/unwind_user.h |   6 +-
 fs/binfmt_elf.c                    |  48 ++-
 include/linux/mm_types.h           |   3 +
 include/linux/sframe.h             |  60 +++
 include/linux/unwind_user_types.h  |   5 +-
 include/uapi/linux/elf.h           |   1 +
 include/uapi/linux/prctl.h         |   6 +-
 kernel/fork.c                      |  10 +
 kernel/sys.c                       |   9 +
 kernel/unwind/Makefile             |   3 +-
 kernel/unwind/sframe.c             | 627 +++++++++++++++++++++++++++++
 kernel/unwind/sframe.h             |  72 ++++
 kernel/unwind/sframe_debug.h       |  68 ++++
 kernel/unwind/user.c               |  29 ++
 mm/init-mm.c                       |   2 +
 20 files changed, 996 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/sframe_debug.h

--
2.48.1


