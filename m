Return-Path: <bpf+bounces-49279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA9A16584
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 03:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430777A35AD
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4B47A73;
	Mon, 20 Jan 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="rJ89JvPG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9A18027;
	Mon, 20 Jan 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737341209; cv=none; b=fn2sWRzhau9DGLpaFLBC7ocyC0d3geJtP8qT9u1anMqf547pa9w8buslpEw5CkP6u2UjIzPDZCDcUjZd4ke4CjcClYwUVUaVFjyGuB84tfMJw0ggiBGBOnhWDn7+vOm5raHfWqjfYtL8Gv6gqf7nxf6RJiBZ0Kb9nlDGAon7J7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737341209; c=relaxed/simple;
	bh=Y93DmH27ogYacl6SEa13n6o4Spm4UDRrRis20EXqzS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXXFLWYxCyQGAZmIZYTZVDC25mxY6E4f5QT65cd9f1pJ2r7oS75FHzN93UCEIEfZV6mGHUYwS4SC13PQhlsyb+aqKSzRtQwzDYDhiErLz1vZce1RxXutjk6sdCDgqG+TxLG00w7E7UAx3QMLswBfZBZfSmfI5UViYGB/f4iJ+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=rJ89JvPG; arc=none smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272704.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K0K7nk027244;
	Mon, 20 Jan 2025 02:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=campusrelays; bh=bcWHCzTUpxMbbi7sysREuVmXXPlZ0ad0
	akXDucSqgOo=; b=rJ89JvPGwzUnyQmTGUeMYLVXawF87W4NTUnH2KAgDO8vVApi
	mIzW6zAE0kFviJKjHooHHXWseEsGfNR1PFH2SPRGd+mrEsA5jZIjIDh6k6fRtRnS
	XEfj52l6jigykManEbIK/lgIcXccyYRYPgLTQusLADp+XmmCs5+3nMGerUJ+Hlh5
	+zIxpZxAyMq1QPYL/UWHggeA0j7qx74ihqch7bqn218/U9QNf8LY6MVLTSgDNM7Z
	v9khcZtcmilqibTlCdoT6uy4/47kwtPPc7tPING6H7EVDDeuhgipSxQpl8xMzDrq
	X9HbLGGCgMkb8VLj5sFO2w0wYdM0sKI4ekf8Uw==
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 449bup0e2w-1;
	Mon, 20 Jan 2025 02:30:28 +0000 (GMT)
From: Jinghao Jia <jinghao7@illinois.edu>
To: Ruowen Qin <ruqin@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
Date: Sun, 19 Jan 2025 20:30:27 -0600
Message-ID: <20250120023027.160448-1-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X0njzFrPqv7lOrJyKsho8Ozdtze2a-Xw
X-Proofpoint-ORIG-GUID: X0njzFrPqv7lOrJyKsho8Ozdtze2a-Xw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-16_01,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=657
 suspectscore=0 clxscore=1011 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501200018
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Commit 13b25489b6f8 ("kbuild: change working directory to external
module directory with M=") changed kbuild working directory of bpf
samples to $(srctree)/samples/bpf, which broke the vmlinux path for
VMLINUX_BTF, as the Makefile assumes the current work directory to be
$(srctree):

  Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.

Correctly refer to the kernel source directory using $(srctree).

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
Tested-by: Ruowen Qin <ruqin@redhat.com>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 96a05e70ace3..f97295724a14 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
 
 VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
 		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
-		     $(abspath ./vmlinux)
+		     $(abspath $(srctree)/vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
-- 
2.48.1


