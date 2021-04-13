Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E335E2F6
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbhDMPem (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 11:34:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41758 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344797AbhDMPek (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 11:34:40 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DFQ1Xv006409
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 08:34:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=f85XKa8nb30dwQWZpQtdrLtN8VggNvUjDGlhsY0ZSII=;
 b=p9KCmL/uB8y7VVKbpQLxs/xQjfRs35/otqF+EAbWK49W9uWCodGUplUAw+UWcnVjiO3C
 R7RHi3HwA0bXV68d7pym7Q2CnoF4LFu6ci0MDZd+PXt8M8LruGA89SW9zppWcuvn2WDH
 p4Nw3/fMcNi9NQFFaiwiV+/3QDs691QinrQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37wbd5h137-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 08:34:14 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 08:34:14 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id BE09A161F37B; Tue, 13 Apr 2021 08:34:08 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next v3 0/5] bpf: tools: support build selftests/bpf with clang
Date:   Tue, 13 Apr 2021 08:34:08 -0700
Message-ID: <20210413153408.3027270-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qHMRV2hFHZMQoqLfYk-zG7lKEkk-kVcF
X-Proofpoint-ORIG-GUID: qHMRV2hFHZMQoqLfYk-zG7lKEkk-kVcF
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_09:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104130108
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

I am using latest bpf-next kernel code base and
latest clang built from source from
  https://github.com/llvm/llvm-project.git
Using earlier version of llvm may have compilation errors, see
  tools/testing/selftests/bpf
due to continuous development in llvm bpf features and selftests
to use these features.

To run bpf selftest properly, you need have certain necessary
kernel configs like at:
  bpf-next:tools/testing/selftests/bpf/config
(not that this is not a complete .config file and some other configs
 might still be needed.)

Currently, using the above command, some compilations
still use gcc and there are also compilation errors and warnings.
This patch set intends to fix these issues.
Patch #1 and #2 fixed the issue so clang/clang++ is
used instead of gcc/g++. Patch #3 fixed a compilation
failure. Patch #4 and #5 fixed various compiler warnings.

Changelog:
  v2 -> v3:
    . more test environment description in cover letter. (Sedat)
    . use a different fix, but similar to other use in selftests/bpf
      Makefile, to exclude header files from CXX compilation command
      line. (Andrii)
    . fix codes instead of adding -Wno-format-security. (Andrii)
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

 tools/bpf/bpftool/net.c                              |  2 +-
 tools/scripts/Makefile.include                       | 12 ++++++++++--
 tools/testing/selftests/bpf/Makefile                 |  7 ++++++-
 tools/testing/selftests/bpf/prog_tests/fexit_sleep.c |  4 ++--
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c   |  4 ++--
 tools/testing/selftests/lib.mk                       |  4 ++++
 6 files changed, 25 insertions(+), 8 deletions(-)

--=20
2.30.2

