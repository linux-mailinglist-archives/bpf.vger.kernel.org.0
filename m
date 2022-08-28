Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712345A3B23
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 04:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiH1Cza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 22:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiH1Cz3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 22:55:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD1331237
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:28 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27RN9n1f003128
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=i2Xh31sWBJdsXYvXVLfzbCj+G9CvRh79pA4ZMqMF/70=;
 b=ooaExDpMXs7EIJ7P7R4Cse6t2ybQBiBNjoheVerdMco9Zs4bxNL8uR2e8mZohyfo21Z5
 tP29IHZhD6+KtXEyeIJ+JmrEl/JThwZHXnwHdPogNLNz+WpWTCQD6KIn+FecSfEw/rdu
 0gZRZcCpzjkdh5XfGOCoJFYGWyuba0AAumw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7ekmuawy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:28 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:55:26 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2387AEA74875; Sat, 27 Aug 2022 19:55:15 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: Use BPF_PROG2 for some fentry programs without struct arguments
Date:   Sat, 27 Aug 2022 19:55:15 -0700
Message-ID: <20220828025515.146020-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220828025438.142798-1-yhs@fb.com>
References: <20220828025438.142798-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wTYCGx8LucUwTdNocOUMJFiG5fxEjb94
X-Proofpoint-GUID: wTYCGx8LucUwTdNocOUMJFiG5fxEjb94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use BPF_PROG2 instead of BPF_PROG for programs in progs/timer.c
to test BPF_PROG2 for cases without struct arguments.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/se=
lftests/bpf/progs/timer.c
index 5f5309791649..560a63e95dc3 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -120,7 +120,7 @@ static int timer_cb1(void *map, int *key, struct bpf_=
timer *timer)
 }
=20
 SEC("fentry/bpf_fentry_test1")
-int BPF_PROG(test1, int a)
+int BPF_PROG2(test1, int, a)
 {
 	struct bpf_timer *arr_timer, *lru_timer;
 	struct elem init =3D {};
@@ -247,7 +247,7 @@ int bpf_timer_test(void)
 }
=20
 SEC("fentry/bpf_fentry_test2")
-int BPF_PROG(test2, int a, int b)
+int BPF_PROG2(test2, int, a, int, b)
 {
 	struct hmap_elem init =3D {}, *val;
 	int key =3D HTAB, key_malloc =3D HTAB_MALLOC;
--=20
2.30.2

