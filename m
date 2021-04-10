Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD5D35AF1D
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhDJQtt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 12:49:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50638 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234334AbhDJQtt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 10 Apr 2021 12:49:49 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13AGjbkR021566
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 09:49:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=fAFXdPttQf7ftlV84f9eZ5+bGyGujKzBVdowIdMqys8=;
 b=MhsyIBqrU2M89kczDI3Uw2UoCIkj0sWUlyrlj/liST7nqsR1gbScDhvfD+w77k9ViVPS
 ljIZ0X4pskY5MLZBDk4TXb3LH3u/PXB4tU+A6kP3V2xITSt8IKT+WZkX0+IpNsP2JXqr
 P0Z09nU4RC0zLSGb22wjwQlaqbrEzscXlEM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37u9qe98y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 09:49:34 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 10 Apr 2021 09:49:30 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2E52E14503F3; Sat, 10 Apr 2021 09:49:25 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next 0/5] support build selftests/bpf with clang
Date:   Sat, 10 Apr 2021 09:49:25 -0700
Message-ID: <20210410164925.768741-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HP7DyxNgLHZMVJDhbXWWOXeW3yfbexO0
X-Proofpoint-GUID: HP7DyxNgLHZMVJDhbXWWOXeW3yfbexO0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-10_07:2021-04-09,2021-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=577 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104100126
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

But currently, some compilations still use gcc
and there are also compilation errors and warnings.
This patch set intends to fix these issues.
Patch #1 and #2 fixed the issue so clang/clang++ is
used instead of gcc/g++. Patch #3 fixed a compilation
failure. Patch #4 and #5 fixed various compiler warnings.

Yonghong Song (5):
  selftests: set CC to clang in lib.mk if LLVM is set
  tools: allow proper CC/CXX/... override with LLVM=3D1 in
    Makefile.include
  selftests/bpf: fix test_cpp compilation failure with clang
  selftests/bpf: silence clang compilation warnings
  bpftool: fix a clang compilation warning

 tools/bpf/bpftool/net.c              |  2 +-
 tools/scripts/Makefile.include       | 12 ++++++++++--
 tools/testing/selftests/bpf/Makefile |  4 +++-
 tools/testing/selftests/lib.mk       |  4 ++++
 4 files changed, 18 insertions(+), 4 deletions(-)

--=20
2.30.2

