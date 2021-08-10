Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29EF3E5051
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhHJAR5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:17:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18098 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231439AbhHJAR5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 20:17:57 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17A0D1pV012610
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 17:17:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=O8sHeNDWTZBptedNdbvKRS0XhkRECy7xRVDIHKw+9ZQ=;
 b=f76rD91bbelwXSVCY5AH+yZXYwRlCsg70V9+wK++4vcpfHCaz4HOyWDQufL7iT6wMPPk
 zcYYb9M0AaK61iAkozJsKEyPKrGEOCy3gYingCyeA08gVOgeeKUgTdig8+51dKcGaEx8
 rvdeZ5XeA/YULmQx15K1OKwnsk52qtRImUs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3abbsqry8g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:17:35 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 17:17:34 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 2FF4C1E2CB68; Mon,  9 Aug 2021 17:17:25 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v2 bpf-next 1/5] Skip loading bpf_testmod when using -l to list tests.
Date:   Mon, 9 Aug 2021 17:16:21 -0700
Message-ID: <20210810001625.1140255-2-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810001625.1140255-1-fallentree@fb.com>
References: <20210810001625.1140255-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: BCxzVSPK7QJMs8r26RDVnyfyTdrDorlM
X-Proofpoint-ORIG-GUID: BCxzVSPK7QJMs8r26RDVnyfyTdrDorlM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=833 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch remove bpf_testmod load test when using "-l", making output
cleaner.

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

