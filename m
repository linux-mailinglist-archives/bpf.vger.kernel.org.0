Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F261835AF1F
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhDJQuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 12:50:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234334AbhDJQuG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 10 Apr 2021 12:50:06 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13AGiR8h023534
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 09:49:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gyE307jnpHidO5GmDqeEjlONxZuG4OwvfSivC7TEne8=;
 b=dh8LkzraMSuQ7B6pEAiEh0qXl+u0bpEhK5PIs0otOhLO4feybD2tCxqB7r0a369W+llD
 Y5Ty5+FUo9eYneLVAjpWdAa2gwtAMKEcQxXQ7P6arA+bFJm4D7F61MDKT6GSGkord7Lu
 ODlg3jUUkP2FKH6q1Rx2pnLfrc1r1lRuxTo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37u7h3hk30-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 09:49:51 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 10 Apr 2021 09:49:50 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 33A351450449; Sat, 10 Apr 2021 09:49:46 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next 4/5] selftests/bpf: silence clang compilation warnings
Date:   Sat, 10 Apr 2021 09:49:46 -0700
Message-ID: <20210410164946.770575-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210410164925.768741-1-yhs@fb.com>
References: <20210410164925.768741-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 532wonT5liChyiS4qkBkwea4BAZwx_fH
X-Proofpoint-GUID: 532wonT5liChyiS4qkBkwea4BAZwx_fH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-10_07:2021-04-09,2021-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=769 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104100126
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
Let us add proper compilation flags to silence the above two kinds of war=
nings.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index bbd61cc3889b..a9c0a64a4c49 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -24,6 +24,8 @@ SAN_CFLAGS	?=3D
 CFLAGS +=3D -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)		\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)			\
+	  -Wno-unused-command-line-argument				\
+	  -Wno-format-security						\
 	  -Dbpf_prog_load=3Dbpf_prog_test_load				\
 	  -Dbpf_load_program=3Dbpf_test_load_program
 LDLIBS +=3D -lcap -lelf -lz -lrt -lpthread
--=20
2.30.2

