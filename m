Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB835C8BC
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 16:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbhDLO3u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 10:29:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46972 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241820AbhDLO3t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 10:29:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CEQJSb016765
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 07:29:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fXo6ka8UaVCnwZN3atsYncf9YikRdsxuYLK5BPjYYBA=;
 b=lACSUemwv1rcZeBLwtq/EMFmYJnxqIWvn3BXPmkjM06YEovGQzNNW7UzLAzZ8L2GFQgZ
 /eRK/m/j1QyLScmr7tz/SHVyMQSZy5xbt2n0KVtW5b38idCzLd7diwEZh1fj8Lf16NDi
 ds8Tl1uMIQq/i6yBvoYnRNEPJJIyS76C2do= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37vhtkhq77-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 07:29:31 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 07:29:29 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 625A61569AB4; Mon, 12 Apr 2021 07:29:27 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: silence clang compilation warnings
Date:   Mon, 12 Apr 2021 07:29:27 -0700
Message-ID: <20210412142927.268732-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412142905.266942-1-yhs@fb.com>
References: <20210412142905.266942-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 84hVFOzrp6V6aWwMeuJkmMetJOPyvZpv
X-Proofpoint-ORIG-GUID: 84hVFOzrp6V6aWwMeuJkmMetJOPyvZpv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With clang compiler:
  make -j60 LLVM=3D1 LLVM_IAS=3D1  <=3D=3D=3D compile kernel
  make -j60 -C tools/testing/selftests/bpf LLVM=3D1 LLVM_IAS=3D1
Some linker flags are not used/effective for some binaries and
we have warnings like:
  warning: -lelf: 'linker' input unused [-Wunused-command-line-argument]

We also have warnings like:
  .../selftests/bpf/prog_tests/ns_current_pid_tgid.c:74:57: note: treat t=
he string as an argument to avoid this
        if (CHECK(waitpid(cpid, &wstatus, 0) =3D=3D -1, "waitpid", strerr=
or(errno)))
                                                               ^
                                                               "%s",
  .../selftests/bpf/test_progs.h:129:35: note: expanded from macro 'CHECK=
'
        _CHECK(condition, tag, duration, format)
                                         ^
  .../selftests/bpf/test_progs.h:108:21: note: expanded from macro '_CHEC=
K'
                fprintf(stdout, ##format);                              \
                                  ^
The first warning can be silenced with clang option -Wno-unused-command-l=
ine-argument,
and the second with -Wno-format-security. Further, gcc does not support t=
he option
-Wno-unused-command-line-argument. Since the warning only happens with cl=
ang
compiler, these two options are enabled only when clang compiler is used =
and this
fixed the above warnings.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index bbd61cc3889b..ef7078756c8a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -28,6 +28,11 @@ CFLAGS +=3D -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_C=
FLAGS)		\
 	  -Dbpf_load_program=3Dbpf_test_load_program
 LDLIBS +=3D -lcap -lelf -lz -lrt -lpthread
=20
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS +=3D -Wno-unused-command-line-argument -Wno-format-security
+endif
+
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_lp=
m_map test_progs \
 	test_verifier_log test_dev_cgroup \
--=20
2.30.2

