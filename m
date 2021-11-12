Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4097844ED3F
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 20:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhKLT3U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 14:29:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11688 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhKLT3U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 14:29:20 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACIjFNd023049
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:26:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7TD35CBBrxBt0ONHPRciJj2id40BUzhUtfDucGsvGdQ=;
 b=VZRel+HNGW1pFOO61IEQbkwWBQLzShEJMu1kFNnS0R+xt9z4F9k/WLD/fS4hSGciSIB6
 ZAqDK7OKkgrWhWIwPo3Jev4XpyZwCbHo6ubwbx+AHGG1hOrvzdLhLJFPd0is5LOlXykW
 dUWMKQp/ukgecF2rAoshbLTBUzNkd8WDqF4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c98k59js2-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:26:29 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 11:25:49 -0800
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id BB7606C83835; Fri, 12 Nov 2021 11:25:39 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>,
        Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 1/4] selftests/bpf: Move summary line after the error logs
Date:   Fri, 12 Nov 2021 11:25:32 -0800
Message-ID: <20211112192535.898352-2-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112192535.898352-1-fallentree@fb.com>
References: <20211112192535.898352-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: _JuZp_1LlFCL0opSRRxx5krXks_akHdD
X-Proofpoint-GUID: _JuZp_1LlFCL0opSRRxx5krXks_akHdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

Makes it easier to find the summary line when there is a lot of logs to
scroll back.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index c65986bd9d07..d129ea5c9a48 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1198,11 +1198,11 @@ static int server_main(void)
 		env.sub_succ_cnt +=3D result->sub_succ_cnt;
 	}
=20
+	print_all_error_logs();
+
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
=20
-	print_all_error_logs();
-
 	/* reap all workers */
 	for (i =3D 0; i < env.workers; i++) {
 		int wstatus, pid;
@@ -1484,11 +1484,11 @@ int main(int argc, char **argv)
 	if (env.list_test_names)
 		goto out;
=20
+	print_all_error_logs();
+
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
=20
-	print_all_error_logs();
-
 	close(env.saved_netns_fd);
 out:
 	if (!env.list_test_names && env.has_testmod)
--=20
2.30.2

