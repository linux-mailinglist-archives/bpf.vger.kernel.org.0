Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A12D8674
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 05:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbfJPD36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 23:29:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32176 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389352AbfJPD35 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Oct 2019 23:29:57 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G3QSTC020060
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 20:29:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=G9pkX0Le7EtlmNs7HIJJjBYvxhTS/DlmBVtgrQigqKQ=;
 b=FBjZaadX2WGfdr/bnx3gxvt257nToOlT7GxV5jc7aF1s+ahhGwSgVaswMGD3r6HlWMkH
 02WuVadxwRbnJek6vOh9I6utb62HJuQsalrWwttFINo8pV/Zn1oDs+fVpLT2NMHesbtK
 a1nl/kYIH/hDDSq1PWua1aAsg0JiQMs5ELE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnkjd20w4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 20:29:57 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 15 Oct 2019 20:29:56 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 12C37861998; Tue, 15 Oct 2019 20:29:56 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 2/6] selftests/bpf: make CO-RE reloc test impartial to test_progs flavor
Date:   Tue, 15 Oct 2019 20:29:45 -0700
Message-ID: <20191016032949.1445888-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016032949.1445888-1-andriin@fb.com>
References: <20191016032949.1445888-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_01:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=8 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910160029
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_core_reloc_kernel test captures its own process name and validates
it as part of the test. Given extra "flavors" of test_progs, this break
for anything by default test_progs binary. Fix the test to cut out
flavor part of the process name.

Fixes: ee2eb063d330 ("selftests/bpf: Add BPF_CORE_READ and BPF_CORE_READ_STR_INTO macro tests")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c        | 4 ++--
 tools/testing/selftests/bpf/progs/core_reloc_types.h       | 2 +-
 tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 7e2f5b4bf7f3..2b3586dc6c86 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -211,8 +211,8 @@ static struct core_reloc_test_case test_cases[] = {
 		.input_len = 0,
 		.output = STRUCT_TO_CHAR_PTR(core_reloc_kernel_output) {
 			.valid = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, },
-			.comm = "test_progs\0\0\0\0\0",
-			.comm_len = 11,
+			.comm = "test_progs",
+			.comm_len = sizeof("test_progs"),
 		},
 		.output_len = sizeof(struct core_reloc_kernel_output),
 	},
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index ad763ec0ba8f..f5939d9d5c61 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -6,7 +6,7 @@
 
 struct core_reloc_kernel_output {
 	int valid[10];
-	char comm[16];
+	char comm[sizeof("test_progs")];
 	int comm_len;
 };
 
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
index 50f609618b65..a4b5e0562ed5 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
@@ -15,7 +15,8 @@ static volatile struct data {
 
 struct core_reloc_kernel_output {
 	int valid[10];
-	char comm[16];
+	/* we have test_progs[-flavor], so cut flavor part */
+	char comm[sizeof("test_progs")];
 	int comm_len;
 };
 
-- 
2.17.1

