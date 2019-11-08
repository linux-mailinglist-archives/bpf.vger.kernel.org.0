Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66907F408B
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 07:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfKHGk4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Nov 2019 01:40:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57524 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729941AbfKHGk4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Nov 2019 01:40:56 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA86YaUR028618
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 22:40:55 -0800
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41u2sn01-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 22:40:55 -0800
Received: from 2401:db00:2120:81dc:face:0:23:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 7 Nov 2019 22:40:54 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id AEB05760F61; Thu,  7 Nov 2019 22:40:53 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 07/18] bpf: Add kernel test functions for fentry testing
Date:   Thu, 7 Nov 2019 22:40:28 -0800
Message-ID: <20191108064039.2041889-8-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108064039.2041889-1-ast@kernel.org>
References: <20191108064039.2041889-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_01:2019-11-07,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=1 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080064
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add few kernel functions with various number of arguments,
their types and sizes for BPF trampoline testing to cover
different calling conventions.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
---
 net/bpf/test_run.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0be4497cb832..62933279fbba 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -105,6 +105,40 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 	return err;
 }
 
+/* Integer types of various sizes and pointer combinations cover variety of
+ * architecture dependent calling conventions. 7+ can be supported in the
+ * future.
+ */
+int noinline bpf_fentry_test1(int a)
+{
+	return a + 1;
+}
+
+int noinline bpf_fentry_test2(int a, u64 b)
+{
+	return a + b;
+}
+
+int noinline bpf_fentry_test3(char a, int b, u64 c)
+{
+	return a + b + c;
+}
+
+int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
+{
+	return (long)a + b + c + d;
+}
+
+int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
+{
+	return a + (long)b + c + d + e;
+}
+
+int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
+{
+	return a + (long)b + c + d + (long)e + f;
+}
+
 static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
 			   u32 headroom, u32 tailroom)
 {
@@ -122,6 +156,13 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
 		kfree(data);
 		return ERR_PTR(-EFAULT);
 	}
+	if (bpf_fentry_test1(1) != 2 ||
+	    bpf_fentry_test2(2, 3) != 5 ||
+	    bpf_fentry_test3(4, 5, 6) != 15 ||
+	    bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
+	    bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
+	    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111)
+		return ERR_PTR(-EFAULT);
 	return data;
 }
 
-- 
2.23.0

