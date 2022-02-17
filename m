Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1024BA9FE
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 20:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245359AbiBQTk3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 14:40:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbiBQTk2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 14:40:28 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8FB4199B
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 11:40:12 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HHf5wL002003
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 11:40:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=YSSB4tTq/K17hWAxXW9Qgn/pTn8qhJ/2vur5wVcIvkw=;
 b=h0Ql8mhn46ypPi6YuCSPoKpELJPSyPFoRK6/TnTN68TglrV7QzaqDMKUkBv1WHsofm6g
 rd81NI3K3VEfw8qTKQ+Q1qV1tBwXEbWvNDEWN49GT1ZqBeJfr1E3Toq/wbHskm44Inxe
 FWTHmSZdJJKidEwbEp81f8MAgNK0sDg/hvs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e9g4y542d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 11:40:11 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 11:40:11 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5E7C46857D3A; Thu, 17 Feb 2022 11:40:05 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix a clang deprecated-declarations compilation error
Date:   Thu, 17 Feb 2022 11:40:05 -0800
Message-ID: <20220217194005.2765348-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6qAess2wQ7z2qMbR1QIeedCigTUTrv_r
X-Proofpoint-ORIG-GUID: 6qAess2wQ7z2qMbR1QIeedCigTUTrv_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_07,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=718 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170092
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Build the kernel and selftest with clang compiler with LLVM=3D1,
  make -j LLVM=3D1
  make -C tools/testing/selftests/bpf -j LLVM=3D1

I hit the following selftests/bpf compilation error:
  In file included from test_cpp.cpp:3:
  /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:73:8:
    error: 'relaxed_core_relocs' is deprecated: libbpf v0.6+: field has n=
o effect [-Werror,-Wdeprecated-declarations]
  struct bpf_object_open_opts {
         ^
  test_cpp.cpp:56:2: note: in implicit move constructor for 'bpf_object_o=
pen_opts' first required here
          LIBBPF_OPTS(bpf_object_open_opts, opts);
          ^
  /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:77:3=
: note: expanded from macro 'LIBBPF_OPTS'
                  (struct TYPE) {                                        =
     \
                  ^
  /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:90:2: note:=
 'relaxed_core_relocs' has been explicitly marked deprecated here
          LIBBPF_DEPRECATED_SINCE(0, 6, "field has no effect")
          ^
  /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:24:4=
: note: expanded from macro 'LIBBPF_DEPRECATED_SINCE'
                  (LIBBPF_DEPRECATED("libbpf v" # major "." # minor "+: "=
 msg))
                   ^
  /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:19:4=
7: note: expanded from macro 'LIBBPF_DEPRECATED'
  #define LIBBPF_DEPRECATED(msg) __attribute__((deprecated(msg)))

There are two ways to fix the issue, one is to use GCC diagnostic ignore =
pragma, and the
other is to open code bpf_object_open_opts instead of using LIBBPF_OPTS.
Since in general LIBBPF_OPTS is preferred, the patch fixed the issue by
adding proper GCC diagnostic ignore pragmas.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/test_cpp.cpp | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/sel=
ftests/bpf/test_cpp.cpp
index 773f165c4898..19ad172036da 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 #include <iostream>
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 #include <bpf/libbpf.h>
+#pragma GCC diagnostic pop
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include "test_core_extern.skel.h"
--=20
2.30.2

