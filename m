Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F107C4E1987
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 04:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiCTDVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiCTDVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 23:21:40 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026031DEC
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 20:20:18 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22K1bBsD024143
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 20:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=VJjgzLE69aLs/INCLOwhRkLdfsfGQ47yNO2FQwLqZk0=;
 b=gTX1YK0pebc9WDks0WZMkc+GRzoRl9a6notKeOgEtHluSCxtBB0aqhi8fvK9OwNECN1V
 +iWoDfTyH11qrGMeNgMkMO5f3nCTkNKfdg1mqmCSGz/inp2yEMC5ub9F0b5ezmurlr7E
 w9uQikiB009WQMdn6SWMXqKWYMexAJcjic8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ewcwxauv7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 20:20:17 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Mar 2022 20:20:16 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9BFAA7D98AFD; Sat, 19 Mar 2022 20:20:09 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next] bpftool: fix a bug in subskeleton code generation
Date:   Sat, 19 Mar 2022 20:20:09 -0700
Message-ID: <20220320032009.3106133-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AArzn9MP2EKQtx5sIxJjzbNJNVFErnzv
X-Proofpoint-ORIG-GUID: AArzn9MP2EKQtx5sIxJjzbNJNVFErnzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-20_01,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Compiled with clang by adding LLVM=3D1 both kernel and selftests/bpf
build, I hit the following compilation error:

In file included from /.../tools/testing/selftests/bpf/prog_tests/subskel=
eton.c:6:
  ./test_subskeleton_lib.subskel.h:168:6: error: variable 'err' is used u=
ninitialized whenever
      'if' condition is true [-Werror,-Wsometimes-uninitialized]
          if (!s->progs)
              ^~~~~~~~~
  ./test_subskeleton_lib.subskel.h:181:11: note: uninitialized use occurs=
 here
          errno =3D -err;
                   ^~~
  ./test_subskeleton_lib.subskel.h:168:2: note: remove the 'if' if its co=
ndition is always false
          if (!s->progs)
          ^~~~~~~~~~~~~~

The compilation error is triggered by the following code
        ...
        int err;

        obj =3D (struct test_subskeleton_lib *)calloc(1, sizeof(*obj));
        if (!obj) {
                errno =3D ENOMEM;
                goto err;
        }
        ...

  err:
        test_subskeleton_lib__destroy(obj);
        errno =3D -err;
        ...
in test_subskeleton_lib__open(). The 'err' is not initialized, yet it
is used in 'errno =3D -err' later.

The fix is to remove 'errno =3D -err' since errno has been set properly
in all incoming branches.

Cc: Delyan Kratunov <delyank@fb.com>
Fixes: 00389c58ffe9 ("00389c58ffe993782a8ba4bb5a34a102b1f6fe24")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/gen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 96bd2b33ccf6..7ba7ff55d2ea 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1538,7 +1538,6 @@ static int do_subskeleton(int argc, char **argv)
 			return obj;					    \n\
 		err:							    \n\
 			%1$s__destroy(obj);				    \n\
-			errno =3D -err;					    \n\
 			return NULL;					    \n\
 		}							    \n\
 									    \n\
--=20
2.30.2

