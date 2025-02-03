Return-Path: <bpf+bounces-50314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB35A2550E
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 09:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7DC7A4986
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9720767A;
	Mon,  3 Feb 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="YKceePOp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771F2063D0;
	Mon,  3 Feb 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572954; cv=none; b=jG/9nAWL9kaSo87WuiPMWlO43qyM4K9nYs1wX4GbOIPt7vvaC96s9IuP6Kmt6ln7cxvE5fcDp8poeNNW73fTUQrHf7nesR4l/ktj7TbGpEoRT3L48Aub1WzpLME4PvckJFbNvw8B/y4i++FoXDd/rUoW+9aDAVf3GfNJGFFbaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572954; c=relaxed/simple;
	bh=ZKHIR6wnVvJMF1XgF9zruT066nKXFM3lisQyFGX6mOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2iCOmZORnjlxHNuGhQ3hYIvqIIP/jas2obkVL1j9lt9YQKAxjAVe1gkAlPzPGGCDFrx0On3p5XVnU9j5PtKUSDe8/jIgNT+YMuJSXn8M/fAzNsd1xciopyz5M2s5qyh4ANYx+EsEjwy9YCX72k9gLD8qc9HqcJuGyEw9oVnflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=YKceePOp; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137Nkfu001149;
	Mon, 3 Feb 2025 08:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=campusrelays; bh=xwved6j1
	Vt8e4dOW6wJuBUwbHU2XqUSDmxms8fZezwg=; b=YKceePOpo2CPne72M7EWQ6mN
	246TFojjU46Ux+IEDK78qpcgOn9cGGJ6FFPP+dURjrJFuy8R+rNXKiegHnTbzJrF
	wUdV/+Aa5iq/xpqBG3MCQXOW64P23lSGiqTzNdYKDCRi9gnpryX8Ch9ERcGdJo0y
	wVyHiM4+M5uEru3PAioGEe1v2/0sZk4Vu37lQYil7ZmTIRErW3ioxMjcJ1dt5LJv
	sXQoZb0Nfe2VZw9p2C9c57tJEc9NFJws8NiVis9cnaEGGAMOelWPO4v3+Gyt0BPk
	B0VA5ORs/oSX9OqQIZzW7jSsjKMFt5gyOv8T4oZsTSKynju8fydUWOFpLzXQvw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44jjep9xep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 08:55:12 +0000 (GMT)
Received: from m0272703.ppops.net (m0272703.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5138q1nS024616;
	Mon, 3 Feb 2025 08:55:12 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 44jjep9xed-3;
	Mon, 03 Feb 2025 08:55:12 +0000 (GMT)
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
Subject: [PATCH v3 2/3] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
Date: Mon,  3 Feb 2025 02:55:05 -0600
Message-ID: <20250203085506.220297-3-jinghao7@illinois.edu>
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
X-Proofpoint-ORIG-GUID: utht8fX9U7PwpEQZV63AUlwJrZg3C2-I
X-Proofpoint-GUID: WmLRWqbcIJhW6UCjyXSOmOiOV-Ol0VDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=810 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030071
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Commit 13b25489b6f8 ("kbuild: change working directory to external
module directory with M=") changed kbuild working directory of bpf
sample programs to samples/bpf, which broke the vmlinux path for
VMLINUX_BTF, as the Makefiles assume the current work directory to be
the kernel output directory and use a relative path (i.e., ./vmlinux):

  Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.

Correctly refer to the kernel output directory using $(objtree).

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
Tested-by: Ruowen Qin <ruqin@redhat.com>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index dd9944a97b7e..5b632635e00d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
 
 VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
 		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
-		     $(abspath ./vmlinux)
+		     $(abspath $(objtree)/vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
-- 
2.48.1


