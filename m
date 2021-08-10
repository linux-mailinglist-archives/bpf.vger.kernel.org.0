Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B13E8527
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 23:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhHJVVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 17:21:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54238 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234444AbhHJVVk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 17:21:40 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ALF2AF001977
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sRUOsAjeJ4RLSLKzj8c3CidKZXQUcjAOJz4b/q/sndE=;
 b=d7a6ij46EJ6AS7u6mZZtwTfX3ihlXd/Eks0XnUmabHOj45/1rZzqtXoYvmRtWdBVomWX
 SJvwMuB3sCpScGvUDKvOa2zDVHQuUKWzgUXWS+JwI4qkS1dbjLtYxQ3MFOYbA1rsoi5j
 vjop7n21mgSiDksHLQjKmU9ozDzC8jkodSk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3abyc88vkj-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:21:17 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 14:21:15 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 32AD31EB0E14; Tue, 10 Aug 2021 14:21:08 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, Yucong Sun <fallentree@fb.com>
Subject: [PATCH v3 bpf-next 4/4] selftests/bpf: also print test name in subtest status message
Date:   Tue, 10 Aug 2021 14:21:07 -0700
Message-ID: <20210810212107.2237868-5-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810212107.2237868-1-fallentree@fb.com>
References: <20210810212107.2237868-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 9DZjNg121McYKTpded6A3W81FKJf2X9a
X-Proofpoint-ORIG-GUID: 9DZjNg121McYKTpded6A3W81FKJf2X9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_08:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=877 suspectscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100141
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

Example: $sudo ./test_progs -a 'xdp*' 2>/dev/null | grep ":OK" | cut -d":=
" -f 1
| cut -d" " -f2- | paste -s -d,
xdp_adjust_tail/xdp_adjust_tail_shrink,xdp,xdp_devmap_attach/Verifier che=
ck of
DEVMAP programs,xdp_info,xdp_noinline,xdp_perf

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index af43e206a806..23e4ea51f9e7 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -182,8 +182,8 @@ void test__end_subtest()
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

