Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3089045B0B1
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhKXA1L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:27:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52590 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233523AbhKXA1K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:27:10 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf4o8010318
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:24:01 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch0wxcgv3-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:24:00 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:57 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 06FD8A666AE6; Tue, 23 Nov 2021 16:23:49 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 11/13] selftests/bpf: prevent out-of-bounds stack access in test_bpffs
Date:   Tue, 23 Nov 2021 16:23:23 -0800
Message-ID: <20211124002325.1737739-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: iNduWSeP0CMRKZtlhQctlJoiWDfIk8QQ
X-Proofpoint-ORIG-GUID: iNduWSeP0CMRKZtlhQctlJoiWDfIk8QQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=757
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Buf can be not zero-terminated leading to strstr() to access data beyond
the intended buf[] array. Fix by forcing zero termination.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/test_bpffs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index d29ebfeef9c5..e36782c8ec49 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -19,11 +19,13 @@ static int read_iter(char *file)
 	fd = open(file, 0);
 	if (fd < 0)
 		return -1;
-	while ((len = read(fd, buf, sizeof(buf))) > 0)
+	while ((len = read(fd, buf, sizeof(buf))) > 0) {
+		buf[sizeof(buf) - 1] = '\0';
 		if (strstr(buf, "iter")) {
 			close(fd);
 			return 0;
 		}
+	}
 	close(fd);
 	return -1;
 }
-- 
2.30.2

