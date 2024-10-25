Return-Path: <bpf+bounces-43167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDB9B0882
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884832846C3
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064ED15D5CF;
	Fri, 25 Oct 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZINpzi9R"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B015B992
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870759; cv=none; b=Vi4Re/9JHwGoVXZoAyIRTmGwcrAmjxm2MIUGVZIzdjJElfrOOvXD3Bpbl80afLqLLpWRpBGLb4SWuKwNkK3eVlxL44gYp2T6v3Te+GET9Q42g+ihIZeLPophSRxzSOaz1uG2AoyKV3/eaQzqf6BAJv79Bbw3MzBsPuXtgq8WuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870759; c=relaxed/simple;
	bh=C4gV4q6piKd+jg3krYRRddL5ViN/tyh+9u6bqSltgjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJChBCO+zrQIfSjSpuGWnGdexjg5WrsyfAnctohqaPtnt9IoATSeCY+bzbBnhZM94keLisYwsouGxpcSwz5Iwz3x8WltuRTYht+vkfegRQ74FQ6n81C63L6jwMmo+Fc9vWjhzlFLY/zUG4Lq2qngbHQMg47O9R2UlI7Zri1brJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZINpzi9R; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PEtZZC026139;
	Fri, 25 Oct 2024 15:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=ujBtez9l8oSLCJJrzk4Pbf8SbjTmg
	D6ph6gKOHUif3M=; b=ZINpzi9Rbp9WmW1de6C8fkreA69WxxL2120kg7AKoc02Z
	0vtEhfb2ndBcb2mDNq6NuXzjeZKXSn1zviDoFx1w8XgvPc6OE1yiYmlXrmtjJr0c
	slXEx1/qwZ34AUIuM1AxjERJdwV/hbdCh33Du07ak7UXJ7qyA00H00iMV+lAeD1l
	WXEBgAfFQBx1+ohmd0M7mFTbLhVu6GqAFQKwl0iIeKefgzrwdL2ZEjEt1L1yz4XB
	tIqN27bwiMqex2CQrpL3uNKQPfyaZZgzTXuHCL0p3ZHE1SyPfpmgTfzM21Vdp/sB
	HP96HC7Foex6Hbj75WJrF5UmuaFAWxE0lM8K8XQDA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545dc1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 15:38:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PEFuJ3036739;
	Fri, 25 Oct 2024 15:38:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh5f9b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 15:38:54 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PFcsTi005701;
	Fri, 25 Oct 2024 15:38:54 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-208-77.vpn.oracle.com [10.175.208.77])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42emh5f9a2-1;
	Fri, 25 Oct 2024 15:38:54 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] docs/bpf: Add description of .BTF.base section
Date: Fri, 25 Oct 2024 16:38:50 +0100
Message-ID: <20241025153850.1791761-1-alan.maguire@oracle.com>
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
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250122
X-Proofpoint-ORIG-GUID: thFDa6Z8ngwTXr_wsoMYbc7yDQ921wwk
X-Proofpoint-GUID: thFDa6Z8ngwTXr_wsoMYbc7yDQ921wwk

Now that .BTF.base sections are generated for out-of-tree kernel
modules (provided pahole supports the "distilled_base" BTF feature),
document .BTF.base and its role in supporting resilient split BTF
and BTF relocation.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/bpf/btf.rst | 78 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 93060283b6fd..57992a9aa4f6 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -835,7 +835,7 @@ section named by ``btf_ext_info_sec->sec_name_off``.
 See :ref:`Documentation/bpf/llvm_reloc.rst <btf-co-re-relocations>`
 for more information on CO-RE relocations.
 
-4.2 .BTF_ids section
+4.3 .BTF_ids section
 --------------------
 
 The .BTF_ids section encodes BTF ID values that are used within the kernel.
@@ -896,6 +896,82 @@ and is used as a filter when resolving the BTF ID value.
 All the BTF ID lists and sets are compiled in the .BTF_ids section and
 resolved during the linking phase of kernel build by ``resolve_btfids`` tool.
 
+4.4 .BTF.base section
+---------------------
+Split BTF - where the .BTF section only contains types not in the associated
+base .BTF section - is an extremely efficient way to encode type information
+for kernel modules, since they generally consist of a few module-specific
+types along with a large set of shared kernel types.  The former are encoded
+in split BTF, while the latter are encoded in base BTF, resulting in more
+compact representations.  A type in split BTF that referes to a type in
+base BTF refers to it using its base type id, and split BTF type ids start
+at last_base_type + 1.
+
+The downside of this approach however is that this makes the split BTF
+somewhat brittle - when the base BTF changes, these base id references are
+no longer valid and the split BTF itself becomes useless.  The role of the
+.BTF.base section is to make split BTF more resilient for cases where
+the base BTF may change, as is the case for kernel modules not built every
+time the kernel is for example.  .BTF.base contains named base types; INTs,
+FLOATs, STRUCTs, UNIONs, ENUM[64]s and FWDs.  INTs and FLOATs are fully
+described in .BTF.base sections, while composite types like structs
+and unions are not fully defined - the .BTF.base type simply serves as
+a description of the type the split BTF referred to, so struct/unions
+has 0 members in the .BTF.base section.  ENUM[64]s are similarly recorded
+with 0 members.  Any other types are added to the split BTF.  This
+distillation process then leaves us with a .BTF.base section with
+such minimal descriptions of base types and .BTF split section which refers
+to those base types.  Later, we can relocate the split BTF using both the
+information stored in the .BTF.base section and the new BTF base; the type
+information in the .BTF.base section allows us to update the split BTF
+references to point at the corresponding new base BTF types.
+
+BTF relocation happens on kernel module load when a kernel module has a
+.BTF.base section, and libbpf also provides a btf__relocate() API to
+accomplish this.
+
+As an example consider the following base BTF:
+
+[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+[2] STRUCT 'foo' size=8 vlen=2
+        'f1' type_id=1 bits_offset=0
+        'f2' type_id=2 bits_offset=32
+
+...and associated split BTF:
+
+[3] PTR '(anon)' type_id=2
+
+i.e. split BTF describes a pointer to struct foo { int f1; int f2 };
+
+.BTF.base will consist of
+
+[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+[2] STRUCT 'foo' size=8 vlen=0
+
+..so if we relocate the split BTF later using the following new base
+BTF:
+
+[1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
+[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+[3] STRUCT 'foo' size=8 vlen=2
+        'f1' type_id=2 bits_offset=0
+        'f2' type_id=2 bits_offset=32
+
+...we can use our .BTF.base description to know that the split BTF reference
+is to struct foo, and relocation results in:
+
+[4] PTR '(anon)' type_id=3
+
+Note that we had to update type id and start BTF id for the split BTF.
+
+So we see how .BTF.base plays the role of facilitating later relocation,
+leading to more resilient split BTF.
+
+.BTF.base sections will be generated automatically for out-of-tree kernel module
+builds - i.e. where KBUILD_EXTMOD is set (as it would be for "make M=path/2/mod"
+cases).  .BTF.base generation requires pahole support for the "distilled_base"
+BTF feature; this is available in pahole v1.28 and later.
+
 5. Using BTF
 ============
 
-- 
2.43.5


