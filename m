Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9522920FA3C
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbgF3RNB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 13:13:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63468 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729963AbgF3RNB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 13:13:01 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UHClRS015844
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:13:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QBBlwTOVhORfIFqyWDrTRGGbAzuqVdM0VcYhatntdW4=;
 b=dG55tokP7paSiFFyrcb1mgbKY84SS2qJwPAJfJcWL9HolTX/x9JodGRMKuH9gEi0wuXn
 q/7h1tGv2h2orjrFJIrMVQcsrBb4HsIhKNBw4U9oigg8l01mxrF49SIQ1ZLEyh5b8bpj
 YgGLSPtfiSa1+jyNhXnqtIDACfjIbRVV4RI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31xny2axdk-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:13:01 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 10:12:44 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 82986370229B; Tue, 30 Jun 2020 10:12:40 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 1/2] bpf: fix an incorrect branch elimination by verifier
Date:   Tue, 30 Jun 2020 10:12:40 -0700
Message-ID: <20200630171240.2523722-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630171240.2523628-1-yhs@fb.com>
References: <20200630171240.2523628-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxlogscore=751 adultscore=0 suspectscore=1
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300118
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wenbo reported an issue in [1] where a checking of null
pointer is evaluated as always false. In this particular
case, the program type is tp_btf and the pointer to
compare is a PTR_TO_BTF_ID.

The current verifier considers PTR_TO_BTF_ID always
reprents a non-null pointer, hence all PTR_TO_BTF_ID compares
to 0 will be evaluated as always not-equal, which resulted
in the branch elimination.

For example,
 struct bpf_fentry_test_t {
     struct bpf_fentry_test_t *a;
 };
 int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
 {
     if (arg =3D=3D 0)
         test7_result =3D 1;
     return 0;
 }
 int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
 {
     if (arg->a =3D=3D 0)
         test8_result =3D 1;
     return 0;
 }

In above bpf programs, both branch arg =3D=3D 0 and arg->a =3D=3D 0
are removed. This may not be what developer expected.

The bug is introduced by Commit cac616db39c2 ("bpf: Verifier
track null pointer branch_taken with JNE and JEQ"),
where PTR_TO_BTF_ID is considered to be non-null when evaluting
pointer vs. scalar comparison. This may be added
considering we have PTR_TO_BTF_ID_OR_NULL in the verifier
as well.

PTR_TO_BTF_ID_OR_NULL is added to explicitly requires
a non-NULL testing in selective cases. The current generic
pointer tracing framework in verifier always
assigns PTR_TO_BTF_ID so users does not need to
check NULL pointer at every pointer level like a->b->c->d.

We may not want to assign every PTR_TO_BTF_ID as
PTR_TO_BTF_ID_OR_NULL as this will require a null test
before pointer dereference which may cause inconvenience
for developers. But we could avoid branch elimination
to preserve original code intention.

This patch simply removed PTR_TO_BTD_ID from reg_type_not_null()
in verifier, which prevented the above branches from being eliminated.

 [1]: https://lore.kernel.org/bpf/79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb=
.com/T/

Fixes: cac616db39c2 ("bpf: Verifier track null pointer branch_taken with =
JNE and JEQ")
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Wenbo Zhang <ethercflow@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8911d0576399..94cead5a43e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -399,8 +399,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
 		type =3D=3D PTR_TO_MAP_VALUE ||
-		type =3D=3D PTR_TO_SOCK_COMMON ||
-	        type =3D=3D PTR_TO_BTF_ID;
+		type =3D=3D PTR_TO_SOCK_COMMON;
 }
=20
 static bool reg_type_may_be_null(enum bpf_reg_type type)
--=20
2.24.1

