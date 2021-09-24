Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81384416A46
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 04:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhIXDAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 23:00:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230123AbhIXDAg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 23:00:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18NNe2v3027464
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 19:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Jf8HUtAaPN0Vj8gjqMPx5UMvBuoAblzRm7i0B2hPAik=;
 b=BMkWV2T17rbLpLxRYiu8YSZipJWd1dcC7Zy+E/LPq6gZW9gxDjDo5NGxyhO/SeHTIXpW
 J0BZ1RFUY6gWm7TmnEQKvtAxTGj8fG43aaTSERXATLm8BuDw4qGi88R+3fg4E86qbzFQ
 9wN9Q3X+v41ah5qK85Ok0LAW2JNACUuBOPw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b93em0u4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 19:59:03 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 19:59:03 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 4CDE4394E1D; Thu, 23 Sep 2021 19:58:56 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix btf_dump __int128 test failure with clang build kernel
Date:   Thu, 23 Sep 2021 19:58:56 -0700
Message-ID: <20210924025856.2192476-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: D8z1ZTTgyteHhpNYNoB30KFb0ZViq3bu
X-Proofpoint-ORIG-GUID: D8z1ZTTgyteHhpNYNoB30KFb0ZViq3bu
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_07,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=953 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240014
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With clang build kernel (adding LLVM=3D1 to kernel and selftests/bpf build
command line), I hit the following test failure:

  $ ./test_progs -t btf_dump
  ...
  btf_dump_data:PASS:ensure expected/actual match 0 nsec
  btf_dump_data:FAIL:find type id unexpected find type id: actual -2 < expe=
cted 0
  btf_dump_data:FAIL:find type id unexpected find type id: actual -2 < expe=
cted 0
  test_btf_dump_int_data:FAIL:dump __int128 unexpected error: -2 (errno 2)
  #15/9 btf_dump/btf_dump: int_data:FAIL

Further analysis showed gcc build kernel has type "__int128" in dwarf/BTF
and it doesn't exist in clang build kernel. Code searching for kernel code
found the following:
  arch/s390/include/asm/types.h:  unsigned __int128 pair;
  crypto/ecc.c:   unsigned __int128 m =3D (unsigned __int128)left * right;
  include/linux/math64.h: return (u64)(((unsigned __int128)a * mul) >> shif=
t);
  include/linux/math64.h: return (u64)(((unsigned __int128)a * mul) >> shif=
t);
  lib/ubsan.h:typedef __int128 s_max;
  lib/ubsan.h:typedef unsigned __int128 u_max;

In my case, CONFIG_UBSAN is not enabled. Even if we only have "unsigned __i=
nt128"
in the code, somehow gcc still put "__int128" in dwarf while clang didn't.
Hence current test works fine for gcc but not for clang.

Enabling CONFIG_UBSAN is an option to provide __int128 type into dwarf
reliably for both gcc and clang, but not everybody enables CONFIG_UBSAN
in their kernel build. So the best choice is to use "unsigned __int128" type
which is available in both clang and gcc build kernels. But clang and gcc
dwarf encoded names for "unsigned __int128" are different:

  [$ ~] cat t.c
  unsigned __int128 a;
  [$ ~] gcc -g -c t.c && llvm-dwarfdump t.o | grep __int128
                  DW_AT_type      (0x00000031 "__int128 unsigned")
                  DW_AT_name      ("__int128 unsigned")
  [$ ~] clang -g -c t.c && llvm-dwarfdump t.o | grep __int128
                  DW_AT_type      (0x00000033 "unsigned __int128")
                  DW_AT_name      ("unsigned __int128")

The test change in this patch tries to test type name before
doing actual test.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/test=
ing/selftests/bpf/prog_tests/btf_dump.c
index 52ccf0cf35e1..87f9df653e4e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -358,12 +358,27 @@ static void test_btf_dump_int_data(struct btf *btf, s=
truct btf_dump *d,
 	TEST_BTF_DUMP_DATA_OVER(btf, d, NULL, str, int, sizeof(int)-1, "", 1);
=20
 #ifdef __SIZEOF_INT128__
-	TEST_BTF_DUMP_DATA(btf, d, NULL, str, __int128, BTF_F_COMPACT,
-			   "(__int128)0xffffffffffffffff",
-			   0xffffffffffffffff);
-	ASSERT_OK(btf_dump_data(btf, d, "__int128", NULL, 0, &i, 16, str,
-				"(__int128)0xfffffffffffffffffffffffffffffffe"),
-		  "dump __int128");
+	/* gcc encode unsigned __int128 type with name "__int128 unsigned" in dwa=
rf,
+	 * and clang encode it with name "unsigned __int128" in dwarf.
+	 * Do an availability test for either variant before doing actual test.
+	 */
+	if (btf__find_by_name(btf, "unsigned __int128") > 0) {
+		TEST_BTF_DUMP_DATA(btf, d, NULL, str, unsigned __int128, BTF_F_COMPACT,
+				   "(unsigned __int128)0xffffffffffffffff",
+				   0xffffffffffffffff);
+		ASSERT_OK(btf_dump_data(btf, d, "unsigned __int128", NULL, 0, &i, 16, st=
r,
+					"(unsigned __int128)0xfffffffffffffffffffffffffffffffe"),
+			  "dump unsigned __int128");
+	} else if (btf__find_by_name(btf, "__int128 unsigned") > 0) {
+		TEST_BTF_DUMP_DATA(btf, d, NULL, str, __int128 unsigned, BTF_F_COMPACT,
+				   "(__int128 unsigned)0xffffffffffffffff",
+				   0xffffffffffffffff);
+		ASSERT_OK(btf_dump_data(btf, d, "__int128 unsigned", NULL, 0, &i, 16, st=
r,
+					"(__int128 unsigned)0xfffffffffffffffffffffffffffffffe"),
+			  "dump unsigned __int128");
+	} else {
+		ASSERT_TRUE(false, "unsigned_int128_not_found");
+	}
 #endif
 }
=20
--=20
2.30.2

