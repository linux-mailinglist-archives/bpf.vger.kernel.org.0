Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40463EE5DA
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 06:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHQEsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 00:48:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234050AbhHQEsO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 00:48:14 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H4hEDO028504
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3dPZr7B/QJLQTtNbgnGT+zzJcwW07k6QOzPCJIIcQMI=;
 b=SIrXeiosqgji7C7UDDSxnse41NHMdkIcEqBWYvs5GcBWnQSjybm9eOIghLHgi/8Zy4nR
 GHRqvVnYkEucarha/s5fUNzHFlPb5I2RZfdr8zvCWcbC2TSmoWI6n/vDnmp1ziMhhIDK
 E6LFnbSqGWjkeTk/c2y6+XUUtgEtcdr7Rao= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3afrcbn5hq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:47:41 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 21:47:40 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id F228822A241C; Mon, 16 Aug 2021 21:47:36 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v5 bpf-next 3/4] selftests/bpf: also print test name in subtest status message
Date:   Mon, 16 Aug 2021 21:47:31 -0700
Message-ID: <20210817044732.3263066-4-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817044732.3263066-1-fallentree@fb.com>
References: <20210817044732.3263066-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: dKF9Fk2-U495VU1UGz5qaR2ILYz_rBVM
X-Proofpoint-ORIG-GUID: dKF9Fk2-U495VU1UGz5qaR2ILYz_rBVM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_01:2021-08-16,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=897
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch add test name in subtest status message line, making it possib=
le to
grep ':OK' in the output to generate a list of passed test+subtest names,=
 which
can be processed to generate argument list to be used with "-a", "-d" exa=
ct
string matching.

Example:

 #1/1 align/mov:OK
 ..
 #1/12 align/pointer variable subtraction:OK
 #1 align:OK

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index f0fbead40883..90539b15b744 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -150,8 +150,8 @@ void test__end_subtest()
=20
 	dump_test_log(test, sub_error_cnt);
=20
-	fprintf(env.stdout, "#%d/%d %s:%s\n",
-	       test->test_num, test->subtest_num, test->subtest_name,
+	fprintf(env.stdout, "#%d/%d %s/%s:%s\n",
+	       test->test_num, test->subtest_num, test->test_name, test->subtes=
t_name,
 	       sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
=20
 	if (sub_error_cnt)
--=20
2.30.2

