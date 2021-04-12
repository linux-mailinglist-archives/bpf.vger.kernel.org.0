Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7F35C8B6
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhDLO3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 10:29:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51379 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237558AbhDLO33 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 10:29:29 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13CENZIo028092
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 07:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JKrw/jNJkkohEY2BCHVVoBZZfopETqSvMrkdrAt0bXU=;
 b=W9sCdaXPTg91J/cRlXkwU0JwxWuPZZU+BZRT8V7/Xy7i0zys18TlSYD+r1KFP5HN8H0t
 OyPvmR4QQDyMquggwuXwjvRDPMJAQOsSdvqPSuYBHKmV+mwC1Z7blsKd8qFhSXynEZSY
 e9qgbhTyUkg4qP2Jc8l3WvikYD9ewVa6CJo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37vkb2savk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 07:29:11 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 07:29:10 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B899B1569A68; Mon, 12 Apr 2021 07:29:05 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf with clang
Date:   Mon, 12 Apr 2021 07:29:05 -0700
Message-ID: <20210412142905.266942-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RXPA8RVEqRn7h4DmijDDsBZChnaKkZ7X
X-Proofpoint-GUID: RXPA8RVEqRn7h4DmijDDsBZChnaKkZ7X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=706 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To build kernel with clang, people typically use
  make -j60 LLVM=3D1 LLVM_IAS=3D1
LLVM_IAS=3D1 is not required for non-LTO build but
is required for LTO build. In my environment,
I am always having LLVM_IAS=3D1 regardless of
whether LTO is enabled or not.

After kernel is build with clang, the following command
can be used to build selftests with clang:
  make -j60 -C tools/testing/selftests/bpf LLVM=3D1 LLVM_IAS=3D1

But currently, using the above command, some compilations
still use gcc and there are also compilation errors and warnings.
This patch set intends to fix these issues.
Patch #1 and #2 fixed the issue so clang/clang++ is
used instead of gcc/g++. Patch #3 fixed a compilation
failure. Patch #4 and #5 fixed various compiler warnings.

Changelog:
  v1 -> v2:
    . add -Wno-unused-command-line-argument and -Wno-format-security
      for clang only as (1). gcc does not exhibit those
      warnings, and (2). -Wno-unused-command-line-argument is
      only supported by clang. (Sedat)

Yonghong Song (5):
  selftests: set CC to clang in lib.mk if LLVM is set
  tools: allow proper CC/CXX/... override with LLVM=3D1 in
    Makefile.include
  selftests/bpf: fix test_cpp compilation failure with clang
  selftests/bpf: silence clang compilation warnings
  bpftool: fix a clang compilation warning

 tools/bpf/bpftool/net.c              |  2 +-
 tools/scripts/Makefile.include       | 12 ++++++++++--
 tools/testing/selftests/bpf/Makefile |  7 ++++++-
 tools/testing/selftests/lib.mk       |  4 ++++
 4 files changed, 21 insertions(+), 4 deletions(-)

--=20
2.30.2

