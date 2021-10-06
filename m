Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA637424651
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhJFS6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2408 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238494AbhJFS6W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196HJggO020184
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=oRNzDRv/XjiA5W0OSwlSRRHD8Nu1l0VNZq73Q9KMlA0=;
 b=HkkXL9Xpd/RBMHpiXOSHKLgkRWL7pER+LIHTnQtffkQg5FSoJmVPzdxlmAP0RP2tTIQx
 ts6vKDSUe+/+VPE2L5SdITuJOfvJ7NSYe9EfSs1MKUBZVHLI4cIOpKao2ASrYWDmsWZt
 excZYrGVIMpkoY1TELlhyEJLYSSOaJjOmws= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhg3n0u4c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:29 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:27 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 31B744BDB5B9; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 07/14] selftests/bpf: make cgroup_v1v2 use its own port
Date:   Wed, 6 Oct 2021 11:56:12 -0700
Message-ID: <20211006185619.364369-8-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: _xAtfJEvPo2pZq2bMYU1cJdsvFQYbK2U
X-Proofpoint-ORIG-GUID: _xAtfJEvPo2pZq2bMYU1cJdsvFQYbK2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=659 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch change cgroup_v1v2 use a different port, avoid conflict with
other tests.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c | 2 +-
 tools/testing/selftests/bpf/progs/connect4_dropper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools=
/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index ab3b9bc5e6d1..9026b42914d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -46,7 +46,7 @@ void test_cgroup_v1v2(void)
 {
 	struct network_helper_opts opts =3D {};
 	int server_fd, client_fd, cgroup_fd;
-	static const int port =3D 60123;
+	static const int port =3D 60120;
=20
 	/* Step 1: Check base connectivity works without any BPF. */
 	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
diff --git a/tools/testing/selftests/bpf/progs/connect4_dropper.c b/tools=
/testing/selftests/bpf/progs/connect4_dropper.c
index b565d997810a..d3f4c5e4fb69 100644
--- a/tools/testing/selftests/bpf/progs/connect4_dropper.c
+++ b/tools/testing/selftests/bpf/progs/connect4_dropper.c
@@ -18,7 +18,7 @@ int connect_v4_dropper(struct bpf_sock_addr *ctx)
 {
 	if (ctx->type !=3D SOCK_STREAM)
 		return VERDICT_PROCEED;
-	if (ctx->user_port =3D=3D bpf_htons(60123))
+	if (ctx->user_port =3D=3D bpf_htons(60120))
 		return VERDICT_REJECT;
 	return VERDICT_PROCEED;
 }
--=20
2.30.2

