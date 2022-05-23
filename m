Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B474531311
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 18:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiEWPUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 11:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbiEWPUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 11:20:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA75DA7F
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 08:20:51 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24N8qlTw026927
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 08:20:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=LKRfxk7fSTHvRbAUg+0bXFDqYlW0I8BK8H9263ZIg/8=;
 b=dTM3qJ2oCWrQQ7lS9YbpYPic8w1AtO6pGBeiZCclimhpU8YqTKIyyhLs8fElq/U3CHl5
 oOoHIUCro+4wfcFA1r3QGN2ZV0Pw9sU8qi4sUHEE9W151YL9Yamcrg1IrloVCb5R1F/E
 bj3y4WkXSfZgJEnAcsAgGUDLZHrNqFb36fI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g6uk7huxk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 08:20:50 -0700
Received: from twshared24024.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 08:20:50 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 057AEAB381DD; Mon, 23 May 2022 08:20:44 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix btf_dump/btf_dump due to recent clang change
Date:   Mon, 23 May 2022 08:20:44 -0700
Message-ID: <20220523152044.3905809-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F3LjnVWdr03UxwImI31bGn-1huIVM9Ul
X-Proofpoint-GUID: F3LjnVWdr03UxwImI31bGn-1huIVM9Ul
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_06,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Latest llvm-project upstream had a change of behavior
related to qualifiers on function return type ([1]).
This caused selftests btf_dump/btf_dump failure.
The following example shows what changed.

  $ cat t.c
  typedef const char * const (* const (* const fn_ptr_arr2_t[5])())(char * =
(*)(int));
  struct t {
    int a;
    fn_ptr_arr2_t l;
  };
  int foo(struct t *arg) {
    return arg->a;
  }

Compiled with latest upstream llvm15,
  $ clang -O2 -g -target bpf -S -emit-llvm t.c
The related generated debuginfo IR looks like:
  !16 =3D !DIDerivedType(tag: DW_TAG_typedef, name: "fn_ptr_arr2_t", file: =
!1, line: 1, baseType: !17)
  !17 =3D !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 320=
, elements: !32)
  !18 =3D !DIDerivedType(tag: DW_TAG_const_type, baseType: !19)
  !19 =3D !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
  !20 =3D !DISubroutineType(types: !21)
  !21 =3D !{!22, null}
  !22 =3D !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
  !23 =3D !DISubroutineType(types: !24)
  !24 =3D !{!25, !28}
  !25 =3D !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
  !26 =3D !DIDerivedType(tag: DW_TAG_const_type, baseType: !27)
  !27 =3D !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
You can see two intermediate const qualifier to pointer are dropped in debu=
ginfo IR.

With llvm14, we have following debuginfo IR:
  !16 =3D !DIDerivedType(tag: DW_TAG_typedef, name: "fn_ptr_arr2_t", file: =
!1, line: 1, baseType: !17)
  !17 =3D !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 320=
, elements: !34)
  !18 =3D !DIDerivedType(tag: DW_TAG_const_type, baseType: !19)
  !19 =3D !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
  !20 =3D !DISubroutineType(types: !21)
  !21 =3D !{!22, null}
  !22 =3D !DIDerivedType(tag: DW_TAG_const_type, baseType: !23)
  !23 =3D !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
  !24 =3D !DISubroutineType(types: !25)
  !25 =3D !{!26, !30}
  !26 =3D !DIDerivedType(tag: DW_TAG_const_type, baseType: !27)
  !27 =3D !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
  !28 =3D !DIDerivedType(tag: DW_TAG_const_type, baseType: !29)
  !29 =3D !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
All const qualifiers are preserved.

To adapt the selftest to both old and new llvm, this patch removed
the intermediate const qualifier in const-to-ptr types, to make the
test succeed again.

  [1] https://reviews.llvm.org/D125919

Reported-by: Mykola Lysenko <mykolal@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c =
b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index 1c7105fcae3c..4ee4748133fe 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -94,7 +94,7 @@ typedef void (* (*signal_t)(int, void (*)(int)))(int);
=20
 typedef char * (*fn_ptr_arr1_t[10])(int **);
=20
-typedef char * (* const (* const fn_ptr_arr2_t[5])())(char * (*)(int));
+typedef char * (* (* const fn_ptr_arr2_t[5])())(char * (*)(int));
=20
 struct struct_w_typedefs {
 	int_t a;
--=20
2.30.2

