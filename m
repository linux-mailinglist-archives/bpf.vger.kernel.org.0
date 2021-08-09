Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F623E5009
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhHIXhX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 19:37:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45120 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235336AbhHIXhX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 19:37:23 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179NTZ6u028682
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 16:37:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5unEAbVYxJPSyyeMj7wVqZ24fEuumjpYtbdTKhzmnrY=;
 b=PAsadOPgSH1FYcWAz+nO2lcbTpHU3PG0uAlYPD1qj6nLQ8U1PMdV39gk50QrOYCsUsD/
 NRHib7fDMqnJCBbyvs4dxY52HJXYXVjarXiCiE0K1UwJqYBv9cllkwSySC+3B5Y0H7t9
 Bv1LkaJDo/V+6mRJvrddWFH8X6xZjs5CiNQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ab7exahw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 16:37:01 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 16:36:58 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 9F6EE1E278FC; Mon,  9 Aug 2021 16:36:55 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next 1/5] Skip loading bpf_testmod when using -l to list tests.
Date:   Mon, 9 Aug 2021 16:36:29 -0700
Message-ID: <20210809233633.973638-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: BY1MspTHDA53JtiKp_XGtHcWl_PUjcaH
X-Proofpoint-ORIG-GUID: BY1MspTHDA53JtiKp_XGtHcWl_PUjcaH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=894 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090165
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 6f103106a39b..74dde0af1592 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -754,10 +754,12 @@ int main(int argc, char **argv)
=20
 	save_netns();
 	stdio_hijack();
-	env.has_testmod =3D true;
-	if (load_bpf_testmod()) {
-		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will=
 be skipped.\n");
-		env.has_testmod =3D false;
+	if (!env.list_test_names) {
+		env.has_testmod =3D true;
+		if (load_bpf_testmod()) {
+			fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko wil=
l be skipped.\n");
+			env.has_testmod =3D false;
+		}
 	}
 	for (i =3D 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test =3D &prog_test_defs[i];
--=20
2.30.2

