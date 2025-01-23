Return-Path: <bpf+bounces-49566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14EA19FC0
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31978188E7D7
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C9220C48C;
	Thu, 23 Jan 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="e7I40A5p"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB720C46D;
	Thu, 23 Jan 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620445; cv=none; b=umZ+DlqhbDpOhxfJg4x3gV4HogZ2qseebfaITOPgl5IdmqLG1BbWvO7piQ4AfV2q49G4JmMV4TeJkzY+cclVn6/F7wRaN6wqA1IOBwmNhoFC3bh62TXjPygJiN5MOm5Xm0LinAztadSGYE2xUH3cmYf3Rfl+NdR0yIf3T4xQ3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620445; c=relaxed/simple;
	bh=DwCoLwcXNGTa0TfQ4FCFmhswt8LEVnJuWU5KHLcGtfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qt0YjaA1Xb+ckV2p0vJ+rCLbReBLPyNhjo5DmRAl5nrVh6OUYJnVfRlbLbagKFikkKOjpbRNLAPnzccH1APkRWSedFR9wS75RYn2Rd3qSCQ4qTRcZ1T3cnwSMbag6AqQYsPZl/rhMpzCCTHev2vmJV8dr1Dq37hvTaYoQIIts4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=e7I40A5p; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166260.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7kCiM001971;
	Thu, 23 Jan 2025 08:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=campusrelays; bh=/QKn96iV
	LXUOLDfAuEjFOSwPTi0ktGJjTokNt8GuDHo=; b=e7I40A5pEPv7mcB7ms3fY51u
	3SL0MgPWfjcHsRzur1u3voImag3ovjXmfy5AqDep4W0rN45E2W76743YF5Sd0i1x
	VDtOwWSb5uH7nwzv1F0dZ+mWO8YQTfv4UxZCdhN+dwfaijkceWNcw8ZS1JRC83iX
	UtMbrZmmAme4I0LtMSroTilYF+5Xnv2bLtkaIKb1gU4tTUyIlnrylNMKuYWAfo6S
	5zPYq9pD5EijR9tS2KmqsbMKZNXaqZUCmcIz0DiJ5SP1Ek0ZHUAwzGx1sgNnG5I7
	q5wccYUP/rL3qQFO7V0E/JaSjTmK2olCKUPdaErsV2jCFNbPRYwAa0GAQ5htTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44b862b4re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 08:19:58 +0000 (GMT)
Received: from m0166260.ppops.net (m0166260.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50N8Ju0O005824;
	Thu, 23 Jan 2025 08:19:58 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 44b862b4r7-2;
	Thu, 23 Jan 2025 08:19:58 +0000 (GMT)
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
Subject: [PATCH bpf v2 1/2] samples/hid: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
Date: Thu, 23 Jan 2025 02:19:49 -0600
Message-ID: <20250123081950.173588-2-jinghao7@illinois.edu>
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
X-Proofpoint-ORIG-GUID: A4cCvQHLVYXumjkXmXKaiAHMs_T4211_
X-Proofpoint-GUID: W-_2aBBR5-nWbn7WseZGAa07L8N7t1mk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1011
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501230063
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


