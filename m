Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331E4424658
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhJFS6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57030 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232002AbhJFS6q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:46 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196HJggW020184
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=psoUZACw7YDrssMBJFkOLYrHyBeOiB9rtocyBLkJDto=;
 b=YmWqMlmjdtrisZjmtXyzTp2gKHN2mOTmsy5WjHfvxmUlf2ubFGO7o3mKGli5j1NR7ywP
 hkylJS3yPDvFLwLn8thhejguD4fEuBCtizFk4K1WEsE1ispEUUg7yjQ9S9kOcrl2vMIV
 KEqRBn34VVzx2zC/k4p1DFdlWuGxwE5u494= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhg3n0u83-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:53 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:27 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 36CEE4BDB5BB; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 08/14] selftests/bpf: adding a namespace reset for tc_redirect
Date:   Wed, 6 Oct 2021 11:56:13 -0700
Message-ID: <20211006185619.364369-9-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Qv4_tP7kWx-NcM0ImAF6OR8R54fIKAFF
X-Proofpoint-ORIG-GUID: Qv4_tP7kWx-NcM0ImAF6OR8R54fIKAFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=998 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch delete ns_src/ns_dst/ns_redir namespaces before recreating
them, making the test more robust.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/tc_redirect.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools=
/testing/selftests/bpf/prog_tests/tc_redirect.c
index e87bc4466d9a..25744136e131 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -176,6 +176,18 @@ static int netns_setup_namespaces(const char *verb)
 	return 0;
 }
=20
+static void netns_setup_namespaces_nofail(const char *verb)
+{
+	const char * const *ns =3D namespaces;
+	char cmd[128];
+
+	while (*ns) {
+		snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb, *ns);
+		system(cmd);
+		ns++;
+	}
+}
+
 struct netns_setup_result {
 	int ifindex_veth_src_fwd;
 	int ifindex_veth_dst_fwd;
@@ -762,6 +774,8 @@ static void test_tc_redirect_peer_l3(struct netns_set=
up_result *setup_result)
=20
 static void *test_tc_redirect_run_tests(void *arg)
 {
+	netns_setup_namespaces_nofail("delete");
+
 	RUN_TEST(tc_redirect_peer);
 	RUN_TEST(tc_redirect_peer_l3);
 	RUN_TEST(tc_redirect_neigh);
--=20
2.30.2

