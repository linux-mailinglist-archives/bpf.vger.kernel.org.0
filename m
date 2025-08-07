Return-Path: <bpf+bounces-65201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B7B1DA16
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1081AA2AA8
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2382641E7;
	Thu,  7 Aug 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S7Fpj/he"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26665147C9B;
	Thu,  7 Aug 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577734; cv=none; b=EcouaHOz2rJee6tdLUk93HwPlNAIQIQKKnPapBblDfs0ocUL2n4G/MycsQL+9lq6nNrUdvCHCH2dVfU7Vc4sKvuRZyNMNqj06xmMB7tO8NS4VSixDtuLzPK0Jn6fhu0vK/jd0saQ8cTjryj9tOxWLIIZ7d82ZoGhUyltPiCP8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577734; c=relaxed/simple;
	bh=cAEjn9i3/n45D2Q6P74caT2os8HbuGfdB1KtlXZF/Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnHKnJe6AZDc6UCrXTi9hEUUdxxtyFC1Sf4lBY0fuxSRqhqSMopxFoUWcNyCgqKgWGMXdmiunQs4qmVvWyOtxFSrAne6obYtFR3ug30S1e//ls2581uwi2wlYWiLPUCcjbtfAySozZijnyXbOg7eir7fkAK8nCP8ZdIELfoH0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S7Fpj/he; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777MsQB006993;
	Thu, 7 Aug 2025 14:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7bvO6sNxRW71J696voN8RK6NgSTNZ
	bKrgR+tuRZJMqc=; b=S7Fpj/heR6Ne+aTbvSTZinxOvxqh8VE3qW/u5DHBBC2GJ
	8xHDzVkv3CXlW3EoI8folLVLYQlflgLBVfOf2m55PbzUCa03qA0S3Fi2Lr7e30WL
	YoUxu9aKyh+qiFoaNpFLYiiOmylEnczb1JZBLsZ4tiWUy/OyG0bKxaU1s4GDrbCZ
	FNxK3heUBeRhEpj1Cl1TK6TKId2IeezC+mmy/02Z9dAbsNDp/Zr61xQhe5If1rbe
	f8l5xcLcgRqizz+3tysuJzsxya4ytt63Gx0B5ugGdBekLjeHQQXhxuxUhT+EhTvh
	oxqNz6XhlCBUEabg5EJjnsi6rqZZzjx7gyiheP5/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy4dny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577Du8Yt005659;
	Thu, 7 Aug 2025 14:42:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwyhvu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 577EgAIj014830;
	Thu, 7 Aug 2025 14:42:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-8.vpn.oracle.com [10.154.53.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48bpwyhvt5-1;
	Thu, 07 Aug 2025 14:42:10 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 0/6] prep for compiler-generated BTF
Date: Thu,  7 Aug 2025 15:42:03 +0100
Message-ID: <20250807144209.1845760-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070118
X-Proofpoint-GUID: XwgKMW_QbKimcOFTItNFQeRk95fgtUrY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExOSBTYWx0ZWRfX9+2ogq0i0iOc
 XwcT29b6QWmzjNuvZQuTldS1aj60W68GE0TxHHZPmXld0mz/bFhUVaoDCmfMjA95vTuA4dd9GLj
 O0KejngJ/KRApICsf6CKeMvRyky7bdjyP/48N8F8n1tusOUC9+mvec1UMp9yVgywFr75D82O4Ex
 +Yz2z/OJqbvSjmhQTY0xSapXJlNwVaDc/SvuiCRKZZI16iJFJZEbh1VjKyNOX7AoprX0HEUmJrC
 cT/jIz9Jp7IpUBsHWG7PM04xfR8acJLl9fjumSdm6fRZaFEdLBpU7UJWYiuEC2uNmS2dcKVwsfU
 vh0MhzrV6XHso2x90/xuTdTcoWCpaBKsS/0JGnSGGsYe6oXmLdxZgmP4JI3lxtt+L6A70zGiHEm
 SCtFq5LCsMY5HIZ1/hAHMrtsNgwxXXiTrgaUlpNSM543oKTylIc1IdQuKHuOf7j/CjAxgJNT
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=6894bb43 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=vbyJIY8eAAAA:8 a=soMMFH-TSS2fA1ltYOsA:9
 a=UXyj_mcEdvtx2GLQwyJ1:22 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: XwgKMW_QbKimcOFTItNFQeRk95fgtUrY

This series is intended to help pave the way to allow pahole to
handle compiler-generated BTF as input to its encoding process.

The BTF loader currently supports loading BTF for data structure
and function query but not for BTF generation.  [1] describes how
gcc can generate (and the linker deduplicate) BTF but even there
we will need pahole to post-process the results so it is valuable
to support reading BTF in pahole as input to start exploring how
to handle cases like [1].

The intention of this series is not yet to fully support
linker-deduplicated BTF, but to start down that road by supporting
reading BTF from (multiple) object files and support its deduplication
and BTF output.  To that end a few changes are needed in the
intermediate representation generated by the BTF loader; these are
done in patch 1.  Patch 2 then fixes up a few cases where we needed
to special-case the intermediate representation when it came from
BTF.  Patches 3/4 ensure that we retrieve ELF info when loading BTF
for encoding.  Patch 5 is intended to support cases where we read BTF from
multiple objects and - if the "encode_force" BTF feature is specified -
we continue as long as BTF is found in at least one of those sources.
Finally patch 6 tests pahole when BTF is used as input.

This allows us to experiment with "gcc -gbtf".  For example adding
-gbtf to the KCFLAGS environment variable for a kernel build, we can
then run pahole across the set of vmlinux objects via

pahole --format_path=btf -J --btf_features=encode_force \
        --btf_encode_detached=/tmp/vmlinux.btf $(ar t vmlinux.a)

This is clearly not the right way to do this for kernel builds -
we want to make use of linker deduplication as in [1] - but the fact
that even a hack like this works does demonstrate the viability of
handling BTF as input to vmlinux BTF encoding.  It also allows us
to provide a comparison between compiler-generated BTF with pahole
deduplication and compiler-generated BTF with linker deduplication
when the latter becomes available.

[1] https://lore.kernel.org/dwarves/87ldqf1i19.fsf@esperi.org.uk/

Alan Maguire (6):
  btf_loader: Make BTF representation match DWARF
  pfunct: Fix up function display with updated prototype representation
  pahole: Add btf_encode to conf_load
  btf_loader: read ELF for BTF encoding
  btf_encoder: Do not error out if BTF is not found in some input files
  tests: Add test of pahole using BTF as input to BTF generation

 btf_loader.c       |  36 +++++++++++--
 dwarves.c          |  14 +++++-
 dwarves.h          |   1 +
 dwarves_fprintf.c  |   2 +-
 pahole.c           |  15 +++---
 pfunct.c           |   2 +-
 tests/btf_2_btf.sh | 122 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 176 insertions(+), 16 deletions(-)
 create mode 100755 tests/btf_2_btf.sh

-- 
2.43.5


