Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB62944ED48
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 20:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhKLTcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 14:32:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40098 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229892AbhKLTcT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 14:32:19 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ACJTHBl027399
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:29:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=86kIcNsvaqDvX2Hx0i789sntqyT+gLkR7h955WY3cvU=;
 b=nPILvdLCznt1IkTi2knQDdO/5diUoA/iM8mscx76DTWhtTgWid/hMe9BOAIE4Phd/Mpm
 PHx2pUY3AMhNXNB7mEoXzdzZlL56HrWJhIBCxrS6xG36lJGOlfUXCwvo+at5xoF8u5wd
 F4AoY65APMbQnqfGxbub2GkAU2AlmjxeDhQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c9ukssf83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:29:27 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 11:25:48 -0800
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id C68C66C83839; Fri, 12 Nov 2021 11:25:39 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>,
        Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: mark variable as static
Date:   Fri, 12 Nov 2021 11:25:34 -0800
Message-ID: <20211112192535.898352-4-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112192535.898352-1-fallentree@fb.com>
References: <20211112192535.898352-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: bqBg83amcP9IGO2ChimVwMOA-O6VDueI
X-Proofpoint-GUID: bqBg83amcP9IGO2ChimVwMOA-O6VDueI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=844
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

Fix warnings from checkstyle.pl

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 926475aa10bb..296928948bb9 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -473,11 +473,11 @@ static struct prog_test_def prog_test_defs[] =3D {
 #include <prog_tests/tests.h>
 #undef DEFINE_TEST
 };
-const int prog_test_cnt =3D ARRAY_SIZE(prog_test_defs);
+static const int prog_test_cnt =3D ARRAY_SIZE(prog_test_defs);
=20
 const char *argp_program_version =3D "test_progs 0.1";
 const char *argp_program_bug_address =3D "<bpf@vger.kernel.org>";
-const char argp_program_doc[] =3D "BPF selftests test runner";
+static const char argp_program_doc[] =3D "BPF selftests test runner";
=20
 enum ARG_KEYS {
 	ARG_TEST_NUM =3D 'n',
--=20
2.30.2

