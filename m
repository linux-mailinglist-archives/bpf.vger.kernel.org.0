Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0621A3E500C
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 01:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhHIXhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 19:37:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63322 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235336AbhHIXhY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 19:37:24 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179NSieR027754
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 16:37:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KQtqJ6p+pz0zS1MDx9XZ8kD6y2tuR26EUeYDXqyzj6A=;
 b=EWn1McU/4oKdcYQMbIw83UkcsgZJba+19zQMPkCFRhfOra26Dja40DTI6VU0pA3AFgdZ
 qiZLdWibe5993KqYa3E6PEE2xt4jxPhNVy+lwRGP4nm86NY/k7Nx9PiJq2KyyiHmLSc2
 fL1f5vk0TrVdZrrWy9LwHRh8Dpz9JihwUUI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ab7exahw6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 16:37:02 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 16:37:01 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id AACC01E27902; Mon,  9 Aug 2021 16:36:55 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next 4/5] Display test number when listing test names
Date:   Mon, 9 Aug 2021 16:36:32 -0700
Message-ID: <20210809233633.973638-4-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809233633.973638-1-fallentree@fb.com>
References: <20210809233633.973638-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: xyxXFdSpEHkzcSWD3lntWrCFjb4hH2dh
X-Proofpoint-ORIG-GUID: xyxXFdSpEHkzcSWD3lntWrCFjb4hH2dh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=720 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090165
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 tools/testing/selftests/bpf/test_progs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 82d012671552..5cc808992b00 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -867,7 +867,8 @@ int main(int argc, char **argv)
 		}
=20
 		if (env.list_test_names) {
-			fprintf(env.stdout, "%s\n", test->test_name);
+			fprintf(env.stdout, "# %d %s\n",
+				test->test_num, test->test_name);
 			env.succ_cnt++;
 			continue;
 		}
--=20
2.30.2

