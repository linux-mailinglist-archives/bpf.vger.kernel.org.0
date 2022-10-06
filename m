Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED75F60B3
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 07:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJFFel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 01:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJFFel (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 01:34:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA78D33E
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 22:34:38 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295NJqoj029434
        for <bpf@vger.kernel.org>; Wed, 5 Oct 2022 22:34:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=BZrjIkm3sPcM8M3FAgj6rTeOgcFeiMDaQ1jOEPLsbcc=;
 b=YWZ2KrwYZfWdt7ODy84nfUyd4g0pxiuMz5oUF5vtfXypOOYxoqPu5Cn8NMRw0K+f0PIl
 JDLF9vgnuIbpa8Ghrw5Ek1kjjgfU/I2S2ntzc3Suw3FU2i4nwDSYZo0OKhJ+lHLYfjkQ
 fPHGuVbqp6DW7n46ErMC0LhZS2yQFyUqxtI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k0ehwyvrk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 22:34:37 -0700
Received: from twshared0933.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 22:34:36 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id E6B25104E0E8B; Wed,  5 Oct 2022 22:34:29 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Add selftest deny_namespace to s390x deny list
Date:   Wed, 5 Oct 2022 22:34:29 -0700
Message-ID: <20221006053429.3549165-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LtZq9t4lyU8x4lqVdla70qq7pNpDiQaV
X-Proofpoint-GUID: LtZq9t4lyU8x4lqVdla70qq7pNpDiQaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF CI reported that selftest deny_namespace failed with s390x.

  test_unpriv_userns_create_no_bpf:PASS:no-bpf unpriv new user ns 0 nsec
  test_deny_namespace:PASS:skel load 0 nsec
  libbpf: prog 'test_userns_create': failed to attach: ERROR: strerror_r(=
-524)=3D22
  libbpf: prog 'test_userns_create': failed to auto-attach: -524
  test_deny_namespace:FAIL:attach unexpected error: -524 (errno 524)
  #57/1    deny_namespace/unpriv_userns_create_no_bpf:FAIL
  #57      deny_namespace:FAIL

BPF program test_userns_create is a BPF LSM type program which is
based on trampoline and s390x does not support s390x. Let add the
test to x390x deny list to avoid this failure in BPF CI.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
index 17e074eb42b8..0fb03b8047d5 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -75,3 +75,4 @@ user_ringbuf                             # failed to fi=
nd kernel BTF type ID of
 lookup_key                               # JIT does not support calling =
kernel function                                (kfunc)
 verify_pkcs7_sig                         # JIT does not support calling =
kernel function                                (kfunc)
 kfunc_dynptr_param                       # JIT does not support calling =
kernel function                                (kfunc)
+deny_namespace                           # failed to attach: ERROR: stre=
rror_r(-524)=3D22                                (trampoline)
--=20
2.30.2

