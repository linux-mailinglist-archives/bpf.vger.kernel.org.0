Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E81853E5
	for <lists+bpf@lfdr.de>; Sat, 14 Mar 2020 02:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgCNBju (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 21:39:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51414 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgCNBju (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Mar 2020 21:39:50 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02E1U2eX002984
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 18:39:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=B09Z2hvcTTzvTWqy566fOYiTsbK8fw6QCZOOQsi+84I=;
 b=JDXyJbBlcE49hPmngmuWoNBrcm7z+SV6FowHkhYmK9axz8hTdDy32bM4YyoxiMaxtEBf
 uHBDCOPskfxkcw0kSFMxFGIdrGXzbhQKCQfTp8DsX6blMICkZ+gOEzm54D5VbvfiTmCT
 2v5gMVZCPKOykhDTynv2WC7iSs4d/Cu7a4k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqt96y9ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 18:39:48 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 18:39:47 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 344EA2EC2D6B; Fri, 13 Mar 2020 18:39:37 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/3] selftests/bpf: fix test_progs's parsing of test numbers
Date:   Fri, 13 Mar 2020 18:39:31 -0700
Message-ID: <20200314013932.4035712-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314013932.4035712-1-andriin@fb.com>
References: <20200314013932.4035712-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_12:2020-03-12,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=964 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=25 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When specifying disjoint set of tests, test_progs doesn't set skipped test's
array elements to false. This leads to spurious execution of tests that should
have been skipped. Fix it by explicitly initializing them to false.

Fixes: 3a516a0a3a7b ("selftests/bpf: add sub-tests support for test_progs")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index dc12fd0de1c2..c8cb407482c6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -424,7 +424,7 @@ static int parse_str_list(const char *s, struct str_set *set)
 
 int parse_num_list(const char *s, struct test_selector *sel)
 {
-	int i, set_len = 0, num, start = 0, end = -1;
+	int i, set_len = 0, new_len, num, start = 0, end = -1;
 	bool *set = NULL, *tmp, parsing_end = false;
 	char *next;
 
@@ -459,18 +459,19 @@ int parse_num_list(const char *s, struct test_selector *sel)
 			return -EINVAL;
 
 		if (end + 1 > set_len) {
-			set_len = end + 1;
-			tmp = realloc(set, set_len);
+			new_len = end + 1;
+			tmp = realloc(set, new_len);
 			if (!tmp) {
 				free(set);
 				return -ENOMEM;
 			}
+			for (i = set_len; i < start; i++)
+				tmp[i] = false;
 			set = tmp;
+			set_len = new_len;
 		}
-		for (i = start; i <= end; i++) {
+		for (i = start; i <= end; i++)
 			set[i] = true;
-		}
-
 	}
 
 	if (!set)
-- 
2.17.1

