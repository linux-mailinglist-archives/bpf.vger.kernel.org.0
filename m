Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345AD54A8EE
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 07:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiFNFzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 01:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFNFzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 01:55:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205211F2EC
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 22:55:37 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E1pmRG023035
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 22:55:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Tgpvm7aFyGBDsqOQjQHr84tNIDJZ0EMUVuJ9xgr6f6E=;
 b=gRicDptgC2g6sGgMcC98RhI0+3/1eBf/hsc0324AQ2ktmiDWMuRtHCaw0OlXavhEp/UJ
 mSe6tFU7AMdR0DMMXZ956gX+BzPh9fD9d3LJPzhoWuXXlu0IvxU+3D3uDN26PIvlWv0Q
 Nra/1o2oKv4M7sQJtjx44ibBaPvkG1UZb0s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmrvv59e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 22:55:36 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 13 Jun 2022 22:55:35 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2889BB9432E8; Mon, 13 Jun 2022 22:55:26 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Avoid skipping certain subtests
Date:   Mon, 13 Jun 2022 22:55:26 -0700
Message-ID: <20220614055526.628299-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PKhnd8zXsgGpg862G-pYPW4rnJi34fzQ
X-Proofpoint-GUID: PKhnd8zXsgGpg862G-pYPW4rnJi34fzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_02,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 704c91e59fe0 ('selftests/bpf: Test "bpftool gen min_core_btf"')
added a test test_core_btfgen to test core relocation with btf
generated with 'bpftool gen min_core_btf'. Currently,
among 76 subtests, 25 are skipped.

  ...
  #46/69   core_reloc_btfgen/enumval:OK
  #46/70   core_reloc_btfgen/enumval___diff:OK
  #46/71   core_reloc_btfgen/enumval___val3_missing:OK
  #46/72   core_reloc_btfgen/enumval___err_missing:SKIP
  #46/73   core_reloc_btfgen/enum64val:OK
  #46/74   core_reloc_btfgen/enum64val___diff:OK
  #46/75   core_reloc_btfgen/enum64val___val3_missing:OK
  #46/76   core_reloc_btfgen/enum64val___err_missing:SKIP
  ...
  #46      core_reloc_btfgen:SKIP
  Summary: 1/51 PASSED, 25 SKIPPED, 0 FAILED

Alexei found that in the above core_reloc_btfgen/enum64val___err_missing
should not be skipped.

Currently, the core_reloc tests have some negative tests.
In Commit 704c91e59fe0, for core_reloc_btfgen, all negative tests
are skipped with the following condition
  if (!test_case->btf_src_file || test_case->fails) {
	test__skip();
	continue;
  }
This is too conservative. Negative tests do not fail
mkstemp() and run_btfgen() should not be skipped.
There are a few negative tests indeed failing run_btfgen()
and this patch added 'run_btfgen_fails' to mark these tests
so that they can be skipped for btfgen tests. With this,
we have
  ...
  #46/69   core_reloc_btfgen/enumval:OK
  #46/70   core_reloc_btfgen/enumval___diff:OK
  #46/71   core_reloc_btfgen/enumval___val3_missing:OK
  #46/72   core_reloc_btfgen/enumval___err_missing:OK
  #46/73   core_reloc_btfgen/enum64val:OK
  #46/74   core_reloc_btfgen/enum64val___diff:OK
  #46/75   core_reloc_btfgen/enum64val___val3_missing:OK
  #46/76   core_reloc_btfgen/enum64val___err_missing:OK
  ...
  Summary: 1/62 PASSED, 14 SKIPPED, 0 FAILED

Totally 14 subtests are skipped instead of 25.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Changelog:
 - Added missing test_progs output
 - I didn't add Fixes tag since Commit 704c91e59fe0 doesn't really
   introduce bugs, just a little bit conservative.

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index 47c1ef117275..2f92feb809be 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -84,6 +84,7 @@ static int duration =3D 0;
 #define NESTING_ERR_CASE(name) {					\
 	NESTING_CASE_COMMON(name),					\
 	.fails =3D true,							\
+	.run_btfgen_fails =3D true,							\
 }
=20
 #define ARRAYS_DATA(struct_name) STRUCT_TO_CHAR_PTR(struct_name) {	\
@@ -258,12 +259,14 @@ static int duration =3D 0;
 	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_probed.o",	\
 			      "probed:", name),				\
 	.fails =3D true,							\
+	.run_btfgen_fails =3D true,							\
 	.raw_tp_name =3D "sys_enter",					\
 	.prog_name =3D "test_core_bitfields",				\
 }, {									\
 	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_direct.o",	\
 			      "direct:", name),				\
 	.fails =3D true,							\
+	.run_btfgen_fails =3D true,							\
 	.prog_name =3D "test_core_bitfields_direct",			\
 }
=20
@@ -304,6 +307,7 @@ static int duration =3D 0;
 #define SIZE_ERR_CASE(name) {						\
 	SIZE_CASE_COMMON(name),						\
 	.fails =3D true,							\
+	.run_btfgen_fails =3D true,							\
 }
=20
 #define TYPE_BASED_CASE_COMMON(name)					\
@@ -396,6 +400,7 @@ struct core_reloc_test_case {
 	const char *output;
 	int output_len;
 	bool fails;
+	bool run_btfgen_fails;
 	bool needs_testmod;
 	bool relaxed_core_relocs;
 	const char *prog_name;
@@ -952,7 +957,7 @@ static void run_core_reloc_tests(bool use_btfgen)
 		/* generate a "minimal" BTF file and use it as source */
 		if (use_btfgen) {
=20
-			if (!test_case->btf_src_file || test_case->fails) {
+			if (!test_case->btf_src_file || test_case->run_btfgen_fails) {
 				test__skip();
 				continue;
 			}
--=20
2.30.2

