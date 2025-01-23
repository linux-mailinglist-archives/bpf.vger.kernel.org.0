Return-Path: <bpf+bounces-49564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D5A19FBC
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC22816DF21
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104920C028;
	Thu, 23 Jan 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="RcjACZoj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC820C01E;
	Thu, 23 Jan 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620441; cv=none; b=hCZW2/oq2UYzwBA2VoN8XqocFwoqgBrvBOiZNZWAmGKkW7ER7MU1atpgc9MYIlPUUE/i50ZCJJt5ScHrCnnRG68e8t5l4VkgWzJFGwDI1eRtV9YExFBlqKsLRYGkoyWA/DP3CaMA3uGVrLuZn7jKLWIT9HFELCfwOMV8aprD/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620441; c=relaxed/simple;
	bh=LWA9b0HzSGGckRdhyyX7c6LFQ5J4AogKHol5NS78NRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mevL+wE3yyQWjWpNh0ng6RE/MQSNB/ax+dY8V+XOgXK1+AIgLQI1fCgI9YuTIzE5gDlJiczpeptrZss2HEF8ck0WAHIYMn4jMvGfqfLylPatOUIbiHx5Fk6RJ+wWpglWOt1zfDz3qHKIIkM0sHErSn2pJB5cJf4DmE723oOEkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=RcjACZoj; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166260.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7kxc9003012;
	Thu, 23 Jan 2025 08:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=campusrelays; bh=lRBk38l5
	lurgliS/JzcMG7RVtPEg3j4DsycQL+ruVrs=; b=RcjACZojpfhXgXXyg5tW7f0f
	CSoP7assBnUEyID4QhmIMWa5p3Q16Z0QejZ8CyCrAWwg+8FDvGV6kAyZ4w4chVry
	FBbhYhmkch5fe2sRi8TrwTjBFKux95dFlQOCK33DgzV5Ki53aYFnlseCtCmWMmuU
	RsG6vXJdsjDfKj+oRg6TTQIH3gwragtBEyAMs5iTf3XeNKY1Uho5l538Dwq3EfJ9
	NulaAcPgTYrMcMYgnxKfAta+uYz3WJpBYnQVVqNPwsBF0wahDztc2bOz0/icJyb/
	rgVd/Xuzny8KozQDRzdhmdti/DJ/yfImWSe4uqrdQNKKW/0a6eUv9spL6HLjVA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44b862b4rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 08:20:00 +0000 (GMT)
Received: from m0166260.ppops.net (m0166260.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50N8Ju0Q005824;
	Thu, 23 Jan 2025 08:19:59 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 44b862b4r7-3;
	Thu, 23 Jan 2025 08:19:59 +0000 (GMT)
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
Subject: [PATCH bpf v2 2/2] samples/{bpf,hid}: fix broken vmlinux path for VMLINUX_BTF
Date: Thu, 23 Jan 2025 02:19:50 -0600
Message-ID: <20250123081950.173588-3-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250123081950.173588-1-jinghao7@illinois.edu>
References: <20250123081950.173588-1-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LHckYdI5Q3FYaQmJRL-d4tzZQPkJAFa1
X-Proofpoint-GUID: iflN5J_B61XkGykhVbYCaYDiDO7Msw9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=830 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501230063
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Commit 13b25489b6f8 ("kbuild: change working directory to external
module directory with M=") changed kbuild working directory of bpf and
hid samples to samples/{bpf,hid}, which broke the vmlinux path for
VMLINUX_BTF, as the Makefiles assume the current work directory to be
the kernel output directory and use a relative path (i.e., ./vmlinux):

  Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.

Correctly refer to the kernel output directory using $(objtree).

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
Tested-by: Ruowen Qin <ruqin@redhat.com>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 samples/bpf/Makefile | 2 +-
 samples/hid/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 96a05e70ace3..f5865fbbae62 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
 
 VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
 		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
-		     $(abspath ./vmlinux)
+		     $(abspath $(objtree)/vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
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


