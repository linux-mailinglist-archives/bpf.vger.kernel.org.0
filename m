Return-Path: <bpf+bounces-50313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B4A2550A
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 09:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1227318818F1
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F198206F01;
	Mon,  3 Feb 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="Zd2H/+Um"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731E202C40;
	Mon,  3 Feb 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572954; cv=none; b=SHML77EHtvOHUpn79lVGnkxi0FUCZIJd8fmaueuo43TW7t1cEyc5vnBT3SqtRe2qIaY9QYMI11eLCMHh1HEKnudzroucT3XQOyyUVyAtp0h5EtWeymPR1CN0d5ytu2ygKhXrrHr8K9w0jEyrL66hiCWawrmnYGUj8gPABPWlHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572954; c=relaxed/simple;
	bh=1YTO9INez+CnwjPY9kI4ZOAcWBmKf/Llmb8zbEm1NCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCjkLnxfwJkYLINsvCr8lgfPJm6mIpnYlxCeq4dr8O1CMA1vQ/J9sAZFssBmwkac+TTDLGCfd5aXHW5nCcAyyhH1Bx+VsI6CnFfAsY37E5qH0Gu1Vzzq9UzGov3EDcUwwEKk4o1NxsNKkdm4oXbk/310hDz19Eqdc3BzZBlpOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=Zd2H/+Um; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135Lxn0004344;
	Mon, 3 Feb 2025 08:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=campusrelays; bh=RCfMUHG2
	VmNAH/8CCuKfGREBh8Aoub4r2DhMd+5tnUw=; b=Zd2H/+UmzcjVU2FJnFAWQciM
	rptV47Fj48QoHSPd0Afw+zR39O2mrobwfbRwpyqm+vBw5Tso1kczntTVEnwXErsz
	eI3p2tLqnY8MssqxM08uqqBYlvnXvcsa95Ki6uUD9AYUmwE15dqz4tJFv5zzP0Rv
	ZQ8q7HybQ+Sa/f5r5E6SPwkmXUcEtCKo7dJVMoAHwCiyiN3qIu0UyYJae/hZ+Mwa
	E+ArBP7VDFpCMPjWjV+SYR2l0N9qjGUMCvoivwo/xhRjlaJME19h5L7EOnpDECrb
	K+XPMPHCkDH6df7bszzl0oAC66nuZJGKLK7hgwcYlPs/FAi8GTtj9yEoqAMaOQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44jjep9xet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 08:55:13 +0000 (GMT)
Received: from m0272703.ppops.net (m0272703.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5138q1nU024616;
	Mon, 3 Feb 2025 08:55:13 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 44jjep9xed-4;
	Mon, 03 Feb 2025 08:55:13 +0000 (GMT)
From: Jinghao Jia <jinghao7@illinois.edu>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>, Ruowen Qin <ruqin@redhat.com>,
        Jinghao Jia <jinghao7@illinois.edu>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v3 3/3] samples/hid: fix broken vmlinux path for VMLINUX_BTF
Date: Mon,  3 Feb 2025 02:55:06 -0600
Message-ID: <20250203085506.220297-4-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250203085506.220297-1-jinghao7@illinois.edu>
References: <20250203085506.220297-1-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OdQjC_8YDZj7se2XaZ61oCTyjWVSYnGU
X-Proofpoint-GUID: c5o_IbYaaHI99HPpe15OxgXV0rmloE1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=887 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030071
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Commit 13b25489b6f8 ("kbuild: change working directory to external
module directory with M=") changed kbuild working directory of hid-bpf
sample programs to samples/hid, which broke the vmlinux path for
VMLINUX_BTF, as the Makefiles assume the current work directory to be
the kernel output directory and use a relative path (i.e., ./vmlinux):

  Makefile:173: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/hid/vmlinux", build the kernel or set VMLINUX_BTF or VMLINUX_H variable.  Stop.

Correctly refer to the kernel output directory using $(objtree).

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
Tested-by: Ruowen Qin <ruqin@redhat.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 samples/hid/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hid/Makefile b/samples/hid/Makefile
index 69159c81d045..db5a077c77fc 100644
--- a/samples/hid/Makefile
+++ b/samples/hid/Makefile
@@ -164,7 +164,7 @@ $(obj)/hid_surface_dial.o: $(obj)/hid_surface_dial.skel.h
 
 VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
 		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
-		     $(abspath ./vmlinux)
+		     $(abspath $(objtree)/vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
-- 
2.48.1


