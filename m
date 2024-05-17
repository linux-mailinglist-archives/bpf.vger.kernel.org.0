Return-Path: <bpf+bounces-29930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2C8C84B4
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3F5B233AC
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A4364DA;
	Fri, 17 May 2024 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3XwoUUc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740779FE
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941405; cv=none; b=gkAkvYwjYIs0NoxNfaoWWx6JYyyeynBP2jGkC2QNKyE9hme4d7NrVfEiSG0ecg6KnDrdagoV+EEDypJXrA3NPaSLAK84C3uL/Rci7R14g83ARTe5umKTJwOJFaq7tH6aAou74K0JJ+5bcgwvN0pmRcGw5/4MC/ILGUbFr6KCSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941405; c=relaxed/simple;
	bh=FBxXLVS8YXGnGVaS2NMj2y40BdGZulEYmeql2T76VD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iyTHCeslTsgHVfyk4oH+0005FdlFdg7TP3j6XNvXxY+eWdwlChox/qp2vsUVOup5Pao59xuQWXINZVEXpJoFOQczuxonNbb9SUJ9wap5xvaK5fXKQZz6p9zOqA91i9exKCLfHCyko1tt8yCbSS9g1+xlT+NPewV29eGyrUk+Se4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I3XwoUUc; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H8eFJf010351;
	Fri, 17 May 2024 10:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=6mFLWMk/c8n65+3qno0UfFR+boIxWttF+j9GSPkQHsA=;
 b=I3XwoUUcSiam3c6RJfUGDQIn7JBvm8AuoauPS3jWlP5wVtKILjmToQcoDP1ljJcKVuQM
 XkL1/AUUbtcEw8C4rk2gV/rIZUB2lwkTcRP2AKBLv8nHR2JENGmptXIiijvhRJ08Hip1
 cmDmjbHdv1yle7eOTDXjRFTIqRyYZjl8SGyzmPgXjFJGFoJ77AYPbFN9t9ccWjw3EqE0
 dzLv2C6dx35d9X7+sq5Htr9/iSCqIhHLNJernehzqLyhKHzRF0s1lX+yZJKt+iM42V4m
 x+5T639FakxNRf8GPzu8PH3w3CGJBD1OzykXLOta49ZwhZ+NJjhvza9Hw2+3BC6ySbtG hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4rym4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:22:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44H8mEaK000360;
	Fri, 17 May 2024 10:22:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fsuqrsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:22:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HAMqFY036134;
	Fri, 17 May 2024 10:22:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-196-17.vpn.oracle.com [10.175.196.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y4fsuqrr2-1;
	Fri, 17 May 2024 10:22:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
Date: Fri, 17 May 2024 11:22:35 +0100
Message-Id: <20240517102246.4070184-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170082
X-Proofpoint-GUID: wwlJX6HtnV3kDMLbfjfbE16kNHLVYS3n
X-Proofpoint-ORIG-GUID: wwlJX6HtnV3kDMLbfjfbE16kNHLVYS3n

Split BPF Type Format (BTF) provides huge advantages in that kernel
modules only have to provide type information for types that they do not
share with the core kernel; for core kernel types, split BTF refers to
core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
uses that structure (or a pointer to it) simply needs to refer to the
core kernel type id, saving the need to define the structure and its many
dependents.  This cuts down on duplication and makes BTF as compact
as possible.

However, there is a downside.  This scheme requires the references from
split BTF to base BTF to be valid not just at encoding time, but at use
time (when the module is loaded).  Even a small change in kernel types
can perturb the type ids in core kernel BTF, and due to pahole's
parallel processing of compilation units, even an unchanged kernel can
have different type ids if BTF is re-generated.  So we have a robustness
problem for split BTF for cases where a module is not always compiled at
the same time as the kernel.  This problem is particularly acute for
distros which generally want module builders to be able to compile a
module for the lifetime of a Linux stable-based release, and have it
continue to be valid over the lifetime of that release, even as changes
in data structures (and hence BTF types) accrue.  Today it's not
possible to generate BTF for modules that works beyond the initial
kernel it is compiled against - kernel bugfixes etc invalidate the split
BTF references to vmlinux BTF, and BTF is no longer usable for the
module.

The goal of this series is to provide options to provide additional
context for cases like this.  That context comes in the form of
distilled base BTF; it stands in for the base BTF, and contains
information about the types referenced from split BTF, but not their
full descriptions.  The modified split BTF will refer to type ids in
this .BTF.base section, and when the kernel loads such modules it
will use that .BTF.base to map references from split BTF to the
equivalent current vmlinux base BTF types.  Once this relocation
process has succeeded, the module BTF available in /sys/kernel/btf
will look exactly as if it was built with the current vmlinux;
references to base types will be fixed up etc.

A module builder - using this series along with the pahole changes -
can then build a module with distilled base BTF via an out-of-tree
module build, i.e.

make -C . M=path/2/module

The module will have a .BTF section (the split BTF) and a
.BTF.base section.  The latter is small in size - distilled base
BTF does not need full struct/union/enum information for named
types for example.  For 2667 modules built with distilled base BTF,
the average size observed was 1556 bytes (stddev 1563).  The overall
size added to this 2667 modules was 5.3Mb.

Note that for the in-tree modules, this approach is not needed as
split and base BTF in the case of in-tree modules are always built
and re-built together.

The series first focuses on generating split BTF with distilled base
BTF, and provides btf__parse_opts() which allows specification
of the section name from which to read BTF data, since we now have
both .BTF and .BTF.base sections that can contain such data.

Then we add support to resolve_btfids for generating the .BTF.ids
section with reference to the .BTF.base section - this ensures the
.BTF.ids match those used in the split/base BTF.

Finally the series provides the mechanism for relocating split BTF with
a new base; the distilled base BTF is used to map the references to base
BTF in the split BTF to the new base.  For the kernel, this relocation
process happens at module load time, and we relocate split BTF
references to point at types in the current vmlinux BTF.  As part of
this, .BTF.ids references need to be mapped also.

So concretely, what happens is

- we generate split BTF in the .BTF section of a module that refers to
  types in the .BTF.base section as base types; the latter are not full
  type descriptions but provide information about the base type.  So
  a STRUCT sk_buff would be represented as a FWD struct sk_buff in
  distilled base BTF for example.
- when the module is loaded, the split BTF is relocated with vmlinux
  BTF; in the case of the FWD struct sk_buff, we find the STRUCT sk_buff
  in vmlinux BTF and map all split BTF references to the distilled base
  FWD sk_buff, replacing them with references to the vmlinux BTF
  STRUCT sk_buff.

Support is also added to bpftool to be able to display split BTF
relative to its .BTF.base section, and also to display the relocated
form via the "-R path_to_base_btf".

A previous approach to this problem [1] utilized standalone BTF for such
cases - where the BTF is not defined relative to base BTF so there is no
relocation required.  The problem with that approach is that from
the verifier perspective, some types are special, and having a custom
representation of a core kernel type that did not necessarily match the
current representation is not tenable.  So the approach taken here was
to preserve the split BTF model while minimizing the representation of
the context needed to relocate split and current vmlinux BTF.

To generate distilled .BTF.base sections the associated dwarves
patch (to be applied on the "next" branch there) is needed.
Without it, things will still work but modules will not be built
with a .BTF.base section.

Changes since v3[3]:

- distill now checks for duplicate-named struct/unions and records
  them as a sized struct/union to help identify which of the
  multiple base BTF structs/unions it refers to (Eduard, patch 1)
- added test support for multiple name handling (Eduard, patch 2)
- simplified the string mapping when updating split BTF to use
  base BTF instead of distilled base.  Since the only string
  references split BTF can make to base BTF are the names of
  the base types, create a string map from distilled string
  offset -> base BTF string offset and update string offsets
  by visiting all strings in split BTF; this saves having to
  do costly searches of base BTF (Eduard, patch 7,10)
- fixed bpftool manpage and indentation issues (Quentin, patch 11)

Also explored Eduard's suggestion of doing an implicit fallback
to checking for .BTF.base section in btf__parse() when it is
called to get base BTF.  However while it is doable, it turned
out to be difficult operationally.  Since fallback is implicit
we do not know the source of the BTF - was it from .BTF or
.BTF.base? In bpftool, we want to try first standalone BTF,
then split, then split with distilled base.  Having a way
to explicitly request .BTF.base via btf__parse_opts() fits
that model better.

Changes since v2[4]:

- submitted patch to use --btf_features in Makefile.btf for pahole
  v1.26 and later separately (Andrii).  That has landed in bpf-next
  now.
- distilled base now encodes ENUM64 as fwd ENUM (size 8), eliminating
  the need for support for ENUM64 in btf__add_fwd (patch 1, Andrii)
- moved to distilling only named types, augmenting split BTF with
  associated reference types; this simplifies greatly the distilled
  base BTF and the mapping operation between distilled and base
  BTF when relocating (most of the series changes, Andrii)
- relocation now iterates over base BTF, looking for matches based
  on name in distilled BTF.  Distilled BTF is pre-sorted by name
  (Andrii, patch 8)
- removed most redundant compabitiliby checks aside from struct
  size for base types/embedded structs and kind compatibility
  (since we only match on name) (Andrii, patch 8)
- btf__parse_opts() now replaces btf_parse() internally in libbpf
  (Eduard, patch 3)

Changes since RFC [5]:

- updated terminology; we replace clunky "base reference" BTF with
  distilling base BTF into a .BTF.base section. Similarly BTF
  reconcilation becomes BTF relocation (Andrii, most patches)
- add distilled base BTF by default for out-of-tree modules
  (Alexei, patch 8)
- distill algorithm updated to record size of embedded struct/union
  by recording it as a 0-vlen STRUCT/UNION with size preserved
  (Andrii, patch 2)
- verify size match on relocation for such STRUCT/UNIONs (Andrii,
  patch 9)
- with embedded STRUCT/UNION recording size, we can have bpftool
  dump a header representation using .BTF.base + .BTF sections
  rather than special-casing and refusing to use "format c" for
  that case (patch 5)
- match enum with enum64 and vice versa (Andrii, patch 9)
- ensure that resolve_btfids works with BTF without .BTF.base
  section (patch 7)
- update tests to cover embedded types, arrays and function
  prototypes (patches 3, 12)

[1] https://lore.kernel.org/bpf/20231112124834.388735-14-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20240501175035.2476830-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/20240510103052.850012-1-alan.maguire@oracle.com/
[4] https://lore.kernel.org/bpf/20240424154806.3417662-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire@oracle.com/

Alan Maguire (11):
  libbpf: add btf__distill_base() creating split BTF with distilled base
    BTF
  selftests/bpf: test distilled base, split BTF generation
  libbpf: add btf__parse_opts() API for flexible BTF parsing
  bpftool: support displaying raw split BTF using base BTF section as
    base
  resolve_btfids: use .BTF.base ELF section as base BTF if -B option is
    used
  kbuild, bpf: add module-specific pahole/resolve_btfids flags for
    distilled base BTF
  libbpf: split BTF relocation
  selftests/bpf: extend distilled BTF tests to cover BTF relocation
  module, bpf: store BTF base pointer in struct module
  libbpf,bpf: share BTF relocate-related code with kernel
  bpftool: support displaying relocated-with-base split BTF

 include/linux/btf.h                           |  45 ++
 include/linux/module.h                        |   2 +
 kernel/bpf/Makefile                           |   8 +
 kernel/bpf/btf.c                              | 166 +++--
 kernel/module/main.c                          |   5 +-
 scripts/Makefile.btf                          |   7 +
 scripts/Makefile.modfinal                     |   4 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  15 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   7 +-
 tools/bpf/bpftool/btf.c                       |  19 +-
 tools/bpf/bpftool/main.c                      |  14 +-
 tools/bpf/bpftool/main.h                      |   2 +
 tools/bpf/resolve_btfids/main.c               |  28 +-
 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/btf.c                           | 605 +++++++++++++-----
 tools/lib/bpf/btf.h                           |  59 ++
 tools/lib/bpf/btf_common.c                    | 143 +++++
 tools/lib/bpf/btf_relocate.c                  | 341 ++++++++++
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_internal.h               |   3 +
 .../selftests/bpf/prog_tests/btf_distill.c    | 346 ++++++++++
 21 files changed, 1612 insertions(+), 212 deletions(-)
 create mode 100644 tools/lib/bpf/btf_common.c
 create mode 100644 tools/lib/bpf/btf_relocate.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c

-- 
2.31.1


