Return-Path: <bpf+bounces-32051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A1906946
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41AE2866A9
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C88A13F451;
	Thu, 13 Jun 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iJgZjyZA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB313F449
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272245; cv=none; b=sBNJjJK+72UTArEq5fNh4fEYGBPL+G8OVTVv67BR+6OmdTr9WvWQkrrsjZVHiqY5SbSD2DvN4jxLBQsipHeGdMZLFS8T0lxEa3MZtcLi++Uad5MXbsy4BrP+40fQnhS/HUceIWI9ivqV6c925UDSIJWZU0xEuUzNwmUEapgAl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272245; c=relaxed/simple;
	bh=HLpPGTKLy2J6Fistg2CSZ+bc+O3IyiyDbCDvJCOFyTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Icd+ylLKvdrvZhIs0YFTe0vKTx+db8XAV5NnWhTJfs5/b5Bk1DtoyZxsNq9TEwNj6getNV5xy3ApshjpSFcPZc7XbfQJESrBhXvTsTQvFsml/B2SEyw0Vnx0NkF6Y1/XVO3zhY77CU2Hyp5Yvhx6+OWfUcZULtggO5ySOM8l6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iJgZjyZA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7ti70028487;
	Thu, 13 Jun 2024 09:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=YDRLvnD0pEsFIa
	T7ndDs86+Cr/a6k8kVkcU9gLtWOAE=; b=iJgZjyZA2SyWSuxwuV60F+F6VB5Ya2
	ykEVlalkYKXEZcCdhk12Ew94dY9fGt/b22eR3LajvTWVKpOHYHuPnCV66DG+PGZJ
	UpNDGGoRHjToWbqu0xZ44mYs5wGudU0YN0tUelFvru0HiFJuSONwGm4sBRUXmEIL
	ToDg8JdwbBgEFzb8DGk+ySiljK3brockzo8Wxxi7nC9FoTdcMQoKpBpttnGwiFXV
	ZWNEc3oCz6/Lfgmz4kS3h1QKD/ptxU29POcCgX+8bFaxBEQtCXmYzbhMcvcX7T6b
	tRu6Ny/IvuxIbzxOpOEJGRQzEAaptlVabcH+8ujinkQgnyHMinCl1h2g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1ghab3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D9E2qP014234;
	Thu, 13 Jun 2024 09:50:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncewnkt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45D9oJpo005489;
	Thu, 13 Jun 2024 09:50:19 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-187.vpn.oracle.com [10.175.212.187])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yncewnkqw-1;
	Thu, 13 Jun 2024 09:50:19 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 0/9] bpf: support resilient split BTF
Date: Thu, 13 Jun 2024 10:50:05 +0100
Message-Id: <20240613095014.357981-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130070
X-Proofpoint-ORIG-GUID: aSQmW4wwRJ8ts-inLQx0s_naVYmmnbZ4
X-Proofpoint-GUID: aSQmW4wwRJ8ts-inLQx0s_naVYmmnbZ4

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
can perturb the type ids in core kernel BTF, and - if the new reproducible
BTF option is not used - pahole's parallel processing of compilation units
can lead to different type ids for the same kernel if the BTF is
regenerated.

So we have a robustness problem for split BTF for cases where a module is
not always compiled at the same time as the kernel.  This problem is
particularly acute for distros which generally want module builders to be
able to compile a module for the lifetime of a Linux stable-based release,
and have it continue to be valid over the lifetime of that release, even
as changes in data structures (and hence BTF types) accrue.  Today it's not
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
BTF; then relocation support is added to allow split BTF with
an associated distlled base to be relocated with a new base BTF.

Next Eduard's patch allows BTF ELF parsing to work with both
.BTF and .BTF.base sections; this ensures that bpftool will be
able to dump BTF for a module with a .BTF.base section for example,
or indeed dump relocated BTF where a module and a "-B vmlinux"
is supplied.

Then we add support to resolve_btfids to ignore base BTF - i.e.
to avoid relocation - if a .BTF.base section is found.  This ensures
the .BTF.ids section is populated with ids relative to the distilled
base (these will be relocated as part of module load).

Finally the series supports storage of .BTF.base data/size in modules
and supports sharing of relocation code with the kernel to allow
relocation of module BTF.  For the kernel, this relocation
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

A previous approach to this problem [1] utilized standalone BTF for such
cases - where the BTF is not defined relative to base BTF so there is no
relocation required.  The problem with that approach is that from
the verifier perspective, some types are special, and having a custom
representation of a core kernel type that did not necessarily match the
current representation is not tenable.  So the approach taken here was
to preserve the split BTF model while minimizing the representation of
the context needed to relocate split and current vmlinux BTF.

To generate distilled .BTF.base sections the associated dwarves
patch (to be applied on the "next" branch there) is needed [3]
Without it, things will still work but modules will not be built
with a .BTF.base section.

Changes since v5[4]:

- Update search of distilled types to return the first occurrence
  of a string (or a string+size pair); this allows us to iterate
  over all matches in distilled base BTF (Andrii, patch 3)
- Update to use BTF field iterators (Andrii, patches 1, 3 and 8)
- Update tests to cover multiple match and associated error cases
  (Eduard, patch 4)
- Rename elf_sections_info to btf_elf_secs, remove use of
  libbpf_get_error(), reset btf->owns_base when relocation
  succeeds (Andrii, patch 5)

Changes since v4[5]:

- Moved embeddedness, duplicate name checks to relocation time
  and record struct/union size for all distilled struct/unions
  instead of using forwards.  This allows us to carry out
  type compatibility checks based on the base BTF we want to
  relocate with (Eduard, patches 1, 3)
- Moved to using qsort() instead of qsort_r() as support for
  qsort_r() appears to be missing in Android libc (Andrii, patch 3)
- Sorting/searching now incorporates size matching depending
  on BTF kind and embeddedness of struct/union (Eduard, Andrii,
  patch 3)
- Improved naming of various types during relocation to avoid
  confusion (Andrii, patch 3)
- Incorporated Eduard's patch (patch 5) which handles .BTF.base
  sections internally in btf_parse_elf().  This makes ELF parsing
  work with split BTF, split BTF with a distilled base, split
  BTF with a distilled base _and_ base BTF (by relocating) etc.
  Having this avoids the need for bpftool changes; it will work
  as-is with .BTF.base sections (Eduard, patch 4)
- Updated resolve_btfids to _not_ relocate BTF for modules
  where a .BTF.base section is present; in that one case we
  do not want to relocate BTF as the .BTF.ids section should
  reflect ids in .BTF.base which will later be relocated on
  module load (Eduard, Andrii, patch 5)

Changes since v3[6]:

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

Changes since v2[7]:

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

Changes since RFC [8]:

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
[3] https://lore.kernel.org/bpf/20240517102714.4072080-1-alan.maguire@oracle.com/
[4] https://lore.kernel.org/bpf/20240528122408.3154936-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20240517102246.4070184-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20240510103052.850012-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20240424154806.3417662-1-alan.maguire@oracle.com/
[8] https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire@oracle.com/

Alan Maguire (8):
  libbpf: add btf__distill_base() creating split BTF with distilled base
    BTF
  selftests/bpf: test distilled base, split BTF generation
  libbpf: split BTF relocation
  selftests/bpf: extend distilled BTF tests to cover BTF relocation
  resolve_btfids: handle presence of .BTF.base section
  module, bpf: store BTF base pointer in struct module
  libbpf,bpf: share BTF relocate-related code with kernel
  kbuild,bpf: add module-specific pahole flags for distilled base BTF

Eduard Zingerman (1):
  libbpf: make btf_parse_elf process .BTF.base transparently

 include/linux/btf.h                           |  64 ++
 include/linux/module.h                        |   2 +
 kernel/bpf/Makefile                           |  10 +-
 kernel/bpf/btf.c                              | 168 +++--
 kernel/module/main.c                          |   5 +-
 scripts/Makefile.btf                          |   5 +
 scripts/Makefile.modfinal                     |   2 +-
 tools/bpf/resolve_btfids/main.c               |   8 +
 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/btf.c                           | 660 ++++++++++++------
 tools/lib/bpf/btf.h                           |  36 +
 tools/lib/bpf/btf_iter.c                      | 177 +++++
 tools/lib/bpf/btf_relocate.c                  | 529 ++++++++++++++
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   3 +
 .../selftests/bpf/prog_tests/btf_distill.c    | 552 +++++++++++++++
 16 files changed, 1955 insertions(+), 270 deletions(-)
 create mode 100644 tools/lib/bpf/btf_iter.c
 create mode 100644 tools/lib/bpf/btf_relocate.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c

-- 
2.31.1


