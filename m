Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF9B125974
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 03:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfLSCEp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 18 Dec 2019 21:04:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36384 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfLSCEp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 21:04:45 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ1xn5i027073
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 18:04:43 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wypvwjxad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 18:04:43 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 18:04:42 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 3C9F3760FB5; Wed, 18 Dec 2019 18:04:42 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] selftests/bpf: Fix test_attach_probe
Date:   Wed, 18 Dec 2019 18:04:42 -0800
Message-ID: <20191219020442.1922617-1-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=846 malwarescore=0 suspectscore=1 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190014
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix two issues in test_attach_probe:
1. it was not able to parse /proc/self/maps beyond the first line,
   since %s means parse string until white space.
2. offset has to be accounted for otherwise uprobed address is incorrect.

Fixes: 1e8611bbdfc9 ("selftests/bpf: add kprobe/uprobe selftests")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 5ed90ede2f1d..a0ee87c8e1ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -3,7 +3,7 @@
 #include "test_attach_probe.skel.h"
 
 ssize_t get_base_addr() {
-	size_t start;
+	size_t start, offset;
 	char buf[256];
 	FILE *f;
 
@@ -11,10 +11,11 @@ ssize_t get_base_addr() {
 	if (!f)
 		return -errno;
 
-	while (fscanf(f, "%zx-%*x %s %*s\n", &start, buf) == 2) {
+	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
+		      &start, buf, &offset) == 3) {
 		if (strcmp(buf, "r-xp") == 0) {
 			fclose(f);
-			return start;
+			return start - offset;
 		}
 	}
 
-- 
2.23.0

