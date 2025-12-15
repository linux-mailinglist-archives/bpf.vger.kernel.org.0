Return-Path: <bpf+bounces-76590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BFACBD224
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C933300AC64
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC97314B81;
	Mon, 15 Dec 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qHWUzXs1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67674313E19;
	Mon, 15 Dec 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790313; cv=none; b=Ejf35RufuDRjdak1OJm2WJHsg22e82apa3ZeItNzUV5Uc4zcNggQ/v8TR2Jk5Wp42oOFVd7SCwoT8Pc3J3RTCVtIsgWKwJPxAPV9taPmdHQDwQ5y+gkavJQ3KTqFo6IkrRsdMwPOofT3rhNYw7y+e4Rr2DPiGNnmEbZTgSIIQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790313; c=relaxed/simple;
	bh=8skWFpIigf1fqm4EjCy50+1plMGHIYEEt8loB08c/T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJn6Z8xtFti+yfsdVtzCfGy8yox+/Eq1QXBSrOdI/YBVqEaVOx9V0as5XVl6mwXUTbBElKaJ3uy2dXyh42SfPoiiEtGV0kPrjN3Oa1CyjWmHDCkRBCPkFlbasBd1Eu1GCVke412H3MBHcpUcCUU1sZ7HQb/DBLWMp91Pfhwyb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qHWUzXs1; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uKm61652143;
	Mon, 15 Dec 2025 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=73GMQeZAWy6peF3Usq8c1dgJuZPzS
	Taj4q/0cSD4zug=; b=qHWUzXs1q6v+hmPdaEBQMe9WLRIPNMeTLCVxGCeAqbxkg
	iwUktnKvu9TbkPEZ8wENcmR9T49wgAoaie53YG+FALQIhnZkEj8wqrQ3SIY1I5/p
	t03d7OMW4InrYlTV4Dt1n55pT47/s5hAM1h0LR3QrgAShc1OeU3TyTdBngGwS+Gd
	KxnaIZVquqool8ouqTLIGB5p1hNRjnql/HE+tAGCOsotgUSTAn0bDooVZlPszPvU
	ZzBzQyBPxkSbfsQu5oC5LtIdolRzWF0+cVotUx0K/4ULxRD2AXeYp5NcHxcxjCpA
	nPruYh3PVN72WVztCtyq63T6O7qGjQFB4FzuGympQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prhny1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:17:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF8h7je025249;
	Mon, 15 Dec 2025 09:17:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8ygbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:17:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BF9HdwQ027566;
	Mon, 15 Dec 2025 09:17:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-2.vpn.oracle.com [10.154.53.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk8yg99-1;
	Mon, 15 Dec 2025 09:17:39 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v8 bpf-next 00/10] Add kind layout to BTF
Date: Mon, 15 Dec 2025 09:17:20 +0000
Message-ID: <20251215091730.1188790-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA3OCBTYWx0ZWRfXxEpTwD5VzLg1
 xSFzZBcQgmMH7vOvJleWkYD8MEucxhdIxe+09h/Ni0i5jbcpXPacmK+6/EjHNNpkMxPxNOdTyV7
 Biy+4qdO/+6NZP8rfh5qQS7N2kobDuHrG/ajF3cuU7y4DxZSv+Yglt+2c+QhDk9kyJ2nBOeel+f
 rX6W2+gs3osscGHbkntGZ9QNaItI0YcgpKVgZjqOamn/cQ5yBVv67Q3KrU0wMIaJfz16MB5tV6H
 thGechxcMAepd4TbrrxnLwYbnocY8ilRgCFye1UnkXYokdcPefmOMTa+KLVlsrEmhRJZlLtSj/3
 W0R+mIybaPzmE2X5+FYUpT5x2wGLcDQSK5fUA5sTaAGw8vG70YNPrPoqR69rJFWPgZYyGObKg7F
 CW8s5ja4E3nnkWQxQBLwZkaafj0wxA==
X-Proofpoint-GUID: 8irfBAFL34-BlPXKMIVH0L8JlyIT3UkE
X-Proofpoint-ORIG-GUID: 8irfBAFL34-BlPXKMIVH0L8JlyIT3UkE
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=693fd235 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=rhq5rkmzt818iw8Jb8EA:9

Update struct btf_header to add a new "kind_layout" section containing
a description of how to parse the BTF kinds known about at BTF
encoding time.  This provides the opportunity for tools that might
not know all of these kinds - as is the case when older tools run
on more newly-generated BTF - to still parse the BTF provided,
even if it cannot all be used.

Also add support to bpftool to dump metadata about BTF; its size,
header information and kind layout section.

The ideas here were discussed at [1], with further discussion
at [2].

Patches for pahole will enable the kind layout addition during
BTF generation are at [3], but even absent these the addition of the
kind_layout feature in the final patch in this series should not break
anything since such unknown features are simply ignored during pahole
BTF generation.

Changes since v7: [4]:

- Fixed comment style in UAPI headers (Mykyta, patch 1)
- Simplify calcuation of header size using min() (Mykyta, patch 2)
- simplify computation of bounds for kind (Mykyta, patch 3)
- Added utility functions for updating type, string offsets when
  data is added; this simplifies the code and encapsulates such
  updates more clearly (patch 2)

Changes since v6: [5]:

- BPF review bot caught some memory leaks around freeing
  of kind layout; more importantly, it noted that we were
  breaking with the contiguous BTF representation for
  btf_new_empty_opts(). Doing so meant that freeing kind_layout
  could not be predicated on having btf->modifiable set, so
  adpoted the contiguous raw data layout for BTF to be
  consistent with type/string storage (patches 2,4)
- Moved checks for kind overflow prior to referencing kinds
  to avoid any risk of overrun (patches 3, 8)
- Tightened up kind layout header offset/len header validation
  to catch invalid combinations early in btf_parse_hdr()
  (patch 2)
- Fixed selftest to verify calloc success (patch 7)

Changes since v5: [6]:

- removed flags field from kind layout; it is not really workable
  since we would have to define semantics of all possible future
  flags today to be usable. Instead stick to parsing only, which
  means each kind just needs the length of the singular and
  vlen-specified objects (Alexei)
- added documentation for bpftool BTF metadata dump (Quentin, patch 9)

Changes since v4: [7]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

Changes since v3 [8]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [9]:

- drop "optional" kind flag (Andrii, patch 1)
- allocate "struct btf_header" for struct btf to ensure
  we can always access new fields (Andrii, patch 2)
- use an internal BTF kind array in btf.c to simplify
  kind encoding (Andrii, patch 2)
- drop use of kind layout information for in-kernel parsing,
  since the kernel needs to be strict in what it accepts
  (Andrii, patch 6)
 added CRC verification for BTF objects and for matching
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
[3] https://lore.kernel.org/dwarves/20251210202752.813919-1-alan.maguire@oracle.com/
[4] https://lore.kernel.org/dwarves/20251211164646.1219122-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20251210203243.814529-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[8] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[9] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

Alan Maguire (10):
  btf: add kind layout encoding to UAPI
  libbpf: Support kind layout section handling in BTF
  libbpf: use kind layout to compute an unknown kind size
  libbpf: Add kind layout encoding support
  libbpf: BTF validation can use kind layout for unknown kinds
  btf: support kernel parsing of BTF with kind layout
  selftests/bpf: test kind encoding/decoding
  bpftool: add BTF dump "format meta" to dump header/metadata
  bpftool: Update doc to describe bpftool btf dump .. format metadata
  kbuild, bpf: Specify "kind_layout" optional feature

 include/uapi/linux/btf.h                      |  11 +
 kernel/bpf/btf.c                              |  96 ++++-
 scripts/Makefile.btf                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  28 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/btf.c                       |  94 ++++-
 tools/include/uapi/linux/btf.h                |  11 +
 tools/lib/bpf/btf.c                           | 362 +++++++++++++-----
 tools/lib/bpf/btf.h                           |  20 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 178 +++++++++
 11 files changed, 690 insertions(+), 115 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3


