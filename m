Return-Path: <bpf+bounces-43279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57C9B2B21
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B6280E7B
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C1192B7C;
	Mon, 28 Oct 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5hSdjaj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA329188737
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106978; cv=none; b=pKLgsIwCWFLaq/kwqc3xuZzwDf2qik5j4DmZoESwWoHM5HHMVm0XyQxlwhwfVR93lLWDwPrcA8U6qhPLS/kVVWTqfwtORCwNPsAhcbTJFPpql4yWxAPX5rC/1e4x603V1vnFyRowSQ7Wz+Yw8iKvWwHjhyj2s6Hzno06sFjDins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106978; c=relaxed/simple;
	bh=ujRzFk5tVZB3HecsR0nNJ3MP+/LJI6hkyxL/fax2Uf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOs4NS5WmTGdGkZpAJFwAHQqNwM/mDafwu1qmVdzc+AM4aAPelX+OHnVxMML4qrqoVX4QXmxrCWj/1znWccxdAy7bTzLyDwYbXgGgZdIRbtjQCbh5eK2p53y6Lje5XgDW/tZjYD626lR8+dK2KG7CyukYDY6POTMuOI4WgZ4MMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h5hSdjaj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S7tc6D021889;
	Mon, 28 Oct 2024 09:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=U5TgroXQ2lh++nho0nUy0Jx17cN0T
	JtBSrEwKRJ/I80=; b=h5hSdjajSueHP5bhePt4Pa23bPUoL5a9UQg9saC3oy0yr
	mneEvb9G7BnJXnzTN6vHzi7hP59xXmp5gfxs81JqyzdIeui1r0WuYRIhMfK7OPcm
	OCqpVIkvUwcxJfI26IWNC+9i9L0PAvfw2lT7matWnwO1bzW0q0MqCn04G8qEnhCC
	nRlBYZb2yEb7M1k2vtUFOXfsx4M8QBsjRnycNhdf7e9UIOgfhKxpb7LteyHo5Kka
	f4p3ICGKxzRgv5j4DZFQkmMwW3ySSsB3o7x7Yy8lnPJFiCyCzLBPtSuRcrwFwmNN
	K6HyRKYkq6DwU7bQD6uB7L7zyCrTCuIBYJjizPpug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwa9ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 09:15:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49S8odbF040239;
	Mon, 28 Oct 2024 09:15:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnam4w79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 09:15:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49S9Fk6m024856;
	Mon, 28 Oct 2024 09:15:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-187-49.vpn.oracle.com [10.175.187.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42hnam4w5a-1;
	Mon, 28 Oct 2024 09:15:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next] docs/bpf: Add description of .BTF.base section
Date: Mon, 28 Oct 2024 09:15:43 +0000
Message-ID: <20241028091543.2175967-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_01,2024-10-28_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280075
X-Proofpoint-ORIG-GUID: dIK54b_R2TWfvPSmBRVAPeIv_VxGUyoT
X-Proofpoint-GUID: dIK54b_R2TWfvPSmBRVAPeIv_VxGUyoT

Now that .BTF.base sections are generated for out-of-tree kernel
modules (provided pahole supports the "distilled_base" BTF feature),
document .BTF.base and its role in supporting resilient split BTF
and BTF relocation.

Changes since v1:

- updated formatting, corrected typo, used BTF ID[s] consistently
  (Andrii)

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/bpf/btf.rst | 77 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 93060283b6fd..2478cef758f8 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -835,7 +835,7 @@ section named by ``btf_ext_info_sec->sec_name_off``.
 See :ref:`Documentation/bpf/llvm_reloc.rst <btf-co-re-relocations>`
 for more information on CO-RE relocations.
 
-4.2 .BTF_ids section
+4.3 .BTF_ids section
 --------------------
 
 The .BTF_ids section encodes BTF ID values that are used within the kernel.
@@ -896,6 +896,81 @@ and is used as a filter when resolving the BTF ID value.
 All the BTF ID lists and sets are compiled in the .BTF_ids section and
 resolved during the linking phase of kernel build by ``resolve_btfids`` tool.
 
+4.4 .BTF.base section
+---------------------
+Split BTF - where the .BTF section only contains types not in the associated
+base .BTF section - is an extremely efficient way to encode type information
+for kernel modules, since they generally consist of a few module-specific
+types along with a large set of shared kernel types. The former are encoded
+in split BTF, while the latter are encoded in base BTF, resulting in more
+compact representations. A type in split BTF that refers to a type in
+base BTF refers to it using its base BTF ID, and split BTF IDs start
+at last_base_BTF_ID + 1.
+
+The downside of this approach however is that this makes the split BTF
+somewhat brittle - when the base BTF changes, base BTF ID references are
+no longer valid and the split BTF itself becomes useless. The role of the
+.BTF.base section is to make split BTF more resilient for cases where
+the base BTF may change, as is the case for kernel modules not built every
+time the kernel is for example. .BTF.base contains named base types; INTs,
+FLOATs, STRUCTs, UNIONs, ENUM[64]s and FWDs. INTs and FLOATs are fully
+described in .BTF.base sections, while composite types like structs
+and unions are not fully defined - the .BTF.base type simply serves as
+a description of the type the split BTF referred to, so structs/unions
+have 0 members in the .BTF.base section. ENUM[64]s are similarly recorded
+with 0 members. Any other types are added to the split BTF. This
+distillation process then leaves us with a .BTF.base section with
+such minimal descriptions of base types and .BTF split section which refers
+to those base types. Later, we can relocate the split BTF using both the
+information stored in the .BTF.base section and the new .BTF base; the type
+information in the .BTF.base section allows us to update the split BTF
+references to point at the corresponding new base BTF IDs.
+
+BTF relocation happens on kernel module load when a kernel module has a
+.BTF.base section, and libbpf also provides a btf__relocate() API to
+accomplish this.
+
+As an example consider the following base BTF::
+
+      [1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+      [2] STRUCT 'foo' size=8 vlen=2
+              'f1' type_id=1 bits_offset=0
+              'f2' type_id=1 bits_offset=32
+
+...and associated split BTF::
+
+      [3] PTR '(anon)' type_id=2
+
+i.e. split BTF describes a pointer to struct foo { int f1; int f2 };
+
+.BTF.base will consist of::
+
+      [1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+      [2] STRUCT 'foo' size=8 vlen=0
+
+If we relocate the split BTF later using the following new base BTF::
+
+      [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
+      [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+      [3] STRUCT 'foo' size=8 vlen=2
+              'f1' type_id=2 bits_offset=0
+              'f2' type_id=2 bits_offset=32
+
+...we can use our .BTF.base description to know that the split BTF reference
+is to struct foo, and relocation results in new split BTF::
+
+      [4] PTR '(anon)' type_id=3
+
+Note that we had to update BTF ID and start BTF ID for the split BTF.
+
+So we see how .BTF.base plays the role of facilitating later relocation,
+leading to more resilient split BTF.
+
+.BTF.base sections will be generated automatically for out-of-tree kernel module
+builds - i.e. where KBUILD_EXTMOD is set (as it would be for "make M=path/2/mod"
+cases). .BTF.base generation requires pahole support for the "distilled_base"
+BTF feature; this is available in pahole v1.28 and later.
+
 5. Using BTF
 ============
 
-- 
2.43.5


