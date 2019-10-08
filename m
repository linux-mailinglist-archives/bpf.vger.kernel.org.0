Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39AFD03DF
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfJHXKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Oct 2019 19:10:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbfJHXKh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Oct 2019 19:10:37 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x98NASu3009292
        for <bpf@vger.kernel.org>; Tue, 8 Oct 2019 16:10:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=oIhq0y55owKbTb1aWo8CNJEaH59x0DKJW3ggGY6nmBs=;
 b=KRDl1k8XX/Q50yOD0Yb4HPTjVDQ6cEHMBzsoJru5Q2QxaSGb0jc++jcXb/MLLdIJ6JjA
 GfXuMcfFRUKeZNctok4Q1oUP7eOl4+ts6vCKsfaCIuDem0LVPmBK/sZT1KnFYiUcqESA
 bhP1KhwLjJxliGeOz80QHpFmldUyh3whwxw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vh1ukrnay-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2019 16:10:36 -0700
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 8 Oct 2019 16:10:17 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 098098618FA; Tue,  8 Oct 2019 16:10:17 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <john.fastabend@gmail.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 3/3] selftests/bpf: fix btf_dump padding test case
Date:   Tue, 8 Oct 2019 16:10:08 -0700
Message-ID: <20191008231009.2991130-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008231009.2991130-1-andriin@fb.com>
References: <20191008231009.2991130-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_09:2019-10-08,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=678 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=8 clxscore=1015 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Existing padding test case for btf_dump has a good test that was
supposed to test padding generation at the end of a struct, but its
expected output was specified incorrectly. Fix this.

Fixes: 2d2a3ad872f8 ("selftests/bpf: add btf_dump BTF-to-C conversion tests")
Reported-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../testing/selftests/bpf/progs/btf_dump_test_case_padding.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
index 3a62119c7498..35c512818a56 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
@@ -62,6 +62,10 @@ struct padded_a_lot {
  *	long: 64;
  *	long: 64;
  *	int b;
+ *	long: 32;
+ *	long: 64;
+ *	long: 64;
+ *	long: 64;
  *};
  *
  */
@@ -95,7 +99,6 @@ struct zone_padding {
 struct zone {
 	int a;
 	short b;
-	short: 16;
 	struct zone_padding __pad__;
 };
 
-- 
2.17.1

