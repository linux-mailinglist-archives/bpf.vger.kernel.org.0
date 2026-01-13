Return-Path: <bpf+bounces-78713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81997D19138
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 14:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E2F3306F263
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4F938FF19;
	Tue, 13 Jan 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EjYG7LWj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFA2556E;
	Tue, 13 Jan 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310061; cv=none; b=r1k4ys1252yIiO8ASCup+WWnS5DloGm4ZIyKJTWAJXkFcAC7kf2myhI4W1ByxFQit9aIx94wPm+7ADf1/vXzuf7/D17w4X7ZB+NDnDI3C1kbH6OE+mSYPAv4JGsw4wGlgqfSv09Wg6RHP0794iV4mFtZ66TMRMMQR/m+t1dT5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310061; c=relaxed/simple;
	bh=REBn5zGFf1WxpLZP6l8dibmNt1lUjVMOwPu7Blvwo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOcJ1DGwQiJlKmMrDH2UPxrlwFXMtE81LcIaeecQ8WLeExp07uMQsrexSluawzr90id/1k9EkUnRWp0mdKKKhonXctPifZjw9Rde6UxfaOSCPkTm8JjUIVJiXYLvvqFtqEy+oE+LHAKtPwyFvPdaGLcRd9xblBNi3dO/7IloAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EjYG7LWj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gBAS2682127;
	Tue, 13 Jan 2026 13:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=c8GMTqbL1+dB4S4B01doB3chSu8aI
	yKZ4Rj7i5JDZmg=; b=EjYG7LWjeYIrSmmOkzr0+IpARiUqdiLCCkuakvdKMKxfe
	JBRFntkT1J9GQ0HsnYhEPBq7ldsZmUKrEorBUBmLmtFDvOu+g/vuM6ZtxipusdkC
	QrgQWtPeuTIJL2obAo9fdzfbnrF8v2sL/4ARMH3hBcRarrAEN9+qO82TQ+75zsv2
	HiE7dbvy49X0t+Ra0dXBL+o8FQYmvZNTxmAg1lK9KjYmpR1ZCo/KCCDAFec39WoE
	rR6X4SdmD8vGZEt90I7oPcRcESq62/kRbbeuUHnoMSojzWIq88FH1UrfoZp60Ma4
	5JsUHakrAVCm15ugEPRed/TOgOLjKZU8dmE58DvOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb3e2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:14:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DCpRSQ004358;
	Tue, 13 Jan 2026 13:14:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7jg7gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:14:13 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60DDEBYT037732;
	Tue, 13 Jan 2026 13:14:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-89.vpn.oracle.com [10.154.50.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7jg7a6-1;
	Tue, 13 Jan 2026 13:14:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/4] Improve BTF concrete function accuracy
Date: Tue, 13 Jan 2026 13:13:48 +0000
Message-ID: <20260113131352.2395024-1-alan.maguire@oracle.com>
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
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=744 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130111
X-Proofpoint-GUID: 1fEfgeZ7MmGF3J5_ulMEUkZ6iI8mJTau
X-Proofpoint-ORIG-GUID: 1fEfgeZ7MmGF3J5_ulMEUkZ6iI8mJTau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExMSBTYWx0ZWRfX7ifaAKjEsbS3
 /TBVarWjUesfQJB//xCC+26W2ChogohKFO5Rv0Z/Ij6SSSbjS8I6ie/mzf0WbbgXxPsQ5nYo5lT
 vXtw+I/o8KsjztOGN/PtI9lTSRjoXMmoQT4lo5xJwosXM6rlh5AGIFwVKa3v0z/gmED+jJoXXPZ
 3AZnLI7MPsrZ9VAQy8jDAd9tjkJXZAgGZvER92TJKqiKbmzM7Qf0F9FgnSIbY+O5N85kUJPw8G+
 AI+L5sKijkU6wGB3yYDMhCspFKQ0WrSgaL9HGiXlCDpGUDQMNlLaQ5JbetTumc2rOnj7nSQ+n9X
 ruAaOqmT++wbzCbq/M7Hs3Z6JFXnMtWEngKZHgl7XLDA9KdYzYhpQBtcl4sX3u/UeIRz3hi3hxp
 S3kjUuBnV0uzuL5a7s9g1c4+a6Wxadt5czMVSj/fV/AEpYnEZ72fKGkgZjA1YASYNQvfJurThqt
 nzianKfgY7m23e3C5qFUlpdKEmEfmmH3ItLkZpPE=
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=69664525 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mTeYw-Z3I5E7VyaPtpUA:9 cc=ntf
 awl=host:12110

This series brings together a few solutions to issues we have
with accuracy of BTF function representation at the binary level.

The first patch detects mismatches between concrete (binary)
and abstract (source-level) function signatures as a means
of either excluding them or providing a "true" function signature.

Patch 2 is from Yonghong's LLVM true function signature series,
and helps for patch 3 which adds GCC true function signature
support for optimized functions; with that support, we use
binary-level signatures for .isra, .constprop functions and
represent them with their "." suffixes as BTF_KIND_FUNC
names.  This allows for fentry attach to such functions, and
the "." suffix is an indicator of signature modification.
The feature is guarded by a default-off BTF feature because
older kernels did not support a "." in a function name.

Patch 4 is Matt's patch to favour the strong function
over the associated weak declaration.  The other patches
are important prerequisites for this as the patch selects
the binary-level function (with a lowpc value), and in
the case of optimized functions we were often selecting
the .isra function with optimized-out parameters.  Because
pahole did not previously detect this correctly we ended
up with functions with signatures having reordered parameters.

Patches 1-3 help avoid this by better detecting optimized-out
function parameters.

With these patches in place, ~20 functions are omitted from
vmlinux BTF; all these are "."-suffixed functions which
we were not noticing had optimized-out parameters.

Experimenting with adding true_signature to BTF features
we end up adding approximately 500 .isra and .constprop
functions to vmlinux BTF.

The true function signature support here will also hopefully
help pave the way for Yonghong's work on the LLVM side.

Alan Maguire (2):
  dwarf_loader/btf_encoder: Detect reordered parameters
  btf_encoder: Add true_signature feature support for "."-suffixed
    functions

Matt Bobrowski (1):
  btf_encoder: Prefer strong function definitions for BTF generation

Yonghong Song (1):
  btf_encoder: Refactor elf_functions__new() with struct btf_encoder as
    argument

 btf_encoder.c  | 142 ++++++++++++++++++++++++++++++++++++++++++-------
 dwarf_loader.c |   5 +-
 dwarves.h      |   3 ++
 pahole.c       |   1 +
 4 files changed, 131 insertions(+), 20 deletions(-)

-- 
2.43.5


