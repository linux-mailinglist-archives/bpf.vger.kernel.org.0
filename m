Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3925A8147
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiHaPau (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiHaPar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 11:30:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09373F1C5
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:30:46 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27VEgvFg002224
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:30:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=i2Xh31sWBJdsXYvXVLfzbCj+G9CvRh79pA4ZMqMF/70=;
 b=ixvCV+e4Nfs8hLXfkuYJg0gQdyTPOHOU4cD+qsNoV8ul2NcLoGxrjIIustpkAGaaQzNk
 J3ViemqlS7hm/yroQOL9CkyVTbvK3TWyrcWA3TOvNnI+o6smYHfhG1wo0GvgSpCG9hQ1
 fM33C1eAV04vPwHNzDnTSiFKcB1+6McLSZc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j9nkryg12-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:30:46 -0700
Received: from twshared11415.03.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 08:30:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 60C16ECDED51; Wed, 31 Aug 2022 08:27:18 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 7/8] selftests/bpf: Use BPF_PROG2 for some fentry programs without struct arguments
Date:   Wed, 31 Aug 2022 08:27:18 -0700
Message-ID: <20220831152718.2081091-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831152641.2077476-1-yhs@fb.com>
References: <20220831152641.2077476-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tQirgScg-_oJsIPZLdv3R6yXrakIO_mr
X-Proofpoint-ORIG-GUID: tQirgScg-_oJsIPZLdv3R6yXrakIO_mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

