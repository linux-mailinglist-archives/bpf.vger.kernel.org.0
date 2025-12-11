Return-Path: <bpf+bounces-76473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A165FCB68F1
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85AD230213C5
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BACA2D594A;
	Thu, 11 Dec 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gAr8uXoV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E468128816;
	Thu, 11 Dec 2025 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471636; cv=none; b=rfSkSLz2/pLtr3Rvcb2ZBHI4ZQ8oTPbMag1oPmKpWeX3dBJsrUJOZEtCCJq3tgs9ZMR/QPG3sQv9RNxm92noDw5rgpsCahwLSNF1cN/MLS6gl9SapZZU/AscVHGs3I33CGaIhMgGz5d7ZIWwRZGgpstmk6JpjPy62N9/9HTUUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471636; c=relaxed/simple;
	bh=cfLbcLZ7vaT3hqKM8FunDl3l7PuCaz3r/sElXQS+aK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fG9TW1AAJX1v/3u8kvfzd6iSLJ8YpDZ/DQyAlsFahGQGkBnwKq57hginq/1QRSWeSKLkxsPRbIGB7F7qIiqAwDnM/8IxMmc3K7qOsoK7JqQ83xLx+EHApycs1age9FF0978a43s9E46h9sKjQH/b9ZDES+eI1JHXJZToymUomBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gAr8uXoV; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBG5R6f1894773;
	Thu, 11 Dec 2025 16:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tUA1aGk572rH1j/Z5SDtqshzHDYwy
	VsFAV/pFwBUZZI=; b=gAr8uXoVhyBSXmueMn+9WjE0lzf9qhb1DJJGXWJ1ol4wb
	2eNVsBykzLGdKs2S/ap+QiMqf0uoXgwtrdQCyyX7mPdXXdnbOZefWU+i16sr8aLl
	veM287luQraemZEuapoKtqc8ASkG4u83Tt52C/3eZX/mhlYeg/EKj7fD8/Qeno27
	XDUywrOKAs4cdZK9I6N3ITGmWX7Hu5jObkWT8yZaQElOL8CcsF9FRR7ly93aZQiC
	Y1qDacNhGNjG6J/cwK3UqrTfWUXZAJg2SLOOy7lNWKzxtWeaP4qXAb5DZb7ciyfy
	g7mT3GrGt848/5PbqputKWCZhLL7BgWm+8BXD2pZQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ay9y326ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:46:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBFxJOM040622;
	Thu, 11 Dec 2025 16:46:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnswry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:46:50 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BBGknm7030704;
	Thu, 11 Dec 2025 16:46:49 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-126.vpn.oracle.com [10.154.50.126])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxnswqy-1;
	Thu, 11 Dec 2025 16:46:49 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 00/10] Add kind layout to BTF
Date: Thu, 11 Dec 2025 16:46:36 +0000
Message-ID: <20251211164646.1219122-1-alan.maguire@oracle.com>
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
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110133
X-Proofpoint-GUID: gwD8i7ng3dR9GpwxLeZuCmjyJUNGpSj3
X-Proofpoint-ORIG-GUID: gwD8i7ng3dR9GpwxLeZuCmjyJUNGpSj3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNCBTYWx0ZWRfX5e1pbBF6cm6x
 /8BksH6MudhdSsDwIpFVqSTRlIigmenqdhzi46tn3ioqVzsgeUWZNLGUYDO6aYSzW1bmytzu2kq
 D7BL3ZWXn1rq/fyMl81Ujc+2JlLerPfmnl7l8qoEgLE+cJd25Dw7aPy4eWgbBbP5bdR48JrS85T
 fMoq74hbu4b3Tr+BGFtLPyjoDl/EVBOjriXZcsyfxD0Knvr1ZmSeUOGlcK1MVydJjnJ1ahziM9g
 SCNNE6JM+tl6hgFBmkG6djV2hE13Xw7OH2JqoHrE1YLJ5ahBcpdbhEEvlRvNod8vklK4r4flTmC
 BIT/SZznErme/EWcRMoRSrJ3fUlDqSzkb9xMiY5umPmVTfHqjgjETkomgbZlHMuozF2RbO5YiJR
 apgpHQBYo+pC1I9nFhBug/d0riSu1QxWkxuaILBIK/XR+mzDZCw=
X-Authority-Analysis: v=2.4 cv=YJeSCBGx c=1 sm=1 tr=0 ts=693af57b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=_BFYMIbDUM0KML3pps0A:9 cc=ntf awl=host:12110

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

Changes since v6: [4]:

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

Changes since v5: [5]:

- removed flags field from kind layout; it is not really workable
  since we would have to define semantics of all possible future
  flags today to be usable. Instead stick to parsing only, which
  means each kind just needs the length of the singular and
  vlen-specified objects (Alexei)
- added documentation for bpftool BTF metadata dump (Quentin, patch 9)

Changes since v4: [6]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

Changes since v3 [7]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [8]:

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
[4] https://lore.kernel.org/bpf/20251210203243.814529-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[8] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

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

 include/uapi/linux/btf.h                      |  10 +
 kernel/bpf/btf.c                              |  96 ++++--
 scripts/Makefile.btf                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  28 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/btf.c                       |  94 +++++-
 tools/include/uapi/linux/btf.h                |  10 +
 tools/lib/bpf/btf.c                           | 319 ++++++++++++++----
 tools/lib/bpf/btf.h                           |  20 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 178 ++++++++++
 11 files changed, 661 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3


