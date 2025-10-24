Return-Path: <bpf+bounces-71996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03881C04BE7
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 09:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E91C64FDDF6
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 07:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5592E5400;
	Fri, 24 Oct 2025 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c3FgtXNH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD92E2DE6;
	Fri, 24 Oct 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291245; cv=none; b=ANRU4SK0PKrHMOwabeSpfKZeZyOge7SIctYmW1en9nIB5JT34GehruF6G7Tlu34YpC4WQ0AeJee8hYcvz2D+nicctVodbIQ6EaQKhhD2uBbJpZe1CsWGP0avhBNdIYEFmeD1MJWe0ODuNfmoq18qePpeTCC+NVfPFaNUVTJfyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291245; c=relaxed/simple;
	bh=0UAec0Fr+NXUdWX+wkOeNQszJqaI0q/zsFGU5CjU0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbTAb3RllNlwdDc2si/Ej/8H7T+jIgUK5doXL7wNXuQ5y9JJk16ysNVe9//KIofyfh227S8YqXSZodPZmxqlk/YaApUHWCyB64c8Kncv0pttLtttAvQ6V4ZIHPtgYJKnk9VnAQsq3gQUZqrSnO6fD5dWHuu4QJmpnk0qlZ1R6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c3FgtXNH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NWHA005755;
	Fri, 24 Oct 2025 07:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=wxHYR7ihB1r1dCploAkzZQWl5F5Cu
	QnQs24YD7aVxCo=; b=c3FgtXNHjoFIVO1z9FxnU3wQlNdkbM3w68gfiwmY6VJci
	uMu6+5CGJGTrc1Fn10i0EngAJlwz5T65ymCebTdkMpfWGr5brgEUPusaJMg74Yv1
	S7W+H31GcOrEZkEGk2SXVmYDoo6CEiJmsSBqjzBU8NaTh5hRw2lY41z2j9/bvI2Q
	mo9D/d013B7h3I46SfJV32RDpfVww/i1asuWa2L0WSmqAxrd+F+RcUE+cJYyE4dO
	wsVLGQgbBGQpo9/qvlfUO/VTFlqd/5CNcrQEKsSHJX/SLgjjS07+EN7NJJclwqnB
	eJtJk40P40pU6viEpqsHa65i1Sco1z/N34yZvoUKw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv5wm4q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5MC1P022300;
	Fri, 24 Oct 2025 07:33:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm4ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59O7XYwd019356;
	Fri, 24 Oct 2025 07:33:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-127.vpn.oracle.com [10.154.57.127])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bgm48v-1;
	Fri, 24 Oct 2025 07:33:34 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 0/5] pahole: support BTF inline encoding
Date: Fri, 24 Oct 2025 08:33:23 +0100
Message-ID: <20251024073328.370457-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240065
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX74csGnbckTSJ
 NyIlGfOdirJ/v5k/tbSg84ibZMNDaOR1CcSOuId25OREgOh1zU3+fOF5siwUb2AMu9a5JSGXRpy
 LBv6fOX9KDLZrX1noFwOYIKLscmk/WxTGm6Wq/HORyWS7PxbUtLFw6PGnUzgblIMvcfO23nyeLz
 3nnuSyIYHcMOMYIgSzg6KSWoDk0D4wd9eDbn6mMIGGM6qMuwtUiAqptOthCJ7GNM52YtQrCFcxr
 n2W7/kPdycfP5L6D5G4kuWDIpEKHwoiU2bV6j1TpQ7wdk8xbDxgrZWg8lkMBu+GpiObIryKIVmP
 tD7506venXDPeUngPz4Mzh2yFV2zvnUwz8y8zSwPlLAOS0+8Zkx+VcH/rNrsu4cXcqpMN9r8nBE
 Cv3n7QfshTgiMUmRjhhfWB8UIFuE6XW7xOpz/i7D/iwCepRp9Bo=
X-Proofpoint-GUID: Xw9WjEbmNYafsC-pcMoI0HGK3iSrK9dU
X-Proofpoint-ORIG-GUID: Xw9WjEbmNYafsC-pcMoI0HGK3iSrK9dU
X-Authority-Analysis: v=2.4 cv=RfOdyltv c=1 sm=1 tr=0 ts=68fb2bcf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=MKHlBN67fjswmNnkxXsA:9 cc=ntf awl=host:13624

This series is the RFC companion to [1]; while it has some issues
(including segmentation faults which will be fixed in follups)
hopefully it illustrates the approach.

These patches were developed with help from prior work by
Eduard Zingerman on inline site decoding and Thierry Treyer
on inline encoding, but the scheme used here is somewhat simpler.
It relies on using standard BTF kinds (_LOC_PARAM for parameters
at inline sites, _LOC_PROTO for collections of paraeters at inline
sites, _LOCSEC for descriptions of inline sites; names, function
prototypes, location prototypes and relative address offsets).

Patches 1-3 focus on preparing the DWARF loader to collect
inline info.

Patch 4 does the BTF encoding, and patch 5 adds the inline option.

The target of encoding is either the .BTF section (if "inline"
is specified as btf_feature) or .BTF.extra (for the inline.extra
feature).

One challenge here is that we need to stash info about function
prototypes while walking DWARF CUs for later use in inline
encoding.  However, if the inlines are encoded in a separate
split BTF section (inline.extra) dedup that happens to the
main BTF will not renumber these type references.  As a result
we need to ask dedup to hand us back the old->new BTF id
mappings to fix things up.

Note that since RFC of the bpf-next series we will be changing
a lot of this, but it still gives a rough sense of how things
are done.

[1] https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/

Alan Maguire (3):
  dwarf_loader: Collect inline expansion location information
  btf_encoder: Support encoding of inline location information
  pahole: Support inline encoding with inline[.extra] BTF feature

Thierry Treyer (2):
  dwarf_loader: Add parameters list to inlined expansion
  dwarf_loader: Add name to inline expansion

 btf_encoder.c  | 396 +++++++++++++++++++++++++++++++++++++++++----
 dwarf_loader.c | 428 ++++++++++++++++++++++++++++++++++++-------------
 dwarves.c      |  26 +++
 dwarves.h      |  60 +++++++
 pahole.c       |  33 +++-
 5 files changed, 791 insertions(+), 152 deletions(-)

-- 
2.39.3


