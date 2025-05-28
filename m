Return-Path: <bpf+bounces-59155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85014AC6671
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466AC170DF4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20B279796;
	Wed, 28 May 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BDCxdwtN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7546278779;
	Wed, 28 May 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426308; cv=none; b=NrYkIzKOC5bJuVoH7RNWAdRo9+bGInCBCOLWERFXyuTxCdERRCCpSTkQN2M9lY6iUeaBgh9c+EEuRBBmx2WBpI/n7NAj3snjbkZAQMplLhRr5fGMzZ1wJlNmajjTWfGyRswq8JqgDzmr7+d1yAw42RWYJMkD3UiuMg1gBnZDIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426308; c=relaxed/simple;
	bh=9OjYGX0dGuvoeCrC8i54h3en+0jp2dMgdtZg+AK1O54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtiEgrmMtiis+uqnz4FJUZ7TtxM9lqACg85z81YG3CtfyH3FeaiOW1Im+0YF6KHATN7VjPyK86V4V5EhWlZc6+ZUutuggTLKj7Bt+1wQVxGSSIgqsTxEUMsDs+2iUpW+aR8dq1gdrST9Ko22skkxrA3ovJk5k6Y9VNi/+cVaIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BDCxdwtN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1fvBC001432;
	Wed, 28 May 2025 09:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=1K20du+o4pWxKnpdNYVLrejmAWikJ
	RzR3LoRJBRrq7c=; b=BDCxdwtN9rBcGxf5oYdE9qaruYyg/RJZDZMG9l3IqLWUH
	2QKGpiKPY942eU99DT/MaRCB+m6VECnCCoeogNiLqKERe/7kvEtSGAzd0RELDGfM
	KHrzPxJJUNxuVCE3ZvVtO+inzmPq3eqWelZeearHsejWzSsEjhxRW3GoDYML4lQZ
	gygocfkB302wo6lb8JJbUqJBzq2FiTY2nXV2tP4lo/6oi9w9y+BQioIgY5VeJu+B
	rLdhEm6rA3Nta340b5bz3u4uaGbfYMaT97g/kQbYkTmC7g+icqqdlYrffRj3br0i
	cdR71Da0DVEjs1lypy19UtZwZXCNWY50lIftYbVHw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46twffy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:57:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9XIIU024356;
	Wed, 28 May 2025 09:57:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaeuxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:57:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwVk007194;
	Wed, 28 May 2025 09:57:46 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-1;
	Wed, 28 May 2025 09:57:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 0/9] Add kind layout to BTF
Date: Wed, 28 May 2025 10:57:34 +0100
Message-ID: <20250528095743.791722-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-GUID: KI-cieHZ7GyDsjEyiV3a5YcJGzl2_S3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NiBTYWx0ZWRfXyJUXUrXsJUeB F1FKbN4EYIhMCckwD2aRyv/2go5/FcY7xWh29l3FmGX59H8Hpa2tmeJjqQxvsGLG+bMk/ioTgiL RneZQAcbzYBPDmIdEMMMNBsO0mNm2286yt4ageDpw4ZbUQzU8+2l/Rm5ZOigOGYs3gW8PADEMk7
 4TjbQw4nhb8M/vJwd0rqk0I+IS+oR6iYVtRk6bbm+IWzA98cgbS0FhiYWqZBj2ljGFcInfXp+/B M+aeMVQgJyti5o3EhO1QlWVWIaOoRtI2i5aC5tkqRfNbCtP1toKGLKCy03jKD7E5mqnXtD+Jilb ZOraoDWGSaGAe4X7CiU9ySfZVsV9BR6Tiy+6uNIFz7ek/3M8AiYffgyJMl1TDwWeTLOw8/MG/Oj
 wAalh37/Rk1HH1ejC7vctBYbtE5DSGMeidELaLRMaz1kMNl3bcA9wsZX0BIiX7B/TaJWY176
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6836de1c b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=gMmyl0DYk92usImE97kA:9 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: KI-cieHZ7GyDsjEyiV3a5YcJGzl2_S3e

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

Changes since v4: [4]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

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
[3] https://lore.kernel.org/dwarves/20250528095349.788793-1-alan.maguire@oracle.com/
[4] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/


Alan Maguire (9):
  btf: add kind layout encoding to UAPI
  libbpf: Support kind layout section handling in BTF
  libbpf: use kind layout to compute an unknown kind size
  libbpf: Add kind layout encoding support
  libbpf: BTF validation can use kind layout for unknown kinds
  btf: support kernel parsing of BTF with kind layout
  selftests/bpf: test kind encoding/decoding
  bpftool: add BTF dump "format meta" to dump header/metadata
  kbuild, bpf: Specify "kind_layout" optional feature

 include/uapi/linux/btf.h                      |  11 +
 kernel/bpf/btf.c                              |  96 ++++--
 scripts/Makefile.btf                          |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/btf.c                       |  90 ++++-
 tools/include/uapi/linux/btf.h                |  11 +
 tools/lib/bpf/btf.c                           | 316 ++++++++++++++----
 tools/lib/bpf/btf.h                           |  20 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 176 ++++++++++
 10 files changed, 627 insertions(+), 98 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3


