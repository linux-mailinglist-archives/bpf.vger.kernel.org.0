Return-Path: <bpf+bounces-76425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8FCB3F71
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C442C3011A92
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E67732C31E;
	Wed, 10 Dec 2025 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JOpqhH6y"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D93126B9;
	Wed, 10 Dec 2025 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398802; cv=none; b=dOouarBfQ5aBpLbdF8bn9L2I/aZRb7UKrFMosyWBlJXY1y9jA0ytEE7OiXLUiBe0f755KP4XYro6/ppzDKAIi/WBiblEXjVCbydbeAQbYpM9JGUWZU2ejk38g0p/nZXgPSfBGB4l7cDKgeeHmZsSjiDpFBU+8vHjp0+sTaL+LJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398802; c=relaxed/simple;
	bh=xBLt1t4nwpuyd/HcTKehtLtkonudCMV7Gr0/XxihSuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjNmxBpnv2+86FxV2V1N7djHHh2qcOTRp7khlzXshd74zkgKbKNCXMuTZVATSukdAYlhgv0cSeohVr9K56IFoDyM+ijHo2doTpgsORxz8bKsfM1mRjarOQWXtBHwYd09gvx/XNxIy/JFiMLeCiq/iY/Sj9G/PdyIkrZOSW5toSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JOpqhH6y; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYNDl3730102;
	Wed, 10 Dec 2025 20:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=+dumOvegogpCHmF47f1bKdcI1V3F9
	gIaZJ6ipvbMK1I=; b=JOpqhH6yaKCoV8BMm+4zSD1aY7sdvatEK0SXkSMY1nCme
	rk/SKJasMcQm0Fq7YipmM/M2i8FtSAx/IF4at+EqQM4NcdVWrAsL6UWn4sdHine2
	d/9GsfuTjSZqg0wAZMdp/bDlNxjNdAOvXjXXHWmYopniGLeAx4VEEi0SP2WlTKix
	yE1x7pI1hUfYdbKmf4WYuAT4OUUCtLYaBCB2WxGORcB81rvKsApmyi1ycmdkGlxB
	GTjRuC7AzlIxP06ASgeQQ5hJvGxO5Y3Munpsa3Tcuww9N8hIzHKr1DiljAeDaxT8
	Bm/LsnnLl9wFc0eE80BjDAriVcufU9PdWEgjGKbRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayc9q0e3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:32:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAKJCDt040344;
	Wed, 10 Dec 2025 20:32:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrpsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:32:47 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkST001635;
	Wed, 10 Dec 2025 20:32:46 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-1;
	Wed, 10 Dec 2025 20:32:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 00/10] Add kind layout to BTF
Date: Wed, 10 Dec 2025 20:32:33 +0000
Message-ID: <20251210203243.814529-1-alan.maguire@oracle.com>
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
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100168
X-Proofpoint-GUID: fM3kTDpR_A0FpkHyadmu5RufgYd1gTPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfXxG1bt5F1BSCq
 Eltn00/kHYW614KM0/bUFFW0UOZqXrDSK7uoYSuVL6cNUtvUAQPgsUHFpLknSlLByqBuKDLzVsg
 angqt7GLkv6lIGWwkSavfLB4LNy+j9DxxRhFFO8FUAqp+qiXP/MliJj3NQ4rl7k0yaLgUjW8hya
 w9QJaU304TajgyZsE2e2FwnPrQGlDDRkrMWEsY/l/2LR5Ysij7CBV5FMFA/mDVscnjiC6xATcyT
 wwff9RdBli0EkIgYOMw9jvB+ToXE5UHeaJPWdKHBJKuDp628CBWDAHtD5iyQl9S+Hay+iC7mYZJ
 LDPyeX7IBX+RaqA75yBNAW4VOAXeCRZ8r94r6KKG+j/XtxLnXJO3/BvVU5Dzw8ZoFAU/xxW3IQn
 8MDcozarhGJRShtaFGARQG9gEeeuSfy0vLHwnEwmYIJdazVmI1o=
X-Proofpoint-ORIG-GUID: fM3kTDpR_A0FpkHyadmu5RufgYd1gTPW
X-Authority-Analysis: v=2.4 cv=SYn6t/Ru c=1 sm=1 tr=0 ts=6939d8ef b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=gMmyl0DYk92usImE97kA:9 cc=ntf awl=host:12099

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

Changes since v5: [4]:

- removed flags field from kind layout; it is not really workable
  since we would have to define semantics of all possible future
  flags today to be usable. Instead stick to parsing only, which
  means each kind just needs the length of the singular and
  vlen-specified objects (Alexei)
- added documentation for bpftool BTF metadata dump (Quentin, patch 9)

Changes since v4: [5]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

Changes since v3 [6]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [7]:

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
[4] https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

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
 tools/bpf/bpftool/btf.c                       |  89 ++++-
 tools/include/uapi/linux/btf.h                |  10 +
 tools/lib/bpf/btf.c                           | 304 +++++++++++++-----
 tools/lib/bpf/btf.h                           |  20 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 176 ++++++++++
 11 files changed, 639 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.43.5


