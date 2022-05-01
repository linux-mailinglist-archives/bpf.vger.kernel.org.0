Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1E2516747
	for <lists+bpf@lfdr.de>; Sun,  1 May 2022 21:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351379AbiEATEi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 May 2022 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352260AbiEATEh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 May 2022 15:04:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C833A23
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 12:01:11 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241AKvNg020726
        for <bpf@vger.kernel.org>; Sun, 1 May 2022 12:01:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=L2C93fhZ4liEM4rtlLIHzsQ7M6A63adBs15NyMcupjY=;
 b=cJqHE9YSQJoersfLQUvu6KO+l3uQCu52HFlbW9DEkkZNyZxa1yGT9PQzkiest/D/gpja
 Xb9n9uRBxLNAJIOxrXwYxG/KuKRLPJNfgGMjfG4QQdiR3xpGJV7M4RLOno8xQujIqdJd
 HZDMS2/Q+dIoembOuHNwm/nHkuTjKv6scO4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs15jx02b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 12:01:11 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 1 May 2022 12:01:10 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id E64289C01FAB; Sun,  1 May 2022 12:00:59 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 11/12] selftests/bpf: Clarify llvm dependency with possible selftest failures
Date:   Sun, 1 May 2022 12:00:59 -0700
Message-ID: <20220501190059.2581175-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220501190002.2576452-1-yhs@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uVuXxjE7sByI6EAGZH1jZieBvjcGozRc
X-Proofpoint-ORIG-GUID: uVuXxjE7sByI6EAGZH1jZieBvjcGozRc
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-01_07,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Certain subtests in selftests core_reloc and core_reloc_btfgen
requires llvm ENUM64 support in llvm15. If an older compiler
is used, these subtests will fail. Make this requirement clear
in selftests README.rst file.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/README.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftes=
ts/bpf/README.rst
index eb1b7541f39d..a68f448a6043 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -266,3 +266,21 @@ from running test_progs will look like:
   test_xdpwall:FAIL:Does LLVM have https://reviews.llvm.org/D109073? unexp=
ected error: -4007
=20
 __ https://reviews.llvm.org/D109073
+
+ENUM64 support and Clang version
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+There are a few selftests requiring LLVM ENUM64 support. The LLVM ENUM64 is
+introduced in `Clang 15` [0_]. Without proper compiler support, the follow=
ing selftests
+will fail:
+
+.. code-block:: console
+
+  #45 /72    core_reloc/enum64val:FAIL
+  #45 /73    core_reloc/enum64val___diff:FAIL
+  #45 /74    core_reloc/enum64val___val3_missing:FAIL
+  #46 /72    core_reloc_btfgen/enum64val:FAIL
+  #46 /73    core_reloc_btfgen/enum64val___diff:FAIL
+  #46 /74    core_reloc_btfgen/enum64val___val3_missing:FAIL
+
+.. _0: https://reviews.llvm.org/D124641
--=20
2.30.2

