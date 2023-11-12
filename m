Return-Path: <bpf+bounces-14922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A37E8FC1
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ED7280BF9
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D798BE5;
	Sun, 12 Nov 2023 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qFH3YfGF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A080648
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:10 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5623430C2
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCj0rt028955;
	Sun, 12 Nov 2023 12:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=sXGRCpaAhbhb5d9RgDT1UMjtj2IEWdCROziUQ3gV4Rc=;
 b=qFH3YfGF6CEtmnMzimUrL+wvosNRLNwKqvaQm23d4siyRHPlRwH7b4jGP/U6Pyilw2kO
 ENuyntwJQA/Ce7kB5dw0B4k8zcrH/TryETYOOUuAoYDxjBOz4SiwNB5KfkobanQk93Qu
 ciPWRRMNxpkuj8185XTT/vQDEPurg3b/VYU/xazVGOVM0jy0hxiYCHLqi+bfxzFLUILt
 Rpdz1H/5cqlKOOs0vxDY6ZKPQzeFPOtjuQadzlPE7ChSUNnzIEvjcKSTfCKa6JEuLeMw
 FlIxK19HXFu8ApA8a9BidnOygSnlwHJoJC1hhSpZin27Q807141a45pP6KjPrXURMUJt Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd1e1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:48:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCElvE009031;
	Sun, 12 Nov 2023 12:48:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngff8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:48:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmce2029718;
	Sun, 12 Nov 2023 12:48:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-1;
	Sun, 12 Nov 2023 12:48:38 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 00/17] Add kind layout, CRCs to BTF
Date: Sun, 12 Nov 2023 12:48:17 +0000
Message-Id: <20231112124834.388735-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-ORIG-GUID: pgWs0c-Jti-QhvlPq_bJSQBqXj7aQYSd
X-Proofpoint-GUID: pgWs0c-Jti-QhvlPq_bJSQBqXj7aQYSd

Update struct btf_header to add a new "kind_layout" section containing
a description of how to parse the BTF kinds known about at BTF
encoding time.  This provides the opportunity for tools that might
not know all of these kinds - as is the case when older tools run
on more newly-generated BTF - to still parse the BTF provided,
even if it cannot all be used.

Also add CRCs for the BTF and base BTF (if needed) from which it was
created.  CRCs provide a few useful features:

- the base CRC allows us to explicitly identify when the split and
  base BTF are not matched
- absence of a base BTF CRC can indicate that BTF is standalone;
  i.e. not defined relative to base BTF

The former case can be used to explicitly reject mismatched
module/kernel BTF rather than assuming it is matched until an
unexpected type is encountered.

The latter case is useful for modules that are not built as
frequently as the kernel; in such cases, the module can be built
standalone by specifying an empty BTF base:

 make BTF_BASE= M=path/2/module

If CRCs are not present (as will be the case for pahole versions
prior to the proposed v1.26 which will support CRC generation),
standalone BTF can still be identified by a slower fallback
method of examining BTF type ids to ensure that BTF is
self-referential only.

To ensure existing tooling can handle standalone BTF for kernel
modules,  we remap the type ids to start after the vmlinux
BTF ids, to make it appear to be split BTF.  This allows tools
(and the kernel) that assume split BTF for modules to operate normally.

Also add support to bpftool to dump metadata about BTF; its size,
header information and kind layout section.

The ideas here were discussed at [1], with further discussion
at [2].

A  patch for pahole [3] will enable the CRC/kind layout
addition to BTF generation, but the kernel can still be built
and tests added will still pass; it will just be the case that
we fall back to the slowpath of standalone module identification
in the absence of CRCs in the standalone module.

Note that for additional context I will be discussing this work
along with some other issues around evolving BTF at Linux
Plumbers next week; see [4] where slides will be added shortly.

Changes since v3 [5]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [6]:

- drop "optional" kind flag (Andrii, patch 1)
- allocate "struct btf_header" for struct btf to ensure
  we can always access new fields (Andrii, patch 2)
- use an internal BTF kind array in btf.c to simplify
  kind encoding (Andrii, patch 2)
- drop use of kind layout information for in-kernel parsing,
  since the kernel needs to be strict in what it accepts
  (Andrii, patch 6)
- added CRC verification for BTF objects and for matching
  with base object (Alexei, patches 7,8)
- fixed bpftool json output (Quentin, patch 10)
- added standalone module BTF support, tests (patches 13-17)

Changes since RFC

- Terminology change from meta -> kind_layout
  (Alexei and Andrii)
- Simplify representation, removing meta header
  and just having kind layout section (Alexei)
- Fixed bpftool to have JSON support, support
  prefix match, documented changes (Quentin)
- Separated metadata opts into add_kind_layout
  and add_crc
- Added additional positive/negative tests
  to cover basic unknown kind, one with an
  info_sz object following it and one with
  N elem_sz elements following it.
- Updated pahole-flags to use help output
  rather than version to see if features
  are present


[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/20231110111533.64608-1-alan.maguire@oracle.com/
[4] https://lpc.events/event/17/contributions/1576/
[5] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/


Alan Maguire (17):
  btf: add kind layout encoding, crcs to UAPI
  libbpf: support kind layout section handling in BTF
  libbpf: use kind layout to compute an unknown kind size
  libbpf: add kind layout encoding, crc support
  libbpf: BTF validation can use kind layout for unknown kinds
  btf: support kernel parsing of BTF with kind layout
  bpf: add BTF CRC verification where present
  bpf: verify base BTF CRC to ensure it matches module BTF
  kbuild, bpf: switch to --btf_features, add crc,kind_layout features
  bpftool: add BTF dump "format meta" to dump header/metadata
  bpftool: update doc to describe bpftool btf dump .. format meta
  selftests/bpf: test kind encoding/decoding
  bpf: support standalone BTF in modules
  kbuild, bpf: allow opt-out from using split BTF for modules
  selftests/bpf: generalize module load to support specifying a module
    name
  selftests/bpf: build separate bpf_testmod module with standalone BTF
  selftests/bpf: update btf_module test to ensure standalone BTF works

 include/uapi/linux/btf.h                      |  18 +
 kernel/bpf/btf.c                              | 435 +++++++++++++-
 scripts/Makefile.btf                          |   5 +
 scripts/Makefile.modfinal                     |   4 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  30 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/btf.c                       |  91 ++-
 tools/include/uapi/linux/btf.h                |  18 +
 tools/lib/bpf/btf.c                           | 341 ++++++++---
 tools/lib/bpf/btf.h                           |  11 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |   8 +-
 .../selftests/bpf/bpf_testmod/Makefile        |  10 +-
 .../bpf_testmod_standalone-events.h           |  57 ++
 .../bpf/bpf_testmod/bpf_testmod_standalone.c  | 551 ++++++++++++++++++
 .../bpf/bpf_testmod/bpf_testmod_standalone.h  |  31 +
 .../bpf_testmod_standalone_kfunc.h            | 109 ++++
 .../selftests/bpf/prog_tests/bpf_mod_race.c   |   8 +-
 .../selftests/bpf/prog_tests/btf_kind.c       | 176 ++++++
 .../selftests/bpf/prog_tests/btf_module.c     |  19 +-
 .../selftests/bpf/prog_tests/module_attach.c  |   6 +-
 tools/testing/selftests/bpf/test_progs.c      |   6 +-
 tools/testing/selftests/bpf/test_verifier.c   |   6 +-
 tools/testing/selftests/bpf/testing_helpers.c |  24 +-
 tools/testing/selftests/bpf/testing_helpers.h |   4 +-
 25 files changed, 1832 insertions(+), 139 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone-events.h
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.c
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.h
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone_kfunc.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.31.1


