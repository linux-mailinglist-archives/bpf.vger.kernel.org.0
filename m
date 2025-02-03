Return-Path: <bpf+bounces-50312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8EA25507
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 09:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78421883661
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0F1FDE29;
	Mon,  3 Feb 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="qNXa2KE8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03F1FC11E;
	Mon,  3 Feb 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572951; cv=none; b=RPQndjJ2zHjIXBEtSbMCwYLQZMeXJwExDV7KCZzHebflcQ0Apuv4RrZYxMbtm8ju7UPyTvn0WJtW22CT7iGyGwRGNPgoCMOL25Io12GowzfyFNxtPpp9yyUK5gq4retbF1lZbuL4lvhMQkJ+tRVe5lIgDWnhhmSBU31eiCHM12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572951; c=relaxed/simple;
	bh=DwCoLwcXNGTa0TfQ4FCFmhswt8LEVnJuWU5KHLcGtfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtXAAB9BVeKNduaRefxQVRNllQy+Q4g1+4PS1CTdszXVX6bbsP9PSR0olFA89+dtBAedvSOwpDcz+bm9hA7inaNrmFYFUHYUKqmXm8ZuC/Bn1iTVHykMas7QFgqlaK8IlBOM4TPmVVlzE8pR0jATy6Iqvk+UB2iAM06QWRqukMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=qNXa2KE8; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5134DPDw022317;
	Mon, 3 Feb 2025 08:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=campusrelays; bh=/QKn96iV
	LXUOLDfAuEjFOSwPTi0ktGJjTokNt8GuDHo=; b=qNXa2KE8/IDLXXYD766kBqtW
	Gj2LuDhm4qTddlOngh/mG9hJclBV2uLPm1TdTIwbG0hLlfDs+5/SYRV0OFF/d0Qa
	ooT2iAM2G3ND88lKbZytKvcbIltsl+cU4I6EFk5UjVJT7jDU/fmQK8dgL70uB/7I
	z5Dp+/RqjpNNc6ULrdiof8p04Ml09xs6Y9gp/m/fwPLEsBsUAqdccrfUKQ9s/1BE
	r5mquNMJUH60DZKfNhVUPKO1lSFJsWTzZsRDW6C/Hd6LAZObyOq6hWG9gy+n6Jdz
	kravZkPdyR/vY9GjJ9wdSmunA8cn9LzGwU+csKKv17qmhxVnWv9Vk55rVYeQyw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44jjep9xem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 08:55:11 +0000 (GMT)
Received: from m0272703.ppops.net (m0272703.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5138q1nQ024616;
	Mon, 3 Feb 2025 08:55:10 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 44jjep9xed-2;
	Mon, 03 Feb 2025 08:55:10 +0000 (GMT)
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
Subject: [PATCH v3 1/3] samples/hid: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
Date: Mon,  3 Feb 2025 02:55:04 -0600
Message-ID: <20250203085506.220297-2-jinghao7@illinois.edu>
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
X-Proofpoint-ORIG-GUID: tgXTfZ-fRZH_XRGNqPYsjKZr-08GAJGP
X-Proofpoint-GUID: ecVygsEaCsSlGXp6PT4nmELIfD12glzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030071
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from
libbpf EXTRA_CFLAGS") fixed the build error caused by redundant include
path for samples/bpf, but not samples/hid.

Apply the same fix on samples/hid as well.

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
Tested-by: Ruowen Qin <ruqin@redhat.com>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 samples/hid/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/samples/hid/Makefile b/samples/hid/Makefile
index 8ea59e9631a3..69159c81d045 100644
--- a/samples/hid/Makefile
+++ b/samples/hid/Makefile
@@ -40,16 +40,17 @@ BPF_EXTRA_CFLAGS += -I$(srctree)/arch/mips/include/asm/mach-generic
 endif
 endif
 
-TPROGS_CFLAGS += -Wall -O2
-TPROGS_CFLAGS += -Wmissing-prototypes
-TPROGS_CFLAGS += -Wstrict-prototypes
+COMMON_CFLAGS += -Wall -O2
+COMMON_CFLAGS += -Wmissing-prototypes
+COMMON_CFLAGS += -Wstrict-prototypes
 
+TPROGS_CFLAGS += $(COMMON_CFLAGS)
 TPROGS_CFLAGS += -I$(objtree)/usr/include
 TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
 TPROGS_CFLAGS += -I$(srctree)/tools/include
 
 ifdef SYSROOT
-TPROGS_CFLAGS += --sysroot=$(SYSROOT)
+COMMON_CFLAGS += --sysroot=$(SYSROOT)
 TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
 endif
 
@@ -112,7 +113,7 @@ clean:
 
 $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
 # Fix up variables inherited from Kbuild that tools/ build system won't like
-	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
+	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(COMMON_CFLAGS)" \
 		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(HID_SAMPLES_PATH)/../../ \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
 		$@ install_headers
-- 
2.48.1


