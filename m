Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4963E8523
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhHJVVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 17:21:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233887AbhHJVVg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 17:21:36 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ALEntK020570
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:21:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=X25EmMsLaxrrMKX2J/YfHD0JlldnW2DjxkU8mC66Yu4=;
 b=orYI6TJ0Zbuicbye1TaUx/GndTV/obtbg1bliixYNIhyOggGTxfED8GYsTaRmRXH+jjd
 J2G29KbwH5p/B59Of8iiNs4QXdOd4lR2FfOCtMkSSh0pg+MPGagTCCa0BlrJke2k6TrX
 UD3g4FLQjJlumMPiN/TeS3bEZLn1jMS/ImA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aby7k90jw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:21:13 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 14:21:13 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 228A11EB0E0E; Tue, 10 Aug 2021 14:21:08 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, Yucong Sun <fallentree@fb.com>
Subject: [PATCH v3 bpf-next 1/4] selftests/bpf: skip loading bpf_testmod when using -l to list tests.
Date:   Tue, 10 Aug 2021 14:21:04 -0700
Message-ID: <20210810212107.2237868-2-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810212107.2237868-1-fallentree@fb.com>
References: <20210810212107.2237868-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: xzZhkO6g8Wtz7Ib_fKAsj9ETIeLHyyaQ
X-Proofpoint-ORIG-GUID: xzZhkO6g8Wtz7Ib_fKAsj9ETIeLHyyaQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_08:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=850 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using "-l", test_progs often is executed as non-root user,
load_bpf_testmod() will fail and output errors. This patch skip loading b=
pf
testmod when "-l" is specified, making output cleaner.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 6f103106a39b..532af3353edf 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -755,7 +755,7 @@ int main(int argc, char **argv)
 	save_netns();
 	stdio_hijack();
 	env.has_testmod =3D true;
-	if (load_bpf_testmod()) {
+	if (!env.list_test_names && load_bpf_testmod()) {
 		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will=
 be skipped.\n");
 		env.has_testmod =3D false;
 	}
@@ -803,7 +803,7 @@ int main(int argc, char **argv)
 		if (test->need_cgroup_cleanup)
 			cleanup_cgroup_environment();
 	}
-	if (env.has_testmod)
+	if (!env.list_test_names && env.has_testmod)
 		unload_bpf_testmod();
 	stdio_restore();
=20
--=20
2.30.2

