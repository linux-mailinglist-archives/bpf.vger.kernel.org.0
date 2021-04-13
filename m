Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312A135E2FA
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbhDMPez (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 11:34:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28360 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344722AbhDMPey (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 11:34:54 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DFOc0Z018040
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 08:34:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=iIplZfTK9uWTPjGoeXupSpYNBFLlGs2BtUUyc6SCIDU=;
 b=h3ym3PPNxb9JzyTYcVSkly0kfohsERmensC4dhbkXP/NRZ9D8Z/8Ur7Q7i90hvwfcu+g
 frKiO58is3afbdbHqBSuC8RZgFeGyMNA1QKZ184skoBuI5xez68xCMW7HhB+8YZ6AKSX
 NjMJJm6z14x7/nV/vrjaw2fl75myG1OYg04= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37w94f1pee-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 08:34:33 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 08:34:31 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 9DFBE161F552; Tue, 13 Apr 2021 08:34:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: fix test_cpp compilation failure with clang
Date:   Tue, 13 Apr 2021 08:34:24 -0700
Message-ID: <20210413153424.3028986-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413153408.3027270-1-yhs@fb.com>
References: <20210413153408.3027270-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uaCMueh1reQ7V_WU16U2fxaEH8Duvvkv
X-Proofpoint-GUID: uaCMueh1reQ7V_WU16U2fxaEH8Duvvkv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_09:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=832 adultscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With clang compiler:
  make -j60 LLVM=3D1 LLVM_IAS=3D1  <=3D=3D=3D compile kernel
  make -j60 -C tools/testing/selftests/bpf LLVM=3D1 LLVM_IAS=3D1
the test_cpp build failed due to the failure:
  warning: treating 'c-header' input as 'c++-header' when in C++ mode, th=
is behavior is deprecated [-Wdeprecated]
  clang-13: error: cannot specify -o when generating multiple output file=
s

test_cpp compilation flag looks like:
  clang++ -g -Og -rdynamic -Wall -I<...> ... \
  -Dbpf_prog_load=3Dbpf_prog_test_load -Dbpf_load_program=3Dbpf_test_load=
_program \
  test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_st=
ub.o \
  -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp

The clang++ compiler complains the header file in the command line and
also failed the compilation due to this.
Let us remove the header file from the command line which is not intended
any way, and this fixed the compilation problem.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 6448c626498f..dcc2dc1f2a86 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tes=
ts.h $(BPFOBJ) | $(OUTPUT)
 # Make sure we are able to include and link libbpf against c++.
 $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPF=
OBJ)
 	$(call msg,CXX,,$@)
-	$(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
+	$(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
=20
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
--=20
2.30.2

