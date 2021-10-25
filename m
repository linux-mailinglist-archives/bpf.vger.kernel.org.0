Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15343A6A8
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhJYWgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 18:36:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42304 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234081AbhJYWgS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:36:18 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMGN53017421
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GmHJvVFnYPy8bDSSsfkhkG78X1TVj5lywJ8XWxYSoxA=;
 b=aiRVRmcIZAxWwaI5GUMXtnx4aUy6lbqwukAW63wO9C3tE8cxfOcbT74XAPJh1R0vZtr8
 9aeAEhuIzW8gwh5fpheN9XJGLXanqdUK2xtjgoshqJ97+ZYwsedDATkfZHS1TwPJ7shQ
 qo9pXNpvSGazee6xmtypR6sA/PNbyDOFnhg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4gn8dc3-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:55 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:33:52 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 468985DB8D42; Mon, 25 Oct 2021 15:33:46 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: adding a namespace reset for tc_redirect
Date:   Mon, 25 Oct 2021 15:33:45 -0700
Message-ID: <20211025223345.2136168-5-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025223345.2136168-1-fallentree@fb.com>
References: <20211025223345.2136168-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: kB11SCJ3F9LkEuIvdVj22kTAnNe2ynhK
X-Proofpoint-ORIG-GUID: kB11SCJ3F9LkEuIvdVj22kTAnNe2ynhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=924 phishscore=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110250127
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
index 53672634bc52..4b18b73df10b 100644
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
+		snprintf(cmd, sizeof(cmd), "ip netns %s %s > /dev/null 2>&1", verb, *n=
s);
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

