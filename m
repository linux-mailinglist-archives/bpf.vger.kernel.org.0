Return-Path: <bpf+bounces-32568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D806291001E
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B6C1C22583
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8419B3D7;
	Thu, 20 Jun 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SyIEEIkH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2B3D0AD
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875094; cv=none; b=XOv+N/+e/DsP3ye8bZ2Zd6QcDeMEwZuwIClXLWC1dIzR7ugr8mVnruwxSpyTdCAGb3q+8ECB63vjPBkVvl+7UeJLRaxnDAvXf5hg56TVm337RpgdDGOFOqcEpXx+K6mF/IPC5MyKTaqdVtzjmKz1AYogZRe695B9r47lmlbFlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875094; c=relaxed/simple;
	bh=BVVrDhTPsO95f7LFsYK9YHY3LYzOkuZ0cmkF1cekH7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1JcYahCBjWSm7UfR5exmt8nDidyCbVmsGXF1lABnQWyYiOO/fi+bHfcsLyh+tUr/PqGfd6NzuN9qbW/wgEapPXqH45JNHRN10dWpsMfXK0HIEjgJeP0LvAZUPoaTXd7eejHYkA1fPCeYg++tZOq64uJXbwk76Tf5l3j/0uZNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SyIEEIkH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FQl4004153;
	Thu, 20 Jun 2024 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=3ENVKEZ/sQneRO
	ifyTgUPAXs2/RJntA9ozRh7vpMJZg=; b=SyIEEIkHECHP4WvWGfZ5L/a4tWjPAr
	dPNEjseSunJmUbtqS4DCJUbd85aQ7BQLoqEXwAjmqRpaLj6+e1TvhwP2PnDzbtBu
	MXAotBT0hdOnMXnVXp7JC+LyzI3IBm9U765f0d1Ypj5o9qAyHPDjR6hJTkbYwbMU
	A7qIUims5Rh/E9rHgE2yvGMtGNf6/iqNL7mrDSG9t+/yGyPrkf2CgS+dNGgJ3NW6
	JNTCuIJ06zBWak6/yJ2jPTAxnEgV1qoxEAaYQvFQR/jy0LJSX5KAwcVYyZFQXcrL
	w3W9VqBf25eWgBnXPGF9+WYn86h7bw3KpyegM2nTz72GDR4XOJSsqv/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9nar44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:17:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45K7Yc2F031332;
	Thu, 20 Jun 2024 09:17:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1da767g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:17:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45K9HdGD028275;
	Thu, 20 Jun 2024 09:17:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-186-70.vpn.oracle.com [10.175.186.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1da764t-1;
	Thu, 20 Jun 2024 09:17:39 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 0/6] bpf: resilient split BTF followups
Date: Thu, 20 Jun 2024 10:17:27 +0100
Message-ID: <20240620091733.1967885-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=796 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200065
X-Proofpoint-GUID: tkjfsmDltygYuR4baUpraNZAMsABxxZk
X-Proofpoint-ORIG-GUID: tkjfsmDltygYuR4baUpraNZAMsABxxZk

Follow-up to resilient split BTF series [1],

- cleaning up libbpf relocation code (patch 1);
- adding 'struct module' support for base BTF data (patch 2);
- splitting out field iteration code into separate file (patch 3);
- sharing libbpf relocation code with the kernel (patch 4);
- adding a kbuild --btf_features flag to generate distilled base
  BTF in the module-specific case where KBUILD_EXTMOD is true
  (patch 5); and
- adding test coverage for module-based kfunc dtor (patch 6)

Generation of distilled base BTF for modules requires the pahole patch
at [2], but without it we just won't get distilled base BTF (and thus BTF
relocation on module load) for bpf_testmod.ko.

Changes since v1 [3]:

- fixed line lengths and made comparison an explicit == 0 (Andrii, patch 1)
- moved btf_iter.c changes to separate patch (Andrii, patch 3)
- grouped common targets in kernel/bpf/Makefile (Andrii, patch 4)
- updated bpf_testmod ctx alloc to use GFP_ATOMIC, and updated dtor
  selftest to use map-based dtor cleanup (Eduard, patch 6)

[1] https://lore.kernel.org/bpf/20240613095014.357981-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20240517102714.4072080-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/20240618162449.809994-1-alan.maguire@oracle.com/

Alan Maguire (6):
  libbpf: BTF relocation followup fixing naming, loop logic
  module, bpf: store BTF base pointer in struct module
  libbpf: split field iter code into its own file kernel
  libbpf,bpf: share BTF relocate-related code with kernel
  kbuild,bpf: add module-specific pahole flags for distilled base BTF
  selftests/bpf: add kfunc_call test for simple dtor in bpf_testmod

 include/linux/btf.h                           |  64 +++++++
 include/linux/module.h                        |   2 +
 kernel/bpf/Makefile                           |   8 +-
 kernel/bpf/btf.c                              | 176 ++++++++++++-----
 kernel/module/main.c                          |   5 +-
 scripts/Makefile.btf                          |   5 +
 scripts/Makefile.modfinal                     |   2 +-
 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/btf.c                           | 162 ----------------
 tools/lib/bpf/btf_iter.c                      | 177 ++++++++++++++++++
 tools/lib/bpf/btf_relocate.c                  |  95 ++++++----
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  46 +++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   9 +
 .../selftests/bpf/prog_tests/kfunc_call.c     |   1 +
 .../selftests/bpf/progs/kfunc_call_test.c     |  37 ++++
 15 files changed, 532 insertions(+), 259 deletions(-)
 create mode 100644 tools/lib/bpf/btf_iter.c

-- 
2.31.1


