Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2051516741
	for <lists+bpf@lfdr.de>; Sun,  1 May 2022 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346687AbiEATEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 May 2022 15:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352103AbiEATEJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 May 2022 15:04:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5836B33A37
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 12:00:43 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2414sarI006169
        for <bpf@vger.kernel.org>; Sun, 1 May 2022 12:00:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LzO9CDROEHrW6BvGJ68Dv5xX5YFhpYGX0bBapRTeTaA=;
 b=EoWdO4/F3sAghF0lWkx0Lhyfg3xxkLfcf7p6wN9TpMutuBZylngBmZ3vDDLrlI8INxD7
 euGJXrkbjdTazNG18Lt5Gnp2Xsc/r32wk+6Uezp5P5UUfRLsLtjYIhBclDl0AziBBgkS
 +FyKoEMFvp1eYzwDBfa5L5UVDnJoq40Mp8A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs15jx00e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 12:00:43 -0700
Received: from twshared10896.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 1 May 2022 12:00:40 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B2BD69C01F6B; Sun,  1 May 2022 12:00:33 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 06/12] selftests/bpf: Fix selftests failure
Date:   Sun, 1 May 2022 12:00:33 -0700
Message-ID: <20220501190033.2579182-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220501190002.2576452-1-yhs@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HpvK2FZSHbAHQlxpmhzU7QVnVgI0KTG_
X-Proofpoint-ORIG-GUID: HpvK2FZSHbAHQlxpmhzU7QVnVgI0KTG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-01_07,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kflag is supported now for BTF_KIND_ENUM.
So remove the test which tests verifier failure
due to existence of kflag.

With enum64 support in kernel and libbpf,
selftest btf_dump/btf_dump failed with
no-enum64 support llvm for the following
enum definition:
 enum e2 {
        C =3D 100,
        D =3D 4294967295,
        E =3D 0,
 };

With the no-enum64 support llvm, the signedness is
'signed' by default, and D (4294967295 =3D 0xffffffff)
will print as -1. With enum64 support llvm, the signedness
is 'unsigned' and the value of D will print as 4294967295.
To support both old and new compilers, this patch
changed the value to 268435455 =3D 0xfffffff which works
with both enum64 or non-enum64 support llvm.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c  | 20 -------------------
 .../bpf/progs/btf_dump_test_case_syntax.c     |  2 +-
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index ba5bde53d418..8e068e06b3e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -2896,26 +2896,6 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid btf_info kind_flag",
 },
=20
-{
-	.descr =3D "invalid enum kind_flag",
-	.raw_types =3D {
-		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ENUM, 1, 1), 4),	/* [2] */
-		BTF_ENUM_ENC(NAME_TBD, 0),
-		BTF_END_RAW,
-	},
-	BTF_STR_SEC("\0A"),
-	.map_type =3D BPF_MAP_TYPE_ARRAY,
-	.map_name =3D "enum_type_check_btf",
-	.key_size =3D sizeof(int),
-	.value_size =3D sizeof(int),
-	.key_type_id =3D 1,
-	.value_type_id =3D 1,
-	.max_entries =3D 4,
-	.btf_load_err =3D true,
-	.err_str =3D "Invalid btf_info kind_flag",
-},
-
 {
 	.descr =3D "valid fwd kind_flag",
 	.raw_types =3D {
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.=
c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index 1c7105fcae3c..4068cea4be53 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -13,7 +13,7 @@ enum e1 {
=20
 enum e2 {
 	C =3D 100,
-	D =3D 4294967295,
+	D =3D 268435455,
 	E =3D 0,
 };
=20
--=20
2.30.2

